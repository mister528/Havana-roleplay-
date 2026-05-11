#include "../main.h"
#include "../game/game.h"
#include "../net/netgame.h"
#include "../net/textdrawpool.h"
#include "../game/textdraw.h"
#include "skinshopoverlay.h"
#include "gui.h"
#include "../vendor/imgui/imgui.h"
#include "../vendor/imgui/imgui_internal.h"

#include <cstdio>
#include <cstring>
#include <cctype>
#include <cstdlib>
#include <cmath>
#include "../arabic.h"

CSkinShopOverlay* pSkinShopOverlay = nullptr;

extern CGUI* pGUI;

// Bridge: read the local player ped's current skin id (matches
// inventoryoverlay's call into netrpc.cpp).
extern int Inv_GetLocalSkinId();

// =====================================================================
// Brand palette (kept in sync with the inventory / bank / shop247 overlays)
// =====================================================================
static const ImU32 kSColPanelTop  = IM_COL32(18,  36,  28,  240);
static const ImU32 kSColPanelBot  = IM_COL32( 9,  18,  14,  250);
static const ImU32 kSColBorder    = IM_COL32(60, 255, 120, 220);
static const ImU32 kSColBorderDim = IM_COL32(60, 255, 120,  90);
static const ImU32 kSColAccent    = IM_COL32( 0, 245, 160, 255);
static const ImU32 kSColGreen     = IM_COL32(60, 255, 120, 255);
static const ImU32 kSColGreenDeep = IM_COL32(17, 156,  69, 255);
static const ImU32 kSColRed       = IM_COL32(240, 80,  80, 255);
static const ImU32 kSColOrange    = IM_COL32(255,165,  60, 255);
static const ImU32 kSColBlue      = IM_COL32( 30,180, 255, 255);
static const ImU32 kSColText      = IM_COL32(255,255,255, 255);
static const ImU32 kSColTextDim   = IM_COL32(210,232,222, 220);
static const ImU32 kSColTextMuted = IM_COL32(170,196,186, 200);
static const ImU32 kSColCardBg    = IM_COL32(20,  38,  30, 235);
static const ImU32 kSColCardBgHi  = IM_COL32(28,  52,  40, 240);
static const ImU32 kSColShadow    = IM_COL32( 0,   0,   0, 160);

// =====================================================================
// Hidden-textdraw bridge consumed by CTextDrawPool::Draw to suppress the
// gamemode's tiny native buttons while our overlay owns them.
// =====================================================================
bool SkinShop_IsTextdrawHidden(int td_id)
{
    if (!pSkinShopOverlay) return false;
    return pSkinShopOverlay->IsTextdrawHidden(td_id);
}

// =====================================================================
// Construction / reset
// =====================================================================
CSkinShopOverlay::CSkinShopOverlay()
    : m_prevId(-1), m_nextId(-1), m_buyId(-1), m_exitId(-1)
    , m_prevClickId(-1), m_nextClickId(-1), m_buyClickId(-1), m_exitClickId(-1)
    , m_priceTdId(-1), m_otherCount(0)
    , m_bVisible(false), m_fAnimT(0.0f)
    , m_lastDispatchTime(0.0f), m_lastDispatchTd(-1)
{
    m_szPrice[0] = '\0';
    for (int i = 0; i < 24; ++i) m_otherIds[i] = -1;
    for (int i = 0; i < 8;  ++i) m_btnWasDown[i] = false;
}

CSkinShopOverlay::~CSkinShopOverlay() {}

void CSkinShopOverlay::ResetCaptured()
{
    m_prevId = m_nextId = m_buyId = m_exitId = m_priceTdId = -1;
    m_prevClickId = m_nextClickId = m_buyClickId = m_exitClickId = -1;
    m_otherCount = 0;
    m_szPrice[0] = '\0';
}

bool CSkinShopOverlay::IsTextdrawHidden(int td_id) const
{
    if (!m_bVisible) return false;
    if (td_id == m_prevId || td_id == m_nextId
     || td_id == m_buyId  || td_id == m_exitId
     || td_id == m_priceTdId) return true;
    // Also hide the invisible click areas (LD_SPAC:white) so they don't
    // bleed through. They're invisible by design but suppressing them
    // also blocks the native textdraw hit-tester from consuming taps.
    if (td_id == m_prevClickId || td_id == m_nextClickId
     || td_id == m_buyClickId  || td_id == m_exitClickId) return true;
    for (int i = 0; i < m_otherCount; ++i)
        if (m_otherIds[i] == td_id) return true;
    return false;
}

// =====================================================================
// Text matchers
// =====================================================================
static void StripCC_(const char* in, char* out, size_t outSz)
{
    if (!in || !out || outSz == 0) return;
    size_t j = 0;
    while (*in && j + 1 < outSz)
    {
        if (in[0] == '~' && in[1])
        {
            // SAMP textdraw color code  ~r~ ~g~ ~b~ ~y~ ~p~ ~w~ ~l~ ~h~ ~n~
            // skip "~X~" (or "~X~" with X being 1 char)
            const char* p = in + 1;
            while (*p && *p != '~') ++p;
            if (*p == '~') in = p + 1; else { ++in; }
            continue;
        }
        out[j++] = *in++;
    }
    out[j] = '\0';
}

static void TrimAndUpper_(char* s)
{
    if (!s) return;
    // ltrim
    char* p = s;
    while (*p == ' ' || *p == '\t') ++p;
    if (p != s) memmove(s, p, strlen(p) + 1);
    // rtrim
    size_t len = strlen(s);
    while (len > 0 && (s[len-1] == ' ' || s[len-1] == '\t' || s[len-1] == '\n'))
        s[--len] = '\0';
    // upper
    for (char* q = s; *q; ++q) *q = (char)toupper((unsigned char)*q);
}

bool CSkinShopOverlay::MatchSelect(const char* t) const
{
    if (!t) return false;
    char b[64];
    StripCC_(t, b, sizeof(b));
    TrimAndUpper_(b);
    return strcmp(b, "اختيار") == 0;
}
bool CSkinShopOverlay::MatchExit(const char* t) const
{
    if (!t) return false;
    char b[64];
    StripCC_(t, b, sizeof(b));
    TrimAndUpper_(b);
    return strcmp(b, "خروج") == 0 || strcmp(b, "إغلاق") == 0;
}
bool CSkinShopOverlay::MatchLeft(const char* t) const
{
    if (!t) return false;
    char b[64];
    StripCC_(t, b, sizeof(b));
    TrimAndUpper_(b);
    // Common variants used by GTA:SA TXD sprites and ASCII fallbacks.
    if (strstr(b, "LD_BEAT:LEFT")) return true;
    if (strstr(b, "LD_PAN_:LEFT")) return true;
    if (strstr(b, "HUD:RADAR_LEFT")) return true;
    // ASCII arrow-ish characters
    if (strchr(b, '<')) return true;
    return false;
}
bool CSkinShopOverlay::MatchRight(const char* t) const
{
    if (!t) return false;
    char b[64];
    StripCC_(t, b, sizeof(b));
    TrimAndUpper_(b);
    if (strstr(b, "LD_BEAT:RIGHT")) return true;
    if (strstr(b, "LD_PAN_:RIGHT")) return true;
    if (strstr(b, "HUD:RADAR_RIGHT")) return true;
    if (strchr(b, '>')) return true;
    return false;
}
bool CSkinShopOverlay::LooksLikePriceBanner(const char* t) const
{
    // Price textdraws are formatted "<digits>$" or "$<digits>" by the
    // gamemode. We never *need* this (the player textdraw renders the
    // price separately) but we use it as an extra signal that the shop
    // is currently visible.
    if (!t) return false;
    if (strchr(t, '$') == nullptr) return false;
    int digits = 0;
    for (const char* p = t; *p; ++p) if (isdigit((unsigned char)*p)) ++digits;
    return digits >= 1;
}

// =====================================================================
// Detection — runs every frame.
// =====================================================================
extern CNetGame* pNetGame;

void CSkinShopOverlay::DetectFromPool()
{
    ResetCaptured();

    if (!pNetGame) { m_bVisible = false; return; }
    CTextDrawPool* pool = pNetGame->GetTextDrawPool();
    if (!pool) { m_bVisible = false; return; }

    // Collect textdraws of interest.
    int select_id = -1, exit_id = -1;
    int leftCandidates[8];  int leftCount = 0;
    int rightCandidates[8]; int rightCount = 0;
    int priceCandidates[8]; int priceCount = 0;

    // Iterate the pool. MAX_TEXT_DRAWS is 3072 — single-pass scan is cheap
    // (~10us on a phone) and only fires while shopping.
    for (int i = 0; i < 3072; ++i)
    {
        if (!pool->IsSlotUsed((uint16_t)i)) continue;
        CTextDraw* td = pool->GetAt((uint16_t)i);
        if (!td) continue;
        const char* txt = td->GetText();
        if (!txt) continue;

        if (MatchSelect(txt))      select_id = i;
        else if (MatchExit(txt))   exit_id   = i;
        else if (MatchLeft(txt))   { if (leftCount  < 8) leftCandidates[leftCount++]   = i; }
        else if (MatchRight(txt))  { if (rightCount < 8) rightCandidates[rightCount++] = i; }
        else if (LooksLikePriceBanner(txt))
                                   { if (priceCount < 8) priceCandidates[priceCount++] = i; }
    }

    // Both SELECT *and* EXIT must be present for us to claim it's a shop.
    if (select_id < 0 || exit_id < 0)
    {
        m_bVisible = false;
        return;
    }

    // Pick the prev/next arrows that are spatially closest to the
    // SELECT button (some gamemodes have multiple < > sprites for other
    // unrelated UIs, e.g. radio).  Use textdraw position as the metric.
    CTextDraw* selTd = pool->GetAt((uint16_t)select_id);
    if (!selTd) { m_bVisible = false; return; }
    float sx = selTd->m_TextDrawData.fX;
    float sy = selTd->m_TextDrawData.fY;

    auto nearestTo = [&](int* arr, int n) -> int {
        int best = -1; float bestD = 1e9f;
        for (int i = 0; i < n; ++i)
        {
            CTextDraw* t = pool->GetAt((uint16_t)arr[i]);
            if (!t) continue;
            float dx = t->m_TextDrawData.fX - sx;
            float dy = t->m_TextDrawData.fY - sy;
            // Same row: prefer small |dy|.
            float d = fabsf(dy) * 4.0f + fabsf(dx);
            if (d < bestD) { bestD = d; best = arr[i]; }
        }
        return best;
    };

    m_prevId = nearestTo(leftCandidates,  leftCount);
    m_nextId = nearestTo(rightCandidates, rightCount);
    m_buyId  = select_id;
    m_exitId = exit_id;

    // Prefer a price textdraw close to SELECT's column; if none qualifies,
    // still hide the closest one so our overlay is the single source of
    // truth.
    if (priceCount > 0)
    {
        m_priceTdId = nearestTo(priceCandidates, priceCount);
        if (m_priceTdId >= 0)
        {
            CTextDraw* pt = pool->GetAt((uint16_t)m_priceTdId);
            if (pt)
            {
                char clean[32];
                StripCC_(pt->GetText(), clean, sizeof(clean));
                strncpy(m_szPrice, clean, sizeof(m_szPrice) - 1);
                m_szPrice[sizeof(m_szPrice) - 1] = '\0';
            }
        }
    }

    m_bVisible = (m_prevId >= 0 && m_nextId >= 0);

    // If we still couldn't find both arrows but SELECT+EXIT are there,
    // we're probably in some related shop variant; fall back to showing
    // the panel without arrow buttons rather than displaying nothing.
    if (!m_bVisible && select_id >= 0 && exit_id >= 0) m_bVisible = true;

    // -----------------------------------------------------------------
    // Resolve the SELECTABLE click-area ids.
    //
    // The HavanaRp gamemode lays out the skin shop as 19 textdraws
    // (`td_skinshop[0..18]`). Visible labels live at offsets 4 (SELECT),
    // 5 (◄), 6 (►) and 15 (EXIT). The actual click hit-areas are
    // *invisible* `LD_SPAC:white` textdraws at offsets 1 (BUY), 2 (NEXT),
    // 3 (PREV) and 13 (EXIT).  The server's OnPlayerClickTextDraw only
    // checks against the selectable offsets — so we must dispatch those
    // ids when buttons are tapped, never the visible-label ids.
    //
    // Since the array is created sequentially, knowing any one offset's
    // textdraw id lets us derive the rest by simple arithmetic.
    // -----------------------------------------------------------------
    m_buyClickId = m_nextClickId = m_prevClickId = m_exitClickId = -1;
    if (m_buyId >= 0)
    {
        const int base = m_buyId - 4;          // td_skinshop[0]
        if (base >= 0)
        {
            const int wantBuy  = base + 1;
            const int wantNext = base + 2;
            const int wantPrev = base + 3;
            const int wantExit = base + 13;

            // Validate: each computed slot must be a real, *selectable*
            // textdraw — otherwise the layout assumption is wrong and we
            // skip the override (clicks will then go to the decoration
            // ids, same as v8/v9 behaviour).
            auto isSelectable = [&pool](int id) -> bool {
                if (id < 0 || id >= MAX_TEXT_DRAWS) return false;
                if (!pool->IsSlotUsed((uint16_t)id)) return false;
                CTextDraw* t = pool->GetAt((uint16_t)id);
                return t && t->m_TextDrawData.byteSelectable;
            };

            if (isSelectable(wantBuy)  &&
                isSelectable(wantNext) &&
                isSelectable(wantPrev) &&
                isSelectable(wantExit))
            {
                m_buyClickId  = wantBuy;
                m_nextClickId = wantNext;
                m_prevClickId = wantPrev;
                m_exitClickId = wantExit;
            }
        }
    }

    // Log captured ids ONCE per visibility transition.
    static bool s_wasVisible = false;
    if (m_bVisible && !s_wasVisible)
    {
        Log("[SKINSHOP] visible: deco prev=%d next=%d buy=%d exit=%d  "
            "click prev=%d next=%d buy=%d exit=%d  price=%d '%s'",
            m_prevId, m_nextId, m_buyId, m_exitId,
            m_prevClickId, m_nextClickId, m_buyClickId, m_exitClickId,
            m_priceTdId, m_szPrice);
    }
    s_wasVisible = m_bVisible;
}

// =====================================================================
// Drawing helpers
// =====================================================================
static ImFont* GetUIFont_()
{
    ImGuiIO& io = ImGui::GetIO();
    if (io.Fonts && io.Fonts->Fonts.Size > 0) return io.Fonts->Fonts[0];
    return nullptr;
}

static void DrawShadowedText_(ImDrawList* dl, ImFont* font, float fs,
                              ImVec2 pos, ImU32 col, const char* txt)
{
    if (!txt || !*txt) return;
    if (!font) font = GetUIFont_();
    std::string shaped = Arabic::ContainsArabic(txt) ? Arabic::Shape(txt) : std::string(txt);
    const char* p = shaped.c_str();
    dl->AddText(font, fs, ImVec2(pos.x + 2.0f, pos.y + 2.0f),
                IM_COL32(0,0,0,200), p);
    dl->AddText(font, fs, pos, col, p);
}

static bool TouchInRect_(ImVec2 a, ImVec2 b)
{
    ImGuiIO& io = ImGui::GetIO();
    if (!ImGui::IsMouseClicked(0)) return false;
    ImVec2 m = io.MousePos;
    return m.x >= a.x && m.x <= b.x && m.y >= a.y && m.y <= b.y;
}

void CSkinShopOverlay::DrawButton(ImDrawList* dl, ImVec2 c, float w, float h,
                                  ImU32 col, ImU32 colHov, ImU32 colTxt,
                                  const char* label, int touchId, int textdrawId,
                                  bool primary)
{
    (void)touchId;

    ImVec2 a(c.x - w * 0.5f, c.y - h * 0.5f);
    ImVec2 b(c.x + w * 0.5f, c.y + h * 0.5f);

    ImGuiIO& io = ImGui::GetIO();
    bool hover = io.MousePos.x >= a.x && io.MousePos.x <= b.x
              && io.MousePos.y >= a.y && io.MousePos.y <= b.y;
    bool pressed = hover && io.MouseDown[0];

    float r = h * 0.22f;

    // Outer glow for the primary action so the user can find it instantly.
    if (primary)
    {
        for (int i = 0; i < 6; ++i)
        {
            float t = i / 6.0f;
            dl->AddRect(
                ImVec2(a.x - i * 1.5f, a.y - i * 1.5f),
                ImVec2(b.x + i * 1.5f, b.y + i * 1.5f),
                IM_COL32(60, 255, 120, (int)((1.0f - t) * 50)),
                r + i * 1.5f, 0, 2.0f);
        }
    }

    dl->AddRectFilled(a, b, pressed ? colHov : col, r);
    dl->AddRect      (a, b, kSColBorder, r, 0, primary ? 3.5f : 2.5f);

    ImFont* font = GetUIFont_();
    float fs = h * 0.42f;
    float tw = 0.0f;
    std::string labelSh = Arabic::ContainsArabic(label) ? Arabic::Shape(label) : std::string(label);
    const char* lp = labelSh.c_str();
    if (font)
    {
        ImVec2 sz = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, lp);
        tw = sz.x;
    }
    DrawShadowedText_(dl, font, fs,
        ImVec2(c.x - tw * 0.5f, c.y - fs * 0.55f), colTxt, lp);

    // Tap dispatch — match the pattern used by inventoryoverlay /
    // bankoverlay (rising edge of MouseDown[0] inside the rect).
    // Throttle to 1 dispatch / 250ms per textdraw so a brief press
    // doesn't fire twice.
    if (textdrawId < 0 || !pGUI) return;

    bool down = io.MouseDown[0] && hover;
    bool clickEdge = down && !m_btnWasDown[touchId];
    m_btnWasDown[touchId] = down;

    if (clickEdge)
    {
        float now = (float)ImGui::GetTime();
        if (textdrawId != m_lastDispatchTd ||
            now - m_lastDispatchTime > 0.25f)
        {
            Log("[SKINSHOP] dispatch td_id=%d (label=%s)",
                textdrawId, label ? label : "");
            pGUI->PushToBufferedQueueTextDrawPressed((uint16_t)textdrawId);
            m_lastDispatchTd   = textdrawId;
            m_lastDispatchTime = now;
        }
    }
}

// =====================================================================
// Render
// =====================================================================
void CSkinShopOverlay::Render()
{
    DetectFromPool();
    if (!m_bVisible) { m_fAnimT = 0.0f; return; }

    ImGuiIO& io = ImGui::GetIO();

    // Animate intro
    if (m_fAnimT < 1.0f)
    {
        m_fAnimT += io.DeltaTime / 0.20f;
        if (m_fAnimT > 1.0f) m_fAnimT = 1.0f;
    }
    float ease = 1.0f - (1.0f - m_fAnimT) * (1.0f - m_fAnimT);

    float scale = io.DisplaySize.y / 1080.0f;

    // Bottom-anchored panel: ~80% width, ~28% height. Sits above the
    // bottom of the screen (well clear of the 24/7 button column).
    float panelW = io.DisplaySize.x * 0.78f;
    float panelH = 360.0f * scale;
    if (panelH > io.DisplaySize.y * 0.42f) panelH = io.DisplaySize.y * 0.42f;

    float panelX = (io.DisplaySize.x - panelW) * 0.5f;
    float panelY = io.DisplaySize.y - panelH - 20.0f * scale;
    panelY += (1.0f - ease) * 30.0f * scale;     // slide-up

    ImDrawList* dl = ImGui::GetOverlayDrawList();

    // Panel body
    ImVec2 pMin(panelX, panelY);
    ImVec2 pMax(panelX + panelW, panelY + panelH);
    float r = 22.0f * scale;

    // Glow
    for (int i = 0; i < 6; ++i)
    {
        float t = i / 6.0f;
        dl->AddRect(
            ImVec2(pMin.x - i * 2.0f, pMin.y - i * 2.0f),
            ImVec2(pMax.x + i * 2.0f, pMax.y + i * 2.0f),
            IM_COL32(60, 255, 120, (int)((1.0f - t) * 24 * ease)),
            r + i * 2.0f, 0, 2.0f);
    }

    // Vertical gradient fill
    dl->AddRectFilledMultiColor(pMin, pMax,
        kSColPanelTop, kSColPanelTop, kSColPanelBot, kSColPanelBot);
    dl->AddRect(pMin, pMax, kSColBorder, r, 0, 3.0f);

    // Decorative top stripe
    dl->AddRectFilled(
        ImVec2(pMin.x + 16.0f * scale, pMin.y + 14.0f * scale),
        ImVec2(pMax.x - 16.0f * scale, pMin.y + 18.0f * scale),
        kSColAccent);

    // -----------------------------------------------------------------
    // Header: title + price + skin id badge
    // -----------------------------------------------------------------
    ImFont* font = GetUIFont_();
    float padX = 36.0f * scale;
    float padY = 28.0f * scale;

    DrawShadowedText_(dl, font, 38.0f * scale,
        ImVec2(pMin.x + padX, pMin.y + padY),
        kSColText, "محل الملابس");

    DrawShadowedText_(dl, font, 18.0f * scale,
        ImVec2(pMin.x + padX, pMin.y + padY + 44.0f * scale),
        kSColTextMuted, "تصفح الكتالوج واضغط شراء للشراء.");

    // Price banner (right-aligned)
    if (m_szPrice[0])
    {
        char buf[48];
        // Beautify: $123,456 instead of "123456$"
        const char* src = m_szPrice;
        while (*src == ' ' || *src == '$') ++src;
        long long val = atoll(src);
        if (val > 0)
        {
            char tmp[32];
            int len = snprintf(tmp, sizeof(tmp), "%lld", val);
            // group with commas
            char grouped[40]; int gi = 0;
            int firstGroup = len % 3; if (firstGroup == 0) firstGroup = 3;
            for (int i = 0; i < len; ++i)
            {
                if (i > 0 && (i - firstGroup) % 3 == 0) grouped[gi++] = ',';
                grouped[gi++] = tmp[i];
            }
            grouped[gi] = '\0';
            snprintf(buf, sizeof(buf), "$ %s", grouped);
        }
        else
        {
            snprintf(buf, sizeof(buf), "%s", m_szPrice);
        }
        if (font)
        {
            float fs = 44.0f * scale;
            ImVec2 sz = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, buf);
            DrawShadowedText_(dl, font, fs,
                ImVec2(pMax.x - padX - sz.x, pMin.y + padY - 4.0f * scale),
                kSColAccent, buf);

            // Caption
            std::string labSh = Arabic::Shape("السعر");
            const char* lab = labSh.c_str();
            ImVec2 sz2 = font->CalcTextSizeA(16.0f * scale, FLT_MAX, 0.0f, lab);
            DrawShadowedText_(dl, font, 16.0f * scale,
                ImVec2(pMax.x - padX - sz2.x,
                       pMin.y + padY + fs - 4.0f * scale),
                kSColTextMuted, lab);
        }
    }

    // Current skin id badge (small chip top-center)
    int skin = Inv_GetLocalSkinId();
    if (skin >= 0 && font)
    {
        char sb[32];
        snprintf(sb, sizeof(sb), "سكن #%d", skin);
        float fs = 18.0f * scale;
        ImVec2 sz = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, sb);
        float chipW = sz.x + 28.0f * scale;
        float chipH = fs + 14.0f * scale;
        ImVec2 a((pMin.x + pMax.x) * 0.5f - chipW * 0.5f,
                 pMin.y + 10.0f * scale);
        ImVec2 b(a.x + chipW, a.y + chipH);
        dl->AddRectFilled(a, b, kSColCardBgHi, chipH * 0.5f);
        dl->AddRect      (a, b, kSColBorder,   chipH * 0.5f, 0, 1.5f);
        DrawShadowedText_(dl, font, fs,
            ImVec2(a.x + 14.0f * scale, a.y + 7.0f * scale),
            kSColAccent, sb);
    }

    // -----------------------------------------------------------------
    // Buttons row
    //
    // Layout:   [ ◄ PREV ]   [        BUY        ]   [ NEXT ► ]
    //                       [        EXIT        ]
    //
    // Big 1.4-cm targets (~h=92dp at 1080p).
    // -----------------------------------------------------------------
    float rowY  = pMin.y + panelH * 0.62f;
    float btnH  = 92.0f * scale;
    float gap   = 24.0f * scale;
    float arrowW = 220.0f * scale;
    float buyW   = 360.0f * scale;
    float exitH  = 70.0f * scale;

    float totalW = arrowW + gap + buyW + gap + arrowW;
    float startX = (pMin.x + pMax.x) * 0.5f - totalW * 0.5f;

    // PREV button
    DrawButton(dl,
        ImVec2(startX + arrowW * 0.5f, rowY),
        arrowW, btnH,
        IM_COL32(20, 60, 40, 220), IM_COL32(34, 92, 60, 240), kSColText,
        "< السابق",
        1, (m_prevClickId >= 0 ? m_prevClickId : m_prevId), false);

    // BUY (primary)
    DrawButton(dl,
        ImVec2(startX + arrowW + gap + buyW * 0.5f, rowY),
        buyW, btnH,
        IM_COL32(28, 90, 56, 240), IM_COL32(40, 130, 80, 250), kSColText,
        "شراء هذا السكن",
        2, (m_buyClickId >= 0 ? m_buyClickId : m_buyId), true);

    // NEXT button
    DrawButton(dl,
        ImVec2(startX + arrowW + gap + buyW + gap + arrowW * 0.5f, rowY),
        arrowW, btnH,
        IM_COL32(20, 60, 40, 220), IM_COL32(34, 92, 60, 240), kSColText,
        "التالي >",
        3, (m_nextClickId >= 0 ? m_nextClickId : m_nextId), false);

    // EXIT button (centered, below)
    float exitY = rowY + btnH * 0.5f + 24.0f * scale + exitH * 0.5f;
    if (exitY + exitH * 0.5f > pMax.y - 20.0f * scale)
    {
        // tight fit - tuck slightly higher
        exitY = pMax.y - 20.0f * scale - exitH * 0.5f;
    }
    DrawButton(dl,
        ImVec2((pMin.x + pMax.x) * 0.5f, exitY),
        320.0f * scale, exitH,
        IM_COL32(80, 24, 24, 230), IM_COL32(120, 36, 36, 240), kSColText,
        "الخروج من محل الملابس",
        4, (m_exitClickId >= 0 ? m_exitClickId : m_exitId), false);
}
