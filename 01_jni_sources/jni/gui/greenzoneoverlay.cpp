#include "../main.h"
#include "greenzoneoverlay.h"
#include "inventorytex.h"
#include "../keyboard.h"
#include "../vendor/imgui/imgui.h"
#include "../vendor/imgui/imgui_internal.h"
#include "inventoryoverlay.h"
#include "testinvoverlay.h"

CGreenZoneOverlay* pGreenZoneOverlay = nullptr;
extern CKeyBoard* pKeyBoard;

CGreenZoneOverlay::CGreenZoneOverlay()
    : m_active(false)
    , m_anim(0.0f)
{
}

CGreenZoneOverlay::~CGreenZoneOverlay() {}

void CGreenZoneOverlay::SetActive(bool active)
{
    m_active = active;
}

static float Clamp01(float v)
{
    if (v < 0.0f) return 0.0f;
    if (v > 1.0f) return 1.0f;
    return v;
}

static float EaseOutCubic(float t)
{
    t = Clamp01(t);
    float u = 1.0f - t;
    return 1.0f - u * u * u;
}

void CGreenZoneOverlay::Render()
{
    if ((pKeyBoard && pKeyBoard->IsOpen()) ||
        (pTestInvOverlay && pTestInvOverlay->IsVisible()) ||
        (pInventoryOverlay && pInventoryOverlay->IsModalActive()))
    {
        m_anim = 0.0f;
        return;
    }

    ImGuiIO& io = ImGui::GetIO();
    float dt = io.DeltaTime;
    float target = m_active ? 1.0f : 0.0f;
    float speed = m_active ? 8.5f : 6.0f;
    if (m_anim < target)
    {
        m_anim += dt * speed;
        if (m_anim > target) m_anim = target;
    }
    else if (m_anim > target)
    {
        m_anim -= dt * speed;
        if (m_anim < target) m_anim = target;
    }

    if (m_anim <= 0.001f) return;

    void* tex = nullptr;
    int iw = 0, ih = 0;
    float u = 1.0f, v = 1.0f;
    if (!InventoryTex::GetGreenZone(&tex, &iw, &ih, &u, &v) || !tex) return;

    float scale = io.DisplaySize.y / 768.0f;
    if (scale < 0.65f) scale = 0.65f;

    float w = 305.0f * scale;
    float h = w * ((float)ih / (float)iw);
    float x = io.DisplaySize.x * 0.072f;
    float yBase = io.DisplaySize.y * 0.365f;
    float e = EaseOutCubic(m_anim);
    float y = yBase + (1.0f - e) * 20.0f * scale;
    int alpha = (int)(255.0f * e);

    ImDrawList* dl = ImGui::GetOverlayDrawList();
    ImVec2 min(x, y);
    ImVec2 max(x + w, y + h);

    dl->AddImage((ImTextureID)tex, min, max, ImVec2(0, 0), ImVec2(u, v),
                 IM_COL32(255, 255, 255, alpha));
}
