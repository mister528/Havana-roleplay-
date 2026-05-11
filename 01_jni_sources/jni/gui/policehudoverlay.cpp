#include "../main.h"
#include "policehudoverlay.h"
#include "gui.h"
#include "../arabic.h"
#include "../vendor/imgui/imgui.h"
#include "../vendor/imgui/imgui_internal.h"
#include <cstring>
#include <cstdio>
#include <cstdlib>
#include <cmath>
#include <string>

// Bridge implemented in net/netrpc.cpp.
void PoliceHud_SendChatCommand(const char* cmd);

CPoliceHudOverlay* pPoliceHudOverlay = nullptr;
extern CGUI* pGUI;

#ifndef PH_PI
#define PH_PI 3.14159265358979323846f
#endif

// ---- palette --------------------------------------------------------------
static const ImU32 kColShadow      = IM_COL32(  0,   0,   0, 200);
static const ImU32 kColRingOuter   = IM_COL32( 14,  18,  28, 230);
static const ImU32 kColRingMid     = IM_COL32( 22,  32,  52, 240);
static const ImU32 kColRingInner   = IM_COL32( 38,  56,  92, 245);
static const ImU32 kColAccentA     = IM_COL32( 56, 165, 255, 255); // police blue
static const ImU32 kColAccentB     = IM_COL32(  0, 110, 220, 255);
static const ImU32 kColAccentDim   = IM_COL32( 24,  64, 128, 255);
static const ImU32 kColCuff        = IM_COL32(225, 232, 244, 255);
static const ImU32 kColCuffShadow  = IM_COL32( 10,  16,  28, 255);
static const ImU32 kColPulse       = IM_COL32( 80, 180, 255,  90);
static const ImU32 kColLabelText   = IM_COL32(225, 232, 244, 255);
static const ImU32 kColBadgeText   = IM_COL32(255, 220, 130, 255);

// edit-mode chrome
static const ImU32 kColEditOverlay = IM_COL32(  0,   0,   0, 110);
static const ImU32 kColEditMarker  = IM_COL32(255, 200,  60, 230);
static const ImU32 kColBtnBgN      = IM_COL32( 22,  30,  44, 240);
static const ImU32 kColBtnBgH      = IM_COL32( 40,  60,  90, 240);
static const ImU32 kColBtnBorder   = IM_COL32(120, 170, 230, 255);
static const ImU32 kColBtnText     = IM_COL32(235, 240, 250, 255);
static const ImU32 kColBtnSaveBg   = IM_COL32( 28,  90,  46, 240);
static const ImU32 kColBtnSaveBd   = IM_COL32( 80, 220, 120, 255);
static const ImU32 kColBtnCancelBg = IM_COL32(120,  32,  32, 240);
static const ImU32 kColBtnCancelBd = IM_COL32(255, 110, 110, 255);

CPoliceHudOverlay::CPoliceHudOverlay()
    : m_bVisible(false)
    , m_pulse(0.0f)
    , m_pressAnim(0.0f)
    , m_lastMouseDown(false)
    , m_cfgX(0.96f)
    , m_cfgY(0.42f)
    , m_cfgSize(1.0f)
    , m_editMode(false)
    , m_dragging(false)
    , m_savedX(0.96f)
    , m_savedY(0.42f)
    , m_savedSize(1.0f)
{
}

bool CPoliceHudOverlay::IsBlockingInput() const
{
    // While the layout editor is open the entire screen is reserved for
    // adjustments so the chat / map / movement keys don't fight us.
    return m_bVisible && m_editMode;
}

// Parses "X Y SIZE" (or "X|Y|SIZE", separators don't matter) out of `body`.
// Returns true if all three numbers parsed successfully.
static bool ParseLayoutBody(const char* body,
                            float& outX, float& outY, float& outSize)
{
    if (!body) return false;
    float x = 0.0f, y = 0.0f, s = 0.0f;
    int n = sscanf(body, "%f %f %f", &x, &y, &s);
    if (n != 3) return false;
    outX = x; outY = y; outSize = s;
    return true;
}

bool CPoliceHudOverlay::TryHandleDialog(uint16_t /*dialogId*/, uint8_t /*style*/,
                                       const char* title, const char* body)
{
    if (!title) return false;

    if (strncmp(title, "[!POLICE_HUD_ON]",  16) == 0)
    {
        m_bVisible      = true;
        m_pressAnim     = 0.0f;
        m_lastMouseDown = false;
        return true;
    }
    if (strncmp(title, "[!POLICE_HUD_OFF]", 17) == 0)
    {
        m_bVisible      = false;
        m_editMode      = false;
        m_dragging      = false;
        m_pressAnim     = 0.0f;
        return true;
    }
    if (strncmp(title, "[!POLICE_HUD_CFG]", 17) == 0)
    {
        float x, y, s;
        if (ParseLayoutBody(body, x, y, s))
        {
            if (x < 0.05f) x = 0.05f; if (x > 0.95f) x = 0.95f;
            if (y < 0.05f) y = 0.05f; if (y > 0.95f) y = 0.95f;
            if (s < 0.5f)  s = 0.5f;  if (s > 2.0f)  s = 2.0f;
            m_cfgX = x; m_cfgY = y; m_cfgSize = s;
        }
        return true;
    }
    if (strncmp(title, "[!POLICE_HUD_EDIT]", 18) == 0)
    {
        float x, y, s;
        if (ParseLayoutBody(body, x, y, s))
        {
            m_cfgX = x; m_cfgY = y; m_cfgSize = s;
        }
        m_savedX     = m_cfgX;
        m_savedY     = m_cfgY;
        m_savedSize  = m_cfgSize;
        m_bVisible   = true;
        m_editMode   = true;
        m_dragging   = false;
        m_pressAnim  = 0.0f;
        m_lastMouseDown = false;
        return true;
    }
    return false;
}

// Draws a single handcuff (one ring + chain stub) centered at (cx,cy)
// with given outer radius "r" and chain pointing in (dx,dy) direction.
static void DrawCuffRing(ImDrawList* dl, float cx, float cy, float r,
                         float dx, float dy)
{
    float chainLen = r * 0.55f;
    float chainX0  = cx + dx * (r * 0.85f);
    float chainY0  = cy + dy * (r * 0.85f);
    float chainX1  = chainX0 + dx * chainLen;
    float chainY1  = chainY0 + dy * chainLen;

    float linkW = r * 0.32f;
    float nx = -dy, ny = dx;
    ImVec2 a(chainX0 - nx * linkW * 0.5f, chainY0 - ny * linkW * 0.5f);
    ImVec2 b(chainX1 - nx * linkW * 0.5f, chainY1 - ny * linkW * 0.5f);
    ImVec2 c(chainX1 + nx * linkW * 0.5f, chainY1 + ny * linkW * 0.5f);
    ImVec2 d(chainX0 + nx * linkW * 0.5f, chainY0 + ny * linkW * 0.5f);
    dl->AddQuadFilled(a, b, c, d, kColCuffShadow);

    dl->AddCircleFilled(ImVec2(cx, cy), r,         kColCuff,       40);
    dl->AddCircleFilled(ImVec2(cx, cy), r * 0.62f, kColCuffShadow, 40);

    float khR = r * 0.16f;
    float khX = cx - dx * (r * 0.30f);
    float khY = cy - dy * (r * 0.30f);
    dl->AddCircleFilled(ImVec2(khX, khY), khR, kColAccentA, 24);
    dl->AddCircle      (ImVec2(khX, khY), khR, kColCuffShadow, 24, 1.4f);
}

// Shapes (Arabic-aware) and centers a label inside the given rect, then
// returns true if the rect was clicked this frame. `fontPx` is the desired
// font height in pixels; the rect is sized by the caller.
static bool RectButton(ImDrawList* dl, const char* label,
                       float x, float y, float w, float h,
                       ImU32 bgN, ImU32 bgH, ImU32 borderCol,
                       ImU32 textCol,
                       const ImVec2& mp, bool clickedThisFrame,
                       float fontPx)
{
    bool hovered =
        (mp.x >= x && mp.x <= x + w &&
         mp.y >= y && mp.y <= y + h);

    ImU32 bg = hovered ? bgH : bgN;
    // drop shadow
    dl->AddRectFilled(ImVec2(x + 3.0f, y + 5.0f),
                      ImVec2(x + w + 3.0f, y + h + 5.0f),
                      IM_COL32(0, 0, 0, 170), 12.0f);
    // body
    dl->AddRectFilled(ImVec2(x, y), ImVec2(x + w, y + h), bg, 12.0f);
    // bright top highlight band
    dl->AddRectFilledMultiColor(
        ImVec2(x, y), ImVec2(x + w, y + h * 0.45f),
        IM_COL32(255, 255, 255, 35), IM_COL32(255, 255, 255, 35),
        IM_COL32(255, 255, 255,  0), IM_COL32(255, 255, 255,  0));
    // border
    dl->AddRect(ImVec2(x, y), ImVec2(x + w, y + h),
                borderCol, 12.0f, ImDrawCornerFlags_All, 2.4f);

    ImFont* font = ImGui::GetFont();
    if (font && label)
    {
        std::string shaped = Arabic::Shape(label);
        const char* p = shaped.c_str();
        ImVec2 ts = font->CalcTextSizeA(fontPx, FLT_MAX, 0.0f, p);
        float tx = x + (w - ts.x) * 0.5f;
        float ty = y + (h - ts.y) * 0.5f;
        dl->AddText(font, fontPx, ImVec2(tx + 2, ty + 2),
                    IM_COL32(0, 0, 0, 220), p);
        dl->AddText(font, fontPx, ImVec2(tx, ty), textCol, p);
    }

    return hovered && clickedThisFrame;
}

// Helper: shape + draw centered text (Arabic-aware) with a soft shadow.
static ImVec2 DrawCenteredShaped(ImDrawList* dl, ImFont* font,
                                 float fontPx, const char* logical,
                                 float cx, float y, ImU32 col)
{
    if (!font || !logical) return ImVec2(0, 0);
    std::string shaped = Arabic::Shape(logical);
    const char* p = shaped.c_str();
    ImVec2 ts = font->CalcTextSizeA(fontPx, FLT_MAX, 0.0f, p);
    float x = cx - ts.x * 0.5f;
    dl->AddText(font, fontPx, ImVec2(x + 2, y + 2),
                IM_COL32(0, 0, 0, 220), p);
    dl->AddText(font, fontPx, ImVec2(x, y), col, p);
    return ts;
}

void CPoliceHudOverlay::RenderHud(float cx, float cy, float radius,
                                  float scale, bool inEdit)
{
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    if (!dl) return;

    // ---- Outer pulse glow -------------------------------------------------
    float pulseT = (sinf(m_pulse) * 0.5f + 0.5f);
    float glowR  = radius * (1.18f + 0.10f * pulseT);
    int   glowA  = (int)(60 + 70 * pulseT);
    if (glowA > 255) glowA = 255;
    ImU32 colGlow = (kColPulse & 0x00FFFFFF) | (((unsigned)glowA & 0xFF) << 24);
    dl->AddCircleFilled(ImVec2(cx, cy), glowR, colGlow, 56);

    // drop shadow
    dl->AddCircleFilled(ImVec2(cx + 3.0f, cy + 5.0f), radius + 2.0f,
                        kColShadow, 56);

    // layered ring
    dl->AddCircleFilled(ImVec2(cx, cy), radius,         kColRingOuter, 56);
    dl->AddCircleFilled(ImVec2(cx, cy), radius * 0.92f, kColRingMid,   56);
    dl->AddCircleFilled(ImVec2(cx, cy), radius * 0.82f, kColRingInner, 56);

    // accent ring
    float ringTh = 3.4f * scale;
    dl->AddCircle(ImVec2(cx, cy), radius * 0.95f,
                  m_pressAnim > 0.0f ? kColAccentA : kColAccentDim,
                  56, ringTh);

    // animated arc (police-style rotating accent)
    {
        float aLen = PH_PI * 0.55f;
        float aS   = m_pulse;
        float aE   = aS + aLen;
        const int seg = 24;
        for (int i = 0; i < seg; ++i)
        {
            float t0 = (float)i / seg;
            float t1 = (float)(i+1) / seg;
            float a0 = aS + (aE - aS) * t0;
            float a1 = aS + (aE - aS) * t1;
            float r0 = radius * 0.99f;
            ImVec2 p0(cx + cosf(a0) * r0, cy + sinf(a0) * r0);
            ImVec2 p1(cx + cosf(a1) * r0, cy + sinf(a1) * r0);
            int alpha = (int)(220 * (1.0f - t1));
            ImU32 c = (kColAccentA & 0x00FFFFFF) | (((unsigned)alpha & 0xFF) << 24);
            dl->AddLine(p0, p1, c, 2.0f * scale);
        }
    }

    // twin handcuffs icon
    float tilt   = -0.35f;
    float ringR  = radius * 0.30f;
    float halfSp = radius * 0.32f;
    float ux     = cosf(tilt), uy = sinf(tilt);

    float c1x = cx - ux * halfSp;
    float c1y = cy - uy * halfSp;
    float c2x = cx + ux * halfSp;
    float c2y = cy + uy * halfSp;

    {
        float linkW = ringR * 0.55f;
        float nx = -uy, ny = ux;
        ImVec2 a(c1x - nx * linkW * 0.5f, c1y - ny * linkW * 0.5f);
        ImVec2 b(c2x - nx * linkW * 0.5f, c2y - ny * linkW * 0.5f);
        ImVec2 cc(c2x + nx * linkW * 0.5f, c2y + ny * linkW * 0.5f);
        ImVec2 d(c1x + nx * linkW * 0.5f, c1y + ny * linkW * 0.5f);
        dl->AddQuadFilled(a, b, cc, d, kColCuffShadow);
        dl->AddQuadFilled(
            ImVec2(a.x + 1, a.y + 1), ImVec2(b.x - 1, b.y - 1),
            ImVec2(cc.x - 1, cc.y - 1), ImVec2(d.x + 1, d.y + 1),
            kColCuff);
    }

    DrawCuffRing(dl, c1x, c1y, ringR, -ux, -uy);
    DrawCuffRing(dl, c2x, c2y, ringR,  ux,  uy);

    // press flash
    if (m_pressAnim > 0.0f)
    {
        int a = (int)(140 * m_pressAnim);
        if (a > 255) a = 255;
        ImU32 cF = IM_COL32(255, 255, 255, a);
        dl->AddCircleFilled(ImVec2(cx, cy), radius * 0.95f, cF, 56);
    }

    // bottom label
    ImFont* font = ImGui::GetFont();
    if (font)
    {
        const char* label = "CUFF";
        float fontSz = 13.0f * scale;
        ImVec2 ts = font->CalcTextSizeA(fontSz, FLT_MAX, 0.0f, label);
        float lx = cx - ts.x * 0.5f;
        float ly = cy + radius - ts.y - 2.0f * scale;
        dl->AddText(font, fontSz, ImVec2(lx + 1, ly + 1),
                    IM_COL32(0, 0, 0, 220), label);
        dl->AddText(font, fontSz, ImVec2(lx, ly), kColLabelText, label);
    }

    // top star badge
    {
        float sx = cx;
        float sy = cy - radius * 0.62f;
        float sR = 6.0f * scale;
        const int pts = 5;
        ImVec2 verts[10];
        for (int i = 0; i < pts * 2; ++i)
        {
            float a = -PH_PI * 0.5f + (PH_PI / pts) * (float)i;
            float rr = (i & 1) ? sR * 0.45f : sR;
            verts[i] = ImVec2(sx + cosf(a) * rr, sy + sinf(a) * rr);
        }
        dl->AddConvexPolyFilled(verts, pts * 2, kColBadgeText);
    }

    // edit-mode marker (dashed border + grab handle hint)
    if (inEdit)
    {
        const int dashes = 24;
        for (int i = 0; i < dashes; ++i)
        {
            if ((i & 1) == 0) continue;
            float a0 = (PH_PI * 2.0f) * (float)i      / (float)dashes;
            float a1 = (PH_PI * 2.0f) * (float)(i+1)  / (float)dashes;
            float rr = radius * 1.07f;
            ImVec2 p0(cx + cosf(a0) * rr, cy + sinf(a0) * rr);
            ImVec2 p1(cx + cosf(a1) * rr, cy + sinf(a1) * rr);
            dl->AddLine(p0, p1, kColEditMarker, 2.4f * scale);
        }
    }
}

void CPoliceHudOverlay::RenderEditChrome(float cx, float cy, float radius,
                                         float scale)
{
    ImGuiIO& io = ImGui::GetIO();
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    if (!dl) return;

    // full-screen dim so the editor stands out and chat / movement do not
    // bleed through visually
    dl->AddRectFilled(ImVec2(0, 0), io.DisplaySize,
                      IM_COL32(0, 0, 0, 160));

    ImFont* font = ImGui::GetFont();

    // ---- top banner ------------------------------------------------------
    if (font)
    {
        const char* title = "تعديل واجهة الكلبشة";
        const char* sub   = "اسحب الزر لتغيير مكانه - استخدم الازرار لتغيير حجمه - ثم اضغط حفظ";

        float fsTitle = 32.0f * scale;
        float fsSub   = 18.0f * scale;

        std::string sTitle = Arabic::Shape(title);
        std::string sSub   = Arabic::Shape(sub);

        ImVec2 tsT = font->CalcTextSizeA(fsTitle, FLT_MAX, 0.0f, sTitle.c_str());
        ImVec2 tsS = font->CalcTextSizeA(fsSub,   FLT_MAX, 0.0f, sSub.c_str());

        float bannerW = (tsT.x > tsS.x ? tsT.x : tsS.x) + 80.0f * scale;
        float bannerH = tsT.y + tsS.y + 40.0f * scale;
        float bx = (io.DisplaySize.x - bannerW) * 0.5f;
        float by = 24.0f * scale;

        // banner shadow + body
        dl->AddRectFilled(ImVec2(bx + 4, by + 6),
                          ImVec2(bx + bannerW + 4, by + bannerH + 6),
                          IM_COL32(0, 0, 0, 180), 14.0f);
        dl->AddRectFilled(ImVec2(bx, by),
                          ImVec2(bx + bannerW, by + bannerH),
                          IM_COL32(14, 22, 40, 235), 14.0f);
        dl->AddRect      (ImVec2(bx, by),
                          ImVec2(bx + bannerW, by + bannerH),
                          kColAccentA, 14.0f, ImDrawCornerFlags_All, 2.2f);

        // title centered
        float tx = bx + (bannerW - tsT.x) * 0.5f;
        float ty = by + 14.0f * scale;
        dl->AddText(font, fsTitle, ImVec2(tx + 2, ty + 2),
                    IM_COL32(0, 0, 0, 230), sTitle.c_str());
        dl->AddText(font, fsTitle, ImVec2(tx, ty),
                    IM_COL32(255, 220, 130, 255), sTitle.c_str());

        // subtitle
        float sx = bx + (bannerW - tsS.x) * 0.5f;
        float sy = ty + tsT.y + 8.0f * scale;
        dl->AddText(font, fsSub, ImVec2(sx + 2, sy + 2),
                    IM_COL32(0, 0, 0, 210), sSub.c_str());
        dl->AddText(font, fsSub, ImVec2(sx, sy),
                    IM_COL32(220, 232, 250, 255), sSub.c_str());
    }

    // ---- size +/- buttons (left side) ------------------------------------
    ImVec2 mp = io.MousePos;
    bool   md = io.MouseDown[0];
    bool   clickedThisFrame = (md && !m_lastMouseDown);

    // bigger, square buttons (touch-friendly)
    float btnW = 150.0f * scale;
    float btnH = 110.0f * scale;
    float leftX = 36.0f * scale;
    float baseY = io.DisplaySize.y * 0.5f - btnH - 18.0f * scale;

    // size readout label above the buttons
    if (font)
    {
        char sz[64];
        snprintf(sz, sizeof(sz), "الحجم %.2f", m_cfgSize);
        float fs = 22.0f * scale;
        std::string s = Arabic::Shape(sz);
        ImVec2 ts = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, s.c_str());
        float lx = leftX + (btnW - ts.x) * 0.5f;
        float ly = baseY - ts.y - 12.0f * scale;
        dl->AddText(font, fs, ImVec2(lx + 2, ly + 2),
                    IM_COL32(0, 0, 0, 230), s.c_str());
        dl->AddText(font, fs, ImVec2(lx, ly),
                    IM_COL32(255, 220, 130, 255), s.c_str());
    }

    if (RectButton(dl, "تكبير +", leftX, baseY, btnW, btnH,
                   kColBtnBgN, kColBtnBgH, kColBtnBorder, kColBtnText,
                   mp, clickedThisFrame, 26.0f * scale))
    {
        m_cfgSize += 0.10f;
        if (m_cfgSize > 2.0f) m_cfgSize = 2.0f;
    }
    if (RectButton(dl, "تصغير -",
                   leftX, baseY + btnH + 18.0f * scale,
                   btnW, btnH,
                   kColBtnBgN, kColBtnBgH, kColBtnBorder, kColBtnText,
                   mp, clickedThisFrame, 26.0f * scale))
    {
        m_cfgSize -= 0.10f;
        if (m_cfgSize < 0.5f) m_cfgSize = 0.5f;
    }

    // ---- Save / Cancel buttons (bottom center) ---------------------------
    float bigW = 280.0f * scale;
    float bigH = 100.0f * scale;
    float gap  = 32.0f * scale;
    float row  = io.DisplaySize.y - bigH - 48.0f * scale;
    float cxs  = io.DisplaySize.x * 0.5f - bigW - gap * 0.5f;
    float cxc  = io.DisplaySize.x * 0.5f + gap * 0.5f;

    if (RectButton(dl, "حفظ", cxs, row, bigW, bigH,
                   kColBtnSaveBg, IM_COL32(40, 150, 80, 240),
                   kColBtnSaveBd, kColBtnText,
                   mp, clickedThisFrame, 32.0f * scale))
    {
        char cmd[96];
        snprintf(cmd, sizeof(cmd), "/hudset %.4f %.4f %.4f",
                 m_cfgX, m_cfgY, m_cfgSize);
        PoliceHud_SendChatCommand(cmd);
        m_editMode = false;
        m_dragging = false;
    }

    if (RectButton(dl, "الغاء", cxc, row, bigW, bigH,
                   kColBtnCancelBg, IM_COL32(180, 60, 60, 240),
                   kColBtnCancelBd, kColBtnText,
                   mp, clickedThisFrame, 32.0f * scale))
    {
        m_cfgX     = m_savedX;
        m_cfgY     = m_savedY;
        m_cfgSize  = m_savedSize;
        m_editMode = false;
        m_dragging = false;
    }

    // ---- coordinates readout near the HUD --------------------------------
    if (font)
    {
        char co[64];
        snprintf(co, sizeof(co), "X %.2f   Y %.2f", m_cfgX, m_cfgY);
        float fs = 18.0f * scale;
        ImVec2 ts = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, co);
        float tx = cx - ts.x * 0.5f;
        float ty = cy + radius + 16.0f * scale;
        dl->AddText(font, fs, ImVec2(tx + 2, ty + 2),
                    IM_COL32(0, 0, 0, 220), co);
        dl->AddText(font, fs, ImVec2(tx, ty), kColEditMarker, co);
    }
}

void CPoliceHudOverlay::Render()
{
    if (!m_bVisible) return;

    ImGuiIO& io = ImGui::GetIO();
    if (io.DisplaySize.x <= 0.0f || io.DisplaySize.y <= 0.0f) return;

    ImDrawList* dl = ImGui::GetOverlayDrawList();
    if (!dl) return;

    m_pulse += io.DeltaTime * 2.2f;
    if (m_pulse > PH_PI * 2.0f) m_pulse -= PH_PI * 2.0f;

    if (m_pressAnim > 0.0f)
    {
        m_pressAnim -= io.DeltaTime * 4.5f;
        if (m_pressAnim < 0.0f) m_pressAnim = 0.0f;
    }

    // ---- Geometry from saved layout --------------------------------------
    float baseScale = io.DisplaySize.y / 1080.0f;
    if (baseScale < 0.5f) baseScale = 0.5f;
    float scale  = baseScale * m_cfgSize;
    float radius = 56.0f * scale;

    if (m_cfgX < 0.05f) m_cfgX = 0.05f; if (m_cfgX > 0.95f) m_cfgX = 0.95f;
    if (m_cfgY < 0.05f) m_cfgY = 0.05f; if (m_cfgY > 0.95f) m_cfgY = 0.95f;

    float cx = io.DisplaySize.x * m_cfgX;
    float cy = io.DisplaySize.y * m_cfgY;

    // keep the HUD fully on screen
    if (cx - radius < 4.0f)                 cx = radius + 4.0f;
    if (cx + radius > io.DisplaySize.x - 4) cx = io.DisplaySize.x - radius - 4.0f;
    if (cy - radius < 4.0f)                 cy = radius + 4.0f;
    if (cy + radius > io.DisplaySize.y - 4) cy = io.DisplaySize.y - radius - 4.0f;

    ImVec2 mp = io.MousePos;
    float  dx = mp.x - cx, dy = mp.y - cy;
    bool   inside = (dx*dx + dy*dy) <= (radius * radius);

    bool mouseDown = io.MouseDown[0];
    bool clicked   = false;

    if (m_editMode)
    {
        // dim background first so HUD draws on top
        RenderEditChrome(cx, cy, radius, baseScale);

        // drag the HUD around
        if (mouseDown)
        {
            if (!m_dragging && inside)
                m_dragging = true;
            if (m_dragging)
            {
                float nx = mp.x / io.DisplaySize.x;
                float ny = mp.y / io.DisplaySize.y;
                if (nx < 0.05f) nx = 0.05f; if (nx > 0.95f) nx = 0.95f;
                if (ny < 0.05f) ny = 0.05f; if (ny > 0.95f) ny = 0.95f;
                m_cfgX = nx;
                m_cfgY = ny;
            }
        }
        else
        {
            m_dragging = false;
        }

        // capture all input while editing
        io.WantCaptureMouse = true;
        io.WantCaptureKeyboard = true;

        m_lastMouseDown = mouseDown;

        // re-compute final position after drag
        cx = io.DisplaySize.x * m_cfgX;
        cy = io.DisplaySize.y * m_cfgY;
        if (cx - radius < 4.0f)                 cx = radius + 4.0f;
        if (cx + radius > io.DisplaySize.x - 4) cx = io.DisplaySize.x - radius - 4.0f;
        if (cy - radius < 4.0f)                 cy = radius + 4.0f;
        if (cy + radius > io.DisplaySize.y - 4) cy = io.DisplaySize.y - radius - 4.0f;

        RenderHud(cx, cy, radius, scale, /*inEdit=*/true);
        return;
    }

    // normal mode (not edit)
    if (inside && mouseDown && !m_lastMouseDown)
    {
        clicked     = true;
        m_pressAnim = 1.0f;
    }
    m_lastMouseDown = mouseDown;

    if (clicked)
    {
        PoliceHud_SendChatCommand("/cuffnear");
    }

    if (inside)
    {
        io.WantCaptureMouse = true;
    }

    RenderHud(cx, cy, radius, scale, /*inEdit=*/false);
}
