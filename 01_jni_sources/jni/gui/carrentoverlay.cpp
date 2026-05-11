#include "../main.h"
#include "carrentoverlay.h"
#include "gui.h"
#include "../vendor/imgui/imgui.h"
#include "../vendor/imgui/imgui_internal.h"
#include <cstdio>
#include <cstring>
#include <cstdlib>
#include "../arabic.h"
#include <string>

// Forward declaration to avoid pulling the whole netgame.h header chain in.
// SendDialogResponse is a public method of CNetGame; we only need to call it.
class CNetGame;
extern CNetGame* pNetGame;

// Function pointer to member - we call it via a thin helper defined later.
void CarRent_SendDialogResponse(uint16_t id, uint8_t btn, uint16_t listitem, char* input);

CCarRentOverlay* pCarRentOverlay = nullptr;
extern CGUI* pGUI;

static std::string CrShape(const char* s)
{
    if (!s) return std::string();
    if (!Arabic::ContainsArabic(s)) return std::string(s);
    return Arabic::Shape(s);
}

// HavanaRp polished palette - glass/gradient, no hard borders
static const ImU32 kC_Bg         = IM_COL32(14,  28,  22, 240);
static const ImU32 kC_BgInner    = IM_COL32(20,  36,  28, 250);
static const ImU32 kC_Border     = IM_COL32(60, 255, 120, 210);
static const ImU32 kC_BorderDim  = IM_COL32(60, 255, 120,  70);
static const ImU32 kC_Accent     = IM_COL32( 0, 245, 160, 255);
static const ImU32 kC_Green      = IM_COL32(60, 255, 120, 255);
static const ImU32 kC_GreenDeep  = IM_COL32(17, 156,  69, 255);
static const ImU32 kC_Text       = IM_COL32(255,255,255, 255);
static const ImU32 kC_TextDim    = IM_COL32(220,220,220, 210);
static const ImU32 kC_TextMuted  = IM_COL32(180,200,190, 180);
static const ImU32 kC_CardTop    = IM_COL32(30, 58, 44, 240);
static const ImU32 kC_CardBot    = IM_COL32(12, 26, 20, 248);
static const ImU32 kC_CardHovT   = IM_COL32(56,130, 94, 248);
static const ImU32 kC_CardHovB   = IM_COL32(24, 66, 48, 250);
static const ImU32 kC_Card       = IM_COL32(22, 42, 32,  240);
static const ImU32 kC_CardHover  = IM_COL32(34, 72, 54,  250);
static const ImU32 kC_PriceBg    = IM_COL32( 0, 210, 140, 220);
static const ImU32 kC_Danger     = IM_COL32(255, 90,  90, 240);
static const ImU32 kC_Shadow     = IM_COL32(  0,   0,  0, 160);
static const ImU32 kC_HiLine     = IM_COL32(255, 255, 255,  40);

// Strip SAMP color codes ({RRGGBB} and {RRGGBBAA}) and common
// whitespace padding. Writes into out (<= len).
static void StripColors(const char* in, char* out, size_t len)
{
    size_t j = 0;
    for (size_t i = 0; in[i] && j + 1 < len; ++i)
    {
        if (in[i] == '{')
        {
            // skip until '}' or end
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
                i = k; // skip color
                continue;
            }
        }
        out[j++] = in[i];
    }
    out[j] = '\0';
}

// Extract first integer value present in string (after any '$'). Returns 0 if none.
static int ParseFirstInt(const char* s)
{
    while (*s && (*s == ' ' || *s == '\t' || *s == '$')) s++;
    int sign = 1;
    if (*s == '-') { sign = -1; s++; }
    int v = 0;
    bool has = false;
    while (*s >= '0' && *s <= '9') { v = v*10 + (*s - '0'); s++; has = true; }
    return has ? sign * v : 0;
}

static bool StartsWith(const char* s, const char* prefix)
{
    size_t n = strlen(prefix);
    return strncmp(s, prefix, n) == 0;
}

// Reverse UTF-8 code points in a string (for right-to-left visual rendering
// when the underlying ImGui renderer only draws left-to-right). ASCII letters
// pass through but runs get reversed as well, so callers should pass pure
// Arabic strings only. Output buffer must differ from input.
static void ReverseUtf8(const char* in, char* out, size_t outSize)
{
    if (!in || !out || outSize == 0) return;
    size_t len = strlen(in);
    // First, mark code point boundaries.
    // positions[i] is the start index of code point i.
    static const int kMaxCp = 256;
    int starts[kMaxCp + 1];
    int count = 0;
    for (size_t i = 0; i < len && count < kMaxCp; )
    {
        starts[count++] = (int)i;
        unsigned char c = (unsigned char)in[i];
        int bytes = 1;
        if ((c & 0x80) == 0)      bytes = 1;
        else if ((c & 0xE0) == 0xC0) bytes = 2;
        else if ((c & 0xF0) == 0xE0) bytes = 3;
        else if ((c & 0xF8) == 0xF0) bytes = 4;
        i += bytes;
    }
    starts[count] = (int)len;

    // Append code points in reverse order.
    size_t oi = 0;
    for (int i = count - 1; i >= 0 && oi < outSize - 1; --i)
    {
        int s = starts[i], e = starts[i + 1];
        int sz = e - s;
        if (oi + (size_t)sz >= outSize) break;
        memcpy(out + oi, in + s, sz);
        oi += sz;
    }
    out[oi] = '\0';
}

// Helper that reverses and returns a static buffer pointer usable in a single
// draw call. Not thread-safe but the GUI thread is single-threaded.
static const char* AR(const char* s)
{
    static char bufs[8][512];
    static int  idx = 0;
    char* b = bufs[idx]; idx = (idx + 1) & 7;
    ReverseUtf8(s, b, 512);
    return b;
}

CCarRentOverlay::CCarRentOverlay()
    : m_state(CARRENT_NONE)
    , m_dialogId(0)
    , m_fAnimT(0.0f)
    , m_fScroll(0.0f)
    , m_fScrollVelocity(0.0f)
    , m_hoverIdx(-1)
    , m_bDragging(false)
    , m_fDragStartY(0.0f)
    , m_fDragStartScroll(0.0f)
    , m_fLastTouchY(0.0f)
    , m_bMovedSinceDown(false)
    , m_fDownY(0.0f)
    , m_fDownX(0.0f)
{
}

CCarRentOverlay::~CCarRentOverlay() {}

void CCarRentOverlay::Hide()
{
    m_state = CARRENT_NONE;
    m_items.clear();
    m_confirmBody.clear();
}

void CCarRentOverlay::ParseItems(const char* body, bool hasHeader)
{
    m_items.clear();
    if (!body) return;

    char clean[4096];
    StripColors(body, clean, sizeof(clean));

    // Split by '\n'
    const char* p = clean;
    bool firstLine = true;
    while (*p)
    {
        const char* eol = strchr(p, '\n');
        size_t lineLen = eol ? (size_t)(eol - p) : strlen(p);
        if (lineLen > 0 && lineLen < 255)
        {
            char line[256];
            memcpy(line, p, lineLen);
            line[lineLen] = '\0';

            if (firstLine && hasHeader)
            {
                firstLine = false;
            }
            else
            {
                firstLine = false;
                // Split on tab
                char* tab = strchr(line, '\t');
                CarRentItem item;
                item.priceInt = 0;
                if (tab)
                {
                    *tab = '\0';
                    item.label     = line;
                    item.priceText = tab + 1;
                    item.priceInt  = ParseFirstInt(tab + 1);
                }
                else
                {
                    item.label     = line;
                    item.priceText = "";
                }
                if (!item.label.empty())
                    m_items.push_back(item);
            }
        }
        if (!eol) break;
        p = eol + 1;
    }
}

void CCarRentOverlay::SetState(ECarRentState s, uint16_t dialogId,
                               const char* title, const char* body)
{
    m_state    = s;
    m_dialogId = dialogId;
    m_fAnimT   = 0.0f;
    m_fScroll  = 0.0f;
    m_hoverIdx = -1;

    char tclean[256];
    StripColors(title ? title : "", tclean, sizeof(tclean));
    m_title = tclean;

    if (s == CARRENT_CARS)
    {
        m_subtitle = CrShape("اختر مركبتك");
        ParseItems(body, true);
    }
    else if (s == CARRENT_DURATIONS)
    {
        m_subtitle = CrShape("اختر مدة الإيجار");
        ParseItems(body, true);
    }
    else if (s == CARRENT_PREVIEW || s == CARRENT_CONFIRM)
    {
        m_subtitle = (s == CARRENT_PREVIEW) ? "معاينة المركبة"
                                            : "أكد الإيجار";
        m_items.clear();
        char clean[4096];
        StripColors(body ? body : "", clean, sizeof(clean));
        m_confirmBody = clean;
    }
}

bool CCarRentOverlay::TryHandleDialog(uint16_t dialogId, uint8_t /*style*/,
                                      const char* title, const char* body)
{
    if (!title) return false;

    char tclean[128];
    StripColors(title, tclean, sizeof(tclean));

    // Match the three rental titles produced by arabonline.pwn:
    //   "Car Rental - Select Vehicle"
    //   "Rent <car> - Choose Duration"
    //   "Confirm Rental"
    if (strstr(tclean, "تأجير السيارات"))
    {
        SetState(CARRENT_CARS, dialogId, title, body);
        return true;
    }
    if (strstr(tclean, "معاينة الإيجار"))
    {
        SetState(CARRENT_PREVIEW, dialogId, title, body);
        return true;
    }
    if (strstr(tclean, "اختر المدة"))
    {
        SetState(CARRENT_DURATIONS, dialogId, title, body);
        return true;
    }
    if (strstr(tclean, "تأكيد الإيجار"))
    {
        SetState(CARRENT_CONFIRM, dialogId, title, body);
        return true;
    }

    return false;
}

void CCarRentOverlay::SendPick(int listitem)
{
    char empty[2] = {0};
    CarRent_SendDialogResponse(m_dialogId, 1, (uint16_t)listitem, empty);
    Hide();
}

void CCarRentOverlay::SendCancel()
{
    char empty[2] = {0};
    CarRent_SendDialogResponse(m_dialogId, 0, 0, empty);
    Hide();
}

// X button: close the overlay locally without sending any dialog response.
// In most rental states the button=0 response has a side-effect (e.g. in
// d_trent_preview it means "See Car", not "cancel"), so we just dismiss the
// overlay. The server keeps the dialog pending; it will be replaced by the
// next dialog or expire when the player re-enters the checkpoint.
static void CarRent_Close(CCarRentOverlay* self)
{
    if (self) self->Hide();
}

void CCarRentOverlay::Render()
{
    if (m_state == CARRENT_NONE) return;

    ImGuiIO& io = ImGui::GetIO();

    if (m_fAnimT < 1.0f)
    {
        m_fAnimT += io.DeltaTime / 0.25f;
        if (m_fAnimT > 1.0f) m_fAnimT = 1.0f;
    }
    float ease = 1.0f - (1.0f - m_fAnimT) * (1.0f - m_fAnimT);

    float scale = io.DisplaySize.y / 1080.0f;
    if (scale < 0.5f) scale = 0.5f;

    // Large, prominent panel: fill most of the screen to make every card big
    // and easy to tap. Leave thin margins so the bezel/glow is visible.
    float panelW = io.DisplaySize.x * 0.92f;
    float panelH = io.DisplaySize.y * 0.94f;
    // Upper caps so it doesn't blow up on tablets
    if (panelW > 1600.0f * scale) panelW = 1600.0f * scale;
    if (panelH > 1000.0f * scale) panelH = 1000.0f * scale;

    float panelX = (io.DisplaySize.x - panelW) * 0.5f;
    float panelY = (io.DisplaySize.y - panelH) * 0.5f;
    panelY -= (1.0f - ease) * 40.0f * scale;

    ImDrawList* dl = ImGui::GetOverlayDrawList();

    // Dim backdrop
    dl->AddRectFilled(ImVec2(0, 0), io.DisplaySize, IM_COL32(0, 0, 0, (int)(160 * ease)));

    ImVec2 pMin(panelX, panelY);
    ImVec2 pMax(panelX + panelW, panelY + panelH);
    float rounding = 26.0f * scale;

    // Outer glow
    for (int i = 0; i < 6; ++i)
    {
        float t = i / 6.0f;
        dl->AddRect(
            ImVec2(pMin.x - i * 2.0f, pMin.y - i * 2.0f),
            ImVec2(pMax.x + i * 2.0f, pMax.y + i * 2.0f),
            IM_COL32(60, 255, 120, (int)((1.0f - t) * 28 * ease)),
            rounding + i * 2.0f, 0, 2.0f);
    }

    // Body gradient
    dl->AddRectFilledMultiColor(pMin, pMax,
        IM_COL32(20, 40, 30, (int)(240 * ease)),
        IM_COL32(14, 28, 22, (int)(240 * ease)),
        IM_COL32( 8, 18, 14, (int)(250 * ease)),
        IM_COL32(12, 22, 18, (int)(250 * ease))
    );
    // Soft highlight line at the top - no hard border
    dl->AddRectFilledMultiColor(ImVec2(pMin.x + rounding, pMin.y + 1),
                                ImVec2(pMax.x - rounding, pMin.y + 24.0f * scale),
                                kC_HiLine, kC_HiLine,
                                IM_COL32(255,255,255,0),
                                IM_COL32(255,255,255,0));

    // --- Header ---
    float headerH = 168.0f * scale;
    ImVec2 hMax(pMax.x, pMin.y + headerH);
    dl->AddRectFilledMultiColor(pMin, hMax,
        IM_COL32(17, 156, 69, 220),
        IM_COL32( 0, 210, 140, 220),
        IM_COL32( 0, 180, 120, 140),
        IM_COL32(17, 156, 69, 140));
    dl->AddLine(ImVec2(pMin.x + 12, hMax.y), ImVec2(pMax.x - 12, hMax.y),
                kC_Accent, 2.0f);

    // Car icon (stylized)
    {
        float iconX = pMin.x + 36.0f * scale;
        float iconY = pMin.y + 42.0f * scale;
        float iconS = 56.0f * scale;
        ImU32 ic = IM_COL32(255,255,255, 240);
        // Body
        dl->AddRectFilled(ImVec2(iconX, iconY + iconS*0.45f),
                          ImVec2(iconX + iconS*1.6f, iconY + iconS*0.90f),
                          ic, 6.0f*scale);
        // Cabin
        dl->AddQuadFilled(
            ImVec2(iconX + iconS*0.32f, iconY + iconS*0.45f),
            ImVec2(iconX + iconS*1.28f, iconY + iconS*0.45f),
            ImVec2(iconX + iconS*1.10f, iconY + iconS*0.18f),
            ImVec2(iconX + iconS*0.50f, iconY + iconS*0.18f), ic);
        // Wheels
        dl->AddCircleFilled(ImVec2(iconX + iconS*0.36f, iconY + iconS*0.95f),
                            iconS*0.16f, IM_COL32(30, 30, 30, 255));
        dl->AddCircleFilled(ImVec2(iconX + iconS*1.28f, iconY + iconS*0.95f),
                            iconS*0.16f, IM_COL32(30, 30, 30, 255));
        dl->AddCircleFilled(ImVec2(iconX + iconS*0.36f, iconY + iconS*0.95f),
                            iconS*0.08f, ic);
        dl->AddCircleFilled(ImVec2(iconX + iconS*1.28f, iconY + iconS*0.95f),
                            iconS*0.08f, ic);
    }

    ImFont* font = pGUI ? pGUI->GetFont() : nullptr;
    // Header title (English, large)
    {
        const char* title = nullptr;
        switch (m_state)
        {
            case CARRENT_CARS:      title = "تأجير المركبات"; break;
            case CARRENT_PREVIEW:   title = "معاينة المركبة"; break;
            case CARRENT_DURATIONS: title = "اختر المدة"; break;
            case CARRENT_CONFIRM:   title = "أكد الإيجار"; break;
            default:                title = "إيجار"; break;
        }
        if (font)
        {
            float fs = 56.0f * scale;
            std::string titleSh = CrShape(title);
            dl->AddText(font, fs,
                        ImVec2(pMin.x + 160.0f * scale, pMin.y + 22.0f * scale),
                        kC_Text, titleSh.c_str());

            // Subtitle
            std::string subtitleSh = CrShape(m_subtitle.c_str());
            dl->AddText(font, 28.0f * scale,
                        ImVec2(pMin.x + 160.0f * scale, pMin.y + 96.0f * scale),
                        kC_TextDim, subtitleSh.c_str());
        }
    }

    // --- Edge-detected input state (shared between Close button + list + buttons) ---
    // We track down/up transitions ourselves so dragging vs tapping can be
    // distinguished. A "tap" is fired on MouseUp if the finger didn't travel
    // more than kTapSlop since MouseDown.
    const float kTapSlop = 10.0f;
    static bool s_prevDown = false;
    bool down = io.MouseDown[0];
    bool pressed  = (down && !s_prevDown);  // edge: just went down
    bool released = (!down && s_prevDown);  // edge: just lifted
    s_prevDown = down;

    if (pressed)
    {
        m_fDownX          = io.MousePos.x;
        m_fDownY          = io.MousePos.y;
        m_fDragStartY     = io.MousePos.y;
        m_fDragStartScroll= m_fScroll;
        m_fLastTouchY     = io.MousePos.y;
        m_bMovedSinceDown = false;
        m_bDragging       = false;
    }
    if (down)
    {
        float dx = io.MousePos.x - m_fDownX;
        float dy = io.MousePos.y - m_fDownY;
        if (!m_bMovedSinceDown && (dx*dx + dy*dy) > (kTapSlop*kTapSlop))
            m_bMovedSinceDown = true;
    }

    // Close (X) button (28 dp on the top-right of the header)
    ImVec2 closeC(pMax.x - 50.0f * scale, pMin.y + headerH * 0.5f);
    float  closeR = 28.0f * scale;
    {
        ImVec2 mp = io.MousePos;
        float dx = mp.x - closeC.x, dy = mp.y - closeC.y;
        bool inCloseHit  = (dx*dx + dy*dy <= (closeR+10.0f*scale)*(closeR+10.0f*scale));
        bool hover = down && inCloseHit;
        // Soft drop shadow + gradient glass fill, no hard border
        dl->AddCircleFilled(ImVec2(closeC.x + 2.0f * scale,
                                   closeC.y + 4.0f * scale),
                            closeR, kC_Shadow, 40);
        dl->AddCircleFilled(closeC, closeR,
            hover ? kC_Danger : IM_COL32(34, 50, 42, 235), 40);
        dl->AddCircleFilled(ImVec2(closeC.x, closeC.y + closeR * 0.25f),
            closeR * 0.78f,
            hover ? IM_COL32(160, 50, 50, 140)
                  : IM_COL32(14, 28, 22, 90), 36);
        dl->AddCircleFilled(ImVec2(closeC.x, closeC.y - closeR * 0.30f),
            closeR * 0.65f, IM_COL32(255, 255, 255, 28), 32);
        float xs = closeR * 0.45f;
        dl->AddLine(ImVec2(closeC.x - xs, closeC.y - xs),
                    ImVec2(closeC.x + xs, closeC.y + xs), kC_Text, 2.6f);
        dl->AddLine(ImVec2(closeC.x + xs, closeC.y - xs),
                    ImVec2(closeC.x - xs, closeC.y + xs), kC_Text, 2.6f);

        // Fire on release (tap = small movement) and only if down-start was on X too.
        float downDx = m_fDownX - closeC.x;
        float downDy = m_fDownY - closeC.y;
        bool downOnClose = (downDx*downDx + downDy*downDy
                           <= (closeR+10.0f*scale)*(closeR+10.0f*scale));
        if (released && !m_bMovedSinceDown && downOnClose)
        {
            CarRent_Close(this);
            return;
        }
    }

    // Content area (leave narrow footer only)
    float contentTop = pMin.y + headerH + 14.0f * scale;
    float contentBot = pMax.y - 46.0f * scale;   // leave narrow room for footer hint

    if (m_state == CARRENT_CARS || m_state == CARRENT_DURATIONS)
    {
        // --- Card list ---
        float cardW = panelW - 80.0f * scale;  // leave room for scrollbar
        float cardH = 160.0f * scale;          // much bigger touch target
        float cardSp = 14.0f * scale;
        float x0 = pMin.x + 30.0f * scale;
        float areaH = contentBot - contentTop;

        float totalH = m_items.size() * (cardH + cardSp);
        float maxScroll = (totalH > areaH) ? (totalH - areaH) : 0.0f;

        // Touch-drag scrolling: if the finger started inside the list area and
        // moves vertically, drag the list. MouseWheel is kept for desktop.
        bool downStartedInList = (m_fDownY >= contentTop && m_fDownY <= contentBot &&
                                  m_fDownX >= pMin.x    && m_fDownX <= pMax.x);
        if (down && downStartedInList && m_bMovedSinceDown && maxScroll > 0.5f)
        {
            m_fScroll = m_fDragStartScroll - (io.MousePos.y - m_fDragStartY);
            m_fLastTouchY = io.MousePos.y;
        }
        // Wheel (desktop)
        m_fScroll -= io.MouseWheel * 40.0f;

        // Apply inertia when not actively dragging
        if (!down && maxScroll > 0.5f)
        {
            // Simple decay; 0.9 every frame
            m_fScroll += m_fScrollVelocity * io.DeltaTime;
            m_fScrollVelocity *= 0.90f;
            if (m_fScrollVelocity > -1.0f && m_fScrollVelocity < 1.0f)
                m_fScrollVelocity = 0.0f;
        }
        else if (down && m_bMovedSinceDown)
        {
            // Track velocity for momentum (pixels per second)
            if (io.DeltaTime > 0.0f)
                m_fScrollVelocity = -(io.MouseDelta.y) / io.DeltaTime;
        }

        // Clamp
        if (m_fScroll < 0) { m_fScroll = 0; m_fScrollVelocity = 0; }
        if (m_fScroll > maxScroll) { m_fScroll = maxScroll; m_fScrollVelocity = 0; }

        // Clip drawing
        dl->PushClipRect(ImVec2(pMin.x, contentTop),
                         ImVec2(pMax.x, contentBot), true);

        const char* cardHint = (m_state == CARRENT_CARS)
                                   ? "اضغط لاستئجار المركبة"
                                   : "اضغط لاختيار المدة";

        float y = contentTop - m_fScroll;
        int hovered = -1;
        for (size_t i = 0; i < m_items.size(); ++i)
        {
            ImVec2 cMin(x0, y);
            ImVec2 cMax(x0 + cardW, y + cardH);

            bool inView = (cMax.y >= contentTop && cMin.y <= contentBot);
            if (inView)
            {
                // Visual hover: highlight only while pressing without dragging
                bool hover = (down && !m_bMovedSinceDown &&
                              io.MousePos.x >= cMin.x && io.MousePos.x <= cMax.x &&
                              io.MousePos.y >= cMin.y && io.MousePos.y <= cMax.y &&
                              io.MousePos.y >= contentTop && io.MousePos.y <= contentBot);
                if (hover) hovered = (int)i;

                // Soft shadow under card for lift
                dl->AddRectFilled(ImVec2(cMin.x + 3*scale, cMin.y + 6*scale),
                                  ImVec2(cMax.x + 3*scale, cMax.y + 6*scale),
                                  kC_Shadow, 14.0f * scale);
                // Gradient card body (no hard border)
                dl->AddRectFilledMultiColor(cMin, cMax,
                    hover ? kC_CardHovT : kC_CardTop,
                    hover ? kC_CardHovT : kC_CardTop,
                    hover ? kC_CardHovB : kC_CardBot,
                    hover ? kC_CardHovB : kC_CardBot);
                // Subtle top highlight
                dl->AddRectFilledMultiColor(
                    ImVec2(cMin.x + 14.0f * scale, cMin.y + 1),
                    ImVec2(cMax.x - 14.0f * scale, cMin.y + cardH * 0.40f),
                    kC_HiLine, kC_HiLine,
                    IM_COL32(255,255,255,0),
                    IM_COL32(255,255,255,0));

                // Left accent strip
                dl->AddRectFilled(cMin,
                    ImVec2(cMin.x + 5.0f * scale, cMax.y),
                    kC_Accent, 14.0f * scale);

                // Number badge (polished glass)
                ImVec2 nC(cMin.x + 70.0f * scale, (cMin.y + cMax.y) * 0.5f);
                float nR = 44.0f * scale;
                dl->AddCircleFilled(ImVec2(nC.x + 2.0f*scale,
                                            nC.y + 4.0f*scale),
                                     nR, kC_Shadow, 40);
                dl->AddCircleFilled(nC, nR, IM_COL32(0, 90, 60, 245), 40);
                dl->AddCircleFilled(ImVec2(nC.x, nC.y + nR * 0.25f),
                                     nR * 0.78f,
                                     IM_COL32(0, 50, 30, 140), 36);
                dl->AddCircleFilled(ImVec2(nC.x, nC.y - nR * 0.30f),
                                     nR * 0.65f,
                                     IM_COL32(255, 255, 255, 30), 32);
                char nbuf[8];
                snprintf(nbuf, sizeof(nbuf), "%d", (int)i + 1);
                if (font)
                {
                    ImVec2 tsz = font->CalcTextSizeA(40.0f * scale, FLT_MAX, 0, nbuf);
                    dl->AddText(font, 40.0f * scale,
                        ImVec2(nC.x - tsz.x * 0.5f, nC.y - tsz.y * 0.5f),
                        kC_Text, nbuf);
                }

                // Label (bigger)
                if (font)
                {
                    dl->AddText(font, 42.0f * scale,
                        ImVec2(cMin.x + 130.0f * scale, cMin.y + 28.0f * scale),
                        kC_Text, m_items[i].label.c_str());

                    // Small Arabic sub-label under the car name
                    dl->AddText(font, 24.0f * scale,
                        ImVec2(cMin.x + 130.0f * scale, cMin.y + 90.0f * scale),
                        kC_TextMuted, cardHint);
                }

                // Price pill on the right (bigger)
                const char* pricetxt = m_items[i].priceText.c_str();
                if (pricetxt && *pricetxt)
                {
                    float fs = 38.0f * scale;
                    ImVec2 tsz = font ? font->CalcTextSizeA(fs, FLT_MAX, 0, pricetxt)
                                      : ImVec2(80 * scale, fs);
                    float padX = 14.0f * scale, padY = 8.0f * scale;
                    ImVec2 pillMax(cMax.x - 16.0f * scale,
                                   (cMin.y + cMax.y) * 0.5f + tsz.y * 0.5f + padY);
                    ImVec2 pillMin(pillMax.x - tsz.x - padX * 2.0f,
                                   (cMin.y + cMax.y) * 0.5f - tsz.y * 0.5f - padY);
                    // Soft shadow + gradient gold-green pill, no hard border
                    dl->AddRectFilled(
                        ImVec2(pillMin.x + 2*scale, pillMin.y + 4*scale),
                        ImVec2(pillMax.x + 2*scale, pillMax.y + 4*scale),
                        kC_Shadow, 14.0f * scale);
                    dl->AddRectFilledMultiColor(pillMin, pillMax,
                        IM_COL32(90, 255, 180, 235),
                        IM_COL32(90, 255, 180, 235),
                        IM_COL32( 0, 190, 130, 240),
                        IM_COL32( 0, 190, 130, 240));
                    if (font)
                        dl->AddText(font, fs,
                            ImVec2(pillMin.x + padX,
                                   (pillMin.y + pillMax.y) * 0.5f - tsz.y * 0.5f),
                            IM_COL32(10, 40, 20, 255), pricetxt);
                }
            }
            y += cardH + cardSp;
        }

        dl->PopClipRect();
        m_hoverIdx = hovered;

        // Tap-to-pick: on release, if no drag happened and both down & up
        // landed on the same card (inside the list area), trigger the pick.
        if (released && !m_bMovedSinceDown && downStartedInList)
        {
            // Compute which card the user tapped on based on DOWN position.
            float tapY = m_fDownY + m_fScroll - contentTop;
            if (m_fDownX >= x0 && m_fDownX <= x0 + cardW &&
                m_fDownY >= contentTop && m_fDownY <= contentBot)
            {
                int idx = (int)(tapY / (cardH + cardSp));
                if (idx >= 0 && idx < (int)m_items.size())
                {
                    // Confirm within the card body (not in the gap).
                    float withinY = tapY - idx * (cardH + cardSp);
                    if (withinY >= 0 && withinY <= cardH)
                    {
                        SendPick(idx);
                        return;
                    }
                }
            }
        }

        // Scrollbar
        if (maxScroll > 0.5f)
        {
            float trackX = pMax.x - 14.0f * scale;
            float trackW = 6.0f * scale;
            dl->AddRectFilled(
                ImVec2(trackX, contentTop),
                ImVec2(trackX + trackW, contentBot),
                IM_COL32(255, 255, 255, 40), trackW * 0.5f);
            float thumbH = areaH * (areaH / totalH);
            if (thumbH < 30.0f * scale) thumbH = 30.0f * scale;
            float thumbY = contentTop + (areaH - thumbH) * (m_fScroll / maxScroll);
            dl->AddRectFilled(
                ImVec2(trackX, thumbY),
                ImVec2(trackX + trackW, thumbY + thumbH),
                kC_Accent, trackW * 0.5f);
        }

        // Footer hint
        if (font)
        {
            const char* hint = (m_state == CARRENT_CARS)
                ? "اسحب لأعلى أو لأسفل لعرض مركبات أكثر"
                : "اختر مدة الإيجار المناسبة لك";
            float fs = 26.0f * scale;
            std::string hintSh = CrShape(hint);
            ImVec2 tsz = font->CalcTextSizeA(fs, FLT_MAX, 0, hintSh.c_str());
            dl->AddText(font, fs,
                ImVec2(pMin.x + (panelW - tsz.x) * 0.5f,
                       pMax.y - fs - 14.0f * scale),
                kC_TextMuted, hintSh.c_str());
        }
    }
    else if (m_state == CARRENT_PREVIEW || m_state == CARRENT_CONFIRM)
    {
        // Big confirm card
        float cardW = panelW - 80.0f * scale;
        float cardH = panelH - headerH - 160.0f * scale;
        float x0 = pMin.x + 40.0f * scale;
        float y0 = contentTop + 10.0f * scale;
        ImVec2 cMin(x0, y0);
        ImVec2 cMax(x0 + cardW, y0 + cardH);

        // Gradient body (no hard border)
        dl->AddRectFilled(ImVec2(cMin.x + 3*scale, cMin.y + 6*scale),
                          ImVec2(cMax.x + 3*scale, cMax.y + 6*scale),
                          kC_Shadow, 16.0f * scale);
        dl->AddRectFilledMultiColor(cMin, cMax,
            IM_COL32(30, 58, 44, 250), IM_COL32(30, 58, 44, 250),
            IM_COL32(12, 26, 20, 250), IM_COL32(12, 26, 20, 250));
        dl->AddRectFilledMultiColor(
            ImVec2(cMin.x + 16.0f * scale, cMin.y + 1),
            ImVec2(cMax.x - 16.0f * scale, cMin.y + cardH * 0.20f),
            kC_HiLine, kC_HiLine,
            IM_COL32(255,255,255,0), IM_COL32(255,255,255,0));

        // Draw each line of confirm body on its own row
        if (font)
        {
            float lineY = cMin.y + 30.0f * scale;
            float fs = 30.0f * scale;
            const char* p = m_confirmBody.c_str();
            char line[256];
            while (*p)
            {
                const char* eol = strchr(p, '\n');
                size_t ll = eol ? (size_t)(eol - p) : strlen(p);
                if (ll >= sizeof(line)) ll = sizeof(line) - 1;
                memcpy(line, p, ll); line[ll] = '\0';

                // Split "Label:\tValue" into two columns
                char* tab = strchr(line, '\t');
                if (tab)
                {
                    *tab = '\0';
                    dl->AddText(font, fs,
                                ImVec2(cMin.x + 28.0f * scale, lineY),
                                kC_TextDim, line);
                    const char* val = tab + 1;
                    ImVec2 tsz = font->CalcTextSizeA(fs, FLT_MAX, 0, val);
                    dl->AddText(font, fs,
                                ImVec2(cMax.x - tsz.x - 28.0f * scale, lineY),
                                kC_Accent, val);
                }
                else if (line[0])
                {
                    // Non-paired line - draw as dim muted (description)
                    dl->AddText(font, fs * 0.82f,
                                ImVec2(cMin.x + 28.0f * scale, lineY),
                                kC_TextMuted, line);
                }
                lineY += fs + 10.0f * scale;
                if (!eol) break;
                p = eol + 1;
                if (lineY > cMax.y - 30.0f * scale) break;
            }
        }

        // Confirm + Back buttons
        float btnH = 72.0f * scale;
        float btnW = (panelW - 80.0f * scale - 20.0f * scale) * 0.5f;
        float btnY = pMax.y - btnH - 22.0f * scale;
        ImVec2 confMin(pMin.x + 40.0f * scale, btnY);
        ImVec2 confMax(confMin.x + btnW, btnY + btnH);
        ImVec2 backMin(confMax.x + 20.0f * scale, btnY);
        ImVec2 backMax(backMin.x + btnW, btnY + btnH);

        auto pointInRect = [](const ImVec2& p, const ImVec2& mn, const ImVec2& mx) {
            return p.x >= mn.x && p.x <= mx.x && p.y >= mn.y && p.y <= mx.y;
        };

        bool confPressing = down && pointInRect(io.MousePos, confMin, confMax) &&
                            pointInRect(ImVec2(m_fDownX, m_fDownY), confMin, confMax);
        bool backPressing = down && pointInRect(io.MousePos, backMin, backMax) &&
                            pointInRect(ImVec2(m_fDownX, m_fDownY), backMin, backMax);

        // Button labels differ between Preview and Confirm states.
        // Preview dialog: button1="Continue" (proceed), button0="See Car" (preview)
        // Confirm dialog: button1="Rent" (confirm), button0="Cancel"
        const char* primaryLabel = (m_state == CARRENT_PREVIEW)
            ? "متابعة"
            : "أكد الإيجار";
        const char* secondaryLabel = (m_state == CARRENT_PREVIEW)
            ? "عرض المركبة"
            : "رجوع";

        // Primary (green gradient) button - no hard border
        dl->AddRectFilled(ImVec2(confMin.x + 2*scale, confMin.y + 4*scale),
                          ImVec2(confMax.x + 2*scale, confMax.y + 4*scale),
                          kC_Shadow, 12.0f * scale);
        dl->AddRectFilledMultiColor(confMin, confMax,
            confPressing ? IM_COL32( 90, 255, 170, 255) : IM_COL32( 50, 210, 130, 245),
            confPressing ? IM_COL32( 90, 255, 170, 255) : IM_COL32( 50, 210, 130, 245),
            confPressing ? IM_COL32( 18, 190,  90, 255) : IM_COL32( 14, 160,  80, 245),
            confPressing ? IM_COL32( 18, 190,  90, 255) : IM_COL32( 14, 160,  80, 245));
        dl->AddRectFilledMultiColor(
            ImVec2(confMin.x + 18.0f * scale, confMin.y + 1),
            ImVec2(confMax.x - 18.0f * scale, confMin.y + btnH * 0.42f),
            kC_HiLine, kC_HiLine,
            IM_COL32(255,255,255,0), IM_COL32(255,255,255,0));
        if (font)
        {
            float fs = 30.0f * scale;
            std::string primSh = CrShape(primaryLabel);
            ImVec2 tsz = font->CalcTextSizeA(fs, FLT_MAX, 0, primSh.c_str());
            dl->AddText(font, fs,
                ImVec2((confMin.x + confMax.x) * 0.5f - tsz.x * 0.5f,
                       (confMin.y + confMax.y) * 0.5f - tsz.y * 0.5f),
                IM_COL32(10, 40, 20, 255), primSh.c_str());
        }

        // Secondary gradient button - no hard border
        dl->AddRectFilled(ImVec2(backMin.x + 2*scale, backMin.y + 4*scale),
                          ImVec2(backMax.x + 2*scale, backMax.y + 4*scale),
                          kC_Shadow, 12.0f * scale);
        dl->AddRectFilledMultiColor(backMin, backMax,
            backPressing ? IM_COL32(100, 115, 108, 250) : IM_COL32( 58,  72,  66, 245),
            backPressing ? IM_COL32(100, 115, 108, 250) : IM_COL32( 58,  72,  66, 245),
            backPressing ? IM_COL32( 40,  55,  50, 250) : IM_COL32( 26,  40,  34, 250),
            backPressing ? IM_COL32( 40,  55,  50, 250) : IM_COL32( 26,  40,  34, 250));
        dl->AddRectFilledMultiColor(
            ImVec2(backMin.x + 18.0f * scale, backMin.y + 1),
            ImVec2(backMax.x - 18.0f * scale, backMin.y + btnH * 0.42f),
            kC_HiLine, kC_HiLine,
            IM_COL32(255,255,255,0), IM_COL32(255,255,255,0));
        if (font)
        {
            float fs = 30.0f * scale;
            std::string secSh = CrShape(secondaryLabel);
            ImVec2 tsz = font->CalcTextSizeA(fs, FLT_MAX, 0, secSh.c_str());
            dl->AddText(font, fs,
                ImVec2((backMin.x + backMax.x) * 0.5f - tsz.x * 0.5f,
                       (backMin.y + backMax.y) * 0.5f - tsz.y * 0.5f),
                kC_Text, secSh.c_str());
        }

        // Fire on release (tap, no drag)
        if (released && !m_bMovedSinceDown)
        {
            ImVec2 downP(m_fDownX, m_fDownY);
            if (pointInRect(downP, confMin, confMax) &&
                pointInRect(io.MousePos, confMin, confMax))
            {
                SendPick(0);   // primary button -> button1 in dialog terms
                return;
            }
            if (pointInRect(downP, backMin, backMax) &&
                pointInRect(io.MousePos, backMin, backMax))
            {
                SendCancel(); // secondary button -> button0 in dialog terms
                return;
            }
        }
    }
}
