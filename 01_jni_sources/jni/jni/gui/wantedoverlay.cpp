#include "../main.h"
#include "wantedoverlay.h"
#include "gui.h"
#include "../arabic.h"
#include "../vendor/imgui/imgui.h"
#include "../vendor/imgui/imgui_internal.h"
#include <cstring>
#include <cstdio>
#include <cstdlib>
#include <cmath>
#include <string>

// Bridge implemented in net/netrpc.cpp (same one police HUD uses).
void PoliceHud_SendChatCommand(const char* cmd);

CWantedOverlay* pWantedOverlay = nullptr;
extern CGUI* pGUI;

#ifndef WO_PI
#define WO_PI 3.14159265358979323846f
#endif

// ---- palette ---------------------------------------------------------------
static const ImU32 kColPanelShadow = IM_COL32(  0,   0,   0, 220);
static const ImU32 kColPanelBgTop  = IM_COL32( 14,  20,  34, 246);
static const ImU32 kColPanelBgBot  = IM_COL32( 10,  14,  24, 248);
static const ImU32 kColPanelBorder = IM_COL32( 56, 165, 255, 235);
static const ImU32 kColAccentA     = IM_COL32( 56, 165, 255, 255);
static const ImU32 kColAccentB     = IM_COL32(  0, 110, 220, 255);
static const ImU32 kColRowBgN      = IM_COL32( 22,  32,  52, 240);
static const ImU32 kColRowBgH      = IM_COL32( 38,  60,  98, 240);
static const ImU32 kColRowBorder   = IM_COL32( 80, 130, 200, 200);
static const ImU32 kColTextPrimary = IM_COL32(232, 240, 250, 255);
static const ImU32 kColTextDim     = IM_COL32(170, 188, 215, 255);
static const ImU32 kColStarOn      = IM_COL32(255, 210,  90, 255);
static const ImU32 kColStarOff     = IM_COL32( 70,  82, 100, 200);
static const ImU32 kColBtnBlueBg   = IM_COL32( 28,  90, 170, 240);
static const ImU32 kColBtnBlueBd   = IM_COL32(120, 190, 255, 255);
static const ImU32 kColBtnAmberBg  = IM_COL32(160,  92,  20, 240);
static const ImU32 kColBtnAmberBd  = IM_COL32(255, 200, 100, 255);
static const ImU32 kColBtnRedBg    = IM_COL32(140,  32,  32, 240);
static const ImU32 kColBtnRedBd    = IM_COL32(255, 110, 110, 255);
static const ImU32 kColCloseBg     = IM_COL32( 70,  20,  24, 240);
static const ImU32 kColCloseBd     = IM_COL32(255, 130, 130, 255);
static const ImU32 kColInfoBg      = IM_COL32( 18,  26,  44, 250);
static const ImU32 kColInfoBorder  = IM_COL32(255, 200, 100, 255);

// ===========================================================================
// Helpers
// ===========================================================================

void CWantedOverlay::Trim(std::string& s)
{
    while (!s.empty() && (s.back() == ' ' || s.back() == '\r' ||
                          s.back() == '\n' || s.back() == '\t'))
        s.pop_back();
    size_t i = 0;
    while (i < s.size() && (s[i] == ' ' || s[i] == '\t')) i++;
    if (i > 0) s.erase(0, i);
}

// "id|name|stars|level\nid|name|stars|level..."
void CWantedOverlay::ParseList(const char* body, std::vector<WantedRow>& out)
{
    out.clear();
    if (!body) return;

    std::string buf(body);
    size_t pos = 0;
    while (pos <= buf.size())
    {
        size_t nl = buf.find('\n', pos);
        if (nl == std::string::npos) nl = buf.size();
        std::string line = buf.substr(pos, nl - pos);
        Trim(line);
        pos = nl + 1;
        if (line.empty()) continue;

        // split by '|'
        std::string parts[4];
        int n = 0;
        size_t p = 0;
        while (n < 4 && p <= line.size())
        {
            size_t bar = line.find('|', p);
            if (bar == std::string::npos) bar = line.size();
            parts[n++] = line.substr(p, bar - p);
            p = bar + 1;
            if (bar == line.size()) break;
        }
        if (n < 3) continue;
        WantedRow r;
        r.id    = atoi(parts[0].c_str());
        r.name  = parts[1];
        Trim(r.name);
        r.stars = atoi(parts[2].c_str());
        r.level = (n >= 4) ? atoi(parts[3].c_str()) : 0;
        out.push_back(r);
        if (out.size() >= 32) break;
    }
}

// "id|name|stars|level|reason|by_name|hh:mm:ss"
bool CWantedOverlay::ParseInfo(const char* body, WantedInfo& out)
{
    out.valid = false;
    if (!body) return false;
    std::string line(body);
    Trim(line);
    if (line.empty()) return false;

    std::string parts[7];
    int n = 0;
    size_t p = 0;
    while (n < 7 && p <= line.size())
    {
        size_t bar = line.find('|', p);
        if (bar == std::string::npos) bar = line.size();
        parts[n++] = line.substr(p, bar - p);
        p = bar + 1;
        if (bar == line.size()) break;
    }
    if (n < 4) return false;
    out.id     = atoi(parts[0].c_str());
    out.name   = parts[1]; Trim(out.name);
    out.stars  = atoi(parts[2].c_str());
    out.level  = atoi(parts[3].c_str());
    out.reason = (n >= 5) ? parts[4] : "";
    Trim(out.reason);
    out.byName = (n >= 6) ? parts[5] : "";
    Trim(out.byName);
    out.sinceHms = (n >= 7) ? parts[6] : "";
    Trim(out.sinceHms);
    out.valid = true;
    return true;
}

// ===========================================================================
// Construction
// ===========================================================================
CWantedOverlay::CWantedOverlay()
    : m_bVisible(false)
    , m_infoOpen(false)
    , m_hudActive(false)
    , m_cfgX(0.96f)
    , m_cfgY(0.42f)
    , m_cfgSize(1.0f)
    , m_iconX(0.92f)
    , m_iconY(0.62f)
    , m_iconSize(1.0f)
    , m_iconEditMode(false)
    , m_iconPulse(0.0f)
    , m_iconPressAnim(0.0f)
    , m_iconLastMouseDown(false)
    , m_lastMouseDown(false)
    , m_openAnim(0.0f)
    , m_scrollY(0.0f)
    , m_scrollVel(0.0f)
    , m_scrollMax(0.0f)
    , m_dragScroll(false)
    , m_dragPending(false)
    , m_dragStartY(0.0f)
    , m_dragStartX(0.0f)
    , m_dragStartScroll(0.0f)
{
    m_info.valid = false;
}

bool CWantedOverlay::IsBlockingInput() const
{
    // The floating icon does NOT need to block input (the user must be
    // able to walk under it). The panel + info card DO block.
    return m_bVisible || m_iconEditMode;
}

void CWantedOverlay::SetIconAnchor(float x, float y, float sz)
{
    if (x < 0.05f) x = 0.05f; if (x > 0.95f) x = 0.95f;
    if (y < 0.05f) y = 0.05f; if (y > 0.95f) y = 0.95f;
    if (sz < 0.5f) sz = 0.5f; if (sz > 2.0f) sz = 2.0f;
    m_iconX    = x;
    m_iconY    = y;
    m_iconSize = sz;
}

float CWantedOverlay::GetIconRadiusPx(float baseScale) const
{
    if (baseScale < 0.5f) baseScale = 0.5f;
    return 46.0f * baseScale * m_iconSize;
}

void CWantedOverlay::GetIconCenterPx(float displayW, float displayH,
                                     float& cx, float& cy,
                                     float& radius) const
{
    float baseScale = displayH / 1080.0f;
    if (baseScale < 0.5f) baseScale = 0.5f;
    radius = GetIconRadiusPx(baseScale);
    cx = displayW * m_iconX;
    cy = displayH * m_iconY;
    if (cx - radius < 4.0f)               cx = radius + 4.0f;
    if (cx + radius > displayW - 4.0f)    cx = displayW - radius - 4.0f;
    if (cy - radius < 4.0f)               cy = radius + 4.0f;
    if (cy + radius > displayH - 4.0f)    cy = displayH - radius - 4.0f;
}

void CWantedOverlay::Toggle()
{
    if (!m_hudActive) return;
    if (m_bVisible)
    {
        Hide();
    }
    else
    {
        m_bVisible      = true;
        m_infoOpen      = false;
        m_openAnim      = 0.0f;
        m_scrollY       = 0.0f;
        m_scrollVel     = 0.0f;
        m_dragScroll    = false;
        m_dragPending   = false;
        // Reset so the first frame's input is treated as fresh state and
        // not as "already-pressed continuation" of the icon tap.
        m_lastMouseDown = true;
        // Ask server for a fresh list right away.
        PoliceHud_SendChatCommand("/wantedrefresh");
    }
}

void CWantedOverlay::SetAnchor(float cfgX, float cfgY, float cfgSize,
                               bool active)
{
    m_cfgX     = cfgX;
    m_cfgY     = cfgY;
    m_cfgSize  = cfgSize;
    m_hudActive = active;
    if (!active)
    {
        m_bVisible = false;
        m_infoOpen = false;
    }
}

// ===========================================================================
// Dialog handling
// ===========================================================================
bool CWantedOverlay::TryHandleDialog(uint16_t /*dialogId*/, uint8_t /*style*/,
                                     const char* title, const char* body)
{
    if (!title) return false;

    if (strncmp(title, "[!POLICE_HUD_LIST]", 18) == 0)
    {
        ParseList(body, m_rows);
        return true;
    }
    if (strncmp(title, "[!POLICE_HUD_INFO]", 18) == 0)
    {
        if (ParseInfo(body, m_info))
        {
            m_infoOpen = true;
            m_bVisible = true;
        }
        return true;
    }
    if (strncmp(title, "[!WANTED_HUD_CFG]", 17) == 0)
    {
        // body = "X Y SIZE" - position of the floating wanted icon.
        if (body)
        {
            float x = m_iconX, y = m_iconY, s = m_iconSize;
            if (sscanf(body, "%f %f %f", &x, &y, &s) == 3)
                SetIconAnchor(x, y, s);
        }
        return true;
    }
    return false;
}

// ===========================================================================
// Drawing helpers
// ===========================================================================
static void DrawRoundedShadow(ImDrawList* dl, ImVec2 a, ImVec2 b,
                              float r, ImU32 col, float spread = 6.0f)
{
    dl->AddRectFilled(ImVec2(a.x + spread * 0.6f, a.y + spread),
                      ImVec2(b.x + spread * 0.6f, b.y + spread),
                      col, r);
}

static void DrawShapedText(ImDrawList* dl, ImFont* font, float fontPx,
                           const char* logical, float x, float y, ImU32 col)
{
    if (!font || !logical) return;
    std::string shaped = Arabic::Shape(logical);
    dl->AddText(font, fontPx, ImVec2(x + 1.5f, y + 1.5f),
                IM_COL32(0, 0, 0, 220), shaped.c_str());
    dl->AddText(font, fontPx, ImVec2(x, y), col, shaped.c_str());
}

static ImVec2 MeasureShaped(ImFont* font, float fontPx, const char* logical)
{
    if (!font || !logical) return ImVec2(0, 0);
    std::string shaped = Arabic::Shape(logical);
    return font->CalcTextSizeA(fontPx, FLT_MAX, 0.0f, shaped.c_str());
}

static bool DrawButton(ImDrawList* dl, ImFont* font, const char* label,
                       float x, float y, float w, float h,
                       ImU32 bgN, ImU32 bgH, ImU32 borderCol,
                       ImU32 textCol, float fontPx,
                       const ImVec2& mp, bool clickedThisFrame,
                       bool& hoveredOut)
{
    bool hovered =
        (mp.x >= x && mp.x <= x + w && mp.y >= y && mp.y <= y + h);
    hoveredOut = hovered;

    ImU32 bg = hovered ? bgH : bgN;
    dl->AddRectFilled(ImVec2(x + 2, y + 4),
                      ImVec2(x + w + 2, y + h + 4),
                      IM_COL32(0, 0, 0, 170), 10.0f);
    dl->AddRectFilled(ImVec2(x, y), ImVec2(x + w, y + h), bg, 10.0f);
    dl->AddRectFilledMultiColor(
        ImVec2(x, y), ImVec2(x + w, y + h * 0.5f),
        IM_COL32(255, 255, 255, 35), IM_COL32(255, 255, 255, 35),
        IM_COL32(255, 255, 255,  0), IM_COL32(255, 255, 255,  0));
    dl->AddRect(ImVec2(x, y), ImVec2(x + w, y + h),
                borderCol, 10.0f, ImDrawCornerFlags_All, 2.0f);

    if (font && label)
    {
        ImVec2 ts = MeasureShaped(font, fontPx, label);
        float tx = x + (w - ts.x) * 0.5f;
        float ty = y + (h - ts.y) * 0.5f;
        DrawShapedText(dl, font, fontPx, label, tx, ty, textCol);
    }
    return hovered && clickedThisFrame;
}

// 5-point stars row at (x, y) - radius determines spacing.
static void DrawStarsRow(ImDrawList* dl, float x, float y, float r,
                         int filled, int total = 6)
{
    if (total < 1) total = 1;
    if (total > 6) total = 6;
    float step = r * 2.4f;
    for (int i = 0; i < total; ++i)
    {
        float cx = x + r + i * step;
        float cy = y + r;
        ImU32 col = (i < filled) ? kColStarOn : kColStarOff;
        const int pts = 5;
        ImVec2 verts[10];
        for (int k = 0; k < pts * 2; ++k)
        {
            float a  = -WO_PI * 0.5f + (WO_PI / pts) * (float)k;
            float rr = (k & 1) ? r * 0.45f : r;
            verts[k] = ImVec2(cx + cosf(a) * rr, cy + sinf(a) * rr);
        }
        dl->AddConvexPolyFilled(verts, pts * 2, col);
        // soft outline so the off-stars stay legible against dark bg
        for (int k = 0; k < pts * 2; ++k)
        {
            int kn = (k + 1) % (pts * 2);
            dl->AddLine(verts[k], verts[kn], IM_COL32(0, 0, 0, 200), 1.0f);
        }
    }
}

// ===========================================================================
// Render
// ===========================================================================
void CWantedOverlay::Render()
{
    if (!m_hudActive) return;
    ImGuiIO& io = ImGui::GetIO();
    if (io.DisplaySize.x <= 0.0f || io.DisplaySize.y <= 0.0f) return;
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    if (!dl) return;

    // animations
    m_openAnim += io.DeltaTime * 6.0f;
    if (m_openAnim > 1.0f) m_openAnim = 1.0f;
    m_iconPulse += io.DeltaTime * 2.4f;
    if (m_iconPulse > WO_PI * 2.0f) m_iconPulse -= WO_PI * 2.0f;
    if (m_iconPressAnim > 0.0f)
    {
        m_iconPressAnim -= io.DeltaTime * 4.5f;
        if (m_iconPressAnim < 0.0f) m_iconPressAnim = 0.0f;
    }

    // Floating wanted icon is drawn whenever the police HUD is on, even
    // if the panel is collapsed (so the player can still tap it).
    RenderIcon();

    if (m_bVisible)
    {
        RenderPanel();
        if (m_infoOpen) RenderInfoCard();
    }
}

// ---------------------------------------------------------------------------
// Floating wanted icon (drawn next to the cuff icon, but with its own
// independent X / Y / size).
// ---------------------------------------------------------------------------
void CWantedOverlay::RenderIcon()
{
    ImGuiIO& io = ImGui::GetIO();
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    ImFont* font = ImGui::GetFont();
    if (!dl) return;

    float cx, cy, radius;
    GetIconCenterPx(io.DisplaySize.x, io.DisplaySize.y, cx, cy, radius);

    // Pulse halo
    float pulseT = (sinf(m_iconPulse) * 0.5f + 0.5f);
    float glowR  = radius * (1.18f + 0.10f * pulseT);
    int   glowA  = (int)(60 + 70 * pulseT);
    if (glowA > 255) glowA = 255;
    ImU32 colGlow = IM_COL32(255, 170,  60, glowA);
    dl->AddCircleFilled(ImVec2(cx, cy), glowR, colGlow, 56);

    // drop shadow
    dl->AddCircleFilled(ImVec2(cx + 3.0f, cy + 5.0f), radius + 2.0f,
                        IM_COL32(0, 0, 0, 200), 56);

    // ring layers (warm tones to differentiate from the cuff icon)
    dl->AddCircleFilled(ImVec2(cx, cy), radius,         IM_COL32( 28,  18,  12, 232), 56);
    dl->AddCircleFilled(ImVec2(cx, cy), radius * 0.93f, IM_COL32( 64,  34,  22, 240), 56);
    dl->AddCircleFilled(ImVec2(cx, cy), radius * 0.78f, IM_COL32(110,  60,  30, 245), 56);

    // accent band gradient (orange -> red)
    dl->AddCircle(ImVec2(cx, cy), radius * 0.93f,
                  IM_COL32(255, 200, 110, 255), 56, 2.4f);
    dl->AddCircle(ImVec2(cx, cy), radius * 0.62f,
                  IM_COL32(255, 100,  60, 255), 56, 1.8f);

    // Wanted-style poster: a stylised "W*" inside the disc.
    if (font)
    {
        const char* glyph = "W";
        float fs = radius * 1.10f;
        ImVec2 ts = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, glyph);
        float tx = cx - ts.x * 0.5f;
        float ty = cy - ts.y * 0.55f;
        dl->AddText(font, fs, ImVec2(tx + 2, ty + 2),
                    IM_COL32(0, 0, 0, 220), glyph);
        dl->AddText(font, fs, ImVec2(tx, ty),
                    IM_COL32(255, 240, 180, 255), glyph);

        // little badge under the W with the live count.
        char cnt[24];
        snprintf(cnt, sizeof(cnt), "%d", (int)m_rows.size());
        float fsCnt = radius * 0.42f;
        ImVec2 cs = font->CalcTextSizeA(fsCnt, FLT_MAX, 0.0f, cnt);
        float bw = cs.x + radius * 0.40f;
        float bh = cs.y + radius * 0.18f;
        float bx = cx - bw * 0.5f;
        float by = cy + radius * 0.28f;
        dl->AddRectFilled(ImVec2(bx, by), ImVec2(bx + bw, by + bh),
                          IM_COL32(180,  40,  40, 240),
                          bh * 0.5f);
        dl->AddRect(ImVec2(bx, by), ImVec2(bx + bw, by + bh),
                    IM_COL32(255, 200, 100, 255), bh * 0.5f,
                    ImDrawCornerFlags_All, 1.6f);
        dl->AddText(font, fsCnt,
                    ImVec2(bx + (bw - cs.x) * 0.5f,
                           by + (bh - cs.y) * 0.5f),
                    IM_COL32(255, 245, 220, 255), cnt);
    }

    // Press feedback
    if (m_iconPressAnim > 0.0f)
    {
        float a = (int)(180 * m_iconPressAnim);
        if (a < 0) a = 0;
        if (a > 255) a = 255;
        dl->AddCircle(ImVec2(cx, cy), radius * (1.05f + 0.04f * m_iconPressAnim),
                      IM_COL32(255, 255, 255, (int)a), 56, 3.0f);
    }

    // Edit-mode marker so the user can see the icon is draggable.
    if (m_iconEditMode)
    {
        dl->AddCircle(ImVec2(cx, cy), radius + 6.0f,
                      IM_COL32(255, 200,  60, 230), 56, 3.0f);
    }

    // Click to toggle the panel - only when NOT editing layout (the
    // edit chrome owns drag input in that mode).
    if (m_iconEditMode)
    {
        m_iconLastMouseDown = io.MouseDown[0];
        return;
    }

    ImVec2 mp = io.MousePos;
    float  dx = mp.x - cx, dy = mp.y - cy;
    bool   inside = (dx*dx + dy*dy) <= (radius * radius);
    bool   md = io.MouseDown[0];
    bool   click = (inside && md && !m_iconLastMouseDown);
    m_iconLastMouseDown = md;
    if (click)
    {
        m_iconPressAnim = 1.0f;
        Toggle();
        // Make sure the panel's click detection doesn't see this same
        // frame as a "click" (we already consumed it).
        m_lastMouseDown = true;
    }
    if (inside)
        io.WantCaptureMouse = true;
}

void CWantedOverlay::RenderPanel()
{
    ImGuiIO& io   = ImGui::GetIO();
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    ImFont* font  = ImGui::GetFont();
    if (!dl) return;

    float baseScale = io.DisplaySize.y / 1080.0f;
    if (baseScale < 0.5f) baseScale = 0.5f;

    // Panel anchors to the WANTED ICON (so it opens beside that icon,
    // not beside the cuff button). Both position + size come from the
    // independent m_iconX/Y/Size config.
    float scale = baseScale * m_iconSize;
    float radius = GetIconRadiusPx(baseScale);
    float hcx, hcy, hr;
    GetIconCenterPx(io.DisplaySize.x, io.DisplaySize.y, hcx, hcy, hr);

    // Panel size scales with icon size but capped to 92% of screen.
    float W = 480.0f * scale;
    if (W > io.DisplaySize.x * 0.92f) W = io.DisplaySize.x * 0.92f;
    float headerH = 92.0f * scale;
    float footerH = 92.0f * scale;
    float rowH    = 110.0f * scale;
    int   visible = (int)m_rows.size();
    if (visible > 6) visible = 6;
    if (visible < 1) visible = 1;
    float listH   = rowH * visible + 16.0f * scale;
    float H       = headerH + listH + footerH + 24.0f * scale;
    if (H > io.DisplaySize.y * 0.92f) H = io.DisplaySize.y * 0.92f;

    // Place panel left/right of the WANTED icon depending on its X fraction.
    bool leftSide = (m_iconX > 0.5f);
    float gap = 16.0f * scale;
    float panelX, panelY;
    if (leftSide)
    {
        // panel slides in from the LEFT of the wanted icon
        float target = hcx - radius - gap - W;
        if (target < 8.0f) target = 8.0f;
        panelX = target + (1.0f - m_openAnim) * (gap * 4.0f);
    }
    else
    {
        // panel slides in from the RIGHT of the wanted icon
        float target = hcx + radius + gap;
        if (target + W > io.DisplaySize.x - 8.0f)
            target = io.DisplaySize.x - W - 8.0f;
        panelX = target - (1.0f - m_openAnim) * (gap * 4.0f);
    }
    panelY = hcy - H * 0.5f;
    if (panelY < 8.0f) panelY = 8.0f;
    if (panelY + H > io.DisplaySize.y - 8.0f)
        panelY = io.DisplaySize.y - H - 8.0f;

    float alpha = m_openAnim;
    if (alpha < 0.05f) alpha = 0.05f;

    // ---- panel body --------------------------------------------------------
    // soft drop shadow
    dl->AddRectFilled(ImVec2(panelX + 6.0f, panelY + 10.0f),
                      ImVec2(panelX + W + 6.0f, panelY + H + 10.0f),
                      IM_COL32(0, 0, 0, (int)(180 * alpha)), 18.0f);

    // gradient fill
    ImU32 cTop = (kColPanelBgTop & 0x00FFFFFF) |
                 (((unsigned)(((kColPanelBgTop >> 24) & 0xFF) * alpha) & 0xFF) << 24);
    ImU32 cBot = (kColPanelBgBot & 0x00FFFFFF) |
                 (((unsigned)(((kColPanelBgBot >> 24) & 0xFF) * alpha) & 0xFF) << 24);
    dl->AddRectFilledMultiColor(
        ImVec2(panelX, panelY), ImVec2(panelX + W, panelY + H),
        cTop, cTop, cBot, cBot);

    // accent border
    ImU32 cBorder = (kColPanelBorder & 0x00FFFFFF) |
                    (((unsigned)(((kColPanelBorder >> 24) & 0xFF) * alpha) & 0xFF) << 24);
    dl->AddRect(ImVec2(panelX, panelY), ImVec2(panelX + W, panelY + H),
                cBorder, 18.0f, ImDrawCornerFlags_All, 2.6f);

    // small "anchor pip" pointing toward the HUD (just decorative)
    {
        float pipR = 10.0f * scale;
        float pipX = leftSide ? (panelX + W) : (panelX);
        float pipY = panelY + H * 0.5f;
        dl->AddCircleFilled(ImVec2(pipX, pipY), pipR,
                            cBorder, 24);
        dl->AddCircleFilled(ImVec2(pipX, pipY), pipR * 0.55f,
                            kColPanelBgBot, 24);
    }

    // ---- header ------------------------------------------------------------
    if (font)
    {
        const char* title = "قائمة المطلوبين";
        float fsTitle = 30.0f * scale;
        ImVec2 ts = MeasureShaped(font, fsTitle, title);
        float tx = panelX + W * 0.5f - ts.x * 0.5f;
        float ty = panelY + 16.0f * scale;
        DrawShapedText(dl, font, fsTitle, title, tx, ty, kColTextPrimary);

        // count badge
        char cnt[24];
        snprintf(cnt, sizeof(cnt), "%d", (int)m_rows.size());
        float fsCnt = 22.0f * scale;
        ImVec2 cs = font->CalcTextSizeA(fsCnt, FLT_MAX, 0.0f, cnt);
        float bw = cs.x + 24.0f * scale;
        float bh = cs.y + 10.0f * scale;
        float bx = panelX + 18.0f * scale;
        float by = panelY + 22.0f * scale;
        dl->AddRectFilled(ImVec2(bx, by),
                          ImVec2(bx + bw, by + bh),
                          kColAccentB, 10.0f);
        dl->AddRect(ImVec2(bx, by), ImVec2(bx + bw, by + bh),
                    kColAccentA, 10.0f, ImDrawCornerFlags_All, 1.6f);
        dl->AddText(font, fsCnt,
                    ImVec2(bx + (bw - cs.x) * 0.5f,
                           by + (bh - cs.y) * 0.5f),
                    IM_COL32(255, 255, 255, 255), cnt);

        // header divider
        dl->AddLine(ImVec2(panelX + 16.0f * scale,
                           panelY + headerH - 4.0f * scale),
                    ImVec2(panelX + W - 16.0f * scale,
                           panelY + headerH - 4.0f * scale),
                    kColAccentA, 1.6f);
    }

    // ---- close button (top-right inside panel) -----------------------------
    ImVec2 mp = io.MousePos;
    bool   md = io.MouseDown[0];
    bool   clickedThisFrame = (md && !m_lastMouseDown);

    {
        float bw = 56.0f * scale;
        float bh = 56.0f * scale;
        float bx = panelX + W - bw - 14.0f * scale;
        float by = panelY + 18.0f * scale;
        bool hov = false;
        if (DrawButton(dl, font, "✕", bx, by, bw, bh,
                       kColCloseBg, IM_COL32(180, 60, 60, 240),
                       kColCloseBd, kColTextPrimary,
                       28.0f * scale, mp, clickedThisFrame, hov))
        {
            Hide();
            io.WantCaptureMouse = true;
            m_lastMouseDown = md;
            return;
        }
    }

    // ---- list area ---------------------------------------------------------
    float listX = panelX + 14.0f * scale;
    float listY = panelY + headerH;
    float listW = W - 28.0f * scale;
    float listVisH = H - headerH - footerH - 4.0f * scale;

    // clip
    dl->PushClipRect(ImVec2(listX - 4, listY),
                     ImVec2(listX + listW + 4, listY + listVisH), true);

    // dynamic content height
    float contentH = (m_rows.empty() ? rowH : (rowH * (float)m_rows.size()));
    m_scrollMax = contentH - listVisH;
    if (m_scrollMax < 0.0f) m_scrollMax = 0.0f;

    // touch-drag scroll. We don't engage drag immediately on press --
    // otherwise a tap on a list button would also trigger drag and the
    // button click is suppressed. Instead we record the press, then
    // upgrade to drag-scroll only after the finger has moved past a
    // small threshold. A pure tap (no movement) leaves the buttons
    // free to fire normally.
    bool overList = (mp.x >= listX && mp.x <= listX + listW &&
                     mp.y >= listY && mp.y <= listY + listVisH);
    const float kDragThreshold = 12.0f * scale;

    if (md)
    {
        if (!m_dragScroll && !m_dragPending && !m_lastMouseDown && overList)
        {
            // Press recorded, but don't latch on to drag yet.
            m_dragPending     = true;
            m_dragStartY      = mp.y;
            m_dragStartX      = mp.x;
            m_dragStartScroll = m_scrollY;
            m_scrollVel       = 0.0f;
        }
        if (m_dragPending && !m_dragScroll)
        {
            float dy = mp.y - m_dragStartY;
            float dx = mp.x - m_dragStartX;
            if (dy * dy + dx * dx > kDragThreshold * kDragThreshold)
            {
                m_dragScroll  = true;
                m_dragPending = false;
            }
        }
        if (m_dragScroll)
        {
            float delta = m_dragStartY - mp.y;
            float ny = m_dragStartScroll + delta;
            // soft clamp with rubber-band
            if (ny < 0.0f) ny *= 0.4f;
            if (ny > m_scrollMax) ny = m_scrollMax + (ny - m_scrollMax) * 0.4f;
            m_scrollVel = ny - m_scrollY;
            m_scrollY   = ny;
        }
    }
    else
    {
        m_dragPending = false;
        if (m_dragScroll) m_dragScroll = false;
        // inertia
        m_scrollY   += m_scrollVel;
        m_scrollVel *= 0.90f;
        if (m_scrollY < 0.0f)
        {
            m_scrollY *= 0.75f;
            if (m_scrollY > -0.5f) m_scrollY = 0.0f;
        }
        else if (m_scrollY > m_scrollMax)
        {
            float over = m_scrollY - m_scrollMax;
            m_scrollY -= over * 0.25f;
            if (m_scrollY < m_scrollMax + 0.5f) m_scrollY = m_scrollMax;
        }
    }

    // render rows
    if (m_rows.empty())
    {
        if (font)
        {
            const char* msg = "لا يوجد مطلوبين الآن";
            float fs = 22.0f * scale;
            ImVec2 ts = MeasureShaped(font, fs, msg);
            DrawShapedText(dl, font, fs, msg,
                           listX + (listW - ts.x) * 0.5f,
                           listY + (listVisH - ts.y) * 0.5f,
                           kColTextDim);
        }
    }
    else
    {
        // Even if the user is dragging the scroll the buttons should NOT
        // fire, so we suppress click-detection while drag-scrolling.
        bool clickAllowed = (!m_dragScroll);

        for (size_t i = 0; i < m_rows.size(); ++i)
        {
            float ry = listY + (float)i * rowH - m_scrollY;
            if (ry + rowH < listY - 8.0f) continue;
            if (ry > listY + listVisH + 8.0f) break;

            const WantedRow& r = m_rows[i];
            bool hov = (mp.x >= listX && mp.x <= listX + listW &&
                        mp.y >= ry && mp.y <= ry + rowH - 8.0f * scale);
            ImU32 bg = hov ? kColRowBgH : kColRowBgN;

            float pad = 8.0f * scale;
            dl->AddRectFilled(ImVec2(listX, ry),
                              ImVec2(listX + listW, ry + rowH - pad),
                              bg, 12.0f);
            dl->AddRect(ImVec2(listX, ry),
                        ImVec2(listX + listW, ry + rowH - pad),
                        kColRowBorder, 12.0f, ImDrawCornerFlags_All, 1.6f);

            // ID badge (left)
            char idBuf[16];
            snprintf(idBuf, sizeof(idBuf), "%d", r.id);
            float idW = 56.0f * scale;
            float idH = 38.0f * scale;
            float idX = listX + 12.0f * scale;
            float idY = ry + 14.0f * scale;
            dl->AddRectFilled(ImVec2(idX, idY),
                              ImVec2(idX + idW, idY + idH),
                              kColAccentB, 8.0f);
            if (font)
            {
                float fs = 22.0f * scale;
                ImVec2 ts = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, idBuf);
                dl->AddText(font, fs,
                            ImVec2(idX + (idW - ts.x) * 0.5f,
                                   idY + (idH - ts.y) * 0.5f),
                            IM_COL32(255, 255, 255, 255), idBuf);
            }

            // Name (Arabic-aware)
            if (font)
            {
                float fs = 24.0f * scale;
                std::string shaped = Arabic::Shape(r.name.c_str());
                ImVec2 ts = font->CalcTextSizeA(fs, FLT_MAX, 0.0f,
                                                shaped.c_str());
                float nx = idX + idW + 12.0f * scale;
                float ny = ry + 8.0f * scale;
                dl->AddText(font, fs, ImVec2(nx + 1.5f, ny + 1.5f),
                            IM_COL32(0, 0, 0, 220), shaped.c_str());
                dl->AddText(font, fs, ImVec2(nx, ny),
                            kColTextPrimary, shaped.c_str());

                // stars under name
                float sx = nx;
                float sy = ny + ts.y + 4.0f * scale;
                DrawStarsRow(dl, sx, sy, 6.0f * scale, r.stars, 6);

                // level badge to the right of stars
                char lvl[24];
                snprintf(lvl, sizeof(lvl), "Lv %d", r.level);
                float lfs = 16.0f * scale;
                ImVec2 ls = font->CalcTextSizeA(lfs, FLT_MAX, 0.0f, lvl);
                float lx = sx + 6.0f * scale * 2.4f * 6 + 18.0f * scale;
                float ly = sy + (12.0f * scale - ls.y) * 0.5f;
                dl->AddText(font, lfs, ImVec2(lx + 1, ly + 1),
                            IM_COL32(0, 0, 0, 200), lvl);
                dl->AddText(font, lfs, ImVec2(lx, ly),
                            kColTextDim, lvl);
            }

            // Buttons (right side)
            float btnW = 96.0f * scale;
            float btnH = 64.0f * scale;
            float btnY = ry + 18.0f * scale;
            float btnInfoX = listX + listW - btnW - 12.0f * scale;
            float btnLocX  = btnInfoX - btnW - 8.0f * scale;
            bool h1 = false, h2 = false;

            if (DrawButton(dl, font, "تحديد",
                           btnLocX, btnY, btnW, btnH,
                           kColBtnBlueBg,
                           IM_COL32(56, 130, 220, 240),
                           kColBtnBlueBd, kColTextPrimary,
                           20.0f * scale,
                           mp, clickedThisFrame && clickAllowed, h1))
            {
                char cmd[32];
                snprintf(cmd, sizeof(cmd), "/wantedlocate %d", r.id);
                PoliceHud_SendChatCommand(cmd);
            }
            if (DrawButton(dl, font, "معلومات",
                           btnInfoX, btnY, btnW, btnH,
                           kColBtnAmberBg,
                           IM_COL32(220, 140, 40, 240),
                           kColBtnAmberBd, kColTextPrimary,
                           20.0f * scale,
                           mp, clickedThisFrame && clickAllowed, h2))
            {
                char cmd[32];
                snprintf(cmd, sizeof(cmd), "/wantedinfo %d", r.id);
                PoliceHud_SendChatCommand(cmd);
            }
        }
    }

    dl->PopClipRect();

    // scrollbar (subtle)
    if (m_scrollMax > 0.0f)
    {
        float trackX = listX + listW + 2.0f * scale;
        float trackW = 6.0f * scale;
        dl->AddRectFilled(ImVec2(trackX, listY),
                          ImVec2(trackX + trackW, listY + listVisH),
                          IM_COL32(255, 255, 255, 30), trackW * 0.5f);
        float thumbH = listVisH * (listVisH / contentH);
        if (thumbH < 16.0f * scale) thumbH = 16.0f * scale;
        float t = (m_scrollMax > 0.0f) ? (m_scrollY / m_scrollMax) : 0.0f;
        if (t < 0.0f) t = 0.0f;
        if (t > 1.0f) t = 1.0f;
        float thumbY = listY + (listVisH - thumbH) * t;
        dl->AddRectFilled(ImVec2(trackX, thumbY),
                          ImVec2(trackX + trackW, thumbY + thumbH),
                          kColAccentA, trackW * 0.5f);
    }

    // ---- footer: cuff-nearest big button -----------------------------------
    {
        float bw = W - 36.0f * scale;
        float bh = footerH - 24.0f * scale;
        float bx = panelX + 18.0f * scale;
        float by = panelY + H - footerH + 8.0f * scale;
        bool hov = false;
        if (DrawButton(dl, font, "اعتقال الأقرب", bx, by, bw, bh,
                       IM_COL32(28, 90, 46, 240),
                       IM_COL32(60, 160, 90, 240),
                       IM_COL32(120, 230, 150, 255),
                       kColTextPrimary, 26.0f * scale,
                       mp, clickedThisFrame, hov))
        {
            PoliceHud_SendChatCommand("/cuffnear");
        }
    }

    // capture input while panel is open so chat/movement do not leak
    if (mp.x >= panelX && mp.x <= panelX + W &&
        mp.y >= panelY && mp.y <= panelY + H)
    {
        io.WantCaptureMouse    = true;
    }

    m_lastMouseDown = md;
}

void CWantedOverlay::RenderInfoCard()
{
    if (!m_info.valid) { m_infoOpen = false; return; }

    ImGuiIO& io   = ImGui::GetIO();
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    ImFont* font  = ImGui::GetFont();
    if (!dl) return;

    float baseScale = io.DisplaySize.y / 1080.0f;
    if (baseScale < 0.5f) baseScale = 0.5f;
    float scale = baseScale * m_cfgSize;

    float W = 620.0f * scale;
    if (W > io.DisplaySize.x * 0.92f) W = io.DisplaySize.x * 0.92f;
    float H = 460.0f * scale;
    if (H > io.DisplaySize.y * 0.92f) H = io.DisplaySize.y * 0.92f;
    float x = (io.DisplaySize.x - W) * 0.5f;
    float y = (io.DisplaySize.y - H) * 0.5f;

    // dim backdrop
    dl->AddRectFilled(ImVec2(0, 0), io.DisplaySize, IM_COL32(0, 0, 0, 150));

    // card
    dl->AddRectFilled(ImVec2(x + 6, y + 10),
                      ImVec2(x + W + 6, y + H + 10),
                      IM_COL32(0, 0, 0, 200), 18.0f);
    dl->AddRectFilled(ImVec2(x, y), ImVec2(x + W, y + H),
                      kColInfoBg, 18.0f);
    dl->AddRect(ImVec2(x, y), ImVec2(x + W, y + H),
                kColInfoBorder, 18.0f, ImDrawCornerFlags_All, 2.4f);

    // header banner
    if (font)
    {
        const char* head = "بطاقة المطلوب";
        float fs = 30.0f * scale;
        ImVec2 ts = MeasureShaped(font, fs, head);
        DrawShapedText(dl, font, fs, head,
                       x + (W - ts.x) * 0.5f, y + 18.0f * scale,
                       IM_COL32(255, 220, 130, 255));
    }

    float lineY = y + 80.0f * scale;
    float linePad = 10.0f * scale;
    float colVal = x + W * 0.55f;

    auto drawRow = [&](const char* label, const char* value, ImU32 col)
    {
        if (!font) return;
        float fs = 22.0f * scale;
        DrawShapedText(dl, font, fs, label,
                       x + 28.0f * scale, lineY,
                       kColTextDim);
        DrawShapedText(dl, font, fs, value, colVal, lineY, col);
        lineY += 36.0f * scale;
    };

    // rows
    char buf[128];

    drawRow("الاسم:", m_info.name.c_str(), kColTextPrimary);

    snprintf(buf, sizeof(buf), "%d", m_info.id);
    drawRow("ID:", buf, kColTextPrimary);

    // stars row drawn manually to render visually
    if (font)
    {
        float fs = 22.0f * scale;
        DrawShapedText(dl, font, fs, "النجوم:",
                       x + 28.0f * scale, lineY, kColTextDim);
        DrawStarsRow(dl, colVal, lineY + 2.0f * scale,
                     8.0f * scale, m_info.stars, 6);
        lineY += 36.0f * scale;
    }

    snprintf(buf, sizeof(buf), "%d", m_info.level);
    drawRow("المستوى:", buf, kColTextPrimary);

    drawRow("منذ:",
            m_info.sinceHms.empty() ? "غير محدد" : m_info.sinceHms.c_str(),
            kColTextPrimary);

    drawRow("بواسطة:",
            m_info.byName.empty() ? "غير محدد" : m_info.byName.c_str(),
            kColTextPrimary);

    drawRow("السبب:",
            m_info.reason.empty() ? "غير محدد" : m_info.reason.c_str(),
            IM_COL32(255, 220, 130, 255));

    // bottom buttons
    float bw = 200.0f * scale;
    float bh = 70.0f * scale;
    float by = y + H - bh - 24.0f * scale;
    float gap = 18.0f * scale;
    float bx1 = x + W * 0.5f - bw - gap * 0.5f;
    float bx2 = x + W * 0.5f + gap * 0.5f;

    ImVec2 mp = io.MousePos;
    bool   md = io.MouseDown[0];
    bool   clickedThisFrame = (md && !m_lastMouseDown);
    bool h = false;

    if (DrawButton(dl, font, "تحديد",
                   bx1, by, bw, bh,
                   kColBtnBlueBg, IM_COL32(56, 130, 220, 240),
                   kColBtnBlueBd, kColTextPrimary,
                   24.0f * scale,
                   mp, clickedThisFrame, h))
    {
        char cmd[32];
        snprintf(cmd, sizeof(cmd), "/wantedlocate %d", m_info.id);
        PoliceHud_SendChatCommand(cmd);
        m_infoOpen = false;
    }
    if (DrawButton(dl, font, "إغلاق",
                   bx2, by, bw, bh,
                   kColBtnRedBg, IM_COL32(180, 60, 60, 240),
                   kColBtnRedBd, kColTextPrimary,
                   24.0f * scale,
                   mp, clickedThisFrame, h))
    {
        m_infoOpen = false;
    }

    // capture input while card visible
    io.WantCaptureMouse    = true;
    m_lastMouseDown = md;
}
