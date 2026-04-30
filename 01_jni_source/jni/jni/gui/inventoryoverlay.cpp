#include "../main.h"
#include "inventoryoverlay.h"
#include "gui.h"
#include "skintex.h"
#include "../vendor/imgui/imgui.h"
#include "../vendor/imgui/imgui_internal.h"
#include <cstdio>
#include <cstring>
#include <cstdlib>
#include <cmath>

CInventoryOverlay* pInventoryOverlay = nullptr;
extern CGUI* pGUI;

// Lightweight bridges implemented in netrpc.cpp so we don't drag the full
// netgame.h / playerped.h chain into this overlay translation unit.
extern const char* Inv_GetLocalPlayerName();
extern int         Inv_GetLocalSkinId();
extern int         Inv_GetLocalPlayerScore();

// =====================================================================
// HavanaRp brand palette (matches bankoverlay.cpp / shop247overlay.cpp)
// =====================================================================
static const ImU32 kColPanelTop      = IM_COL32(18,  36,  28,  238);
static const ImU32 kColPanelBot      = IM_COL32(9,   18,  14,  248);
static const ImU32 kColBorder        = IM_COL32(60, 255, 120, 200);
static const ImU32 kColBorderDim     = IM_COL32(60, 255, 120,  90);
static const ImU32 kColAccent        = IM_COL32( 0, 245, 160, 255);
static const ImU32 kColGreen         = IM_COL32(60, 255, 120, 255);
static const ImU32 kColGreenDeep     = IM_COL32(17, 156,  69, 255);
static const ImU32 kColRed           = IM_COL32(240, 80,  80, 255);
static const ImU32 kColOrange        = IM_COL32(255, 165, 60, 255);
static const ImU32 kColBlue          = IM_COL32( 30,180, 255, 255);
static const ImU32 kColYellow        = IM_COL32(255, 215, 80, 255);
static const ImU32 kColPurple        = IM_COL32(180,100, 255, 255);
static const ImU32 kColText          = IM_COL32(255,255,255, 255);
static const ImU32 kColTextDim       = IM_COL32(220,235,228, 220);
static const ImU32 kColTextMuted     = IM_COL32(170,196,186, 200);
static const ImU32 kColCardBg        = IM_COL32(20,  38,  30, 235);
static const ImU32 kColCardBgHi      = IM_COL32(28,  52,  40, 240);
static const ImU32 kColShadow        = IM_COL32( 0,   0,   0, 160);

// =====================================================================
// Construction / state
// =====================================================================
CInventoryOverlay::CInventoryOverlay()
    : m_bVisible(false)
    , m_fAnimT(0.0f)
    , m_iDialogId(0xFFFF)
    , m_bDialogActive(false)
    , m_iLevel(0), m_iJob(0), m_iSkin(0)
    , m_iHealth(100), m_iHunger(100)
    , m_iMoney(0), m_iBank(0)
    , m_iPhone(0), m_iDrugs(0), m_iMats(0), m_iCigs(0)
    , m_iAidKit(0), m_iBandage(0), m_iSchiene(0)
    , m_iAspirin(0), m_iMorphine(0), m_iAdrenalin(0)
    , m_iRepairKit(0), m_iGPS(0), m_iMask(0)
    , m_iRope(0), m_iCanister(0), m_iSeed(0)
    , m_iAmmo(0), m_iGuns(0)
{
    m_szName[0] = '\0';
}

CInventoryOverlay::~CInventoryOverlay() {}

// Bridge to CNetGame::SendDialogResponse (defined in netrpc.cpp).
extern void CarRent_SendDialogResponse(uint16_t id, uint8_t btn, uint16_t listitem, char* input);
// Bridge that sends a chat command (e.g. "/mask") via the network layer.
extern void Inventory_SendChatCommand(const char* cmd);

void CInventoryOverlay::Hide()
{
    // If an underlying SAMP dialog is still "open" server-side, cancel it
    // (button=0 is the Back/right button which the gamemode treats as cancel).
    if (m_bDialogActive)
    {
        char empty[1] = { 0 };
        CarRent_SendDialogResponse(m_iDialogId, 0, 0, empty);
        m_bDialogActive = false;
    }
    m_bVisible = false;
}

// =====================================================================
// Payload parsing  (k=v;k=v;k=v ...)
// =====================================================================
void CInventoryOverlay::SetField(const char* key, const char* value)
{
    if (!key || !value) return;

    if      (!strcmp(key, "الاسم"))       { strncpy(m_szName, value, kNameMax - 1); m_szName[kNameMax - 1] = '\0'; }
    else if (!strcmp(key, "المستوى"))      m_iLevel    = atoi(value);
    else if (!strcmp(key, "الوظيفة"))        m_iJob      = atoi(value);
    else if (!strcmp(key, "السكن"))       m_iSkin     = atoi(value);
    else if (!strcmp(key, "صحة"))     m_iHealth   = atoi(value);
    else if (!strcmp(key, "الجوع"))     m_iHunger   = atoi(value);
    else if (!strcmp(key, "الفلوس"))      m_iMoney    = strtoll(value, nullptr, 10);
    else if (!strcmp(key, "البنك"))       m_iBank     = strtoll(value, nullptr, 10);
    else if (!strcmp(key, "جوال"))      m_iPhone    = atoi(value);
    else if (!strcmp(key, "مخدرات"))      m_iDrugs    = atoi(value);
    else if (!strcmp(key, "مواد"))       m_iMats     = atoi(value);
    else if (!strcmp(key, "دخان"))       m_iCigs     = atoi(value);
    else if (!strcmp(key, "إسعاف"))     m_iAidKit   = atoi(value);
    else if (!strcmp(key, "ضماد"))    m_iBandage  = atoi(value);
    else if (!strcmp(key, "schiene"))    m_iSchiene  = atoi(value);
    else if (!strcmp(key, "aspirin"))    m_iAspirin  = atoi(value);
    else if (!strcmp(key, "morphine"))   m_iMorphine = atoi(value);
    else if (!strcmp(key, "adrenalin"))  m_iAdrenalin= atoi(value);
    else if (!strcmp(key, "تصليح"))  m_iRepairKit= atoi(value);
    else if (!strcmp(key, "ملاحة"))        m_iGPS      = atoi(value);
    else if (!strcmp(key, "قناع"))       m_iMask     = atoi(value);
    else if (!strcmp(key, "حبل"))       m_iRope     = atoi(value);
    else if (!strcmp(key, "بنزين"))   m_iCanister = atoi(value);
    else if (!strcmp(key, "بذور"))       m_iSeed     = atoi(value);
    else if (!strcmp(key, "ذخيرة"))       m_iAmmo     = atoi(value);
    else if (!strcmp(key, "أسلحة"))       m_iGuns     = atoi(value);
}

void CInventoryOverlay::ParsePayload(const char* payload)
{
    // Merge - only fields explicitly present in the payload are overwritten.
    // This lets the server push partial updates (e.g. wallet only) without
    // wiping the items previously parsed from the SAMP "Inventory" dialog.
    if (!payload) return;

    char buf[1024];
    strncpy(buf, payload, sizeof(buf) - 1);
    buf[sizeof(buf) - 1] = '\0';

    char* save = nullptr;
    char* tok  = strtok_r(buf, ";", &save);
    while (tok)
    {
        // Skip leading whitespace.
        while (*tok == ' ' || *tok == '\t') ++tok;
        char* eq = strchr(tok, '=');
        if (eq)
        {
            *eq = '\0';
            const char* key = tok;
            const char* val = eq + 1;
            SetField(key, val);
        }
        tok = strtok_r(nullptr, ";", &save);
    }
}

void CInventoryOverlay::UpdateFromPayload(const char* payload)
{
    ParsePayload(payload);
}

void CInventoryOverlay::ShowFromPayload(const char* payload)
{
    ParsePayload(payload);
    m_bVisible = true;
    m_fAnimT   = 0.0f;
}

// =====================================================================
// SAMP-dialog interception (gamemode "Inventory" dialog -> our overlay)
// =====================================================================

// Strip SAMP color codes ({RRGGBB} / {RRGGBBAA}) and write a clean copy.
static void Inv_StripColors(const char* in, char* out, size_t len)
{
    if (!in || !out || len == 0) return;
    size_t j = 0;
    for (size_t i = 0; in[i] && j + 1 < len; ++i)
    {
        if (in[i] == '{')
        {
            size_t k = i + 1;
            bool isColor = true;
            int hex = 0;
            while (in[k] && in[k] != '}' && (k - i) < 12)
            {
                char c = in[k];
                if (!((c >= '0' && c <= '9') || (c >= 'A' && c <= 'F') || (c >= 'a' && c <= 'f')))
                { isColor = false; break; }
                hex++; k++;
            }
            if (isColor && in[k] == '}' && (hex == 6 || hex == 8))
            {
                i = k;
                continue;
            }
        }
        out[j++] = in[i];
    }
    out[j] = '\0';
}

// Find first integer that follows the `prefix` in `text` (case-insensitive
// substring search). Returns true if a number was extracted.
static bool Inv_ExtractIntAfter(const char* text, const char* prefix, int* out)
{
    if (!text || !prefix || !out) return false;
    size_t plen = strlen(prefix);
    if (plen == 0) return false;

    for (const char* p = text; *p; ++p)
    {
        // Case-insensitive prefix match.
        bool match = true;
        for (size_t k = 0; k < plen; ++k)
        {
            char a = p[k], b = prefix[k];
            if (a >= 'A' && a <= 'Z') a += 32;
            if (b >= 'A' && b <= 'Z') b += 32;
            if (a != b) { match = false; break; }
        }
        if (!match) continue;

        // Walk past the prefix and any non-digit, non-newline characters.
        const char* q = p + plen;
        while (*q && *q != '\n' && (*q < '0' || *q > '9')) q++;
        if (*q < '0' || *q > '9') continue;

        int v = 0;
        bool has = false;
        while (*q >= '0' && *q <= '9') { v = v * 10 + (*q - '0'); q++; has = true; }
        if (has) { *out = v; return true; }
    }
    return false;
}

bool CInventoryOverlay::TryHandleDialog(uint16_t dialogId, uint8_t style,
                                       const char* title, const char* body)
{
    if (!title || !body) return false;
    // Style 2 == DIALOG_STYLE_LIST (the inventory dialog).
    // We accept any LIST/TABLIST style to be lenient.
    //   0 = MSGBOX, 1 = INPUT, 2 = LIST, 4 = TABLIST, 5 = TABLIST_HEADERS
    if (style != 2 && style != 4 && style != 5) return false;

    char tclean[128];
    Inv_StripColors(title, tclean, sizeof(tclean));

    // Match the gamemode's "Inventory" title (color-stripped).
    // The actual title is "{80FF00}Inventory" in arabonline.pwn.
    bool isInv = false;
    for (const char* p = tclean; *p; ++p)
    {
        if ((p[0] == 'I' || p[0] == 'i') && (p[1] == 'n' || p[1] == 'N')
         && (p[2] == 'v' || p[2] == 'V') && (p[3] == 'e' || p[3] == 'E')
         && (p[4] == 'n' || p[4] == 'N') && (p[5] == 't' || p[5] == 'T'))
        { isInv = true; break; }
    }
    if (!isInv) return false;

    char clean[4096];
    Inv_StripColors(body, clean, sizeof(clean));

    // Reset only the fields the dialog body is authoritative for. Wallet
    // values (money/bank/phone/mats/cigs/drugs) and meta (level/job/skin/
    // health/hunger) come from the inv_ui.pwn periodic push and must not
    // be wiped here, otherwise the overlay would always show 0.
    m_iAidKit = m_iBandage = m_iSchiene = 0;
    m_iAspirin = m_iMorphine = m_iAdrenalin = 0;
    m_iRepairKit = m_iGPS = m_iMask = 0;
    m_iRope = m_iCanister = m_iSeed = 0;
    m_iAmmo = m_iGuns = 0;
    m_iHealth = m_iHunger = 0;

    int v = 0;
    if (Inv_ExtractIntAfter(clean, "إسعافات أولية", &v)) m_iAidKit   = v;
    if (Inv_ExtractIntAfter(clean, "ضمادات",       &v)) m_iBandage  = v;
    if (Inv_ExtractIntAfter(clean, "كفرات",          &v)) m_iSchiene  = v;
    if (Inv_ExtractIntAfter(clean, "أسبرين",        &v)) m_iAspirin  = v;
    if (Inv_ExtractIntAfter(clean, "Morphim",        &v)) m_iMorphine = v;
    if (Inv_ExtractIntAfter(clean, "Morphine",       &v)) m_iMorphine = v;
    if (Inv_ExtractIntAfter(clean, "Adrenalin",      &v)) m_iAdrenalin= v;
    if (Inv_ExtractIntAfter(clean, "Drugs",          &v)) m_iDrugs    = v;

    // Pull live player name and the actual GTA model index (skin) so the
    // center card matches the character the user is wearing in-game.
    {
        const char* nm = Inv_GetLocalPlayerName();
        if (nm && *nm)
        {
            strncpy(m_szName, nm, kNameMax - 1);
            m_szName[kNameMax - 1] = '\0';
        }
        int sk = Inv_GetLocalSkinId();
        if (sk >= 0) m_iSkin = sk;
        // SAMP "score" is exposed by most roleplay gamemodes as the player's
        // experience level - HavanaRp uses it that way.
        m_iLevel = Inv_GetLocalPlayerScore();
    }

    // Auto-ack the underlying SAMP dialog right now so the server treats
    // it as closed. This keeps chat / on-screen widgets fully responsive
    // while our overlay is open. Item "use" is now driven by chat
    // commands (Inventory_SendChatCommand), not dialog responses, so we
    // don't need to keep the dialog logically active anymore.
    m_iDialogId     = dialogId;
    m_bDialogActive = false;
    {
        char empty[1] = { 0 };
        CarRent_SendDialogResponse(dialogId, 0, 0, empty);
    }

    m_bVisible = true;
    m_fAnimT   = 0.0f;
    return true;
}

// =====================================================================
// Helpers
// =====================================================================
static void FormatMoney(int64_t value, char* out, size_t outSize)
{
    bool negative = value < 0;
    uint64_t absv = (uint64_t)(negative ? -value : value);

    char raw[48];
    int len = snprintf(raw, sizeof(raw), "%llu", (unsigned long long)absv);

    char tmp[64];
    int j = 0, cntr = 0;
    for (int i = len - 1; i >= 0; --i)
    {
        if (cntr && cntr % 3 == 0 && j < (int)sizeof(tmp) - 1) tmp[j++] = ',';
        tmp[j++] = raw[i];
        cntr++;
    }
    tmp[j] = '\0';

    int outIdx = 0;
    if (negative && outIdx < (int)outSize - 1) out[outIdx++] = '-';
    for (int i = j - 1; i >= 0 && outIdx < (int)outSize - 1; --i)
        out[outIdx++] = tmp[i];
    if (outIdx < (int)outSize) out[outIdx] = '\0';
}

static const char* JobName(int jobId)
{
    switch (jobId)
    {
        case 0:  return "Unemployed";
        case 1:  return "Truck Driver";
        case 2:  return "Taxi Driver";
        case 3:  return "Bus Driver";
        case 4:  return "Mechanic";
        case 5:  return "Pizza Delivery";
        case 6:  return "Fisherman";
        case 7:  return "Hunter";
        case 8:  return "Farmer";
        case 9:  return "Pilot";
        case 10: return "Detective";
        case 11: return "Drug Dealer";
        case 12: return "Lumberjack";
        default: return "Civilian";
    }
}

static void DrawShadowedText(ImDrawList* dl, ImFont* font, float fSize,
                             ImVec2 pos, ImU32 col, const char* txt)
{
    if (font)
    {
        dl->AddText(font, fSize, ImVec2(pos.x + 1, pos.y + 1), kColShadow, txt);
        dl->AddText(font, fSize, pos, col, txt);
    }
    else
    {
        dl->AddText(ImVec2(pos.x + 1, pos.y + 1), kColShadow, txt);
        dl->AddText(pos, col, txt);
    }
}

// Draw a stat bar (HP / Hunger style).
static void DrawStatBar(ImDrawList* dl, ImFont* font, ImVec2 pMin, ImVec2 pMax,
                        const char* label, int value, ImU32 fillCol,
                        float scale)
{
    float h    = pMax.y - pMin.y;
    float pad  = 6.0f * scale;
    float hdr  = 22.0f * scale;

    // Label
    if (font)
    {
        dl->AddText(font, 16.0f * scale,
                    ImVec2(pMin.x, pMin.y - 2 * scale),
                    kColTextDim, label);

        char vbuf[16];
        snprintf(vbuf, sizeof(vbuf), "%d%%", value);
        ImVec2 ts = font->CalcTextSizeA(16.0f * scale, FLT_MAX, 0.0f, vbuf);
        dl->AddText(font, 16.0f * scale,
                    ImVec2(pMax.x - ts.x, pMin.y - 2 * scale),
                    kColText, vbuf);
    }

    ImVec2 trackMin(pMin.x, pMin.y + hdr);
    ImVec2 trackMax(pMax.x, pMin.y + hdr + (h - hdr));
    float  trackR  = (trackMax.y - trackMin.y) * 0.5f;

    // Track
    dl->AddRectFilled(trackMin, trackMax, IM_COL32(10, 22, 16, 230), trackR);
    dl->AddRect(trackMin, trackMax, kColBorderDim, trackR, 0, 1.2f);

    // Fill
    float pct  = value / 100.0f;
    if (pct < 0) pct = 0; if (pct > 1) pct = 1;
    ImVec2 fMin = trackMin;
    ImVec2 fMax(trackMin.x + (trackMax.x - trackMin.x) * pct, trackMax.y);
    if (fMax.x > fMin.x + 2)
    {
        dl->AddRectFilledMultiColor(fMin, fMax,
            fillCol, fillCol,
            IM_COL32((fillCol >>  0) & 0xFF,
                     (fillCol >>  8) & 0xFF,
                     (fillCol >> 16) & 0xFF, 180),
            IM_COL32((fillCol >>  0) & 0xFF,
                     (fillCol >>  8) & 0xFF,
                     (fillCol >> 16) & 0xFF, 180));
        // Highlight
        dl->AddRectFilled(
            ImVec2(fMin.x, fMin.y),
            ImVec2(fMax.x, fMin.y + (fMax.y - fMin.y) * 0.45f),
            IM_COL32(255, 255, 255, 30), trackR);
    }
    (void)pad;
}

// Draw a small vector "icon" identified by name.
// Keeps the launcher self-contained (no external textures).
static void DrawItemIcon(ImDrawList* dl, ImVec2 c, float r, const char* kind)
{
    ImU32 mainCol  = IM_COL32(255, 255, 255, 235);
    ImU32 accentCol= kColAccent;

    if (!strcmp(kind, "الفلوس"))
    {
        // dollar bill
        dl->AddRectFilled(ImVec2(c.x - r*0.9f, c.y - r*0.55f),
                          ImVec2(c.x + r*0.9f, c.y + r*0.55f),
                          IM_COL32(40, 160, 90, 255), r*0.18f);
        dl->AddCircleFilled(c, r * 0.42f, IM_COL32(255, 255, 255, 235));
        dl->AddText(ImVec2(c.x - r*0.18f, c.y - r*0.4f), IM_COL32(40,160,90,255), "$");
    }
    else if (!strcmp(kind, "البنك"))
    {
        // bank building
        dl->AddTriangleFilled(
            ImVec2(c.x - r,        c.y - r*0.20f),
            ImVec2(c.x + r,        c.y - r*0.20f),
            ImVec2(c.x,            c.y - r*0.95f), mainCol);
        for (int i = 0; i < 4; ++i)
        {
            float cx = c.x - r*0.85f + i * (r*0.55f);
            dl->AddRectFilled(ImVec2(cx, c.y - r*0.10f),
                              ImVec2(cx + r*0.18f, c.y + r*0.55f), mainCol);
        }
        dl->AddRectFilled(ImVec2(c.x - r, c.y + r*0.55f),
                          ImVec2(c.x + r, c.y + r*0.85f), mainCol);
    }
    else if (!strcmp(kind, "جوال"))
    {
        // smartphone with screen content + speaker + home indicator
        // body shadow
        dl->AddRectFilled(ImVec2(c.x - r*0.58f, c.y - r*0.92f),
                          ImVec2(c.x + r*0.62f, c.y + r*0.98f),
                          IM_COL32(0, 0, 0, 90), r*0.26f);
        // body
        dl->AddRectFilled(ImVec2(c.x - r*0.60f, c.y - r*0.95f),
                          ImVec2(c.x + r*0.60f, c.y + r*0.95f),
                          IM_COL32(28, 38, 50, 255), r*0.26f);
        dl->AddRect(ImVec2(c.x - r*0.60f, c.y - r*0.95f),
                    ImVec2(c.x + r*0.60f, c.y + r*0.95f),
                    IM_COL32(110, 130, 150, 200), r*0.26f, 0, 1.4f);
        // screen with vertical gradient
        dl->AddRectFilledMultiColor(
            ImVec2(c.x - r*0.48f, c.y - r*0.75f),
            ImVec2(c.x + r*0.48f, c.y + r*0.55f),
            IM_COL32(110, 200, 255, 255), IM_COL32(110, 200, 255, 255),
            IM_COL32( 50, 110, 220, 255), IM_COL32( 50, 110, 220, 255));
        // app icons grid
        for (int yy = 0; yy < 3; ++yy)
        for (int xx = 0; xx < 3; ++xx) {
            float ax = c.x - r*0.36f + xx * r*0.30f;
            float ay = c.y - r*0.55f + yy * r*0.34f;
            dl->AddRectFilled(ImVec2(ax - r*0.10f, ay - r*0.10f),
                              ImVec2(ax + r*0.10f, ay + r*0.10f),
                              IM_COL32(255, 255, 255, 200), r*0.04f);
        }
        // speaker slit
        dl->AddRectFilled(ImVec2(c.x - r*0.16f, c.y - r*0.85f),
                          ImVec2(c.x + r*0.16f, c.y - r*0.80f),
                          IM_COL32(120, 140, 160, 255));
        // home indicator
        dl->AddRectFilled(ImVec2(c.x - r*0.18f, c.y + r*0.78f),
                          ImVec2(c.x + r*0.18f, c.y + r*0.84f),
                          IM_COL32(220, 230, 240, 255), r*0.04f);
    }
    else if (!strcmp(kind, "مخدرات"))
    {
        // pill capsule lying horizontally with split & glossy highlight
        // shadow under capsule
        dl->AddRectFilled(ImVec2(c.x - r*0.86f, c.y - r*0.30f),
                          ImVec2(c.x + r*0.90f, c.y + r*0.42f),
                          IM_COL32(0, 0, 0, 80), r*0.34f);
        // left half (white)
        dl->AddRectFilled(ImVec2(c.x - r*0.85f, c.y - r*0.32f),
                          ImVec2(c.x + r*0.05f, c.y + r*0.32f),
                          IM_COL32(245, 245, 250, 255), r*0.32f);
        // right half (red/orange)
        dl->AddRectFilled(ImVec2(c.x - r*0.05f, c.y - r*0.32f),
                          ImVec2(c.x + r*0.85f, c.y + r*0.32f),
                          IM_COL32(220, 70, 70, 255), r*0.32f);
        // split line
        dl->AddRectFilled(ImVec2(c.x - r*0.04f, c.y - r*0.30f),
                          ImVec2(c.x + r*0.04f, c.y + r*0.30f),
                          IM_COL32(20, 30, 40, 200));
        // top glossy highlight
        dl->AddRectFilledMultiColor(
            ImVec2(c.x - r*0.78f, c.y - r*0.28f),
            ImVec2(c.x + r*0.78f, c.y - r*0.10f),
            IM_COL32(255, 255, 255, 110), IM_COL32(255, 255, 255, 110),
            IM_COL32(255, 255, 255,  0), IM_COL32(255, 255, 255,  0));
    }
    else if (!strcmp(kind, "مواد"))
    {
        // wooden crate with metal corner braces
        // shadow
        dl->AddRectFilled(ImVec2(c.x - r*0.86f, c.y - r*0.66f),
                          ImVec2(c.x + r*0.90f, c.y + r*0.78f),
                          IM_COL32(0, 0, 0, 90), r*0.10f);
        // wood body gradient (top brighter)
        dl->AddRectFilledMultiColor(
            ImVec2(c.x - r*0.85f, c.y - r*0.70f),
            ImVec2(c.x + r*0.85f, c.y + r*0.75f),
            IM_COL32(190, 130, 70, 255), IM_COL32(190, 130, 70, 255),
            IM_COL32(140,  90, 50, 255), IM_COL32(140,  90, 50, 255));
        // diagonal slats (X)
        dl->AddLine(ImVec2(c.x - r*0.85f, c.y - r*0.70f),
                    ImVec2(c.x + r*0.85f, c.y + r*0.75f),
                    IM_COL32(95, 60, 30, 220), 3.0f);
        dl->AddLine(ImVec2(c.x + r*0.85f, c.y - r*0.70f),
                    ImVec2(c.x - r*0.85f, c.y + r*0.75f),
                    IM_COL32(95, 60, 30, 220), 3.0f);
        // metal corner braces (4 corners)
        ImU32 metal = IM_COL32(190, 195, 205, 255);
        for (int qy = 0; qy < 2; ++qy)
        for (int qx = 0; qx < 2; ++qx) {
            float x0 = (qx == 0) ? c.x - r*0.85f : c.x + r*0.55f;
            float y0 = (qy == 0) ? c.y - r*0.70f : c.y + r*0.45f;
            dl->AddRectFilled(ImVec2(x0, y0),
                              ImVec2(x0 + r*0.30f, y0 + r*0.28f),
                              metal, r*0.04f);
        }
        // outline
        dl->AddRect(ImVec2(c.x - r*0.85f, c.y - r*0.70f),
                    ImVec2(c.x + r*0.85f, c.y + r*0.75f),
                    IM_COL32(70, 45, 25, 255), r*0.04f, 0, 1.6f);
    }
    else if (!strcmp(kind, "دخان"))
    {
        // cigarette pack with one cig sticking out + smoke
        // pack shadow
        dl->AddRectFilled(ImVec2(c.x - r*0.66f, c.y - r*0.40f),
                          ImVec2(c.x + r*0.70f, c.y + r*0.92f),
                          IM_COL32(0, 0, 0, 90), r*0.08f);
        // pack body
        dl->AddRectFilled(ImVec2(c.x - r*0.65f, c.y - r*0.45f),
                          ImVec2(c.x + r*0.65f, c.y + r*0.90f),
                          IM_COL32(220, 60, 60, 255), r*0.08f);
        // top opened flap
        dl->AddRectFilled(ImVec2(c.x - r*0.65f, c.y - r*0.45f),
                          ImVec2(c.x + r*0.65f, c.y - r*0.18f),
                          IM_COL32(180, 40, 40, 255), r*0.08f);
        // label band (white)
        dl->AddRectFilled(ImVec2(c.x - r*0.65f, c.y + r*0.10f),
                          ImVec2(c.x + r*0.65f, c.y + r*0.40f),
                          IM_COL32(245, 245, 240, 255));
        // cigarette poking out
        dl->AddRectFilled(ImVec2(c.x - r*0.10f, c.y - r*0.95f),
                          ImVec2(c.x + r*0.10f, c.y - r*0.30f),
                          IM_COL32(245, 240, 220, 255), r*0.04f);
        dl->AddRectFilled(ImVec2(c.x - r*0.10f, c.y - r*0.95f),
                          ImVec2(c.x + r*0.10f, c.y - r*0.78f),
                          IM_COL32(220, 130, 50, 255), r*0.04f);
        // ember tip
        dl->AddCircleFilled(ImVec2(c.x, c.y - r*0.95f), r*0.10f,
                            IM_COL32(255, 120, 50, 255));
        // outline
        dl->AddRect(ImVec2(c.x - r*0.65f, c.y - r*0.45f),
                    ImVec2(c.x + r*0.65f, c.y + r*0.90f),
                    IM_COL32(110, 25, 25, 255), r*0.08f, 0, 1.4f);
    }
    else if (!strcmp(kind, "إسعاف"))
    {
        // first-aid kit (red box with handle and white cross panel)
        // shadow
        dl->AddRectFilled(ImVec2(c.x - r*0.86f, c.y - r*0.56f),
                          ImVec2(c.x + r*0.90f, c.y + r*0.90f),
                          IM_COL32(0, 0, 0, 90), r*0.16f);
        // handle
        dl->AddRect(ImVec2(c.x - r*0.32f, c.y - r*0.78f),
                    ImVec2(c.x + r*0.32f, c.y - r*0.50f),
                    IM_COL32(180, 50, 50, 255), r*0.08f, 0, r*0.16f);
        // box gradient
        dl->AddRectFilledMultiColor(
            ImVec2(c.x - r*0.85f, c.y - r*0.55f),
            ImVec2(c.x + r*0.85f, c.y + r*0.85f),
            IM_COL32(240, 90, 90, 255), IM_COL32(240, 90, 90, 255),
            IM_COL32(180, 40, 40, 255), IM_COL32(180, 40, 40, 255));
        // white center panel
        dl->AddRectFilled(ImVec2(c.x - r*0.55f, c.y - r*0.30f),
                          ImVec2(c.x + r*0.55f, c.y + r*0.65f),
                          IM_COL32(250, 250, 250, 255), r*0.06f);
        // red cross
        dl->AddRectFilled(ImVec2(c.x - r*0.10f, c.y - r*0.20f),
                          ImVec2(c.x + r*0.10f, c.y + r*0.55f),
                          IM_COL32(220, 60, 60, 255));
        dl->AddRectFilled(ImVec2(c.x - r*0.40f, c.y + r*0.08f),
                          ImVec2(c.x + r*0.40f, c.y + r*0.28f),
                          IM_COL32(220, 60, 60, 255));
        // outline
        dl->AddRect(ImVec2(c.x - r*0.85f, c.y - r*0.55f),
                    ImVec2(c.x + r*0.85f, c.y + r*0.85f),
                    IM_COL32(110, 20, 20, 255), r*0.10f, 0, 1.6f);
    }
    else if (!strcmp(kind, "ضماد"))
    {
        // bandage roll (3D-looking) with cross
        // shadow
        dl->AddCircleFilled(ImVec2(c.x + r*0.04f, c.y + r*0.06f),
                            r*0.86f, IM_COL32(0, 0, 0, 90));
        // outer roll
        dl->AddCircleFilled(c, r*0.85f, IM_COL32(248, 240, 220, 255));
        // shadow ring
        dl->AddCircle(c, r*0.85f, IM_COL32(170, 150, 110, 220), 36, 2.4f);
        // inner hole
        dl->AddCircleFilled(c, r*0.32f, IM_COL32(180, 160, 120, 255));
        dl->AddCircle(c, r*0.32f, IM_COL32(120, 100, 70, 255), 28, 1.6f);
        // wrap edge lines
        for (int i = -3; i <= 3; ++i) {
            if (i == 0) continue;
            float a = i * 0.18f;
            dl->AddLine(
                ImVec2(c.x + cosf(a + 0.4f) * r*0.85f,
                       c.y + sinf(a + 0.4f) * r*0.85f),
                ImVec2(c.x + cosf(a + 0.4f) * r*0.32f,
                       c.y + sinf(a + 0.4f) * r*0.32f),
                IM_COL32(200, 180, 140, 110), 1.2f);
        }
        // red cross
        dl->AddRectFilled(ImVec2(c.x - r*0.10f, c.y - r*0.62f),
                          ImVec2(c.x + r*0.10f, c.y - r*0.36f),
                          IM_COL32(220, 60, 60, 255));
        dl->AddRectFilled(ImVec2(c.x - r*0.22f, c.y - r*0.54f),
                          ImVec2(c.x + r*0.22f, c.y - r*0.42f),
                          IM_COL32(220, 60, 60, 255));
    }
    else if (!strcmp(kind, "schiene"))
    {
        // splint - two wooden planks bound with bandage strap
        // shadow
        dl->AddRectFilled(ImVec2(c.x - r*0.46f, c.y - r*0.78f),
                          ImVec2(c.x + r*0.46f, c.y + r*0.92f),
                          IM_COL32(0, 0, 0, 80), r*0.06f);
        // left plank
        dl->AddRectFilledMultiColor(
            ImVec2(c.x - r*0.45f, c.y - r*0.85f),
            ImVec2(c.x - r*0.10f, c.y + r*0.85f),
            IM_COL32(210, 160, 90, 255), IM_COL32(170, 110, 50, 255),
            IM_COL32(170, 110, 50, 255), IM_COL32(140,  85, 35, 255));
        // right plank
        dl->AddRectFilledMultiColor(
            ImVec2(c.x + r*0.10f, c.y - r*0.85f),
            ImVec2(c.x + r*0.45f, c.y + r*0.85f),
            IM_COL32(210, 160, 90, 255), IM_COL32(170, 110, 50, 255),
            IM_COL32(170, 110, 50, 255), IM_COL32(140,  85, 35, 255));
        // grain lines
        for (int i = 0; i < 3; ++i) {
            float yy = c.y - r*0.55f + i * r*0.55f;
            dl->AddLine(ImVec2(c.x - r*0.42f, yy),
                        ImVec2(c.x - r*0.13f, yy),
                        IM_COL32(110, 70, 30, 180), 1.2f);
            dl->AddLine(ImVec2(c.x + r*0.13f, yy),
                        ImVec2(c.x + r*0.42f, yy),
                        IM_COL32(110, 70, 30, 180), 1.2f);
        }
        // bandage strap (wraps both planks)
        dl->AddRectFilled(ImVec2(c.x - r*0.55f, c.y - r*0.18f),
                          ImVec2(c.x + r*0.55f, c.y + r*0.18f),
                          IM_COL32(248, 240, 220, 255), r*0.04f);
        dl->AddRect(ImVec2(c.x - r*0.55f, c.y - r*0.18f),
                    ImVec2(c.x + r*0.55f, c.y + r*0.18f),
                    IM_COL32(180, 160, 120, 255), r*0.04f, 0, 1.2f);
    }
    else if (!strcmp(kind, "aspirin"))
    {
        // round white tablet with score line + ASPIRIN dot pattern
        // shadow
        dl->AddCircleFilled(ImVec2(c.x + r*0.04f, c.y + r*0.06f),
                            r*0.78f, IM_COL32(0, 0, 0, 80));
        // tablet
        dl->AddCircleFilled(c, r*0.78f, IM_COL32(252, 250, 248, 255));
        // edge ring
        dl->AddCircle(c, r*0.78f, IM_COL32(200, 195, 188, 230), 36, 2.0f);
        // score line
        dl->AddLine(ImVec2(c.x - r*0.55f, c.y),
                    ImVec2(c.x + r*0.55f, c.y),
                    IM_COL32(170, 165, 160, 220), 2.0f);
        // top highlight
        dl->AddCircleFilled(ImVec2(c.x - r*0.20f, c.y - r*0.30f),
                            r*0.18f, IM_COL32(255, 255, 255, 200));
    }
    else if (!strcmp(kind, "morphine"))
    {
        // syringe with blue liquid + plunger + needle (rotated -25° look)
        ImU32 glass  = IM_COL32(220, 230, 245, 255);
        ImU32 fluid  = IM_COL32( 90, 170, 240, 255);
        ImU32 fluidD = IM_COL32( 50, 110, 200, 255);
        ImU32 metal  = IM_COL32(190, 200, 215, 255);
        ImU32 outline= IM_COL32( 30,  50,  80, 255);
        // shadow
        dl->AddRectFilled(ImVec2(c.x - r*0.84f, c.y - r*0.26f),
                          ImVec2(c.x + r*0.50f, c.y + r*0.30f),
                          IM_COL32(0,0,0,80), r*0.08f);
        // barrel (glass)
        dl->AddRectFilled(ImVec2(c.x - r*0.85f, c.y - r*0.28f),
                          ImVec2(c.x + r*0.45f, c.y + r*0.28f),
                          glass, r*0.08f);
        // fluid (front 70%)
        dl->AddRectFilledMultiColor(
            ImVec2(c.x - r*0.30f, c.y - r*0.22f),
            ImVec2(c.x + r*0.42f, c.y + r*0.22f),
            fluid, fluid, fluidD, fluidD);
        // tick marks
        for (int i = 0; i < 5; ++i) {
            float xx = c.x - r*0.70f + i * r*0.22f;
            dl->AddLine(ImVec2(xx, c.y - r*0.28f),
                        ImVec2(xx, c.y - r*0.18f), outline, 1.4f);
        }
        // plunger (left)
        dl->AddRectFilled(ImVec2(c.x - r*0.95f, c.y - r*0.36f),
                          ImVec2(c.x - r*0.78f, c.y + r*0.36f),
                          metal, r*0.04f);
        dl->AddRectFilled(ImVec2(c.x - r*0.78f, c.y - r*0.18f),
                          ImVec2(c.x - r*0.30f, c.y + r*0.18f),
                          IM_COL32(245, 245, 250, 255));
        // needle
        dl->AddRectFilled(ImVec2(c.x + r*0.45f, c.y - r*0.06f),
                          ImVec2(c.x + r*0.95f, c.y + r*0.06f),
                          metal);
        dl->AddTriangleFilled(
            ImVec2(c.x + r*0.85f, c.y - r*0.06f),
            ImVec2(c.x + r*0.85f, c.y + r*0.06f),
            ImVec2(c.x + r*1.05f, c.y),
            metal);
        // outline
        dl->AddRect(ImVec2(c.x - r*0.85f, c.y - r*0.28f),
                    ImVec2(c.x + r*0.45f, c.y + r*0.28f),
                    outline, r*0.08f, 0, 1.4f);
    }
    else if (!strcmp(kind, "adrenalin"))
    {
        // glowing lightning bolt with halo
        // glow halo
        for (int g = 3; g >= 1; --g) {
            dl->AddCircleFilled(c, r*(0.55f + g*0.18f),
                IM_COL32(255, 220, 90, (g==3)?22:(g==2)?40:70));
        }
        ImVec2 p[6] = {
            { c.x - r*0.20f, c.y - r*0.85f },
            { c.x + r*0.30f, c.y - r*0.10f },
            { c.x - r*0.05f, c.y - r*0.10f },
            { c.x + r*0.20f, c.y + r*0.85f },
            { c.x - r*0.30f, c.y + r*0.10f },
            { c.x + r*0.05f, c.y + r*0.10f }
        };
        ImU32 boltA = IM_COL32(255, 230, 100, 255);
        ImU32 boltB = IM_COL32(255, 170,  40, 255);
        // shadow underlay
        for (int i = 0; i < 6; ++i) { p[i].x += 2; p[i].y += 2; }
        dl->AddTriangleFilled(p[0], p[1], p[2], IM_COL32(0,0,0,90));
        dl->AddTriangleFilled(p[2], p[1], p[5], IM_COL32(0,0,0,90));
        dl->AddTriangleFilled(p[5], p[4], p[3], IM_COL32(0,0,0,90));
        dl->AddTriangleFilled(p[5], p[3], p[2], IM_COL32(0,0,0,90));
        for (int i = 0; i < 6; ++i) { p[i].x -= 2; p[i].y -= 2; }
        dl->AddTriangleFilled(p[0], p[1], p[2], boltA);
        dl->AddTriangleFilled(p[2], p[1], p[5], boltA);
        dl->AddTriangleFilled(p[5], p[4], p[3], boltB);
        dl->AddTriangleFilled(p[5], p[3], p[2], boltB);
    }
    else if (!strcmp(kind, "تصليح"))
    {
        // wrench + screwdriver crossed (X), metallic gradient
        ImU32 metalA = IM_COL32(220, 225, 235, 255);
        ImU32 metalB = IM_COL32(140, 150, 165, 255);
        ImU32 outline= IM_COL32( 40,  50,  65, 255);
        ImU32 handle = IM_COL32(220,  80,  60, 255);
        ImU32 handleD= IM_COL32(160,  40,  30, 255);

        // ---- screwdriver (\ diagonal) ----
        // handle
        dl->AddTriangleFilled(
            ImVec2(c.x - r*0.95f, c.y - r*0.55f),
            ImVec2(c.x - r*0.55f, c.y - r*0.95f),
            ImVec2(c.x - r*0.30f, c.y - r*0.70f), handle);
        dl->AddTriangleFilled(
            ImVec2(c.x - r*0.95f, c.y - r*0.55f),
            ImVec2(c.x - r*0.30f, c.y - r*0.70f),
            ImVec2(c.x - r*0.70f, c.y - r*0.30f), handleD);
        // shaft
        dl->AddTriangleFilled(
            ImVec2(c.x - r*0.30f, c.y - r*0.70f),
            ImVec2(c.x - r*0.70f, c.y - r*0.30f),
            ImVec2(c.x + r*0.55f, c.y + r*0.55f), metalA);
        dl->AddTriangleFilled(
            ImVec2(c.x - r*0.70f, c.y - r*0.30f),
            ImVec2(c.x + r*0.55f, c.y + r*0.55f),
            ImVec2(c.x + r*0.20f, c.y + r*0.85f), metalB);
        // tip
        dl->AddTriangleFilled(
            ImVec2(c.x + r*0.55f, c.y + r*0.55f),
            ImVec2(c.x + r*0.20f, c.y + r*0.85f),
            ImVec2(c.x + r*0.95f, c.y + r*0.95f), outline);

        // ---- wrench (/ diagonal) ----
        // shaft
        dl->AddTriangleFilled(
            ImVec2(c.x - r*0.85f, c.y + r*0.55f),
            ImVec2(c.x - r*0.55f, c.y + r*0.85f),
            ImVec2(c.x + r*0.40f, c.y - r*0.20f), metalA);
        dl->AddTriangleFilled(
            ImVec2(c.x - r*0.85f, c.y + r*0.55f),
            ImVec2(c.x + r*0.40f, c.y - r*0.20f),
            ImVec2(c.x + r*0.20f, c.y - r*0.45f), metalB);
        // open jaw (circle with bite)
        dl->AddCircleFilled(ImVec2(c.x + r*0.50f, c.y - r*0.50f), r*0.32f, metalA);
        dl->AddCircleFilled(ImVec2(c.x + r*0.65f, c.y - r*0.65f), r*0.18f,
                            IM_COL32(20, 30, 45, 255));
        // outline pass
        dl->AddCircle(ImVec2(c.x + r*0.50f, c.y - r*0.50f), r*0.32f, outline, 28, 1.6f);
    }
    else if (!strcmp(kind, "ملاحة"))
    {
        // glossy map pin with shadow & inner ring
        // ground shadow ellipse
        dl->AddCircleFilled(ImVec2(c.x, c.y + r*0.92f), r*0.30f,
                            IM_COL32(0, 0, 0, 90));
        // pin gradient body (red)
        dl->AddCircleFilled(ImVec2(c.x, c.y - r*0.18f), r*0.62f,
                            IM_COL32(220, 50, 50, 255));
        // upper highlight
        dl->AddCircleFilled(ImVec2(c.x - r*0.18f, c.y - r*0.36f), r*0.18f,
                            IM_COL32(255, 200, 200, 200));
        // pin tail triangle
        dl->AddTriangleFilled(
            ImVec2(c.x - r*0.36f, c.y + r*0.16f),
            ImVec2(c.x + r*0.36f, c.y + r*0.16f),
            ImVec2(c.x,           c.y + r*0.92f),
            IM_COL32(180, 30, 30, 255));
        // inner white circle
        dl->AddCircleFilled(ImVec2(c.x, c.y - r*0.18f), r*0.26f,
                            IM_COL32(252, 252, 252, 255));
        // small dot in center
        dl->AddCircleFilled(ImVec2(c.x, c.y - r*0.18f), r*0.10f,
                            IM_COL32(180, 30, 30, 255));
        // outer ring outline
        dl->AddCircle(ImVec2(c.x, c.y - r*0.18f), r*0.62f,
                      IM_COL32(110, 15, 15, 255), 36, 2.0f);
    }
    else if (!strcmp(kind, "قناع"))
    {
        // ski mask / balaclava with two eye holes and a mouth slit
        ImU32 fabric  = IM_COL32(35, 40, 50, 255);
        ImU32 fabricD = IM_COL32(20, 25, 35, 255);
        ImU32 stitch  = IM_COL32(80, 90, 105, 255);
        ImU32 eye     = IM_COL32(245, 245, 250, 255);
        ImU32 pupil   = IM_COL32(40, 50, 65, 255);

        // shadow
        dl->AddCircleFilled(ImVec2(c.x + r*0.04f, c.y + r*0.06f),
                            r*0.92f, IM_COL32(0, 0, 0, 90));

        // head silhouette (rounded rectangle)
        dl->AddRectFilledMultiColor(
            ImVec2(c.x - r*0.85f, c.y - r*0.95f),
            ImVec2(c.x + r*0.85f, c.y + r*0.85f),
            fabric, fabric, fabricD, fabricD);
        // round the top
        dl->AddCircleFilled(ImVec2(c.x, c.y - r*0.55f), r*0.85f, fabric);
        // narrow chin (pinched bottom)
        dl->AddTriangleFilled(
            ImVec2(c.x - r*0.85f, c.y + r*0.45f),
            ImVec2(c.x + r*0.85f, c.y + r*0.45f),
            ImVec2(c.x,           c.y + r*0.95f), fabricD);

        // stitching outline
        dl->AddCircle(ImVec2(c.x, c.y - r*0.55f), r*0.85f, stitch, 36, 1.4f);
        // eye holes (rounded ellipses)
        for (int s = -1; s <= 1; s += 2) {
            float ex = c.x + s * r*0.34f;
            float ey = c.y - r*0.10f;
            dl->AddRectFilled(ImVec2(ex - r*0.22f, ey - r*0.12f),
                              ImVec2(ex + r*0.22f, ey + r*0.12f),
                              eye, r*0.10f);
            dl->AddCircleFilled(ImVec2(ex, ey), r*0.08f, pupil);
            dl->AddCircleFilled(ImVec2(ex + r*0.04f, ey - r*0.03f),
                                r*0.025f, IM_COL32(255,255,255,200));
            dl->AddRect(ImVec2(ex - r*0.22f, ey - r*0.12f),
                        ImVec2(ex + r*0.22f, ey + r*0.12f),
                        stitch, r*0.10f, 0, 1.2f);
        }
        // mouth slit
        dl->AddRectFilled(ImVec2(c.x - r*0.30f, c.y + r*0.30f),
                          ImVec2(c.x + r*0.30f, c.y + r*0.42f),
                          IM_COL32(20, 25, 35, 255), r*0.04f);
        dl->AddRect(ImVec2(c.x - r*0.30f, c.y + r*0.30f),
                    ImVec2(c.x + r*0.30f, c.y + r*0.42f),
                    stitch, r*0.04f, 0, 1.2f);
    }
    else if (!strcmp(kind, "حبل"))
    {
        // coiled rope - 3 layered rings with twist marks
        ImU32 ropeOuter = IM_COL32(210, 170, 100, 255);
        ImU32 ropeInner = IM_COL32(170, 130,  70, 255);
        ImU32 ropeMid   = IM_COL32(195, 150,  90, 255);
        // shadow
        dl->AddCircleFilled(ImVec2(c.x + r*0.04f, c.y + r*0.06f),
                            r*0.88f, IM_COL32(0, 0, 0, 80));
        // 3 concentric rings
        for (int i = 0; i < 3; ++i) {
            float rr = r * (0.85f - i*0.22f);
            ImU32 fill = (i % 2 == 0) ? ropeOuter : ropeMid;
            dl->AddCircleFilled(c, rr, fill);
            dl->AddCircle(c, rr, IM_COL32(110, 80, 30, 220), 36, 1.6f);
        }
        // hole
        dl->AddCircleFilled(c, r*0.20f, ropeInner);
        dl->AddCircle(c, r*0.20f, IM_COL32(80, 55, 20, 255), 24, 1.4f);
        // twist hatch marks
        for (int i = 0; i < 12; ++i) {
            float a = i * (6.2832f / 12.0f);
            dl->AddLine(
                ImVec2(c.x + cosf(a) * r*0.40f, c.y + sinf(a) * r*0.40f),
                ImVec2(c.x + cosf(a) * r*0.62f, c.y + sinf(a) * r*0.62f),
                IM_COL32(110, 80, 30, 200), 1.4f);
        }
    }
    else if (!strcmp(kind, "بنزين"))
    {
        // jerrycan / fuel can with handle, spout cap, X mark
        ImU32 bodyTop = IM_COL32(220, 80, 70, 255);
        ImU32 bodyBot = IM_COL32(160, 35, 30, 255);
        ImU32 outline = IM_COL32(80, 15, 15, 255);
        ImU32 metal   = IM_COL32(210, 215, 225, 255);
        // shadow
        dl->AddRectFilled(ImVec2(c.x - r*0.80f, c.y - r*0.78f),
                          ImVec2(c.x + r*0.84f, c.y + r*0.92f),
                          IM_COL32(0, 0, 0, 90), r*0.10f);
        // main body gradient
        dl->AddRectFilledMultiColor(
            ImVec2(c.x - r*0.80f, c.y - r*0.80f),
            ImVec2(c.x + r*0.80f, c.y + r*0.85f),
            bodyTop, bodyTop, bodyBot, bodyBot);
        // top cap shoulder
        dl->AddRectFilled(ImVec2(c.x - r*0.80f, c.y - r*0.80f),
                          ImVec2(c.x + r*0.80f, c.y - r*0.55f),
                          IM_COL32(190, 50, 40, 255), r*0.10f);
        // handle (flat top)
        dl->AddRectFilled(ImVec2(c.x - r*0.40f, c.y - r*1.00f),
                          ImVec2(c.x + r*0.20f, c.y - r*0.80f),
                          IM_COL32(200, 60, 50, 255), r*0.06f);
        // spout cap (right side)
        dl->AddRectFilled(ImVec2(c.x + r*0.40f, c.y - r*1.00f),
                          ImVec2(c.x + r*0.62f, c.y - r*0.80f),
                          metal, r*0.04f);
        // body X mark (signature jerrycan)
        dl->AddLine(ImVec2(c.x - r*0.55f, c.y - r*0.30f),
                    ImVec2(c.x + r*0.55f, c.y + r*0.55f),
                    IM_COL32(120, 25, 20, 255), 3.0f);
        dl->AddLine(ImVec2(c.x + r*0.55f, c.y - r*0.30f),
                    ImVec2(c.x - r*0.55f, c.y + r*0.55f),
                    IM_COL32(120, 25, 20, 255), 3.0f);
        // outline
        dl->AddRect(ImVec2(c.x - r*0.80f, c.y - r*0.80f),
                    ImVec2(c.x + r*0.80f, c.y + r*0.85f),
                    outline, r*0.10f, 0, 1.6f);
    }
    else if (!strcmp(kind, "بذور"))
    {
        // sprouted seed packet shape: pot/soil + sprout
        ImU32 leafA  = IM_COL32(110, 220, 120, 255);
        ImU32 leafB  = IM_COL32( 60, 170,  80, 255);
        ImU32 stem   = IM_COL32( 90, 160,  60, 255);
        ImU32 soilA  = IM_COL32(120,  80,  50, 255);
        ImU32 soilB  = IM_COL32( 80,  50,  30, 255);
        // shadow
        dl->AddRectFilled(ImVec2(c.x - r*0.66f, c.y + r*0.30f),
                          ImVec2(c.x + r*0.70f, c.y + r*0.94f),
                          IM_COL32(0,0,0,80), r*0.10f);
        // pot trapezoid
        ImVec2 potTL(c.x - r*0.60f, c.y + r*0.30f);
        ImVec2 potTR(c.x + r*0.60f, c.y + r*0.30f);
        ImVec2 potBL(c.x - r*0.45f, c.y + r*0.85f);
        ImVec2 potBR(c.x + r*0.45f, c.y + r*0.85f);
        dl->AddQuadFilled(potTL, potTR, potBR, potBL, soilA);
        dl->AddTriangleFilled(potTL, potBR, potBL, soilB);
        // soil rim
        dl->AddRectFilled(ImVec2(c.x - r*0.65f, c.y + r*0.22f),
                          ImVec2(c.x + r*0.65f, c.y + r*0.34f),
                          IM_COL32(70, 45, 25, 255), r*0.04f);
        // stem
        dl->AddRectFilled(ImVec2(c.x - r*0.05f, c.y - r*0.40f),
                          ImVec2(c.x + r*0.05f, c.y + r*0.28f), stem);
        // left leaf
        dl->AddTriangleFilled(
            ImVec2(c.x - r*0.05f, c.y - r*0.10f),
            ImVec2(c.x - r*0.65f, c.y - r*0.45f),
            ImVec2(c.x - r*0.05f, c.y - r*0.50f), leafA);
        dl->AddTriangleFilled(
            ImVec2(c.x - r*0.05f, c.y - r*0.10f),
            ImVec2(c.x - r*0.65f, c.y - r*0.45f),
            ImVec2(c.x - r*0.30f, c.y - r*0.10f), leafB);
        // right leaf
        dl->AddTriangleFilled(
            ImVec2(c.x + r*0.05f, c.y - r*0.30f),
            ImVec2(c.x + r*0.70f, c.y - r*0.70f),
            ImVec2(c.x + r*0.05f, c.y - r*0.78f), leafA);
        dl->AddTriangleFilled(
            ImVec2(c.x + r*0.05f, c.y - r*0.30f),
            ImVec2(c.x + r*0.70f, c.y - r*0.70f),
            ImVec2(c.x + r*0.40f, c.y - r*0.30f), leafB);
    }
    else if (!strcmp(kind, "ذخيرة"))
    {
        // 3 rifle cartridges with brass casing + pointed tip
        ImU32 brassA  = IM_COL32(230, 195, 100, 255);
        ImU32 brassB  = IM_COL32(180, 140,  50, 255);
        ImU32 brassR  = IM_COL32(150, 110,  35, 255);
        ImU32 tipA    = IM_COL32(205,  80,  60, 255);
        ImU32 tipB    = IM_COL32(150,  35,  25, 255);
        ImU32 outline = IM_COL32( 60,  30,  10, 255);
        for (int i = -1; i <= 1; ++i)
        {
            float bx = c.x + i * r*0.50f;
            // shadow
            dl->AddRectFilled(ImVec2(bx - r*0.18f, c.y - r*0.50f),
                              ImVec2(bx + r*0.20f, c.y + r*0.84f),
                              IM_COL32(0,0,0,80), r*0.04f);
            // casing gradient
            dl->AddRectFilledMultiColor(
                ImVec2(bx - r*0.18f, c.y - r*0.55f),
                ImVec2(bx + r*0.18f, c.y + r*0.80f),
                brassA, brassB, brassB, brassA);
            // rim base
            dl->AddRectFilled(ImVec2(bx - r*0.22f, c.y + r*0.62f),
                              ImVec2(bx + r*0.22f, c.y + r*0.80f),
                              brassR, r*0.04f);
            // primer dot
            dl->AddCircleFilled(ImVec2(bx, c.y + r*0.71f), r*0.06f,
                                IM_COL32(120, 90, 30, 255));
            // bullet tip (pointed)
            dl->AddTriangleFilled(
                ImVec2(bx - r*0.18f, c.y - r*0.55f),
                ImVec2(bx + r*0.18f, c.y - r*0.55f),
                ImVec2(bx,           c.y - r*0.92f), tipA);
            // tip shadow
            dl->AddTriangleFilled(
                ImVec2(bx - r*0.18f, c.y - r*0.55f),
                ImVec2(bx,           c.y - r*0.55f),
                ImVec2(bx,           c.y - r*0.92f), tipB);
            // outline
            dl->AddLine(ImVec2(bx - r*0.18f, c.y - r*0.55f),
                        ImVec2(bx - r*0.18f, c.y + r*0.62f), outline, 1.2f);
            dl->AddLine(ImVec2(bx + r*0.18f, c.y - r*0.55f),
                        ImVec2(bx + r*0.18f, c.y + r*0.62f), outline, 1.2f);
        }
    }
    else if (!strcmp(kind, "أسلحة"))
    {
        // detailed pistol silhouette (slide + barrel + trigger guard + grip)
        ImU32 metalA  = IM_COL32( 90,  95, 110, 255);
        ImU32 metalB  = IM_COL32( 50,  55,  70, 255);
        ImU32 highlight = IM_COL32(160, 170, 185, 255);
        ImU32 outline = IM_COL32( 20,  25,  35, 255);
        ImU32 grip    = IM_COL32( 70,  45,  25, 255);
        ImU32 gripD   = IM_COL32( 45,  25,  10, 255);

        // shadow
        dl->AddRectFilled(ImVec2(c.x - r*0.86f, c.y - r*0.26f),
                          ImVec2(c.x + r*0.94f, c.y + r*0.10f),
                          IM_COL32(0,0,0,80), r*0.06f);
        // slide gradient
        dl->AddRectFilledMultiColor(
            ImVec2(c.x - r*0.85f, c.y - r*0.30f),
            ImVec2(c.x + r*0.92f, c.y + r*0.06f),
            metalA, metalA, metalB, metalB);
        // barrel front
        dl->AddRectFilled(ImVec2(c.x + r*0.75f, c.y - r*0.20f),
                          ImVec2(c.x + r*0.96f, c.y - r*0.04f),
                          metalB, r*0.02f);
        // ejection port
        dl->AddRectFilled(ImVec2(c.x - r*0.10f, c.y - r*0.20f),
                          ImVec2(c.x + r*0.30f, c.y - r*0.10f),
                          IM_COL32(20, 25, 35, 255));
        // top highlight
        dl->AddLine(ImVec2(c.x - r*0.78f, c.y - r*0.26f),
                    ImVec2(c.x + r*0.85f, c.y - r*0.26f),
                    highlight, 1.4f);
        // grip (slanted)
        ImVec2 gTL(c.x - r*0.55f, c.y + r*0.06f);
        ImVec2 gTR(c.x - r*0.10f, c.y + r*0.06f);
        ImVec2 gBL(c.x - r*0.65f, c.y + r*0.85f);
        ImVec2 gBR(c.x - r*0.20f, c.y + r*0.85f);
        dl->AddQuadFilled(gTL, gTR, gBR, gBL, grip);
        dl->AddTriangleFilled(gTL, gBR, gBL, gripD);
        // grip texture stripes
        for (int i = 0; i < 4; ++i) {
            float yy = c.y + r*0.18f + i * r*0.16f;
            dl->AddLine(ImVec2(c.x - r*0.50f, yy),
                        ImVec2(c.x - r*0.18f, yy),
                        IM_COL32(40, 25, 10, 200), 1.2f);
        }
        // trigger guard
        dl->AddRect(ImVec2(c.x - r*0.10f, c.y + r*0.06f),
                    ImVec2(c.x + r*0.30f, c.y + r*0.42f),
                    metalB, r*0.10f, 0, 2.0f);
        // trigger
        dl->AddTriangleFilled(
            ImVec2(c.x + r*0.05f, c.y + r*0.10f),
            ImVec2(c.x + r*0.18f, c.y + r*0.10f),
            ImVec2(c.x + r*0.10f, c.y + r*0.32f), metalB);
        // outline
        dl->AddRect(ImVec2(c.x - r*0.85f, c.y - r*0.30f),
                    ImVec2(c.x + r*0.92f, c.y + r*0.06f),
                    outline, r*0.04f, 0, 1.4f);
    }
    else
    {
        dl->AddCircleFilled(c, r * 0.6f, accentCol);
    }
}

// Draw a single resource card (icon + label + quantity).
static void DrawResourceCard(ImDrawList* dl, ImFont* font,
                             ImVec2 pMin, ImVec2 pMax,
                             const char* label, const char* iconKind,
                             int64_t value, ImU32 accent,
                             float scale, bool money = false)
{
    float rounding = 14.0f * scale;

    // Card body (subtle gradient)
    dl->AddRectFilledMultiColor(pMin, pMax,
        kColCardBgHi, kColCardBgHi,
        kColCardBg,   kColCardBg);
    dl->AddRect(pMin, pMax, kColBorderDim, rounding, 0, 1.2f);

    // Accent stripe (left)
    dl->AddRectFilled(ImVec2(pMin.x, pMin.y),
                      ImVec2(pMin.x + 3.5f * scale, pMax.y),
                      accent, 0.0f);

    // Icon disc
    float iconR = (pMax.y - pMin.y) * 0.32f;
    ImVec2 iconC(pMin.x + 24.0f * scale + iconR,
                 (pMin.y + pMax.y) * 0.5f);
    dl->AddCircleFilled(iconC, iconR + 3 * scale, IM_COL32(0,0,0,150));
    dl->AddCircleFilled(iconC, iconR, IM_COL32(28, 50, 40, 255));
    dl->AddCircle(iconC, iconR, accent, 32, 1.6f * scale);

    DrawItemIcon(dl, iconC, iconR * 0.9f, iconKind);

    // Label
    if (font)
    {
        float labelFs = 22.0f * scale;
        DrawShadowedText(dl, font, labelFs,
            ImVec2(iconC.x + iconR + 18.0f * scale,
                   pMin.y + 16.0f * scale),
            kColText, label);

        // Value (large, accent colour)
        char vbuf[64];
        if (money)
        {
            char m[64];
            FormatMoney(value, m, sizeof(m));
            snprintf(vbuf, sizeof(vbuf), "$ %s", m);
        }
        else
        {
            snprintf(vbuf, sizeof(vbuf), "x %lld", (long long)value);
        }
        float fs = 30.0f * scale;
        DrawShadowedText(dl, font, fs,
            ImVec2(iconC.x + iconR + 18.0f * scale,
                   pMin.y + 16.0f * scale + labelFs + 4.0f * scale),
            accent, vbuf);
    }
}

// =====================================================================
// New "الحقيبة" grid-style overlay (matches invetory.txt mockup).
// =====================================================================
//
// The design: a centred dark-green panel with rounded corners holds a
// 6x4 grid of square slot tiles. Each tile carries a coloured gradient,
// a vector icon, an optional badge (top-right) and an optional count
// (bottom-right) with the slot label rendered just below it. A pill-tab
// at the top of the panel says "الحقيبة"; a red round X sits on the
// top-right; chevron-arrow paginators sit at the bottom along with page
// dots showing the current page.
//
// Touch behaviour matches the previous overlay:
//   - tapping the X (or anywhere outside the panel after a tap) closes;
//   - tapping a usable slot (one that is wired to a SAMP dialog index)
//     fires Response(button=1, listitem=N) to drive the gamemode.
// =====================================================================

namespace InvGrid
{
    // Item palette parsed from invetory.txt (values match the React mock).
    enum Color { COL_RED, COL_ORANGE, COL_YELLOW, COL_GREEN,
                 COL_BLUE, COL_PURPLE, COL_WHITE, COL_COUNT };

    static ImU32 SlotFrom(Color c) {
        static const ImU32 v[COL_COUNT] = {
            IM_COL32(255,107,107,255),   // red
            IM_COL32(255,184,107,255),   // orange
            IM_COL32(255,224,102,255),   // yellow
            IM_COL32(105,219,124,255),   // green
            IM_COL32(116,192,252,255),   // blue
            IM_COL32(208,191,255,255),   // purple
            IM_COL32(248,249,250,255),   // white
        };
        return v[c];
    }
    static ImU32 SlotTo(Color c) {
        static const ImU32 v[COL_COUNT] = {
            IM_COL32(201, 42, 42,255),
            IM_COL32(232, 89, 12,255),
            IM_COL32(245,159,  0,255),
            IM_COL32( 47,158, 68,255),
            IM_COL32( 25,113,194,255),
            IM_COL32(103, 65,217,255),
            IM_COL32(206,212,218,255),
        };
        return v[c];
    }
    static ImU32 SlotRing(Color c, int alpha = 140) {
        static const ImU32 v[COL_COUNT] = {
            IM_COL32(255,120,120,140),
            IM_COL32(255,170, 90,140),
            IM_COL32(255,220, 90,140),
            IM_COL32(120,230,170,165),
            IM_COL32(120,180,255,140),
            IM_COL32(190,160,255,140),
            IM_COL32(220,230,225,140),
        };
        ImU32 col = v[c];
        return (col & 0x00FFFFFFu) | ((ImU32)alpha << 24);
    }

    struct Slot {
        const char* label;     // already in Arabic, ready for AddText
        const char* iconKind;  // matches DrawItemIcon
        int*        countPtr;  // null => fixed/no count
        const char* badge;     // null => no badge
        Color       color;
        int         dlgIndex;  // >0 => tap fires SAMP dialog response
        const char* useCmd;    // null => no chat command on tap
    };
}

static void DrawNewIcon(ImDrawList* dl, ImVec2 c, float r, const char* kind)
{
    // Icons used by the new grid that don't already exist in DrawItemIcon().
    // Falls back to DrawItemIcon for known kinds.
    ImU32 white = IM_COL32(255,255,255,235);
    if (!strcmp(kind, "ghost")) {
        dl->AddCircleFilled(ImVec2(c.x, c.y - r*0.30f), r*0.85f, white);
        dl->AddRectFilled(ImVec2(c.x - r*0.85f, c.y - r*0.30f),
                          ImVec2(c.x + r*0.85f, c.y + r*0.65f), white);
        for (int i = -2; i <= 2; ++i) {
            dl->AddTriangleFilled(
                ImVec2(c.x + i*r*0.30f - r*0.15f, c.y + r*0.65f),
                ImVec2(c.x + i*r*0.30f + r*0.15f, c.y + r*0.65f),
                ImVec2(c.x + i*r*0.30f,           c.y + r*0.95f), white);
        }
        dl->AddCircleFilled(ImVec2(c.x - r*0.30f, c.y - r*0.30f), r*0.10f, IM_COL32(0,0,0,255));
        dl->AddCircleFilled(ImVec2(c.x + r*0.30f, c.y - r*0.30f), r*0.10f, IM_COL32(0,0,0,255));
    } else if (!strcmp(kind, "wine")) {
        dl->AddTriangleFilled(ImVec2(c.x - r*0.55f, c.y - r*0.85f),
                              ImVec2(c.x + r*0.55f, c.y - r*0.85f),
                              ImVec2(c.x,           c.y + r*0.05f), white);
        dl->AddRectFilled(ImVec2(c.x - r*0.06f, c.y + r*0.05f),
                          ImVec2(c.x + r*0.06f, c.y + r*0.55f), white);
        dl->AddRectFilled(ImVec2(c.x - r*0.40f, c.y + r*0.55f),
                          ImVec2(c.x + r*0.40f, c.y + r*0.70f), white);
    } else if (!strcmp(kind, "skull")) {
        dl->AddCircleFilled(c, r*0.85f, white);
        dl->AddCircleFilled(ImVec2(c.x - r*0.30f, c.y - r*0.10f), r*0.18f, IM_COL32(0,0,0,255));
        dl->AddCircleFilled(ImVec2(c.x + r*0.30f, c.y - r*0.10f), r*0.18f, IM_COL32(0,0,0,255));
        for (int i = -1; i <= 1; ++i)
            dl->AddRectFilled(ImVec2(c.x + i*r*0.18f - r*0.04f, c.y + r*0.40f),
                              ImVec2(c.x + i*r*0.18f + r*0.04f, c.y + r*0.65f),
                              IM_COL32(0,0,0,255));
    } else if (!strcmp(kind, "fish")) {
        dl->AddTriangleFilled(
            ImVec2(c.x - r*0.85f, c.y),
            ImVec2(c.x + r*0.30f, c.y - r*0.55f),
            ImVec2(c.x + r*0.30f, c.y + r*0.55f), white);
        dl->AddTriangleFilled(
            ImVec2(c.x + r*0.30f, c.y - r*0.40f),
            ImVec2(c.x + r*0.30f, c.y + r*0.40f),
            ImVec2(c.x + r*0.85f, c.y),           white);
        dl->AddCircleFilled(ImVec2(c.x - r*0.40f, c.y - r*0.10f), r*0.10f, IM_COL32(0,0,0,255));
    } else if (!strcmp(kind, "anchor")) {
        dl->AddCircle(ImVec2(c.x, c.y - r*0.65f), r*0.25f, white, 24, 3.0f);
        dl->AddRectFilled(ImVec2(c.x - r*0.06f, c.y - r*0.40f),
                          ImVec2(c.x + r*0.06f, c.y + r*0.55f), white);
        dl->AddLine(ImVec2(c.x - r*0.55f, c.y + r*0.55f),
                    ImVec2(c.x + r*0.55f, c.y + r*0.55f), white, 4.0f);
        dl->AddLine(ImVec2(c.x - r*0.55f, c.y + r*0.55f),
                    ImVec2(c.x - r*0.30f, c.y + r*0.85f), white, 4.0f);
        dl->AddLine(ImVec2(c.x + r*0.55f, c.y + r*0.55f),
                    ImVec2(c.x + r*0.30f, c.y + r*0.85f), white, 4.0f);
    } else if (!strcmp(kind, "stetho")) {
        // medical / aid kit cross on a white square
        dl->AddRectFilled(ImVec2(c.x - r*0.85f, c.y - r*0.65f),
                          ImVec2(c.x + r*0.85f, c.y + r*0.85f),
                          white, r*0.18f);
        dl->AddRectFilled(ImVec2(c.x - r*0.55f, c.y - r*0.85f),
                          ImVec2(c.x + r*0.55f, c.y - r*0.55f),
                          white, r*0.10f);
        dl->AddRectFilled(ImVec2(c.x - r*0.55f, c.y - r*0.20f),
                          ImVec2(c.x + r*0.55f, c.y + r*0.20f),
                          IM_COL32(220,40,40,255));
        dl->AddRectFilled(ImVec2(c.x - r*0.20f, c.y - r*0.55f),
                          ImVec2(c.x + r*0.20f, c.y + r*0.55f),
                          IM_COL32(220,40,40,255));
    } else if (!strcmp(kind, "sparkles")) {
        for (int i = 0; i < 4; ++i) {
            float a = (float)i * 1.5707963f;
            float dx = cosf(a), dy = sinf(a);
            dl->AddLine(ImVec2(c.x - dx*r*0.85f, c.y - dy*r*0.85f),
                        ImVec2(c.x + dx*r*0.85f, c.y + dy*r*0.85f),
                        white, 3.0f);
        }
        dl->AddCircleFilled(c, r*0.18f, white);
    } else if (!strcmp(kind, "gift")) {
        dl->AddRectFilled(ImVec2(c.x - r*0.85f, c.y - r*0.30f),
                          ImVec2(c.x + r*0.85f, c.y + r*0.85f),
                          white, r*0.10f);
        dl->AddRectFilled(ImVec2(c.x - r*0.85f, c.y - r*0.45f),
                          ImVec2(c.x + r*0.85f, c.y - r*0.20f),
                          white);
        dl->AddRectFilled(ImVec2(c.x - r*0.10f, c.y - r*0.45f),
                          ImVec2(c.x + r*0.10f, c.y + r*0.85f),
                          IM_COL32(180,40,40,255));
        // bow
        dl->AddCircleFilled(ImVec2(c.x - r*0.25f, c.y - r*0.55f), r*0.15f, IM_COL32(180,40,40,255));
        dl->AddCircleFilled(ImVec2(c.x + r*0.25f, c.y - r*0.55f), r*0.15f, IM_COL32(180,40,40,255));
    } else if (!strcmp(kind, "shirt")) {
        dl->AddTriangleFilled(ImVec2(c.x - r*0.85f, c.y - r*0.55f),
                              ImVec2(c.x - r*0.45f, c.y - r*0.85f),
                              ImVec2(c.x - r*0.30f, c.y - r*0.45f), white);
        dl->AddTriangleFilled(ImVec2(c.x + r*0.85f, c.y - r*0.55f),
                              ImVec2(c.x + r*0.45f, c.y - r*0.85f),
                              ImVec2(c.x + r*0.30f, c.y - r*0.45f), white);
        dl->AddRectFilled(ImVec2(c.x - r*0.45f, c.y - r*0.55f),
                          ImVec2(c.x + r*0.45f, c.y + r*0.85f),
                          white, r*0.10f);
        // V-neck
        dl->AddTriangleFilled(ImVec2(c.x - r*0.15f, c.y - r*0.55f),
                              ImVec2(c.x + r*0.15f, c.y - r*0.55f),
                              ImVec2(c.x,           c.y - r*0.20f),
                              IM_COL32(40,60,50,255));
    } else if (!strcmp(kind, "crown")) {
        dl->AddTriangleFilled(ImVec2(c.x - r*0.85f, c.y + r*0.40f),
                              ImVec2(c.x - r*0.85f, c.y - r*0.40f),
                              ImVec2(c.x - r*0.45f, c.y + r*0.10f), white);
        dl->AddTriangleFilled(ImVec2(c.x + r*0.85f, c.y + r*0.40f),
                              ImVec2(c.x + r*0.85f, c.y - r*0.40f),
                              ImVec2(c.x + r*0.45f, c.y + r*0.10f), white);
        dl->AddTriangleFilled(ImVec2(c.x,           c.y - r*0.65f),
                              ImVec2(c.x - r*0.30f, c.y + r*0.10f),
                              ImVec2(c.x + r*0.30f, c.y + r*0.10f), white);
        dl->AddRectFilled(ImVec2(c.x - r*0.85f, c.y + r*0.40f),
                          ImVec2(c.x + r*0.85f, c.y + r*0.85f), white);
        dl->AddCircleFilled(ImVec2(c.x, c.y + r*0.65f), r*0.12f, IM_COL32(220, 60, 60, 255));
    } else if (!strcmp(kind, "wand")) {
        dl->AddCircleFilled(c, r*0.55f, white);
        dl->AddCircleFilled(c, r*0.35f, IM_COL32(60, 130, 220, 255));
        dl->AddCircleFilled(c, r*0.15f, IM_COL32(0, 0, 0, 255));
    } else if (!strcmp(kind, "hammer")) {
        dl->AddRectFilled(ImVec2(c.x - r*0.85f, c.y - r*0.65f),
                          ImVec2(c.x + r*0.10f, c.y - r*0.20f),
                          white, r*0.05f);
        dl->AddRectFilled(ImVec2(c.x + r*0.10f, c.y - r*0.10f),
                          ImVec2(c.x + r*0.30f, c.y + r*0.85f),
                          white);
    } else if (!strcmp(kind, "phone")) {
        dl->AddRectFilled(ImVec2(c.x - r*0.55f, c.y - r*0.95f),
                          ImVec2(c.x + r*0.55f, c.y + r*0.95f),
                          IM_COL32(40, 60, 50, 255), r*0.25f);
        dl->AddRectFilled(ImVec2(c.x - r*0.45f, c.y - r*0.75f),
                          ImVec2(c.x + r*0.45f, c.y + r*0.55f),
                          IM_COL32(170, 220, 250, 230), r*0.10f);
        dl->AddCircleFilled(ImVec2(c.x, c.y + r*0.75f), r*0.10f, white);
    } else if (!strcmp(kind, "flame")) {
        dl->AddTriangleFilled(ImVec2(c.x - r*0.55f, c.y + r*0.85f),
                              ImVec2(c.x + r*0.55f, c.y + r*0.85f),
                              ImVec2(c.x,           c.y - r*0.85f), white);
        dl->AddTriangleFilled(ImVec2(c.x - r*0.30f, c.y + r*0.85f),
                              ImVec2(c.x + r*0.30f, c.y + r*0.85f),
                              ImVec2(c.x,           c.y - r*0.20f),
                              IM_COL32(255, 220, 90, 255));
    } else if (!strcmp(kind, "pill")) {
        dl->AddCircleFilled(ImVec2(c.x - r*0.40f, c.y), r*0.55f, IM_COL32(255,255,255,255));
        dl->AddCircleFilled(ImVec2(c.x + r*0.40f, c.y), r*0.55f, IM_COL32(60,60,80,255));
        dl->AddLine(ImVec2(c.x, c.y - r*0.55f), ImVec2(c.x, c.y + r*0.55f),
                    IM_COL32(0,0,0,140), 2.0f);
    } else if (!strcmp(kind, "cross")) {
        dl->AddRectFilled(ImVec2(c.x - r*0.20f, c.y - r*0.85f),
                          ImVec2(c.x + r*0.20f, c.y + r*0.85f), white);
        dl->AddRectFilled(ImVec2(c.x - r*0.85f, c.y - r*0.20f),
                          ImVec2(c.x + r*0.85f, c.y + r*0.20f), white);
    } else if (!strcmp(kind, "backpack")) {
        dl->AddRectFilled(ImVec2(c.x - r*0.75f, c.y - r*0.60f),
                          ImVec2(c.x + r*0.75f, c.y + r*0.85f),
                          white, r*0.20f);
        dl->AddRectFilled(ImVec2(c.x - r*0.30f, c.y - r*0.85f),
                          ImVec2(c.x + r*0.30f, c.y - r*0.50f),
                          white, r*0.10f);
        dl->AddRectFilled(ImVec2(c.x - r*0.50f, c.y),
                          ImVec2(c.x + r*0.50f, c.y + r*0.30f),
                          IM_COL32(40,60,50,255));
    } else if (!strcmp(kind, "shield")) {
        dl->AddTriangleFilled(ImVec2(c.x - r*0.75f, c.y - r*0.55f),
                              ImVec2(c.x + r*0.75f, c.y - r*0.55f),
                              ImVec2(c.x,           c.y + r*0.85f), white);
        dl->AddRectFilled(ImVec2(c.x - r*0.75f, c.y - r*0.85f),
                          ImVec2(c.x + r*0.75f, c.y - r*0.55f), white);
    } else {
        DrawItemIcon(dl, c, r, kind);
    }
}

// Draw one inventory grid slot (square tile + optional badge/count + label).
static void DrawInvSlot(ImDrawList* dl, ImFont* font, ImVec2 pMin,
                        float side, const InvGrid::Slot* slot,
                        bool empty, bool hovered, float scale)
{
    using namespace InvGrid;

    float rounding = 16.0f * scale;
    ImVec2 pMax(pMin.x + side, pMin.y + side);

    if (empty || !slot) {
        // Empty slot: dark inset square (matches "rgba(8,30,20,0.55)").
        dl->AddRectFilled(pMin, pMax, IM_COL32(8, 30, 20, 140), rounding);
        dl->AddRect(pMin, pMax, IM_COL32(120, 230, 170, 46),
                    rounding, 0, 1.4f * scale);
        // Subtle inner highlight (matches "inset 0 1px 0 rgba(255,255,255,0.04)").
        dl->AddLine(ImVec2(pMin.x + 4, pMin.y + 1),
                    ImVec2(pMax.x - 4, pMin.y + 1),
                    IM_COL32(255, 255, 255, 10), 1.0f);
        return;
    }

    ImU32 from = SlotFrom(slot->color);
    ImU32 to   = SlotTo(slot->color);
    ImU32 ring = SlotRing(slot->color, hovered ? 230 : 165);

    // Card body: diagonal gradient (top-left bright -> bottom-right deep).
    dl->AddRectFilledMultiColor(pMin, pMax, from, from, to, to);
    // The above gives a vertical gradient; overlay a horizontal one to
    // approximate the "linear-gradient(155deg, ...)" of the mockup.
    dl->AddRectFilledMultiColor(pMin, pMax,
        IM_COL32(255,255,255, 40), IM_COL32(0,0,0,40),
        IM_COL32(0,  0,  0,   0), IM_COL32(0,0,0, 0));

    // Inner top highlight (mockup's inset 0 1px 0 rgba(255,255,255,0.35)).
    dl->AddLine(ImVec2(pMin.x + rounding * 0.5f, pMin.y + 2),
                ImVec2(pMax.x - rounding * 0.5f, pMin.y + 2),
                IM_COL32(255, 255, 255, 90), 1.5f);

    // Inner bottom shadow (mockup's inset 0 -12px 18px rgba(0,0,0,0.18)).
    dl->AddRectFilledMultiColor(
        ImVec2(pMin.x + 1, pMax.y - 12 * scale),
        ImVec2(pMax.x - 1, pMax.y - 1),
        IM_COL32(0, 0, 0, 0), IM_COL32(0, 0, 0, 0),
        IM_COL32(0, 0, 0, 60), IM_COL32(0, 0, 0, 60));

    // Outer ring.
    dl->AddRect(pMin, pMax, ring, rounding, 0,
                hovered ? 2.4f * scale : 1.6f * scale);

    // Hover halo (matches the mockup's "boxShadow: 0 8px 18px -8px ring").
    if (hovered) {
        for (int i = 1; i <= 3; ++i)
            dl->AddRect(ImVec2(pMin.x - i, pMin.y - i),
                        ImVec2(pMax.x + i, pMax.y + i),
                        (ring & 0x00FFFFFFu) | ((ImU32)(60 - i*15) << 24),
                        rounding + i, 0, 1.4f);
    }

    // Icon disc.
    ImVec2 c((pMin.x + pMax.x) * 0.5f, (pMin.y + pMax.y) * 0.5f);
    float r = side * 0.30f;
    DrawNewIcon(dl, c, r, slot->iconKind);

    // Badge (top-right) — green pill matching the mockup's accent.
    if (font && slot->badge) {
        float fs = 22.0f * scale;
        ImVec2 ts = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, slot->badge);
        ImVec2 bMin(pMax.x - ts.x - 10 * scale, pMin.y - 4 * scale);
        ImVec2 bMax(pMax.x - 2 * scale,         pMin.y + ts.y + 4 * scale);
        dl->AddRectFilled(bMin, bMax, IM_COL32(61, 220, 132, 255),
                          5.0f * scale);
        dl->AddText(font, fs,
                    ImVec2(bMin.x + 4 * scale, bMin.y + 2 * scale),
                    IM_COL32(10, 42, 29, 255), slot->badge);
    }

    // Count (bottom-right) — white text with strong shadow.
    if (font && slot->countPtr) {
        char buf[16];
        snprintf(buf, sizeof(buf), "x%d", *slot->countPtr);
        float fs = 30.0f * scale;
        ImVec2 ts = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, buf);
        ImVec2 tp(pMax.x - ts.x - 6 * scale, pMax.y - ts.y - 4 * scale);
        dl->AddText(font, fs, ImVec2(tp.x + 1, tp.y + 1),
                    IM_COL32(0, 0, 0, 200), buf);
        dl->AddText(font, fs, tp, IM_COL32(255, 255, 255, 255), buf);
    }
}

// Draw the chevron paginator buttons at the bottom of the panel.
static void DrawChevronButton(ImDrawList* dl, ImVec2 c, float r,
                              bool left, bool hovered, float scale)
{
    ImU32 top    = IM_COL32(122, 245, 182, 255);
    ImU32 mid    = IM_COL32( 61, 220, 132, 255);
    ImU32 bot    = IM_COL32( 31, 170,  95, 255);
    ImU32 border = IM_COL32(255, 255, 255, 90);

    ImVec2 pMin(c.x - r * 1.20f, c.y - r * 0.85f);
    ImVec2 pMax(c.x + r * 1.20f, c.y + r * 0.85f);
    float round = r * 0.45f;
    dl->AddRectFilledMultiColor(pMin, pMax, top, top, bot, bot);
    dl->AddRectFilled(ImVec2(pMin.x, pMin.y + (pMax.y-pMin.y)*0.35f),
                      ImVec2(pMax.x, pMin.y + (pMax.y-pMin.y)*0.65f),
                      mid, round * 0.0f);
    dl->AddRect(pMin, pMax, border, round, 0, 1.4f * scale);

    if (hovered) {
        dl->AddRect(ImVec2(pMin.x - 2, pMin.y - 2),
                    ImVec2(pMax.x + 2, pMax.y + 2),
                    IM_COL32(122, 245, 182, 200), round + 2, 0, 1.6f * scale);
    }

    float ax = r * 0.25f, ay = r * 0.45f;
    ImU32 ink = IM_COL32(10, 42, 29, 255);
    if (left) {
        dl->AddTriangleFilled(ImVec2(c.x + ax, c.y - ay),
                              ImVec2(c.x + ax, c.y + ay),
                              ImVec2(c.x - ax, c.y), ink);
    } else {
        dl->AddTriangleFilled(ImVec2(c.x - ax, c.y - ay),
                              ImVec2(c.x - ax, c.y + ay),
                              ImVec2(c.x + ax, c.y), ink);
    }
}

// =====================================================================
// Render
// =====================================================================
void CInventoryOverlay::Render()
{
    if (!m_bVisible) return;

    using namespace InvGrid;

    ImGuiIO& io = ImGui::GetIO();

    // Animate in (260ms ease-out)
    if (m_fAnimT < 1.0f)
    {
        m_fAnimT += io.DeltaTime / 0.26f;
        if (m_fAnimT > 1.0f) m_fAnimT = 1.0f;
    }
    float ease = 1.0f - (1.0f - m_fAnimT) * (1.0f - m_fAnimT);

    // Scale relative to a 1080-tall canvas, but the new panel is much
    // narrower than the old wide HUD (mockup is ~720px wide on 1080p).
    float scale = io.DisplaySize.y / 1080.0f;

    // Slot tile size is the principal driver of layout.
    const int kCols = 6;
    const int kRows = 4;
    float tileSide = 152.0f * scale;
    float tileGapX = 16.0f * scale;
    float tileGapY = 22.0f * scale;

    float panelPadX = 36.0f * scale;
    float panelPadTop = 34.0f * scale;
    float panelPadBot = 42.0f * scale;
    float headerH    = 92.0f * scale;
    float footerH    = 80.0f * scale;
    float gridW      = kCols * tileSide + (kCols - 1) * tileGapX;
    float labelArea  = 56.0f * scale; // height reserved under each tile for label
    float gridH      = kRows * tileSide + (kRows - 1) * tileGapY + labelArea * kRows;

    float panelW = gridW + panelPadX * 2.0f;
    float panelH = panelPadTop + headerH + 20.0f * scale + gridH + footerH + panelPadBot;

    // Clamp on small / odd-aspect displays.
    if (panelW > io.DisplaySize.x * 0.96f) {
        float k = (io.DisplaySize.x * 0.96f) / panelW;
        panelW *= k; panelH *= k;
        tileSide *= k; tileGapX *= k; tileGapY *= k;
        panelPadX *= k; panelPadTop *= k; panelPadBot *= k;
        headerH *= k; footerH *= k; gridW *= k; gridH *= k;
        labelArea *= k; scale *= k;
    }
    if (panelH > io.DisplaySize.y * 0.95f) {
        float k = (io.DisplaySize.y * 0.95f) / panelH;
        panelW *= k; panelH *= k;
        tileSide *= k; tileGapX *= k; tileGapY *= k;
        panelPadX *= k; panelPadTop *= k; panelPadBot *= k;
        headerH *= k; footerH *= k; gridW *= k; gridH *= k;
        labelArea *= k; scale *= k;
    }

    float panelX = (io.DisplaySize.x - panelW) * 0.5f;
    float panelY = (io.DisplaySize.y - panelH) * 0.5f;
    panelY -= (1.0f - ease) * 30.0f * scale;   // slide-in

    ImDrawList* dl = ImGui::GetOverlayDrawList();

    // -----------------------------------------------------------------
    // Backdrop (radial gradient + modal dim) — matches the mockup's
    // "radial-gradient(ellipse at 20% 20%, #0e3b27, #061b13, #02100a)".
    // -----------------------------------------------------------------
    {
        // Plain dim first.
        dl->AddRectFilled(ImVec2(0, 0), io.DisplaySize,
                          IM_COL32(0, 0, 0, (int)(140 * ease)));

        // Soft elliptical green wash anchored top-left, fading to nothing.
        ImVec2 gC(io.DisplaySize.x * 0.20f, io.DisplaySize.y * 0.20f);
        float gR = (io.DisplaySize.x + io.DisplaySize.y) * 0.55f;
        for (int i = 0; i < 14; ++i) {
            float t = (float)i / 14.0f;
            int   a = (int)((1.0f - t) * 22.0f * ease);
            dl->AddCircle(gC, gR * (0.30f + t * 0.70f),
                          IM_COL32(14, 60, 39, a), 80, 18.0f);
        }
    }

    // -----------------------------------------------------------------
    // Outer panel (rounded, dark green with subtle inner glow + border)
    // -----------------------------------------------------------------
    ImVec2 pMin(panelX, panelY);
    ImVec2 pMax(panelX + panelW, panelY + panelH);
    float rounding = 28.0f * scale;

    // Drop shadow.
    for (int i = 0; i < 10; ++i) {
        float t = (float)i / 10.0f;
        dl->AddRect(
            ImVec2(pMin.x - i, pMin.y - i + 4),
            ImVec2(pMax.x + i, pMax.y + i + 4),
            IM_COL32(0, 0, 0, (int)((1.0f - t) * 18 * ease)),
            rounding + i, 0, 1.4f);
    }
    // Panel body (mockup: rgba(14,48,33,0.78) with backdrop blur).
    dl->AddRectFilled(pMin, pMax, IM_COL32(14, 48, 33, 235), rounding);
    dl->AddRect(pMin, pMax, IM_COL32(120, 230, 170, 90),
                rounding, 0, 1.6f * scale);

    ImFont* font = pGUI ? pGUI->GetFont() : nullptr;

    // -----------------------------------------------------------------
    // Top tab pill — "الحقيبة" (overlapping the panel's top edge)
    // -----------------------------------------------------------------
    {
        const char* tabText = "الحقيبة";
        float fsTab = 34.0f * scale;
        ImVec2 ts = font ? font->CalcTextSizeA(fsTab, FLT_MAX, 0.0f, tabText)
                         : ImVec2(70 * scale, fsTab);
        // Pill width: shield + gap + text, with healthy padding.
        float shieldW = 30 * scale;
        float pillW = shieldW + 16 * scale + ts.x + 80 * scale;
        float pillH = 64 * scale;
        ImVec2 tMin((pMin.x + pMax.x) * 0.5f - pillW * 0.5f,
                    pMin.y - pillH * 0.55f);
        ImVec2 tMax(tMin.x + pillW, tMin.y + pillH);
        float tr = pillH * 0.5f;

        // Gradient: lighter green top -> mid -> darker bottom.
        dl->AddRectFilled(tMin, tMax,
                          IM_COL32(122, 245, 182, 255), tr);
        dl->AddRectFilledMultiColor(
            ImVec2(tMin.x, tMin.y + pillH * 0.40f), tMax,
            IM_COL32( 61, 220, 132, 255), IM_COL32( 61, 220, 132, 255),
            IM_COL32( 31, 170,  95, 255), IM_COL32( 31, 170,  95, 255));
        dl->AddRect(tMin, tMax, IM_COL32(255, 255, 255, 90), tr, 0, 1.4f * scale);
        // Shield icon
        DrawNewIcon(dl, ImVec2(tMin.x + 32 * scale,
                               (tMin.y + tMax.y) * 0.5f),
                    16 * scale, "shield");
        // Label
        if (font) {
            ImVec2 tp(tMin.x + 32 * scale + shieldW + 16 * scale,
                      (tMin.y + tMax.y) * 0.5f - ts.y * 0.5f);
            dl->AddText(font, fsTab, ImVec2(tp.x + 1, tp.y + 1),
                        IM_COL32(255, 255, 255, 90), tabText);
            dl->AddText(font, fsTab, tp, IM_COL32(10, 42, 29, 255), tabText);
        }
    }

    // -----------------------------------------------------------------
    // Top-right close button (red gradient, rounded square)
    // -----------------------------------------------------------------
    float closeS = 60 * scale;
    ImVec2 closeMin(pMax.x - closeS - 4 * scale, pMin.y - closeS * 0.30f);
    ImVec2 closeMax(closeMin.x + closeS, closeMin.y + closeS);
    bool closeHover = (io.MousePos.x >= closeMin.x - 6 &&
                       io.MousePos.x <= closeMax.x + 6 &&
                       io.MousePos.y >= closeMin.y - 6 &&
                       io.MousePos.y <= closeMax.y + 6);
    {
        float cr = closeS * 0.32f;
        dl->AddRectFilledMultiColor(closeMin, closeMax,
            IM_COL32(255, 107, 107, 255), IM_COL32(255, 107, 107, 255),
            IM_COL32(201,  42,  42, 255), IM_COL32(201,  42,  42, 255));
        dl->AddRect(closeMin, closeMax, IM_COL32(255, 255, 255, 90),
                    cr, 0, 1.4f * scale);
        if (closeHover) {
            dl->AddRect(ImVec2(closeMin.x - 2, closeMin.y - 2),
                        ImVec2(closeMax.x + 2, closeMax.y + 2),
                        IM_COL32(255, 180, 180, 200), cr + 2, 0, 1.6f * scale);
        }
        // X mark
        ImVec2 cc((closeMin.x + closeMax.x) * 0.5f,
                  (closeMin.y + closeMax.y) * 0.5f);
        float xs = closeS * 0.22f;
        dl->AddLine(ImVec2(cc.x - xs, cc.y - xs),
                    ImVec2(cc.x + xs, cc.y + xs),
                    IM_COL32(255, 255, 255, 255), 3.0f * scale);
        dl->AddLine(ImVec2(cc.x + xs, cc.y - xs),
                    ImVec2(cc.x - xs, cc.y + xs),
                    IM_COL32(255, 255, 255, 255), 3.0f * scale);
    }

    static bool s_wasDown = false;
    if (io.MouseDown[0] && !s_wasDown) {
        // Close button hit-box (slightly oversized for touch).
        if (io.MousePos.x >= closeMin.x - 14 && io.MousePos.x <= closeMax.x + 14 &&
            io.MousePos.y >= closeMin.y - 14 && io.MousePos.y <= closeMax.y + 14) {
            Hide();
            s_wasDown = io.MouseDown[0];
            return;
        }
    }

    // -----------------------------------------------------------------
    // Build slot list — order matches the mockup (18 filled + 6 empty).
    // Slot data is bound to the existing payload fields on each render so
    // counts stay live with the inv_ui.pwn periodic refresh.
    // -----------------------------------------------------------------
    Slot slots[24];
    int  filledCount = 0;
    {
        // Static template; counts come from member fields.
        // Each row also carries the SAMP chat command (if any) that the
        // gamemode exposes for actually "using" the item. Items with
        // no usable command (raw resources like ammo / seed / mats)
        // are still shown but a tap on them is a no-op.
        struct Tpl {
            const char* label; const char* iconKind; int* countPtr;
            const char* badge; Color color; int dlgIndex;
            const char* useCmd;
        };
        Tpl tpl[18] = {
            // Row 1 — medical
            {"إسعاف",      "stetho",    &m_iAidKit,    nullptr,  COL_RED,    1, "/healme"},
            {"ضماد",        "cross",     &m_iBandage,   nullptr,  COL_WHITE,  2, "/healme"},
            {"جبيرة",       "schiene",   &m_iSchiene,   nullptr,  COL_ORANGE, 3, "/healme"},
            {"أسبرين",      "aspirin",   &m_iAspirin,   nullptr,  COL_WHITE,  4, "/healme"},
            {"مورفين",      "morphine",  &m_iMorphine,  nullptr,  COL_BLUE,   5, "/healme"},
            {"أدرينالين",   "adrenalin", &m_iAdrenalin, nullptr,  COL_YELLOW, 6, "/healme"},
            // Row 2 — wallet & resources
            {"جوال",        "phone",     &m_iPhone,     nullptr,  COL_WHITE,  -1, "/phone"},
            {"مواد",        "مواد",      &m_iMats,      nullptr,  COL_ORANGE, -1, nullptr},
            {"مخدرات",      "pill",      &m_iDrugs,     nullptr,  COL_GREEN,  7, "/usedrugs"},
            {"سجائر",       "دخان",      &m_iCigs,      nullptr,  COL_YELLOW, -1, nullptr},
            {"عدة تصليح",   "تصليح",     &m_iRepairKit, nullptr,  COL_WHITE,  -1, "/repairkit"},
            {"ملاحة",       "ملاحة",      &m_iGPS,       "GPS",    COL_PURPLE, -1, "/gps"},
            // Row 3 — tools & combat
            {"قناع",         "قناع",       &m_iMask,      nullptr,  COL_WHITE,  -1, "/mask"},
            {"حبل",          "anchor",    &m_iRope,      nullptr,  COL_ORANGE, -1, nullptr},
            {"بنزين",        "بنزين",     &m_iCanister,  nullptr,  COL_RED,    -1, "/usecan"},
            {"بذور",         "بذور",      &m_iSeed,      nullptr,  COL_GREEN,  -1, nullptr},
            {"ذخيرة",        "ذخيرة",      &m_iAmmo,      nullptr,  COL_YELLOW, -1, nullptr},
            {"أسلحة",        "أسلحة",      &m_iGuns,      nullptr,  COL_WHITE,  -1, nullptr},
        };
        // Only show items the player actually owns (count > 0). Empty
        // slots fill the rest of the 24-cell grid so the layout stays tidy.
        for (int i = 0; i < 18; ++i) {
            int qty = (tpl[i].countPtr) ? *tpl[i].countPtr : 0;
            if (qty <= 0) continue;
            int dst = filledCount++;
            if (dst >= 24) break;
            slots[dst].label    = tpl[i].label;
            slots[dst].iconKind = tpl[i].iconKind;
            slots[dst].countPtr = tpl[i].countPtr;
            slots[dst].badge    = tpl[i].badge;
            slots[dst].color    = tpl[i].color;
            slots[dst].dlgIndex = tpl[i].dlgIndex;
            slots[dst].useCmd   = tpl[i].useCmd;
        }
        for (int i = filledCount; i < 24; ++i) {
            slots[i].label = nullptr; slots[i].iconKind = nullptr;
            slots[i].countPtr = nullptr; slots[i].badge = nullptr;
            slots[i].color = COL_WHITE; slots[i].dlgIndex = -1;
            slots[i].useCmd = nullptr;
        }
    }

    // -----------------------------------------------------------------
    // Header row inside the panel: backpack icon + "العناصر" label,
    // slot count text, and a thin capacity bar on the right.
    // -----------------------------------------------------------------
    float headerY = pMin.y + panelPadTop;
    {
        // Backpack disc
        float discS = 60 * scale;
        ImVec2 discMin(pMin.x + panelPadX, headerY + 2 * scale);
        ImVec2 discMax(discMin.x + discS, discMin.y + discS);
        dl->AddRectFilledMultiColor(discMin, discMax,
            IM_COL32(122, 245, 182, 255), IM_COL32(122, 245, 182, 255),
            IM_COL32( 61, 220, 132, 255), IM_COL32( 61, 220, 132, 255));
        dl->AddRect(discMin, discMax, IM_COL32(255, 255, 255, 90),
                    8 * scale, 0, 1.2f * scale);
        DrawNewIcon(dl, ImVec2((discMin.x + discMax.x) * 0.5f,
                               (discMin.y + discMax.y) * 0.5f),
                    discS * 0.32f, "backpack");

        if (font) {
            const char* hdrLbl = "العناصر";
            float fsHdr = 36 * scale;
            dl->AddText(font, fsHdr,
                ImVec2(discMax.x + 16 * scale, headerY + 1 * scale),
                IM_COL32(122, 245, 182, 255), hdrLbl);

            char slotBuf[64];
            snprintf(slotBuf, sizeof(slotBuf), "الخانات: %d / %d",
                     filledCount, 24);
            float fsSub = 24 * scale;
            dl->AddText(font, fsSub,
                ImVec2(discMax.x + 16 * scale,
                       headerY + 1 * scale + fsHdr + 4 * scale),
                IM_COL32(220, 255, 235, 220), slotBuf);
        }

        // Capacity bar (right side).
        float barW = 260 * scale, barH = 12 * scale;
        ImVec2 barMin(pMax.x - panelPadX - barW, headerY + 30 * scale);
        ImVec2 barMax(barMin.x + barW, barMin.y + barH);
        float br = barH * 0.5f;
        dl->AddRectFilled(barMin, barMax, IM_COL32(8, 30, 20, 220), br);
        dl->AddRect(barMin, barMax, IM_COL32(120, 230, 170, 60), br, 0, 1.0f);
        float pct = (float)filledCount / 24.0f;
        if (pct > 0) {
            ImVec2 fMin = barMin;
            ImVec2 fMax(barMin.x + barW * pct, barMax.y);
            dl->AddRectFilledMultiColor(fMin, fMax,
                IM_COL32(122, 245, 182, 255), IM_COL32( 61, 220, 132, 255),
                IM_COL32( 61, 220, 132, 255), IM_COL32(122, 245, 182, 255));
        }
    }

    // -----------------------------------------------------------------
    // 6 x 4 grid of slot tiles
    // -----------------------------------------------------------------
    float gridX = pMin.x + panelPadX;
    float gridY = headerY + headerH + 6 * scale;

    static bool  s_itemWasDown = false;
    bool         clickEdge = io.MouseDown[0] && !s_itemWasDown;
    int          tappedDlg = -1;
    const char*  tappedCmd = nullptr;
    {
        for (int row = 0; row < kRows; ++row) {
            for (int col = 0; col < kCols; ++col) {
                int idx = row * kCols + col;
                ImVec2 sMin(gridX + col * (tileSide + tileGapX),
                            gridY + row * (tileSide + tileGapY + labelArea));
                ImVec2 sMax(sMin.x + tileSide, sMin.y + tileSide);

                bool empty   = (slots[idx].label == nullptr);
                bool hovered = (io.MousePos.x >= sMin.x &&
                                io.MousePos.x <= sMax.x &&
                                io.MousePos.y >= sMin.y &&
                                io.MousePos.y <= sMax.y &&
                                !empty);

                DrawInvSlot(dl, font, sMin, tileSide, &slots[idx],
                            empty, hovered, scale);

                // Label below tile.
                if (!empty && font && slots[idx].label) {
                    float fs = 32.0f * scale;
                    ImVec2 ts = font->CalcTextSizeA(fs, FLT_MAX, 0.0f,
                                                    slots[idx].label);
                    ImVec2 lp(sMin.x + (tileSide - ts.x) * 0.5f,
                              sMax.y + 4 * scale);
                    dl->AddText(font, fs, ImVec2(lp.x + 1, lp.y + 1),
                                IM_COL32(0, 0, 0, 160),
                                slots[idx].label);
                    dl->AddText(font, fs, lp,
                                IM_COL32(220, 255, 235, 225),
                                slots[idx].label);
                }

                // Click handling — usable item only.
                // Priority 1: if the gamemode dialog is still open, fire a
                // dialog response (legacy path for the medical pouch).
                // Priority 2: send the chat command associated with the
                // slot (works regardless of whether a dialog is active).
                if (clickEdge && hovered && slots[idx].countPtr &&
                    *slots[idx].countPtr > 0)
                {
                    if (slots[idx].dlgIndex > 0 && m_bDialogActive) {
                        tappedDlg = slots[idx].dlgIndex;
                    } else if (slots[idx].useCmd) {
                        tappedCmd = slots[idx].useCmd;
                    }
                }
            }
        }
    }

    if (tappedDlg > 0) {
        char empty[1] = { 0 };
        CarRent_SendDialogResponse(m_iDialogId, 1,
            (uint16_t)tappedDlg, empty);
        m_bDialogActive = false;
        m_bVisible      = false;
        s_itemWasDown   = io.MouseDown[0];
        s_wasDown       = io.MouseDown[0];
        return;
    }
    if (tappedCmd) {
        Inventory_SendChatCommand(tappedCmd);
        m_bVisible    = false;
        s_itemWasDown = io.MouseDown[0];
        s_wasDown     = io.MouseDown[0];
        return;
    }

    s_itemWasDown = io.MouseDown[0];
    s_wasDown     = io.MouseDown[0];

    // -----------------------------------------------------------------
    // Footer — chevron paginators + page dots
    // -----------------------------------------------------------------
    {
        float footerY = pMax.y - panelPadBot - 16 * scale;
        float btnR    = 30 * scale;
        ImVec2 leftC (pMin.x + panelW * 0.5f - 60 * scale, footerY);
        ImVec2 rightC(pMin.x + panelW * 0.5f + 60 * scale, footerY);

        DrawChevronButton(dl, leftC,  btnR, true,  false, scale);
        DrawChevronButton(dl, rightC, btnR, false, false, scale);

        // Page dots (4 dots, 2nd active, matching mockup's pattern).
        float dotsCx = pMin.x + panelW * 0.5f;
        float dotR   = 2.5f * scale;
        ImVec2 dots[4] = {
            ImVec2(dotsCx - 18 * scale, footerY),
            ImVec2(dotsCx -  6 * scale, footerY),
            ImVec2(dotsCx +  8 * scale, footerY),
            ImVec2(dotsCx + 20 * scale, footerY),
        };
        // Inactive dots
        for (int i = 0; i < 4; ++i) {
            if (i == 1) continue;
            dl->AddCircleFilled(dots[i], dotR,
                IM_COL32(220, 255, 235, 80));
        }
        // Active dot — elongated pill
        ImVec2 aMin(dots[1].x - 7 * scale, dots[1].y - 3.5f * scale);
        ImVec2 aMax(dots[1].x + 7 * scale, dots[1].y + 3.5f * scale);
        dl->AddRectFilled(aMin, aMax, IM_COL32(61, 220, 132, 255),
                          3.5f * scale);
    }

    // -----------------------------------------------------------------
    // Eat clicks inside the panel (block touch passthrough to game)
    // -----------------------------------------------------------------
    if (io.MouseDown[0] || io.MouseClicked[0]) {
        ImVec2 mp = io.MousePos;
        bool inside = (mp.x >= pMin.x && mp.x <= pMax.x &&
                       mp.y >= pMin.y && mp.y <= pMax.y);
        (void)inside;
    }
}
