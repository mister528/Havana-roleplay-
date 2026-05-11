#include "../main.h"
#include "carshopoverlay.h"
#include "gui.h"
#include "../vendor/imgui/imgui.h"
#include "../vendor/imgui/imgui_internal.h"
#include <cstring>
#include <cstdio>
#include <cstdlib>
#include <cmath>
#include "../arabic.h"

extern void CarRent_SendDialogResponse(uint16_t id, uint8_t btn,
                                       uint16_t listitem, char* input);
extern void Inventory_SendChatCommand(const char* cmd);

CCarShopOverlay* pCarShopOverlay = nullptr;

// -----------------------------------------------------------------------------
// Polished visual palette - flat glass look, no hard borders.
// -----------------------------------------------------------------------------
static const ImU32 kCs_PanelTop  = IM_COL32( 22,  34,  46, 235);
static const ImU32 kCs_PanelBot  = IM_COL32( 10,  16,  22, 245);
static const ImU32 kCs_BtnTop    = IM_COL32( 34,  56,  72, 240);
static const ImU32 kCs_BtnBot    = IM_COL32( 14,  26,  36, 245);
static const ImU32 kCs_BtnHovTop = IM_COL32( 60, 110, 140, 245);
static const ImU32 kCs_BtnHovBot = IM_COL32( 30,  60,  80, 250);
static const ImU32 kCs_BtnPressT = IM_COL32( 90, 200, 240, 245);
static const ImU32 kCs_BtnPressB = IM_COL32( 40, 130, 180, 250);
static const ImU32 kCs_Glyph     = IM_COL32(240, 248, 255, 255);
static const ImU32 kCs_GlyphDim  = IM_COL32(170, 190, 205, 235);
static const ImU32 kCs_Gold      = IM_COL32(255, 215,  90, 255);
static const ImU32 kCs_GoldTop   = IM_COL32(165, 125,  35, 240);
static const ImU32 kCs_GoldBot   = IM_COL32(110,  80,  20, 245);
static const ImU32 kCs_GoldHovT  = IM_COL32(220, 170,  55, 245);
static const ImU32 kCs_GoldHovB  = IM_COL32(150, 110,  35, 248);
static const ImU32 kCs_RedTop    = IM_COL32(160,  40,  40, 240);
static const ImU32 kCs_RedBot    = IM_COL32( 90,  18,  18, 245);
static const ImU32 kCs_RedHovT   = IM_COL32(220,  70,  70, 248);
static const ImU32 kCs_RedHovB   = IM_COL32(140,  35,  35, 250);
static const ImU32 kCs_Shadow    = IM_COL32(  0,   0,   0, 160);
static const ImU32 kCs_HiLine    = IM_COL32(255, 255, 255,  40);

// 16-colour visual palette (matches Pawn g_car_palette order exactly).
static const ImU32 kCs_Swatches[16] = {
    IM_COL32( 10,  10,  12, 255), //  0 Black
    IM_COL32(250, 250, 250, 255), //  1 White
    IM_COL32(170, 170, 178, 255), //  2 Silver
    IM_COL32(220,  32,  32, 255), //  3 Red
    IM_COL32(255, 140,  32, 255), //  4 Orange
    IM_COL32(255, 220,  40, 255), //  5 Yellow
    IM_COL32(120, 220, 110, 255), //  6 Light Green
    IM_COL32( 32, 150,  60, 255), //  7 Green
    IM_COL32( 60, 210, 230, 255), //  8 Cyan
    IM_COL32( 40,  90, 220, 255), //  9 Blue
    IM_COL32( 16,  28,  90, 255), // 10 Navy
    IM_COL32(150,  60, 210, 255), // 11 Purple
    IM_COL32(255, 140, 190, 255), // 12 Pink
    IM_COL32(110,  70,  30, 255), // 13 Brown
    IM_COL32(130,  20,  20, 255), // 14 Dark Red
    IM_COL32(220, 205, 170, 255), // 15 Beige
};

static bool PointInRectCs(const ImVec2& p, const ImVec2& mn, const ImVec2& mx)
{
    return p.x >= mn.x && p.x <= mx.x && p.y >= mn.y && p.y <= mx.y;
}

CCarShopOverlay::CCarShopOverlay()
    : m_bVisible(false), m_fAnimT(0.0f), m_prevDown(false),
      m_lastSendTick(0.0f), m_paletteOpen(false), m_bHidden(false),
      m_currentModel(0), m_currentPrice(0), m_rotStep(0)
{
    m_szCat[0]   = '\0';
    m_szPrice[0] = '\0';
}

CCarShopOverlay::~CCarShopOverlay() {}

void CCarShopOverlay::Hide()
{
    m_bVisible    = false;
    m_fAnimT      = 0.0f;
    m_prevDown    = false;
    m_paletteOpen = false;
    m_bHidden     = false;
}

void CCarShopOverlay::OnAnyDialog()
{
    if (m_bVisible) Hide();
}

bool CCarShopOverlay::TryHandleDialog(uint16_t dialogId, uint8_t /*style*/,
                                       const char* title, const char* body)
{
    if (!title) return false;

    if (strncmp(title, "[!CARSHOP_CLOSE]", 16) == 0)
    {
        char empty[2] = {0};
        CarRent_SendDialogResponse(dialogId, 0, 0, empty);
        Hide();
        return true;
    }
    if (strncmp(title, "[!CARSHOP_OPEN]", 15) != 0) return false;

    char empty[2] = {0};
    CarRent_SendDialogResponse(dialogId, 0, 0, empty);

    // Body: "<model>|<price>|<rot>|<category>"
    int model = 0, price = 0, rot = 0;
    char cat[32]; cat[0] = '\0';
    if (body && body[0])
    {
        char tmp[128];
        strncpy(tmp, body, sizeof(tmp) - 1);
        tmp[sizeof(tmp) - 1] = '\0';
        char* s = tmp;
        char* p1 = strchr(s, '|');
        if (p1) { *p1 = '\0'; model = atoi(s); s = p1 + 1; }
        char* p2 = strchr(s, '|');
        if (p2) { *p2 = '\0'; price = atoi(s); s = p2 + 1; }
        char* p3 = strchr(s, '|');
        if (p3) { *p3 = '\0'; rot = atoi(s); s = p3 + 1; }
        if (!p1) model = atoi(tmp);
        strncpy(cat, s, sizeof(cat) - 1);
        cat[sizeof(cat) - 1] = '\0';
    }
    m_currentModel = model;
    m_currentPrice = price;
    m_rotStep      = rot;
    strncpy(m_szCat, cat, sizeof(m_szCat) - 1);
    m_szCat[sizeof(m_szCat) - 1] = '\0';

    // Format price with thousands separators.
    char raw[16];
    snprintf(raw, sizeof(raw), "%d", price);
    char pretty[32]; int n = (int)strlen(raw); int o = 0;
    pretty[o++] = '$';
    for (int i = 0; i < n; ++i)
    {
        pretty[o++] = raw[i];
        int rem = n - i - 1;
        if (rem > 0 && rem % 3 == 0) pretty[o++] = ',';
    }
    pretty[o] = '\0';
    strncpy(m_szPrice, pretty, sizeof(m_szPrice) - 1);
    m_szPrice[sizeof(m_szPrice) - 1] = '\0';

    if (!m_bVisible)
    {
        m_bVisible    = true;
        m_fAnimT      = 0.0f;
        m_prevDown    = false;
        m_paletteOpen = false;
        m_bHidden     = false;
    }
    return true;
}

// -----------------------------------------------------------------------------
// Glyph helpers
// -----------------------------------------------------------------------------
static void DrawChevronCs(ImDrawList* dl, ImVec2 c, float r, int dir,
                          ImU32 col, float thick)
{
    float w = r * 0.50f;
    float h = r * 0.62f;
    if (dir < 0)
    {
        dl->AddLine(ImVec2(c.x + w * 0.40f, c.y - h),
                    ImVec2(c.x - w * 0.55f, c.y),     col, thick);
        dl->AddLine(ImVec2(c.x - w * 0.55f, c.y),
                    ImVec2(c.x + w * 0.40f, c.y + h), col, thick);
    }
    else
    {
        dl->AddLine(ImVec2(c.x - w * 0.40f, c.y - h),
                    ImVec2(c.x + w * 0.55f, c.y),     col, thick);
        dl->AddLine(ImVec2(c.x + w * 0.55f, c.y),
                    ImVec2(c.x - w * 0.40f, c.y + h), col, thick);
    }
}

static void DrawXMarkCs(ImDrawList* dl, ImVec2 c, float r, ImU32 col,
                        float thick)
{
    dl->AddLine(ImVec2(c.x - r, c.y - r), ImVec2(c.x + r, c.y + r), col, thick);
    dl->AddLine(ImVec2(c.x - r, c.y + r), ImVec2(c.x + r, c.y - r), col, thick);
}

// Rotate icon: circular arrow (~275° sweep) with arrow head.
static void DrawRotateIcon(ImDrawList* dl, ImVec2 c, float r, ImU32 col,
                           float thick)
{
    const int N = 28;
    ImVec2 prev;
    for (int i = 0; i <= N; ++i)
    {
        float t = (float)i / (float)N;
        float ang = -1.6f + t * 4.8f;
        ImVec2 p(c.x + cosf(ang) * r, c.y + sinf(ang) * r);
        if (i > 0) dl->AddLine(prev, p, col, thick);
        prev = p;
    }
    float ang = -1.6f + 4.8f;
    ImVec2 tip(c.x + cosf(ang) * r, c.y + sinf(ang) * r);
    ImVec2 n1(tip.x - r * 0.35f * cosf(ang - 0.8f),
              tip.y - r * 0.35f * sinf(ang - 0.8f));
    ImVec2 n2(tip.x - r * 0.35f * cosf(ang + 0.8f),
              tip.y - r * 0.35f * sinf(ang + 0.8f));
    dl->AddLine(tip, n1, col, thick);
    dl->AddLine(tip, n2, col, thick);
}

// Palette icon: 4 coloured tiles without hard border.
static void DrawPaletteIcon(ImDrawList* dl, ImVec2 c, float r, ImU32 /*col*/,
                            float /*thick*/)
{
    float s = r * 0.58f;
    float g = 2.0f;
    dl->AddRectFilled(ImVec2(c.x - s,     c.y - s),     ImVec2(c.x - g, c.y - g),
                      IM_COL32(230, 55, 55, 255), 2.5f);
    dl->AddRectFilled(ImVec2(c.x + g,     c.y - s),     ImVec2(c.x + s, c.y - g),
                      IM_COL32( 55,110,230, 255), 2.5f);
    dl->AddRectFilled(ImVec2(c.x - s,     c.y + g),     ImVec2(c.x - g, c.y + s),
                      IM_COL32(255,215, 70, 255), 2.5f);
    dl->AddRectFilled(ImVec2(c.x + g,     c.y + g),     ImVec2(c.x + s, c.y + s),
                      IM_COL32( 60,190, 90, 255), 2.5f);
}

// Eye icon (open): almond with pupil.
static void DrawEyeOpen(ImDrawList* dl, ImVec2 c, float r, ImU32 col,
                        float thick)
{
    const int N = 22;
    for (int i = 0; i <= N; ++i)
    {
        float t1 = (float)i / (float)N;
        float a1 = 3.14159f * t1;
        ImVec2 p1(c.x + cosf(a1) * r,           c.y - sinf(a1) * r * 0.55f);
        if (i > 0)
        {
            float t0 = (float)(i - 1) / (float)N;
            float a0 = 3.14159f * t0;
            ImVec2 p0(c.x + cosf(a0) * r,       c.y - sinf(a0) * r * 0.55f);
            dl->AddLine(p0, p1, col, thick);
        }
    }
    // bottom half
    for (int i = 0; i <= N; ++i)
    {
        float t1 = (float)i / (float)N;
        float a1 = 3.14159f * t1;
        ImVec2 p1(c.x - cosf(a1) * r,           c.y + sinf(a1) * r * 0.55f);
        if (i > 0)
        {
            float t0 = (float)(i - 1) / (float)N;
            float a0 = 3.14159f * t0;
            ImVec2 p0(c.x - cosf(a0) * r,       c.y + sinf(a0) * r * 0.55f);
            dl->AddLine(p0, p1, col, thick);
        }
    }
    dl->AddCircleFilled(c, r * 0.28f, col, 18);
}

// Eye icon (closed): slash + slight curve.
static void DrawEyeClosed(ImDrawList* dl, ImVec2 c, float r, ImU32 col,
                          float thick)
{
    const int N = 18;
    for (int i = 0; i < N; ++i)
    {
        float t0 = (float)i / (float)N;
        float t1 = (float)(i + 1) / (float)N;
        float a0 = 3.14159f * t0;
        float a1 = 3.14159f * t1;
        ImVec2 p0(c.x + cosf(a0) * r, c.y - sinf(a0) * r * 0.25f + r * 0.12f);
        ImVec2 p1(c.x + cosf(a1) * r, c.y - sinf(a1) * r * 0.25f + r * 0.12f);
        dl->AddLine(p0, p1, col, thick);
    }
    dl->AddLine(ImVec2(c.x - r, c.y + r * 0.65f),
                ImVec2(c.x + r, c.y - r * 0.65f),
                col, thick);
}

static void DrawTextCentredCs(ImDrawList* dl, ImFont* font, float fontSize,
                              ImVec2 a, ImVec2 b, const char* utf8, ImU32 col)
{
    ImVec2 ts = font->CalcTextSizeA(fontSize, FLT_MAX, 0.0f, utf8);
    dl->AddText(font, fontSize,
        ImVec2((a.x + b.x - ts.x) * 0.5f, (a.y + b.y - ts.y) * 0.5f),
        col, utf8);
}

// Gradient rounded pill - no hard border, subtle top highlight for depth.
static void DrawPillGradient(ImDrawList* dl, ImVec2 mn, ImVec2 mx,
                             ImU32 top, ImU32 bot, float rounding,
                             float scale)
{
    // soft shadow
    dl->AddRectFilled(ImVec2(mn.x + 3*scale, mn.y + 6*scale),
                      ImVec2(mx.x + 3*scale, mx.y + 6*scale),
                      kCs_Shadow, rounding);
    dl->AddRectFilledMultiColor(mn, mx, top, top, bot, bot);
    // Subtle inner highlight strip at the top (gives it glass feel)
    dl->AddRectFilledMultiColor(ImVec2(mn.x + 6*scale, mn.y + 3*scale),
                                ImVec2(mx.x - 6*scale,
                                       mn.y + (mx.y - mn.y) * 0.42f),
                                kCs_HiLine, kCs_HiLine,
                                IM_COL32(255,255,255,0),
                                IM_COL32(255,255,255,0));
    (void)rounding;  // rounding handled via AddRectFilled/circle above; we
                     // only use gradient quads here for crisp look.
}

// Convenience: draw a pill with rounded corners using circles + middle rect.
static void DrawRoundedPillGradient(ImDrawList* dl, ImVec2 mn, ImVec2 mx,
                                    ImU32 top, ImU32 bot, float scale)
{
    float h = mx.y - mn.y;
    float r = h * 0.5f;
    // Shadow (rounded)
    dl->AddRectFilled(ImVec2(mn.x + 3*scale, mn.y + 6*scale),
                      ImVec2(mx.x + 3*scale, mx.y + 6*scale),
                      kCs_Shadow, r);
    // Middle gradient rect
    dl->AddRectFilledMultiColor(ImVec2(mn.x + r, mn.y),
                                ImVec2(mx.x - r, mx.y),
                                top, top, bot, bot);
    // Left semicircle
    dl->AddRectFilled(ImVec2(mn.x, mn.y),
                      ImVec2(mn.x + r + 1, mx.y),
                      top, r, ImDrawCornerFlags_Left);
    // Right semicircle
    dl->AddRectFilled(ImVec2(mx.x - r - 1, mn.y),
                      ImVec2(mx.x, mx.y),
                      bot, r, ImDrawCornerFlags_Right);
    // Glass highlight on top
    dl->AddRectFilledMultiColor(ImVec2(mn.x + r*0.5f, mn.y + 2*scale),
                                ImVec2(mx.x - r*0.5f, mn.y + h * 0.42f),
                                kCs_HiLine, kCs_HiLine,
                                IM_COL32(255,255,255,0),
                                IM_COL32(255,255,255,0));
}

// -----------------------------------------------------------------------------
// Main render
// -----------------------------------------------------------------------------
void CCarShopOverlay::Render()
{
    if (!m_bVisible) return;

    ImGuiIO& io = ImGui::GetIO();
    if (m_fAnimT < 1.0f)
    {
        m_fAnimT += io.DeltaTime / 0.22f;
        if (m_fAnimT > 1.0f) m_fAnimT = 1.0f;
    }
    float ease = 1.0f - (1.0f - m_fAnimT) * (1.0f - m_fAnimT);

    float scale = io.DisplaySize.y / 1080.0f;
    if (scale < 0.5f) scale = 0.5f;

    ImDrawList* dl   = ImGui::GetOverlayDrawList();
    ImFont*     font = ImGui::GetFont();

    bool down     = io.MouseDown[0];
    bool released = (!down && m_prevDown);
    m_prevDown = down;

    // ----- Eye toggle (always drawn) --------------------------------------
    const float eyeR   = 38.0f * scale;
    ImVec2      eyeC(io.DisplaySize.x * 0.5f,
                     (m_bHidden ? 60.0f : 30.0f) * scale + eyeR);
    float dxE = io.MousePos.x - eyeC.x, dyE = io.MousePos.y - eyeC.y;
    bool  hoverEye = (dxE*dxE + dyE*dyE) <= (eyeR * eyeR);
    {
        bool isPress = down && hoverEye;
        // drop-shadow
        dl->AddCircleFilled(ImVec2(eyeC.x + 3*scale, eyeC.y + 5*scale),
                            eyeR, kCs_Shadow, 42);
        ImU32 fill = isPress ? kCs_BtnPressT
                             : (hoverEye ? kCs_BtnHovTop : kCs_PanelTop);
        dl->AddCircleFilled(eyeC, eyeR, fill, 42);
        // inner highlight
        dl->AddCircleFilled(ImVec2(eyeC.x, eyeC.y - eyeR * 0.35f),
                            eyeR * 0.72f, IM_COL32(255,255,255, 22), 36);
        ImU32 gc = isPress ? IM_COL32(16, 34, 44, 255) : kCs_Glyph;
        if (m_bHidden)
            DrawEyeClosed(dl, eyeC, eyeR * 0.55f, gc, 4.0f * scale);
        else
            DrawEyeOpen  (dl, eyeC, eyeR * 0.55f, gc, 4.0f * scale);
    }
    if (released && hoverEye)
    {
        m_bHidden = !m_bHidden;
        m_lastSendTick = (float)ImGui::GetTime();
        if (m_bHidden) m_paletteOpen = false;
        return;
    }

    // If hidden, suppress the rest of the UI.
    if (m_bHidden) return;

    // ---- Price / category banner (top centre) ----------------------------
    const float priceW = 520.0f * scale;
    const float priceH =  92.0f * scale;
    ImVec2 priceMin(io.DisplaySize.x * 0.5f - priceW * 0.5f,
                    eyeC.y + eyeR + 18.0f * scale);
    ImVec2 priceMax(priceMin.x + priceW, priceMin.y + priceH);
    float drop = (1.0f - ease) * (80.0f * scale);
    priceMin.y -= drop; priceMax.y -= drop;
    {
        DrawRoundedPillGradient(dl, priceMin, priceMax,
                                kCs_PanelTop, kCs_PanelBot, scale);

        // Gold accent bar on the left
        float accentW = 6.0f * scale;
        dl->AddRectFilled(ImVec2(priceMin.x + 18.0f * scale,
                                 priceMin.y + 14.0f * scale),
                          ImVec2(priceMin.x + 18.0f * scale + accentW,
                                 priceMax.y - 14.0f * scale),
                          kCs_Gold, accentW * 0.5f);

        // Category (muted, right side)
        if (m_szCat[0])
        {
            float catSize = 24.0f * scale;
            ImVec2 ts = font->CalcTextSizeA(catSize, FLT_MAX, 0.0f, m_szCat);
            ImVec2 tp(priceMax.x - ts.x - 28.0f * scale,
                      (priceMin.y + priceMax.y - ts.y) * 0.5f);
            dl->AddText(font, catSize, tp, kCs_GlyphDim, m_szCat);
        }
        // Price (gold, centre-left)
        float priceSize = 42.0f * scale;
        dl->AddText(font, priceSize,
            ImVec2(priceMin.x + 38.0f * scale,
                   (priceMin.y + priceMax.y -
                    font->CalcTextSizeA(priceSize, FLT_MAX, 0.0f, m_szPrice).y)
                    * 0.5f),
            kCs_Gold, m_szPrice);
    }

    // ---- Left / Right arrows (screen-edge circular buttons) --------------
    const float btnR   = 92.0f * scale;
    const float btnY   = io.DisplaySize.y * 0.56f;
    const float leftX  = btnR + 56.0f * scale;
    const float rightX = io.DisplaySize.x - btnR - 56.0f * scale;
    ImVec2 leftC (leftX,  btnY);
    ImVec2 rightC(rightX, btnY);
    float slide = (1.0f - ease) * (160.0f * scale);
    leftC.x  -= slide;
    rightC.x += slide;

    float dxL = io.MousePos.x - leftC.x,  dyL = io.MousePos.y - leftC.y;
    float dxR = io.MousePos.x - rightC.x, dyR = io.MousePos.y - rightC.y;
    bool hoverL = (dxL*dxL + dyL*dyL) <= (btnR * btnR);
    bool hoverR = (dxR*dxR + dyR*dyR) <= (btnR * btnR);

    auto drawRound = [&](ImVec2 c, bool hov, int dir) {
        bool  isPress = down && hov;
        ImU32 top = isPress ? kCs_BtnPressT : (hov ? kCs_BtnHovTop : kCs_BtnTop);
        ImU32 bot = isPress ? kCs_BtnPressB : (hov ? kCs_BtnHovBot : kCs_BtnBot);
        ImU32 glyph = isPress ? IM_COL32(16, 34, 44, 255) : kCs_Glyph;
        // shadow
        dl->AddCircleFilled(ImVec2(c.x + 3*scale, c.y + 6*scale),
                            btnR, kCs_Shadow, 48);
        // body (filled circle)
        dl->AddCircleFilled(c, btnR, top, 48);
        // lower half darker via overlay
        dl->AddCircleFilled(ImVec2(c.x, c.y + btnR * 0.25f),
                            btnR * 0.78f,
                            IM_COL32(((bot >>  0) & 0xFF),
                                     ((bot >>  8) & 0xFF),
                                     ((bot >> 16) & 0xFF), 90), 42);
        // top highlight
        dl->AddCircleFilled(ImVec2(c.x, c.y - btnR * 0.30f),
                            btnR * 0.65f,
                            IM_COL32(255,255,255, 28), 36);
        DrawChevronCs(dl, c, btnR, dir, glyph, 9.0f * scale);
    };

    // ---- Bottom row --------------------------------------------------------
    const float bottomY = io.DisplaySize.y - 170.0f * scale;
    const float buyW   = 200.0f * scale, buyH  = 68.0f * scale;
    const float aicW   =  68.0f * scale;
    const float exitW  = 140.0f * scale, exitH = 68.0f * scale;
    const float gap    =  18.0f * scale;

    // ---- PALETTE MODE -----------------------------------------------------
    if (m_paletteOpen)
    {
        const float swR   = 40.0f * scale;
        const float swGap = 12.0f * scale;
        const float rowW  = 16 * (swR * 2) + 15 * swGap;
        float rowX        = io.DisplaySize.x * 0.5f - rowW * 0.5f;
        float rowY        = bottomY + buyH * 0.5f;

        // Background pill
        ImVec2 bgMn(rowX - 26.0f * scale,  rowY - swR - 16.0f * scale);
        ImVec2 bgMx(rowX + rowW + 26.0f * scale,
                    rowY + swR + 16.0f * scale);
        DrawRoundedPillGradient(dl, bgMn, bgMx,
                                kCs_PanelTop, kCs_PanelBot, scale);

        int hoverSw = -1;
        for (int i = 0; i < 16; ++i)
        {
            float cx = rowX + swR + i * (swR * 2 + swGap);
            ImVec2 c(cx, rowY);
            float dx = io.MousePos.x - c.x, dy = io.MousePos.y - c.y;
            bool  hov = (dx*dx + dy*dy) <= (swR * swR);
            if (hov) hoverSw = i;
            bool isPress = down && hov;
            float rr = swR * (isPress ? 0.90f : (hov ? 1.06f : 1.0f));
            // Drop shadow
            dl->AddCircleFilled(ImVec2(c.x + 2*scale, c.y + 4*scale),
                                rr, kCs_Shadow, 36);
            dl->AddCircleFilled(c, rr, kCs_Swatches[i], 36);
            // Glassy top highlight
            dl->AddCircleFilled(ImVec2(c.x, c.y - rr * 0.35f),
                                rr * 0.65f, IM_COL32(255,255,255,45), 30);
            if (hov)
            {
                dl->AddCircle(c, rr + 3*scale, kCs_Gold, 36, 2.5f * scale);
            }
        }

        if (released && hoverSw >= 0)
        {
            const float now = (float)ImGui::GetTime();
            if ((now - m_lastSendTick) > 0.10f)
            {
                char cmd[32];
                snprintf(cmd, sizeof(cmd), "/carshop_color %d", hoverSw);
                Inventory_SendChatCommand(cmd);
                m_lastSendTick = now;
            }
        }
        if (released && hoverSw < 0 &&
            !PointInRectCs(io.MousePos, bgMn, bgMx))
        {
            m_paletteOpen = false;
        }
        drawRound(leftC,  hoverL, -1);
        drawRound(rightC, hoverR, +1);
        if (released && hoverL) {
            Inventory_SendChatCommand("/carshop_left");
            m_lastSendTick = (float)ImGui::GetTime();
        } else if (released && hoverR) {
            Inventory_SendChatCommand("/carshop_right");
            m_lastSendTick = (float)ImGui::GetTime();
        }
        return;
    }

    // ---- NORMAL MODE buttons layout ---------------------------------------
    const float totalW = buyW + aicW + aicW + exitW + 3 * gap;
    float startX = io.DisplaySize.x * 0.5f - totalW * 0.5f;
    float lift   = (1.0f - ease) * (120.0f * scale);

    ImVec2 buyMin (startX, bottomY + lift);
    ImVec2 buyMax (buyMin.x + buyW, buyMin.y + buyH);
    ImVec2 rotMin (buyMax.x + gap, buyMin.y);
    ImVec2 rotMax (rotMin.x + aicW, rotMin.y + buyH);
    ImVec2 colMin (rotMax.x + gap, buyMin.y);
    ImVec2 colMax (colMin.x + aicW, colMin.y + buyH);
    ImVec2 exitMin(colMax.x + gap, buyMin.y);
    ImVec2 exitMax(exitMin.x + exitW, exitMin.y + exitH);

    bool hoverBuy  = PointInRectCs(io.MousePos, buyMin,  buyMax);
    bool hoverRot  = PointInRectCs(io.MousePos, rotMin,  rotMax);
    bool hoverCol  = PointInRectCs(io.MousePos, colMin,  colMax);
    bool hoverExit = PointInRectCs(io.MousePos, exitMin, exitMax);

    drawRound(leftC,  hoverL, -1);
    drawRound(rightC, hoverR, +1);

    // BUY (gold pill + Arabic label) - no border
    {
        bool isP = down && hoverBuy;
        ImU32 top = isP ? IM_COL32(255, 220, 110, 250)
                        : (hoverBuy ? kCs_GoldHovT : kCs_GoldTop);
        ImU32 bot = isP ? IM_COL32(190, 150,  55, 250)
                        : (hoverBuy ? kCs_GoldHovB : kCs_GoldBot);
        DrawRoundedPillGradient(dl, buyMin, buyMax, top, bot, scale);
        ImU32 gc = isP ? IM_COL32(30, 24, 10, 255) : kCs_Glyph;
        std::string lblSh = Arabic::Shape("\xd8\xb4\xd8\xb1\xd8\xa7\xd8\xa1");  // شراء
        const char* lbl = lblSh.c_str();
        DrawTextCentredCs(dl, font, 30.0f * scale, buyMin, buyMax, lbl, gc);
    }

    // ROTATE (icon button) - no border
    {
        bool isP = down && hoverRot;
        ImU32 top = isP ? kCs_BtnPressT : (hoverRot ? kCs_BtnHovTop : kCs_BtnTop);
        ImU32 bot = isP ? kCs_BtnPressB : (hoverRot ? kCs_BtnHovBot : kCs_BtnBot);
        DrawRoundedPillGradient(dl, rotMin, rotMax, top, bot, scale);
        ImU32 gc = isP ? IM_COL32(16, 34, 44, 255) : kCs_Glyph;
        ImVec2 c((rotMin.x + rotMax.x) * 0.5f,
                 (rotMin.y + rotMax.y) * 0.5f);
        DrawRotateIcon(dl, c, 20.0f * scale, gc, 5.0f * scale);
    }

    // COLOUR (palette icon button) - no border
    {
        bool isP = down && hoverCol;
        ImU32 top = isP ? kCs_BtnPressT : (hoverCol ? kCs_BtnHovTop : kCs_BtnTop);
        ImU32 bot = isP ? kCs_BtnPressB : (hoverCol ? kCs_BtnHovBot : kCs_BtnBot);
        DrawRoundedPillGradient(dl, colMin, colMax, top, bot, scale);
        ImU32 gc = isP ? IM_COL32(16, 34, 44, 255) : kCs_Glyph;
        ImVec2 c((colMin.x + colMax.x) * 0.5f,
                 (colMin.y + colMax.y) * 0.5f);
        DrawPaletteIcon(dl, c, 20.0f * scale, gc, 3.0f * scale);
    }

    // EXIT (red pill + X mark + Arabic label) - no border
    {
        bool isP = down && hoverExit;
        ImU32 top = isP ? IM_COL32(255, 90, 90, 250)
                        : (hoverExit ? kCs_RedHovT : kCs_RedTop);
        ImU32 bot = isP ? IM_COL32(150, 40, 40, 250)
                        : (hoverExit ? kCs_RedHovB : kCs_RedBot);
        DrawRoundedPillGradient(dl, exitMin, exitMax, top, bot, scale);
        ImU32 gc = isP ? IM_COL32(40, 10, 10, 255) : kCs_Glyph;
        ImVec2 xC(exitMin.x + exitH * 0.55f,
                  (exitMin.y + exitMax.y) * 0.5f);
        DrawXMarkCs(dl, xC, exitH * 0.22f, gc, 5.5f * scale);
        std::string lblSh2 = Arabic::Shape("\xd8\xae\xd8\xb1\xd9\x88\xd8\xac");  // خروج
        const char* lbl = lblSh2.c_str();
        float fs = 26.0f * scale;
        ImVec2 ts = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, lbl);
        ImVec2 tp(exitMin.x + (exitW + exitH * 0.55f - ts.x) * 0.5f +
                  exitH * 0.10f,
                  (exitMin.y + exitMax.y - ts.y) * 0.5f);
        dl->AddText(font, fs, tp, gc, lbl);
    }

    // ---- Dispatch ---------------------------------------------------------
    if (released)
    {
        const float now = (float)ImGui::GetTime();
        bool throttleOk = (now - m_lastSendTick) > 0.10f;
        const char* cmd = nullptr;
        int act = -1;
        if      (hoverL)    { cmd = "/carshop_left";   act = 0; }
        else if (hoverR)    { cmd = "/carshop_right";  act = 1; }
        else if (hoverBuy)  { cmd = "/carshop_buy";    act = 2; }
        else if (hoverExit) { cmd = "/carshop_exit";   act = 3; }
        else if (hoverRot)  { cmd = "/carshop_rotate"; act = 4; }
        else if (hoverCol)  {                          act = 5; }

        if (act == 5 && throttleOk)
        {
            m_paletteOpen = true;
            m_lastSendTick = now;
        }
        else if (cmd && throttleOk)
        {
            Inventory_SendChatCommand(cmd);
            m_lastSendTick = now;
            if (act == 3) Hide();
        }
    }
}
