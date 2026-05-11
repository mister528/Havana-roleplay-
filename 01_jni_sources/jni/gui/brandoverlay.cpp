#include "../main.h"
#include "brandoverlay.h"
#include "gui.h"
#include "../game/game.h"
#include "../net/netgame.h"
#include "../dialog.h"
#include "../scoreboard.h"
#include "../keyboard.h"
#include "inventorytex.h"
#include "../vendor/imgui/imgui.h"
#include "../vendor/imgui/imgui_internal.h"

#include <math.h>
#include <stdio.h>

CBrandOverlay* pBrandOverlay = nullptr;

extern CGUI*          pGUI;
extern CGame*         pGame;
extern CNetGame*      pNetGame;
extern CDialogWindow* pDialogWindow;
extern CScoreBoard*   pScoreBoard;
extern CKeyBoard*     pKeyBoard;

// HavanaRp brand palette (matches bankoverlay / inventoryoverlay)
static const ImU32 kColBarTop     = IM_COL32( 30, 138,  80, 232); // emerald
static const ImU32 kColBarMid     = IM_COL32( 18,  92,  56, 240);
static const ImU32 kColBarBot     = IM_COL32(  6,  38,  24, 250); // deep emerald
static const ImU32 kColBarShine   = IM_COL32(190, 255, 210,  70);
static const ImU32 kColBarShadow  = IM_COL32(  0,   0,   0, 130);
static const ImU32 kColBadgeOuter = IM_COL32(  4,  24,  16, 255);
static const ImU32 kColBadgeInner = IM_COL32( 12,  60,  38, 255);
static const ImU32 kColBadgeRim   = IM_COL32(218, 200, 130, 235); // soft gold
static const ImU32 kColBadgeRim2  = IM_COL32(255, 244, 188, 110);
static const ImU32 kColHrCore     = IM_COL32(160, 230, 175, 255);
static const ImU32 kColHrShine    = IM_COL32(245, 255, 220, 255);
static const ImU32 kColHrDeep     = IM_COL32( 28,  88,  52, 255);
static const ImU32 kColTextWhite  = IM_COL32(248, 252, 248, 255);
static const ImU32 kColTextDim    = IM_COL32(195, 220, 200, 215);
static const ImU32 kColAccentDot  = IM_COL32( 90, 220, 145, 255);

CBrandOverlay::CBrandOverlay()
    : m_x(0.075064f)
    , m_y(0.952778f)
    , m_scale(0.860000f)
{
}
CBrandOverlay::~CBrandOverlay() {}

static float BrandClamp(float v, float lo, float hi)
{
    if (v < lo) return lo;
    if (v > hi) return hi;
    return v;
}

// Approximate vertical gradient for a banner using a stack of thin filled rects.
static void DrawVerticalGradientRect(ImDrawList* dl, ImVec2 a, ImVec2 b,
                                     ImU32 top, ImU32 bot, int steps = 22)
{
    if (b.y <= a.y || b.x <= a.x) return;
    const ImVec4 vt = ImColor(top).Value;
    const ImVec4 vb = ImColor(bot).Value;
    for (int i = 0; i < steps; ++i)
    {
        float t0 = (float)i / steps;
        float t1 = (float)(i + 1) / steps;
        float y0 = a.y + (b.y - a.y) * t0;
        float y1 = a.y + (b.y - a.y) * t1;
        ImVec4 c;
        c.x = vt.x + (vb.x - vt.x) * (t0 + t1) * 0.5f;
        c.y = vt.y + (vb.y - vt.y) * (t0 + t1) * 0.5f;
        c.z = vt.z + (vb.z - vt.z) * (t0 + t1) * 0.5f;
        c.w = vt.w + (vb.w - vt.w) * (t0 + t1) * 0.5f;
        dl->AddRectFilled(ImVec2(a.x, y0), ImVec2(b.x, y1), ImColor(c));
    }
}

// Polished circular badge with a metallic-green "HR" monogram.
//
// Layered, in order:
//   1. soft outer drop shadow
//   2. dark outer disc
//   3. gold rim (thin)
//   4. inner emerald disc with subtle radial vignette
//   5. inner gold highlight ring
//   6. HR monogram drawn with a 2-pass gradient (deep base + lighter top half)
//   7. tiny specular highlight
static void DrawBadge(ImDrawList* dl, ImVec2 c, float r,
                      ImFont* font, float fontSize)
{
    // Soft drop shadow
    for (int i = 4; i >= 1; --i)
    {
        dl->AddCircleFilled(ImVec2(c.x, c.y + i * 0.6f), r + i * 0.6f,
                            IM_COL32(0, 0, 0, 14 * i), 64);
    }
    // Dark outer disc
    dl->AddCircleFilled(c, r + 1.5f, kColBadgeOuter, 64);
    // Gold rim
    dl->AddCircle(c, r + 0.5f, kColBadgeRim, 64, 1.6f);
    // Inner emerald disc
    dl->AddCircleFilled(c, r - 1.5f, kColBadgeInner, 64);
    // Inner highlight ring (gold)
    dl->AddCircle(c, r - 4.0f, kColBadgeRim2, 64, 0.9f);
    // Subtle radial vignette: dimmer outer ring
    dl->AddCircle(c, r - 2.0f, IM_COL32(0, 0, 0, 60), 64, 1.4f);

    const char* hr = "HR";
    ImVec2 ts = font->CalcTextSizeA(fontSize, FLT_MAX, 0.0f, hr);
    ImVec2 tp = ImVec2(c.x - ts.x * 0.5f, c.y - ts.y * 0.5f - fontSize * 0.04f);

    // Deep shadow (offset right + down)
    dl->AddText(font, fontSize, ImVec2(tp.x + 1.6f, tp.y + 1.6f),
                IM_COL32(0, 0, 0, 165), hr);
    // Base fill
    dl->AddText(font, fontSize, tp, kColHrDeep, hr);

    // Top-half lighter pass (clipped to upper portion)
    dl->PushClipRect(ImVec2(tp.x - 2.0f, tp.y - 2.0f),
                     ImVec2(tp.x + ts.x + 2.0f, tp.y + ts.y * 0.65f), true);
    dl->AddText(font, fontSize, tp, kColHrCore, hr);
    dl->PopClipRect();

    // Top shine band (clipped to upper third)
    dl->PushClipRect(ImVec2(tp.x - 2.0f, tp.y - 2.0f),
                     ImVec2(tp.x + ts.x + 2.0f, tp.y + ts.y * 0.32f), true);
    dl->AddText(font, fontSize, tp, kColHrShine, hr);
    dl->PopClipRect();

    // Tiny specular highlight on the rim (top-left)
    dl->AddCircleFilled(ImVec2(c.x - r * 0.45f, c.y - r * 0.55f),
                        r * 0.12f, IM_COL32(255, 255, 255, 70), 16);
}

// Filled banner shape with a smooth swoop-curve right edge.
static void FillSwoopBanner(ImDrawList* dl, float x0, float y0, float x1, float y1,
                            float swoopExtra, ImU32 mid)
{
    const int N = 32;
    ImVec2 pts[N + 4];
    int idx = 0;
    pts[idx++] = ImVec2(x1, y1);
    pts[idx++] = ImVec2(x1, y0);

    float h = y1 - y0;
    // Cubic bezier-ish profile: t^2 ease that curves down smoothly
    for (int i = 1; i <= N; ++i)
    {
        float t = (float)i / N;
        float ax = x1 + swoopExtra * t;
        // ay starts near y0 and curves down to y1 at t=1
        float ay = y0 + h * (1.0f - powf(1.0f - t, 2.2f)) * 0.92f;
        pts[idx++] = ImVec2(ax, ay);
    }
    pts[idx++] = ImVec2(x1 + swoopExtra, y1);

    dl->AddConvexPolyFilled(pts, idx, mid);

    // Glossy line along the top arc
    for (int i = 1; i < N; ++i)
    {
        dl->AddLine(pts[i + 1], pts[i + 2], kColBarShine, 1.0f);
    }
}

void CBrandOverlay::RenderLogo(float sw, float sh)
{
    void* tex = nullptr; int tw = 0, th = 0; float tu = 1.0f, tv = 1.0f;
    if (!InventoryTex::GetHavanaLogo(&tex, &tw, &th, &tu, &tv) || !tex) return;

    ImDrawList* dl = ImGui::GetOverlayDrawList();
    if (!dl) return;

    float uiScale = BrandClamp(sh / 720.0f, 0.55f, 2.0f);
    float w = 270.0f * uiScale * m_scale;
    float h = w * ((th > 0 && tw > 0) ? ((float)th / (float)tw) : 1.0f);
    float x = sw * m_x - w * 0.5f;
    float y = sh * m_y - h * 0.5f;

    dl->AddImage((ImTextureID)tex, ImVec2(x, y), ImVec2(x + w, y + h),
                 ImVec2(0, 0), ImVec2(tu, tv), IM_COL32(255, 255, 255, 235));
}

void CBrandOverlay::Render()
{
    if (!pNetGame || !pGame) return;
    if (!pGUI) return;
    ImGuiIO& io = ImGui::GetIO();
    if (pKeyBoard && pKeyBoard->IsOpen()) return;
    if (pDialogWindow && pDialogWindow->m_bIsActive) return;
    if (pScoreBoard && pScoreBoard->m_bToggle) return;
    if (!pGame->IsToggledHUDElement(HUD_ELEMENT_BUTTONS)) return;

    RenderLogo(io.DisplaySize.x, io.DisplaySize.y);
}
