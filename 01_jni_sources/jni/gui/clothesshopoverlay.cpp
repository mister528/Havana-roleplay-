#include "../main.h"
#include "clothesshopoverlay.h"
#include "gui.h"
#include "../vendor/imgui/imgui.h"
#include "../vendor/imgui/imgui_internal.h"
#include <cstring>
#include <cstdio>
#include <cstdlib>
#include <cmath>

// Bridges in netrpc.cpp.
extern void CarRent_SendDialogResponse(uint16_t id, uint8_t btn,
                                       uint16_t listitem, char* input);
extern void Inventory_SendChatCommand(const char* cmd);

CClothesShopOverlay* pClothesShopOverlay = nullptr;

// -----------------------------------------------------------------------------
// Polished emerald/gold palette - glass gradients, soft shadows, no hard borders.
// -----------------------------------------------------------------------------
static const ImU32 kCl_PanelTop  = IM_COL32( 22,  40,  32, 235);
static const ImU32 kCl_PanelBot  = IM_COL32(  8,  18,  14, 248);
static const ImU32 kCl_BtnTop    = IM_COL32( 32,  62,  50, 240);
static const ImU32 kCl_BtnBot    = IM_COL32( 12,  26,  20, 245);
static const ImU32 kCl_BtnHovTop = IM_COL32( 60, 140, 100, 245);
static const ImU32 kCl_BtnHovBot = IM_COL32( 28,  80,  56, 250);
static const ImU32 kCl_BtnPressT = IM_COL32( 90, 235, 170, 245);
static const ImU32 kCl_BtnPressB = IM_COL32( 40, 160, 120, 250);
static const ImU32 kCl_Glyph     = IM_COL32(240, 255, 248, 255);
static const ImU32 kCl_GlyphDim  = IM_COL32(170, 200, 188, 235);
static const ImU32 kCl_Gold      = IM_COL32(255, 215,  90, 255);
static const ImU32 kCl_GoldTop   = IM_COL32(165, 125,  35, 240);
static const ImU32 kCl_GoldBot   = IM_COL32(110,  80,  20, 245);
static const ImU32 kCl_GoldHovT  = IM_COL32(220, 170,  55, 245);
static const ImU32 kCl_GoldHovB  = IM_COL32(150, 110,  35, 248);
static const ImU32 kCl_RedTop    = IM_COL32(160,  40,  40, 240);
static const ImU32 kCl_RedBot    = IM_COL32( 90,  18,  18, 245);
static const ImU32 kCl_RedHovT   = IM_COL32(220,  70,  70, 248);
static const ImU32 kCl_RedHovB   = IM_COL32(140,  35,  35, 250);
static const ImU32 kCl_Shadow    = IM_COL32(  0,   0,   0, 160);
static const ImU32 kCl_HiLine    = IM_COL32(255, 255, 255,  40);

static bool PointInRect(const ImVec2& p, const ImVec2& mn, const ImVec2& mx)
{
    return p.x >= mn.x && p.x <= mx.x && p.y >= mn.y && p.y <= mx.y;
}

CClothesShopOverlay::CClothesShopOverlay()
    : m_bVisible(false), m_fAnimT(0.0f), m_prevDown(false),
      m_pressIdx(-1), m_pressFlash(0.0f), m_lastSendTick(0.0f),
      m_currentSkinId(0), m_currentPrice(0)
{
    m_szPrice[0] = '\0';
}

CClothesShopOverlay::~CClothesShopOverlay() {}

void CClothesShopOverlay::Hide()
{
    m_bVisible    = false;
    m_fAnimT      = 0.0f;
    m_prevDown    = false;
    m_pressIdx    = -1;
    m_pressFlash  = 0.0f;
}

void CClothesShopOverlay::OnAnyDialog()
{
    if (m_bVisible) Hide();
}

bool CClothesShopOverlay::TryHandleDialog(uint16_t dialogId, uint8_t /*style*/,
                                          const char* title, const char* body)
{
    if (!title) return false;

    if (strncmp(title, "[!CLOTHES_SHOP_CLOSE]", 21) == 0)
    {
        char empty[2] = {0};
        CarRent_SendDialogResponse(dialogId, 0, 0, empty);
        Hide();
        return true;
    }
    if (strncmp(title, "[!CLOTHES_SHOP_OPEN]", 20) != 0) return false;

    char empty[2] = {0};
    CarRent_SendDialogResponse(dialogId, 0, 0, empty);

    int skinId = 0;
    int price  = 0;
    if (body && body[0])
    {
        const char* sep = strchr(body, '|');
        if (sep)
        {
            skinId = atoi(body);
            price  = atoi(sep + 1);
        }
        else
        {
            price = atoi(body);
        }
    }
    m_currentSkinId = skinId;
    m_currentPrice  = price;

    char raw[16];
    snprintf(raw, sizeof(raw), "%d", price);
    char pretty[32];
    int  n = (int)strlen(raw);
    int  o = 0;
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
        m_pressIdx    = -1;
        m_pressFlash  = 0.0f;
    }
    return true;
}

// -----------------------------------------------------------------------------
// Glyph helpers
// -----------------------------------------------------------------------------
static void DrawChevronCl(ImDrawList* dl, ImVec2 c, float r, int dir,
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

static void DrawXMarkCl(ImDrawList* dl, ImVec2 c, float r, ImU32 col,
                        float thick)
{
    dl->AddLine(ImVec2(c.x - r, c.y - r), ImVec2(c.x + r, c.y + r), col, thick);
    dl->AddLine(ImVec2(c.x - r, c.y + r), ImVec2(c.x + r, c.y - r), col, thick);
}

static void DrawTextCentred(ImDrawList* dl, ImFont* font, float fontSize,
                            ImVec2 boxMin, ImVec2 boxMax,
                            const char* utf8, ImU32 col)
{
    ImVec2 ts = font->CalcTextSizeA(fontSize, FLT_MAX, 0.0f, utf8);
    ImVec2 tp((boxMin.x + boxMax.x - ts.x) * 0.5f,
              (boxMin.y + boxMax.y - ts.y) * 0.5f);
    dl->AddText(font, fontSize, tp, col, utf8);
}

// Rounded pill with gradient fill - no hard border; soft shadow + top
// highlight to give a subtle glass/glossy finish.
static void DrawPillClothes(ImDrawList* dl, ImVec2 mn, ImVec2 mx,
                            ImU32 top, ImU32 bot, float scale)
{
    float h = mx.y - mn.y;
    float r = h * 0.5f;
    // Shadow
    dl->AddRectFilled(ImVec2(mn.x + 3*scale, mn.y + 6*scale),
                      ImVec2(mx.x + 3*scale, mx.y + 6*scale),
                      kCl_Shadow, r);
    // Body gradient (middle rect)
    dl->AddRectFilledMultiColor(ImVec2(mn.x + r, mn.y),
                                ImVec2(mx.x - r, mx.y),
                                top, top, bot, bot);
    // Left/right caps (rounded)
    dl->AddRectFilled(ImVec2(mn.x, mn.y),
                      ImVec2(mn.x + r + 1, mx.y),
                      top, r, ImDrawCornerFlags_Left);
    dl->AddRectFilled(ImVec2(mx.x - r - 1, mn.y),
                      ImVec2(mx.x, mx.y),
                      bot, r, ImDrawCornerFlags_Right);
    // Top highlight strip
    dl->AddRectFilledMultiColor(ImVec2(mn.x + r * 0.5f, mn.y + 2 * scale),
                                ImVec2(mx.x - r * 0.5f, mn.y + h * 0.42f),
                                kCl_HiLine, kCl_HiLine,
                                IM_COL32(255, 255, 255, 0),
                                IM_COL32(255, 255, 255, 0));
}

// Glass circular button (arrow)
static void DrawGlassCircleCl(ImDrawList* dl, ImVec2 c, float r,
                              ImU32 top, ImU32 bot, float scale)
{
    // Drop shadow
    dl->AddCircleFilled(ImVec2(c.x + 3*scale, c.y + 6*scale),
                        r, kCl_Shadow, 48);
    // Main body
    dl->AddCircleFilled(c, r, top, 48);
    // Bottom darker overlay
    dl->AddCircleFilled(ImVec2(c.x, c.y + r * 0.25f),
                        r * 0.78f,
                        IM_COL32(((bot >>  0) & 0xFF),
                                 ((bot >>  8) & 0xFF),
                                 ((bot >> 16) & 0xFF), 90), 42);
    // Top highlight
    dl->AddCircleFilled(ImVec2(c.x, c.y - r * 0.30f),
                        r * 0.65f,
                        IM_COL32(255, 255, 255, 28), 36);
}

// -----------------------------------------------------------------------------
// Main render
// -----------------------------------------------------------------------------
void CClothesShopOverlay::Render()
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

    // ---- Layout ----------------------------------------------------------
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
    const float priceH =  92.0f * scale;
    ImVec2 priceMin(io.DisplaySize.x * 0.5f - priceW * 0.5f, 64.0f * scale);
    ImVec2 priceMax(priceMin.x + priceW, priceMin.y + priceH);
    float drop = (1.0f - ease) * (80.0f * scale);
    priceMin.y -= drop; priceMax.y -= drop;

    const float bottomY = io.DisplaySize.y - 170.0f * scale;
    const float buyW    = 220.0f * scale;
    const float buyH    =  68.0f * scale;
    const float exitW   = 150.0f * scale;
    const float exitH   =  68.0f * scale;
    const float gap     =  22.0f * scale;
    const float totalW  = buyW + exitW + gap;
    ImVec2 buyMin (io.DisplaySize.x * 0.5f - totalW * 0.5f, bottomY);
    ImVec2 buyMax (buyMin.x + buyW, buyMin.y + buyH);
    ImVec2 exitMin(buyMax.x + gap, buyMin.y);
    ImVec2 exitMax(exitMin.x + exitW, exitMin.y + exitH);
    float lift = (1.0f - ease) * (120.0f * scale);
    buyMin.y  += lift;  buyMax.y  += lift;
    exitMin.y += lift;  exitMax.y += lift;

    float dxL = io.MousePos.x - leftC.x,  dyL = io.MousePos.y - leftC.y;
    float dxR = io.MousePos.x - rightC.x, dyR = io.MousePos.y - rightC.y;
    bool  hoverL    = (dxL*dxL + dyL*dyL) <= (btnR * btnR);
    bool  hoverR    = (dxR*dxR + dyR*dyR) <= (btnR * btnR);
    bool  hoverBuy  = PointInRect(io.MousePos, buyMin, buyMax);
    bool  hoverExit = PointInRect(io.MousePos, exitMin, exitMax);

    // ---- Price banner (rounded pill, gold accent) ------------------------
    {
        DrawPillClothes(dl, priceMin, priceMax, kCl_PanelTop, kCl_PanelBot,
                        scale);
        // Gold accent vertical bar
        float accentW = 6.0f * scale;
        dl->AddRectFilled(ImVec2(priceMin.x + 20.0f * scale,
                                 priceMin.y + 14.0f * scale),
                          ImVec2(priceMin.x + 20.0f * scale + accentW,
                                 priceMax.y - 14.0f * scale),
                          kCl_Gold, accentW * 0.5f);

        // Label "السعر" (right, muted)
        const char* lbl = "\xd8\xa7\xd9\x84\xd8\xb3\xd8\xb9\xd8\xb1";
        float titleSize = 28.0f * scale;
        ImVec2 lblTs = font->CalcTextSizeA(titleSize, FLT_MAX, 0.0f, lbl);
        ImVec2 lblPos(priceMax.x - lblTs.x - 26.0f * scale,
                      (priceMin.y + priceMax.y - lblTs.y) * 0.5f);
        dl->AddText(font, titleSize, lblPos, kCl_GlyphDim, lbl);

        // Price number (gold, left)
        float priceSize = 42.0f * scale;
        ImVec2 priceTs = font->CalcTextSizeA(priceSize, FLT_MAX, 0.0f,
                                             m_szPrice);
        ImVec2 pricePos(priceMin.x + 40.0f * scale,
                        (priceMin.y + priceMax.y - priceTs.y) * 0.5f);
        dl->AddText(font, priceSize, pricePos, kCl_Gold, m_szPrice);
    }

    // ---- Left arrow ------------------------------------------------------
    {
        bool isPress = down && hoverL;
        ImU32 top = isPress ? kCl_BtnPressT
                            : (hoverL ? kCl_BtnHovTop : kCl_BtnTop);
        ImU32 bot = isPress ? kCl_BtnPressB
                            : (hoverL ? kCl_BtnHovBot : kCl_BtnBot);
        ImU32 glyph = isPress ? IM_COL32(15, 30, 22, 255) : kCl_Glyph;
        DrawGlassCircleCl(dl, leftC, btnR, top, bot, scale);
        DrawChevronCl(dl, leftC, btnR, -1, glyph, 9.0f * scale);
    }

    // ---- Right arrow -----------------------------------------------------
    {
        bool isPress = down && hoverR;
        ImU32 top = isPress ? kCl_BtnPressT
                            : (hoverR ? kCl_BtnHovTop : kCl_BtnTop);
        ImU32 bot = isPress ? kCl_BtnPressB
                            : (hoverR ? kCl_BtnHovBot : kCl_BtnBot);
        ImU32 glyph = isPress ? IM_COL32(15, 30, 22, 255) : kCl_Glyph;
        DrawGlassCircleCl(dl, rightC, btnR, top, bot, scale);
        DrawChevronCl(dl, rightC, btnR, +1, glyph, 9.0f * scale);
    }

    // ---- Buy button (gold gradient pill) --------------------------------
    {
        bool isP = down && hoverBuy;
        ImU32 top = isP ? IM_COL32(255, 220, 110, 250)
                        : (hoverBuy ? kCl_GoldHovT : kCl_GoldTop);
        ImU32 bot = isP ? IM_COL32(190, 150,  55, 250)
                        : (hoverBuy ? kCl_GoldHovB : kCl_GoldBot);
        DrawPillClothes(dl, buyMin, buyMax, top, bot, scale);
        ImU32 glyph = isP ? IM_COL32(28, 22, 8, 255) : kCl_Glyph;
        const char* lbl = "\xd8\xb4\xd8\xb1\xd8\xa7\xd8\xa1";
        DrawTextCentred(dl, font, 30.0f * scale, buyMin, buyMax, lbl, glyph);
    }

    // ---- Exit button (red gradient pill) --------------------------------
    {
        bool isP = down && hoverExit;
        ImU32 top = isP ? IM_COL32(255, 90, 90, 250)
                        : (hoverExit ? kCl_RedHovT : kCl_RedTop);
        ImU32 bot = isP ? IM_COL32(150, 40, 40, 250)
                        : (hoverExit ? kCl_RedHovB : kCl_RedBot);
        DrawPillClothes(dl, exitMin, exitMax, top, bot, scale);
        ImU32 glyph = isP ? IM_COL32(40, 10, 10, 255) : kCl_Glyph;
        ImVec2 xC(exitMin.x + exitH * 0.55f,
                  (exitMin.y + exitMax.y) * 0.5f);
        DrawXMarkCl(dl, xC, exitH * 0.22f, glyph, 5.5f * scale);
        const char* lbl = "\xd8\xae\xd8\xb1\xd9\x88\xd8\xac";
        float fontSize = 26.0f * scale;
        ImVec2 ts = font->CalcTextSizeA(fontSize, FLT_MAX, 0.0f, lbl);
        ImVec2 tp(exitMin.x + (exitW + exitH * 0.55f - ts.x) * 0.5f
                            + exitH * 0.10f,
                  (exitMin.y + exitMax.y - ts.y) * 0.5f);
        dl->AddText(font, fontSize, tp, glyph, lbl);
    }

    // ---- Tap dispatch ---------------------------------------------------
    if (released)
    {
        const float now = (float)ImGui::GetTime();
        bool throttleOk = (now - m_lastSendTick) > 0.10f;
        const char* cmd = nullptr;
        int idx = -1;
        if      (hoverL)    { cmd = "/clshop_left";  idx = 0; }
        else if (hoverR)    { cmd = "/clshop_right"; idx = 1; }
        else if (hoverBuy)  { cmd = "/clshop_buy";   idx = 2; }
        else if (hoverExit) { cmd = "/clshop_exit";  idx = 3; }

        if (cmd && throttleOk)
        {
            Inventory_SendChatCommand(cmd);
            m_lastSendTick = now;
            m_pressIdx     = idx;
            m_pressFlash   = 0.18f;
            if (idx == 3) Hide();
        }
    }
}
