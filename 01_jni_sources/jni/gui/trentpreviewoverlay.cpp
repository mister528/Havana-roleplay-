#include "../main.h"
#include "trentpreviewoverlay.h"
#include "gui.h"
#include "../vendor/imgui/imgui.h"
#include "../vendor/imgui/imgui_internal.h"
#include <cstring>
#include <cmath>

// Forward declarations of bridge helpers in netrpc.cpp.
extern void CarRent_SendDialogResponse(uint16_t id, uint8_t btn,
                                       uint16_t listitem, char* input);
extern void Inventory_SendChatCommand(const char* cmd);

CTrentPreviewOverlay* pTrentPreviewOverlay = nullptr;

// Polished glass/gradient palette - no hard borders.
static const ImU32 kT_BtnTop     = IM_COL32( 32,  62,  50, 240);
static const ImU32 kT_BtnBot     = IM_COL32( 12,  26,  20, 248);
static const ImU32 kT_BtnHovTop  = IM_COL32( 60, 140, 100, 245);
static const ImU32 kT_BtnHovBot  = IM_COL32( 24,  66,  48, 250);
static const ImU32 kT_BtnPressT  = IM_COL32( 90, 235, 170, 250);
static const ImU32 kT_BtnPressB  = IM_COL32( 40, 160, 120, 250);
static const ImU32 kT_Glyph      = IM_COL32(240, 255, 248, 255);
static const ImU32 kT_GlyphPress = IM_COL32( 10,  30,  20, 255);
static const ImU32 kT_RedTop     = IM_COL32(180,  55,  55, 245);
static const ImU32 kT_RedBot     = IM_COL32( 90,  18,  18, 250);
static const ImU32 kT_RedHovTop  = IM_COL32(220,  80,  80, 250);
static const ImU32 kT_RedHovBot  = IM_COL32(130,  28,  28, 250);
static const ImU32 kT_RedPressT  = IM_COL32(255, 130, 120, 250);
static const ImU32 kT_RedPressB  = IM_COL32(180,  45,  45, 250);
static const ImU32 kT_Shadow     = IM_COL32(  0,   0,   0, 160);
static const ImU32 kT_HiLine     = IM_COL32(255, 255, 255,  45);
static const ImU32 kT_InnerDark  = IM_COL32(  0,   0,   0,  90);

static bool PointInRect(const ImVec2& p, const ImVec2& mn, const ImVec2& mx)
{
    return p.x >= mn.x && p.x <= mx.x && p.y >= mn.y && p.y <= mx.y;
}

CTrentPreviewOverlay::CTrentPreviewOverlay()
    : m_bVisible(false), m_fAnimT(0.0f), m_prevDown(false),
      m_pressIdx(-1), m_pressFlash(0.0f), m_lastSendTick(0.0f) {}

CTrentPreviewOverlay::~CTrentPreviewOverlay() {}

void CTrentPreviewOverlay::Hide()
{
    m_bVisible    = false;
    m_fAnimT      = 0.0f;
    m_prevDown    = false;
    m_pressIdx    = -1;
    m_pressFlash  = 0.0f;
}

void CTrentPreviewOverlay::OnAnyDialog()
{
    // Any other dialog means the rental flow has progressed (e.g. the
    // duration list reappeared after auto-return). Dismiss ourselves.
    if (m_bVisible) Hide();
}

bool CTrentPreviewOverlay::TryHandleDialog(uint16_t dialogId, uint8_t /*style*/,
                                           const char* title, const char* /*body*/)
{
    if (!title) return false;
    if (strncmp(title, "[!TRENT_PREVIEW_OPEN]", 21) != 0) return false;

    // Auto-dismiss the sentinel dialog server-side so p_dialog clears.
    char empty[2] = {0};
    CarRent_SendDialogResponse(dialogId, 0, 0, empty);

    m_bVisible    = true;
    m_fAnimT      = 0.0f;
    m_prevDown    = false;
    m_pressIdx    = -1;
    m_pressFlash  = 0.0f;
    return true;
}

// Draws an arrow glyph (chevron) inside a circle. dir = -1 (left) or +1 (right).
static void DrawChevron(ImDrawList* dl, ImVec2 c, float r, int dir, ImU32 col, float thick)
{
    float w = r * 0.55f;
    float h = r * 0.65f;
    if (dir < 0)
    {
        ImVec2 p0(c.x + w * 0.45f, c.y - h);
        ImVec2 p1(c.x - w * 0.55f, c.y);
        ImVec2 p2(c.x + w * 0.45f, c.y + h);
        dl->AddLine(p0, p1, col, thick);
        dl->AddLine(p1, p2, col, thick);
    }
    else
    {
        ImVec2 p0(c.x - w * 0.45f, c.y - h);
        ImVec2 p1(c.x + w * 0.55f, c.y);
        ImVec2 p2(c.x - w * 0.45f, c.y + h);
        dl->AddLine(p0, p1, col, thick);
        dl->AddLine(p1, p2, col, thick);
    }
}

// Draws an X glyph centered at c with arms of half-length r.
static void DrawXMark(ImDrawList* dl, ImVec2 c, float r, ImU32 col, float thick)
{
    dl->AddLine(ImVec2(c.x - r, c.y - r), ImVec2(c.x + r, c.y + r), col, thick);
    dl->AddLine(ImVec2(c.x - r, c.y + r), ImVec2(c.x + r, c.y - r), col, thick);
}

void CTrentPreviewOverlay::Render()
{
    if (!m_bVisible) return;

    ImGuiIO& io = ImGui::GetIO();
    if (m_fAnimT < 1.0f)
    {
        m_fAnimT += io.DeltaTime / 0.22f;
        if (m_fAnimT > 1.0f) m_fAnimT = 1.0f;
    }
    if (m_pressFlash > 0.0f)
    {
        m_pressFlash -= io.DeltaTime;
        if (m_pressFlash < 0.0f) m_pressFlash = 0.0f;
    }
    float ease = 1.0f - (1.0f - m_fAnimT) * (1.0f - m_fAnimT);

    float scale = io.DisplaySize.y / 1080.0f;
    if (scale < 0.5f) scale = 0.5f;

    ImDrawList* dl = ImGui::GetOverlayDrawList();

    // -------- Edge-detected input --------
    bool down     = io.MouseDown[0];
    bool pressed  = (down && !m_prevDown);
    bool released = (!down && m_prevDown);
    m_prevDown = down;

    // -------- Layout --------
    // Three buttons: side rotation buttons (large circles) on the left and
    // right edges of the screen, vertically centered. Exit button (rounded
    // rectangle) at top-center, well clear of game HUD.
    const float btnR     = 110.0f * scale;          // rotation button radius
    const float btnY     = io.DisplaySize.y * 0.55f; // a touch below center
    const float leftX    = btnR + 60.0f * scale;
    const float rightX   = io.DisplaySize.x - btnR - 60.0f * scale;

    ImVec2 leftC (leftX,  btnY);
    ImVec2 rightC(rightX, btnY);

    // Animate slide-in for circular buttons (from outside the screen).
    float slide = (1.0f - ease) * (160.0f * scale);
    leftC.x  -= slide;
    rightC.x += slide;

    // Exit button — wide rounded rect at top-center.
    const float exitW = 360.0f * scale;
    const float exitH = 100.0f * scale;
    ImVec2 exitMin(io.DisplaySize.x * 0.5f - exitW * 0.5f,
                   60.0f * scale);
    ImVec2 exitMax(exitMin.x + exitW, exitMin.y + exitH);
    // Animate slide-down
    float drop = (1.0f - ease) * (120.0f * scale);
    exitMin.y -= drop;
    exitMax.y -= drop;

    // Hover detection
    float dxL = io.MousePos.x - leftC.x,  dyL = io.MousePos.y - leftC.y;
    float dxR = io.MousePos.x - rightC.x, dyR = io.MousePos.y - rightC.y;
    bool hoverL = (dxL*dxL + dyL*dyL) <= (btnR * btnR);
    bool hoverR = (dxR*dxR + dyR*dyR) <= (btnR * btnR);
    bool hoverX = PointInRect(io.MousePos, exitMin, exitMax);

    // Helper: draw a polished glass circle with drop shadow, body gradient,
    // inner darker overlay (bottom half) and a top highlight crescent.
    auto DrawGlassCircle = [&](ImVec2 c, float r,
                               ImU32 top, ImU32 bot, ImU32 glyph, int dir)
    {
        // Drop shadow
        dl->AddCircleFilled(ImVec2(c.x + 3.0f * scale, c.y + 6.0f * scale),
                            r, kT_Shadow, 56);
        // Body - approximate a vertical gradient by layering two filled discs
        dl->AddCircleFilled(c, r, top, 56);
        dl->AddCircleFilled(ImVec2(c.x, c.y + r * 0.35f),
                            r * 0.78f, bot, 48);
        // Bottom inner dark for depth
        dl->AddCircleFilled(ImVec2(c.x, c.y + r * 0.55f),
                            r * 0.62f, kT_InnerDark, 48);
        // Top highlight crescent
        dl->AddCircleFilled(ImVec2(c.x, c.y - r * 0.30f),
                            r * 0.68f, IM_COL32(255, 255, 255, 28), 48);
        // Glyph
        DrawChevron(dl, c, r, dir, glyph, 9.0f * scale);
    };

    // -------- Draw left button --------
    {
        bool isPress = down && hoverL;
        ImU32 top   = isPress ? kT_BtnPressT : (hoverL ? kT_BtnHovTop : kT_BtnTop);
        ImU32 bot   = isPress ? kT_BtnPressB : (hoverL ? kT_BtnHovBot : kT_BtnBot);
        ImU32 glyph = isPress ? kT_GlyphPress : kT_Glyph;
        DrawGlassCircle(leftC, btnR, top, bot, glyph, -1);
    }

    // -------- Draw right button --------
    {
        bool isPress = down && hoverR;
        ImU32 top   = isPress ? kT_BtnPressT : (hoverR ? kT_BtnHovTop : kT_BtnTop);
        ImU32 bot   = isPress ? kT_BtnPressB : (hoverR ? kT_BtnHovBot : kT_BtnBot);
        ImU32 glyph = isPress ? kT_GlyphPress : kT_Glyph;
        DrawGlassCircle(rightC, btnR, top, bot, glyph, +1);
    }

    // -------- Draw exit button --------
    {
        bool isPress = down && hoverX;
        ImU32 top   = isPress ? kT_RedPressT
                              : (hoverX ? kT_RedHovTop : kT_RedTop);
        ImU32 bot   = isPress ? kT_RedPressB
                              : (hoverX ? kT_RedHovBot : kT_RedBot);
        ImU32 glyph = kT_Glyph;
        float rad   = exitH * 0.5f;
        // Shadow
        dl->AddRectFilled(ImVec2(exitMin.x + 3*scale, exitMin.y + 6*scale),
                          ImVec2(exitMax.x + 3*scale, exitMax.y + 6*scale),
                          kT_Shadow, rad);
        // Vertical gradient body (no hard border)
        dl->AddRectFilledMultiColor(exitMin, exitMax, top, top, bot, bot);
        // Top highlight strip
        dl->AddRectFilledMultiColor(
            ImVec2(exitMin.x + rad * 0.6f, exitMin.y + 1),
            ImVec2(exitMax.x - rad * 0.6f, exitMin.y + exitH * 0.42f),
            kT_HiLine, kT_HiLine,
            IM_COL32(255,255,255,0), IM_COL32(255,255,255,0));
        // X glyph on left
        ImVec2 xC(exitMin.x + exitH * 0.55f, (exitMin.y + exitMax.y) * 0.5f);
        DrawXMark(dl, xC, exitH * 0.22f, glyph, 6.0f * scale);
        // Label "خروج"
        const char* label = "\xd8\xae\xd8\xb1\xd9\x88\xd8\xac"; // خروج
        ImFont* font = ImGui::GetFont();
        float fontSize = 44.0f * scale;
        ImVec2 ts = font->CalcTextSizeA(fontSize, FLT_MAX, 0.0f, label);
        ImVec2 tp(exitMin.x + (exitW + exitH * 0.55f - ts.x) * 0.5f
                            + exitH * 0.10f,
                  (exitMin.y + exitMax.y - ts.y) * 0.5f);
        dl->AddText(font, fontSize, tp, glyph, label);
    }

    // -------- Tap dispatch (on release, only if pointer stayed inside) --------
    if (released)
    {
        // Throttle re-fires (some devices send stutter taps).
        const float now = (float)ImGui::GetTime();
        bool throttleOk = (now - m_lastSendTick) > 0.10f;
        const char* cmd = nullptr;
        int idx = -1;
        if (hoverL)      { cmd = "/tprev_left";  idx = 0; }
        else if (hoverR) { cmd = "/tprev_right"; idx = 1; }
        else if (hoverX) { cmd = "/tprev_exit";  idx = 2; }

        if (cmd && throttleOk)
        {
            Inventory_SendChatCommand(cmd);
            m_lastSendTick = now;
            m_pressIdx     = idx;
            m_pressFlash   = 0.18f;
            // Locally hide on exit so the UI feels instant; the server will
            // also re-open the preview dialog right after which keeps things
            // consistent.
            if (idx == 2) Hide();
        }
    }
}
