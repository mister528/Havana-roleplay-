#include "../main.h"
#include "accessoryshopoverlay.h"
#include "gui.h"
#include "../vendor/imgui/imgui.h"
#include "../vendor/imgui/imgui_internal.h"
#include <cstring>
#include <cstdio>
#include <cstdlib>
#include <cmath>

extern void CarRent_SendDialogResponse(uint16_t id, uint8_t btn,
                                       uint16_t listitem, char* input);
extern void Inventory_SendChatCommand(const char* cmd);

CAccessoryShopOverlay* pAccessoryShopOverlay = nullptr;

// -----------------------------------------------------------------------------
// Polished teal/gold palette - glass gradients, no hard borders.
// -----------------------------------------------------------------------------
static const ImU32 kAc_PanelTop  = IM_COL32( 18,  32,  48, 235);
static const ImU32 kAc_PanelBot  = IM_COL32(  6,  14,  22, 248);
static const ImU32 kAc_BtnTop    = IM_COL32( 30,  54,  76, 240);
static const ImU32 kAc_BtnBot    = IM_COL32( 10,  22,  34, 245);
static const ImU32 kAc_BtnHovTop = IM_COL32( 58, 120, 170, 245);
static const ImU32 kAc_BtnHovBot = IM_COL32( 28,  68, 100, 250);
static const ImU32 kAc_BtnPressT = IM_COL32( 90, 210, 255, 245);
static const ImU32 kAc_BtnPressB = IM_COL32( 40, 140, 205, 250);
static const ImU32 kAc_Glyph     = IM_COL32(240, 250, 255, 255);
static const ImU32 kAc_GlyphDim  = IM_COL32(170, 200, 220, 235);
static const ImU32 kAc_Gold      = IM_COL32(255, 215,  90, 255);
static const ImU32 kAc_GoldTop   = IM_COL32(165, 125,  35, 240);
static const ImU32 kAc_GoldBot   = IM_COL32(110,  80,  20, 245);
static const ImU32 kAc_GoldHovT  = IM_COL32(220, 170,  55, 245);
static const ImU32 kAc_GoldHovB  = IM_COL32(150, 110,  35, 248);
static const ImU32 kAc_RedTop    = IM_COL32(160,  40,  40, 240);
static const ImU32 kAc_RedBot    = IM_COL32( 90,  18,  18, 245);
static const ImU32 kAc_RedHovT   = IM_COL32(220,  70,  70, 248);
static const ImU32 kAc_RedHovB   = IM_COL32(140,  35,  35, 250);
static const ImU32 kAc_Shadow    = IM_COL32(  0,   0,   0, 160);
static const ImU32 kAc_HiLine    = IM_COL32(255, 255, 255,  40);

// Rounded pill with gradient fill + subtle highlight, no hard border.
static void DrawPillAc(ImDrawList* dl, ImVec2 mn, ImVec2 mx,
                       ImU32 top, ImU32 bot, float scale)
{
    float h = mx.y - mn.y;
    float r = h * 0.5f;
    dl->AddRectFilled(ImVec2(mn.x + 3*scale, mn.y + 6*scale),
                      ImVec2(mx.x + 3*scale, mx.y + 6*scale),
                      kAc_Shadow, r);
    dl->AddRectFilledMultiColor(ImVec2(mn.x + r, mn.y),
                                ImVec2(mx.x - r, mx.y),
                                top, top, bot, bot);
    dl->AddRectFilled(ImVec2(mn.x, mn.y), ImVec2(mn.x + r + 1, mx.y),
                      top, r, ImDrawCornerFlags_Left);
    dl->AddRectFilled(ImVec2(mx.x - r - 1, mn.y), ImVec2(mx.x, mx.y),
                      bot, r, ImDrawCornerFlags_Right);
    dl->AddRectFilledMultiColor(ImVec2(mn.x + r*0.5f, mn.y + 2*scale),
                                ImVec2(mx.x - r*0.5f, mn.y + h * 0.42f),
                                kAc_HiLine, kAc_HiLine,
                                IM_COL32(255,255,255,0),
                                IM_COL32(255,255,255,0));
}

static void DrawGlassCircleAc(ImDrawList* dl, ImVec2 c, float r,
                              ImU32 top, ImU32 bot, float scale)
{
    dl->AddCircleFilled(ImVec2(c.x + 3*scale, c.y + 6*scale),
                        r, kAc_Shadow, 48);
    dl->AddCircleFilled(c, r, top, 48);
    dl->AddCircleFilled(ImVec2(c.x, c.y + r * 0.25f),
                        r * 0.78f,
                        IM_COL32(((bot >>  0) & 0xFF),
                                 ((bot >>  8) & 0xFF),
                                 ((bot >> 16) & 0xFF), 90), 42);
    dl->AddCircleFilled(ImVec2(c.x, c.y - r * 0.30f),
                        r * 0.65f,
                        IM_COL32(255, 255, 255, 28), 36);
}

static bool PointInRectA(const ImVec2& p, const ImVec2& mn, const ImVec2& mx)
{
    return p.x >= mn.x && p.x <= mx.x && p.y >= mn.y && p.y <= mx.y;
}

CAccessoryShopOverlay::CAccessoryShopOverlay()
    : m_bVisible(false), m_fAnimT(0.0f), m_prevDown(false),
      m_pressIdx(-1), m_pressFlash(0.0f), m_lastSendTick(0.0f),
      m_currentModelId(0), m_currentPrice(0)
{
    m_szPrice[0] = '\0';
}

CAccessoryShopOverlay::~CAccessoryShopOverlay() {}

void CAccessoryShopOverlay::Hide()
{
    m_bVisible   = false;
    m_fAnimT     = 0.0f;
    m_prevDown   = false;
    m_pressIdx   = -1;
    m_pressFlash = 0.0f;
}

void CAccessoryShopOverlay::OnAnyDialog()
{
    if (m_bVisible) Hide();
}

bool CAccessoryShopOverlay::TryHandleDialog(uint16_t dialogId, uint8_t,
                                            const char* title, const char* body)
{
    if (!title) return false;

    if (strncmp(title, "[!ACC_SHOP_CLOSE]", 17) == 0)
    {
        char empty[2] = {0};
        CarRent_SendDialogResponse(dialogId, 0, 0, empty);
        Hide();
        return true;
    }
    if (strncmp(title, "[!ACC_SHOP_OPEN]", 16) != 0) return false;

    char empty[2] = {0};
    CarRent_SendDialogResponse(dialogId, 0, 0, empty);

    int model = 0, price = 0;
    if (body && body[0])
    {
        const char* sep = strchr(body, '|');
        if (sep) { model = atoi(body); price = atoi(sep + 1); }
        else     {                     price = atoi(body); }
    }
    m_currentModelId = model;
    m_currentPrice   = price;

    char raw[16];
    snprintf(raw, sizeof(raw), "%d", price);
    char pretty[32];
    int n = (int)strlen(raw);
    int o = 0;
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
        m_bVisible   = true;
        m_fAnimT     = 0.0f;
        m_prevDown   = false;
        m_pressIdx   = -1;
        m_pressFlash = 0.0f;
    }
    return true;
}

// -----------------------------------------------------------------------------
// Glyphs
// -----------------------------------------------------------------------------
static void DrawChevronAc(ImDrawList* dl, ImVec2 c, float r, int dir,
                          ImU32 col, float thick)
{
    float w = r * 0.55f, h = r * 0.65f;
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

static void DrawXMarkAc(ImDrawList* dl, ImVec2 c, float r, ImU32 col,
                        float thick)
{
    dl->AddLine(ImVec2(c.x - r, c.y - r), ImVec2(c.x + r, c.y + r), col, thick);
    dl->AddLine(ImVec2(c.x - r, c.y + r), ImVec2(c.x + r, c.y - r), col, thick);
}

// Rotation glyph: 3/4 circle arc + arrow tip.
static void DrawRotateGlyph(ImDrawList* dl, ImVec2 c, float r, ImU32 col,
                            float thick)
{
    const int seg = 36;
    const float arcStart = -2.3f;  // radians, leaves a gap for the arrow tip
    const float arcEnd   =  2.3f;
    ImVec2 prev(c.x + cosf(arcStart) * r, c.y + sinf(arcStart) * r);
    for (int i = 1; i <= seg; ++i)
    {
        float t  = (float)i / seg;
        float a  = arcStart + (arcEnd - arcStart) * t;
        ImVec2 p(c.x + cosf(a) * r, c.y + sinf(a) * r);
        dl->AddLine(prev, p, col, thick);
        prev = p;
    }
    // Arrow tip at arcEnd
    float ax = cosf(arcEnd) * r,  ay = sinf(arcEnd) * r;
    float tx = -sinf(arcEnd),     ty =  cosf(arcEnd);
    float tl = r * 0.35f;
    ImVec2 tip(c.x + ax, c.y + ay);
    ImVec2 left (tip.x - ax * 0.25f + tx * tl, tip.y - ay * 0.25f + ty * tl);
    ImVec2 right(tip.x - ax * 0.25f - tx * tl, tip.y - ay * 0.25f - ty * tl);
    dl->AddLine(tip, left,  col, thick);
    dl->AddLine(tip, right, col, thick);
}

static void DrawTextCentredAc(ImDrawList* dl, ImFont* font, float fontSize,
                              ImVec2 boxMin, ImVec2 boxMax,
                              const char* utf8, ImU32 col)
{
    ImVec2 ts = font->CalcTextSizeA(fontSize, FLT_MAX, 0.0f, utf8);
    ImVec2 tp((boxMin.x + boxMax.x - ts.x) * 0.5f,
              (boxMin.y + boxMax.y - ts.y) * 0.5f);
    dl->AddText(font, fontSize, tp, col, utf8);
}

// -----------------------------------------------------------------------------
// Render
// -----------------------------------------------------------------------------
void CAccessoryShopOverlay::Render()
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

    ImDrawList* dl   = ImGui::GetOverlayDrawList();
    ImFont*     font = ImGui::GetFont();

    bool down     = io.MouseDown[0];
    bool released = (!down && m_prevDown);
    m_prevDown = down;

    // ---- Layout ---------------------------------------------------------
    const float btnR   = 92.0f * scale;
    const float btnY   = io.DisplaySize.y * 0.56f;
    const float leftX  = btnR + 56.0f * scale;
    const float rightX = io.DisplaySize.x - btnR - 56.0f * scale;
    ImVec2 leftC (leftX,  btnY);
    ImVec2 rightC(rightX, btnY);
    float slide = (1.0f - ease) * (160.0f * scale);
    leftC.x  -= slide;
    rightC.x += slide;

    const float priceW = 420.0f * scale;
    const float priceH = 92.0f  * scale;
    ImVec2 priceMin(io.DisplaySize.x * 0.5f - priceW * 0.5f, 64.0f * scale);
    ImVec2 priceMax(priceMin.x + priceW, priceMin.y + priceH);
    float drop = (1.0f - ease) * (80.0f * scale);
    priceMin.y -= drop;
    priceMax.y -= drop;

    // Bottom row: BUY + ROTATE + EXIT.
    const float bottomY = io.DisplaySize.y - 170.0f * scale;
    const float buyW    = 220.0f * scale;
    const float btnH    =  68.0f * scale;
    const float rotW    =  68.0f * scale;  // round-ish pill
    const float exitW   = 150.0f * scale;
    const float gap     =  22.0f * scale;
    const float totalW  = buyW + rotW + exitW + gap * 2.0f;
    ImVec2 buyMin (io.DisplaySize.x * 0.5f - totalW * 0.5f, bottomY);
    ImVec2 buyMax (buyMin.x + buyW,  buyMin.y + btnH);
    ImVec2 rotMin (buyMax.x + gap,   buyMin.y);
    ImVec2 rotMax (rotMin.x + rotW,  rotMin.y + btnH);
    ImVec2 exitMin(rotMax.x + gap,   buyMin.y);
    ImVec2 exitMax(exitMin.x + exitW, exitMin.y + btnH);
    float lift = (1.0f - ease) * (120.0f * scale);
    buyMin.y  += lift;  buyMax.y  += lift;
    rotMin.y  += lift;  rotMax.y  += lift;
    exitMin.y += lift;  exitMax.y += lift;

    float dxL = io.MousePos.x - leftC.x,  dyL = io.MousePos.y - leftC.y;
    float dxR = io.MousePos.x - rightC.x, dyR = io.MousePos.y - rightC.y;
    bool  hoverL    = (dxL*dxL + dyL*dyL) <= (btnR * btnR);
    bool  hoverR    = (dxR*dxR + dyR*dyR) <= (btnR * btnR);
    bool  hoverBuy  = PointInRectA(io.MousePos, buyMin,  buyMax);
    bool  hoverRot  = PointInRectA(io.MousePos, rotMin,  rotMax);
    bool  hoverExit = PointInRectA(io.MousePos, exitMin, exitMax);

    // ---- Price banner --------------------------------------------------
    {
        DrawPillAc(dl, priceMin, priceMax, kAc_PanelTop, kAc_PanelBot, scale);
        // Gold accent bar on the left
        float accentW = 6.0f * scale;
        dl->AddRectFilled(ImVec2(priceMin.x + 20.0f * scale,
                                 priceMin.y + 14.0f * scale),
                          ImVec2(priceMin.x + 20.0f * scale + accentW,
                                 priceMax.y - 14.0f * scale),
                          kAc_Gold, accentW * 0.5f);
        const char* lbl = "\xd8\xa7\xd9\x84\xd8\xb3\xd8\xb9\xd8\xb1";
        float titleSize = 28.0f * scale;
        ImVec2 lblTs = font->CalcTextSizeA(titleSize, FLT_MAX, 0.0f, lbl);
        ImVec2 lblPos(priceMax.x - lblTs.x - 26.0f * scale,
                      (priceMin.y + priceMax.y - lblTs.y) * 0.5f);
        dl->AddText(font, titleSize, lblPos, kAc_GlyphDim, lbl);

        float priceSize = 42.0f * scale;
        ImVec2 priceTs = font->CalcTextSizeA(priceSize, FLT_MAX, 0.0f,
                                             m_szPrice);
        ImVec2 pricePos(priceMin.x + 40.0f * scale,
                        (priceMin.y + priceMax.y - priceTs.y) * 0.5f);
        dl->AddText(font, priceSize, pricePos, kAc_Gold, m_szPrice);
    }

    // ---- Left arrow ----------------------------------------------------
    {
        bool isP = down && hoverL;
        ImU32 top = isP ? kAc_BtnPressT : (hoverL ? kAc_BtnHovTop : kAc_BtnTop);
        ImU32 bot = isP ? kAc_BtnPressB : (hoverL ? kAc_BtnHovBot : kAc_BtnBot);
        ImU32 glyph = isP ? IM_COL32(14, 28, 40, 255) : kAc_Glyph;
        DrawGlassCircleAc(dl, leftC, btnR, top, bot, scale);
        DrawChevronAc(dl, leftC, btnR, -1, glyph, 9.0f * scale);
    }

    // ---- Right arrow ---------------------------------------------------
    {
        bool isP = down && hoverR;
        ImU32 top = isP ? kAc_BtnPressT : (hoverR ? kAc_BtnHovTop : kAc_BtnTop);
        ImU32 bot = isP ? kAc_BtnPressB : (hoverR ? kAc_BtnHovBot : kAc_BtnBot);
        ImU32 glyph = isP ? IM_COL32(14, 28, 40, 255) : kAc_Glyph;
        DrawGlassCircleAc(dl, rightC, btnR, top, bot, scale);
        DrawChevronAc(dl, rightC, btnR, +1, glyph, 9.0f * scale);
    }

    // ---- Buy (gold gradient pill) --------------------------------------
    {
        bool isP = down && hoverBuy;
        ImU32 top = isP ? IM_COL32(255, 220, 110, 250)
                        : (hoverBuy ? kAc_GoldHovT : kAc_GoldTop);
        ImU32 bot = isP ? IM_COL32(190, 150,  55, 250)
                        : (hoverBuy ? kAc_GoldHovB : kAc_GoldBot);
        DrawPillAc(dl, buyMin, buyMax, top, bot, scale);
        ImU32 glyph = isP ? IM_COL32(28, 22, 8, 255) : kAc_Glyph;
        const char* lbl = "\xd8\xb4\xd8\xb1\xd8\xa7\xd8\xa1";
        DrawTextCentredAc(dl, font, 30.0f * scale, buyMin, buyMax, lbl, glyph);
    }

    // ---- Rotate (teal gradient pill) -----------------------------------
    {
        bool isP = down && hoverRot;
        ImU32 top = isP ? kAc_BtnPressT
                        : (hoverRot ? kAc_BtnHovTop : kAc_BtnTop);
        ImU32 bot = isP ? kAc_BtnPressB
                        : (hoverRot ? kAc_BtnHovBot : kAc_BtnBot);
        DrawPillAc(dl, rotMin, rotMax, top, bot, scale);
        ImU32 glyph = isP ? IM_COL32(14, 28, 40, 255) : kAc_Glyph;
        ImVec2 rc((rotMin.x + rotMax.x) * 0.5f, (rotMin.y + rotMax.y) * 0.5f);
        DrawRotateGlyph(dl, rc, btnH * 0.30f, glyph, 5.0f * scale);
    }

    // ---- Exit (red gradient pill) --------------------------------------
    {
        bool isP = down && hoverExit;
        ImU32 top = isP ? IM_COL32(255, 90, 90, 250)
                        : (hoverExit ? kAc_RedHovT : kAc_RedTop);
        ImU32 bot = isP ? IM_COL32(150, 40, 40, 250)
                        : (hoverExit ? kAc_RedHovB : kAc_RedBot);
        DrawPillAc(dl, exitMin, exitMax, top, bot, scale);
        ImU32 glyph = isP ? IM_COL32(40, 10, 10, 255) : kAc_Glyph;
        ImVec2 xC(exitMin.x + btnH * 0.55f, (exitMin.y + exitMax.y) * 0.5f);
        DrawXMarkAc(dl, xC, btnH * 0.22f, glyph, 5.5f * scale);
        const char* lbl = "\xd8\xae\xd8\xb1\xd9\x88\xd8\xac";
        float fontSize = 26.0f * scale;
        ImVec2 ts = font->CalcTextSizeA(fontSize, FLT_MAX, 0.0f, lbl);
        ImVec2 tp(exitMin.x + (exitW + btnH * 0.55f - ts.x) * 0.5f
                            + btnH * 0.10f,
                  (exitMin.y + exitMax.y - ts.y) * 0.5f);
        dl->AddText(font, fontSize, tp, glyph, lbl);
    }

    // ---- Tap dispatch --------------------------------------------------
    if (released)
    {
        const float now = (float)ImGui::GetTime();
        bool throttleOk = (now - m_lastSendTick) > 0.10f;
        const char* cmd = nullptr;
        int idx = -1;
        if      (hoverL)    { cmd = "/accshop_left";   idx = 0; }
        else if (hoverR)    { cmd = "/accshop_right";  idx = 1; }
        else if (hoverBuy)  { cmd = "/accshop_buy";    idx = 2; }
        else if (hoverRot)  { cmd = "/accshop_rotate"; idx = 3; }
        else if (hoverExit) { cmd = "/accshop_exit";   idx = 4; }

        if (cmd && throttleOk)
        {
            Inventory_SendChatCommand(cmd);
            m_lastSendTick = now;
            m_pressIdx     = idx;
            m_pressFlash   = 0.18f;
            if (idx == 4) Hide();
        }
    }
}
