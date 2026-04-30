// =============================================================================
//  HavanaRp — Fisherman Job Overlay implementation
//  Mirrors the carrent/shop247/houseguard overlay pattern: title-prefix sniff,
//  then render a big custom UI over ImGui draw list, reply with
//  SendDialogResponse via the Fisherman_SendDialogResponse() bridge.
// =============================================================================

#include "../main.h"
#include "fishermanoverlay.h"
#include "gui.h"
#include "../vendor/imgui/imgui.h"
#include "../vendor/imgui/imgui_internal.h"
#include <cstdio>
#include <cstring>
#include <cstdlib>
#include <cmath>

// Fwd declare — pNetGame->SendDialogResponse bridge (defined in netrpc.cpp)
class CNetGame;
extern CNetGame* pNetGame;

void Fisherman_SendDialogResponse(uint16_t id, uint8_t btn, uint16_t listitem,
                                   char* input);

CFishermanOverlay* pFishermanOverlay = nullptr;
extern CGUI* pGUI;

// ---- palette (blue / marine) ------------------------------------------------
static const ImU32 kF_Bg           = IM_COL32(  8,  22,  42, 240);
static const ImU32 kF_BgInner      = IM_COL32( 14,  30,  54, 250);
static const ImU32 kF_Border       = IM_COL32( 80, 180, 255, 220);
static const ImU32 kF_BorderDim    = IM_COL32( 60, 140, 220,  70);
static const ImU32 kF_Accent       = IM_COL32( 60, 220, 255, 255);
static const ImU32 kF_Blue         = IM_COL32( 50, 170, 255, 255);
static const ImU32 kF_DeepBlue     = IM_COL32( 18,  60, 120, 255);
static const ImU32 kF_Text         = IM_COL32(255, 255, 255, 255);
static const ImU32 kF_TextDim      = IM_COL32(210, 230, 250, 220);
static const ImU32 kF_TextMuted    = IM_COL32(150, 180, 210, 200);
static const ImU32 kF_Card         = IM_COL32( 24,  46,  72, 240);
static const ImU32 kF_CardHover    = IM_COL32( 44,  78, 120, 250);
static const ImU32 kF_Green        = IM_COL32( 60, 220, 140, 255);
static const ImU32 kF_Gold         = IM_COL32(255, 200,  60, 255);
static const ImU32 kF_Danger       = IM_COL32(255,  90,  90, 240);
static const ImU32 kF_Water        = IM_COL32( 10,  60, 110, 255);
static const ImU32 kF_Wave         = IM_COL32( 60, 140, 200, 130);

// ---- small helpers ----------------------------------------------------------

static void StripColors(const char* in, char* out, size_t len)
{
    size_t j = 0;
    for (size_t i = 0; in[i] && j + 1 < len; ++i)
    {
        if (in[i] == '{')
        {
            size_t k = i + 1;
            bool   isColor = true;
            int    hexCount = 0;
            while (in[k] && in[k] != '}' && (k - i) < 12)
            {
                char c = in[k];
                if (!((c>='0'&&c<='9')||(c>='A'&&c<='F')||(c>='a'&&c<='f')))
                { isColor = false; break; }
                hexCount++;
                k++;
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

static int ParseInt(const char*& p)
{
    int v = 0;
    int sign = 1;
    if (*p == '-') { sign = -1; p++; }
    while (*p >= '0' && *p <= '9') { v = v*10 + (*p - '0'); p++; }
    return sign * v;
}

static float ParseFloat(const char*& p)
{
    char buf[32]; int i = 0;
    if (*p == '-' && i < 30) buf[i++] = *p++;
    while (((*p>='0'&&*p<='9') || *p=='.') && i < 30) { buf[i++] = *p++; }
    buf[i] = 0;
    return (float)atof(buf);
}

static void FmtMoney(int v, char* out, size_t len)
{
    char t[32]; int i = 0, n = v < 0 ? -v : v;
    if (n == 0) { t[i++] = '0'; }
    while (n > 0 && i < 30) { t[i++] = '0' + (n % 10); n /= 10; }
    char o[40]; int k = 0;
    if (v < 0 && k < 38) o[k++] = '-';
    if (k < 38) o[k++] = '$';
    for (int j = i - 1; j >= 0 && k < 38; --j)
    {
        o[k++] = t[j];
        if (j > 0 && (j % 3) == 0 && k < 38) o[k++] = ',';
    }
    o[k] = 0;
    snprintf(out, len, "%s", o);
}

static bool PointInRect(ImVec2 p, ImVec2 a, ImVec2 b)
{
    return p.x >= a.x && p.x <= b.x && p.y >= a.y && p.y <= b.y;
}

// ---- per-frame edge-detected touch state (ImGui on Android doesn't populate
//      MouseReleased/MouseClicked reliably, so we track our own press/release
//      transitions with tap-slop like the carrent/houseguard overlays). ------
struct FishTouch
{
    float downX, downY;
    bool  isDown;
    bool  wasDown;
    bool  pressed;    // true only on the frame the finger touches down
    bool  released;   // true only on the frame the finger lifts
    bool  moved;      // true once finger moved more than kTapSlop since press
    float lastActionT; // used to debounce rapid-fire +/- holds
};
static FishTouch g_fTouch = { 0, 0, false, false, false, false, false, 0.0f };

static void FishTouch_Update(const ImGuiIO& io)
{
    g_fTouch.wasDown  = g_fTouch.isDown;
    g_fTouch.isDown   = io.MouseDown[0];
    g_fTouch.pressed  = ( g_fTouch.isDown && !g_fTouch.wasDown);
    g_fTouch.released = (!g_fTouch.isDown &&  g_fTouch.wasDown);

    if (g_fTouch.pressed)
    {
        g_fTouch.downX = io.MousePos.x;
        g_fTouch.downY = io.MousePos.y;
        g_fTouch.moved = false;
    }
    if (g_fTouch.isDown)
    {
        const float kTapSlop = 14.0f;
        float dx = io.MousePos.x - g_fTouch.downX;
        float dy = io.MousePos.y - g_fTouch.downY;
        if (!g_fTouch.moved && (dx*dx + dy*dy) > kTapSlop*kTapSlop)
            g_fTouch.moved = true;
    }
}

// ---- ctor/dtor/hide ---------------------------------------------------------

CFishermanOverlay::CFishermanOverlay()
    : m_state(FISH_NONE), m_dialogId(0), m_animT(0.0f),
      m_shopHasLic(0), m_shopDaysLeft(0), m_shopBait(0), m_shopHasRod(0),
      m_shopWorking(0), m_shopMoney(0),
      m_baitQty(1), m_baitUnitPrice(10), m_baitMaxQty(20),
      m_rodPrice(500), m_boatPrice(250),
      m_castBait(0), m_castBag(0), m_castMoney(0),
      m_castInZone(0), m_castOnBoat(0), m_waterAnim(0.0f),
      m_fishSwimInit(0),
      m_rsIsCatch(0), m_rsWeight(0), m_rsPrice(0), m_rsRare(0),
      m_rsBaitLeft(0), m_rsBagCount(0), m_rsShowT(0.0f),
      m_stTotalCount(0), m_stTotalPrice(0), m_stTotalWeight(0.0f),
      m_reelFill(0.0f), m_reelDecayRate(0.0f), m_reelPerTap(0.0f),
      m_reelLastFrame(0.0f), m_reelDialogId(0), m_reelPressed(false),
      m_reelTaps(0), m_reelStartT(0.0f)
{}

CFishermanOverlay::~CFishermanOverlay() {}

void CFishermanOverlay::Hide()
{
    m_state = FISH_NONE;
    m_licOpts.clear();
    m_stRows.clear();
    m_msg.clear();
    m_rsName.clear();
}

// ---- reply helpers ----------------------------------------------------------

void CFishermanOverlay::SendPick(int listitem)
{
    char empty[2] = {0};
    Fisherman_SendDialogResponse(m_dialogId, 1, (uint16_t)listitem, empty);
    Hide();
}

void CFishermanOverlay::SendOk()
{
    char empty[2] = {0};
    Fisherman_SendDialogResponse(m_dialogId, 1, 0, empty);
    Hide();
}

void CFishermanOverlay::SendCancel()
{
    char empty[2] = {0};
    Fisherman_SendDialogResponse(m_dialogId, 0, 0, empty);
    Hide();
}

void CFishermanOverlay::SendInput(const char* text)
{
    char buf[64];
    snprintf(buf, sizeof(buf), "%s", text ? text : "");
    Fisherman_SendDialogResponse(m_dialogId, 1, 0, buf);
    Hide();
}

// ---- state transition -------------------------------------------------------

bool CFishermanOverlay::TryHandleDialog(uint16_t dialogId, uint8_t /*style*/,
                                        const char* title, const char* body)
{
    if (!title) return false;
    char tclean[128];
    StripColors(title, tclean, sizeof(tclean));

    if (strncmp(tclean, "HAVANA_FISH_", 12) != 0) return false;

    // Match the suffix used by the gamemode-side fisherman.inc dialogs.
    // Source of truth: 03_gamemode/include/fisherman.inc — all titles are
    // ASCII strings of the form "HAVANA_FISH_<TAG>".
    const char* k = tclean + 12;
    if      (!strcmp(k, "SHOP"))   SetState(FISH_SHOP,   dialogId, title, body);
    else if (!strcmp(k, "LIC"))    SetState(FISH_LIC,    dialogId, title, body);
    else if (!strcmp(k, "BAIT"))   SetState(FISH_BAIT,   dialogId, title, body);
    else if (!strcmp(k, "ROD"))    SetState(FISH_ROD,    dialogId, title, body);
    else if (!strcmp(k, "BOAT"))   SetState(FISH_BOAT,   dialogId, title, body);
    else if (!strcmp(k, "CAST"))   SetState(FISH_CAST,   dialogId, title, body);
    else if (!strcmp(k, "RESULT")) SetState(FISH_RESULT, dialogId, title, body);
    else if (!strcmp(k, "STATS"))  SetState(FISH_STATS,  dialogId, title, body);
    else if (!strcmp(k, "MSG"))    SetState(FISH_MSG,    dialogId, title, body);
    else if (!strcmp(k, "HUD"))    SetState(FISH_HUD,    dialogId, title, body);
    else return false;

    return true;
}

void CFishermanOverlay::SetState(EFishState s, uint16_t dialogId,
                                  const char* /*title*/, const char* body)
{
    m_state    = s;
    m_dialogId = dialogId;
    m_animT    = 0.0f;

    char clean[4096];
    StripColors(body ? body : "", clean, sizeof(clean));
    const char* p = clean;

    switch (s)
    {
    case FISH_SHOP:
    {
        // has_license|days_left|bait|has_rod|working|money
        m_shopHasLic   = ParseInt(p); if (*p == '|') ++p;
        m_shopDaysLeft = ParseInt(p); if (*p == '|') ++p;
        m_shopBait     = ParseInt(p); if (*p == '|') ++p;
        m_shopHasRod   = ParseInt(p); if (*p == '|') ++p;
        m_shopWorking  = ParseInt(p); if (*p == '|') ++p;
        m_shopMoney    = ParseInt(p);
        break;
    }
    case FISH_LIC:
    {
        m_licOpts.clear();
        while (*p)
        {
            FishLicenseOpt o = {0, 0};
            o.days  = ParseInt(p); if (*p == '|') ++p;
            o.price = ParseInt(p);
            m_licOpts.push_back(o);
            while (*p && *p != '\n') ++p;
            if (*p == '\n') ++p;
        }
        break;
    }
    case FISH_BAIT:
    {
        m_baitUnitPrice = ParseInt(p); if (*p == '|') ++p;
        m_baitMaxQty    = ParseInt(p);
        // 0 (or negative) from the server means "no upper limit" — allow
        // the player to buy as much bait as they can afford.
        if (m_baitMaxQty <= 0) m_baitMaxQty = 999999;
        m_baitQty = 1;
        break;
    }
    case FISH_ROD:  m_rodPrice  = ParseInt(p); break;
    case FISH_BOAT: m_boatPrice = ParseInt(p); break;
    case FISH_CAST:
    {
        // bait_left|bag_count|total_money|in_zone|on_boat|casting
        m_castBait   = ParseInt(p); if (*p == '|') ++p;
        m_castBag    = ParseInt(p); if (*p == '|') ++p;
        m_castMoney  = ParseInt(p); if (*p == '|') ++p;
        m_castInZone = ParseInt(p); if (*p == '|') ++p;
        m_castOnBoat = ParseInt(p);
        // spawn decorative fish once
        if (!m_fishSwimInit)
        {
            m_fishSwimX.clear(); m_fishSwimY.clear(); m_fishSwimVX.clear();
            for (int i = 0; i < 6; ++i)
            {
                m_fishSwimX.push_back( (float)(rand() % 1000) / 1000.0f );
                m_fishSwimY.push_back( 0.35f + 0.55f * ((float)(rand()%1000)/1000.0f));
                m_fishSwimVX.push_back( ((rand()&1) ? 1.0f : -1.0f)
                                      * (0.06f + (rand()%100)/1000.0f) );
            }
            m_fishSwimInit = 1;
        }
        break;
    }
    case FISH_RESULT:
    {
        char kind[16] = {0};
        int i = 0;
        while (*p && *p != '|' && i < 15) { kind[i++] = *p++; }
        kind[i] = 0; if (*p == '|') ++p;
        m_rsShowT = 0.0f;
        // Tags from include/fisherman.inc are ASCII: "MISS" / "CATCH".
        if (!strcmp(kind, "MISS"))
        {
            m_rsIsCatch = 0;
            m_rsBaitLeft = ParseInt(p); if (*p == '|') ++p;
            m_rsBagCount = ParseInt(p);
            m_rsName.clear();
            m_rsWeight = 0; m_rsPrice = 0; m_rsRare = 0;
        }
        else if (!strcmp(kind, "CATCH"))
        {
            // CATCH|name|weight|price|rare|bait|bag
            m_rsIsCatch = 1;
            const char* q = p;
            while (*p && *p != '|') ++p;
            m_rsName.assign(q, p - q);
            if (*p == '|') ++p;
            m_rsWeight = ParseFloat(p); if (*p == '|') ++p;
            m_rsPrice  = ParseInt(p);   if (*p == '|') ++p;
            m_rsRare   = ParseInt(p);   if (*p == '|') ++p;
            m_rsBaitLeft = ParseInt(p); if (*p == '|') ++p;
            m_rsBagCount = ParseInt(p);
        }
        break;
    }
    case FISH_STATS:
    {
        m_stRows.clear();
        m_stTotalCount = 0; m_stTotalPrice = 0; m_stTotalWeight = 0.0f;
        // first line: TOTALS|count|price|weight
        if (!strncmp(p, "TOTALS|", 7))
        {
            p += 7;
            m_stTotalCount = ParseInt(p); if (*p == '|') ++p;
            m_stTotalPrice = ParseInt(p); if (*p == '|') ++p;
            m_stTotalWeight= ParseFloat(p);
            while (*p && *p != '\n') ++p;
            if (*p == '\n') ++p;
        }
        // following: name|weight|price|rare
        while (*p)
        {
            const char* start = p;
            while (*p && *p != '|' && *p != '\n') ++p;
            FishStatRow r;
            r.name.assign(start, p - start);
            if (*p == '|') ++p;
            r.weight = ParseFloat(p); if (*p == '|') ++p;
            r.price  = ParseInt(p);   if (*p == '|') ++p;
            r.rare   = ParseInt(p);
            if (!r.name.empty()) m_stRows.push_back(r);
            while (*p && *p != '\n') ++p;
            if (*p == '\n') ++p;
        }
        break;
    }
    case FISH_MSG: m_msg = clean; break;
    case FISH_HUD:
    {
        // body: bait_left|bag_count|total_money
        m_castBait  = ParseInt(p); if (*p == '|') ++p;
        m_castBag   = ParseInt(p); if (*p == '|') ++p;
        m_castMoney = ParseInt(p);
        m_castInZone = 1; m_castOnBoat = 1;
        break;
    }
    default: break;
    }
}

// ---- shared widgets ---------------------------------------------------------

bool CFishermanOverlay::BigButton(const char* label, float x, float y,
                                   float w, float h,
                                   unsigned col, unsigned colHover)
{
    ImGuiIO& io = ImGui::GetIO();
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    ImVec2 a(x, y), b(x+w, y+h);

    bool insideNow = PointInRect(io.MousePos, a, b);
    bool pressing  = insideNow && io.MouseDown[0];
    // IsMouseClicked fires on the transition down-event, matching the proven
    // pattern used by skinshopoverlay/bankoverlay on the Android build.
    bool clicked   = insideNow && ImGui::IsMouseClicked(0);

    dl->AddRectFilledMultiColor(a, b,
        pressing ? colHover : col,
        pressing ? col      : colHover,
        col, col);
    dl->AddRect(a, b, kF_Border, 12.0f, 0, 2.0f);

    // label
    ImFont* font = pGUI ? pGUI->GetFont() : ImGui::GetFont();
    float fs = h * 0.44f;
    if (fs < 18.0f) fs = 18.0f;
    ImVec2 tsz = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, label);
    dl->AddText(font, fs,
        ImVec2(x + (w - tsz.x) * 0.5f, y + (h - tsz.y) * 0.5f),
        kF_Text, label);
    return clicked;
}

void CFishermanOverlay::TitleStrip(const char* title, const char* subtitle,
                                    float x, float y, float w)
{
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    ImVec2 a(x, y), b(x + w, y + 110.0f);
    dl->AddRectFilledMultiColor(a, b,
        kF_DeepBlue, kF_Blue, kF_Blue, kF_DeepBlue);
    dl->AddLine(ImVec2(x + 12, b.y), ImVec2(b.x - 12, b.y), kF_Accent, 2.0f);

    ImFont* font = pGUI ? pGUI->GetFont() : ImGui::GetFont();
    // Title
    ImVec2 ts = font->CalcTextSizeA(46.0f, FLT_MAX, 0.0f, title);
    dl->AddText(font, 46.0f, ImVec2(x + 28.0f, y + 16.0f), kF_Text, title);
    (void)ts;
    if (subtitle && *subtitle)
        dl->AddText(font, 24.0f, ImVec2(x + 28.0f, y + 68.0f),
                    kF_TextDim, subtitle);
}

void CFishermanOverlay::UnderwaterBackdrop(float x, float y, float w, float h,
                                           float t)
{
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    ImVec2 a(x, y), b(x + w, y + h);
    // gradient surface -> deep
    dl->AddRectFilledMultiColor(a, b,
        IM_COL32( 40, 140, 200, 255),
        IM_COL32( 40, 140, 200, 255),
        IM_COL32(  6,  22,  44, 255),
        IM_COL32(  6,  22,  44, 255));

    // Light beams from surface
    for (int i = 0; i < 5; ++i)
    {
        float k = (float)i / 5.0f;
        float cx = x + w * (0.1f + 0.18f * i) + sinf(t * 0.4f + i) * 12.0f;
        ImVec2 p1(cx - 40.0f, y);
        ImVec2 p2(cx + 40.0f, y);
        ImVec2 p3(cx + 10.0f, y + h * 0.9f);
        ImVec2 p4(cx - 10.0f, y + h * 0.9f);
        dl->AddQuadFilled(p1, p2, p3, p4,
            IM_COL32(255, 255, 255, (int)(28.0f * (1.0f - k))));
    }

    // Wavy surface line
    const int kSeg = 40;
    for (int i = 0; i < kSeg; ++i)
    {
        float fx1 = x + w * i / kSeg;
        float fx2 = x + w * (i + 1) / kSeg;
        float fy1 = y + 6.0f + sinf(t * 1.4f + i * 0.6f) * 5.0f;
        float fy2 = y + 6.0f + sinf(t * 1.4f + (i + 1) * 0.6f) * 5.0f;
        dl->AddLine(ImVec2(fx1, fy1), ImVec2(fx2, fy2), kF_Wave, 2.5f);
    }

    // Sea floor with gravel
    ImVec2 flA(x, y + h - 28.0f), flB(x + w, y + h);
    dl->AddRectFilled(flA, flB, IM_COL32(24, 38, 56, 255));
    for (int i = 0; i < 30; ++i)
    {
        float gx = x + (i * 37) % (int)w;
        float gy = y + h - 22.0f + (i % 5);
        dl->AddCircleFilled(ImVec2(gx, gy), 2.0f + (i % 3),
            IM_COL32(50, 70, 90, 200));
    }

    // Bubble trail
    for (int i = 0; i < 18; ++i)
    {
        float phase = t * 0.6f + i * 0.7f;
        float bx = x + w * 0.2f + fmodf(i * 83.0f, w * 0.75f);
        float by = y + h - fmodf(phase * 80.0f, h * 0.9f);
        dl->AddCircle(ImVec2(bx, by), 3.0f + (i % 4),
            IM_COL32(255, 255, 255, 160), 10, 1.5f);
    }
}

// ---- RENDER dispatcher ------------------------------------------------------

void CFishermanOverlay::Render()
{
    if (m_state == FISH_NONE) return;
    ImGuiIO& io = ImGui::GetIO();
    if (m_animT < 1.0f) { m_animT += io.DeltaTime / 0.22f;
                           if (m_animT > 1.0f) m_animT = 1.0f; }
    m_waterAnim += io.DeltaTime;
    if (m_rsShowT < 1.0f) { m_rsShowT += io.DeltaTime / 0.6f;
                             if (m_rsShowT > 1.0f) m_rsShowT = 1.0f; }

    ImDrawList* dl = ImGui::GetOverlayDrawList();
    // HUD + REEL are lightweight on-screen overlays; everything else dims.
    if (m_state != FISH_HUD && m_state != FISH_REEL)
    {
        dl->AddRectFilled(ImVec2(0, 0), io.DisplaySize,
            IM_COL32(0, 0, 0, (int)(170 * m_animT)));
    }

    switch (m_state)
    {
    case FISH_SHOP:   RenderShop();    break;
    case FISH_LIC:    RenderLicense(); break;
    case FISH_BAIT:   RenderBait();    break;
    case FISH_ROD:    RenderRod();     break;
    case FISH_BOAT:   RenderBoat();    break;
    case FISH_CAST:   RenderCast();    break;
    case FISH_RESULT: RenderResult();  break;
    case FISH_STATS:  RenderStats();   break;
    case FISH_MSG:    RenderMessage(); break;
    case FISH_HUD:    RenderHud();     break;
    case FISH_REEL:   RenderReel();    break;
    default: break;
    }
}

// ---- SHOP (laptop / marina) -------------------------------------------------

void CFishermanOverlay::RenderShop()
{
    ImGuiIO& io = ImGui::GetIO();
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    ImFont* font = pGUI ? pGUI->GetFont() : ImGui::GetFont();

    // --------- Panel size + position (centred, fits any phone) -----------
    float pW = io.DisplaySize.x * 0.92f;
    float pH = io.DisplaySize.y * 0.90f;
    if (pW > 1620.0f) pW = 1620.0f;
    if (pH > 1000.0f) pH = 1000.0f;
    float pX = (io.DisplaySize.x - pW) * 0.5f;
    float pY = (io.DisplaySize.y - pH) * 0.5f;

    // =========================================================
    //  LAPTOP CHASSIS  (premium, brushed-aluminium look)
    // =========================================================

    // Deep ground shadow under the laptop.
    for (int s = 0; s < 5; ++s)
    {
        int a = (5 - s) * 30;
        dl->AddRectFilled(
            ImVec2(pX - 70 - s * 4, pY + pH + 26 + s * 6),
            ImVec2(pX + pW + 70 + s * 4, pY + pH + 70 + s * 6),
            IM_COL32(0, 0, 0, a), 24.0f);
    }

    // Laptop base / palm-rest (two strips for trapezoid illusion).
    dl->AddRectFilledMultiColor(
        ImVec2(pX - 80, pY + pH + 4), ImVec2(pX + pW + 80, pY + pH + 22),
        IM_COL32(48, 56, 70, 255), IM_COL32(48, 56, 70, 255),
        IM_COL32(28, 34, 44, 255), IM_COL32(28, 34, 44, 255));
    dl->AddRectFilledMultiColor(
        ImVec2(pX - 110, pY + pH + 22), ImVec2(pX + pW + 110, pY + pH + 56),
        IM_COL32(34, 40, 52, 255), IM_COL32(34, 40, 52, 255),
        IM_COL32(14, 18, 26, 255), IM_COL32(14, 18, 26, 255));
    // Hinge groove + soft highlight.
    dl->AddRectFilled(
        ImVec2(pX - 60, pY + pH + 1), ImVec2(pX + pW + 60, pY + pH + 5),
        IM_COL32(8, 10, 14, 255), 2.0f);
    dl->AddLine(
        ImVec2(pX - 60, pY + pH + 22), ImVec2(pX + pW + 60, pY + pH + 22),
        IM_COL32(120, 140, 160, 60), 1.0f);
    // Speaker grills on the palm-rest.
    for (int sx = 0; sx < 14; ++sx)
    {
        float gxL = pX + 30 + sx * 14.0f;
        float gxR = pX + pW - 30 - sx * 14.0f;
        for (int sy = 0; sy < 3; ++sy)
        {
            dl->AddCircleFilled(ImVec2(gxL, pY + pH + 32 + sy * 6),
                                1.4f, IM_COL32(80, 90, 100, 200), 6);
            dl->AddCircleFilled(ImVec2(gxR, pY + pH + 32 + sy * 6),
                                1.4f, IM_COL32(80, 90, 100, 200), 6);
        }
    }
    dl->AddText(font, 14.0f,
                ImVec2(pX + pW * 0.5f - 50.0f, pY + pH + 30),
                IM_COL32(140, 160, 180, 130), "هافانا آر بي");

    // Outer screen bezel.
    dl->AddRectFilled(ImVec2(pX - 14, pY - 14),
                      ImVec2(pX + pW + 14, pY + pH + 14),
                      IM_COL32(8, 10, 14, 255), 22.0f);
    dl->AddRect(ImVec2(pX - 14, pY - 14),
                ImVec2(pX + pW + 14, pY + pH + 14),
                IM_COL32(70, 90, 120, 220), 22.0f, 0, 1.5f);
    dl->AddLine(ImVec2(pX - 12, pY - 12), ImVec2(pX + pW + 12, pY - 12),
                IM_COL32(180, 200, 220, 80), 1.0f);

    // Webcam.
    dl->AddCircleFilled(ImVec2(pX + pW * 0.5f, pY - 7),
                        4.0f, IM_COL32(20, 22, 28, 255), 24);
    dl->AddCircleFilled(ImVec2(pX + pW * 0.5f, pY - 7),
                        1.5f, IM_COL32(180, 220, 255, 255), 12);
    dl->AddCircleFilled(ImVec2(pX + pW * 0.5f + 10, pY - 7),
                        1.6f, IM_COL32(120, 220, 100, 220), 8);

    // =========================================================
    //  SCREEN  (dark wallpaper with grid + corner glow)
    // =========================================================
    dl->AddRectFilledMultiColor(
        ImVec2(pX, pY), ImVec2(pX + pW, pY + pH),
        IM_COL32(10, 22, 44, 255), IM_COL32(8, 18, 36, 255),
        IM_COL32( 4, 10, 20, 255), IM_COL32(6, 14, 28, 255));
    dl->AddRect(ImVec2(pX, pY), ImVec2(pX + pW, pY + pH),
                IM_COL32(80, 180, 255, 200), 6.0f, 0, 1.5f);
    // dotted grid
    for (int gx = 0; gx < (int)(pW / 32); ++gx)
        for (int gy = 0; gy < (int)(pH / 32); ++gy)
            dl->AddCircleFilled(
                ImVec2(pX + 16 + gx * 32.0f, pY + 16 + gy * 32.0f),
                0.8f, IM_COL32(255, 255, 255, 8), 4);
    // corner glow
    for (int g = 0; g < 6; ++g)
        dl->AddCircleFilled(ImVec2(pX + 80, pY + 60),
                            220.0f + g * 30.0f,
                            IM_COL32(40, 120, 220, 6), 32);

    // =========================================================
    //  MENU BAR  (top status bar, like macOS)
    // =========================================================
    const float MB_H = 32.0f;
    float mbY = pY + 6;
    dl->AddRectFilled(ImVec2(pX + 6, mbY),
                      ImVec2(pX + pW - 6, mbY + MB_H),
                      IM_COL32(8, 14, 26, 230), 4.0f);
    dl->AddCircleFilled(ImVec2(pX + 22, mbY + MB_H * 0.5f), 6.0f,
                        IM_COL32(60, 220, 255, 255), 18);
    dl->AddText(font, 16.0f, ImVec2(pX + 38, mbY + 8),
                kF_Text, "نظام هافانا");
    dl->AddText(font, 13.0f, ImVec2(pX + 158, mbY + 10),
                kF_TextMuted, "ملف   عرض   متجر   مساعدة");

    // Right side: WiFi + battery + clock.
    float rx = pX + pW - 16;
    char clockBuf[16];
    int  hh = ((int)(m_waterAnim * 0.05f) % 24);
    int  mm = ((int)(m_waterAnim * 3.0f) % 60);
    snprintf(clockBuf, sizeof(clockBuf), "%02d:%02d", hh, mm);
    ImVec2 cs = font->CalcTextSizeA(15.0f, FLT_MAX, 0.0f, clockBuf);
    rx -= cs.x;
    dl->AddText(font, 15.0f, ImVec2(rx, mbY + 9), kF_Text, clockBuf);
    rx -= 14;
    dl->AddRect(ImVec2(rx - 26, mbY + 11),
                ImVec2(rx, mbY + 21),
                IM_COL32(220, 230, 240, 220), 2.0f, 0, 1.2f);
    dl->AddRectFilled(ImVec2(rx - 24, mbY + 13),
                      ImVec2(rx - 4, mbY + 19),
                      IM_COL32(60, 220, 140, 240), 1.0f);
    dl->AddRectFilled(ImVec2(rx, mbY + 14),
                      ImVec2(rx + 3, mbY + 18),
                      IM_COL32(220, 230, 240, 220), 1.0f);
    rx -= 38;
    for (int b = 0; b < 3; ++b)
        dl->AddCircleFilled(ImVec2(rx, mbY + 22),
                            3.0f + b * 4.0f,
                            IM_COL32(80, 180, 255, 60), 16);
    dl->AddCircleFilled(ImVec2(rx, mbY + 22), 2.0f, kF_Accent, 12);

    // =========================================================
    //  WINDOW  (frosted card with traffic-light buttons)
    //  Layout budget: everything inside wnX..wnX+wnW, wnY..wnY+wnH.
    // =========================================================
    float wnX = pX + 18;
    float wnY = mbY + MB_H + 8;
    float wnW = pW - 36;
    float wnH = (pY + pH - 14) - wnY;          // to the bottom of the screen

    // Window shadow + body.
    dl->AddRectFilled(ImVec2(wnX + 6, wnY + 8),
                      ImVec2(wnX + wnW + 6, wnY + wnH + 8),
                      IM_COL32(0, 0, 0, 140), 14.0f);
    dl->AddRectFilledMultiColor(
        ImVec2(wnX, wnY), ImVec2(wnX + wnW, wnY + wnH),
        IM_COL32(18, 36, 64, 250), IM_COL32(14, 28, 50, 250),
        IM_COL32( 8, 18, 36, 255), IM_COL32(10, 22, 44, 255));
    dl->AddRect(ImVec2(wnX, wnY), ImVec2(wnX + wnW, wnY + wnH),
                IM_COL32(80, 180, 255, 220), 14.0f, 0, 2.0f);

    // Title bar (slimmer).
    const float TB_H = 36.0f;
    dl->AddRectFilledMultiColor(
        ImVec2(wnX + 1, wnY + 1), ImVec2(wnX + wnW - 1, wnY + TB_H),
        IM_COL32(26, 56, 96, 255), IM_COL32(26, 56, 96, 255),
        IM_COL32(18, 40, 70, 255), IM_COL32(18, 40, 70, 255));
    dl->AddLine(ImVec2(wnX + 1, wnY + TB_H),
                ImVec2(wnX + wnW - 1, wnY + TB_H),
                kF_Border, 1.5f);
    // Traffic lights.
    float tl_y = wnY + TB_H * 0.5f;
    dl->AddCircleFilled(ImVec2(wnX + 22, tl_y), 7.0f,
                        IM_COL32(240, 90, 90, 255), 18);
    dl->AddCircleFilled(ImVec2(wnX + 44, tl_y), 7.0f,
                        IM_COL32(240, 200, 70, 255), 18);
    dl->AddCircleFilled(ImVec2(wnX + 66, tl_y), 7.0f,
                        IM_COL32(80, 220, 130, 255), 18);
    // Window title (centred).
    const char* wnTitle = "havanafish.app  -  المارينا";
    ImVec2 wts = font->CalcTextSizeA(14.0f, FLT_MAX, 0.0f, wnTitle);
    dl->AddText(font, 14.0f,
                ImVec2(wnX + (wnW - wts.x) * 0.5f, wnY + 11),
                kF_Text, wnTitle);
    // Tabs (left side, after traffic lights).
    const char* tabs[3] = { "الرئيسية", "المتجر", "الرحلات" };
    float tabX = wnX + 90;
    for (int t = 0; t < 3; ++t)
    {
        ImVec2 tsz = font->CalcTextSizeA(13.0f, FLT_MAX, 0.0f, tabs[t]);
        float tw = tsz.x + 18.0f;
        if (t == 1) {
            dl->AddRectFilled(ImVec2(tabX, wnY + 5),
                              ImVec2(tabX + tw, wnY + TB_H - 4),
                              IM_COL32(40, 80, 130, 255), 5.0f);
        }
        dl->AddText(font, 13.0f, ImVec2(tabX + 9, wnY + 11),
                    t == 1 ? kF_Text : kF_TextMuted, tabs[t]);
        tabX += tw + 6;
    }

    // Content area (everything below title bar, above dock).
    const float DK_H = 38.0f;
    float cnX = wnX + 16;
    float cnY = wnY + TB_H + 12;
    float cnW = wnW - 32;
    float cnH = wnH - TB_H - DK_H - 24;

    // =========================================================
    //  HERO  (compact banner with sheen)
    // =========================================================
    float hrH = 86.0f;
    if (hrH > cnH * 0.22f) hrH = cnH * 0.22f;     // cap so tiles never starve
    ImVec2 hrA(cnX, cnY), hrB(cnX + cnW, cnY + hrH);
    dl->AddRectFilledMultiColor(
        hrA, hrB,
        IM_COL32(40, 110, 200, 255), IM_COL32(60, 200, 255, 255),
        IM_COL32(20,  60, 120, 255), IM_COL32(30,  90, 160, 255));
    dl->AddRect(hrA, hrB,
                IM_COL32(255, 255, 255, 60), 12.0f, 0, 1.5f);
    // Animated sheen sweep.
    float sheen = cnX + fmodf(m_waterAnim * 80.0f, cnW + 200.0f) - 200.0f;
    for (int s = 0; s < 60; ++s)
    {
        float xx = sheen + s * 2.0f;
        if (xx > cnX + 4 && xx < cnX + cnW - 4)
            dl->AddLine(ImVec2(xx, cnY + 4),
                        ImVec2(xx, cnY + hrH - 4),
                        IM_COL32(255, 255, 255, 6 + (30 - abs(s - 30))), 2.0f);
    }
    // Premium pill.
    dl->AddRectFilled(ImVec2(cnX + 18, cnY + 12),
                      ImVec2(cnX + 162, cnY + 36),
                      IM_COL32(0, 0, 0, 110), 8.0f);
    dl->AddText(font, 13.0f, ImVec2(cnX + 26, cnY + 17),
                IM_COL32(255, 220, 100, 255), "المتجر المميز");
    // Title (auto-shrink to fit available width).
    char moneyChip[32]; FmtMoney(m_shopMoney, moneyChip, sizeof(moneyChip));
    ImVec2 mcsz = font->CalcTextSizeA(22.0f, FLT_MAX, 0.0f, moneyChip);
    float mcW = mcsz.x + 40.0f;
    float titleAvail = cnW - mcW - 40.0f;
    float tFs = 32.0f;
    const char* heroTitle = "متجر صيد هافانا";
    ImVec2 ttsz = font->CalcTextSizeA(tFs, FLT_MAX, 0.0f, heroTitle);
    while (ttsz.x > titleAvail && tFs > 18.0f)
    {
        tFs -= 1.0f;
        ttsz = font->CalcTextSizeA(tFs, FLT_MAX, 0.0f, heroTitle);
    }
    dl->AddText(font, tFs, ImVec2(cnX + 18, cnY + 38),
                IM_COL32(255, 255, 255, 250), heroTitle);
    dl->AddText(font, 13.0f, ImVec2(cnX + 18, cnY + hrH - 22),
                IM_COL32(220, 235, 250, 220),
                "رخص · طُعم · سنارات · ابدأ رحلة");
    // Wallet chip (right, vertically centred).
    float mcX = cnX + cnW - mcW - 14;
    float mcY = cnY + (hrH - 56.0f) * 0.5f;
    dl->AddRectFilled(ImVec2(mcX, mcY),
                      ImVec2(mcX + mcW, mcY + 56),
                      IM_COL32(0, 0, 0, 130), 10.0f);
    dl->AddText(font, 11.0f, ImVec2(mcX + 12, mcY + 6),
                IM_COL32(180, 230, 200, 220), "المحفظة");
    dl->AddText(font, 22.0f, ImVec2(mcX + 12, mcY + 22),
                kF_Green, moneyChip);

    // =========================================================
    //  BODY  (sidebar + 4 horizontal app tiles)
    // =========================================================
    float bdX = cnX;
    float bdY = cnY + hrH + 10;
    float bdW = cnW;
    float bdH = cnY + cnH - bdY;

    float sbW = bdW * 0.30f;
    if (sbW > 320.0f) sbW = 320.0f;
    if (sbW < 240.0f) sbW = 240.0f;
    float sbX = bdX;
    float sbY = bdY;
    float sbH = bdH;

    // Sidebar background.
    dl->AddRectFilled(ImVec2(sbX, sbY), ImVec2(sbX + sbW, sbY + sbH),
                      IM_COL32(20, 40, 70, 230), 12.0f);
    dl->AddRect(ImVec2(sbX, sbY), ImVec2(sbX + sbW, sbY + sbH),
                kF_BorderDim, 12.0f, 0, 1.5f);

    // Profile header inside the sidebar.
    float avR = 28.0f;
    ImVec2 avC(sbX + 42, sbY + 38);
    dl->AddCircleFilled(avC, avR + 3, IM_COL32(80, 180, 255, 70), 32);
    dl->AddCircleFilled(avC, avR, IM_COL32(34, 78, 130, 255), 32);
    dl->AddCircle(avC, avR, kF_Accent, 32, 1.8f);
    dl->AddText(font, 24.0f, ImVec2(avC.x - 9, avC.y - 14),
                kF_Text, "C");
    dl->AddCircleFilled(ImVec2(avC.x + 22, avC.y + 22), 5.0f,
                        IM_COL32(60, 220, 130, 255), 12);
    dl->AddCircle(ImVec2(avC.x + 22, avC.y + 22), 5.0f,
                  IM_COL32(0, 0, 0, 200), 12, 1.2f);

    dl->AddText(font, 18.0f, ImVec2(sbX + 84, sbY + 18),
                kF_Text, "الكابتن");
    dl->AddText(font, 12.0f, ImVec2(sbX + 84, sbY + 40),
                kF_TextMuted, "المارينا · صياد");
    dl->AddText(font, 11.0f, ImVec2(sbX + 84, sbY + 56),
                m_shopWorking ? kF_Green : kF_TextMuted,
                m_shopWorking ? "ON  TRIP" : "DOCKED");

    // Divider + STATUS heading.
    dl->AddLine(ImVec2(sbX + 14, sbY + 84),
                ImVec2(sbX + sbW - 14, sbY + 84),
                kF_BorderDim, 1.0f);
    dl->AddText(font, 12.0f, ImVec2(sbX + 14, sbY + 90),
                kF_TextMuted, "الحالة");

    // Stat rows. We compute spacing from remaining height so 5 rows always
    // fit even on small phones.
    char vLic[32], vBait[32], vMoney[32];
    snprintf(vLic, sizeof(vLic),
             m_shopHasLic ? "%d days" : "None", m_shopDaysLeft);
    snprintf(vBait, sizeof(vBait), "x %d", m_shopBait);
    FmtMoney(m_shopMoney, vMoney, sizeof(vMoney));
    struct SRow {
        const char* ico; const char* lbl; const char* val; ImU32 vcol;
    };
    SRow rows[5] = {
        { "L", "License", vLic,
          m_shopHasLic ? kF_Green : kF_Danger },
        { "B", "Bait", vBait, kF_Gold },
        { "R", "Rod",
          m_shopHasRod ? "Equipped" : "None",
          m_shopHasRod ? kF_Green : kF_Danger },
        { "$", "Money", vMoney, kF_Gold },
        { "W", "Work",
          m_shopWorking ? "Active" : "Idle",
          m_shopWorking ? kF_Green : kF_TextMuted }
    };
    float rowsTop  = sbY + 112;
    float rowsBot  = sbY + sbH - 14;
    float rowSpan  = (rowsBot - rowsTop) / 5.0f;
    float rowH     = rowSpan;
    if (rowH > 40.0f) rowH = 40.0f;

    for (int r = 0; r < 5; ++r)
    {
        float ry = rowsTop + r * rowSpan;
        // icon chip
        dl->AddRectFilled(ImVec2(sbX + 14, ry + 2),
                          ImVec2(sbX + 42, ry + rowH - 2),
                          IM_COL32(30, 70, 120, 240), 6.0f);
        ImVec2 isz = font->CalcTextSizeA(15.0f, FLT_MAX, 0.0f, rows[r].ico);
        dl->AddText(font, 15.0f,
                    ImVec2(sbX + 14 + (28 - isz.x) * 0.5f, ry + (rowH - 15.0f) * 0.5f),
                    kF_Accent, rows[r].ico);
        // label
        dl->AddText(font, 15.0f, ImVec2(sbX + 50, ry + (rowH - 15.0f) * 0.5f),
                    kF_TextDim, rows[r].lbl);
        // value (right-aligned)
        ImVec2 vsz = font->CalcTextSizeA(15.0f, FLT_MAX, 0.0f, rows[r].val);
        dl->AddText(font, 15.0f,
                    ImVec2(sbX + sbW - 14 - vsz.x, ry + (rowH - 15.0f) * 0.5f),
                    rows[r].vcol, rows[r].val);
    }

    // ---------------- App tiles (4 horizontal cards: icon + text) -------
    float tX = sbX + sbW + 14;
    float tY = bdY;
    float tW = bdX + bdW - tX;
    float tH = bdH;
    float gap = 12.0f;
    float colW = (tW - gap) * 0.5f;
    float rowTH = (tH - gap) * 0.5f;

    struct Opt {
        const char* l; const char* d; const char* ico;
        ImU32 c1; ImU32 c2; ImU32 accent; const char* badge;
    };
    Opt opts[4];
    opts[0] = { "LICENSE", "30 / 60 / 90 days", "الرخص",
                IM_COL32(40, 120, 200, 255), IM_COL32(20, 60, 110, 255),
                IM_COL32(120, 220, 255, 255),
                m_shopHasLic ? "ACTIVE" : "REQUIRED" };
    opts[1] = { "الطُعم", "10$ each, up to 20", "الطُعم",
                IM_COL32(200, 130, 60, 255), IM_COL32(110, 60, 20, 255),
                IM_COL32(255, 200, 120, 255),
                m_shopBait > 0 ? "STOCKED" : "EMPTY" };
    opts[2] = { "السنارة", "Single-use rod", "السنارة",
                IM_COL32(160, 90, 200, 255), IM_COL32(80, 40, 120, 255),
                IM_COL32(220, 180, 255, 255),
                m_shopHasRod ? "EQUIPPED" : "NEEDED" };
    if (m_shopWorking) {
        opts[3] = { "FINISH", "Collect earnings", "END",
                    IM_COL32(200, 80, 80, 255), IM_COL32(110, 30, 30, 255),
                    IM_COL32(255, 180, 180, 255), "ACTIVE" };
    } else {
        opts[3] = { "START", "Needs rod + bait", "GO",
                    IM_COL32(60, 180, 100, 255), IM_COL32(20, 100, 50, 255),
                    IM_COL32(180, 255, 200, 255), "READY" };
    }

    for (int i = 0; i < 4; ++i)
    {
        int r = i / 2, c = i % 2;
        float x = tX + c * (colW + gap);
        float y = tY + r * (rowTH + gap);
        ImVec2 a(x, y), b(x + colW, y + rowTH);
        bool insideNow = PointInRect(io.MousePos, a, b);
        bool pressing  = insideNow && io.MouseDown[0];
        bool clicked   = insideNow && ImGui::IsMouseClicked(0);

        // Background gradient.
        if (!pressing)
            dl->AddRectFilledMultiColor(a, b,
                opts[i].c1, opts[i].c1, opts[i].c2, opts[i].c2);
        else
            dl->AddRectFilled(a, b, opts[i].c2, 14.0f);
        dl->AddRect(a, b,
                    insideNow ? opts[i].accent : IM_COL32(255,255,255,60),
                    14.0f, 0, insideNow ? 2.5f : 1.5f);

        // Top sheen stripe.
        dl->AddRectFilledMultiColor(
            ImVec2(a.x + 4, a.y + 4),
            ImVec2(b.x - 4, a.y + 36),
            IM_COL32(255, 255, 255, 28),
            IM_COL32(255, 255, 255, 28),
            IM_COL32(255, 255, 255, 0),
            IM_COL32(255, 255, 255, 0));

        // ---------- Horizontal layout: icon | text -----------------
        float h = b.y - a.y;
        // Icon chip (square, vertically centred on the LEFT).
        float icSz = h * 0.62f;
        if (icSz > 78.0f) icSz = 78.0f;
        if (icSz < 48.0f) icSz = 48.0f;
        float icX = a.x + 14.0f;
        float icY = a.y + (h - icSz) * 0.5f;
        dl->AddRectFilled(ImVec2(icX, icY),
                          ImVec2(icX + icSz, icY + icSz),
                          IM_COL32(0, 0, 0, 130), 12.0f);
        dl->AddRect(ImVec2(icX, icY),
                    ImVec2(icX + icSz, icY + icSz),
                    opts[i].accent, 12.0f, 0, 1.5f);
        float icoFs = icSz * 0.32f;
        ImVec2 icosz = font->CalcTextSizeA(icoFs, FLT_MAX, 0.0f, opts[i].ico);
        dl->AddText(font, icoFs,
                    ImVec2(icX + (icSz - icosz.x) * 0.5f,
                           icY + (icSz - icoFs) * 0.5f),
                    opts[i].accent, opts[i].ico);

        // Text column to the right of the icon.
        float txX = icX + icSz + 16.0f;
        float txW = b.x - 14.0f - txX;
        // Title — auto-shrink to fit txW (keep padding for badge).
        float lblFs = 30.0f;
        ImVec2 lsz  = font->CalcTextSizeA(lblFs, FLT_MAX, 0.0f, opts[i].l);
        while (lsz.x > txW && lblFs > 18.0f)
        {
            lblFs -= 1.0f;
            lsz   = font->CalcTextSizeA(lblFs, FLT_MAX, 0.0f, opts[i].l);
        }
        dl->AddText(font, lblFs,
                    ImVec2(txX, a.y + h * 0.5f - lblFs - 2),
                    IM_COL32(255, 255, 255, 250), opts[i].l);
        dl->AddText(font, 13.0f,
                    ImVec2(txX, a.y + h * 0.5f + 6),
                    IM_COL32(230, 240, 250, 220), opts[i].d);

        // Top-right status badge.
        if (opts[i].badge && *opts[i].badge)
        {
            ImVec2 bsz = font->CalcTextSizeA(10.0f, FLT_MAX, 0.0f, opts[i].badge);
            float bw = bsz.x + 14.0f;
            ImVec2 ba(b.x - bw - 8, a.y + 8);
            ImVec2 bb(b.x - 8,      a.y + 26);
            dl->AddRectFilled(ba, bb, IM_COL32(0, 0, 0, 160), 6.0f);
            dl->AddRect(ba, bb, opts[i].accent, 6.0f, 0, 1.0f);
            dl->AddText(font, 10.0f,
                        ImVec2(ba.x + 7, ba.y + 4),
                        opts[i].accent, opts[i].badge);
        }

        if (clicked) { SendPick(i); return; }
    }

    // =========================================================
    //  DOCK / TASKBAR  (single line, EXIT button right)
    // =========================================================
    float dkY = wnY + wnH - DK_H - 4;
    dl->AddLine(ImVec2(wnX + 16, dkY),
                ImVec2(wnX + wnW - 16, dkY),
                kF_BorderDim, 1.0f);
    dl->AddText(font, 11.0f, ImVec2(wnX + 16, dkY + 12),
                kF_TextMuted,
                "Tap a tile to enter the menu  ·  Earn $ · Trip · Repeat");

    float ebW = 130.0f, ebH = DK_H - 10.0f;
    if (BigButton("خروج",
                  wnX + wnW - ebW - 16, dkY + 5, ebW, ebH,
                  IM_COL32(150, 40, 40, 240), IM_COL32(220, 70, 70, 240)))
    {
        SendCancel();
    }
}

// ---- shared polished chrome for sub-dialogs --------------------------------
//
// Draws drop-shadow, outer dark bezel, marine inner gradient, subtle
// scanlines, top-left HAVANA brand pill, optional top-right money chip,
// and a slow animated marina wave at the bottom. Called at the start of
// the License / Bait / Rod / Boat panels to give them the same elegant
// "console" framing as the main shop window.
void CFishermanOverlay::DrawPanelFrame(float x, float y, float w, float h,
                                        const char* brand, const char* subtitle,
                                        bool showMoneyChip)
{
    ImDrawList* dl   = ImGui::GetOverlayDrawList();
    ImFont*     font = pGUI ? pGUI->GetFont() : ImGui::GetFont();

    // Soft drop shadow under the panel.
    dl->AddRectFilled(ImVec2(x - 22, y + 18),
                      ImVec2(x + w + 22, y + h + 30),
                      IM_COL32(0, 0, 0, 200), 24.0f);

    // Outer dark bezel.
    dl->AddRectFilled(ImVec2(x - 8, y - 8),
                      ImVec2(x + w + 8, y + h + 8),
                      IM_COL32(10, 12, 16, 255), 22.0f);
    dl->AddRect(ImVec2(x - 8, y - 8),
                ImVec2(x + w + 8, y + h + 8),
                IM_COL32(60, 80, 110, 200), 22.0f, 0, 1.5f);

    // Inner marine gradient.
    dl->AddRectFilledMultiColor(
        ImVec2(x, y), ImVec2(x + w, y + h),
        IM_COL32(14, 30, 54, 250), IM_COL32(10, 22, 42, 250),
        IM_COL32( 6, 14, 28, 255), IM_COL32( 8, 18, 34, 255));
    dl->AddRect(ImVec2(x, y), ImVec2(x + w, y + h),
                kF_Border, 18.0f, 0, 2.5f);

    // Scanline sheen.
    for (int i = 0; i < 6; ++i)
    {
        float yy = y + (h / 6.0f) * i;
        dl->AddLine(ImVec2(x + 8, yy), ImVec2(x + w - 8, yy),
                    IM_COL32(255, 255, 255, 5), 1.0f);
    }

    // Accent line under the title area.
    dl->AddLine(ImVec2(x + 24, y + 110),
                ImVec2(x + w - 24, y + 110), kF_BorderDim, 1.5f);

    // Top-left brand pill.
    const char* brandText = brand ? brand : "HAVANA FISHING";
    ImVec2 bsz = font->CalcTextSizeA(20.0f, FLT_MAX, 0.0f, brandText);
    float  pillW = bsz.x + 28.0f;
    dl->AddRectFilled(ImVec2(x + 20, y + 18),
                      ImVec2(x + 20 + pillW, y + 50),
                      IM_COL32(20, 60, 110, 230), 10.0f);
    dl->AddText(font, 20.0f, ImVec2(x + 34, y + 24),
                kF_Accent, brandText);

    // Top-right money chip.
    if (showMoneyChip)
    {
        char moneyChip[32];
        FmtMoney(m_shopMoney, moneyChip, sizeof(moneyChip));
        ImVec2 mcsz = font->CalcTextSizeA(20.0f, FLT_MAX, 0.0f, moneyChip);
        float  mcW = mcsz.x + 32.0f;
        dl->AddRectFilled(ImVec2(x + w - mcW - 20, y + 18),
                          ImVec2(x + w - 20,       y + 50),
                          IM_COL32(20, 60, 40, 230), 10.0f);
        dl->AddText(font, 20.0f,
                    ImVec2(x + w - mcW - 20 + 16, y + 24),
                    kF_Green, moneyChip);
    }

    // Centered title + subtitle.
    if (brand)
    {
        ImVec2 ts = font->CalcTextSizeA(38.0f, FLT_MAX, 0.0f, brand);
        dl->AddText(font, 38.0f,
                    ImVec2(x + (w - ts.x) * 0.5f, y + 56),
                    kF_Text, brand);
    }
    if (subtitle)
    {
        ImVec2 ss = font->CalcTextSizeA(18.0f, FLT_MAX, 0.0f, subtitle);
        dl->AddText(font, 18.0f,
                    ImVec2(x + (w - ss.x) * 0.5f, y + 86),
                    kF_TextDim, subtitle);
    }

    // Subtle marina wave at the bottom.
    for (int i = 0; i < 60; ++i)
    {
        float fx1 = x + 16 + (w - 32) * i / 60.0f;
        float fx2 = x + 16 + (w - 32) * (i + 1) / 60.0f;
        float fy  = y + h - 22 + sinf(m_waterAnim * 1.2f + i * 0.4f) * 4.0f;
        dl->AddLine(ImVec2(fx1, fy), ImVec2(fx2, fy + 2), kF_Wave, 1.8f);
    }
}

// ---- LICENSE picker ---------------------------------------------------------

void CFishermanOverlay::RenderLicense()
{
    ImGuiIO& io = ImGui::GetIO();
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    ImFont* font = pGUI ? pGUI->GetFont() : ImGui::GetFont();

    float pW = 920.0f, pH = 740.0f;
    if (io.DisplaySize.x < pW + 80) pW = io.DisplaySize.x - 80;
    float pX = (io.DisplaySize.x - pW) * 0.5f;
    float pY = (io.DisplaySize.y - pH) * 0.5f;

    DrawPanelFrame(pX, pY, pW, pH,
                   "FISHING LICENSE", "Pick a duration", true);

    int n = (int)m_licOpts.size();
    if (n <= 0) n = 1;
    float listTop  = pY + 150;
    float listBot  = pY + pH - 130;
    float gap      = 16.0f;
    float ch       = (listBot - listTop - (n - 1) * gap) / (float)n;
    if (ch > 150.0f) ch = 150.0f;
    if (ch < 90.0f)  ch = 90.0f;

    for (int i = 0; i < (int)m_licOpts.size(); ++i)
    {
        float cx = pX + 40;
        float cw = pW - 80;
        ImVec2 a(cx, listTop + i * (ch + gap));
        ImVec2 b(a.x + cw, a.y + ch);
        bool insideNow = PointInRect(io.MousePos, a, b);
        bool pressing  = insideNow && io.MouseDown[0];
        bool clicked   = insideNow && ImGui::IsMouseClicked(0);

        // Card body with subtle vertical gradient, hover lifts it.
        ImU32 top = pressing ? IM_COL32(56, 96, 150, 250)
                  : (insideNow ? IM_COL32(40, 78, 124, 250)
                              : IM_COL32(28,  54,  88, 240));
        ImU32 bot = pressing ? IM_COL32(34, 60,  98, 250)
                  : (insideNow ? IM_COL32(22, 44,  74, 250)
                              : IM_COL32(16,  32,  56, 240));
        dl->AddRectFilledMultiColor(a, b, top, top, bot, bot);
        dl->AddRect(a, b, insideNow ? kF_Border : kF_BorderDim,
                    14.0f, 0, insideNow ? 2.5f : 1.8f);

        // Left accent bar.
        dl->AddRectFilled(ImVec2(a.x + 4, a.y + 12),
                          ImVec2(a.x + 10, b.y - 12),
                          kF_Accent, 4.0f);

        // Days
        char L[48], R[48], sub[64];
        snprintf(L, sizeof(L), "%d  days", m_licOpts[i].days);
        FmtMoney(m_licOpts[i].price, R, sizeof(R));
        // Per-day price hint
        int perDay = (m_licOpts[i].days > 0)
                     ? (m_licOpts[i].price / m_licOpts[i].days) : 0;
        char perDayBuf[32]; FmtMoney(perDay, perDayBuf, sizeof(perDayBuf));
        snprintf(sub, sizeof(sub), "%s / day", perDayBuf);

        dl->AddText(font, 52.0f,
                    ImVec2(a.x + 28, a.y + (ch - 70) * 0.5f),
                    kF_Text, L);
        dl->AddText(font, 18.0f,
                    ImVec2(a.x + 28, a.y + (ch - 70) * 0.5f + 56),
                    kF_TextDim, sub);

        ImVec2 rs = font->CalcTextSizeA(48.0f, FLT_MAX, 0.0f, R);
        dl->AddText(font, 48.0f,
            ImVec2(b.x - 32 - rs.x, a.y + (ch - 48) * 0.5f),
            kF_Gold, R);

        if (clicked) { SendPick(i); return; }
    }

    if (BigButton("رجوع", pX + 40, pY + pH - 90, 220, 60,
                  IM_COL32(60, 60, 60, 240), IM_COL32(100, 100, 100, 240)))
    {
        SendCancel();
    }
}

// ---- BAIT quantity picker (stepper) ----------------------------------------

void CFishermanOverlay::RenderBait()
{
    ImGuiIO& io = ImGui::GetIO();
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    ImFont* font = pGUI ? pGUI->GetFont() : ImGui::GetFont();

    float pW = 920.0f, pH = 660.0f;
    if (io.DisplaySize.x < pW + 80) pW = io.DisplaySize.x - 80;
    float pX = (io.DisplaySize.x - pW) * 0.5f;
    float pY = (io.DisplaySize.y - pH) * 0.5f;

    char subtitleBuf[64];
    snprintf(subtitleBuf, sizeof(subtitleBuf),
             "$%d each -- pick a quantity", m_baitUnitPrice);
    DrawPanelFrame(pX, pY, pW, pH, "الطُعم", subtitleBuf, true);

    char buf[64];
    // Row:  [-10] [-1]   QTY   [+1] [+10]
    float sy = pY + 270;
    float bW = 90, bH = 90;

    // -10
    if (BigButton("-10", pX + 40, sy, bW, bH,
                  IM_COL32(40, 90, 140, 240), IM_COL32(70, 130, 190, 240)))
    {
        m_baitQty -= 10; if (m_baitQty < 1) m_baitQty = 1;
    }
    // -1
    if (BigButton("-1", pX + 40 + bW + 10, sy, bW, bH,
                  IM_COL32(40, 90, 140, 240), IM_COL32(70, 130, 190, 240)))
    {
        if (m_baitQty > 1) m_baitQty--;
    }
    // +1
    if (BigButton("+1", pX + pW - 40 - bW*2 - 10, sy, bW, bH,
                  IM_COL32(40, 90, 140, 240), IM_COL32(70, 130, 190, 240)))
    {
        if (m_baitQty < m_baitMaxQty) m_baitQty++;
    }
    // +10
    if (BigButton("+10", pX + pW - 40 - bW, sy, bW, bH,
                  IM_COL32(40, 90, 140, 240), IM_COL32(70, 130, 190, 240)))
    {
        m_baitQty += 10;
        if (m_baitQty > m_baitMaxQty) m_baitQty = m_baitMaxQty;
    }

    // Quantity display inside a soft pill so it looks like a counter.
    snprintf(buf, sizeof(buf), "%d", m_baitQty);
    ImVec2 ts = font->CalcTextSizeA(130.0f, FLT_MAX, 0.0f, buf);
    float qtyPillW = ts.x + 60.0f;
    if (qtyPillW < 200.0f) qtyPillW = 200.0f;
    float qtyX = pX + (pW - qtyPillW) * 0.5f;
    float qtyY = sy - 28;
    dl->AddRectFilled(ImVec2(qtyX, qtyY),
                      ImVec2(qtyX + qtyPillW, qtyY + 150),
                      IM_COL32(18, 40, 70, 220), 18.0f);
    dl->AddRect(ImVec2(qtyX, qtyY),
                ImVec2(qtyX + qtyPillW, qtyY + 150),
                kF_BorderDim, 18.0f, 0, 1.5f);
    dl->AddText(font, 130.0f,
                ImVec2(pX + (pW - ts.x) * 0.5f, sy - 16),
                kF_Accent, buf);

    // Total — right-aligned chip with label underneath.
    int total = m_baitQty * m_baitUnitPrice;
    char priceBuf[48]; FmtMoney(total, priceBuf, sizeof(priceBuf));
    ImVec2 totSz = font->CalcTextSizeA(40.0f, FLT_MAX, 0.0f, priceBuf);
    float totX = pX + pW - 40 - totSz.x;
    float totY = sy + 150;
    dl->AddText(font, 18.0f, ImVec2(totX, totY - 6),
                kF_TextMuted, "المجموع");
    dl->AddText(font, 40.0f, ImVec2(totX, totY + 14),
                kF_Gold, priceBuf);

    // Hint, left-aligned beside the total label.
    dl->AddText(font, 16.0f, ImVec2(pX + 40, totY + 14),
                kF_TextDim,
                "Tap +/- to adjust the quantity.");

    // Buy / Back
    if (BigButton("BUY", pX + pW - 260, pY + pH - 110, 220, 70,
                  IM_COL32(40, 140, 60, 240), IM_COL32(70, 180, 90, 240)))
    {
        snprintf(buf, sizeof(buf), "%d", m_baitQty);
        SendInput(buf);
    }
    if (BigButton("رجوع", pX + 40, pY + pH - 90, 220, 60,
                  IM_COL32(60, 60, 60, 240), IM_COL32(100, 100, 100, 240)))
    {
        SendCancel();
    }
}

// ---- ROD confirm ------------------------------------------------------------

void CFishermanOverlay::RenderRod()
{
    ImGuiIO& io = ImGui::GetIO();
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    ImFont* font = pGUI ? pGUI->GetFont() : ImGui::GetFont();

    float pW = 820.0f, pH = 580.0f;
    if (io.DisplaySize.x < pW + 80) pW = io.DisplaySize.x - 80;
    float pX = (io.DisplaySize.x - pW) * 0.5f;
    float pY = (io.DisplaySize.y - pH) * 0.5f;

    DrawPanelFrame(pX, pY, pW, pH,
                   "FISHING ROD", "Premium carbon rod", true);

    // Stylized rod, centered horizontally inside the panel.
    float cx = pX + pW * 0.5f - 200.0f;
    float cy = pY + 320.0f;
    dl->AddLine(ImVec2(cx, cy), ImVec2(cx + 400, cy - 60),
                IM_COL32(210, 170, 70, 255), 6.0f);
    dl->AddCircleFilled(ImVec2(cx, cy), 14.0f, IM_COL32(70, 50, 20, 255));
    dl->AddLine(ImVec2(cx + 400, cy - 60), ImVec2(cx + 410, cy + 120),
                IM_COL32(240, 240, 240, 180), 2.0f);
    dl->AddCircle(ImVec2(cx + 412, cy + 122), 5.0f,
                  IM_COL32(240, 240, 240, 220), 12, 1.8f);

    // Price chip, right-aligned.
    char pbuf[48]; FmtMoney(m_rodPrice, pbuf, sizeof(pbuf));
    ImVec2 ps = font->CalcTextSizeA(48.0f, FLT_MAX, 0.0f, pbuf);
    float chipW = ps.x + 56.0f;
    float chipX = pX + pW - chipW - 40.0f;
    float chipY = pY + 150.0f;
    dl->AddRectFilled(ImVec2(chipX, chipY),
                      ImVec2(chipX + chipW, chipY + 70),
                      IM_COL32(18, 40, 70, 220), 14.0f);
    dl->AddRect(ImVec2(chipX, chipY),
                ImVec2(chipX + chipW, chipY + 70),
                kF_BorderDim, 14.0f, 0, 1.5f);
    dl->AddText(font, 48.0f,
                ImVec2(chipX + 28, chipY + 12), kF_Gold, pbuf);
    dl->AddText(font, 16.0f,
                ImVec2(chipX, chipY - 22), kF_TextMuted, "السعر");

    // Description card, left-aligned.
    dl->AddText(font, 22.0f, ImVec2(pX + 40, pY + 160),
                kF_Text, "صنارة كربون لاستخدام واحد");
    dl->AddText(font, 18.0f, ImVec2(pX + 40, pY + 192),
                kF_TextDim,
                "The rod is consumed when you end the fishing trip.");

    if (BigButton("BUY", pX + pW - 280, pY + pH - 110, 220, 70,
                  IM_COL32(40, 140, 60, 240), IM_COL32(70, 180, 90, 240)))
        SendOk();
    if (BigButton("رجوع", pX + 40, pY + pH - 90, 220, 60,
                  IM_COL32(60, 60, 60, 240), IM_COL32(100, 100, 100, 240)))
        SendCancel();
}

// ---- BOAT confirm -----------------------------------------------------------

void CFishermanOverlay::RenderBoat()
{
    ImGuiIO& io = ImGui::GetIO();
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    ImFont* font = pGUI ? pGUI->GetFont() : ImGui::GetFont();

    float pW = 920.0f, pH = 660.0f;
    if (io.DisplaySize.x < pW + 80) pW = io.DisplaySize.x - 80;
    float pX = (io.DisplaySize.x - pW) * 0.5f;
    float pY = (io.DisplaySize.y - pH) * 0.5f;

    DrawPanelFrame(pX, pY, pW, pH,
                   "RENT A BOAT",
                   "Sail to the red zone and start fishing", true);

    // Boat silhouette, lifted higher so the price chip + buttons sit clean.
    float cx = pX + pW * 0.5f, cy = pY + pH * 0.5f + 20.0f;
    dl->AddTriangleFilled(ImVec2(cx - 160, cy + 20), ImVec2(cx + 160, cy + 20),
                          ImVec2(cx + 120, cy + 70),
                          IM_COL32(220, 210, 200, 255));
    dl->AddTriangleFilled(ImVec2(cx - 160, cy + 20), ImVec2(cx + 120, cy + 70),
                          ImVec2(cx - 120, cy + 70),
                          IM_COL32(220, 210, 200, 255));
    dl->AddRectFilled(ImVec2(cx - 30, cy - 60), ImVec2(cx + 30, cy + 20),
                      IM_COL32(180, 170, 160, 255));
    dl->AddLine(ImVec2(cx, cy - 60), ImVec2(cx, cy - 140),
                IM_COL32(90, 90, 90, 255), 3.0f);
    dl->AddTriangleFilled(ImVec2(cx, cy - 140), ImVec2(cx + 50, cy - 110),
                          ImVec2(cx, cy - 80),
                          IM_COL32(220, 90, 80, 230));
    // Water under boat
    for (int i = 0; i < 40; ++i)
    {
        float fx1 = pX + 30 + (pW - 60) * i / 40.0f;
        float fx2 = pX + 30 + (pW - 60) * (i + 1) / 40.0f;
        float yy  = cy + 90 + sinf(m_waterAnim * 2.0f + i * 0.4f) * 6.0f;
        dl->AddLine(ImVec2(fx1, yy), ImVec2(fx2, yy + 2), kF_Wave, 3.0f);
    }

    // Price chip, right-aligned at the top.
    char pbuf[48]; FmtMoney(m_boatPrice, pbuf, sizeof(pbuf));
    ImVec2 ps = font->CalcTextSizeA(46.0f, FLT_MAX, 0.0f, pbuf);
    float chipW = ps.x + 56.0f;
    float chipX = pX + pW - chipW - 40.0f;
    float chipY = pY + 150.0f;
    dl->AddRectFilled(ImVec2(chipX, chipY),
                      ImVec2(chipX + chipW, chipY + 70),
                      IM_COL32(18, 40, 70, 220), 14.0f);
    dl->AddRect(ImVec2(chipX, chipY),
                ImVec2(chipX + chipW, chipY + 70),
                kF_BorderDim, 14.0f, 0, 1.5f);
    dl->AddText(font, 46.0f,
                ImVec2(chipX + 28, chipY + 12), kF_Gold, pbuf);
    dl->AddText(font, 16.0f,
                ImVec2(chipX, chipY - 22), kF_TextMuted, "إيجار");

    dl->AddText(font, 22.0f, ImVec2(pX + 40, pY + 160),
                kF_Text, "قارب ممتلئ وقود وجاهز للإبحار.");
    dl->AddText(font, 18.0f, ImVec2(pX + 40, pY + 192),
                kF_TextDim,
                "Returns to the marina when the trip ends.");

    if (BigButton("أجّر", pX + pW - 280, pY + pH - 110, 220, 70,
                  IM_COL32(40, 140, 60, 240), IM_COL32(70, 180, 90, 240)))
        SendOk();
    if (BigButton("رجوع", pX + 40, pY + pH - 90, 220, 60,
                  IM_COL32(60, 60, 60, 240), IM_COL32(100, 100, 100, 240)))
        SendCancel();
}

// ---- CAST (underwater minigame) --------------------------------------------

void CFishermanOverlay::RenderCast()
{
    ImGuiIO& io = ImGui::GetIO();
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    ImFont* font = pGUI ? pGUI->GetFont() : ImGui::GetFont();

    // Full-screen underwater view
    float pW = io.DisplaySize.x * 0.96f;
    float pH = io.DisplaySize.y * 0.92f;
    float pX = (io.DisplaySize.x - pW) * 0.5f;
    float pY = (io.DisplaySize.y - pH) * 0.5f;

    UnderwaterBackdrop(pX, pY, pW, pH, m_waterAnim);
    dl->AddRect(ImVec2(pX, pY), ImVec2(pX + pW, pY + pH),
                kF_Border, 18.0f, 0, 3.0f);

    // Caustics (moving light pattern on the sea floor)
    for (int i = 0; i < 40; ++i)
    {
        float phase = m_waterAnim * 0.8f + i * 0.35f;
        float cx = pX + pW * ((0.5f + 0.5f * sinf(phase)) * 0.9f + 0.05f
                              + (i % 5) * 0.12f - 0.24f);
        float cy = pY + pH * (0.68f + 0.20f * cosf(phase * 0.6f + i));
        if (cx < pX || cx > pX + pW) continue;
        float r = 24.0f + 8.0f * sinf(phase * 1.3f);
        dl->AddCircle(ImVec2(cx, cy), r,
                      IM_COL32(180, 230, 255, 22), 12, 1.5f);
    }

    // Swimming fish (with shimmering body + tail)
    for (int i = 0; i < (int)m_fishSwimX.size(); ++i)
    {
        m_fishSwimX[i] += m_fishSwimVX[i] * io.DeltaTime * 0.25f;
        if (m_fishSwimX[i] < -0.1f) m_fishSwimX[i] = 1.1f;
        if (m_fishSwimX[i] >  1.1f) m_fishSwimX[i] = -0.1f;
        float fx = pX + pW * m_fishSwimX[i];
        float fy = pY + pH * m_fishSwimY[i]
                 + sinf(m_waterAnim * 1.5f + i) * 12.0f;
        float s = 20.0f + (i % 3) * 4.0f;
        float dir = (m_fishSwimVX[i] > 0 ? 1.0f : -1.0f);

        // body with gradient sheen
        ImU32 bcBody = IM_COL32(240, 235, 200, 235);
        ImU32 bcBelly= IM_COL32(255, 250, 230, 220);
        for (int k = 0; k < 14; ++k)
        {
            float a = (float)k / 14.0f * 3.14159265f;
            float rx = cosf(a) * s * dir;
            float ry = sinf(a) * s * 0.5f;
            dl->AddCircleFilled(ImVec2(fx + rx, fy + ry),
                                2.6f, k < 7 ? bcBody : bcBelly);
            dl->AddCircleFilled(ImVec2(fx + rx, fy - ry),
                                2.6f, bcBody);
        }
        // eye
        dl->AddCircleFilled(ImVec2(fx + dir * s * 0.6f, fy - 4.0f),
                            2.2f, IM_COL32(20, 20, 20, 255));
        // tail (wobbles)
        float tailWob = sinf(m_waterAnim * 6.0f + i) * 6.0f;
        dl->AddTriangleFilled(
            ImVec2(fx - dir * s * 0.9f, fy),
            ImVec2(fx - dir * (s + 14), fy - 12 + tailWob),
            ImVec2(fx - dir * (s + 14), fy + 12 + tailWob),
            bcBody);
    }

    // Rod-throw animation: first 700ms the hook falls from above.
    float castT = m_animT;   // 0..1 progression (from entering state)
    float lineX = pX + pW * 0.74f;
    float lineY0 = pY + 10;
    float fallTo = pY + pH * 0.78f + sinf(m_waterAnim * 2.0f) * 6.0f;
    float lineY1;
    if (castT < 1.0f) {
        // ease-in fall
        float k = castT * castT * (3.0f - 2.0f * castT);
        lineY1 = lineY0 + (fallTo - lineY0) * k;
    } else {
        lineY1 = fallTo;
    }

    // Rod line
    dl->AddLine(ImVec2(lineX, lineY0), ImVec2(lineX, lineY1),
                IM_COL32(240, 240, 240, 220), 2.0f);
    // splash ring when the hook reaches the surface midpoint
    if (castT > 0.3f && castT < 0.55f)
    {
        float sp = (castT - 0.3f) / 0.25f;
        dl->AddCircle(ImVec2(lineX, fallTo - 40.0f),
                      8.0f + sp * 28.0f,
                      IM_COL32(255, 255, 255, (int)(200 * (1.0f - sp))),
                      18, 2.0f);
    }
    // Hook + bobber
    dl->AddCircleFilled(ImVec2(lineX, lineY1), 5.0f, kF_Gold);
    dl->AddCircle(ImVec2(lineX + 6, lineY1 + 10), 10.0f,
                  IM_COL32(200, 200, 200, 230), 12, 2.0f);

    // Header + subtitle
    const char* hdr = "FISHING ZONE";
    const char* sub;
    if (!m_castInZone)        sub = "Sail to the red zone on the map";
    else if (!m_castOnBoat)   sub = "Board your boat and stop inside the zone";
    else if (m_castBait <= 0) sub = "Out of bait — head back to the fisherman";
    else                      sub = "Line in the water — wait for a bite...";
    TitleStrip(hdr, sub, pX + 16, pY + 16, pW - 32);

    // Status ribbons (chip style, always contained)
    auto Chip = [&](float cx, float cy, const char* lbl, const char* val,
                    ImU32 valCol)
    {
        ImVec2 lsz = font->CalcTextSizeA(22.0f, FLT_MAX, 0.0f, lbl);
        ImVec2 vsz = font->CalcTextSizeA(26.0f, FLT_MAX, 0.0f, val);
        float w = lsz.x + vsz.x + 48.0f, h = 48.0f;
        dl->AddRectFilled(ImVec2(cx, cy), ImVec2(cx + w, cy + h),
                          IM_COL32(0, 0, 0, 170), 10.0f);
        dl->AddRect(ImVec2(cx, cy), ImVec2(cx + w, cy + h),
                    kF_BorderDim, 10.0f, 0, 1.5f);
        dl->AddText(font, 22.0f, ImVec2(cx + 16, cy + 12), kF_TextDim, lbl);
        dl->AddText(font, 26.0f,
                    ImVec2(cx + w - vsz.x - 16, cy + 10), valCol, val);
    };
    char cb[32], cf[32], cm[40];
    snprintf(cb, sizeof(cb), "%d", m_castBait);
    snprintf(cf, sizeof(cf), "%d", m_castBag);
    FmtMoney(m_castMoney, cm, sizeof(cm));
    Chip(pX + 30,  pY + 140, "الطُعم",   cb, kF_Gold);
    Chip(pX + 230, pY + 140, "FISH",   cf, kF_Text);
    Chip(pX + 410, pY + 140, "EARNED", cm, kF_Green);

    // End button
    if (BigButton("END JOB",
                  pX + 40, pY + pH - 120, 280, 90,
                  IM_COL32(140, 50, 50, 240),
                  IM_COL32(180, 70, 70, 240)))
    {
        SendCancel();
    }

    // Big center "WAITING" indicator while hook settles
    if (castT >= 1.0f)
    {
        const char* wait = "WAITING FOR A BITE...";
        ImVec2 ws = font->CalcTextSizeA(36.0f, FLT_MAX, 0.0f, wait);
        float wy = pY + pH * 0.35f;
        // soft backer
        dl->AddRectFilled(ImVec2(pX + (pW - ws.x) * 0.5f - 18, wy - 10),
                          ImVec2(pX + (pW + ws.x) * 0.5f + 18, wy + ws.y + 14),
                          IM_COL32(0, 0, 0, 150), 10.0f);
        dl->AddText(font, 36.0f,
                    ImVec2(pX + (pW - ws.x) * 0.5f, wy),
                    kF_Accent, wait);
        // progress dots
        int dotCount = (int)(m_waterAnim * 3.0f) % 4;
        for (int i = 0; i < 3; ++i)
        {
            float dx = pX + pW * 0.5f + (i - 1) * 18.0f;
            float dy = wy + ws.y + 36.0f;
            dl->AddCircleFilled(ImVec2(dx, dy), 5.0f,
                                i < dotCount ? kF_Accent : IM_COL32(60, 80, 110, 200));
        }
    }
}

// ---- RESULT (popup after cast) ---------------------------------------------

void CFishermanOverlay::RenderResult()
{
    ImGuiIO& io = ImGui::GetIO();
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    ImFont* font = pGUI ? pGUI->GetFont() : ImGui::GetFont();

    float pW = 1000.0f, pH = 640.0f;
    if (io.DisplaySize.x < pW + 40) pW = io.DisplaySize.x - 40;
    float pX = (io.DisplaySize.x - pW) * 0.5f;
    float pY = (io.DisplaySize.y - pH) * 0.5f;

    // Panel
    float pop = 1.0f - (1.0f - m_rsShowT) * (1.0f - m_rsShowT);
    ImVec2 a(pX, pY - (1.0f - pop) * 40.0f);
    ImVec2 b(pX + pW, a.y + pH);
    dl->AddRectFilled(a, b, kF_Bg, 22.0f);
    dl->AddRect(a, b, m_rsIsCatch ? kF_Gold : kF_Border, 22.0f, 0, 3.0f);

    TitleStrip(m_rsIsCatch ? "مسكت سمكة!" : "ما طلع شي",
               m_rsIsCatch ? "Nice hook!" : "Better luck next cast",
               pX + 16, a.y + 16, pW - 32);

    if (m_rsIsCatch)
    {
        // fish icon (stylized)
        float cx = pX + pW * 0.5f;
        float cy = a.y + pH * 0.5f;
        ImU32 fc = m_rsRare ? kF_Gold : kF_Accent;
        float s = 100.0f + m_rsWeight * 6.0f;
        if (s > 180.0f) s = 180.0f;
        for (int k = 0; k < 12; ++k)
        {
            float ang = (float)k / 12.0f * 3.14159265f;
            dl->AddCircleFilled(ImVec2(cx + cosf(ang) * s,
                                       cy + sinf(ang) * s * 0.5f),
                                5.0f, fc);
        }
        dl->AddTriangleFilled(ImVec2(cx - s, cy),
            ImVec2(cx - s - 30.0f, cy - 26.0f),
            ImVec2(cx - s - 30.0f, cy + 26.0f), fc);
        dl->AddCircleFilled(ImVec2(cx + s * 0.7f, cy - 8.0f), 4.0f,
            IM_COL32(0, 0, 0, 255));

        // Texts
        char wbuf[32]; snprintf(wbuf, sizeof(wbuf), "%.1f kg", m_rsWeight);
        char pbuf[48]; FmtMoney(m_rsPrice, pbuf, sizeof(pbuf));
        ImVec2 ns = font->CalcTextSizeA(64.0f, FLT_MAX, 0.0f, m_rsName.c_str());
        dl->AddText(font, 64.0f, ImVec2(cx - ns.x * 0.5f, a.y + 150),
                    m_rsRare ? kF_Gold : kF_Accent, m_rsName.c_str());
        ImVec2 ws = font->CalcTextSizeA(42.0f, FLT_MAX, 0.0f, wbuf);
        dl->AddText(font, 42.0f, ImVec2(cx - ws.x * 0.5f, a.y + 230),
                    kF_TextDim, wbuf);
        ImVec2 ps = font->CalcTextSizeA(54.0f, FLT_MAX, 0.0f, pbuf);
        dl->AddText(font, 54.0f, ImVec2(cx - ps.x * 0.5f, a.y + pH - 220),
                    kF_Gold, pbuf);
        if (m_rsRare)
        {
            const char* tag = "RARE CATCH";
            ImVec2 ts = font->CalcTextSizeA(28.0f, FLT_MAX, 0.0f, tag);
            dl->AddText(font, 28.0f, ImVec2(cx - ts.x * 0.5f, a.y + pH - 160),
                        kF_Gold, tag);
        }
    }
    else
    {
        const char* msg = "The fish got away...";
        ImVec2 ts = font->CalcTextSizeA(46.0f, FLT_MAX, 0.0f, msg);
        dl->AddText(font, 46.0f,
            ImVec2(pX + (pW - ts.x) * 0.5f, a.y + pH * 0.5f - 20),
            kF_TextDim, msg);
    }

    // Buttons
    if (BigButton("متابعة", pX + pW - 320, a.y + pH - 90, 280, 70,
                  IM_COL32(40, 140, 60, 240), IM_COL32(70, 180, 90, 240)))
    {
        SendOk();
    }
    if (BigButton("END", pX + 40, a.y + pH - 90, 220, 70,
                  IM_COL32(140, 50, 50, 240), IM_COL32(180, 70, 70, 240)))
    {
        SendCancel();
    }
}

// ---- STATS (end of work summary) -------------------------------------------

void CFishermanOverlay::RenderStats()
{
    ImGuiIO& io = ImGui::GetIO();
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    ImFont* font = pGUI ? pGUI->GetFont() : ImGui::GetFont();

    float pW = io.DisplaySize.x * 0.85f;
    float pH = io.DisplaySize.y * 0.88f;
    if (pW > 1400.0f) pW = 1400.0f;
    float pX = (io.DisplaySize.x - pW) * 0.5f;
    float pY = (io.DisplaySize.y - pH) * 0.5f;

    dl->AddRectFilled(ImVec2(pX, pY), ImVec2(pX + pW, pY + pH), kF_Bg, 20.0f);
    dl->AddRect(ImVec2(pX, pY), ImVec2(pX + pW, pY + pH), kF_Gold, 20.0f, 0, 3.0f);

    TitleStrip("اكتمل شغل الصيد", "شغل ممتاز، يا كابتن!",
               pX + 16, pY + 16, pW - 32);

    // Totals card
    float cY = pY + 150;
    dl->AddRectFilled(ImVec2(pX + 30, cY),
                      ImVec2(pX + pW - 30, cY + 120), kF_Card, 14.0f);
    dl->AddRect(ImVec2(pX + 30, cY),
                ImVec2(pX + pW - 30, cY + 120), kF_BorderDim, 14.0f, 0, 2.0f);
    char buf[64];
    snprintf(buf, sizeof(buf), "%d", m_stTotalCount);
    dl->AddText(font, 28.0f, ImVec2(pX + 60, cY + 20), kF_TextDim, "السمك");
    dl->AddText(font, 56.0f, ImVec2(pX + 60, cY + 48), kF_Text,   buf);

    snprintf(buf, sizeof(buf), "%.1f kg", m_stTotalWeight);
    dl->AddText(font, 28.0f, ImVec2(pX + 340, cY + 20), kF_TextDim, "الوزن");
    dl->AddText(font, 56.0f, ImVec2(pX + 340, cY + 48), kF_Accent, buf);

    char mbuf[48]; FmtMoney(m_stTotalPrice, mbuf, sizeof(mbuf));
    dl->AddText(font, 28.0f, ImVec2(pX + 680, cY + 20), kF_TextDim, "الأرباح");
    dl->AddText(font, 56.0f, ImVec2(pX + 680, cY + 48), kF_Gold,    mbuf);

    // List
    float ly = cY + 150;
    float lh = 56.0f;
    int   visible = (int)((pY + pH - 150 - ly) / lh);
    for (int i = 0; i < (int)m_stRows.size() && i < visible; ++i)
    {
        const FishStatRow& r = m_stRows[i];
        ImU32 bgc = (i & 1) ? IM_COL32(20, 40, 64, 220)
                            : IM_COL32(16, 32, 52, 220);
        dl->AddRectFilled(ImVec2(pX + 30, ly),
                          ImVec2(pX + pW - 30, ly + lh - 8),
                          bgc, 8.0f);
        if (r.rare)
        {
            dl->AddRect(ImVec2(pX + 30, ly),
                        ImVec2(pX + pW - 30, ly + lh - 8),
                        kF_Gold, 8.0f, 0, 2.0f);
        }
        dl->AddText(font, 28.0f, ImVec2(pX + 60, ly + 10), kF_Text,
                    r.name.c_str());
        char wbuf[32]; snprintf(wbuf, sizeof(wbuf), "%.1f kg", r.weight);
        dl->AddText(font, 26.0f, ImVec2(pX + 450, ly + 12),
                    kF_TextDim, wbuf);
        char pb[48]; FmtMoney(r.price, pb, sizeof(pb));
        ImVec2 psz = font->CalcTextSizeA(28.0f, FLT_MAX, 0.0f, pb);
        dl->AddText(font, 28.0f,
            ImVec2(pX + pW - 60 - psz.x, ly + 10),
            r.rare ? kF_Gold : kF_Accent, pb);
        if (r.rare)
        {
            dl->AddText(font, 20.0f, ImVec2(pX + 260, ly + 18),
                        kF_Gold, "RARE");
        }
        ly += lh;
    }

    if (BigButton("OK", pX + pW - 260, pY + pH - 90, 220, 70,
                  IM_COL32(40, 140, 60, 240), IM_COL32(70, 180, 90, 240)))
    {
        SendOk();
    }
}

// ---- MSG --------------------------------------------------------------------

void CFishermanOverlay::RenderMessage()
{
    ImGuiIO& io = ImGui::GetIO();
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    ImFont* font = pGUI ? pGUI->GetFont() : ImGui::GetFont();

    float pW = 900.0f, pH = 400.0f;
    if (io.DisplaySize.x < pW + 40) pW = io.DisplaySize.x - 40;
    float pX = (io.DisplaySize.x - pW) * 0.5f;
    float pY = (io.DisplaySize.y - pH) * 0.5f;
    dl->AddRectFilled(ImVec2(pX, pY), ImVec2(pX + pW, pY + pH), kF_Bg, 20.0f);
    dl->AddRect(ImVec2(pX, pY), ImVec2(pX + pW, pY + pH), kF_Border, 20.0f, 0, 2.0f);
    TitleStrip("الصياد", "", pX + 16, pY + 16, pW - 32);

    dl->AddText(font, 32.0f, ImVec2(pX + 40, pY + 160), kF_TextDim,
                m_msg.c_str());

    if (BigButton("OK", pX + pW - 240, pY + pH - 90, 200, 70,
                  IM_COL32(40, 140, 60, 240), IM_COL32(70, 180, 90, 240)))
    {
        SendOk();
    }
}

// ---- HUD (in-zone cast button, non-blocking) --------------------------------

void CFishermanOverlay::RenderHud()
{
    // ---------------------------------------------------------------
    //  Circular icon-only CAST button (no background panel, like the
    //  small HUD boxes) anchored just above the bottom-center of the
    //  screen.  Tap once to throw the rod.
    // ---------------------------------------------------------------
    ImGuiIO&    io   = ImGui::GetIO();
    ImDrawList* dl   = ImGui::GetOverlayDrawList();
    ImFont*     font = pGUI ? pGUI->GetFont() : ImGui::GetFont();

    float radius = 62.0f;
    ImVec2 center(io.DisplaySize.x * 0.5f,
                  io.DisplaySize.y - radius - 80.0f);

    float pulse = 0.5f + 0.5f * sinf(m_waterAnim * 2.6f);

    // Outer soft halo rings (no background card behind it).
    for (int i = 4; i > 0; --i)
    {
        float r = radius + 6.0f + i * 5.0f;
        dl->AddCircle(center, r,
            IM_COL32(60, 180, 255, (int)(22 + i * 18 * pulse)),
            48, 2.0f);
    }

    // Body: radial gradient-ish double-fill.
    dl->AddCircleFilled(center, radius,
        IM_COL32(20,  90, 160, 235), 48);
    dl->AddCircleFilled(center, radius - 4.0f,
        IM_COL32(32, 140, 220, 245), 48);

    // Animated accent ring.
    dl->AddCircle(center, radius,
        IM_COL32(120, 220, 255, (int)(180 + 70 * pulse)), 48, 3.5f);

    // --- Fishing rod icon (rod + line + hook) -----------------------
    // Rod handle -> tip at upper-right.
    ImVec2 rodA(center.x - radius * 0.55f, center.y + radius * 0.45f);
    ImVec2 rodB(center.x + radius * 0.55f, center.y - radius * 0.55f);
    // Handle segment (thicker, dark brown).
    ImVec2 handleMid(center.x - radius * 0.18f,
                     center.y + radius * 0.12f);
    dl->AddLine(rodA, handleMid, IM_COL32(65, 35, 20, 255), 7.0f);
    // Rod body (white glossy).
    dl->AddLine(handleMid, rodB, IM_COL32(240, 245, 250, 255), 4.0f);
    // Subtle rod shadow.
    dl->AddLine(ImVec2(handleMid.x + 1, handleMid.y + 1),
                ImVec2(rodB.x + 1, rodB.y + 1),
                IM_COL32(0, 0, 0, 80), 1.5f);

    // Fishing line dropping from the tip.
    ImVec2 lineA = rodB;
    ImVec2 lineB(rodB.x + 8.0f, center.y + radius * 0.35f);
    dl->AddLine(lineA, lineB, IM_COL32(230, 240, 255, 220), 1.5f);

    // Hook at the bottom of the line.
    dl->AddCircle(ImVec2(lineB.x + 2.0f, lineB.y + 5.0f), 4.0f,
        IM_COL32(240, 240, 240, 255), 12, 2.0f);

    // Small water-splash at the hook tip (animated).
    float splash = 2.5f + 2.0f * pulse;
    dl->AddCircle(ImVec2(lineB.x + 2.0f, lineB.y + 8.0f),
        splash,
        IM_COL32(140, 220, 255, (int)(180 - 120 * pulse)),
        12, 1.5f);

    // --- Input -----------------------------------------------------
    float dx = io.MousePos.x - center.x;
    float dy = io.MousePos.y - center.y;
    bool  inside  = (dx * dx + dy * dy) <= (radius * radius);
    bool  clicked = inside && ImGui::IsMouseClicked(0);

    if (inside && io.MouseDown[0])
    {
        dl->AddCircle(center, radius + 2.0f,
            IM_COL32(255, 255, 255, 210), 48, 3.5f);
    }

    // Tiny label under the button.
    const char* lbl = "رمي السنارة";
    ImVec2 tsz = font->CalcTextSizeA(18.0f, FLT_MAX, 0.0f, lbl);
    dl->AddText(font, 18.0f,
        ImVec2(center.x - tsz.x * 0.5f, center.y + radius + 6.0f),
        IM_COL32(235, 245, 255, 235), lbl);

    if (clicked) { StartReelMinigame(); }
}

// =============================================================================
//  REEL minigame (client-side tap-to-fill power meter)
//
//  When the player taps the circular CAST HUD button we switch to this state
//  instead of forwarding the dialog response to the server immediately.  The
//  player has to tap a large right-side circle button rapidly to fill a bar at
//  the top of the screen.  Every tap adds a random amount (so sometimes the
//  meter surges, sometimes it crawls), and the meter drains continuously when
//  idle.  When the bar hits 100 we forward SendPick(1) exactly like the old
//  HUD button used to do, so the server-side cast/dive/resolve flow is
//  unchanged.
// =============================================================================

void CFishermanOverlay::StartReelMinigame()
{
    // Remember the dialog id so we can answer the server when the meter
    // fills.  (The HUD dialog id is set when FISH_HUD was opened.)
    m_reelDialogId = m_dialogId;
    m_state        = FISH_REEL;
    m_reelFill     = 0.0f;
    m_reelTaps     = 0;
    m_reelPressed  = false;
    m_reelStartT   = 0.0f;

    // Pick a difficulty profile for this attempt (random per cast so it
    // feels different every time).
    //   drain   -- how many % drain off per second when idle
    //   perTap  -- how many % a single tap adds (randomised a little)
    int prof = rand() % 4;
    switch (prof)
    {
    case 0: m_reelDecayRate = 18.0f; m_reelPerTap = 9.0f;  break; // medium
    case 1: m_reelDecayRate = 10.0f; m_reelPerTap = 14.0f; break; // easy / fast
    case 2: m_reelDecayRate = 26.0f; m_reelPerTap = 7.0f;  break; // hard
    default: m_reelDecayRate = 22.0f; m_reelPerTap = 10.0f; break;
    }
}

void CFishermanOverlay::RenderReel()
{
    ImGuiIO&    io   = ImGui::GetIO();
    ImDrawList* dl   = ImGui::GetOverlayDrawList();
    ImFont*     font = pGUI ? pGUI->GetFont() : ImGui::GetFont();

    float dt = io.DeltaTime; if (dt > 0.25f) dt = 0.25f;
    m_reelStartT  += dt;
    m_waterAnim   += dt;

    // --- decay (faster early-game so stopping loses progress) -------------
    float randomBoost = 0.8f + 0.4f * ((rand() % 100) / 100.0f);
    m_reelFill -= m_reelDecayRate * dt * randomBoost;
    if (m_reelFill < 0.0f) m_reelFill = 0.0f;

    // --- top fill bar ----------------------------------------------------
    float barW = io.DisplaySize.x * 0.55f;
    float barH = 28.0f;
    float barX = (io.DisplaySize.x - barW) * 0.5f;
    float barY = 48.0f;

    // Bar shell
    dl->AddRectFilled(ImVec2(barX - 4, barY - 4),
                      ImVec2(barX + barW + 4, barY + barH + 4),
                      IM_COL32(10, 22, 38, 230), 8.0f);
    dl->AddRect(ImVec2(barX - 4, barY - 4),
                ImVec2(barX + barW + 4, barY + barH + 4),
                IM_COL32(80, 180, 240, 230), 8.0f, 0, 2.0f);

    // Bar track
    dl->AddRectFilled(ImVec2(barX, barY),
                      ImVec2(barX + barW, barY + barH),
                      IM_COL32(22, 40, 62, 240), 4.0f);

    // Fill
    float f = m_reelFill / 100.0f; if (f > 1.0f) f = 1.0f;
    int g = 120 + (int)(100 * f);
    int r = 250 - (int)(140 * f);
    dl->AddRectFilled(ImVec2(barX, barY),
                      ImVec2(barX + barW * f, barY + barH),
                      IM_COL32(r, g, 90, 255), 4.0f);
    // Glossy highlight
    dl->AddRectFilled(ImVec2(barX, barY),
                      ImVec2(barX + barW * f, barY + barH * 0.45f),
                      IM_COL32(255, 255, 255, 40), 4.0f);

    // % text centered on bar
    char buf[32]; snprintf(buf, sizeof(buf), "%d %%", (int)m_reelFill);
    ImVec2 ts = font->CalcTextSizeA(20.0f, FLT_MAX, 0.0f, buf);
    dl->AddText(font, 20.0f,
                ImVec2(barX + (barW - ts.x) * 0.5f, barY + 3.0f),
                IM_COL32(255, 255, 255, 240), buf);

    // Label above bar
    const char* hint = "TAP THE BUTTON TO REEL IN";
    ImVec2 hs = font->CalcTextSizeA(24.0f, FLT_MAX, 0.0f, hint);
    dl->AddText(font, 24.0f,
                ImVec2((io.DisplaySize.x - hs.x) * 0.5f, barY - 34.0f),
                IM_COL32(200, 230, 255, 230), hint);

    // --- big right-side circular TAP button ------------------------------
    float radius = 130.0f;
    if (io.DisplaySize.y < 600.0f) radius = 100.0f;
    ImVec2 center(io.DisplaySize.x - radius - 60.0f,
                  io.DisplaySize.y * 0.5f);

    float pulse = 0.5f + 0.5f * sinf(m_waterAnim * 7.0f);

    // Ripple halos
    for (int i = 4; i > 0; --i)
    {
        float rr = radius + 8.0f + i * 8.0f;
        dl->AddCircle(center, rr,
            IM_COL32(60, 180, 255, (int)(16 + i * 18 * pulse)),
            64, 2.0f);
    }

    // Input edge-detect (per-tap, works on Android touch via MouseDown edges).
    float dx = io.MousePos.x - center.x;
    float dy = io.MousePos.y - center.y;
    bool  inside = (dx * dx + dy * dy) <= (radius * radius);
    bool  down   = io.MouseDown[0];
    bool  tapped = false;
    if (inside && down && !m_reelPressed) tapped = true;
    m_reelPressed = down;

    if (tapped)
    {
        m_reelTaps++;
        // Randomise per-tap gain so the meter feels a little alive.
        float jitter = 0.7f + 0.6f * ((rand() % 100) / 100.0f);
        m_reelFill += m_reelPerTap * jitter;
        if (m_reelFill > 100.0f) m_reelFill = 100.0f;
    }

    // Body (pressed = slightly brighter inner)
    unsigned col_outer = IM_COL32(20, 90, 160, 240);
    unsigned col_inner = (inside && down)
        ? IM_COL32(60, 200, 255, 255)
        : IM_COL32(32, 140, 220, 245);
    dl->AddCircleFilled(center, radius, col_outer, 64);
    dl->AddCircleFilled(center, radius - 6.0f, col_inner, 64);

    // Highlight ring
    dl->AddCircle(center, radius,
        IM_COL32(160, 240, 255, (int)(200 + 55 * pulse)), 64, 4.0f);

    // "TAP!" label big
    const char* tapLbl = (tapped ? "TAP !" : "TAP");
    ImVec2 tps = font->CalcTextSizeA(46.0f, FLT_MAX, 0.0f, tapLbl);
    dl->AddText(font, 46.0f,
                ImVec2(center.x - tps.x * 0.5f, center.y - 32.0f),
                IM_COL32(255, 255, 255, 250), tapLbl);

    // Tap counter
    char tpc[32]; snprintf(tpc, sizeof(tpc), "Taps: %d", m_reelTaps);
    ImVec2 tcs = font->CalcTextSizeA(18.0f, FLT_MAX, 0.0f, tpc);
    dl->AddText(font, 18.0f,
                ImVec2(center.x - tcs.x * 0.5f, center.y + 12.0f),
                IM_COL32(220, 240, 255, 210), tpc);

    // --- cancel (small X near top-right of circle) -----------------------
    float endR = 28.0f;
    ImVec2 endC(center.x + radius * 0.78f, center.y - radius * 0.78f);
    dl->AddCircleFilled(endC, endR, IM_COL32(80, 20, 20, 220), 28);
    dl->AddCircle(endC, endR, IM_COL32(255, 110, 110, 220), 28, 2.0f);
    dl->AddLine(ImVec2(endC.x - 9, endC.y - 9),
                ImVec2(endC.x + 9, endC.y + 9),
                IM_COL32(255, 230, 230, 245), 3.0f);
    dl->AddLine(ImVec2(endC.x + 9, endC.y - 9),
                ImVec2(endC.x - 9, endC.y + 9),
                IM_COL32(255, 230, 230, 245), 3.0f);
    float edx = io.MousePos.x - endC.x;
    float edy = io.MousePos.y - endC.y;
    bool endInside = (edx * edx + edy * edy) <= (endR * endR);
    if (endInside && ImGui::IsMouseClicked(0))
    {
        // Back to HUD without committing the cast.
        m_state = FISH_HUD;
        return;
    }

    // --- completion ------------------------------------------------------
    if (m_reelFill >= 100.0f)
    {
        // Commit to server: same as old HUD "cast" response.
        m_dialogId = m_reelDialogId;
        SendPick(1);
        // SendPick Hide()s the overlay; server will switch to CAST state.
    }
}
