#include "../main.h"
#include "houseguardoverlay.h"
#include "houseguardaudio.h"
#include "gui.h"
#include "../vendor/imgui/imgui.h"
#include "../vendor/imgui/imgui_internal.h"
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <cmath>
#include "../arabic.h"

// Forward decl + bridge so we don't need the full netgame.h chain here.
class CNetGame;
extern CNetGame* pNetGame;
void HouseGuard_SendDialogResponse(uint16_t id, uint8_t btn, uint16_t listitem, char* input);

CHouseGuardOverlay* pHouseGuardOverlay = nullptr;
extern CGUI* pGUI;

#ifndef HG_PI
#define HG_PI 3.14159265358979323846f
#endif
#define HG_TAU (HG_PI * 2.0f)

// ---- Palette --------------------------------------------------------------
static const ImU32 kColAccent     = IM_COL32(0,   245, 160, 255);
static const ImU32 kColAccentDim  = IM_COL32(0,   245, 160, 110);
static const ImU32 kColGreen      = IM_COL32(60,  255, 120, 255);
static const ImU32 kColGreenDeep  = IM_COL32(17,  156, 69,  255);
static const ImU32 kColRed        = IM_COL32(255, 80,  80,  255);
static const ImU32 kColAmber      = IM_COL32(255, 196, 64,  255);
static const ImU32 kColRingBg     = IM_COL32(28,  46,  38,  255);
static const ImU32 kColRingBgIn   = IM_COL32(14,  28,  22,  255);
static const ImU32 kColText       = IM_COL32(255, 255, 255, 255);
static const ImU32 kColTextDim    = IM_COL32(220, 230, 224, 220);
static const ImU32 kColTextMuted  = IM_COL32(165, 195, 180, 200);

// ---- Helpers --------------------------------------------------------------
static void StripColors(const char* in, char* out, size_t len)
{
    size_t j = 0;
    for (size_t i = 0; in && in[i] && j + 1 < len; ++i)
    {
        if (in[i] == '{')
        {
            size_t k = i + 1;
            int hexCount = 0;
            bool isColor = true;
            while (in[k] && in[k] != '}' && (k - i) < 12)
            {
                char c = in[k];
                if (!((c >= '0' && c <= '9') || (c >= 'A' && c <= 'F') || (c >= 'a' && c <= 'f')))
                { isColor = false; break; }
                hexCount++; k++;
            }
            if (isColor && in[k] == '}' && (hexCount == 6 || hexCount == 8))
            { i = k; continue; }
        }
        out[j++] = in[i];
    }
    if (j < len) out[j] = '\0';
}

static float EaseOutQuad(float t) { return 1.0f - (1.0f - t) * (1.0f - t); }

static float WrapTau(float a)
{
    while (a < 0.0f) a += HG_TAU;
    while (a >= HG_TAU) a -= HG_TAU;
    return a;
}

static float AngDelta(float a, float b)
{
    float d = WrapTau(b - a);
    if (d > HG_PI) d -= HG_TAU;
    return d;
}

static float frand01() { return (float)rand() / (float)RAND_MAX; }

static void DrawArcFilled(ImDrawList* dl, ImVec2 c, float rOuter, float rInner,
                          float a0, float a1, ImU32 col, int segPerRad = 24)
{
    if (a1 < a0) { float t = a0; a0 = a1; a1 = t; }
    int segs = (int)((a1 - a0) * (float)segPerRad);
    if (segs < 4) segs = 4;
    if (segs > 256) segs = 256;
    dl->PathClear();
    dl->PathArcTo(c, rOuter, a0, a1, segs);
    dl->PathArcTo(c, rInner, a1, a0, segs);
    dl->PathFillConvex(col);
}

// Draw text centered at (cx, top-y). Returns the height used.
static float DrawCenteredText(ImDrawList* dl, ImFont* font, float fontSize,
                              float cx, float topY, ImU32 col, const char* txt)
{
    std::string shaped = (txt && Arabic::ContainsArabic(txt)) ? Arabic::Shape(txt) : std::string(txt ? txt : "");
    const char* p = shaped.c_str();
    if (!font) { dl->AddText(ImVec2(cx, topY), col, p); return fontSize; }
    ImVec2 sz = font->CalcTextSizeA(fontSize, FLT_MAX, 0.0f, p);
    dl->AddText(font, fontSize, ImVec2(cx - sz.x * 0.5f, topY), col, p);
    return sz.y;
}

// ---- Class implementation -------------------------------------------------
CHouseGuardOverlay::CHouseGuardOverlay()
    : m_bVisible(false)
    , m_dialogId(0)
    , m_houseIdx(1)
    , m_totalHouses(5)
    , m_reward(5000)
    , m_hits(0)
    , m_misses(0)
    , m_angle(0.0f)
    , m_targetCenter(0.0f)
    , m_targetHalfArc(0.0f)
    , m_flashHit(0.0f)
    , m_flashMiss(0.0f)
    , m_lastMouseDown(false)
    , m_phase(PHASE_PLAY)
    , m_phaseT(0.0f)
    , m_openT(0.0f)
{
}

CHouseGuardOverlay::~CHouseGuardOverlay() {}

void CHouseGuardOverlay::Hide()
{
    m_bVisible = false;
    m_phase = PHASE_PLAY;
    HouseGuardAudio::StopLoop();
}

float CHouseGuardOverlay::SpeedForHouse(int idx) const
{
    static const float speeds[5] = { 1.6f, 2.0f, 2.4f, 2.7f, 3.0f };
    int i = idx - 1;
    if (i < 0) i = 0;
    if (i > 4) i = 4;
    return speeds[i];
}

float CHouseGuardOverlay::ArcForHouse(int idx) const
{
    static const float halfDeg[5] = { 15.0f, 14.0f, 13.0f, 12.0f, 11.0f };
    int i = idx - 1;
    if (i < 0) i = 0;
    if (i > 4) i = 4;
    return halfDeg[i] * (HG_PI / 180.0f);
}

void CHouseGuardOverlay::ResetAttempt()
{
    m_hits = 0;
    m_misses = 0;
    m_angle = 0.0f;
    NewTarget();
}

void CHouseGuardOverlay::NewTarget()
{
    m_targetHalfArc = ArcForHouse(m_houseIdx);
    float minOffset = 1.0f;
    float span = HG_TAU - 2.0f * minOffset;
    if (span < 0.5f) span = 0.5f;
    float offset = minOffset + frand01() * span;
    m_targetCenter = WrapTau(m_angle + offset);
}

bool CHouseGuardOverlay::TryHandleDialog(uint16_t dialogId, uint8_t /*style*/,
                                         const char* title, const char* body)
{
    if (!title) return false;
    char tclean[160];
    StripColors(title, tclean, sizeof(tclean));
    if (strstr(tclean, "~HOUSEGUARD_UI~") == nullptr) return false;

    char bclean[256];
    StripColors(body ? body : "", bclean, sizeof(bclean));

    int hIdx = 1, hTot = 5, rw = 5000;
    {
        const char* p = bclean;
        char* sep1 = (char*)strchr(p, '|');
        if (sep1)
        {
            *sep1 = '\0';
            hIdx = atoi(p);
            const char* p2 = sep1 + 1;
            char* sep2 = (char*)strchr(p2, '|');
            if (sep2) { *sep2 = '\0'; hTot = atoi(p2); rw = atoi(sep2 + 1); }
            else hTot = atoi(p2);
        }
        else if (*p) hIdx = atoi(p);
    }
    if (hIdx < 1) hIdx = 1;
    if (hTot < 1) hTot = 5;
    if (rw < 0) rw = 0;

    m_dialogId    = dialogId;
    m_houseIdx    = hIdx;
    m_totalHouses = hTot;
    m_reward      = rw;
    m_phase       = PHASE_PLAY;
    m_phaseT      = 0.0f;
    m_openT       = 0.0f;
    m_flashHit    = 0.0f;
    m_flashMiss   = 0.0f;
    m_lastMouseDown = true; // swallow the click that opened the dialog
    ResetAttempt();
    m_bVisible = true;
    HouseGuardAudio::Init();
    HouseGuardAudio::StartLoop();
    return true;
}

void CHouseGuardOverlay::FinishSuccess()
{
    if (!m_bVisible) return;
    m_phase  = PHASE_SUCCESS;
    m_phaseT = 0.0f;
    // [HOUSE GUARD v12.6] Notify the server right away so its 5s burglary
    // timer starts in lockstep with our progress bar. The overlay then keeps
    // the bar on screen for those same 5 seconds and hides itself when done.
    char empty[2] = {0};
    HouseGuard_SendDialogResponse(m_dialogId, 1, 0, empty);
}

void CHouseGuardOverlay::Cancel()
{
    if (!m_bVisible) return;
    char empty[2] = {0};
    HouseGuard_SendDialogResponse(m_dialogId, 0, 0, empty);
    Hide();
}

// ---------------------------------------------------------------------------
// Renderer
//
// v12.1: Minimal layout. No panel/header; just one big, very clear circle in
// the centre of the screen with the rotating arrow + green target arc, a
// small title above and the hits/misses indicator below. Full-screen dim
// keeps the game readable but unobtrusive.
// ---------------------------------------------------------------------------
void CHouseGuardOverlay::Render()
{
    if (!m_bVisible) return;

    ImGuiIO& io = ImGui::GetIO();
    ImDrawList* dl = ImGui::GetOverlayDrawList();

    float scale = io.DisplaySize.y / 1080.0f;
    if (scale < 0.5f) scale = 0.5f;

    // Open animation
    if (m_openT < 1.0f)
    {
        m_openT += io.DeltaTime / 0.22f;
        if (m_openT > 1.0f) m_openT = 1.0f;
    }
    float ease = EaseOutQuad(m_openT);

    // Decay flashes
    if (m_flashHit  > 0.0f) { m_flashHit  -= io.DeltaTime / 0.45f; if (m_flashHit  < 0.0f) m_flashHit  = 0.0f; }
    if (m_flashMiss > 0.0f) { m_flashMiss -= io.DeltaTime / 0.45f; if (m_flashMiss < 0.0f) m_flashMiss = 0.0f; }

    // Backdrop dim (no panel)
    dl->AddRectFilled(ImVec2(0, 0), io.DisplaySize,
                      IM_COL32(0, 0, 0, (int)(170 * ease)));

    ImFont* font = pGUI ? pGUI->GetFont() : nullptr;

    // ---- Big circle -------------------------------------------------------
    // Make it large: 36% of the smaller screen dimension.
    float minDim = io.DisplaySize.x < io.DisplaySize.y ? io.DisplaySize.x : io.DisplaySize.y;
    float rOuter = minDim * 0.32f;
    float rInner = rOuter * 0.78f;
    float ringCX = io.DisplaySize.x * 0.5f;
    float ringCY = io.DisplaySize.y * 0.5f;

    // Slight pop-in on open
    rOuter *= 0.85f + 0.15f * ease;
    rInner *= 0.85f + 0.15f * ease;
    ImVec2 ringC(ringCX, ringCY);

    // [HOUSE GUARD v12.6] During PHASE_SUCCESS the only thing the player
    // should see is a thin "Opening lock..." progress line at the bottom of
    // the screen — the disc, arrow, dots, and hints are all hidden so the
    // foreground (their burglary anim) reads cleanly.
    if (m_phase != PHASE_SUCCESS)
    {

    // Outer halo for hit/miss flash
    {
        ImU32 hi = m_flashHit  > 0.0f ? IM_COL32(60, 255, 120, (int)(160 * m_flashHit)) : 0;
        ImU32 mi = m_flashMiss > 0.0f ? IM_COL32(255, 80, 80,  (int)(160 * m_flashMiss)) : 0;
        if (hi) dl->AddCircleFilled(ringC, rOuter + 70.0f * scale, hi, 96);
        if (mi) dl->AddCircleFilled(ringC, rOuter + 70.0f * scale, mi, 96);
    }

    // Subtle base shadow / halo behind the rim
    for (int g = 0; g < 4; ++g)
    {
        float t = g / 4.0f;
        dl->AddCircle(ringC, rOuter + (8 + g * 6) * scale,
                      IM_COL32(60, 255, 120, (int)((1.0f - t) * 40 * ease)),
                      96, 2.0f * scale);
    }

    // Disc background
    dl->AddCircleFilled(ringC, rOuter + 6.0f * scale, IM_COL32(0, 0, 0, (int)(220 * ease)), 96);
    dl->AddCircleFilled(ringC, rOuter, kColRingBg, 96);
    dl->AddCircleFilled(ringC, rInner, kColRingBgIn, 96);
    dl->AddCircle(ringC, rOuter, kColAccent, 96, 3.0f * scale);
    dl->AddCircle(ringC, rInner, kColAccentDim, 96, 1.6f * scale);

    // Tick marks every 15 deg
    for (int i = 0; i < 24; ++i)
    {
        float a = i * (HG_TAU / 24.0f) - HG_PI * 0.5f;
        bool big = (i % 6 == 0);
        float r1 = big ? (rOuter - 2.0f * scale) : (rOuter - 6.0f * scale);
        float r2 = big ? (rOuter - 26.0f * scale) : (rOuter - 16.0f * scale);
        ImVec2 a1(ringC.x + cosf(a) * r1, ringC.y + sinf(a) * r1);
        ImVec2 a2(ringC.x + cosf(a) * r2, ringC.y + sinf(a) * r2);
        dl->AddLine(a1, a2, big ? kColAccent : kColAccentDim,
                    big ? 3.0f * scale : 1.6f * scale);
    }

    // ---- Target arc -------------------------------------------------------
    if (m_phase == PHASE_PLAY)
    {
        float screenA0 = m_targetCenter - m_targetHalfArc - HG_PI * 0.5f;
        float screenA1 = m_targetCenter + m_targetHalfArc - HG_PI * 0.5f;

        // Glow under the arc
        for (int g = 0; g < 6; ++g)
        {
            float t = g / 6.0f;
            DrawArcFilled(dl, ringC,
                          rOuter + (4 + g * 5) * scale,
                          rInner - (4 + g * 5) * scale,
                          screenA0 - 0.05f, screenA1 + 0.05f,
                          IM_COL32(60, 255, 120, (int)((1.0f - t) * 38)));
        }

        // Solid arc
        DrawArcFilled(dl, ringC,
                      rOuter - 2.0f * scale,
                      rInner + 2.0f * scale,
                      screenA0, screenA1,
                      IM_COL32(60, 255, 120, 240));

        // Bright outer cap on the rim
        DrawArcFilled(dl, ringC,
                      rOuter,
                      rOuter - 9.0f * scale,
                      screenA0, screenA1,
                      kColAccent);
    }

    // ---- Update arrow rotation -------------------------------------------
    if (m_phase == PHASE_PLAY)
    {
        float w = SpeedForHouse(m_houseIdx);
        m_angle = WrapTau(m_angle + w * io.DeltaTime);
    }

    // Big triangle arrow
    auto DrawArrow = [&](float ang, ImU32 col, float scaleMul)
    {
        float screenA = ang - HG_PI * 0.5f;
        float ca = cosf(screenA);
        float sa = sinf(screenA);
        ImVec2 tip(ringC.x + ca * (rOuter - 4.0f * scale),
                   ringC.y + sa * (rOuter - 4.0f * scale));
        float baseR = rInner + 18.0f * scale;
        ImVec2 baseC(ringC.x + ca * baseR, ringC.y + sa * baseR);
        float tx = -sa, ty = ca;
        float halfW = 22.0f * scale * scaleMul;
        ImVec2 b1(baseC.x + tx * halfW, baseC.y + ty * halfW);
        ImVec2 b2(baseC.x - tx * halfW, baseC.y - ty * halfW);
        dl->AddTriangleFilled(tip, b1, b2, col);
        dl->AddCircleFilled(baseC, 7.0f * scale * scaleMul,
                            IM_COL32(255, 255, 255, 235), 16);
    };

    if (m_phase == PHASE_PLAY)
    {
        float w = SpeedForHouse(m_houseIdx);
        for (int t = 1; t <= 6; ++t)
        {
            float dt = t * 0.022f;
            float pa = WrapTau(m_angle - w * dt);
            int alpha = (int)(150.0f * (1.0f - t / 6.0f));
            DrawArrow(pa, IM_COL32(255, 255, 255, alpha), 1.0f - t * 0.08f);
        }
    }
    DrawArrow(m_angle, kColText, 1.0f);

    // Center hub - just a small disc with the hits counter
    float hubR = rInner * 0.32f;
    if (hubR < 60.0f * scale) hubR = 60.0f * scale;
    if (hubR > 110.0f * scale) hubR = 110.0f * scale;
    dl->AddCircleFilled(ringC, hubR + 6.0f * scale, IM_COL32(0, 0, 0, 200), 64);
    dl->AddCircleFilled(ringC, hubR, IM_COL32(20, 40, 32, 245), 64);
    dl->AddCircle(ringC, hubR, kColAccent, 64, 2.0f * scale);

    if (font && m_phase == PHASE_PLAY)
    {
        char hbuf[16];
        snprintf(hbuf, sizeof(hbuf), "%d/%d", m_hits, kRequiredHits);
        float fs = hubR * 0.55f;
        ImVec2 sz = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, hbuf);
        dl->AddText(font, fs,
                    ImVec2(ringC.x - sz.x * 0.5f, ringC.y - sz.y * 0.5f - 4.0f * scale),
                    kColText, hbuf);
    }

    // ---- Title (small, just above the circle) -----------------------------
    if (font)
    {
        float fsTitle = 30.0f * scale;
        float titleY  = ringCY - rOuter - 70.0f * scale;
        if (titleY < 8.0f * scale) titleY = 8.0f * scale;
        DrawCenteredText(dl, font, fsTitle, ringCX, titleY, kColText, "حارس البيت");

        char sub[64];
        snprintf(sub, sizeof(sub), "بيت %d / %d", m_houseIdx, m_totalHouses);
        DrawCenteredText(dl, font, 20.0f * scale,
                         ringCX, titleY + fsTitle + 4.0f * scale,
                         kColAccent, sub);
    }

    // ---- Hits dots + Mistakes (just below the circle) ---------------------
    {
        float dotR   = 14.0f * scale;
        float dotPad = 18.0f * scale;
        int totalDots = kRequiredHits;
        float stripW = totalDots * (dotR * 2 + dotPad) - dotPad;
        float stripX = ringCX - stripW * 0.5f;
        float stripY = ringCY + rOuter + 30.0f * scale;
        for (int i = 0; i < totalDots; ++i)
        {
            ImVec2 c(stripX + dotR + i * (dotR * 2 + dotPad), stripY + dotR);
            ImU32 col = (i < m_hits) ? kColGreen : IM_COL32(40, 70, 56, 230);
            dl->AddCircleFilled(c, dotR, col, 32);
            dl->AddCircle(c, dotR, kColAccentDim, 32, 1.8f);
            if (i < m_hits)
            {
                dl->AddLine(ImVec2(c.x - dotR*0.45f, c.y + dotR*0.05f),
                            ImVec2(c.x - dotR*0.10f, c.y + dotR*0.35f),
                            IM_COL32(0, 50, 25, 255), 2.0f * scale);
                dl->AddLine(ImVec2(c.x - dotR*0.10f, c.y + dotR*0.35f),
                            ImVec2(c.x + dotR*0.50f, c.y - dotR*0.30f),
                            IM_COL32(0, 50, 25, 255), 2.0f * scale);
            }
        }

        // Mistakes line + speed label, on the same row underneath
        char mbuf[64];
        snprintf(mbuf, sizeof(mbuf), "الأخطاء %d / %d", m_misses, kMaxMisses);
        if (font)
        {
            float fs = 18.0f * scale;
            ImU32 col = m_misses == 0 ? kColTextMuted :
                        m_misses == 1 ? kColAmber : kColRed;
            DrawCenteredText(dl, font, fs, ringCX,
                             stripY + dotR * 2 + 12.0f * scale, col, mbuf);
        }

        const char* names[5] = { "بطيء", "سهل", "متوسط", "صعب", "محترف" };
        int li = m_houseIdx - 1;
        if (li < 0) li = 0;
        if (li > 4) li = 4;
        char dbuf[64];
        snprintf(dbuf, sizeof(dbuf), "السرعة: %s", names[li]);
        if (font)
        {
            DrawCenteredText(dl, font, 16.0f * scale, ringCX,
                             stripY + dotR * 2 + 38.0f * scale,
                             kColTextDim, dbuf);
        }
    }

    // ---- Hint at the bottom (only in PLAY) --------------------------------
    if (m_phase == PHASE_PLAY && font)
    {
        const char* hint = "اضغط لما يكون السهم داخل المنطقة الخضراء";
        DrawCenteredText(dl, font, 18.0f * scale, ringCX,
                         io.DisplaySize.y - 80.0f * scale,
                         kColTextDim, hint);
    }

    } // end of `if (m_phase != PHASE_SUCCESS)` — disc / dots / play UI

    // ---- Phase overlays ---------------------------------------------------
    if (m_phase == PHASE_RETRY)
    {
        m_phaseT += io.DeltaTime;
        // Compact red banner across the centre
        float bH = 130.0f * scale;
        float bW = rOuter * 1.6f;
        ImVec2 bMin(ringCX - bW * 0.5f, ringCY - bH * 0.5f);
        ImVec2 bMax(ringCX + bW * 0.5f, ringCY + bH * 0.5f);
        dl->AddRectFilled(bMin, bMax, IM_COL32(80, 12, 12, 240), 18.0f * scale);
        dl->AddRect(bMin, bMax, kColRed, 18.0f * scale, 0, 2.0f * scale);
        if (font)
        {
            DrawCenteredText(dl, font, 30.0f * scale, ringCX,
                             bMin.y + 22.0f * scale,
                             kColText, "أخطاء كثيرة");
            DrawCenteredText(dl, font, 18.0f * scale, ringCX,
                             bMin.y + 78.0f * scale,
                             kColTextDim, "جاري إعادة فتح البيت...");
        }
        if (m_phaseT > 1.4f)
        {
            ResetAttempt();
            m_phase = PHASE_PLAY;
            m_phaseT = 0.0f;
        }
    }
    else if (m_phase == PHASE_SUCCESS)
    {
        m_phaseT += io.DeltaTime;

        // [HOUSE GUARD v12.6] No background, no panel, no disc. Just a thin
        // line across the lower part of the screen filling left-to-right
        // over kOpeningSeconds, with a soft glow and a small leading dot.
        // The matching server-side timer plays the burglary animation and
        // shows "Opening lock..." native game text at the same time.
        const float kOpeningSeconds = 5.0f;
        float p = m_phaseT / kOpeningSeconds;
        if (p < 0.0f) p = 0.0f;
        if (p > 1.0f) p = 1.0f;

        // Smooth easing so the bar starts and ends gently
        float pe = p * p * (3.0f - 2.0f * p);

        float trackW   = io.DisplaySize.x * 0.46f;       // 46% of screen width
        float trackH   = 4.0f * scale;                   // very thin
        float trackX0  = (io.DisplaySize.x - trackW) * 0.5f;
        float trackY   = io.DisplaySize.y - 70.0f * scale;
        float fillX    = trackX0 + trackW * pe;

        // Subtle "rail" — almost invisible, just a hairline so the player
        // knows where the bar will end. Fades in/out with the phase to keep
        // the look airy.
        float fadeIn  = m_phaseT < 0.25f ? (m_phaseT / 0.25f) : 1.0f;
        float fadeOut = m_phaseT > kOpeningSeconds - 0.4f
                          ? (kOpeningSeconds - m_phaseT) / 0.4f : 1.0f;
        float fade = fadeIn < fadeOut ? fadeIn : fadeOut;
        if (fade < 0.0f) fade = 0.0f;
        int aTrack = (int)(28.0f * fade);
        int aFill  = (int)(255.0f * fade);
        int aGlow  = (int)(110.0f * fade);

        ImVec2 tA(trackX0,           trackY);
        ImVec2 tB(trackX0 + trackW,  trackY + trackH);
        // Hairline rail (no box, no panel, no fill — just a 1px line)
        dl->AddLine(ImVec2(tA.x, trackY + trackH * 0.5f),
                    ImVec2(tB.x, trackY + trackH * 0.5f),
                    IM_COL32(255, 255, 255, aTrack),
                    1.0f * scale);

        // Soft outer glow under the filled portion
        for (int g = 0; g < 4; ++g)
        {
            float gh = trackH + (g + 1) * 8.0f * scale;
            float gy = trackY + trackH * 0.5f - gh * 0.5f;
            int   ga = (int)(aGlow * (1.0f - g / 4.0f) * 0.35f);
            dl->AddRectFilled(ImVec2(trackX0, gy),
                              ImVec2(fillX,   gy + gh),
                              IM_COL32(60, 255, 170, ga),
                              gh * 0.5f);
        }

        // The line itself — a smooth gradient from teal to bright green
        if (fillX > trackX0 + 0.5f)
        {
            dl->AddRectFilledMultiColor(
                tA,
                ImVec2(fillX, trackY + trackH),
                IM_COL32( 64, 200, 200, aFill),
                IM_COL32(120, 255, 140, aFill),
                IM_COL32(120, 255, 140, aFill),
                IM_COL32( 64, 200, 200, aFill));
        }

        // Leading-edge marker — a small bright dot with a halo
        ImVec2 head(fillX, trackY + trackH * 0.5f);
        dl->AddCircleFilled(head, 10.0f * scale,
                            IM_COL32(120, 255, 170, aGlow), 20);
        dl->AddCircleFilled(head, 5.0f * scale,
                            IM_COL32(255, 255, 255, aFill), 16);

        // Small label above the bar — no panel, just text
        if (font)
        {
            // Animated dots so it feels alive: "Opening lock", "Opening lock.",
            // "Opening lock..", "Opening lock..."
            char buf[64];
            int dots = ((int)(m_phaseT * 2.0f)) % 4;
            const char* trail = (dots == 0) ? ""
                              : (dots == 1) ? "."
                              : (dots == 2) ? ".."
                                            : "...";
            snprintf(buf, sizeof(buf), "فتح القفل%s", trail);
            ImU32 col = IM_COL32(220, 250, 235, aFill);
            DrawCenteredText(dl, font, 22.0f * scale,
                             io.DisplaySize.x * 0.5f,
                             trackY - 36.0f * scale,
                             col, buf);

            // Percent on the right end of the bar (same y as the label)
            char pct[16];
            snprintf(pct, sizeof(pct), "%d%%", (int)(p * 100.0f + 0.5f));
            ImVec2 sz = font->CalcTextSizeA(16.0f * scale, FLT_MAX, 0.0f, pct);
            dl->AddText(font, 16.0f * scale,
                        ImVec2(trackX0 + trackW - sz.x,
                               trackY - 30.0f * scale),
                        IM_COL32(180, 220, 200, aFill), pct);
        }

        if (m_phaseT >= kOpeningSeconds)
        {
            // Server has already received the response in FinishSuccess(),
            // so we just dismiss the overlay locally.
            Hide();
            return;
        }
    }

    // ---- Input handling ---------------------------------------------------
    bool mouseDown = io.MouseDown[0];
    bool justPressed = mouseDown && !m_lastMouseDown;
    if (m_phase == PHASE_PLAY && justPressed)
    {
        // Tap anywhere on the screen counts as an attempt. Decide based on
        // arrow position relative to the green target arc.
        HouseGuardAudio::PlayClick();
        float d = AngDelta(m_angle, m_targetCenter);
        if (fabsf(d) <= m_targetHalfArc)
        {
            m_hits++;
            m_flashHit = 1.0f;
            HouseGuardAudio::PlayHit();
            if (m_hits >= kRequiredHits)
            {
                HouseGuardAudio::PlayWin();
                FinishSuccess();
            }
            else
            {
                NewTarget();
            }
        }
        else
        {
            m_misses++;
            m_flashMiss = 1.0f;
            HouseGuardAudio::PlayMiss();
            if (m_misses > kMaxMisses)
            {
                HouseGuardAudio::PlayRetry();
                m_phase  = PHASE_RETRY;
                m_phaseT = 0.0f;
            }
            else
            {
                NewTarget();
            }
        }
    }
    m_lastMouseDown = mouseDown;
}
