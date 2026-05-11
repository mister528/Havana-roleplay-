#include "../main.h"
#include "carjackoverlay.h"
#include "fishermanaudio.h"
#include "gui.h"
#include "../vendor/imgui/imgui.h"
#include "../vendor/imgui/imgui_internal.h"
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <cmath>
#include "../arabic.h"

extern CGUI* pGUI;
void CarJack_SendDialogResponse(uint16_t id, uint8_t btn, uint16_t listitem,
                                char* input);

CCarJackOverlay* pCarJackOverlay = nullptr;

#ifndef CJ_PI
#define CJ_PI 3.14159265358979323846f
#endif
#define CJ_TAU (CJ_PI * 2.0f)

static float CjEaseOut(float t) { return 1.0f - (1.0f - t) * (1.0f - t); }
static float CjRand01() { return (float)rand() / (float)RAND_MAX; }

static std::string CjShape(const char* s)
{
    if (!s) return std::string();
    if (!Arabic::ContainsArabic(s)) return std::string(s);
    return Arabic::Shape(s);
}

static void CjText(ImDrawList* dl, ImFont* font, float fs, ImVec2 pos,
                   ImU32 col, const char* text)
{
    std::string shaped = CjShape(text);
    const char* p = shaped.c_str();
    if (!font) { dl->AddText(pos, col, p); return; }
    dl->AddText(font, fs, ImVec2(pos.x + 2.0f, pos.y + 2.0f),
                IM_COL32(0, 0, 0, 180), p);
    dl->AddText(font, fs, pos, col, p);
}

CCarJackOverlay::CCarJackOverlay()
    : m_bVisible(false)
    , m_progressMode(false)
    , m_dialogId(0)
    , m_totalPins(kPins)
    , m_currentPin(0)
    , m_misses(0)
    , m_progStartMs(0)
    , m_progDurationMs(3500)
    , m_flashHit(0.0f)
    , m_flashMiss(0.0f)
    , m_openT(0.0f)
    , m_closeT(0.0f)
    , m_closing(false)
    , m_lastMouseDown(false)
{
    for (int i = 0; i < kPins; ++i)
    {
        m_pinTarget[i] = 0.5f;
        m_pinWindow[i] = 0.12f;
        m_pinSpeed[i] = 0.8f;
        m_pinAngle[i] = 0.0f;
        m_pinDone[i] = false;
        m_pinAccuracy[i] = 0.0f;
    }
}

CCarJackOverlay::~CCarJackOverlay() {}

void CCarJackOverlay::Hide()
{
    m_bVisible = false;
    m_progressMode = false;
    m_closing = false;
    m_openT = 0.0f;
    m_closeT = 0.0f;
}

void CCarJackOverlay::BeginProgress(uint16_t dialogId, int durationMs)
{
    m_bVisible = true;
    m_progressMode = true;
    m_dialogId = dialogId;
    m_progDurationMs = durationMs > 0 ? durationMs : 3500;
    m_progStartMs = (int)(ImGui::GetTime() * 1000.0);
    m_openT = 0.0f;
    m_closeT = 0.0f;
    m_closing = false;
    m_lastMouseDown = false;
}

void CCarJackOverlay::Begin(uint16_t dialogId, int totalPins)
{
    m_bVisible = true;
    m_progressMode = false;
    m_dialogId = dialogId;
    m_totalPins = totalPins > 0 && totalPins <= kPins ? totalPins : kPins;
    m_currentPin = 0;
    m_misses = 0;
    m_flashHit = 0.0f;
    m_flashMiss = 0.0f;
    m_openT = 0.0f;
    m_closeT = 0.0f;
    m_closing = false;
    m_lastMouseDown = false;

    for (int i = 0; i < kPins; ++i)
    {
        m_pinDone[i] = false;
        m_pinAccuracy[i] = 0.0f;
        NewPin(i);
    }
    FishermanAudio::Init();
    FishermanAudio::PlayClick();
}

void CCarJackOverlay::NewPin(int idx)
{
    float t = (float)idx / (float)(kPins - 1);
    m_pinWindow[idx] = 0.070f - 0.020f * t;
    m_pinSpeed[idx] = 0.54f + 0.46f * t;
    m_pinTarget[idx] = CjRand01();
    m_pinAngle[idx] = CjRand01() * CJ_TAU;
}

void CCarJackOverlay::TryPick()
{
    if (m_currentPin >= m_totalPins) return;
    int i = m_currentPin;
    float pos = fmodf(m_pinAngle[i] / CJ_TAU, 1.0f);
    if (pos < 0.0f) pos += 1.0f;
    float dist = fabsf(pos - m_pinTarget[i]);
    if (dist > 0.5f) dist = 1.0f - dist;

    if (dist <= m_pinWindow[i])
    {
        float acc = 1.0f - dist / m_pinWindow[i];
        m_pinAccuracy[i] = acc;
        m_pinDone[i] = true;
        m_flashHit = 1.0f;
        FishermanAudio::PlayCatch();
        m_currentPin++;
        if (m_currentPin >= m_totalPins) FinishSuccess();
    }
    else
    {
        m_misses++;
        m_flashMiss = 1.0f;
        FishermanAudio::PlayMiss();
        if (m_misses >= kMaxMisses)
        {
            char empty[1] = { 0 };
            CarJack_SendDialogResponse(m_dialogId, 0, 0, empty);
            m_closing = true;
        }
        else NewPin(i);
    }
}

void CCarJackOverlay::Cancel()
{
    char empty[1] = { 0 };
    CarJack_SendDialogResponse(m_dialogId, 0, 0, empty);
    m_closing = true;
}

void CCarJackOverlay::FinishSuccess()
{
    float sum = 0.0f;
    for (int i = 0; i < m_totalPins; ++i) sum += m_pinAccuracy[i];
    int score = (int)(100.0f * sum / (float)m_totalPins);
    score += (kMaxMisses - 1 - m_misses) * 3;
    if (score < 0) score = 0;
    if (score > 100) score = 100;
    char buf[16];
    snprintf(buf, sizeof(buf), "%d", score);
    FishermanAudio::PlaySuccess();
    CarJack_SendDialogResponse(m_dialogId, 1, 0, buf);
    m_closing = true;
}

bool CCarJackOverlay::TryHandleDialog(uint16_t dialogId, uint8_t /*style*/,
                                      const char* title, const char* body)
{
    if (!title) return false;
    if (strncmp(title, "[!CARJACK_CLOSE]", 16) == 0)
    {
        Hide();
        return true;
    }
    if (strncmp(title, "[!CARJACK_PROGRESS]", 20) == 0)
    {
        int dur = 3500;
        if (body && body[0])
        {
            int n = atoi(body);
            if (n > 0) dur = n;
        }
        BeginProgress(dialogId, dur);
        return true;
    }
    if (strncmp(title, "[!CARJACK_OPEN]", 15) != 0) return false;

    int total = kPins;
    if (body && body[0])
    {
        int n = atoi(body);
        if (n > 0 && n <= kPins) total = n;
    }
    Begin(dialogId, total);
    return true;
}

void CCarJackOverlay::Render()
{
    if (!m_bVisible) return;
    if (m_progressMode) { RenderProgress(); return; }
    RenderUnlock();
}

void CCarJackOverlay::RenderUnlock()
{
    ImGuiIO& io = ImGui::GetIO();
    if (io.DisplaySize.x <= 0.0f || io.DisplaySize.y <= 0.0f) return;
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    if (!dl) return;

    float scale = io.DisplaySize.y / 1080.0f;
    if (scale < 0.4f) scale = 0.4f;

    if (m_closing)
    {
        m_closeT += io.DeltaTime / 0.25f;
        if (m_closeT >= 1.0f) { Hide(); return; }
    }
    else
    {
        m_openT += io.DeltaTime / 0.25f;
        if (m_openT > 1.0f) m_openT = 1.0f;
    }

    float ease = m_closing ? (1.0f - m_closeT) : CjEaseOut(m_openT);
    int alpha = (int)(255 * ease);
    if (m_flashHit > 0.0f) { m_flashHit -= io.DeltaTime / 0.35f; if (m_flashHit < 0.0f) m_flashHit = 0.0f; }
    if (m_flashMiss > 0.0f) { m_flashMiss -= io.DeltaTime / 0.35f; if (m_flashMiss < 0.0f) m_flashMiss = 0.0f; }

    for (int i = 0; i < m_totalPins; ++i)
        if (!m_pinDone[i]) m_pinAngle[i] += io.DeltaTime * m_pinSpeed[i] * CJ_TAU;

    ImFont* font = pGUI ? pGUI->GetFont() : nullptr;
    dl->AddRectFilled(ImVec2(0, 0), io.DisplaySize, IM_COL32(0, 0, 0, (int)(225 * ease)));

    float cardW = io.DisplaySize.x * 0.58f;
    if (cardW < 640.0f * scale) cardW = 640.0f * scale;
    if (cardW > 980.0f * scale) cardW = 980.0f * scale;
    float cardH = io.DisplaySize.y * 0.76f;
    if (cardH < 720.0f * scale) cardH = 720.0f * scale;
    float cx = io.DisplaySize.x * 0.5f;
    float cy = io.DisplaySize.y * 0.5f;
    ImVec2 cMin(cx - cardW * 0.5f, cy - cardH * 0.5f);
    ImVec2 cMax(cx + cardW * 0.5f, cy + cardH * 0.5f);

    for (int s = 0; s < 9; ++s)
    {
        float o = (s + 1) * 4.0f * scale;
        dl->AddRectFilled(ImVec2(cMin.x - o, cMin.y - o + 10.0f * scale),
                          ImVec2(cMax.x + o, cMax.y + o + 10.0f * scale),
                          IM_COL32(0, 0, 0, 18 - s * 2),
                          28.0f * scale + o);
    }

    dl->AddRectFilledMultiColor(cMin, cMax,
        IM_COL32(18, 24, 32, alpha), IM_COL32(20, 28, 38, alpha),
        IM_COL32(6, 10, 16, alpha), IM_COL32(7, 10, 15, alpha));
    dl->AddRect(cMin, cMax, IM_COL32(80, 230, 150, (int)(190 * ease)),
                28.0f * scale, 0, 2.2f * scale);

    if (font)
    {
        std::string titleS = CjShape("سرقة السيارة");
        std::string subS = CjShape("اضغط وسط الدائرة عندما يصل السهم للمنطقة الخضراء");
        const char* title = titleS.c_str();
        const char* sub = subS.c_str();
        float fsT = 50.0f * scale;
        float fsS = 27.0f * scale;
        ImVec2 ts = font->CalcTextSizeA(fsT, FLT_MAX, 0.0f, title);
        ImVec2 ss = font->CalcTextSizeA(fsS, FLT_MAX, 0.0f, sub);
        CjText(dl, font, fsT, ImVec2(cx - ts.x * 0.5f, cMin.y + 30.0f * scale),
               IM_COL32(235, 255, 245, alpha), title);
        CjText(dl, font, fsS, ImVec2(cx - ss.x * 0.5f, cMin.y + 86.0f * scale),
               IM_COL32(170, 230, 200, alpha), sub);
    }

    bool mDown = ImGui::IsMouseDown(0);
    bool press = mDown && !m_lastMouseDown;

    float r = cardH * 0.255f;
    float ringCx = cx;
    float ringCy = cMin.y + 365.0f * scale;
    float target = m_currentPin < m_totalPins ? m_pinTarget[m_currentPin] * CJ_TAU : 0.0f;
    float half = m_currentPin < m_totalPins ? m_pinWindow[m_currentPin] * CJ_TAU : 0.0f;
    float segA = target - half;
    float segB = target + half;

    for (int s = 0; s < 7; ++s)
        dl->AddCircle(ImVec2(ringCx, ringCy), r + s * 3.0f * scale,
                      IM_COL32(40, 255, 150, (int)((55 - s * 7) * ease)), 96, 2.0f * scale);

    dl->AddCircleFilled(ImVec2(ringCx, ringCy), r + 35.0f * scale,
                        IM_COL32(4, 12, 15, (int)(145 * ease)), 96);
    dl->AddCircle(ImVec2(ringCx, ringCy), r, IM_COL32(75, 95, 105, (int)(210 * ease)), 128, 13.0f * scale);
    dl->PathClear();
    dl->PathArcTo(ImVec2(ringCx, ringCy), r, segA, segB, 36);
    dl->PathStroke(IM_COL32(45, 255, 145, alpha), false, 15.0f * scale);
    dl->PathClear();
    dl->PathArcTo(ImVec2(ringCx, ringCy), r, segA, segB, 36);
    dl->PathStroke(IM_COL32(210, 255, 230, (int)(190 * ease)), false, 3.0f * scale);

    float angle = m_currentPin < m_totalPins ? m_pinAngle[m_currentPin] : 0.0f;
    ImVec2 tip(ringCx + cosf(angle) * (r - 18.0f * scale),
               ringCy + sinf(angle) * (r - 18.0f * scale));
    ImVec2 left(ringCx + cosf(angle + 2.55f) * 42.0f * scale,
                ringCy + sinf(angle + 2.55f) * 42.0f * scale);
    ImVec2 right(ringCx + cosf(angle - 2.55f) * 42.0f * scale,
                 ringCy + sinf(angle - 2.55f) * 42.0f * scale);
    dl->AddTriangleFilled(tip, left, right, IM_COL32(255, 235, 125, alpha));
    dl->AddTriangle(tip, left, right, IM_COL32(255, 255, 245, alpha), 2.5f * scale);

    float centerR = 92.0f * scale;
    bool pHov = (io.MousePos.x - ringCx) * (io.MousePos.x - ringCx) +
                (io.MousePos.y - ringCy) * (io.MousePos.y - ringCy) <= centerR * centerR;
    dl->AddCircleFilled(ImVec2(ringCx, ringCy), centerR,
                        pHov ? IM_COL32(65, 245, 155, alpha) : IM_COL32(24, 115, 82, alpha), 64);
    dl->AddCircle(ImVec2(ringCx, ringCy), centerR, IM_COL32(215, 255, 235, alpha), 64, 3.0f * scale);

    if (font)
    {
        std::string pressSh = CjShape("اضغط");
        const char* pressTxt = pressSh.c_str();
        float fsPress = 41.0f * scale;
        ImVec2 ps = font->CalcTextSizeA(fsPress, FLT_MAX, 0.0f, pressTxt);
        CjText(dl, font, fsPress,
               ImVec2(ringCx - ps.x * 0.5f, ringCy - fsPress * 0.52f),
               IM_COL32(5, 35, 25, alpha), pressTxt);
    }

    float dotY = cMin.y + 620.0f * scale;
    float dotGap = 46.0f * scale;
    float dotsW = (m_totalPins - 1) * dotGap;
    for (int i = 0; i < m_totalPins; ++i)
    {
        float dx = cx - dotsW * 0.5f + i * dotGap;
        ImU32 col = m_pinDone[i] ? IM_COL32(55, 245, 140, alpha)
                    : (i == m_currentPin ? IM_COL32(255, 220, 90, alpha)
                                         : IM_COL32(70, 95, 90, (int)(190 * ease)));
        dl->AddCircleFilled(ImVec2(dx, dotY), 14.0f * scale, col, 24);
    }

    float cancelW = cardW * 0.25f;
    float btnH = 66.0f * scale;
    ImVec2 caMin(cx - cancelW * 0.5f, cMax.y - btnH - 28.0f * scale);
    ImVec2 caMax(caMin.x + cancelW, caMin.y + btnH);
    bool cHov = io.MousePos.x >= caMin.x && io.MousePos.x <= caMax.x && io.MousePos.y >= caMin.y && io.MousePos.y <= caMax.y;
    dl->AddRectFilledMultiColor(caMin, caMax,
        cHov ? IM_COL32(120, 55, 65, alpha) : IM_COL32(80, 34, 45, alpha),
        cHov ? IM_COL32(120, 55, 65, alpha) : IM_COL32(80, 34, 45, alpha),
        cHov ? IM_COL32(65, 20, 28, alpha) : IM_COL32(45, 15, 22, alpha),
        cHov ? IM_COL32(65, 20, 28, alpha) : IM_COL32(45, 15, 22, alpha));
    dl->AddRect(caMin, caMax, IM_COL32(255, 205, 210, (int)(170 * ease)),
                18.0f * scale, 0, 1.8f * scale);

    if (font)
    {
        std::string cancelSh = CjShape("إلغاء");
        const char* cancel = cancelSh.c_str();
        float fsC = 36.0f * scale;
        ImVec2 cs = font->CalcTextSizeA(fsC, FLT_MAX, 0.0f, cancel);
        CjText(dl, font, fsC, ImVec2((caMin.x + caMax.x - cs.x) * 0.5f, (caMin.y + caMax.y) * 0.5f - fsC * 0.55f),
               IM_COL32(255, 235, 235, alpha), cancel);
    }

    if (press)
    {
        if (pHov) TryPick();
        else if (cHov) Cancel();
    }

    if (m_flashHit > 0.0f)
        dl->AddRectFilled(ImVec2(0, 0), io.DisplaySize, IM_COL32(40, 210, 120, (int)(55 * m_flashHit * ease)));
    if (m_flashMiss > 0.0f)
        dl->AddRectFilled(ImVec2(0, 0), io.DisplaySize, IM_COL32(235, 65, 70, (int)(65 * m_flashMiss * ease)));

    m_lastMouseDown = mDown;
}

void CCarJackOverlay::RenderProgress()
{
    ImGuiIO& io = ImGui::GetIO();
    if (io.DisplaySize.x <= 0.0f || io.DisplaySize.y <= 0.0f) return;
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    if (!dl) return;

    float scale = io.DisplaySize.y / 1080.0f;
    if (scale < 0.4f) scale = 0.4f;

    int now = (int)(ImGui::GetTime() * 1000.0);
    int elapsed = now - m_progStartMs;
    if (elapsed < 0) elapsed = 0;
    if (elapsed > m_progDurationMs) elapsed = m_progDurationMs;
    float t = m_progDurationMs > 0 ? (float)elapsed / (float)m_progDurationMs : 1.0f;
    if (t > 1.0f) t = 1.0f;
    if (t >= 1.0f)
    {
        Hide();
        return;
    }

    ImFont* font = pGUI ? pGUI->GetFont() : nullptr;
    float panelW = io.DisplaySize.x * 0.44f;
    float panelH = 102.0f * scale;
    float panelX = (io.DisplaySize.x - panelW) * 0.5f;
    float panelY = io.DisplaySize.y - panelH - 38.0f * scale;
    ImVec2 pMin(panelX, panelY);
    ImVec2 pMax(panelX + panelW, panelY + panelH);

    dl->AddRectFilled(pMin, pMax, IM_COL32(4, 12, 18, 150), 13.0f * scale);
    dl->AddRect(pMin, pMax, IM_COL32(80, 210, 255, 210), 13.0f * scale, 0, 1.6f * scale);

    if (font)
    {
        std::string lockTitleSh = CjShape("جاري فتح قفل السيارة");
        const char* title = lockTitleSh.c_str();
        float fs = 30.0f * scale;
        ImVec2 ts = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, title);
        CjText(dl, font, fs, ImVec2(panelX + (panelW - ts.x) * 0.5f, panelY + 14.0f * scale),
               IM_COL32(210, 245, 255, 245), title);
    }

    float pad = 24.0f * scale;
    float barH = 8.0f * scale;
    ImVec2 bMin(panelX + pad, panelY + panelH - 28.0f * scale);
    ImVec2 bMax(panelX + panelW - pad, bMin.y + barH);
    dl->AddRectFilled(bMin, bMax, IM_COL32(30, 55, 70, 210), 8.0f * scale);
    dl->AddRectFilled(bMin, ImVec2(bMin.x + (bMax.x - bMin.x) * t, bMax.y),
                      IM_COL32(90, 220, 255, 255), 8.0f * scale);
}
