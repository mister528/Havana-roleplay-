#include "../main.h"
#include "bankoverlay.h"
#include "gui.h"
#include "../vendor/imgui/imgui.h"
#include "../vendor/imgui/imgui_internal.h"
#include <cstdio>

CBankOverlay* pBankOverlay = nullptr;
extern CGUI* pGUI;

// HavanaRp brand palette (RGBA, 0xAABBGGRR ImGui order when using IM_COL32)
// IM_COL32(R, G, B, A)
static const ImU32 kColPanelBg       = IM_COL32(14,  28,  22,  235); // havana_surface
static const ImU32 kColPanelBgInner  = IM_COL32(20,  36,  28,  250);
static const ImU32 kColBorder        = IM_COL32(60, 255, 120, 200);  // havana_green
static const ImU32 kColBorderDim     = IM_COL32(60, 255, 120, 80);
static const ImU32 kColAccent        = IM_COL32( 0, 245, 160, 255);  // havana_green_accent
static const ImU32 kColGreen         = IM_COL32(60, 255, 120, 255);
static const ImU32 kColGreenDeep     = IM_COL32(17, 156,  69, 255);
static const ImU32 kColText          = IM_COL32(255,255,255, 255);
static const ImU32 kColTextDim       = IM_COL32(220,220,220, 200);
static const ImU32 kColTextMuted     = IM_COL32(180,200,190, 180);
static const ImU32 kColCashBadge     = IM_COL32( 0, 210, 140, 230);
static const ImU32 kColBankBadge     = IM_COL32( 30,180, 255, 230);

CBankOverlay::CBankOverlay()
    : m_bVisible(false)
    , m_iCash(0)
    , m_iBank(0)
    , m_dwShownAt(0)
    , m_fAnimT(0.0f)
{
}

CBankOverlay::~CBankOverlay() {}

void CBankOverlay::Show(int64_t cash, int64_t bank)
{
    m_iCash = cash;
    m_iBank = bank;
    m_bVisible = true;
    m_fAnimT = 0.0f;
}

void CBankOverlay::Hide()
{
    m_bVisible = false;
}

// Format an integer with thousands separators, e.g. 1234567 -> "1,234,567"
static void FormatMoney(int64_t value, char* out, size_t outSize)
{
    bool negative = value < 0;
    uint64_t absv = (uint64_t)(negative ? -value : value);

    char raw[48];
    int len = snprintf(raw, sizeof(raw), "%llu", (unsigned long long)absv);

    char tmp[64];
    int j = 0;
    int cntr = 0;
    for (int i = len - 1; i >= 0; --i)
    {
        if (cntr && cntr % 3 == 0 && j < (int)sizeof(tmp) - 1)
            tmp[j++] = ',';
        tmp[j++] = raw[i];
        cntr++;
    }
    tmp[j] = '\0';

    // reverse into out
    int outIdx = 0;
    if (negative && outIdx < (int)outSize - 1) out[outIdx++] = '-';
    for (int i = j - 1; i >= 0 && outIdx < (int)outSize - 1; --i)
        out[outIdx++] = tmp[i];
    if (outIdx < (int)outSize) out[outIdx] = '\0';
}

void CBankOverlay::Render()
{
    if (!m_bVisible) return;

    ImGuiIO& io = ImGui::GetIO();

    // Animate in (200ms ease-out)
    if (m_fAnimT < 1.0f)
    {
        m_fAnimT += io.DeltaTime / 0.22f;
        if (m_fAnimT > 1.0f) m_fAnimT = 1.0f;
    }
    float ease = 1.0f - (1.0f - m_fAnimT) * (1.0f - m_fAnimT);

    // Scale-aware panel size (relative to 1920x1080 mobile-safe area)
    float scale = io.DisplaySize.y / 1080.0f;
    float panelW = 720.0f * scale;
    float panelH = 440.0f * scale;

    // Center horizontally, position at upper-center
    float panelX = (io.DisplaySize.x - panelW) * 0.5f;
    float panelY = (io.DisplaySize.y - panelH) * 0.5f - 40.0f * scale;

    // Slide-down animation
    panelY -= (1.0f - ease) * 40.0f * scale;

    ImDrawList* dl = ImGui::GetOverlayDrawList();

    // Global dim backdrop
    dl->AddRectFilled(ImVec2(0, 0), io.DisplaySize, IM_COL32(0, 0, 0, (int)(140 * ease)));

    // --- Panel body with rounded corners ---
    ImVec2 pMin(panelX, panelY);
    ImVec2 pMax(panelX + panelW, panelY + panelH);
    float rounding = 22.0f * scale;

    // Outer glow
    for (int i = 0; i < 6; ++i)
    {
        float t = i / 6.0f;
        dl->AddRect(
            ImVec2(pMin.x - i * 2.0f, pMin.y - i * 2.0f),
            ImVec2(pMax.x + i * 2.0f, pMax.y + i * 2.0f),
            IM_COL32(60, 255, 120, (int)((1.0f - t) * 30 * ease)),
            rounding + i * 2.0f, 0, 2.0f);
    }

    // Panel background (two-layer gradient look)
    dl->AddRectFilledMultiColor(pMin, pMax,
        IM_COL32(18, 36, 28, (int)(235 * ease)),   // top-left
        IM_COL32(14, 28, 22, (int)(235 * ease)),   // top-right
        IM_COL32(9,  18, 14, (int)(245 * ease)),   // bot-right
        IM_COL32(12, 22, 18, (int)(245 * ease))    // bot-left
    );
    dl->AddRect(pMin, pMax, kColBorder, rounding, 0, 2.0f * scale);

    // --- Header bar ---
    float headerH = 90.0f * scale;
    ImVec2 hMin = pMin;
    ImVec2 hMax(pMax.x, pMin.y + headerH);
    dl->AddRectFilledMultiColor(hMin, hMax,
        IM_COL32(17, 156, 69, 200),
        IM_COL32( 0, 210, 140, 200),
        IM_COL32( 0, 180, 120, 120),
        IM_COL32(17, 156,  69, 120)
    );
    dl->AddLine(ImVec2(pMin.x + 12, hMax.y), ImVec2(pMax.x - 12, hMax.y), kColAccent, 2.0f);

    // Bank icon (stylized building) - drawn with primitives
    {
        float iconX = pMin.x + 30.0f * scale;
        float iconY = pMin.y + 22.0f * scale;
        float iconS = 46.0f * scale;
        ImU32 iconCol = IM_COL32(255,255,255,235);
        // Roof (triangle)
        dl->AddTriangleFilled(
            ImVec2(iconX - 4, iconY + iconS*0.30f),
            ImVec2(iconX + iconS + 4, iconY + iconS*0.30f),
            ImVec2(iconX + iconS*0.5f, iconY), iconCol);
        // Columns
        for (int i = 0; i < 4; ++i)
        {
            float cx = iconX + (iconS / 3.5f) * i + iconS*0.05f;
            dl->AddRectFilled(
                ImVec2(cx, iconY + iconS*0.34f),
                ImVec2(cx + iconS*0.12f, iconY + iconS*0.82f),
                iconCol);
        }
        // Base
        dl->AddRectFilled(
            ImVec2(iconX - 4, iconY + iconS*0.85f),
            ImVec2(iconX + iconS + 4, iconY + iconS),
            iconCol);
    }

    // Title text
    if (pGUI && pGUI->GetFont())
    {
        ImFont* font = pGUI->GetFont();
        float fSize = 34.0f * scale;
        dl->AddText(font, fSize,
            ImVec2(pMin.x + 100.0f * scale, pMin.y + 24.0f * scale),
            kColText, "بنك هافانا");
        dl->AddText(font, 18.0f * scale,
            ImVec2(pMin.x + 100.0f * scale, pMin.y + 58.0f * scale),
            kColTextDim, "ملخص الحساب");
    }
    else
    {
        dl->AddText(ImVec2(pMin.x + 100.0f * scale, pMin.y + 26.0f * scale),
                    kColText, "بنك هافانا");
    }

    // --- Close button (top-right) ---
    ImVec2 closeCenter(pMax.x - 36.0f * scale, pMin.y + headerH * 0.5f);
    float closeR = 18.0f * scale;
    bool closeHover = false;
    {
        ImVec2 mp = io.MousePos;
        float dx = mp.x - closeCenter.x;
        float dy = mp.y - closeCenter.y;
        if (dx*dx + dy*dy <= closeR*closeR && io.MouseDown[0])
            closeHover = true;
    }
    dl->AddCircleFilled(closeCenter, closeR, closeHover ? IM_COL32(255, 90, 90, 230) : IM_COL32(40, 60, 50, 230));
    dl->AddCircle(closeCenter, closeR, kColBorderDim, 16, 1.5f);
    float xs = closeR * 0.45f;
    dl->AddLine(ImVec2(closeCenter.x - xs, closeCenter.y - xs),
                ImVec2(closeCenter.x + xs, closeCenter.y + xs), kColText, 2.2f);
    dl->AddLine(ImVec2(closeCenter.x + xs, closeCenter.y - xs),
                ImVec2(closeCenter.x - xs, closeCenter.y + xs), kColText, 2.2f);

    // Handle close (click to dismiss)
    static bool s_wasDown = false;
    if (io.MouseDown[0] && !s_wasDown)
    {
        float dx = io.MousePos.x - closeCenter.x;
        float dy = io.MousePos.y - closeCenter.y;
        if (dx*dx + dy*dy <= (closeR + 6) * (closeR + 6))
            Hide();
    }
    s_wasDown = io.MouseDown[0];

    // --- Balance rows ---
    ImFont* font = pGUI ? pGUI->GetFont() : nullptr;
    float rowY = pMin.y + headerH + 38.0f * scale;
    float rowH = 110.0f * scale;
    float rowPadX = 30.0f * scale;

    auto drawRow = [&](const char* label, const char* subtitle, int64_t value,
                       ImU32 badgeCol, const char* badgeLetter)
    {
        ImVec2 rMin(pMin.x + rowPadX, rowY);
        ImVec2 rMax(pMax.x - rowPadX, rowY + rowH);

        dl->AddRectFilled(rMin, rMax, IM_COL32(20, 38, 30, 230), 14.0f * scale);
        dl->AddRect(rMin, rMax, kColBorderDim, 14.0f * scale, 0, 1.2f);

        // Badge circle
        ImVec2 badgeC(rMin.x + 42.0f * scale, (rMin.y + rMax.y) * 0.5f);
        float badgeR = 30.0f * scale;
        dl->AddCircleFilled(badgeC, badgeR + 2, IM_COL32(0,0,0,120));
        dl->AddCircleFilled(badgeC, badgeR, badgeCol);
        dl->AddCircle(badgeC, badgeR, IM_COL32(255,255,255,180), 32, 1.6f);
        if (font)
            dl->AddText(font, 28.0f * scale,
                        ImVec2(badgeC.x - 8.0f * scale, badgeC.y - 16.0f * scale),
                        kColText, badgeLetter);

        // Label
        if (font)
        {
            dl->AddText(font, 22.0f * scale,
                        ImVec2(rMin.x + 92.0f * scale, rMin.y + 16.0f * scale),
                        kColText, label);
            dl->AddText(font, 15.0f * scale,
                        ImVec2(rMin.x + 92.0f * scale, rMin.y + 46.0f * scale),
                        kColTextMuted, subtitle);
        }

        // Value (right aligned)
        char valBuf[64];
        char fullBuf[80];
        FormatMoney(value, valBuf, sizeof(valBuf));
        snprintf(fullBuf, sizeof(fullBuf), "$ %s", valBuf);
        float fs = 36.0f * scale;
        ImVec2 tsz = font ? font->CalcTextSizeA(fs, FLT_MAX, 0.0f, fullBuf)
                          : ImGui::CalcTextSize(fullBuf);
        ImVec2 valPos(rMax.x - tsz.x - 24.0f * scale,
                      (rMin.y + rMax.y) * 0.5f - tsz.y * 0.5f);
        if (font)
            dl->AddText(font, fs, valPos, kColAccent, fullBuf);
        else
            dl->AddText(valPos, kColAccent, fullBuf);

        rowY += rowH + 16.0f * scale;
    };

    drawRow("الكاش معك", "النقد الموجود بجيبك", m_iCash, kColCashBadge, "$");
    drawRow("رصيد البنك", "المتوفر في حسابك ببنك هافانا", m_iBank, kColBankBadge, "B");

    // Total
    {
        float totH = 52.0f * scale;
        ImVec2 rMin(pMin.x + rowPadX, rowY);
        ImVec2 rMax(pMax.x - rowPadX, rowY + totH);
        dl->AddRectFilledMultiColor(rMin, rMax,
            IM_COL32(0, 60, 45, 220),
            IM_COL32(0,110, 80, 220),
            IM_COL32(0, 80, 60, 220),
            IM_COL32(0, 40, 30, 220));
        dl->AddRect(rMin, rMax, kColGreen, 10.0f * scale, 0, 1.6f);

        if (font)
        {
            dl->AddText(font, 20.0f * scale,
                        ImVec2(rMin.x + 24.0f * scale, rMin.y + 14.0f * scale),
                        kColTextDim, "إجمالي الرصيد");

            char tbuf[64]; char fbuf[80];
            FormatMoney(m_iCash + m_iBank, tbuf, sizeof(tbuf));
            snprintf(fbuf, sizeof(fbuf), "$ %s", tbuf);
            float fs = 24.0f * scale;
            ImVec2 tsz = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, fbuf);
            dl->AddText(font, fs,
                        ImVec2(rMax.x - tsz.x - 22.0f * scale,
                               (rMin.y + rMax.y) * 0.5f - tsz.y * 0.5f),
                        kColText, fbuf);
        }
    }

    // Footer hint
    if (font)
    {
        const char* hint = "اضغط X أو خارج النافذة للإغلاق";
        float fs = 14.0f * scale;
        ImVec2 tsz = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, hint);
        dl->AddText(font, fs,
                    ImVec2(pMin.x + (panelW - tsz.x) * 0.5f,
                           pMax.y - fs - 14.0f * scale),
                    kColTextMuted, hint);
    }

    // Click outside panel to dismiss
    if (io.MouseClicked[0])
    {
        ImVec2 mp = io.MousePos;
        if (mp.x < pMin.x || mp.x > pMax.x || mp.y < pMin.y || mp.y > pMax.y)
            Hide();
    }
}
