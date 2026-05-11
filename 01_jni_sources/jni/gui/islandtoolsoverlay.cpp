#include "../main.h"
#include "islandtoolsoverlay.h"
#include "inventorytex.h"
#include "../arabic.h"
#include "../vendor/imgui/imgui.h"
#include "../vendor/imgui/imgui_internal.h"
#include <cstring>
#include <cmath>
#include <string>

CIslandToolsOverlay* pIslandToolsOverlay = nullptr;

static std::string IslandToolShapeText(const char* s)
{
    if (!s) return std::string();
    if (!Arabic::ContainsArabic(s)) return std::string(s);
    return Arabic::Shape(s);
}

static ImVec2 IslandToolTextSize(ImFont* font, float size, const std::string& text)
{
    if (!font) return ImGui::CalcTextSize(text.c_str());
    return font->CalcTextSizeA(size, FLT_MAX, 0.0f, text.c_str());
}

CIslandToolsOverlay::CIslandToolsOverlay()
    : m_visible(false), m_closing(false), m_anim(0.0f), m_closeAnim(0.0f), m_progress(0)
{
    m_name[0] = '\0';
}

void CIslandToolsOverlay::Show(int progress, const char* name)
{
    if (progress < 0) progress = 0;
    if (progress > 100) progress = 100;
    m_progress = progress;
    if (name && *name)
    {
        strncpy(m_name, name, sizeof(m_name) - 1);
        m_name[sizeof(m_name) - 1] = '\0';
    }
    m_visible = true;
    m_closing = false;
    if (m_anim < 0.15f) m_anim = 0.15f;
}

void CIslandToolsOverlay::Hide()
{
    if (!m_visible) return;
    m_visible = false;
    m_closing = true;
    m_closeAnim = 0.0f;
}

void CIslandToolsOverlay::Render()
{
    if (!m_visible && !m_closing) return;
    ImGuiIO& io = ImGui::GetIO();
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    ImFont* font = ImGui::GetFont();
    float sw = io.DisplaySize.x;
    float sh = io.DisplaySize.y;
    float base = sh / 1080.0f;
    if (base < 0.55f) base = 0.55f;

    float dt = io.DeltaTime > 0.0f ? io.DeltaTime : 0.016f;
    if (m_visible)
    {
        m_anim += dt * 5.0f;
        if (m_anim > 1.0f) m_anim = 1.0f;
    }
    else
    {
        m_closeAnim += dt * 6.0f;
        if (m_closeAnim >= 1.0f) { m_closing = false; m_closeAnim = 0.0f; m_anim = 0.0f; return; }
    }
    float e = m_visible ? m_anim : (1.0f - m_closeAnim);
    e = 1.0f - (1.0f - e) * (1.0f - e);

    float w = 520.0f * base;
    float h = 170.0f * base;
    float x = (sw - w) * 0.5f;
    float y = sh * 0.72f + (1.0f - e) * 90.0f * base;
    float r = 28.0f * base;

    dl->AddRectFilled(ImVec2(x - 5.0f * base, y - 5.0f * base), ImVec2(x + w + 5.0f * base, y + h + 5.0f * base), IM_COL32(40, 25, 8, (int)(115 * e)), r + 6.0f * base);
    dl->AddRectFilledMultiColor(ImVec2(x, y), ImVec2(x + w, y + h),
        IM_COL32(40, 31, 18, (int)(246 * e)), IM_COL32(70, 48, 25, (int)(246 * e)),
        IM_COL32(18, 14, 10, (int)(246 * e)), IM_COL32(30, 21, 13, (int)(246 * e)));
    dl->AddRect(ImVec2(x, y), ImVec2(x + w, y + h), IM_COL32(255, 185, 75, (int)(180 * e)), r, 0, 2.0f * base);

    float icon = 112.0f * base;
    float ix = x + 26.0f * base;
    float iy = y + (h - icon) * 0.5f;
    dl->AddCircleFilled(ImVec2(ix + icon * 0.5f, iy + icon * 0.5f), icon * 0.53f, IM_COL32(255, 194, 74, (int)(35 * e)), 48);
    void* tex = nullptr; int tw = 0, th = 0; float tu = 1.0f, tv = 1.0f;
    bool got = false;
    if (strstr(m_name, "بارود")) got = InventoryTex::GetIslandGunpowder(&tex, &tw, &th, &tu, &tv);
    else if (strstr(m_name, "حديد")) got = InventoryTex::GetIslandIron(&tex, &tw, &th, &tu, &tv);
    else if (strstr(m_name, "خردة")) got = InventoryTex::GetIslandScrap(&tex, &tw, &th, &tu, &tv);
    else if (strstr(m_name, "خشب")) got = InventoryTex::GetIslandWood(&tex, &tw, &th, &tu, &tv);
    else if (strstr(m_name, "زنبرك")) got = InventoryTex::GetIslandSpring(&tex, &tw, &th, &tu, &tv);
    if (got && tex)
        dl->AddImage((ImTextureID)tex, ImVec2(ix - 12.0f * base, iy - 12.0f * base), ImVec2(ix + icon + 12.0f * base, iy + icon + 12.0f * base), ImVec2(0,0), ImVec2(tu,tv), IM_COL32(255,255,255,(int)(255 * e)));

    const char* title = "جاري استخراج الغرض";
    std::string titleText = IslandToolShapeText(title);
    ImVec2 ts = IslandToolTextSize(font, 36.0f * base, titleText);
    dl->AddText(font, 36.0f * base, ImVec2(x + 160.0f * base, y + 28.0f * base), IM_COL32(255, 240, 210, (int)(255 * e)), titleText.c_str());

    const char* shown = m_name[0] ? m_name : "أداة";
    std::string shownText = IslandToolShapeText(shown);
    ImVec2 ns = IslandToolTextSize(font, 28.0f * base, shownText);
    dl->AddText(font, 28.0f * base, ImVec2(x + w - ns.x - 30.0f * base, y + 34.0f * base), IM_COL32(255, 210, 110, (int)(255 * e)), shownText.c_str());

    float bx = x + 160.0f * base;
    float by = y + 92.0f * base;
    float bw = w - 190.0f * base;
    float bh = 24.0f * base;
    dl->AddRectFilled(ImVec2(bx, by), ImVec2(bx + bw, by + bh), IM_COL32(12, 10, 8, (int)(235 * e)), bh * 0.5f);
    float fill = bw * ((float)m_progress / 100.0f);
    dl->AddRectFilled(ImVec2(bx, by), ImVec2(bx + fill, by + bh), IM_COL32(255, 176, 54, (int)(255 * e)), bh * 0.5f);
    dl->AddRect(ImVec2(bx, by), ImVec2(bx + bw, by + bh), IM_COL32(255, 230, 155, (int)(125 * e)), bh * 0.5f, 0, 1.5f * base);

    char pct[16];
    snprintf(pct, sizeof(pct), "%d%%", m_progress);
    ImVec2 ps = font->CalcTextSizeA(24.0f * base, FLT_MAX, 0.0f, pct);
    dl->AddText(font, 24.0f * base, ImVec2(bx + (bw - ps.x) * 0.5f, by + bh + 8.0f * base), IM_COL32(255,255,255,(int)(235 * e)), pct);
}
