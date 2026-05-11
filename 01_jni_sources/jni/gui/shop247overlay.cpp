#include "../main.h"
#include "shop247overlay.h"
#include "gui.h"
#include "../arabic.h"
#include "../vendor/imgui/imgui.h"
#include "../vendor/imgui/imgui_internal.h"
#include <cstdio>
#include <cstring>
#include <cstdlib>
#include <string>

// Bridge from carrentoverlay.cpp — SendDialogResponse goes through the same helper.
void CarRent_SendDialogResponse(uint16_t id, uint8_t btn, uint16_t listitem, char* input);

CShop247Overlay* pShop247Overlay = nullptr;
extern CGUI* pGUI;

static std::string ShapeText(const char* s)
{
    if (!s) return std::string();
    if (!Arabic::ContainsArabic(s)) return std::string(s);
    return Arabic::Shape(s);
}

static ImVec2 CalcShapedTextSize(ImFont* font, float size, const std::string& text)
{
    if (!font) return ImGui::CalcTextSize(text.c_str());
    return font->CalcTextSizeA(size, FLT_MAX, 0.0f, text.c_str());
}

static void AddShapedText(ImDrawList* dl, ImFont* font, float size, ImVec2 pos,
                          ImU32 col, const char* text)
{
    if (!dl || !text) return;
    std::string shaped = ShapeText(text);
    if (font) dl->AddText(font, size, pos, col, shaped.c_str());
    else      dl->AddText(pos, col, shaped.c_str());
}

// --- Market palette: warm amber accent with the Havana green for price tags ---
static const ImU32 kS_Bg         = IM_COL32( 16,  24,  20, 242);
static const ImU32 kS_BgInner    = IM_COL32( 22,  34,  28, 252);
static const ImU32 kS_Border     = IM_COL32( 60, 255, 120, 210);
static const ImU32 kS_BorderDim  = IM_COL32( 60, 255, 120,  70);
static const ImU32 kS_Accent     = IM_COL32(  0, 245, 160, 255);
static const ImU32 kS_AmberLite  = IM_COL32(255, 196,  80, 255);
static const ImU32 kS_AmberDeep  = IM_COL32(215, 140,  35, 255);
static const ImU32 kS_Text       = IM_COL32(255, 255, 255, 255);
static const ImU32 kS_TextDim    = IM_COL32(220, 220, 220, 210);
static const ImU32 kS_TextMuted  = IM_COL32(180, 200, 190, 180);
static const ImU32 kS_Card       = IM_COL32( 26,  44,  34, 242);
static const ImU32 kS_CardHover  = IM_COL32( 40,  74,  56, 250);
static const ImU32 kS_CardEdge   = IM_COL32( 90, 140, 110, 160);
static const ImU32 kS_PriceBg    = IM_COL32(  0, 210, 140, 235);
static const ImU32 kS_IconBg     = IM_COL32( 22,  64,  46, 255);
static const ImU32 kS_IconRing   = IM_COL32( 60, 255, 120, 220);
static const ImU32 kS_Danger     = IM_COL32(255,  90,  90, 240);

// --- Small helpers (duplicated from carrentoverlay for isolation) ---
static void StripColors(const char* in, char* out, size_t len)
{
    size_t j = 0;
    for (size_t i = 0; in[i] && j + 1 < len; ++i)
    {
        if (in[i] == '{')
        {
            size_t k = i + 1;
            bool isColor = true;
            int hexCount = 0;
            while (in[k] && in[k] != '}' && (k - i) < 12)
            {
                char c = in[k];
                if (!((c >= '0' && c <= '9') || (c >= 'A' && c <= 'F') || (c >= 'a' && c <= 'f')))
                { isColor = false; break; }
                hexCount++; k++;
            }
            if (isColor && in[k] == '}' && (hexCount == 6 || hexCount == 8))
            {
                i = k;
                continue;
            }
        }
        out[j++] = in[i];
    }
    out[j] = '\0';
}

static int ParseFirstIntRev(const char* s)
{
    // Search for "<num>$" from the end of the string.
    size_t n = strlen(s);
    if (!n) return 0;
    int i = (int)n - 1;
    // Skip trailing whitespace
    while (i >= 0 && (s[i] == ' ' || s[i] == '\t' || s[i] == '\n')) --i;
    // Skip '$'
    if (i >= 0 && s[i] == '$') --i;
    int v = 0, mul = 1;
    bool has = false;
    while (i >= 0 && s[i] >= '0' && s[i] <= '9')
    {
        v += (s[i] - '0') * mul;
        mul *= 10;
        --i;
        has = true;
    }
    return has ? v : 0;
}

// Pick an icon by simple keyword match on the product name.
// Icon indices map to drawing primitives inside RenderItemIcon.
static int ShopIconForName(const char* n)
{
    if (!n) return 0;
    char lc[128]; size_t i = 0;
    for (; n[i] && i + 1 < sizeof(lc); ++i)
        lc[i] = (n[i] >= 'A' && n[i] <= 'Z') ? (char)(n[i] + 32) : n[i];
    lc[i] = '\0';

    if (strstr(lc, "جوال"))      return 1;   // phone handset
    if (strstr(lc, "رقم"))     return 2;   // SIM card
    if (strstr(lc, "دليل") || strstr(lc, "كتاب")) return 3;
    if (strstr(lc, "صحة") || strstr(lc, "إسعاف"))     return 4; // cross
    if (strstr(lc, "تصليح") || strstr(lc, "عدة"))    return 5; // wrench
    if (strstr(lc, "ملاحة") || strstr(lc, "خريطة"))        return 6;
    if (strstr(lc, "قناع"))                            return 7;
    if (strstr(lc, "حبل"))                            return 8;
    if (strstr(lc, "وردة"))                          return 9;
    if (strstr(lc, "كاميرا"))                          return 10;
    if (strstr(lc, "بخاخ") || strstr(lc, "دهان"))    return 11;
    if (strstr(lc, "راديو"))                           return 12;
    if (strstr(lc, "turning"))                         return 5;  // tools
    if (strstr(lc, "مفتاح") || strstr(lc, "سرقة"))     return 15;

    if (strstr(lc, "مشروب") || strstr(lc, "كولا") || strstr(lc, "شراب"))  return 13;
    if (strstr(lc, "بيرة") || strstr(lc, "نبيذ") || strstr(lc, "فودكا")
        || strstr(lc, "كونياك") || strstr(lc, "ويسكي") || strstr(lc, "أفسنتين"))
        return 14;

    return 0; // generic shopping bag
}

// Draws a small stylised icon inside a circular badge centred on (cx,cy) with radius r.
static void RenderItemIcon(ImDrawList* dl, float cx, float cy, float r, int iconIdx)
{
    // Badge background (with subtle inner glow ring)
    dl->AddCircleFilled(ImVec2(cx, cy), r, kS_IconBg, 40);
    dl->AddCircle(ImVec2(cx, cy), r - 2.0f, IM_COL32(60, 255, 120, 60), 40, 2.0f);
    dl->AddCircle(ImVec2(cx, cy), r, kS_IconRing, 40, 3.5f);

    ImU32 stroke = IM_COL32(255, 255, 255, 245);
    float s = r * 0.62f; // icon half-extent (slightly larger for clearer icons)

    switch (iconIdx)
    {
        case 1: // phone
        {
            dl->AddRectFilled(ImVec2(cx - s*0.55f, cy - s),
                              ImVec2(cx + s*0.55f, cy + s),
                              stroke, s*0.22f);
            dl->AddRectFilled(ImVec2(cx - s*0.35f, cy - s*0.70f),
                              ImVec2(cx + s*0.35f, cy + s*0.55f),
                              IM_COL32(12, 30, 22, 255));
            dl->AddCircleFilled(ImVec2(cx, cy + s*0.78f), s*0.12f, stroke);
            break;
        }
        case 2: // SIM card
        {
            ImVec2 p0(cx - s*0.8f, cy - s*0.6f);
            ImVec2 p1(cx + s*0.8f, cy + s*0.6f);
            dl->AddRectFilled(p0, p1, stroke, s*0.15f);
            dl->AddRectFilled(ImVec2(cx - s*0.55f, cy - s*0.35f),
                              ImVec2(cx + s*0.55f, cy + s*0.35f),
                              IM_COL32(22, 64, 46, 255), s*0.08f);
            // corner chip
            dl->AddTriangleFilled(ImVec2(p1.x, p0.y),
                                  ImVec2(p1.x, p0.y + s*0.32f),
                                  ImVec2(p1.x - s*0.32f, p0.y), IM_COL32(22, 64, 46, 255));
            break;
        }
        case 3: // book / directory
        {
            dl->AddRectFilled(ImVec2(cx - s*0.85f, cy - s),
                              ImVec2(cx + s*0.85f, cy + s),
                              stroke, s*0.14f);
            dl->AddLine(ImVec2(cx, cy - s), ImVec2(cx, cy + s), kS_IconBg, 2.0f);
            for (int k = 0; k < 3; ++k)
            {
                float yy = cy - s*0.45f + k * s*0.45f;
                dl->AddLine(ImVec2(cx - s*0.65f, yy), ImVec2(cx - s*0.15f, yy), kS_IconBg, 1.5f);
                dl->AddLine(ImVec2(cx + s*0.15f, yy), ImVec2(cx + s*0.65f, yy), kS_IconBg, 1.5f);
            }
            break;
        }
        case 4: // health / first aid
        {
            dl->AddRectFilled(ImVec2(cx - s, cy - s*0.75f),
                              ImVec2(cx + s, cy + s*0.75f),
                              stroke, s*0.18f);
            ImU32 red = IM_COL32(215, 35, 35, 255);
            dl->AddRectFilled(ImVec2(cx - s*0.18f, cy - s*0.52f),
                              ImVec2(cx + s*0.18f, cy + s*0.52f), red);
            dl->AddRectFilled(ImVec2(cx - s*0.52f, cy - s*0.18f),
                              ImVec2(cx + s*0.52f, cy + s*0.18f), red);
            break;
        }
        case 5: // wrench / tool
        {
            dl->AddLine(ImVec2(cx - s*0.9f, cy + s*0.9f),
                        ImVec2(cx + s*0.4f, cy - s*0.4f), stroke, 5.0f);
            dl->AddCircleFilled(ImVec2(cx + s*0.55f, cy - s*0.55f), s*0.35f, stroke);
            dl->AddCircleFilled(ImVec2(cx + s*0.55f, cy - s*0.55f), s*0.17f, kS_IconBg);
            break;
        }
        case 6: // GPS / map pin
        {
            // Pin teardrop
            for (int k = 0; k < 12; ++k)
            {
                float a = -1.2f + k * 0.22f;
                float rr = s*0.7f;
                dl->AddLine(ImVec2(cx, cy + s*0.9f),
                            ImVec2(cx + cosf(a)*rr, cy - s*0.1f + sinf(a)*rr),
                            stroke, 3.0f);
            }
            dl->AddCircleFilled(ImVec2(cx, cy - s*0.05f), s*0.55f, stroke);
            dl->AddCircleFilled(ImVec2(cx, cy - s*0.05f), s*0.22f, kS_IconBg);
            break;
        }
        case 7: // mask (oval with eye holes)
        {
            dl->AddCircleFilled(ImVec2(cx, cy), s, stroke);
            dl->AddCircleFilled(ImVec2(cx - s*0.35f, cy - s*0.15f), s*0.18f, kS_IconBg);
            dl->AddCircleFilled(ImVec2(cx + s*0.35f, cy - s*0.15f), s*0.18f, kS_IconBg);
            break;
        }
        case 8: // rope (coil)
        {
            for (int k = 0; k < 3; ++k)
            {
                dl->AddCircle(ImVec2(cx, cy - s*0.35f + k*s*0.28f),
                              s*0.5f - k*0.07f, stroke, 24, 2.0f);
            }
            break;
        }
        case 9: // flower
        {
            for (int k = 0; k < 5; ++k)
            {
                float a = k * 1.2566f; // 2*pi/5
                dl->AddCircleFilled(ImVec2(cx + cosf(a)*s*0.55f, cy + sinf(a)*s*0.55f),
                                    s*0.32f, IM_COL32(255, 120, 180, 255));
            }
            dl->AddCircleFilled(ImVec2(cx, cy), s*0.28f, IM_COL32(255, 210, 80, 255));
            break;
        }
        case 10: // camera
        {
            dl->AddRectFilled(ImVec2(cx - s, cy - s*0.55f),
                              ImVec2(cx + s, cy + s*0.75f),
                              stroke, s*0.15f);
            dl->AddCircleFilled(ImVec2(cx, cy + s*0.1f), s*0.45f, kS_IconBg);
            dl->AddCircleFilled(ImVec2(cx, cy + s*0.1f), s*0.26f, stroke);
            dl->AddRectFilled(ImVec2(cx - s*0.25f, cy - s*0.80f),
                              ImVec2(cx + s*0.25f, cy - s*0.55f),
                              stroke, s*0.05f);
            break;
        }
        case 11: // spray can
        {
            dl->AddRectFilled(ImVec2(cx - s*0.45f, cy - s*0.5f),
                              ImVec2(cx + s*0.45f, cy + s*0.95f),
                              stroke, s*0.1f);
            dl->AddRectFilled(ImVec2(cx - s*0.3f, cy - s*0.85f),
                              ImVec2(cx + s*0.3f, cy - s*0.5f),
                              stroke, s*0.08f);
            dl->AddCircleFilled(ImVec2(cx, cy - s*1.0f), s*0.08f, stroke);
            dl->AddCircleFilled(ImVec2(cx + s*0.2f, cy - s*1.05f), s*0.05f, stroke);
            break;
        }
        case 12: // radio
        {
            dl->AddRectFilled(ImVec2(cx - s*0.45f, cy - s*0.2f),
                              ImVec2(cx + s*0.45f, cy + s*0.9f),
                              stroke, s*0.1f);
            dl->AddLine(ImVec2(cx + s*0.25f, cy - s*0.2f),
                        ImVec2(cx + s*0.85f, cy - s*0.95f), stroke, 3.0f);
            dl->AddCircleFilled(ImVec2(cx + s*0.85f, cy - s*0.95f), s*0.1f, stroke);
            break;
        }
        case 13: // soda bottle / cup
        {
            dl->AddRectFilled(ImVec2(cx - s*0.55f, cy - s*0.7f),
                              ImVec2(cx + s*0.55f, cy + s*0.9f),
                              stroke, s*0.1f);
            dl->AddRectFilled(ImVec2(cx - s*0.35f, cy - s*0.9f),
                              ImVec2(cx + s*0.35f, cy - s*0.65f), stroke);
            dl->AddRectFilled(ImVec2(cx - s*0.45f, cy - s*0.4f),
                              ImVec2(cx + s*0.45f, cy + s*0.2f),
                              IM_COL32(215, 30, 30, 255));
            break;
        }
        case 14: // bottle / beer
        {
            dl->AddRectFilled(ImVec2(cx - s*0.25f, cy - s*0.9f),
                              ImVec2(cx + s*0.25f, cy - s*0.35f),
                              stroke, s*0.06f);
            dl->AddRectFilled(ImVec2(cx - s*0.5f, cy - s*0.45f),
                              ImVec2(cx + s*0.5f, cy + s*0.9f),
                              IM_COL32(180, 130, 60, 255), s*0.1f);
            dl->AddRectFilled(ImVec2(cx - s*0.42f, cy - s*0.2f),
                              ImVec2(cx + s*0.42f, cy + s*0.4f),
                              IM_COL32(255, 250, 240, 255));
            break;
        }
        case 15:
        {
            dl->AddCircle(ImVec2(cx - s*0.35f, cy - s*0.10f),
                          s*0.34f, stroke, 32, 4.0f);
            dl->AddCircleFilled(ImVec2(cx - s*0.35f, cy - s*0.10f),
                                s*0.13f, IM_COL32(22, 64, 46, 255), 24);
            dl->AddLine(ImVec2(cx - s*0.02f, cy - s*0.10f),
                        ImVec2(cx + s*0.82f, cy - s*0.10f), stroke, 5.0f);
            dl->AddLine(ImVec2(cx + s*0.44f, cy - s*0.10f),
                        ImVec2(cx + s*0.44f, cy + s*0.28f), stroke, 4.0f);
            dl->AddLine(ImVec2(cx + s*0.66f, cy - s*0.10f),
                        ImVec2(cx + s*0.66f, cy + s*0.18f), stroke, 4.0f);
            dl->AddRectFilled(ImVec2(cx + s*0.70f, cy - s*0.28f),
                              ImVec2(cx + s*0.95f, cy + s*0.08f),
                              stroke, s*0.04f);
            break;
        }
        default: // generic shopping bag
        {
            dl->AddRectFilled(ImVec2(cx - s*0.75f, cy - s*0.55f),
                              ImVec2(cx + s*0.75f, cy + s*0.9f),
                              stroke, s*0.12f);
            // handles
            dl->AddLine(ImVec2(cx - s*0.35f, cy - s*0.55f),
                        ImVec2(cx - s*0.35f, cy - s*0.95f), stroke, 3.0f);
            dl->AddLine(ImVec2(cx + s*0.35f, cy - s*0.55f),
                        ImVec2(cx + s*0.35f, cy - s*0.95f), stroke, 3.0f);
            dl->AddLine(ImVec2(cx - s*0.35f, cy - s*0.95f),
                        ImVec2(cx + s*0.35f, cy - s*0.95f), stroke, 3.0f);
            break;
        }
    }
}

CShop247Overlay::CShop247Overlay()
    : m_state(SHOP247_NONE)
    , m_dialogId(0)
    , m_fAnimT(0.0f)
    , m_fScroll(0.0f)
    , m_fScrollVelocity(0.0f)
    , m_bDragging(false)
    , m_fDragStartY(0.0f)
    , m_fDragStartScroll(0.0f)
    , m_fLastTouchY(0.0f)
    , m_bMovedSinceDown(false)
    , m_bDialogActive(false)
    , m_fDownX(0.0f)
    , m_fDownY(0.0f)
{
}

CShop247Overlay::~CShop247Overlay() {}

void CShop247Overlay::Hide()
{
    if (m_bDialogActive)
    {
        char empty[2] = { 0 };
        CarRent_SendDialogResponse(m_dialogId, 0, 0, empty);
        m_bDialogActive = false;
    }
    m_state = SHOP247_NONE;
    m_items.clear();
    m_fAnimT = 0.0f;
    m_fScroll = 0.0f;
    m_fScrollVelocity = 0.0f;
    m_bDragging = false;
    m_bMovedSinceDown = false;
}

void CShop247Overlay::ParseItems(const char* body)
{
    m_items.clear();
    if (!body) return;

    char clean[2048];
    StripColors(body, clean, sizeof(clean));

    const char* s = clean;
    while (*s)
    {
        const char* lineStart = s;
        while (*s && *s != '\n') s++;
        size_t lineLen = (size_t)(s - lineStart);
        if (*s == '\n') s++;

        // Trim line
        while (lineLen > 0 && (lineStart[lineLen - 1] == ' ' ||
                               lineStart[lineLen - 1] == '\t' ||
                               lineStart[lineLen - 1] == '\r')) --lineLen;
        while (lineLen > 0 && (lineStart[0] == ' ' || lineStart[0] == '\t'))
        { lineStart++; --lineLen; }
        if (lineLen == 0) continue;

        char line[512];
        if (lineLen >= sizeof(line)) lineLen = sizeof(line) - 1;
        memcpy(line, lineStart, lineLen); line[lineLen] = '\0';

        // Strip leading "N. " prefix
        char* cur = line;
        while (*cur == ' ' || *cur == '\t') cur++;
        char* p = cur;
        while (*p >= '0' && *p <= '9') p++;
        if (p != cur && *p == '.') { p++; while (*p == ' ' || *p == '\t') p++; cur = p; }

        // Split name vs price at the last " <digits>$"
        int price = ParseFirstIntRev(cur);
        char priceTxt[32] = "";
        if (price > 0)
        {
            snprintf(priceTxt, sizeof(priceTxt), "$%d", price);
            // Strip the " <num>$" tail from the name
            size_t L = strlen(cur);
            int i = (int)L - 1;
            while (i >= 0 && (cur[i] == ' ' || cur[i] == '\t' || cur[i] == '\n')) --i;
            if (i >= 0 && cur[i] == '$') --i;
            while (i >= 0 && cur[i] >= '0' && cur[i] <= '9') --i;
            while (i >= 0 && (cur[i] == ' ' || cur[i] == '\t')) --i;
            if (i + 1 < (int)L) cur[i + 1] = '\0';
        }

        Shop247Item it;
        it.name = cur;
        it.priceText = priceTxt;
        it.priceInt = price;
        it.iconIdx = ShopIconForName(cur);
        m_items.push_back(it);
    }
}

bool CShop247Overlay::TryHandleDialog(uint16_t dialogId, uint8_t /*style*/,
                                     const char* title, const char* body)
{
    if (!title) return false;
    char tclean[128];
    StripColors(title, tclean, sizeof(tclean));
    // Trim
    char* t = tclean;
    while (*t == ' ') t++;

    if (!(strstr(t, "بقالة 24/7") != nullptr || strstr(t, "24/7") != nullptr))
        return false;

    m_state = SHOP247_ITEMS;
    m_dialogId = dialogId;
    m_fAnimT = 0.0f;
    m_fScroll = 0.0f;
    m_fScrollVelocity = 0.0f;
    m_bDragging = false;
    m_bMovedSinceDown = false;
    m_bDialogActive = true;
    ParseItems(body);
    return true;
}

void CShop247Overlay::SendPick(int listitem)
{
    char empty[2] = { 0 };
    CarRent_SendDialogResponse(m_dialogId, 1, (uint16_t)listitem, empty);
    m_bDialogActive = false;
    Hide();
}

void CShop247Overlay::Render()
{
    if (m_state == SHOP247_NONE) return;

    ImGuiIO& io = ImGui::GetIO();
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    if (!dl) return;

    // --- Animate in ---
    if (m_fAnimT < 1.0f)
    {
        m_fAnimT += io.DeltaTime * 4.0f;
        if (m_fAnimT > 1.0f) m_fAnimT = 1.0f;
    }
    float ease = 1.0f - (1.0f - m_fAnimT) * (1.0f - m_fAnimT);

    float scale = io.DisplaySize.y / 1080.0f;
    if (scale < 0.5f) scale = 0.5f;

    float panelW = io.DisplaySize.x * 0.92f;
    float panelH = io.DisplaySize.y * 0.94f;
    if (panelW > 1600.0f * scale) panelW = 1600.0f * scale;
    if (panelH > 1000.0f * scale) panelH = 1000.0f * scale;

    float panelX = (io.DisplaySize.x - panelW) * 0.5f;
    float panelY = (io.DisplaySize.y - panelH) * 0.5f;
    panelY -= (1.0f - ease) * 40.0f * scale;

    ImVec2 pMin(panelX, panelY);
    ImVec2 pMax(panelX + panelW, panelY + panelH);
    float rounding = 18.0f * scale;

    // Backdrop dimmer
    dl->AddRectFilled(ImVec2(0, 0), io.DisplaySize,
                      IM_COL32(0, 0, 0, (int)(140 * ease)));

    // Outer glow
    for (int k = 0; k < 6; ++k)
    {
        float o = (k + 1) * 2.0f * scale;
        dl->AddRect(ImVec2(pMin.x - o, pMin.y - o),
                    ImVec2(pMax.x + o, pMax.y + o),
                    IM_COL32(60, 255, 120, (int)(32 * ease) - k * 4 > 0 ? 32 * ease - k * 4 : 0),
                    rounding + o, 0, 1.5f);
    }

    // Panel body (soft vertical gradient)
    dl->AddRectFilledMultiColor(pMin, pMax,
        IM_COL32( 28,  46,  36, (int)(250 * ease)),
        IM_COL32( 28,  46,  36, (int)(250 * ease)),
        IM_COL32( 14,  26,  20, (int)(250 * ease)),
        IM_COL32( 14,  26,  20, (int)(250 * ease))
    );
    dl->AddRect(pMin, pMax, kS_Border, rounding, 0, 2.0f * scale);

    // --- Header ---
    float headerH = 168.0f * scale;
    ImVec2 hMax(pMax.x, pMin.y + headerH);
    dl->AddRectFilledMultiColor(pMin, hMax,
        IM_COL32(17, 156, 69, 230),
        IM_COL32( 0, 210, 140, 230),
        IM_COL32( 0, 150,  80, 230),
        IM_COL32(20, 120,  64, 230));
    dl->AddLine(ImVec2(pMin.x, hMax.y), ImVec2(pMax.x, hMax.y),
                kS_Accent, 2.5f * scale);

    // Cart icon in header (top-left)
    {
        float iconX = pMin.x + 36.0f * scale;
        float iconY = pMin.y + 42.0f * scale;
        float iS = 80.0f * scale;

        // cart body
        ImU32 ic = IM_COL32(255, 255, 255, 235);
        dl->AddRectFilled(ImVec2(iconX, iconY + iS * 0.25f),
                          ImVec2(iconX + iS, iconY + iS * 0.85f),
                          ic, iS * 0.08f);
        dl->AddRectFilled(ImVec2(iconX - iS*0.15f, iconY + iS*0.05f),
                          ImVec2(iconX + iS*0.1f,  iconY + iS*0.2f),
                          ic, iS * 0.04f);
        // wheels
        dl->AddCircleFilled(ImVec2(iconX + iS*0.2f, iconY + iS*0.95f), iS*0.11f, ic);
        dl->AddCircleFilled(ImVec2(iconX + iS*0.8f, iconY + iS*0.95f), iS*0.11f, ic);
        // dark slats
        for (int k = 0; k < 3; ++k)
        {
            float xx = iconX + iS*0.12f + k * iS*0.28f;
            dl->AddLine(ImVec2(xx, iconY + iS*0.3f),
                        ImVec2(xx, iconY + iS*0.78f),
                        IM_COL32(17, 90, 50, 255), 2.0f);
        }
    }

    ImFont* font = pGUI ? pGUI->GetFont() : nullptr;
    // Title + subtitle
    if (font)
    {
        const char* t1 = "بقالة 24/7";
        const char* t2 = "اضغط على منتج للشراء";

        AddShapedText(dl, font, 56.0f * scale,
                      ImVec2(pMin.x + 140.0f * scale, pMin.y + 22.0f * scale),
                      kS_Text, t1);
        AddShapedText(dl, font, 30.0f * scale,
                      ImVec2(pMin.x + 140.0f * scale, pMin.y + 96.0f * scale),
                      kS_TextDim, t2);

        // Item count pill on the right
        char cb[48];
        snprintf(cb, sizeof(cb), "%d منتج", (int)m_items.size());
        float fs = 30.0f * scale;
        std::string cbText = ShapeText(cb);
        ImVec2 tsz = CalcShapedTextSize(font, fs, cbText);
        float padX = 16.0f * scale, padY = 10.0f * scale;
        ImVec2 pillMax(pMax.x - 90.0f * scale, pMin.y + 50.0f * scale + tsz.y);
        ImVec2 pillMin(pillMax.x - tsz.x - padX * 2.0f, pillMax.y - tsz.y - padY * 2.0f);
        dl->AddRectFilled(pillMin, pillMax, IM_COL32(10, 40, 22, 220), 14.0f * scale);
        dl->AddRect(pillMin, pillMax, kS_Accent, 14.0f * scale, 0, 1.6f);
        dl->AddText(font, fs,
                    ImVec2(pillMin.x + padX, pillMin.y + padY),
                    kS_Accent, cbText.c_str());
    }

    // --- Close button (X) ---
    float closeR = 26.0f * scale;
    ImVec2 closeC(pMax.x - closeR - 22.0f * scale, pMin.y + closeR + 22.0f * scale);
    bool closeHover = ((io.MousePos.x - closeC.x) * (io.MousePos.x - closeC.x) +
                      (io.MousePos.y - closeC.y) * (io.MousePos.y - closeC.y))
                      <= closeR * closeR;
    dl->AddCircleFilled(closeC, closeR, closeHover ? kS_Danger : IM_COL32(20, 40, 30, 240));
    dl->AddCircle(closeC, closeR, kS_Border, 32, 1.8f);
    dl->AddLine(ImVec2(closeC.x - 10.0f * scale, closeC.y - 10.0f * scale),
                ImVec2(closeC.x + 10.0f * scale, closeC.y + 10.0f * scale),
                kS_Text, 2.8f);
    dl->AddLine(ImVec2(closeC.x + 10.0f * scale, closeC.y - 10.0f * scale),
                ImVec2(closeC.x - 10.0f * scale, closeC.y + 10.0f * scale),
                kS_Text, 2.8f);

    // --- Edge-detected input ---
    const float kTapSlop = 10.0f;
    static bool s_prevDown = false;
    bool down     = io.MouseDown[0];
    bool pressed  = (down && !s_prevDown);
    bool released = (!down && s_prevDown);
    s_prevDown = down;

    if (pressed)
    {
        m_fDownX = io.MousePos.x;
        m_fDownY = io.MousePos.y;
        m_bMovedSinceDown = false;
    }
    else if (down)
    {
        float dx = io.MousePos.x - m_fDownX;
        float dy = io.MousePos.y - m_fDownY;
        if (dx * dx + dy * dy > kTapSlop * kTapSlop)
            m_bMovedSinceDown = true;
    }

    // Close button: fire on tap (released with no movement) if press started on X
    {
        float dx0 = m_fDownX - closeC.x;
        float dy0 = m_fDownY - closeC.y;
        bool downOnClose = (dx0 * dx0 + dy0 * dy0 <=
                            (closeR + 10.0f * scale) * (closeR + 10.0f * scale));
        if (released && !m_bMovedSinceDown && downOnClose)
        {
            Hide();
            return;
        }
    }

    // --- Grid of product cards ---
    float contentTop = pMin.y + headerH + 16.0f * scale;
    float contentBot = pMax.y - 52.0f * scale;
    float areaH     = contentBot - contentTop;

    // 2-column grid
    const int   cols    = 2;
    float       gridW   = panelW - 80.0f * scale;   // leave scrollbar room
    float       cardW   = (gridW - (cols - 1) * 22.0f * scale) / (float)cols;
    float       cardH   = 190.0f * scale;
    float       gapX    = 22.0f * scale;
    float       gapY    = 22.0f * scale;

    int rows = ((int)m_items.size() + cols - 1) / cols;
    float totalH = rows * (cardH + gapY);
    float maxScroll = (totalH > areaH) ? (totalH - areaH) : 0.0f;

    // Scroll input
    if (io.MouseWheel != 0.0f)
    {
        m_fScroll -= io.MouseWheel * 80.0f * scale;
        m_fScrollVelocity = 0.0f;
    }

    bool ptrInContent = io.MousePos.x >= pMin.x + 20.0f * scale &&
                        io.MousePos.x <= pMax.x - 20.0f * scale &&
                        io.MousePos.y >= contentTop &&
                        io.MousePos.y <= contentBot;

    if (pressed && ptrInContent)
    {
        m_bDragging = true;
        m_fDragStartY = io.MousePos.y;
        m_fDragStartScroll = m_fScroll;
        m_fLastTouchY = io.MousePos.y;
        m_fScrollVelocity = 0.0f;
    }
    else if (down && m_bDragging)
    {
        float dy = io.MousePos.y - m_fDragStartY;
        m_fScroll = m_fDragStartScroll - dy;
        if (io.DeltaTime > 0.0f)
            m_fScrollVelocity = -(io.MousePos.y - m_fLastTouchY) / io.DeltaTime;
        m_fLastTouchY = io.MousePos.y;
    }
    else if (released)
    {
        m_bDragging = false;
    }
    else if (!down && fabsf(m_fScrollVelocity) > 1.0f)
    {
        m_fScroll += m_fScrollVelocity * io.DeltaTime;
        m_fScrollVelocity *= 0.90f;
    }

    if (m_fScroll < 0.0f)         m_fScroll = 0.0f;
    if (m_fScroll > maxScroll)    m_fScroll = maxScroll;

    // Clip
    dl->PushClipRect(ImVec2(pMin.x, contentTop),
                     ImVec2(pMax.x, contentBot), true);

    float x0 = pMin.x + 30.0f * scale;
    int tappedIdx = -1;

    for (size_t i = 0; i < m_items.size(); ++i)
    {
        int col = (int)i % cols;
        int row = (int)i / cols;
        float cx = x0 + col * (cardW + gapX);
        float cy = contentTop + row * (cardH + gapY) - m_fScroll;

        // Skip fully off-screen
        if (cy > contentBot) break;
        if (cy + cardH < contentTop) continue;

        ImVec2 cMin(cx, cy);
        ImVec2 cMax(cx + cardW, cy + cardH);

        bool hover = (io.MousePos.x >= cMin.x && io.MousePos.x <= cMax.x &&
                      io.MousePos.y >= cMin.y && io.MousePos.y <= cMax.y &&
                      !m_bMovedSinceDown && !m_bDragging);

        // Card body
        dl->AddRectFilled(cMin, cMax, hover ? kS_CardHover : kS_Card, 16.0f * scale);
        dl->AddRect(cMin, cMax, hover ? kS_Border : kS_CardEdge, 16.0f * scale, 0, hover ? 2.0f : 1.3f);

        // Left accent bar when hovered
        if (hover)
            dl->AddRectFilled(cMin, ImVec2(cMin.x + 5.0f * scale, cMax.y),
                              kS_Accent, 16.0f * scale);

        // Icon
        float iconR = cardH * 0.34f;
        float iconCx = cMin.x + iconR + 18.0f * scale;
        float iconCy = (cMin.y + cMax.y) * 0.5f;
        RenderItemIcon(dl, iconCx, iconCy, iconR, m_items[i].iconIdx);

        // Name + price
        if (font)
        {
            // Name
            AddShapedText(dl, font, 36.0f * scale,
                          ImVec2(iconCx + iconR + 18.0f * scale, cMin.y + 24.0f * scale),
                          kS_Text, m_items[i].name.c_str());

            // "Tap to buy" hint
            AddShapedText(dl, font, 22.0f * scale,
                          ImVec2(iconCx + iconR + 18.0f * scale, cMin.y + 78.0f * scale),
                          kS_TextMuted, "اضغط للشراء");

            // Price pill
            const char* ptxt = m_items[i].priceText.c_str();
            if (ptxt && *ptxt)
            {
                float fs = 34.0f * scale;
                std::string priceText = ShapeText(ptxt);
                ImVec2 tsz = CalcShapedTextSize(font, fs, priceText);
                float padX = 14.0f * scale, padY = 8.0f * scale;
                ImVec2 pillMax(cMax.x - 14.0f * scale, cMax.y - 14.0f * scale);
                ImVec2 pillMin(pillMax.x - tsz.x - padX * 2.0f,
                               pillMax.y - tsz.y - padY * 2.0f);
                dl->AddRectFilled(pillMin, pillMax, kS_PriceBg, 12.0f * scale);
                dl->AddRect(pillMin, pillMax, kS_Accent, 12.0f * scale, 0, 1.5f);
                dl->AddText(font, fs,
                            ImVec2(pillMin.x + padX, pillMin.y + padY),
                            IM_COL32(6, 32, 20, 255), priceText.c_str());
            }
        }

        // Tap detection
        if (released && !m_bMovedSinceDown &&
            m_fDownX >= cMin.x && m_fDownX <= cMax.x &&
            m_fDownY >= cMin.y && m_fDownY <= cMax.y &&
            io.MousePos.x >= cMin.x && io.MousePos.x <= cMax.x &&
            io.MousePos.y >= cMin.y && io.MousePos.y <= cMax.y)
        {
            tappedIdx = (int)i;
        }
    }

    dl->PopClipRect();

    // Scrollbar
    if (maxScroll > 0.0f)
    {
        float trackX = pMax.x - 18.0f * scale;
        float trackY = contentTop + 4.0f * scale;
        float trackH = areaH - 8.0f * scale;
        float trackW = 6.0f * scale;

        dl->AddRectFilled(ImVec2(trackX, trackY),
                          ImVec2(trackX + trackW, trackY + trackH),
                          IM_COL32(60, 80, 70, 120), trackW * 0.5f);

        float thumbH = trackH * (areaH / totalH);
        if (thumbH < 24.0f * scale) thumbH = 24.0f * scale;
        float thumbY = trackY + (trackH - thumbH) * (m_fScroll / maxScroll);
        dl->AddRectFilled(ImVec2(trackX, thumbY),
                          ImVec2(trackX + trackW, thumbY + thumbH),
                          kS_Accent, trackW * 0.5f);
    }

    // Footer hint
    if (font)
    {
        const char* hint = (maxScroll > 0.0f)
            ? "اسحب لأعلى أو لأسفل لعرض المزيد من المنتجات"
            : "اضغط X لإغلاق المتجر";
        float fs = 26.0f * scale;
        std::string hintText = ShapeText(hint);
        ImVec2 tsz = CalcShapedTextSize(font, fs, hintText);
        dl->AddText(font, fs,
            ImVec2(pMin.x + (panelW - tsz.x) * 0.5f,
                   pMax.y - fs - 14.0f * scale),
            kS_TextMuted, hintText.c_str());
    }

    // Apply tap AFTER drawing so we don't skip a frame
    if (tappedIdx >= 0)
        SendPick(tappedIdx);
}
