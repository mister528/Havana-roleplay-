#include "../main.h"
#include "robberyoverlay.h"
#include "robberytex.h"
#include "fishermanaudio.h"
#include "gui.h"
#include "../arabic.h"
#include "../vendor/imgui/imgui.h"
#include "../vendor/imgui/imgui_internal.h"
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <cmath>
#include <string>

class CNetGame;
extern CNetGame* pNetGame;

// Bridge implemented in net/netrpc.cpp.
void Robbery_SendDialogResponse(uint16_t id, uint8_t btn, uint16_t listitem,
                                char* input);

CRobberyOverlay* pRobberyOverlay = nullptr;
extern CGUI* pGUI;

#ifndef RB_PI
#define RB_PI 3.14159265358979323846f
#endif
#define RB_TAU (RB_PI * 2.0f)

// ---- Palette --------------------------------------------------------------
static const ImU32 kColBgDim     = IM_COL32(  0,   0,   0, 215);
static const ImU32 kColCardA     = IM_COL32( 24,  18,  44, 255);
static const ImU32 kColCardB     = IM_COL32( 12,   8,  22, 255);
static const ImU32 kColAccent    = IM_COL32(255, 195,  60, 255);
static const ImU32 kColAccentDim = IM_COL32(255, 195,  60, 110);
static const ImU32 kColTrack     = IM_COL32( 28,  22,  48, 255);
static const ImU32 kColTrackEdge = IM_COL32(140, 110, 200, 200);
static const ImU32 kColSweet     = IM_COL32(110, 230, 130, 255);
static const ImU32 kColSweetEdge = IM_COL32(140, 255, 160, 255);
static const ImU32 kColInd       = IM_COL32(255, 240, 180, 255);
static const ImU32 kColIndShadow = IM_COL32(255, 200,  80, 220);
static const ImU32 kColLocked    = IM_COL32( 80, 220, 100, 255);
static const ImU32 kColMiss      = IM_COL32(240,  80,  80, 255);
static const ImU32 kColText      = IM_COL32(255, 255, 255, 255);
static const ImU32 kColTextMuted = IM_COL32(200, 195, 220, 255);

// ---- Helpers --------------------------------------------------------------
static float EaseOutQuad(float t) { return 1.0f - (1.0f - t) * (1.0f - t); }
static float frand01() { return (float)rand() / (float)RAND_MAX; }

static std::string RobberyShapeText(const char* s)
{
    if (!s) return std::string();
    if (!Arabic::ContainsArabic(s)) return std::string(s);
    return Arabic::Shape(s);
}

static ImVec2 RobberyCalcTextSize(ImFont* font, float size, const std::string& text)
{
    if (!font) return ImGui::CalcTextSize(text.c_str());
    return font->CalcTextSizeA(size, FLT_MAX, 0.0f, text.c_str());
}

static void DrawShadowedText(ImDrawList* dl, ImFont* font, float fs,
                             ImVec2 pos, ImU32 col, const char* text)
{
    std::string shaped = RobberyShapeText(text);
    const char* s = shaped.c_str();
    if (!font) { dl->AddText(pos, col, s); return; }
    dl->AddText(font, fs, ImVec2(pos.x + 2.0f, pos.y + 2.0f),
                IM_COL32(0, 0, 0, 180), s);
    dl->AddText(font, fs, pos, col, s);
}

// ---- Class implementation -------------------------------------------------
CRobberyOverlay::CRobberyOverlay()
    : m_bVisible(false)
    , m_progressMode(false)
    , m_dialogId(0)
    , m_totalPins(kPins)
    , m_currentPin(0)
    , m_misses(0)
    , m_progStartMs(0)
    , m_progDurationMs(6000)
    , m_flashHit(0.0f)
    , m_flashMiss(0.0f)
    , m_openT(0.0f)
    , m_closeT(0.0f)
    , m_closing(false)
    , m_lastMouseDown(false)
    , m_pressedColumn(-1)
{
    for (int i = 0; i < kPins; ++i)
    {
        m_pinTarget[i]   = 0.5f;
        m_pinHalfArc[i]  = 0.14f;
        m_pinSpeed[i]    = 1.0f;
        m_pinPhase[i]    = 0.0f;
        m_pinLocked[i]   = false;
        m_pinAccuracy[i] = 0.0f;
    }
}

CRobberyOverlay::~CRobberyOverlay() {}

void CRobberyOverlay::Hide()
{
    m_bVisible = false;
    m_progressMode = false;
    m_closing = false;
    m_openT   = 0.0f;
    m_closeT  = 0.0f;
}

void CRobberyOverlay::BeginProgress(uint16_t dialogId, int durationMs)
{
    m_bVisible       = true;
    m_progressMode   = true;
    m_dialogId       = dialogId;
    m_progDurationMs = durationMs > 0 ? durationMs : 6000;
    m_progStartMs    = (int)(ImGui::GetTime() * 1000.0);
    m_openT          = 0.0f;
    m_closeT         = 0.0f;
    m_closing        = false;
}

void CRobberyOverlay::Begin(uint16_t dialogId, int totalPins)
{
    m_bVisible    = true;
    m_progressMode = false;
    m_dialogId    = dialogId;
    m_totalPins   = totalPins > 0 && totalPins <= kPins ? totalPins : kPins;
    m_currentPin  = 0;
    m_misses      = 0;
    m_flashHit    = 0.0f;
    m_flashMiss   = 0.0f;
    m_openT       = 0.0f;
    m_closeT      = 0.0f;
    m_closing     = false;
    m_lastMouseDown = false;
    m_pressedColumn = -1;

    for (int i = 0; i < kPins; ++i)
    {
        m_pinLocked[i]   = false;
        m_pinAccuracy[i] = 0.0f;
        NewPin(i);
    }
    FishermanAudio::Init();
    FishermanAudio::PlayClick();
}

void CRobberyOverlay::NewPin(int idx)
{
    // Difficulty scales gently across the 5 pins; even the hard pins are forgiving.
    float t = (float)idx / (float)(kPins - 1);     // 0..1
    // Sweet zone stays wide: ~32% down to ~22% of channel height.
    m_pinHalfArc[idx] = 0.160f - 0.050f * t;        // half-height
    // Calm pace: 0.7 cycles/sec on pin 1, 1.05 on pin 5.
    m_pinSpeed  [idx] = 0.70f + 0.35f * t;          // cycles per second
    m_pinPhase  [idx] = frand01() * RB_TAU;
    // Sweet center kept away from the very top/bottom 15% of the channel.
    m_pinTarget [idx] = 0.18f + frand01() * 0.64f;
}

void CRobberyOverlay::TryPick()
{
    if (m_currentPin >= m_totalPins) return;
    int i = m_currentPin;

    // Indicator y in 0..1 (0 = top, 1 = bottom).  We use a sin wave that
    // bounces between 0 and 1 over the channel height.
    float y = 0.5f + 0.5f * sinf(m_pinPhase[i]);
    float dist = fabsf(y - m_pinTarget[i]);

    if (dist <= m_pinHalfArc[i])
    {
        // Accuracy 1.0 at center, 0.0 at edge of sweet zone.
        float acc = 1.0f - dist / m_pinHalfArc[i];
        m_pinAccuracy[i] = acc;
        m_pinLocked[i] = true;
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
            FishermanAudio::PlayMiss();
            char empty[1] = { 0 };
            Robbery_SendDialogResponse(m_dialogId, 0, 0, empty);
            m_closing = true;
        }
        else
        {
            // Reshuffle pin to a fresh sweet spot to keep things lively.
            NewPin(i);
        }
    }
}

void CRobberyOverlay::Cancel()
{
    char empty[1] = { 0 };
    Robbery_SendDialogResponse(m_dialogId, 0, 0, empty);
    m_closing = true;
}

void CRobberyOverlay::FinishSuccess()
{
    // Score = average pin accuracy (0..1) scaled to 0..100.
    float sum = 0.0f;
    for (int i = 0; i < m_totalPins; ++i) sum += m_pinAccuracy[i];
    int score = (int)(100.0f * sum / (float)m_totalPins);
    // Bonus for fewer misses: each miss saved adds 2 points (capped 100).
    score += (kMaxMisses - 1 - m_misses) * 2;
    if (score < 0)   score = 0;
    if (score > 100) score = 100;

    char buf[16];
    snprintf(buf, sizeof(buf), "%d", score);
    FishermanAudio::PlaySuccess();
    Robbery_SendDialogResponse(m_dialogId, 1, 0, buf);
    m_closing = true;
}

bool CRobberyOverlay::TryHandleDialog(uint16_t dialogId, uint8_t /*style*/,
                                      const char* title, const char* body)
{
    if (!title) return false;
    if (strncmp(title, "[!ROB247_CLOSE]", 15) == 0)
    {
        Hide();
        return true;
    }
    if (strncmp(title, "[!ROB247_PROGRESS]", 18) == 0)
    {
        int dur = 6000;
        if (body && body[0])
        {
            int n = atoi(body);
            if (n > 0) dur = n;
        }
        BeginProgress(dialogId, dur);
        return true;
    }
    if (strncmp(title, "[!ROB247_OPEN]", 14) != 0) return false;

    int total = kPins;
    if (body && body[0])
    {
        int n = atoi(body);
        if (n > 0 && n <= kPins) total = n;
    }
    Begin(dialogId, total);
    return true;
}

void CRobberyOverlay::Render()
{
    if (!m_bVisible) return;
    if (m_progressMode) { RenderProgress(); return; }
    RenderLockpick();
}

void CRobberyOverlay::RenderLockpick()
{
    ImGuiIO& io = ImGui::GetIO();
    if (io.DisplaySize.x <= 0.0f || io.DisplaySize.y <= 0.0f) return;

    ImDrawList* dl = ImGui::GetOverlayDrawList();
    if (!dl) return;

    float scale = io.DisplaySize.y / 1080.0f;
    if (scale < 0.4f) scale = 0.4f;

    // Open / close animation
    if (m_closing)
    {
        m_closeT += io.DeltaTime / 0.30f;
        if (m_closeT >= 1.0f) { Hide(); return; }
    }
    else
    {
        m_openT += io.DeltaTime / 0.30f;
        if (m_openT > 1.0f) m_openT = 1.0f;
    }

    float ease   = m_closing ? (1.0f - m_closeT) : EaseOutQuad(m_openT);
    int   alpha8 = (int)(255 * ease);

    // Decay flashes
    if (m_flashHit  > 0.0f) { m_flashHit  -= io.DeltaTime / 0.40f; if (m_flashHit  < 0.0f) m_flashHit  = 0.0f; }
    if (m_flashMiss > 0.0f) { m_flashMiss -= io.DeltaTime / 0.40f; if (m_flashMiss < 0.0f) m_flashMiss = 0.0f; }

    // Advance indicator phases for un-locked pins.
    for (int i = 0; i < m_totalPins; ++i)
    {
        if (!m_pinLocked[i])
            m_pinPhase[i] += io.DeltaTime * m_pinSpeed[i] * RB_TAU;
    }

    ImFont* font = pGUI ? pGUI->GetFont() : nullptr;

    // -------- Backdrop ----------------------------------------------------
    // Fully opaque while open so the moving world / HUD behind us is hidden.
    dl->AddRectFilled(ImVec2(0, 0), io.DisplaySize,
                      IM_COL32(0, 0, 0, (int)(255 * ease)));

    // -------- Card --------------------------------------------------------
    float cardW = io.DisplaySize.x * 0.68f;
    if (cardW < 720.0f * scale) cardW = 720.0f * scale;
    if (cardW > 1400.0f * scale) cardW = 1400.0f * scale;
    float cardH = io.DisplaySize.y * 0.78f;
    float cx = io.DisplaySize.x * 0.5f;
    float cy = io.DisplaySize.y * 0.5f;
    ImVec2 cMin(cx - cardW * 0.5f, cy - cardH * 0.5f);
    ImVec2 cMax(cx + cardW * 0.5f, cy + cardH * 0.5f);

    // soft drop shadow
    for (int s = 0; s < 12; ++s)
    {
        float o = (s + 1) * 4.0f * scale;
        int   a = 18 - s; if (a < 0) a = 0;
        dl->AddRectFilled(ImVec2(cMin.x - o, cMin.y - o + 12),
                          ImVec2(cMax.x + o, cMax.y + o + 12),
                          IM_COL32(0, 0, 0, (int)(a * ease)),
                          26.0f * scale + o);
    }
    // body gradient (base, in case the texture is unavailable)
    dl->AddRectFilledMultiColor(cMin, cMax,
        kColCardA, kColCardA, kColCardB, kColCardB);

    // vault background image
    {
        void* tex = nullptr; int tw = 0, th = 0; float tu = 1.0f, tv = 1.0f;
        if (RobberyTex::GetVault(&tex, &tw, &th, &tu, &tv) && tex)
        {
            // Cover the entire card while preserving aspect; let the image
            // be lightly tinted so the gold/dark mood reads through the rest.
            ImU32 tint = IM_COL32(255, 240, 215, alpha8);
            dl->AddImage((ImTextureID)tex, cMin, cMax,
                         ImVec2(0.0f, 0.0f), ImVec2(tu, tv), tint);
            // Vignette + bottom darken to make text & pins readable.
            dl->AddRectFilledMultiColor(cMin, cMax,
                IM_COL32(0, 0, 0, (int)( 70 * ease)),
                IM_COL32(0, 0, 0, (int)( 70 * ease)),
                IM_COL32(0, 0, 0, (int)(170 * ease)),
                IM_COL32(0, 0, 0, (int)(170 * ease)));
        }
    }

    // double gold border
    dl->AddRect(cMin, cMax, IM_COL32(255, 195, 60, (int)(220 * ease)),
                26.0f * scale, 0, 2.5f * scale);
    dl->AddRect(ImVec2(cMin.x + 6 * scale, cMin.y + 6 * scale),
                ImVec2(cMax.x - 6 * scale, cMax.y - 6 * scale),
                IM_COL32(255, 255, 255, (int)(40 * ease)),
                22.0f * scale, 0, 1.0f * scale);

    // -------- Header banner ----------------------------------------------
    float bannerH = 160.0f * scale;
    {
        ImVec2 hMin(cMin.x + 6 * scale, cMin.y + 6 * scale);
        ImVec2 hMax(cMax.x - 6 * scale, cMin.y + bannerH);
        // Translucent dark band so the vault image shows through.
        int hAlpha = (int)(180 * ease);
        dl->AddRectFilledMultiColor(hMin, hMax,
            IM_COL32( 30,  20,  10, hAlpha), IM_COL32( 22,  16,   6, hAlpha),
            IM_COL32(  8,   5,   2, hAlpha), IM_COL32( 14,  10,   4, hAlpha));
        dl->AddRectFilledMultiColor(
            ImVec2(hMin.x, hMin.y),
            ImVec2(hMax.x, hMin.y + bannerH * 0.55f),
            IM_COL32(255, 220, 140, (int)(40 * ease)), IM_COL32(255, 220, 140, (int)(40 * ease)),
            IM_COL32(255, 255, 255,  0),                IM_COL32(255, 255, 255,  0));
        // bottom accent line
        dl->AddRectFilledMultiColor(
            ImVec2(hMin.x, hMax.y - 4 * scale),
            ImVec2(hMax.x, hMax.y),
            IM_COL32(255, 195,  60, alpha8), IM_COL32(255, 120,  40, alpha8),
            IM_COL32(255, 120,  40, alpha8), IM_COL32(255, 195,  60, alpha8));

        // Title + subtitle
        if (font)
        {
            const char* title = "سرقة الخزنة - 24/7";
            float fsT = 64.0f * scale;
            ImVec2 ts = font->CalcTextSizeA(fsT, FLT_MAX, 0.0f, title);
            DrawShadowedText(dl, font, fsT,
                ImVec2(cx - ts.x * 0.5f, cMin.y + 30 * scale),
                IM_COL32(255, 240, 200, alpha8), title);

            const char* sub = "اضغط الدبوس داخل المنطقة الذهبية";
            float fsS = 34.0f * scale;
            ImVec2 ss = font->CalcTextSizeA(fsS, FLT_MAX, 0.0f, sub);
            DrawShadowedText(dl, font, fsS,
                ImVec2(cx - ss.x * 0.5f, cMin.y + 30 * scale + fsT + 6 * scale),
                IM_COL32(255, 220, 200, (int)(220 * ease)), sub);
        }
    }

    // -------- Status bar (lives + pin counter) ---------------------------
    float statusY = cMin.y + bannerH + 14 * scale;
    {
        // Hearts on the left (misses left). Compact when many misses allowed.
        int livesLeft = kMaxMisses - m_misses;
        if (livesLeft < 0) livesLeft = 0;
        float hStep = (kMaxMisses > 6) ? 30.0f : 44.0f;
        float hR    = (kMaxMisses > 6) ? 10.0f : 14.0f;
        for (int i = 0; i < kMaxMisses; ++i)
        {
            float hx = cMin.x + 32 * scale + i * hStep * scale;
            float hy = statusY + 22 * scale;
            float r  = hR * scale;
            ImU32 col = (i < livesLeft) ? IM_COL32(240, 70, 90, alpha8)
                                        : IM_COL32(60, 50, 70, (int)(180 * ease));
            dl->AddCircleFilled(ImVec2(hx - r * 0.5f, hy), r * 0.6f, col, 16);
            dl->AddCircleFilled(ImVec2(hx + r * 0.5f, hy), r * 0.6f, col, 16);
            dl->AddTriangleFilled(
                ImVec2(hx - r,         hy + r * 0.20f),
                ImVec2(hx + r,         hy + r * 0.20f),
                ImVec2(hx,             hy + r * 1.20f),
                col);
        }

        if (font)
        {
            char buf[64];
            snprintf(buf, sizeof(buf), "%d / %d", m_currentPin, m_totalPins);
            float fs = 36.0f * scale;
            ImVec2 sz = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, buf);
            DrawShadowedText(dl, font, fs,
                ImVec2(cMax.x - 36 * scale - sz.x, statusY + 12 * scale),
                IM_COL32(255, 230, 160, alpha8), buf);
        }
    }

    // -------- Pin channels ------------------------------------------------
    float padX = 60 * scale;
    float padY = bannerH + 110 * scale;
    float botPad = 220 * scale;
    float channelsTop  = cMin.y + padY;
    float channelsBot  = cMax.y - botPad;
    float channelsArea = channelsBot - channelsTop;
    float colTotalW    = (cardW - padX * 2);
    float colW         = colTotalW / (float)m_totalPins;

    // Detect press/release on each column
    bool mDown = io.MouseDown[0];
    bool press = mDown && !m_lastMouseDown;
    int  pressedColumn = -1;
    if (press)
    {
        if (io.MousePos.x >= cMin.x + padX &&
            io.MousePos.x <= cMin.x + padX + colTotalW &&
            io.MousePos.y >= channelsTop &&
            io.MousePos.y <= channelsBot)
        {
            pressedColumn = (int)((io.MousePos.x - (cMin.x + padX)) / colW);
        }
    }

    for (int i = 0; i < m_totalPins; ++i)
    {
        float x0 = cMin.x + padX + i * colW + 14 * scale;
        float x1 = cMin.x + padX + (i + 1) * colW - 14 * scale;
        float midX = 0.5f * (x0 + x1);

        // Track shadow + base
        dl->AddRectFilled(
            ImVec2(x0 + 3 * scale, channelsTop + 6 * scale),
            ImVec2(x1 + 3 * scale, channelsBot + 6 * scale),
            IM_COL32(0, 0, 0, (int)(140 * ease)),
            14.0f * scale);
        dl->AddRectFilled(
            ImVec2(x0, channelsTop),
            ImVec2(x1, channelsBot),
            kColTrack, 14.0f * scale);
        dl->AddRect(
            ImVec2(x0, channelsTop),
            ImVec2(x1, channelsBot),
            kColTrackEdge, 14.0f * scale, 0, 1.5f * scale);

        // Tick marks every 10% along the channel
        for (int t = 1; t < 10; ++t)
        {
            float ty = channelsTop + (channelsArea * t / 10.0f);
            dl->AddLine(ImVec2(x0 + 4 * scale, ty),
                        ImVec2(x0 + 14 * scale, ty),
                        IM_COL32(170, 150, 220, (int)(150 * ease)),
                        1.4f * scale);
            dl->AddLine(ImVec2(x1 - 14 * scale, ty),
                        ImVec2(x1 -  4 * scale, ty),
                        IM_COL32(170, 150, 220, (int)(150 * ease)),
                        1.4f * scale);
        }

        if (m_pinLocked[i])
        {
            // Locked: draw a green checkmark medallion at sweet zone.
            float yc = channelsTop + channelsArea * m_pinTarget[i];
            float top    = yc - channelsArea * m_pinHalfArc[i];
            float bottom = yc + channelsArea * m_pinHalfArc[i];
            dl->AddRectFilled(
                ImVec2(x0 + 4 * scale, top),
                ImVec2(x1 - 4 * scale, bottom),
                IM_COL32(40, 180, 90, alpha8),
                10.0f * scale);
            dl->AddRect(
                ImVec2(x0 + 4 * scale, top),
                ImVec2(x1 - 4 * scale, bottom),
                IM_COL32(120, 255, 160, alpha8),
                10.0f * scale, 0, 1.4f * scale);
            // checkmark
            float cy2 = (top + bottom) * 0.5f;
            float r   = (bottom - top) * 0.34f;
            ImVec2 a(midX - r, cy2);
            ImVec2 b(midX - r * 0.20f, cy2 + r * 0.55f);
            ImVec2 c(midX + r, cy2 - r * 0.55f);
            dl->AddLine(a, b, IM_COL32(255, 255, 255, alpha8), 4.0f * scale);
            dl->AddLine(b, c, IM_COL32(255, 255, 255, alpha8), 4.0f * scale);
            // pin number badge
            if (font)
            {
                char buf[8];
                snprintf(buf, sizeof(buf), "%d", i + 1);
                float fs = 28.0f * scale;
                ImVec2 sz = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, buf);
                DrawShadowedText(dl, font, fs,
                    ImVec2(midX - sz.x * 0.5f, channelsBot + 8 * scale),
                    kColLocked, buf);
            }
            continue;
        }

        // Sweet zone
        float yc = channelsTop + channelsArea * m_pinTarget[i];
        float ya = yc - channelsArea * m_pinHalfArc[i];
        float yb = yc + channelsArea * m_pinHalfArc[i];
        dl->AddRectFilled(
            ImVec2(x0 + 4 * scale, ya),
            ImVec2(x1 - 4 * scale, yb),
            IM_COL32(255, 195, 60, (int)(120 * ease)),
            10.0f * scale);
        dl->AddRect(
            ImVec2(x0 + 4 * scale, ya),
            ImVec2(x1 - 4 * scale, yb),
            kColSweetEdge, 10.0f * scale, 0, 1.6f * scale);

        // Indicator
        float yNorm = 0.5f + 0.5f * sinf(m_pinPhase[i]);
        float iy = channelsTop + channelsArea * yNorm;
        float ih = 20 * scale;
        // glow
        dl->AddRectFilled(
            ImVec2(x0 - 6 * scale, iy - ih * 0.5f - 4 * scale),
            ImVec2(x1 + 6 * scale, iy + ih * 0.5f + 4 * scale),
            IM_COL32(255, 220, 120, (int)(80 * ease)),
            12.0f * scale);
        dl->AddRectFilled(
            ImVec2(x0 + 4 * scale, iy - ih * 0.5f),
            ImVec2(x1 - 4 * scale, iy + ih * 0.5f),
            kColInd, 8.0f * scale);
        dl->AddRect(
            ImVec2(x0 + 4 * scale, iy - ih * 0.5f),
            ImVec2(x1 - 4 * scale, iy + ih * 0.5f),
            kColIndShadow, 8.0f * scale, 0, 1.4f * scale);

        // Pin number under the channel
        if (font)
        {
            char buf[8];
            snprintf(buf, sizeof(buf), "%d", i + 1);
            float fs = 28.0f * scale;
            ImVec2 sz = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, buf);
            ImU32 col = (i == m_currentPin) ? kColAccent : kColTextMuted;
            DrawShadowedText(dl, font, fs,
                ImVec2(midX - sz.x * 0.5f, channelsBot + 8 * scale),
                (col & 0x00FFFFFF) | ((unsigned)alpha8 << 24), buf);
        }

        // Press handling: if column tap == current pin, attempt pick.
        if (pressedColumn == i)
        {
            if (i == m_currentPin) TryPick();
            // Tapping a non-current pin does nothing harmful (visual only).
        }
    }

    // -------- PICK + CANCEL buttons --------------------------------------
    {
        float btnH = 110 * scale;
        float btnGap = 28 * scale;
        float btnY = cMax.y - btnH - 36 * scale;

        // PICK (large, gold)
        float pickW = (cardW - padX * 2) * 0.62f;
        ImVec2 pMin(cx - pickW * 0.5f - btnGap * 0.5f - (cardW - padX * 2) * 0.18f, btnY);
        ImVec2 pMax(pMin.x + pickW, btnY + btnH);
        bool pHov = (io.MousePos.x >= pMin.x && io.MousePos.x <= pMax.x &&
                     io.MousePos.y >= pMin.y && io.MousePos.y <= pMax.y);
        // shadow
        dl->AddRectFilled(
            ImVec2(pMin.x + 3 * scale, pMin.y + 8 * scale),
            ImVec2(pMax.x + 3 * scale, pMax.y + 8 * scale),
            IM_COL32(0, 0, 0, (int)(150 * ease)),
            22.0f * scale);
        dl->AddRectFilledMultiColor(pMin, pMax,
            pHov ? IM_COL32(255, 230, 130, alpha8) : IM_COL32(255, 200, 80, alpha8),
            pHov ? IM_COL32(255, 230, 130, alpha8) : IM_COL32(255, 200, 80, alpha8),
            pHov ? IM_COL32(220, 150, 30, alpha8)  : IM_COL32(180, 120, 20, alpha8),
            pHov ? IM_COL32(220, 150, 30, alpha8)  : IM_COL32(180, 120, 20, alpha8));
        dl->AddRectFilledMultiColor(
            ImVec2(pMin.x + 8 * scale, pMin.y + 6 * scale),
            ImVec2(pMax.x - 8 * scale, pMin.y + btnH * 0.45f),
            IM_COL32(255, 255, 255, (int)(120 * ease)), IM_COL32(255, 255, 255, (int)(120 * ease)),
            IM_COL32(255, 255, 255, 0), IM_COL32(255, 255, 255, 0));
        dl->AddRect(pMin, pMax, IM_COL32(255, 245, 200, alpha8),
                    22.0f * scale, 0, 2.5f * scale);

        if (font)
        {
            const char* lab = "افتح الدبوس";
            float fs = 56.0f * scale;
            ImVec2 sz = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, lab);
            DrawShadowedText(dl, font, fs,
                ImVec2((pMin.x + pMax.x) * 0.5f - sz.x * 0.5f,
                       (pMin.y + pMax.y) * 0.5f - fs * 0.55f),
                IM_COL32(60, 30, 0, alpha8), lab);
        }

        // Cancel (smaller, dark)
        float cancelW = (cardW - padX * 2) * 0.34f;
        ImVec2 caMin(pMax.x + btnGap, btnY);
        ImVec2 caMax(caMin.x + cancelW, btnY + btnH);
        bool cHov = (io.MousePos.x >= caMin.x && io.MousePos.x <= caMax.x &&
                     io.MousePos.y >= caMin.y && io.MousePos.y <= caMax.y);
        dl->AddRectFilled(
            ImVec2(caMin.x + 3 * scale, caMin.y + 8 * scale),
            ImVec2(caMax.x + 3 * scale, caMax.y + 8 * scale),
            IM_COL32(0, 0, 0, (int)(140 * ease)),
            22.0f * scale);
        dl->AddRectFilledMultiColor(caMin, caMax,
            cHov ? IM_COL32(120, 50, 60, alpha8) : IM_COL32(85, 30, 40, alpha8),
            cHov ? IM_COL32(120, 50, 60, alpha8) : IM_COL32(85, 30, 40, alpha8),
            cHov ? IM_COL32(60, 18, 24, alpha8)  : IM_COL32(40, 14, 20, alpha8),
            cHov ? IM_COL32(60, 18, 24, alpha8)  : IM_COL32(40, 14, 20, alpha8));
        dl->AddRect(caMin, caMax, IM_COL32(255, 200, 200, (int)(140 * ease)),
                    22.0f * scale, 0, 2.0f * scale);
        if (font)
        {
            const char* lab = "إلغاء";
            float fs = 48.0f * scale;
            ImVec2 sz = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, lab);
            DrawShadowedText(dl, font, fs,
                ImVec2((caMin.x + caMax.x) * 0.5f - sz.x * 0.5f,
                       (caMin.y + caMax.y) * 0.5f - fs * 0.55f),
                IM_COL32(255, 230, 230, alpha8), lab);
        }

        if (press)
        {
            if (pHov)        TryPick();
            else if (cHov)   Cancel();
        }
    }

    // -------- Full-screen flashes ----------------------------------------
    if (m_flashHit > 0.0f)
    {
        dl->AddRectFilled(ImVec2(0, 0), io.DisplaySize,
            IM_COL32(80, 220, 100, (int)(60 * m_flashHit * ease)));
    }
    if (m_flashMiss > 0.0f)
    {
        dl->AddRectFilled(ImVec2(0, 0), io.DisplaySize,
            IM_COL32(240, 80, 80, (int)(70 * m_flashMiss * ease)));
    }

    m_lastMouseDown = mDown;
    m_pressedColumn = pressedColumn;
}

// =====================================================================
// Post-success "robbery in progress" screen.
// Shows an animated progress bar (no background art, just a thin
// professional line) over a fully opaque black backdrop while the
// player ped plays the SHOP / ROB_LOOP animation server-side.
// =====================================================================
void CRobberyOverlay::RenderProgress()
{
    // Small bottom-of-screen progress strip. Transparent background so the
    // player can watch their character play the robbery animation behind it.
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
    float t = (m_progDurationMs > 0)
              ? (float)elapsed / (float)m_progDurationMs : 1.0f;
    if (t > 1.0f) t = 1.0f;

    ImFont* font = pGUI ? pGUI->GetFont() : nullptr;

    // ---- Geometry: small strip near the bottom of the screen --------------
    float panelW = io.DisplaySize.x * 0.42f;          // narrow strip
    float panelH = 110.0f * scale;
    float panelX = (io.DisplaySize.x - panelW) * 0.5f;
    float panelY = io.DisplaySize.y - panelH - 40.0f * scale;
    ImVec2 pMin(panelX, panelY);
    ImVec2 pMax(panelX + panelW, panelY + panelH);

    // ---- Soft transparent backdrop (just enough for readability) ---------
    dl->AddRectFilled(pMin, pMax, IM_COL32(8, 8, 12, 130), 12.0f * scale);
    // Thin gold border
    dl->AddRect(pMin, pMax, IM_COL32(220, 175, 70, 200),
                12.0f * scale, 0, 1.6f * scale);

    // ---- Title (above the bar, centered) ---------------------------------
    float padX = 22.0f * scale;
    float titleY = panelY + 14.0f * scale;
    if (font)
    {
        const char* title = "جاري سرقة الكشير";
        float fsT = 32.0f * scale;
        ImVec2 ts = font->CalcTextSizeA(fsT, FLT_MAX, 0.0f, title);
        DrawShadowedText(dl, font, fsT,
            ImVec2(panelX + (panelW - ts.x) * 0.5f, titleY),
            IM_COL32(255, 230, 170, 245), title);
    }

    // ---- Thin progress bar (bottom of strip) ------------------------------
    float barH = 8.0f * scale;
    ImVec2 bMin(panelX + padX, panelY + panelH - 30.0f * scale);
    ImVec2 bMax(panelX + panelW - padX, bMin.y + barH);

    // Track
    dl->AddRectFilled(bMin, bMax, IM_COL32(40, 30, 20, 200), barH * 0.5f);
    // Filled portion (gold gradient)
    if (t > 0.0f)
    {
        ImVec2 fMax(bMin.x + (bMax.x - bMin.x) * t, bMax.y);
        dl->AddRectFilledMultiColor(bMin, fMax,
            IM_COL32(255, 215, 100, 255), IM_COL32(255, 170,  60, 255),
            IM_COL32(255, 150,  40, 255), IM_COL32(255, 200,  90, 255));
    }
    // Outline
    dl->AddRect(bMin, bMax, IM_COL32(180, 140, 60, 220),
                barH * 0.5f, 0, 1.0f * scale);

    // ---- Percent (small, right of the bar) -------------------------------
    if (font)
    {
        char buf[16];
        snprintf(buf, sizeof(buf), "%d%%", (int)(t * 100.0f));
        float fsP = 22.0f * scale;
        ImVec2 ps = font->CalcTextSizeA(fsP, FLT_MAX, 0.0f, buf);
        DrawShadowedText(dl, font, fsP,
            ImVec2(panelX + panelW - padX - ps.x,
                   bMin.y - ps.y - 4.0f * scale),
            IM_COL32(255, 220, 150, 230), buf);
    }
}
