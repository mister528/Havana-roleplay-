#include "../main.h"
#include "inventoryoverlay.h"
#include "gui.h"
#include "skintex.h"
#include "inventorytex.h"
#include "../arabic.h"
#include "../vendor/imgui/imgui.h"
#include "../vendor/imgui/imgui_internal.h"
#include <cstdio>
#include <cstring>
#include <cstdlib>
#include <cmath>
#include <string>

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
    , m_iMusic(0)
    , m_iTheftKey(0)
    , m_iIslandGunpowder(0), m_iIslandIron(0), m_iIslandScrap(0)
    , m_iIslandWood(0), m_iIslandSpring(0)
    , m_iAccMenuSlot(-1)
    , m_iAccCtrlSlot(-1)
    , m_iPage(0)
{
    m_szName[0] = '\0';
    ClearAccessorySlots();
}

void CInventoryOverlay::ClearAccessorySlots()
{
    for (int i = 0; i < kAccMax; ++i) {
        m_accModel[i] = 0;
        m_accUsed [i] = 0;
        m_accName [i][0] = '\0';
    }
}

void CInventoryOverlay::SetAccessorySlot(int slot, int model, int used, const char* name)
{
    if (slot < 0 || slot >= kAccMax) return;
    m_accModel[slot] = model;
    m_accUsed [slot] = used;
    if (name) {
        strncpy(m_accName[slot], name, kAccNameMax - 1);
        m_accName[slot][kAccNameMax - 1] = '\0';
    } else {
        m_accName[slot][0] = '\0';
    }
}

CInventoryOverlay::~CInventoryOverlay() {}

// Bridge to CNetGame::SendDialogResponse (defined in netrpc.cpp).
extern void CarRent_SendDialogResponse(uint16_t id, uint8_t btn, uint16_t listitem, char* input);
// Bridge that sends a chat command (e.g. "/mask") via the network layer.
extern void Inventory_SendChatCommand(const char* cmd);

static std::string InvShapeText(const char* s)
{
    if (!s) return std::string();
    if (!Arabic::ContainsArabic(s)) return std::string(s);
    return Arabic::Shape(s);
}

static ImVec2 InvCalcTextSize(ImFont* font, float size, const std::string& text)
{
    if (!font) return ImGui::CalcTextSize(text.c_str());
    return font->CalcTextSizeA(size, FLT_MAX, 0.0f, text.c_str());
}

static void InvAddText(ImDrawList* dl, ImFont* font, float size, ImVec2 pos,
                       ImU32 col, const char* text)
{
    if (!dl || !text) return;
    std::string shaped = InvShapeText(text);
    if (font) dl->AddText(font, size, pos, col, shaped.c_str());
    else      dl->AddText(pos, col, shaped.c_str());
}

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

    if      (!strcmp(key, "الاسم") || !strcmp(key, "name")) { strncpy(m_szName, value, kNameMax - 1); m_szName[kNameMax - 1] = '\0'; }
    else if (!strcmp(key, "المستوى") || !strcmp(key, "level")) m_iLevel    = atoi(value);
    else if (!strcmp(key, "الوظيفة") || !strcmp(key, "job"))   m_iJob      = atoi(value);
    else if (!strcmp(key, "السكن") || !strcmp(key, "skin"))    m_iSkin     = atoi(value);
    else if (!strcmp(key, "صحة") || !strcmp(key, "health"))    m_iHealth   = atoi(value);
    else if (!strcmp(key, "الجوع") || !strcmp(key, "hunger"))  m_iHunger   = atoi(value);
    else if (!strcmp(key, "الفلوس") || !strcmp(key, "money"))  m_iMoney    = strtoll(value, nullptr, 10);
    else if (!strcmp(key, "البنك") || !strcmp(key, "bank"))    m_iBank     = strtoll(value, nullptr, 10);
    else if (!strcmp(key, "جوال") || !strcmp(key, "phone"))    m_iPhone    = atoi(value);
    else if (!strcmp(key, "مخدرات") || !strcmp(key, "drugs"))  m_iDrugs    = atoi(value);
    else if (!strcmp(key, "مواد") || !strcmp(key, "mats"))     m_iMats     = atoi(value);
    else if (!strcmp(key, "دخان") || !strcmp(key, "cigs"))     m_iCigs     = atoi(value);
    else if (!strcmp(key, "إسعاف") || !strcmp(key, "aidkit"))  m_iAidKit   = atoi(value);
    else if (!strcmp(key, "ضماد") || !strcmp(key, "bandage"))  m_iBandage  = atoi(value);
    else if (!strcmp(key, "schiene"))    m_iSchiene  = atoi(value);
    else if (!strcmp(key, "aspirin"))    m_iAspirin  = atoi(value);
    else if (!strcmp(key, "morphine"))   m_iMorphine = atoi(value);
    else if (!strcmp(key, "adrenalin"))  m_iAdrenalin= atoi(value);
    else if (!strcmp(key, "تصليح") || !strcmp(key, "repairkit")) m_iRepairKit= atoi(value);
    else if (!strcmp(key, "ملاحة") || !strcmp(key, "gps"))       m_iGPS      = atoi(value);
    else if (!strcmp(key, "قناع") || !strcmp(key, "mask"))       m_iMask     = atoi(value);
    else if (!strcmp(key, "حبل") || !strcmp(key, "rope"))        m_iRope     = atoi(value);
    else if (!strcmp(key, "بنزين") || !strcmp(key, "canister"))  m_iCanister = atoi(value);
    else if (!strcmp(key, "بذور") || !strcmp(key, "seed"))       m_iSeed     = atoi(value);
    else if (!strcmp(key, "ذخيرة") || !strcmp(key, "ammo"))      m_iAmmo     = atoi(value);
    else if (!strcmp(key, "أسلحة") || !strcmp(key, "guns"))      m_iGuns     = atoi(value);
    else if (!strcmp(key, "موسيقى") || !strcmp(key, "music"))    m_iMusic    = atoi(value);
    else if (!strcmp(key, "مفتاح سرقة") || !strcmp(key, "theftkey") || !strcmp(key, "u_theft_key")) m_iTheftKey = atoi(value);
    else if (!strcmp(key, "بارود") || !strcmp(key, "gunpowder") || !strcmp(key, "barood")) m_iIslandGunpowder = atoi(value);
    else if (!strcmp(key, "حديد") || !strcmp(key, "iron") || !strcmp(key, "hadeed")) m_iIslandIron = atoi(value);
    else if (!strcmp(key, "خردة") || !strcmp(key, "scrap") || !strcmp(key, "khardah")) m_iIslandScrap = atoi(value);
    else if (!strcmp(key, "خشب") || !strcmp(key, "wood") || !strcmp(key, "khashab")) m_iIslandWood = atoi(value);
    else if (!strcmp(key, "زنبرك") || !strcmp(key, "spring") || !strcmp(key, "zanbarak")) m_iIslandSpring = atoi(value);
}

void CInventoryOverlay::ParsePayload(const char* payload)
{
    // Merge - only fields explicitly present in the payload are overwritten.
    // This lets the server push partial updates (e.g. wallet only) without
    // wiping the items previously parsed from the SAMP "Inventory" dialog.
    if (!payload) return;

    const bool fullPayload = strstr(payload, "aidkit=") && strstr(payload, "theftkey=");
    if (fullPayload)
    {
        m_iPhone = m_iDrugs = m_iMats = m_iCigs = 0;
        m_iAidKit = m_iBandage = m_iSchiene = m_iAspirin = 0;
        m_iMorphine = m_iAdrenalin = m_iRepairKit = 0;
        m_iGPS = m_iMask = m_iRope = m_iCanister = 0;
        m_iSeed = m_iAmmo = m_iGuns = m_iMusic = m_iTheftKey = 0;
    }

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

    // Match the gamemode's inventory dialog — title is currently
    // "{#cBL}حقيبة الأغراض" in Arabic ("Bag of items"). We also keep the
    // legacy English match ("Inventory") for backwards compatibility.
    bool isInv = false;
    for (const char* p = tclean; *p; ++p)
    {
        if ((p[0] == 'I' || p[0] == 'i') && (p[1] == 'n' || p[1] == 'N')
         && (p[2] == 'v' || p[2] == 'V') && (p[3] == 'e' || p[3] == 'E')
         && (p[4] == 'n' || p[4] == 'N') && (p[5] == 't' || p[5] == 'T'))
        { isInv = true; break; }
    }
    // "حقيبة" = 0xD8 0xAD 0xD9 0x82 0xD9 0x8A 0xD8 0xA8 0xD8 0xA9 in UTF-8.
    if (!isInv && strstr(tclean, "\xD8\xAD\xD9\x82\xD9\x8A\xD8\xA8\xD8\xA9"))
        isInv = true;
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
    m_iTheftKey = 0;
    m_iHealth = m_iHunger = 0;

    int iv = 0;
    if (Inv_ExtractIntAfter(clean, "بارود", &iv)) m_iIslandGunpowder = iv;
    if (Inv_ExtractIntAfter(clean, "حديد", &iv))  m_iIslandIron = iv;
    if (Inv_ExtractIntAfter(clean, "خردة", &iv))  m_iIslandScrap = iv;
    if (Inv_ExtractIntAfter(clean, "خشب", &iv))   m_iIslandWood = iv;
    if (Inv_ExtractIntAfter(clean, "زنبرك", &iv)) m_iIslandSpring = iv;

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
    std::string shaped = InvShapeText(txt);
    const char* s = shaped.c_str();
    if (font)
    {
        dl->AddText(font, fSize, ImVec2(pos.x + 1, pos.y + 1), kColShadow, s);
        dl->AddText(font, fSize, pos, col, s);
    }
    else
    {
        dl->AddText(ImVec2(pos.x + 1, pos.y + 1), kColShadow, s);
        dl->AddText(pos, col, s);
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
        InvAddText(dl, font, 16.0f * scale,
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
    if (!strcmp(kind, "إسعاف") || !strcmp(kind, "stetho") || !strcmp(kind, "cross") ||
        !strcmp(kind, "schiene") || !strcmp(kind, "aspirin") || !strcmp(kind, "morphine") ||
        !strcmp(kind, "adrenalin") || !strcmp(kind, "healme") || !strcmp(kind, "aidkit") ||
        !strcmp(kind, "medical") || !strcmp(kind, "ضماد") || !strcmp(kind, "جبيرة") ||
        !strcmp(kind, "أسبرين") || !strcmp(kind, "مورفين") || !strcmp(kind, "أدرينالين"))
    {
        void* tex = nullptr; int tw = 0, th = 0; float tu = 1.0f, tv = 1.0f;
        if (InventoryTex::GetHealme(&tex, &tw, &th, &tu, &tv) && tex)
        {
            dl->AddImage((ImTextureID)tex,
                         ImVec2(c.x - r*1.72f, c.y - r*1.72f),
                         ImVec2(c.x + r*1.72f, c.y + r*1.72f),
                         ImVec2(0.0f, 0.0f), ImVec2(tu, tv),
                         IM_COL32(255, 255, 255, 255));
            return;
        }
    }
    if (!strcmp(kind, "anchor") || !strcmp(kind, "rope") || !strcmp(kind, "حبل"))
    {
        void* tex = nullptr; int tw = 0, th = 0; float tu = 1.0f, tv = 1.0f;
        if (InventoryTex::GetRope(&tex, &tw, &th, &tu, &tv) && tex)
        {
            dl->AddImage((ImTextureID)tex,
                         ImVec2(c.x - r*1.72f, c.y - r*1.72f),
                         ImVec2(c.x + r*1.72f, c.y + r*1.72f),
                         ImVec2(0.0f, 0.0f), ImVec2(tu, tv),
                         IM_COL32(255, 255, 255, 255));
            return;
        }
    }
    if (!strcmp(kind, "تصليح") || !strcmp(kind, "repair") || !strcmp(kind, "repairkit"))
    {
        void* tex = nullptr; int tw = 0, th = 0; float tu = 1.0f, tv = 1.0f;
        if (InventoryTex::GetRepair(&tex, &tw, &th, &tu, &tv) && tex)
        {
            dl->AddImage((ImTextureID)tex,
                         ImVec2(c.x - r*1.72f, c.y - r*1.72f),
                         ImVec2(c.x + r*1.72f, c.y + r*1.72f),
                         ImVec2(0.0f, 0.0f), ImVec2(tu, tv),
                         IM_COL32(255, 255, 255, 255));
            return;
        }
    }

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
        void* tex = nullptr; int tw = 0, th = 0; float tu = 1.0f, tv = 1.0f;
        if (InventoryTex::GetHealme(&tex, &tw, &th, &tu, &tv) && tex)
        {
            dl->AddImage((ImTextureID)tex,
                         ImVec2(c.x - r*1.72f, c.y - r*1.72f),
                         ImVec2(c.x + r*1.72f, c.y + r*1.72f),
                         ImVec2(0.0f, 0.0f), ImVec2(tu, tv),
                         IM_COL32(255, 255, 255, 255));
            return;
        }
        else
        {
            dl->AddCircleFilled(c, r*0.72f, IM_COL32(255, 85, 55, 255), 36);
            dl->AddCircleFilled(c, r*0.42f, IM_COL32(255, 255, 255, 255), 36);
            dl->AddRectFilled(ImVec2(c.x - r*0.10f, c.y - r*0.45f),
                              ImVec2(c.x + r*0.10f, c.y + r*0.45f),
                              IM_COL32(235, 60, 55, 255));
            dl->AddRectFilled(ImVec2(c.x - r*0.45f, c.y - r*0.10f),
                              ImVec2(c.x + r*0.45f, c.y + r*0.10f),
                              IM_COL32(235, 60, 55, 255));
        }
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
        void* tex = nullptr; int tw = 0, th = 0; float tu = 1.0f, tv = 1.0f;
        if (InventoryTex::GetMask(&tex, &tw, &th, &tu, &tv) && tex)
        {
            dl->AddImage((ImTextureID)tex,
                         ImVec2(c.x - r*1.72f, c.y - r*1.72f),
                         ImVec2(c.x + r*1.72f, c.y + r*1.72f),
                         ImVec2(0.0f, 0.0f), ImVec2(tu, tv),
                         IM_COL32(255, 255, 255, 255));
            return;
        }

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
        int         accSlot;   // -1 = not an accessory, 0..7 = accessory slot idx
    };
}


static void DrawPremiumKeyIcon(ImDrawList* dl, ImVec2 c, float r)
{
    void* tex = nullptr; int tw = 0, th = 0; float tu = 1.0f, tv = 1.0f;
    if (InventoryTex::GetCarKey(&tex, &tw, &th, &tu, &tv) && tex) {
        dl->AddImage((ImTextureID)tex,
                     ImVec2(c.x - r*1.72f, c.y - r*1.72f),
                     ImVec2(c.x + r*1.72f, c.y + r*1.72f),
                     ImVec2(0.0f, 0.0f), ImVec2(tu, tv),
                     IM_COL32(255, 255, 255, 255));
        return;
    }
    dl->AddCircleFilled(c, r*1.04f, IM_COL32(6, 8, 12, 255), 48);
    dl->AddCircle(c, r*1.04f, IM_COL32(255, 255, 255, 85), 48, 2.0f);
    dl->AddCircle(c, r*0.86f, IM_COL32(255, 255, 255, 24), 48, 1.0f);
    ImU32 key = IM_COL32(248, 250, 255, 255);
    ImU32 shade = IM_COL32(160, 170, 188, 255);
    ImU32 dark = IM_COL32(10, 12, 18, 255);
    ImVec2 head(c.x - r*0.44f, c.y - r*0.10f);
    dl->AddCircleFilled(ImVec2(head.x + r*0.06f, head.y + r*0.06f), r*0.42f, IM_COL32(0,0,0,110), 40);
    dl->AddCircleFilled(head, r*0.42f, key, 40);
    dl->AddCircleFilled(head, r*0.20f, dark, 32);
    dl->AddCircle(head, r*0.42f, shade, 40, 2.0f);
    float sy = c.y - r*0.10f;
    dl->AddRectFilled(ImVec2(c.x - r*0.06f, sy - r*0.12f),
                      ImVec2(c.x + r*0.76f, sy + r*0.12f), key, r*0.06f);
    dl->AddRectFilled(ImVec2(c.x + r*0.26f, sy + r*0.08f),
                      ImVec2(c.x + r*0.42f, sy + r*0.42f), key, r*0.03f);
    dl->AddRectFilled(ImVec2(c.x + r*0.56f, sy + r*0.08f),
                      ImVec2(c.x + r*0.74f, sy + r*0.34f), key, r*0.03f);
    dl->AddLine(ImVec2(c.x - r*0.05f, sy - r*0.10f),
                ImVec2(c.x + r*0.72f, sy - r*0.10f), IM_COL32(255,255,255,150), 1.2f);
    dl->AddRectFilled(ImVec2(c.x - r*0.88f, c.y + r*0.56f),
                      ImVec2(c.x + r*0.88f, c.y + r*0.84f), IM_COL32(255,255,255,28), r*0.08f);
    dl->AddText(ImVec2(c.x - r*0.34f, c.y + r*0.47f), IM_COL32(255,255,255,210), "CAR");
}

static bool IsHatAccessoryModel(int model)
{
    return (model >= 19067 && model <= 19069) ||
           model == 19554 ||
           model == 18953 || model == 18954 ||
           model == 18968 || model == 18967 || model == 18969 ||
           model == 18955 || model == 18956 || model == 18957 || model == 18959 ||
           (model >= 18926 && model <= 18933) ||
           (model >= 19104 && model <= 19109) ||
           model == 19519 || model == 19274 ||
           (model >= 18921 && model <= 18925) ||
           (model >= 18947 && model <= 18951) ||
           model == 19528 || model == 19094 ||
           model == 18970 || model == 18973 || model == 18972 || model == 18971 ||
           model == 19487 || model == 19352 ||
           (model >= 19064 && model <= 19066);
}

static bool IsHeadphonesAccessoryModel(int model)
{
    return model == 19421 || model == 19422 || model == 19423 || model == 19424;
}

static bool IsChainAccessoryModel(int model)
{
    return model == 341 || model == 1212 || model == 3056 ||
           model == 11733 || model == 2976 || model == 8493 ||
           model == 19878 || model == 1276 || model == 8492 ||
           model == 362 || model == 19632 || model == 7392 ||
           model == 1681;
}

static bool IsBagAccessoryModel(int model)
{
    return model == 3026 || model == 371 || model == 19559 ||
           model == 19054 || model == 19058 || model == 881 ||
           model == 19319 || model == 19318 || model == 19317 ||
           model == 1609 || model == 2406;
}

static void DrawCanvasIconSurface(ImDrawList* dl, ImVec2 c, float r, ImU32 accent)
{
    dl->AddCircleFilled(ImVec2(c.x + r*0.05f, c.y + r*0.08f), r*1.18f,
                        IM_COL32(0, 0, 0, 120), 56);
    dl->AddCircleFilled(c, r*1.13f, IM_COL32(6, 12, 18, 238), 56);
    dl->AddCircleFilled(ImVec2(c.x - r*0.16f, c.y - r*0.18f), r*0.88f,
                        IM_COL32(24, 44, 52, 235), 56);
    dl->AddCircle(c, r*1.13f, accent, 56, 2.2f);
    dl->AddCircle(c, r*0.86f, IM_COL32(255, 255, 255, 30), 56, 1.0f);
    dl->AddLine(ImVec2(c.x - r*0.74f, c.y - r*0.70f),
                ImVec2(c.x + r*0.26f, c.y - r*0.98f),
                IM_COL32(255, 255, 255, 58), 2.0f);
    dl->AddCircleFilled(ImVec2(c.x + r*0.70f, c.y - r*0.72f), r*0.08f,
                        IM_COL32(255, 255, 255, 105), 16);
}

static void DrawNewIcon(ImDrawList* dl, ImVec2 c, float r, const char* kind)
{
    // Icons used by the new grid that don't already exist in DrawItemIcon().
    // Falls back to DrawItemIcon for known kinds.
    ImU32 white = IM_COL32(255,255,255,235);
    if (!strcmp(kind, "car_key")) {
        DrawPremiumKeyIcon(dl, c, r);
    } else if (!strcmp(kind, "stetho")) {
        DrawItemIcon(dl, c, r, "إسعاف");
    } else if (!strcmp(kind, "cross")) {
        DrawCanvasIconSurface(dl, c, r, IM_COL32(255, 255, 255, 210));
        dl->AddRectFilled(ImVec2(c.x - r*0.72f, c.y - r*0.28f), ImVec2(c.x + r*0.72f, c.y + r*0.28f), IM_COL32(248,240,222,255), r*0.22f);
        dl->AddRect(ImVec2(c.x - r*0.72f, c.y - r*0.28f), ImVec2(c.x + r*0.72f, c.y + r*0.28f), IM_COL32(185,155,115,255), r*0.22f, 0, 1.4f);
        dl->AddRectFilled(ImVec2(c.x - r*0.09f, c.y - r*0.18f), ImVec2(c.x + r*0.09f, c.y + r*0.18f), IM_COL32(225,55,55,255));
        dl->AddRectFilled(ImVec2(c.x - r*0.24f, c.y - r*0.07f), ImVec2(c.x + r*0.24f, c.y + r*0.07f), IM_COL32(225,55,55,255));
    } else if (!strcmp(kind, "phone")) {
        DrawCanvasIconSurface(dl, c, r, IM_COL32(110, 205, 255, 230));
        dl->AddRectFilled(ImVec2(c.x - r*0.40f, c.y - r*0.76f), ImVec2(c.x + r*0.40f, c.y + r*0.76f), IM_COL32(16,22,32,255), r*0.16f);
        dl->AddRectFilledMultiColor(ImVec2(c.x - r*0.31f, c.y - r*0.58f), ImVec2(c.x + r*0.31f, c.y + r*0.46f), IM_COL32(95,210,255,255), IM_COL32(70,150,255,255), IM_COL32(40,70,170,255), IM_COL32(70,95,210,255));
        dl->AddCircleFilled(ImVec2(c.x, c.y + r*0.61f), r*0.055f, IM_COL32(235,240,245,255), 16);
    } else if (!strcmp(kind, "music")) {
        void* tex = nullptr; int tw = 0, th = 0; float tu = 1.0f, tv = 1.0f;
        if (InventoryTex::GetMusic(&tex, &tw, &th, &tu, &tv) && tex) {
            dl->AddImage((ImTextureID)tex,
                         ImVec2(c.x - r*1.72f, c.y - r*1.72f),
                         ImVec2(c.x + r*1.72f, c.y + r*1.72f),
                         ImVec2(0.0f, 0.0f), ImVec2(tu, tv),
                         IM_COL32(255, 255, 255, 255));
        } else {
            DrawCanvasIconSurface(dl, c, r, IM_COL32(210, 165, 255, 230));
            dl->AddCircleFilled(ImVec2(c.x - r*0.20f, c.y + r*0.38f), r*0.28f, IM_COL32(255,255,255,245), 28);
            dl->AddRectFilled(ImVec2(c.x + r*0.04f, c.y - r*0.70f), ImVec2(c.x + r*0.22f, c.y + r*0.42f), IM_COL32(255,255,255,245), r*0.03f);
            dl->AddTriangleFilled(ImVec2(c.x + r*0.22f, c.y - r*0.70f), ImVec2(c.x + r*0.72f, c.y - r*0.45f), ImVec2(c.x + r*0.22f, c.y - r*0.22f), IM_COL32(255,255,255,245));
        }
    } else if (!strcmp(kind, "ملاحة") || !strcmp(kind, "gps")) {
        void* tex = nullptr; int tw = 0, th = 0; float tu = 1.0f, tv = 1.0f;
        if (InventoryTex::GetGps(&tex, &tw, &th, &tu, &tv) && tex) {
            dl->AddImage((ImTextureID)tex,
                         ImVec2(c.x - r*1.72f, c.y - r*1.72f),
                         ImVec2(c.x + r*1.72f, c.y + r*1.72f),
                         ImVec2(0.0f, 0.0f), ImVec2(tu, tv),
                         IM_COL32(255, 255, 255, 255));
        } else {
            DrawItemIcon(dl, c, r, kind);
        }
    } else if (!strcmp(kind, "pill")) {
        DrawCanvasIconSurface(dl, c, r, IM_COL32(120, 240, 170, 230));
        dl->AddRectFilled(ImVec2(c.x - r*0.70f, c.y - r*0.28f), ImVec2(c.x + r*0.70f, c.y + r*0.28f), IM_COL32(245,248,252,255), r*0.28f);
        dl->AddRectFilled(ImVec2(c.x, c.y - r*0.28f), ImVec2(c.x + r*0.70f, c.y + r*0.28f), IM_COL32(52,210,110,255), r*0.28f);
        dl->AddLine(ImVec2(c.x, c.y-r*0.26f), ImVec2(c.x, c.y+r*0.26f), IM_COL32(20,40,40,120), 1.6f);
    } else if (!strcmp(kind, "anchor")) {
        DrawCanvasIconSurface(dl, c, r, IM_COL32(255, 190, 95, 230));
        dl->AddCircle(ImVec2(c.x, c.y - r*0.58f), r*0.22f, IM_COL32(255,255,255,245), 24, 3.2f);
        dl->AddRectFilled(ImVec2(c.x - r*0.055f, c.y - r*0.38f), ImVec2(c.x + r*0.055f, c.y + r*0.55f), IM_COL32(255,255,255,245));
        dl->AddLine(ImVec2(c.x - r*0.55f, c.y + r*0.48f), ImVec2(c.x + r*0.55f, c.y + r*0.48f), IM_COL32(255,255,255,245), 3.2f);
        dl->AddLine(ImVec2(c.x - r*0.55f, c.y + r*0.48f), ImVec2(c.x - r*0.30f, c.y + r*0.76f), IM_COL32(255,255,255,245), 3.2f);
        dl->AddLine(ImVec2(c.x + r*0.55f, c.y + r*0.48f), ImVec2(c.x + r*0.30f, c.y + r*0.76f), IM_COL32(255,255,255,245), 3.2f);
    } else if (!strcmp(kind, "ghost")) {
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
        ImU32 top = IM_COL32(52, 84, 72, 255);
        ImU32 bot = IM_COL32(20, 40, 34, 255);
        ImU32 seam = IM_COL32(118, 240, 172, 210);
        ImU32 trim = IM_COL32(8, 18, 16, 255);
        ImU32 metal = IM_COL32(230, 246, 238, 255);
        dl->AddRectFilled(ImVec2(c.x - r*0.86f, c.y - r*0.44f),
                          ImVec2(c.x + r*0.90f, c.y + r*0.88f),
                          IM_COL32(0,0,0,95), r*0.22f);
        ImVec2 bodyMin(c.x - r*0.82f, c.y - r*0.42f);
        ImVec2 bodyMax(c.x + r*0.82f, c.y + r*0.82f);
        dl->AddRectFilledMultiColor(bodyMin, bodyMax, top, top, bot, bot);
        dl->AddRect(bodyMin, bodyMax, seam, r*0.22f, 0, 2.0f);
        dl->AddRect(ImVec2(c.x - r*0.34f, c.y - r*0.86f),
                    ImVec2(c.x + r*0.34f, c.y - r*0.38f),
                    seam, r*0.16f, 0, 3.0f);
        dl->AddRectFilled(ImVec2(c.x - r*0.90f, c.y - r*0.06f),
                          ImVec2(c.x + r*0.90f, c.y + r*0.12f), trim, r*0.06f);
        dl->AddRectFilled(ImVec2(c.x - r*0.70f, c.y + r*0.20f),
                          ImVec2(c.x + r*0.70f, c.y + r*0.74f),
                          IM_COL32(15, 32, 28, 190), r*0.14f);
        dl->AddRect(ImVec2(c.x - r*0.70f, c.y + r*0.20f),
                    ImVec2(c.x + r*0.70f, c.y + r*0.74f), seam, r*0.14f, 0, 1.3f);
        dl->AddRectFilled(ImVec2(c.x - r*0.10f, c.y - r*0.13f),
                          ImVec2(c.x + r*0.10f, c.y + r*0.22f), metal, r*0.04f);
        dl->AddCircleFilled(ImVec2(c.x, c.y + r*0.38f), r*0.10f, metal, 18);
        dl->AddLine(ImVec2(c.x - r*0.64f, c.y - r*0.30f),
                    ImVec2(c.x + r*0.64f, c.y - r*0.30f), IM_COL32(255,255,255,80), 1.4f);
    } else if (!strcmp(kind, "music")) {
        // Music note: stem + filled note-head + flag. Bright, visible shape.
        // Stem
        dl->AddRectFilled(ImVec2(c.x + r*0.05f, c.y - r*0.90f),
                          ImVec2(c.x + r*0.25f, c.y + r*0.40f), white);
        // Flag
        dl->AddTriangleFilled(
            ImVec2(c.x + r*0.25f, c.y - r*0.90f),
            ImVec2(c.x + r*0.85f, c.y - r*0.55f),
            ImVec2(c.x + r*0.25f, c.y - r*0.35f), white);
        // Note head (ellipse approximation using a circle)
        dl->AddCircleFilled(ImVec2(c.x - r*0.15f, c.y + r*0.45f),
                            r*0.38f, white);
    } else if (!strcmp(kind, "shield")) {
        dl->AddTriangleFilled(ImVec2(c.x - r*0.75f, c.y - r*0.55f),
                              ImVec2(c.x + r*0.75f, c.y - r*0.55f),
                              ImVec2(c.x,           c.y + r*0.85f), white);
        dl->AddRectFilled(ImVec2(c.x - r*0.75f, c.y - r*0.85f),
                          ImVec2(c.x + r*0.75f, c.y - r*0.55f), white);
    } else if (!strcmp(kind, "hat")) {
        void* tex = nullptr; int tw = 0, th = 0; float tu = 1.0f, tv = 1.0f;
        if (InventoryTex::GetHat(&tex, &tw, &th, &tu, &tv) && tex) {
            dl->AddImage((ImTextureID)tex,
                         ImVec2(c.x - r*1.72f, c.y - r*1.72f),
                         ImVec2(c.x + r*1.72f, c.y + r*1.72f),
                         ImVec2(0.0f, 0.0f), ImVec2(tu, tv),
                         IM_COL32(255, 255, 255, 255));
            return;
        }
        DrawNewIcon(dl, c, r, "accessory");
    } else if (!strcmp(kind, "headphones")) {
        void* tex = nullptr; int tw = 0, th = 0; float tu = 1.0f, tv = 1.0f;
        if (InventoryTex::GetHeadphones(&tex, &tw, &th, &tu, &tv) && tex) {
            dl->AddImage((ImTextureID)tex,
                         ImVec2(c.x - r*1.72f, c.y - r*1.72f),
                         ImVec2(c.x + r*1.72f, c.y + r*1.72f),
                         ImVec2(0.0f, 0.0f), ImVec2(tu, tv),
                         IM_COL32(255, 255, 255, 255));
            return;
        }
        DrawNewIcon(dl, c, r, "accessory");
    } else if (!strcmp(kind, "chain")) {
        void* tex = nullptr; int tw = 0, th = 0; float tu = 1.0f, tv = 1.0f;
        if (InventoryTex::GetChain(&tex, &tw, &th, &tu, &tv) && tex) {
            dl->AddImage((ImTextureID)tex,
                         ImVec2(c.x - r*1.72f, c.y - r*1.72f),
                         ImVec2(c.x + r*1.72f, c.y + r*1.72f),
                         ImVec2(0.0f, 0.0f), ImVec2(tu, tv),
                         IM_COL32(255, 255, 255, 255));
            return;
        }
        DrawNewIcon(dl, c, r, "accessory");
    } else if (!strcmp(kind, "bag")) {
        void* tex = nullptr; int tw = 0, th = 0; float tu = 1.0f, tv = 1.0f;
        if (InventoryTex::GetBackpack(&tex, &tw, &th, &tu, &tv) && tex) {
            dl->AddImage((ImTextureID)tex,
                         ImVec2(c.x - r*1.72f, c.y - r*1.72f),
                         ImVec2(c.x + r*1.72f, c.y + r*1.72f),
                         ImVec2(0.0f, 0.0f), ImVec2(tu, tv),
                         IM_COL32(255, 255, 255, 255));
            return;
        }
        DrawNewIcon(dl, c, r, "accessory");
    } else if (!strcmp(kind, "island_gunpowder")) {
        void* tex = nullptr; int tw = 0, th = 0; float tu = 1.0f, tv = 1.0f;
        if (InventoryTex::GetIslandGunpowder(&tex, &tw, &th, &tu, &tv) && tex) {
            dl->AddImage((ImTextureID)tex, ImVec2(c.x - r*1.72f, c.y - r*1.72f), ImVec2(c.x + r*1.72f, c.y + r*1.72f), ImVec2(0,0), ImVec2(tu,tv), IM_COL32(255,255,255,255));
            return;
        }
        DrawNewIcon(dl, c, r, "flame");
    } else if (!strcmp(kind, "island_iron")) {
        void* tex = nullptr; int tw = 0, th = 0; float tu = 1.0f, tv = 1.0f;
        if (InventoryTex::GetIslandIron(&tex, &tw, &th, &tu, &tv) && tex) {
            dl->AddImage((ImTextureID)tex, ImVec2(c.x - r*1.72f, c.y - r*1.72f), ImVec2(c.x + r*1.72f, c.y + r*1.72f), ImVec2(0,0), ImVec2(tu,tv), IM_COL32(255,255,255,255));
            return;
        }
        DrawNewIcon(dl, c, r, "hammer");
    } else if (!strcmp(kind, "island_scrap")) {
        void* tex = nullptr; int tw = 0, th = 0; float tu = 1.0f, tv = 1.0f;
        if (InventoryTex::GetIslandScrap(&tex, &tw, &th, &tu, &tv) && tex) {
            dl->AddImage((ImTextureID)tex, ImVec2(c.x - r*1.72f, c.y - r*1.72f), ImVec2(c.x + r*1.72f, c.y + r*1.72f), ImVec2(0,0), ImVec2(tu,tv), IM_COL32(255,255,255,255));
            return;
        }
        DrawNewIcon(dl, c, r, "sparkles");
    } else if (!strcmp(kind, "island_wood")) {
        void* tex = nullptr; int tw = 0, th = 0; float tu = 1.0f, tv = 1.0f;
        if (InventoryTex::GetIslandWood(&tex, &tw, &th, &tu, &tv) && tex) {
            dl->AddImage((ImTextureID)tex, ImVec2(c.x - r*1.72f, c.y - r*1.72f), ImVec2(c.x + r*1.72f, c.y + r*1.72f), ImVec2(0,0), ImVec2(tu,tv), IM_COL32(255,255,255,255));
            return;
        }
        DrawNewIcon(dl, c, r, "anchor");
    } else if (!strcmp(kind, "island_spring")) {
        void* tex = nullptr; int tw = 0, th = 0; float tu = 1.0f, tv = 1.0f;
        if (InventoryTex::GetIslandSpring(&tex, &tw, &th, &tu, &tv) && tex) {
            dl->AddImage((ImTextureID)tex, ImVec2(c.x - r*1.72f, c.y - r*1.72f), ImVec2(c.x + r*1.72f, c.y + r*1.72f), ImVec2(0,0), ImVec2(tu,tv), IM_COL32(255,255,255,255));
            return;
        }
        DrawNewIcon(dl, c, r, "wand");
    } else if (!strcmp(kind, "accessory")) {
        void* tex = nullptr; int tw = 0, th = 0; float tu = 1.0f, tv = 1.0f;
        if (InventoryTex::GetAccessory(&tex, &tw, &th, &tu, &tv) && tex) {
            dl->AddImage((ImTextureID)tex,
                         ImVec2(c.x - r*1.72f, c.y - r*1.72f),
                         ImVec2(c.x + r*1.72f, c.y + r*1.72f),
                         ImVec2(0.0f, 0.0f), ImVec2(tu, tv),
                         IM_COL32(255, 255, 255, 255));
            return;
        }
        ImU32 gold = IM_COL32(255, 218, 118, 255);
        ImU32 goldD = IM_COL32(138, 92, 34, 255);
        ImU32 gemA = IM_COL32(150, 230, 255, 255);
        ImU32 gemB = IM_COL32(92, 80, 230, 255);
        dl->AddCircleFilled(c, r*0.92f, IM_COL32(10, 12, 22, 210), 40);
        dl->AddCircle(c, r*0.86f, goldD, 40, 3.0f);
        dl->AddCircle(c, r*0.66f, gold, 40, 2.0f);
        for (int i = 0; i < 5; ++i) {
            float a = -1.5708f + i * 1.2566f;
            dl->AddCircleFilled(ImVec2(c.x + cosf(a)*r*0.86f, c.y + sinf(a)*r*0.86f),
                                r*0.09f, gold, 16);
        }
        ImVec2 p0(c.x, c.y - r*0.64f);
        ImVec2 p1(c.x + r*0.55f, c.y - r*0.04f);
        ImVec2 p2(c.x, c.y + r*0.64f);
        ImVec2 p3(c.x - r*0.55f, c.y - r*0.04f);
        dl->AddQuadFilled(p0, p1, p2, p3, gemB);
        dl->AddTriangleFilled(p0, p1, ImVec2(c.x, c.y), gemA);
        dl->AddTriangleFilled(p0, p3, ImVec2(c.x, c.y), IM_COL32(230, 255, 255, 225));
        dl->AddLine(p0, p2, IM_COL32(255,255,255,170), 1.2f);
        dl->AddLine(p3, p1, IM_COL32(255,255,255,130), 1.2f);
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

    ImVec2 c((pMin.x + pMax.x) * 0.5f, (pMin.y + pMax.y) * 0.5f);
    float r = side * 0.30f;
    dl->AddCircleFilled(ImVec2(c.x + side*0.018f, c.y + side*0.025f), r*1.32f, IM_COL32(0,0,0,72), 64);
    dl->AddCircleFilled(c, r*1.25f, IM_COL32(5, 11, 17, 126), 64);
    dl->AddCircle(c, r*1.25f, IM_COL32(255,255,255,42), 64, 1.2f * scale);
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

    // Count — raised above the image so it stays readable.
    if (font && slot->countPtr) {
        char buf[16];
        snprintf(buf, sizeof(buf), "%d", *slot->countPtr);
        float fs = 28.0f * scale;
        ImVec2 ts = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, buf);
        ImVec2 pad(8 * scale, 3 * scale);
        ImVec2 pillMax(pMax.x - 6 * scale, pMin.y + ts.y + pad.y * 2.0f - 2 * scale);
        ImVec2 pillMin(pillMax.x - ts.x - pad.x * 2.0f, pMin.y - 8 * scale);
        dl->AddRectFilled(ImVec2(pillMin.x + 2 * scale, pillMin.y + 2 * scale),
                          ImVec2(pillMax.x + 2 * scale, pillMax.y + 2 * scale),
                          IM_COL32(0, 0, 0, 135), 9 * scale);
        dl->AddRectFilledMultiColor(pillMin, pillMax,
            IM_COL32(20, 28, 34, 245), IM_COL32(35, 45, 52, 245),
            IM_COL32(5, 10, 14, 245),  IM_COL32(12, 18, 24, 245));
        dl->AddRect(pillMin, pillMax, IM_COL32(255, 255, 255, 115),
                    9 * scale, 0, 1.1f * scale);
        ImVec2 tp(pillMin.x + pad.x, pillMin.y + pad.y - 1 * scale);
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
    // Control pad lives independently of the bag — when the player
    // hit "تحكم", we hide the main bag panel but keep drawing the
    // small floating control pad so they can move the accessory
    // while seeing their character on screen.
    if (!m_bVisible) {
        if (m_iAccCtrlSlot >= 0) {
            ImGuiIO& io0 = ImGui::GetIO();
            float s0 = io0.DisplaySize.y / 1080.0f;
            if (s0 < 0.35f) s0 = 0.35f;
            RenderAccessoryControlPad(io0.DisplaySize.x, io0.DisplaySize.y, s0);
        }
        return;
    }

    using namespace InvGrid;

    ImGuiIO& io = ImGui::GetIO();

    // Animate in with a smooth cubic slide from the bottom.
    if (m_fAnimT < 1.0f)
    {
        m_fAnimT += io.DeltaTime / 0.34f;
        if (m_fAnimT > 1.0f) m_fAnimT = 1.0f;
    }
    float ease = 1.0f - powf(1.0f - m_fAnimT, 3.0f);
    float popEase = 1.0f - (1.0f - ease) * (1.0f - ease);

    // Scale relative to a 1080-tall canvas, but the new panel is much
    // narrower than the old wide HUD (mockup is ~720px wide on 1080p).
    float scale = io.DisplaySize.y / 1080.0f;

    // Slot tile size is the principal driver of layout.
    const int kCols = 6;
    const int kRows = 4;
    float tileSide = 152.0f * scale;
    float tileGapX = 26.0f * scale;
    float tileGapY = 30.0f * scale;

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
    panelY += (1.0f - ease) * (io.DisplaySize.y * 0.22f);

    ImDrawList* dl = ImGui::GetOverlayDrawList();

    // -----------------------------------------------------------------
    // Backdrop (radial gradient + modal dim) — matches the mockup's
    // "radial-gradient(ellipse at 20% 20%, #0e3b27, #061b13, #02100a)".
    // -----------------------------------------------------------------
    {
        // Plain dim first.
        dl->AddRectFilled(ImVec2(0, 0), io.DisplaySize,
                          IM_COL32(0, 0, 0, (int)(150 * ease)));

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
    float popScale = 0.94f + 0.06f * popEase;
    panelW *= popScale;
    panelH *= popScale;
    tileSide *= popScale; tileGapX *= popScale; tileGapY *= popScale;
    panelPadX *= popScale; panelPadTop *= popScale; panelPadBot *= popScale;
    headerH *= popScale; footerH *= popScale; gridW *= popScale; gridH *= popScale;
    labelArea *= popScale; scale *= popScale;
    panelX = (io.DisplaySize.x - panelW) * 0.5f;

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
        std::string tabShaped = InvShapeText(tabText);
        ImVec2 ts = font ? font->CalcTextSizeA(fsTab, FLT_MAX, 0.0f, tabShaped.c_str())
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
        // Bag icon
        DrawNewIcon(dl, ImVec2(tMin.x + 32 * scale,
                               (tMin.y + tMax.y) * 0.5f),
                    17 * scale, "backpack");
        // Label
        if (font) {
            ImVec2 tp(tMin.x + 32 * scale + shieldW + 16 * scale,
                      (tMin.y + tMax.y) * 0.5f - ts.y * 0.5f);
            dl->AddText(font, fsTab, ImVec2(tp.x + 1, tp.y + 1),
                        IM_COL32(255, 255, 255, 90), tabShaped.c_str());
            dl->AddText(font, fsTab, tp, IM_COL32(10, 42, 29, 255), tabShaped.c_str());
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
    static const int kSlotsPerPage = 24;
    static const int kMaxSlots = 32;
    Slot allSlots[kMaxSlots];
    Slot slots[kSlotsPerPage];
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
        Tpl tpl[25] = {
            // Row 1 — medical
            {"إسعاف",      "healme",    &m_iAidKit,    nullptr,  COL_RED,    1, "/healme"},
            {"ضماد",        "healme",    &m_iBandage,   nullptr,  COL_WHITE,  2, "/healme"},
            {"جبيرة",       "healme",    &m_iSchiene,   nullptr,  COL_ORANGE, 3, "/healme"},
            {"أسبرين",      "healme",    &m_iAspirin,   nullptr,  COL_WHITE,  4, "/healme"},
            {"مورفين",      "healme",    &m_iMorphine,  nullptr,  COL_BLUE,   5, "/healme"},
            {"أدرينالين",   "healme",    &m_iAdrenalin, nullptr,  COL_YELLOW, 6, "/healme"},
            // Row 2 — wallet & resources
            {"جوال",        "phone",     &m_iPhone,     nullptr,  COL_WHITE,  -1, "/phone"},
            {"موسيقى",     "music",     &m_iMusic,     nullptr,  COL_PURPLE, -1, "/music"},
            {"مواد",        "مواد",      &m_iMats,      nullptr,  COL_ORANGE, -1, nullptr},
            {"مخدرات",      "pill",      &m_iDrugs,     nullptr,  COL_GREEN,  7, "/usedrugs"},
            {"سجائر",       "دخان",      &m_iCigs,      nullptr,  COL_YELLOW, -1, nullptr},
            {"عدة تصليح",   "تصليح",     &m_iRepairKit, nullptr,  COL_WHITE,  -1, "/repairkit"},
            {"ملاحة",       "ملاحة",      &m_iGPS,       "GPS",    COL_PURPLE, -1, "/gps"},
            // Row 3 — tools & combat
            {"قناع",         "قناع",       &m_iMask,      nullptr,  COL_WHITE,  -1, "/mask"},
            {"حبل",          "anchor",    &m_iRope,      nullptr,  COL_ORANGE, -1, nullptr},
            {"مفتاح سرقة",   "car_key",   &m_iTheftKey,  "CAR",    COL_BLUE,   -1, "/stealcar"},
            {"بنزين",        "بنزين",     &m_iCanister,  nullptr,  COL_RED,    -1, "/usecan"},
            {"بذور",         "بذور",      &m_iSeed,      nullptr,  COL_GREEN,  -1, nullptr},
            {"ذخيرة",        "ذخيرة",      &m_iAmmo,      nullptr,  COL_YELLOW, -1, nullptr},
            {"أسلحة",        "أسلحة",      &m_iGuns,      nullptr,  COL_WHITE,  -1, nullptr},
            {"بارود",       "island_gunpowder", &m_iIslandGunpowder, nullptr, COL_ORANGE, -1, nullptr},
            {"حديد",        "island_iron",      &m_iIslandIron,      nullptr, COL_WHITE,  -1, nullptr},
            {"خردة",        "island_scrap",     &m_iIslandScrap,     nullptr, COL_BLUE,   -1, nullptr},
            {"خشب",         "island_wood",      &m_iIslandWood,      nullptr, COL_GREEN,  -1, nullptr},
            {"زنبرك",       "island_spring",    &m_iIslandSpring,    nullptr, COL_PURPLE, -1, nullptr},
        };
        // Only show items the player actually owns (count > 0). Empty
        // slots fill the rest of the 24-cell grid so the layout stays tidy.
        for (int i = 0; i < 25; ++i) {
            int qty = (tpl[i].countPtr) ? *tpl[i].countPtr : 0;
            if (qty <= 0) continue;
            int dst = filledCount++;
            if (dst >= kMaxSlots) break;
            allSlots[dst].label    = tpl[i].label;
            allSlots[dst].iconKind = tpl[i].iconKind;
            allSlots[dst].countPtr = tpl[i].countPtr;
            allSlots[dst].badge    = tpl[i].badge;
            allSlots[dst].color    = tpl[i].color;
            allSlots[dst].dlgIndex = tpl[i].dlgIndex;
            allSlots[dst].useCmd   = tpl[i].useCmd;
            allSlots[dst].accSlot  = -1;
        }
        // Append owned accessories after regular items. Each accessory
        // tile shows its Arabic name and a tap sends /ac_use <slot> (or
        // /ac_off <slot> if already equipped) so the server toggles
        // attachment state and re-saves the row.
        static char s_accCmdBuf[kAccMax][16];
        static char s_accLbl  [kAccMax][kAccNameMax + 8];
        for (int a = 0; a < kAccMax; ++a) {
            if (m_accModel[a] == 0)       continue;
            if (filledCount >= kMaxSlots)  break;
            int dst = filledCount++;
            const char* name = m_accName[a][0] ? m_accName[a] : "إكسسوار";
            if (m_accUsed[a]) {
                snprintf(s_accLbl[a],   sizeof(s_accLbl[a]),   "%s ✓", name);
                snprintf(s_accCmdBuf[a], sizeof(s_accCmdBuf[a]), "/ac_off %d", a);
            } else {
                snprintf(s_accLbl[a],   sizeof(s_accLbl[a]),   "%s", name);
                snprintf(s_accCmdBuf[a], sizeof(s_accCmdBuf[a]), "/ac_use %d", a);
            }
            allSlots[dst].label    = s_accLbl[a];
            allSlots[dst].iconKind = IsHatAccessoryModel(m_accModel[a]) ? "hat" : (IsHeadphonesAccessoryModel(m_accModel[a]) ? "headphones" : (IsChainAccessoryModel(m_accModel[a]) ? "chain" : (IsBagAccessoryModel(m_accModel[a]) ? "bag" : "accessory")));
            allSlots[dst].countPtr = nullptr;
            allSlots[dst].badge    = m_accUsed[a] ? "ON" : nullptr;
            allSlots[dst].color    = m_accUsed[a] ? COL_GREEN : COL_PURPLE;
            allSlots[dst].dlgIndex = -1;
            allSlots[dst].useCmd   = s_accCmdBuf[a];
            allSlots[dst].accSlot  = a;
        }

        int totalPages = (filledCount + kSlotsPerPage - 1) / kSlotsPerPage;
        if (totalPages < 1) totalPages = 1;
        if (m_iPage >= totalPages) m_iPage = totalPages - 1;
        if (m_iPage < 0) m_iPage = 0;
        int pageStart = m_iPage * kSlotsPerPage;
        for (int i = 0; i < kSlotsPerPage; ++i) {
            int src = pageStart + i;
            if (src < filledCount) {
                slots[i] = allSlots[src];
            } else {
                slots[i].label = nullptr; slots[i].iconKind = nullptr;
                slots[i].countPtr = nullptr; slots[i].badge = nullptr;
                slots[i].color = COL_WHITE; slots[i].dlgIndex = -1;
                slots[i].useCmd = nullptr; slots[i].accSlot = -1;
            }
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
            InvAddText(dl, font, fsHdr,
                ImVec2(discMax.x + 16 * scale, headerY + 1 * scale),
                IM_COL32(122, 245, 182, 255), hdrLbl);

            char slotBuf[64];
            snprintf(slotBuf, sizeof(slotBuf), "الخانات: %d / %d",
                     filledCount, kMaxSlots);
            float fsSub = 24 * scale;
            InvAddText(dl, font, fsSub,
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
        float pct = (float)filledCount / (float)kMaxSlots;
        if (pct > 1.0f) pct = 1.0f;
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
    // While the accessory popup is open we disable grid clicks — popup
    // owns the pointer until the player picks an option.
    bool         popupOpen = (m_iAccMenuSlot >= 0);
    bool         clickEdge = io.MouseDown[0] && !s_itemWasDown && !popupOpen;
    int          tappedDlg = -1;
    const char*  tappedCmd = nullptr;
    int          tappedAccSlot = -1;
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
                    std::string slotLabel = InvShapeText(slots[idx].label);
                    ImVec2 ts = font->CalcTextSizeA(fs, FLT_MAX, 0.0f,
                                                    slotLabel.c_str());
                    ImVec2 lp(sMin.x + (tileSide - ts.x) * 0.5f,
                              sMax.y + 4 * scale);
                    dl->AddText(font, fs, ImVec2(lp.x + 1, lp.y + 1),
                                IM_COL32(0, 0, 0, 160),
                                slotLabel.c_str());
                    dl->AddText(font, fs, lp,
                                IM_COL32(220, 255, 235, 225),
                                slotLabel.c_str());
                }

                // Click handling — accessories open a modal menu,
                // everything else keeps the legacy behaviour.
                if (clickEdge && hovered) {
                    if (slots[idx].accSlot >= 0) {
                        tappedAccSlot = slots[idx].accSlot;
                    } else if (slots[idx].countPtr &&
                               *slots[idx].countPtr > 0) {
                        if (slots[idx].dlgIndex > 0 && m_bDialogActive) {
                            tappedDlg = slots[idx].dlgIndex;
                        } else if (slots[idx].useCmd) {
                            tappedCmd = slots[idx].useCmd;
                        }
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
    if (tappedAccSlot >= 0) {
        m_iAccMenuSlot = tappedAccSlot;
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
        int totalPages = (filledCount + kSlotsPerPage - 1) / kSlotsPerPage;
        if (totalPages < 1) totalPages = 1;
        bool canPrev = (m_iPage > 0);
        bool canNext = (m_iPage + 1 < totalPages);

        DrawChevronButton(dl, leftC,  btnR, true,  canPrev, scale);
        DrawChevronButton(dl, rightC, btnR, false, canNext, scale);

        if (clickEdge) {
            float hit = btnR * 1.4f;
            bool hitPrev = io.MousePos.x >= leftC.x - hit && io.MousePos.x <= leftC.x + hit &&
                           io.MousePos.y >= leftC.y - hit && io.MousePos.y <= leftC.y + hit;
            bool hitNext = io.MousePos.x >= rightC.x - hit && io.MousePos.x <= rightC.x + hit &&
                           io.MousePos.y >= rightC.y - hit && io.MousePos.y <= rightC.y + hit;
            if (hitPrev && canPrev) m_iPage--;
            if (hitNext && canNext) m_iPage++;
        }

        // Page dots.
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
            if (i == m_iPage) continue;
            dl->AddCircleFilled(dots[i], dotR,
                IM_COL32(220, 255, 235, 80));
        }
        // Active dot — elongated pill
        int dotIndex = m_iPage;
        if (dotIndex < 0) dotIndex = 0;
        if (dotIndex > 3) dotIndex = 3;
        ImVec2 aMin(dots[dotIndex].x - 7 * scale, dots[dotIndex].y - 3.5f * scale);
        ImVec2 aMax(dots[dotIndex].x + 7 * scale, dots[dotIndex].y + 3.5f * scale);
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

    // -----------------------------------------------------------------
    // Accessory action popup — rendered on top of the grid when the
    // player has just tapped an accessory tile.
    // -----------------------------------------------------------------
    if (m_iAccMenuSlot >= 0) {
        RenderAccessoryPopup(io.DisplaySize.x, io.DisplaySize.y, scale);
    }
}

// =====================================================================
// Accessory popup (تفعيل / تعطيل / تحكم / رمي / إلغاء)
// =====================================================================
void CInventoryOverlay::RenderAccessoryPopup(float scrW, float scrH, float scale)
{
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    if (!dl) return;
    ImGuiIO& io = ImGui::GetIO();
    ImFont* font = ImGui::GetFont();

    int slot = m_iAccMenuSlot;
    if (slot < 0 || slot >= kAccMax) { m_iAccMenuSlot = -1; return; }

    static int   s_animSlot = -1;
    static float s_popupAnim = 0.0f;
    if (s_animSlot != slot) { s_animSlot = slot; s_popupAnim = 0.0f; }
    if (s_popupAnim < 1.0f) {
        s_popupAnim += io.DeltaTime / 0.24f;
        if (s_popupAnim > 1.0f) s_popupAnim = 1.0f;
    }
    float pe = 1.0f - powf(1.0f - s_popupAnim, 3.0f);

    // Card dimensions — large touch-friendly modal.
    float cardW = 920.0f * scale;
    float cardH = 820.0f * scale;
    if (cardW > scrW * 0.92f) cardW = scrW * 0.92f;
    if (cardH > scrH * 0.94f) cardH = scrH * 0.94f;
    float popScale = 0.92f + 0.08f * pe;
    cardW *= popScale;
    cardH *= popScale;
    scale *= popScale;
    float cardX = (scrW - cardW) * 0.5f;
    float cardY = (scrH - cardH) * 0.5f + (1.0f - pe) * 90.0f * scale;
    ImVec2 cMin(cardX, cardY);
    ImVec2 cMax(cardX + cardW, cardY + cardH);

    // Full-screen dim behind the card.
    dl->AddRectFilled(ImVec2(0, 0), ImVec2(scrW, scrH),
                      IM_COL32(4, 5, 10, (int)(218 * pe)));

    // Card body — layered drop shadow + double border for depth.
    float cr = 32.0f * scale;
    for (int s = 0; s < 8; ++s)
    {
        float off = (s + 1) * 2.2f * scale;
        int a = 28 - s * 3; if (a < 0) a = 0;
        dl->AddRectFilled(ImVec2(cMin.x - off, cMin.y - off),
                          ImVec2(cMax.x + off, cMax.y + off),
                          IM_COL32(0, 0, 0, a), cr + off);
    }
    dl->AddRectFilledMultiColor(cMin, cMax,
        IM_COL32(24, 24, 38, 252), IM_COL32(34, 30, 48, 252),
        IM_COL32(12, 14, 24, 252), IM_COL32(10, 12, 20, 252));
    dl->AddRect(cMin, cMax, IM_COL32(150, 120, 210, 185), cr, 0, 2.2f * scale);
    dl->AddRect(ImVec2(cMin.x + 4 * scale, cMin.y + 4 * scale),
                ImVec2(cMax.x - 4 * scale, cMax.y - 4 * scale),
                IM_COL32(255, 255, 255, 26), cr * 0.92f, 0, 1.0f * scale);

    // Close button (X) top-right.
    {
        float bs = 60 * scale;
        float bx = cMax.x - bs - 22 * scale;
        float by = cMin.y + 22 * scale;
        ImVec2 bMin(bx, by), bMax(bx + bs, by + bs);
        bool hov = (io.MousePos.x >= bMin.x && io.MousePos.x <= bMax.x &&
                    io.MousePos.y >= bMin.y && io.MousePos.y <= bMax.y);
        ImU32 c0 = hov ? IM_COL32(220,  90, 110, 240) : IM_COL32(90, 30, 50, 230);
        ImU32 c1 = hov ? IM_COL32(190,  60,  85, 240) : IM_COL32(60, 18, 36, 230);
        dl->AddRectFilledMultiColor(bMin, bMax, c0, c0, c1, c1);
        dl->AddRect(bMin, bMax, IM_COL32(255,255,255,90), bs * 0.5f, 0, 1.4f * scale);
        // X glyph
        float cx = bx + bs * 0.5f, cy = by + bs * 0.5f;
        float o  = bs * 0.24f;
        dl->AddLine(ImVec2(cx - o, cy - o), ImVec2(cx + o, cy + o),
                    IM_COL32(255, 235, 235, 255), 3.4f * scale);
        dl->AddLine(ImVec2(cx + o, cy - o), ImVec2(cx - o, cy + o),
                    IM_COL32(255, 235, 235, 255), 3.4f * scale);
        static bool s_xdown = false;
        bool edgeX = io.MouseDown[0] && !s_xdown;
        if (hov && edgeX) {
            m_iAccMenuSlot = -1;
            s_xdown = io.MouseDown[0];
            return;
        }
        s_xdown = io.MouseDown[0];
    }

    // ========== TOP HEADER BANNER ==========
    // A bold, full-width gradient strip behind the title. This creates a
    // clear "premium card header" that is visually unmistakable.
    float bannerH = 200 * scale;
    {
        ImVec2 hMin(cMin.x + 6 * scale, cMin.y + 6 * scale);
        ImVec2 hMax(cMax.x - 6 * scale, cMin.y + bannerH);
        dl->AddRectFilledMultiColor(hMin, hMax,
            IM_COL32( 50,  36,  96, 255),
            IM_COL32(118,  70, 155, 255),
            IM_COL32( 50,  36,  96, 255),
            IM_COL32( 32,  24,  72, 255));
        dl->AddRectFilledMultiColor(
            ImVec2(hMin.x, hMax.y - 4 * scale),
            ImVec2(hMax.x, hMax.y),
            IM_COL32(225, 190, 120, 230), IM_COL32(190, 125, 210, 230),
            IM_COL32(190, 125, 210, 230), IM_COL32(225, 190, 120, 230));
    }

    // ========== LARGE DIAMOND GEM IN THE BANNER ==========
    // Big, bold and clearly visible — sits on the left side of the
    // header with the title centered next to it.
    {
        float mx = cMin.x + 120 * scale;
        float my = cMin.y + bannerH * 0.5f + 6 * scale;
        float ms = 64 * scale;
        // gem body (two halves for a faceted look)
        ImVec2 p0(mx,        my - ms);
        ImVec2 p1(mx + ms,   my);
        ImVec2 p2(mx,        my + ms);
        ImVec2 p3(mx - ms,   my);
        dl->AddTriangleFilled(p1, p2, p3, IM_COL32(120,  60, 200, 255));
        dl->AddTriangleFilled(p0, p1, p3, IM_COL32(230, 170, 255, 255));
        // inner facet highlight
        dl->AddTriangleFilled(p0, p1, ImVec2(mx, my),
                              IM_COL32(255, 255, 255, 200));
        dl->AddTriangleFilled(p0, p3, ImVec2(mx, my),
                              IM_COL32(255, 240, 255, 130));
        // thick golden outline
        ImVec2 path[4] = { p0, p1, p2, p3 };
        for (int i = 0; i < 4; ++i)
            dl->AddLine(path[i], path[(i + 1) & 3],
                        IM_COL32(255, 220, 140, 255), 3.0f * scale);
    }

    // ========== TITLE + ITEM NAME (in the banner, to the right of gem) ==========
    if (font) {
        const char* title = "إكسسوار";
        float fsT = 60.0f * scale;
        std::string titleShaped = InvShapeText(title);
        ImVec2 ts = font->CalcTextSizeA(fsT, FLT_MAX, 0.0f, titleShaped.c_str());
        float tx = cMin.x + (cardW - ts.x) * 0.5f;
        float ty = cMin.y + 30 * scale;
        // soft text shadow
        dl->AddText(font, fsT, ImVec2(tx + 2 * scale, ty + 3 * scale),
                    IM_COL32(0, 0, 0, 180), titleShaped.c_str());
        dl->AddText(font, fsT, ImVec2(tx, ty),
                    IM_COL32(255, 250, 255, 255), titleShaped.c_str());

        const char* name = (m_accName[slot][0]) ? m_accName[slot] : "—";
        float fsN = 42.0f * scale;
        std::string nameShaped = InvShapeText(name);
        ImVec2 ns = font->CalcTextSizeA(fsN, FLT_MAX, 0.0f, nameShaped.c_str());
        float nx = cMin.x + (cardW - ns.x) * 0.5f;
        float ny = ty + fsT + 12 * scale;
        dl->AddText(font, fsN, ImVec2(nx + 1 * scale, ny + 1 * scale),
                    IM_COL32(0, 0, 0, 130), nameShaped.c_str());
        dl->AddText(font, fsN, ImVec2(nx, ny),
                    IM_COL32(255, 215, 240, 255), nameShaped.c_str());
    }

    // Buttons — stacked vertically with icons, gradients and glow.
    struct Btn {
        const char* label; int id;
        ImU32 col0, col1; // gradient
        ImU32 colHi0, colHi1;
        ImU32 glow;
        int icon; // 0=power, 1=joystick, 2=trash, 3=cancel
    };
    const bool isOn = (m_accUsed[slot] != 0);
    Btn btns[4] = {
        { isOn ? "تعطيل" : "تفعيل", 1,
          isOn ? IM_COL32(220,  78,  78, 245) : IM_COL32( 70, 200, 130, 245),
          isOn ? IM_COL32(160,  40,  50, 245) : IM_COL32( 30, 150,  90, 245),
          isOn ? IM_COL32(255, 120, 120, 255) : IM_COL32(110, 230, 160, 255),
          isOn ? IM_COL32(180,  60,  70, 255) : IM_COL32( 50, 180, 110, 255),
          isOn ? IM_COL32(220,  60,  60, 110) : IM_COL32( 70, 200, 130, 110), 0 },
        { "تحكم",  2,
          IM_COL32(140, 100, 240, 245), IM_COL32( 80,  50, 180, 245),
          IM_COL32(180, 140, 255, 255), IM_COL32(110,  70, 220, 255),
          IM_COL32(140, 100, 240, 110), 1 },
        { "رمي",   3,
          IM_COL32(135, 100, 130, 230), IM_COL32( 80,  60,  85, 230),
          IM_COL32(170, 135, 165, 255), IM_COL32(110,  85, 110, 255),
          IM_COL32(135, 100, 130,  80), 2 },
        { "إلغاء", 4,
          IM_COL32( 70,  62,  90, 230), IM_COL32( 36,  30,  52, 230),
          IM_COL32(110,  98, 130, 255), IM_COL32( 60,  52,  82, 255),
          IM_COL32( 70,  62,  90,  60), 3 },
    };

    float btnH   = 120 * scale;
    float btnW   = cardW - 110 * scale;
    float btnX   = cMin.x + (cardW - btnW) * 0.5f;
    float btnY0  = cMin.y + bannerH + 40 * scale;
    float btnGap = 22 * scale;
    float br     = 22 * scale;            // rounded rectangle, not a pill

    static bool s_down = false;
    bool edge = io.MouseDown[0] && !s_down;
    int clickedId = 0;

    for (int i = 0; i < 4; ++i) {
        ImVec2 bMin(btnX, btnY0 + i * (btnH + btnGap));
        ImVec2 bMax(bMin.x + btnW, bMin.y + btnH);
        bool hov = (io.MousePos.x >= bMin.x && io.MousePos.x <= bMax.x &&
                    io.MousePos.y >= bMin.y && io.MousePos.y <= bMax.y);

        // Soft drop shadow
        dl->AddRectFilled(
            ImVec2(bMin.x + 3 * scale, bMin.y + 8 * scale),
            ImVec2(bMax.x + 3 * scale, bMax.y + 8 * scale),
            IM_COL32(0, 0, 0, 130), br);

        // Outer glow on hover.
        if (hov) {
            for (int g = 0; g < 6; ++g) {
                float o = (g + 1) * 2.5f * scale;
                int a = 50 - g * 8; if (a < 0) a = 0;
                ImU32 base = btns[i].glow;
                ImU32 ag   = (base & 0x00FFFFFF) | ((unsigned)a << 24);
                dl->AddRectFilled(
                    ImVec2(bMin.x - o, bMin.y - o),
                    ImVec2(bMax.x + o, bMax.y + o),
                    ag, br + o);
            }
        }

        // Body — vertical gradient
        ImU32 c0 = hov ? btns[i].colHi0 : btns[i].col0;
        ImU32 c1 = hov ? btns[i].colHi1 : btns[i].col1;
        dl->AddRectFilledMultiColor(bMin, bMax, c0, c0, c1, c1);

        // Bold border (double-stroke for premium feel)
        dl->AddRect(bMin, bMax, IM_COL32(255, 255, 255, 130), br, 0, 2.0f * scale);
        dl->AddRect(ImVec2(bMin.x + 4 * scale, bMin.y + 4 * scale),
                    ImVec2(bMax.x - 4 * scale, bMax.y - 4 * scale),
                    IM_COL32(255, 255, 255,  35), br * 0.85f, 0, 1.0f * scale);

        // ===== LEFT ICON PANEL =====
        // A clearly visible darker square panel on the left side that
        // contains the icon. The panel is the width of the button height
        // so it forms a perfect square aligned to the rounded body.
        float panelW = btnH;
        ImVec2 pMin = bMin;
        ImVec2 pMax(bMin.x + panelW, bMax.y);
        // dark translucent backing
        dl->AddRectFilled(pMin, pMax, IM_COL32(0, 0, 0, 110), br);
        // a thin vertical separator between panel and label area
        dl->AddLine(ImVec2(pMax.x, bMin.y + 14 * scale),
                    ImVec2(pMax.x, bMax.y - 14 * scale),
                    IM_COL32(255, 255, 255, 90), 1.4f * scale);

        // Icon glyph centered in the panel
        float icCx = pMin.x + panelW * 0.5f;
        float icCy = pMin.y + btnH * 0.5f;
        float icR  = btnH * 0.32f;
        ImU32 icCol = IM_COL32(255, 255, 255, 255);
        float lw = 3.5f * scale;
        switch (btns[i].icon)
        {
            case 0: { // power glyph (circle gap + vertical bar)
                dl->PathArcTo(ImVec2(icCx, icCy), icR * 0.62f, 1.0f, 5.28f, 24);
                dl->PathStroke(icCol, false, lw);
                dl->AddLine(ImVec2(icCx, icCy - icR * 0.85f),
                            ImVec2(icCx, icCy - icR * 0.10f),
                            icCol, lw);
                break;
            }
            case 1: { // joystick: stick + base + ball
                dl->AddRectFilled(
                    ImVec2(icCx - icR * 0.55f, icCy + icR * 0.20f),
                    ImVec2(icCx + icR * 0.55f, icCy + icR * 0.55f),
                    icCol, icR * 0.18f);
                dl->AddRectFilled(
                    ImVec2(icCx - icR * 0.10f, icCy - icR * 0.40f),
                    ImVec2(icCx + icR * 0.10f, icCy + icR * 0.20f),
                    icCol);
                dl->AddCircleFilled(ImVec2(icCx, icCy - icR * 0.55f),
                                    icR * 0.28f, icCol, 24);
                break;
            }
            case 2: { // trash can: lid + body
                dl->AddRectFilled(
                    ImVec2(icCx - icR * 0.65f, icCy - icR * 0.55f),
                    ImVec2(icCx + icR * 0.65f, icCy - icR * 0.30f),
                    icCol, icR * 0.10f);
                dl->AddRectFilled(
                    ImVec2(icCx - icR * 0.20f, icCy - icR * 0.75f),
                    ImVec2(icCx + icR * 0.20f, icCy - icR * 0.55f),
                    icCol);
                dl->AddRect(
                    ImVec2(icCx - icR * 0.50f, icCy - icR * 0.30f),
                    ImVec2(icCx + icR * 0.50f, icCy + icR * 0.70f),
                    icCol, icR * 0.10f, 0, lw);
                for (int k = -1; k <= 1; ++k)
                    dl->AddLine(
                        ImVec2(icCx + k * icR * 0.22f, icCy - icR * 0.10f),
                        ImVec2(icCx + k * icR * 0.22f, icCy + icR * 0.50f),
                        icCol, lw * 0.85f);
                break;
            }
            case 3: { // X (cancel)
                float o2 = icR * 0.55f;
                dl->AddLine(ImVec2(icCx - o2, icCy - o2),
                            ImVec2(icCx + o2, icCy + o2), icCol, lw);
                dl->AddLine(ImVec2(icCx + o2, icCy - o2),
                            ImVec2(icCx - o2, icCy + o2), icCol, lw);
                break;
            }
        }

        if (font) {
            float fs = 52 * scale;
            std::string btnLabel = InvShapeText(btns[i].label);
            ImVec2 ts = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, btnLabel.c_str());
            // Label centered in the area to the right of the icon panel.
            float labelLeft = pMax.x;
            float labelW    = bMax.x - labelLeft;
            float lx = labelLeft + (labelW - ts.x) * 0.5f;
            float ly = bMin.y + (btnH - fs) * 0.5f - 4 * scale;
            // shadow
            dl->AddText(font, fs,
                ImVec2(lx + 2 * scale, ly + 2 * scale),
                IM_COL32(0, 0, 0, 140), btnLabel.c_str());
            dl->AddText(font, fs,
                ImVec2(lx, ly),
                IM_COL32(255,255,255,255), btnLabel.c_str());
        }

        if (edge && hov) clickedId = btns[i].id;
    }
    s_down = io.MouseDown[0];

    if (clickedId == 1) {
        char cmd[16];
        snprintf(cmd, sizeof(cmd), isOn ? "/ac_off %d" : "/ac_use %d", slot);
        Inventory_SendChatCommand(cmd);
        // Flip local state so the UI is responsive; server will re-sync.
        m_accUsed[slot] = isOn ? 0 : 1;
        m_iAccMenuSlot  = -1;
    } else if (clickedId == 2) {
        // Open control pad. If not equipped, equip first.
        if (!isOn) {
            char cmd[16];
            snprintf(cmd, sizeof(cmd), "/ac_use %d", slot);
            Inventory_SendChatCommand(cmd);
            m_accUsed[slot] = 1;
        }
        m_iAccCtrlSlot = slot;
        m_iAccMenuSlot = -1;
        m_bVisible     = false;   // hide bag so player sees the world
    } else if (clickedId == 3) {
        char cmd[16];
        snprintf(cmd, sizeof(cmd), "/ac_drop %d", slot);
        Inventory_SendChatCommand(cmd);
        m_accModel[slot] = 0;
        m_accUsed [slot] = 0;
        m_iAccMenuSlot   = -1;
    } else if (clickedId == 4) {
        m_iAccMenuSlot = -1;
    }
}

// =====================================================================
// Accessory control pad — floating on the right side of the screen.
// Six directional buttons (up/down/forward/back/bigger/smaller) plus a
// close button. While visible the main bag is hidden so the player can
// see their character update live.
// =====================================================================
void CInventoryOverlay::RenderAccessoryControlPad(float scrW, float scrH, float scale)
{
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    if (!dl) return;
    ImGuiIO& io = ImGui::GetIO();
    ImFont* font = ImGui::GetFont();

    int slot = m_iAccCtrlSlot;
    if (slot < 0 || slot >= kAccMax) { m_iAccCtrlSlot = -1; return; }

    // Pad anchored right, vertically centered. Large touch targets.
    float padW = 540.0f * scale;
    float padH = 780.0f * scale;
    if (padW > scrW * 0.45f) padW = scrW * 0.45f;
    if (padH > scrH * 0.96f) padH = scrH * 0.96f;
    float padX = scrW - padW - 28.0f * scale;
    float padY = (scrH - padH) * 0.5f;
    ImVec2 pMin(padX, padY);
    ImVec2 pMax(padX + padW, padY + padH);

    // Background — deep glass with purple accent + outer glow.
    float cr = 24.0f * scale;
    for (int s = 0; s < 7; ++s) {
        float off = (s + 1) * 2.0f * scale;
        int a = 22 - s * 2; if (a < 0) a = 0;
        dl->AddRectFilled(ImVec2(pMin.x - off, pMin.y - off),
                          ImVec2(pMax.x + off, pMax.y + off),
                          IM_COL32(140, 90, 220, a), cr + off);
    }
    dl->AddRectFilledMultiColor(pMin, pMax,
        IM_COL32(46, 32, 78, 248), IM_COL32(64, 40, 100, 248),
        IM_COL32(22, 18, 42, 248), IM_COL32(18, 14, 32, 248));
    // Top highlight strip.
    dl->AddRectFilledMultiColor(
        ImVec2(pMin.x, pMin.y),
        ImVec2(pMax.x, pMin.y + 120 * scale),
        IM_COL32(255, 200, 255, 30), IM_COL32(255, 200, 255, 30),
        IM_COL32(255, 200, 255,  0), IM_COL32(255, 200, 255,  0));
    dl->AddRect(pMin, pMax, IM_COL32(190, 140, 255, 180), cr, 0, 2.0f * scale);
    // Accent divider under the title.
    dl->AddRectFilledMultiColor(
        ImVec2(pMin.x + 30 * scale, pMin.y + 118 * scale),
        ImVec2(pMax.x - 30 * scale, pMin.y + 122 * scale),
        IM_COL32(255, 170, 120, 180), IM_COL32(220, 100, 220, 220),
        IM_COL32(220, 100, 220, 220), IM_COL32(255, 170, 120, 180));

    // Title + subtitle
    if (font) {
        const char* title = "تحكم الإكسسوار";
        float fsT = 46 * scale;
        std::string titleShaped = InvShapeText(title);
        ImVec2 ts = font->CalcTextSizeA(fsT, FLT_MAX, 0.0f, titleShaped.c_str());
        dl->AddText(font, fsT,
            ImVec2(pMin.x + (padW - ts.x) * 0.5f, pMin.y + 24 * scale),
            IM_COL32(255, 200, 250, 255), titleShaped.c_str());

        const char* name = (m_accName[slot][0]) ? m_accName[slot] : "—";
        float fsN = 32 * scale;
        std::string nameShaped = InvShapeText(name);
        ImVec2 ns = font->CalcTextSizeA(fsN, FLT_MAX, 0.0f, nameShaped.c_str());
        dl->AddText(font, fsN,
            ImVec2(pMin.x + (padW - ns.x) * 0.5f,
                   pMin.y + 24 * scale + fsT + 6 * scale),
            IM_COL32(220, 210, 245, 220), nameShaped.c_str());
    }

    // 4x2 grid of directional / scale / rotation buttons + reset + close.
    //   Row 1: رفع / نزول       (Y axis)
    //   Row 2: أمام / خلف       (X axis)
    //   Row 3: تكبير / تصغير    (scale)
    //   Row 4: دوران / تصفير    (rotate / reset)
    //   Row 5: إغلاق
    struct B { const char* label; const char* cmd; ImU32 col; ImU32 colHi; int kind; bool canRepeat; };
    B btns[10] = {
        // kind: 0 = arrow-up, 1 = arrow-down, 2 = arrow-right, 3 = arrow-left,
        //       4 = plus, 5 = minus, 6 = rotate, 7 = reset,
        //       8 = double-arrow-right (big-step forward),
        //       9 = double-arrow-left  (big-step back)
        { "رفع",        "/ac_up",  IM_COL32( 88, 130, 220, 230), IM_COL32(130, 170, 255, 255), 0, true  },
        { "نزول",       "/ac_dn",  IM_COL32( 88, 130, 220, 230), IM_COL32(130, 170, 255, 255), 1, true  },
        { "أمام",       "/ac_fw",  IM_COL32(108,  86, 200, 235), IM_COL32(160, 130, 255, 255), 2, true  },
        { "خلف",        "/ac_bk",  IM_COL32(108,  86, 200, 235), IM_COL32(160, 130, 255, 255), 3, true  },
        { "إلى الأمام", "/ac_bfw", IM_COL32(165,  90, 210, 235), IM_COL32(210, 140, 255, 255), 8, true  },
        { "إلى الخلف",  "/ac_bbk", IM_COL32(165,  90, 210, 235), IM_COL32(210, 140, 255, 255), 9, true  },
        { "تكبير",      "/ac_big", IM_COL32( 61, 160, 110, 230), IM_COL32( 90, 200, 140, 255), 4, true  },
        { "تصغير",      "/ac_sml", IM_COL32(160,  95,  95, 230), IM_COL32(210, 130, 130, 255), 5, true  },
        { "دوران",      "/ac_rot", IM_COL32(190, 130,  70, 230), IM_COL32(230, 170, 100, 255), 6, true  },
        { "تصفير",      "/ac_rst", IM_COL32( 90,  90, 110, 230), IM_COL32(130, 130, 150, 255), 7, false },
    };

    float btnW = (padW - 70 * scale) * 0.5f;
    float btnH = 66 * scale;
    float gx   = pMin.x + 25 * scale;
    float gy   = pMin.y + 140 * scale;
    float gap  = 14 * scale;

    static bool s_down = false;
    bool edge = io.MouseDown[0] && !s_down;
    // Allow repeat: every 140ms while held.
    static double s_lastFire = 0.0;
    double now = ImGui::GetTime();
    bool repeat = io.MouseDown[0] && (now - s_lastFire) > 0.14;

    for (int i = 0; i < 10; ++i) {
        int row = i / 2, col = i % 2;
        ImVec2 bMin(gx + col * (btnW + gap),
                    gy + row * (btnH + gap));
        ImVec2 bMax(bMin.x + btnW, bMin.y + btnH);
        bool hov = (io.MousePos.x >= bMin.x && io.MousePos.x <= bMax.x &&
                    io.MousePos.y >= bMin.y && io.MousePos.y <= bMax.y);
        ImU32 col0 = hov ? btns[i].colHi : btns[i].col;
        dl->AddRectFilled(bMin, bMax, col0, btnH * 0.3f);
        dl->AddRect(bMin, bMax, IM_COL32(255,255,255,70), btnH * 0.3f, 0, 1.2f * scale);

        // Icon on the left-hand side of the button.
        float iconCx = bMin.x + 36 * scale;
        float iconCy = bMin.y + btnH * 0.5f;
        float iconR  = 16 * scale;
        ImU32 iconCol = IM_COL32(255, 255, 255, 240);
        float lw = 3.0f * scale;
        switch (btns[i].kind) {
            case 0: // arrow up
                dl->AddTriangleFilled(
                    ImVec2(iconCx,           iconCy - iconR),
                    ImVec2(iconCx - iconR,   iconCy + iconR * 0.6f),
                    ImVec2(iconCx + iconR,   iconCy + iconR * 0.6f),
                    iconCol);
                break;
            case 1: // arrow down
                dl->AddTriangleFilled(
                    ImVec2(iconCx,           iconCy + iconR),
                    ImVec2(iconCx - iconR,   iconCy - iconR * 0.6f),
                    ImVec2(iconCx + iconR,   iconCy - iconR * 0.6f),
                    iconCol);
                break;
            case 2: // arrow right (forward)
                dl->AddTriangleFilled(
                    ImVec2(iconCx + iconR,   iconCy),
                    ImVec2(iconCx - iconR * 0.6f, iconCy - iconR),
                    ImVec2(iconCx - iconR * 0.6f, iconCy + iconR),
                    iconCol);
                break;
            case 3: // arrow left (back)
                dl->AddTriangleFilled(
                    ImVec2(iconCx - iconR,   iconCy),
                    ImVec2(iconCx + iconR * 0.6f, iconCy - iconR),
                    ImVec2(iconCx + iconR * 0.6f, iconCy + iconR),
                    iconCol);
                break;
            case 4: // plus
                dl->AddLine(ImVec2(iconCx - iconR, iconCy), ImVec2(iconCx + iconR, iconCy), iconCol, lw);
                dl->AddLine(ImVec2(iconCx, iconCy - iconR), ImVec2(iconCx, iconCy + iconR), iconCol, lw);
                break;
            case 5: // minus
                dl->AddLine(ImVec2(iconCx - iconR, iconCy), ImVec2(iconCx + iconR, iconCy), iconCol, lw);
                break;
            case 6: // rotate (circular arrow)
                dl->PathArcTo(ImVec2(iconCx, iconCy), iconR, 0.7f, 5.6f, 20);
                dl->PathStroke(iconCol, false, lw);
                dl->AddTriangleFilled(
                    ImVec2(iconCx + iconR - 1*scale, iconCy - iconR*0.4f),
                    ImVec2(iconCx + iconR + 7*scale, iconCy),
                    ImVec2(iconCx + iconR - 1*scale, iconCy + iconR*0.4f),
                    iconCol);
                break;
            case 7: // reset (circle)
                dl->AddCircle(ImVec2(iconCx, iconCy), iconR, iconCol, 16, lw);
                dl->AddLine(ImVec2(iconCx, iconCy - iconR),
                            ImVec2(iconCx, iconCy - iconR * 0.3f),
                            iconCol, lw);
                break;
            case 8: // double arrow right (big forward)
                dl->AddTriangleFilled(
                    ImVec2(iconCx + iconR * 0.2f,  iconCy),
                    ImVec2(iconCx - iconR,         iconCy - iconR),
                    ImVec2(iconCx - iconR,         iconCy + iconR),
                    iconCol);
                dl->AddTriangleFilled(
                    ImVec2(iconCx + iconR * 1.2f,  iconCy),
                    ImVec2(iconCx,                 iconCy - iconR),
                    ImVec2(iconCx,                 iconCy + iconR),
                    iconCol);
                break;
            case 9: // double arrow left (big back)
                dl->AddTriangleFilled(
                    ImVec2(iconCx - iconR * 0.2f,  iconCy),
                    ImVec2(iconCx + iconR,         iconCy - iconR),
                    ImVec2(iconCx + iconR,         iconCy + iconR),
                    iconCol);
                dl->AddTriangleFilled(
                    ImVec2(iconCx - iconR * 1.2f,  iconCy),
                    ImVec2(iconCx,                 iconCy - iconR),
                    ImVec2(iconCx,                 iconCy + iconR),
                    iconCol);
                break;
        }

        if (font) {
            float fs = 36 * scale;
            std::string btnLabel = InvShapeText(btns[i].label);
            ImVec2 ts = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, btnLabel.c_str());
            // Label centered in the remaining space to the right of the icon.
            float tx = bMin.x + iconR * 2 + 36 * scale;
            float tw = (bMax.x - tx) - 16 * scale;
            dl->AddText(font, fs,
                ImVec2(tx + (tw - ts.x) * 0.5f,
                       bMin.y + (btnH - fs) * 0.5f),
                IM_COL32(255,255,255,255), btnLabel.c_str());
        }
        bool fire = btns[i].canRepeat ? (edge || repeat) : edge;
        if (hov && fire) {
            char cmd[32];
            snprintf(cmd, sizeof(cmd), "%s %d", btns[i].cmd, slot);
            Inventory_SendChatCommand(cmd);
            s_lastFire = now;
        }
    }

    // Close row
    float closeY = gy + 5 * (btnH + gap) + 10 * scale;
    ImVec2 bMin(gx, closeY);
    ImVec2 bMax(gx + padW - 50 * scale, closeY + btnH);
    bool hov = (io.MousePos.x >= bMin.x && io.MousePos.x <= bMax.x &&
                io.MousePos.y >= bMin.y && io.MousePos.y <= bMax.y);
    ImU32 col0 = hov ? IM_COL32(200,80,80,255) : IM_COL32(160, 60, 60, 235);
    dl->AddRectFilled(bMin, bMax, col0, btnH * 0.3f);
    dl->AddRect(bMin, bMax, IM_COL32(255,255,255,80), btnH * 0.3f, 0, 1.2f * scale);
    if (font) {
        const char* lbl = "إغلاق";
        float fs = 40 * scale;
        ImVec2 ts = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, lbl);
        dl->AddText(font, fs,
            ImVec2(bMin.x + ((padW - 50 * scale) - ts.x) * 0.5f,
                   bMin.y + (btnH - fs) * 0.5f),
            IM_COL32(255,255,255,255), lbl);
    }
    if (hov && edge) {
        m_iAccCtrlSlot = -1;
    }

    s_down = io.MouseDown[0];
}
