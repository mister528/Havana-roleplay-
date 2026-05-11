#include "../main.h"
#include "../game/game.h"
#include "test1overlay.h"
#include "inventorytex.h"
#include "../net/netgame.h"
#include "../vendor/imgui/imgui.h"
#include "../vendor/imgui/imgui_internal.h"

#include <stdio.h>
#include <string.h>

CTest1Overlay* pTest1Overlay = nullptr;

extern CNetGame* pNetGame;

static float T1Clamp(float v, float lo, float hi)
{
    if (v < lo) return lo;
    if (v > hi) return hi;
    return v;
}

static float T1Ease(float v)
{
    v = T1Clamp(v, 0.0f, 1.0f);
    return 1.0f - (1.0f - v) * (1.0f - v) * (1.0f - v);
}

CTest1Overlay::CTest1Overlay()
    : m_visible(false)
    , m_closing(false)
    , m_shownThisJoin(false)
    , m_wasConnected(false)
    , m_accepted(false)
    , m_lastMouseDown(false)
    , m_anim(0.0f)
{
    m_items[0].x = 0.498092f;
    m_items[0].y = 0.544444f;
    m_items[0].scale = 2.269999f;

    m_items[1].x = 0.488550f;
    m_items[1].y = 0.913889f;
    m_items[1].scale = 0.440000f;
}

CTest1Overlay::~CTest1Overlay() {}

bool CTest1Overlay::WasAccepted(const char* name)
{
    if (!name || !name[0]) return false;
    char path[512];
    snprintf(path, sizeof(path), "%sSAMP/test1_welcome_seen.txt", g_pszStorage ? g_pszStorage : "");
    FILE* f = fopen(path, "r");
    if (!f) return false;

    char line[128];
    bool found = false;
    while (fgets(line, sizeof(line), f))
    {
        line[strcspn(line, "\r\n")] = '\0';
        if (!strcmp(line, name))
        {
            found = true;
            break;
        }
    }
    fclose(f);
    return found;
}

void CTest1Overlay::SaveAccepted(const char* name)
{
    if (!name || !name[0]) return;
    if (WasAccepted(name)) return;

    char path[512];
    snprintf(path, sizeof(path), "%sSAMP/test1_welcome_seen.txt", g_pszStorage ? g_pszStorage : "");
    FILE* f = fopen(path, "a");
    if (!f) return;
    fprintf(f, "%s\n", name);
    fclose(f);
}

bool CTest1Overlay::ShouldAutoShow()
{
    bool connected = false;
    const char* playerName = nullptr;
    if (pNetGame && pNetGame->GetGameState() == GAMESTATE_CONNECTED && pNetGame->GetPlayerPool())
    {
        playerName = pNetGame->GetPlayerPool()->GetLocalPlayerName();
        CLocalPlayer* local = pNetGame->GetPlayerPool()->GetLocalPlayer();
        connected = (local && local->m_bIsActive && local->GetPlayerPed());
    }

    if (!connected)
    {
        m_wasConnected = false;
        m_shownThisJoin = false;
        m_accepted = false;
        m_visible = false;
        m_closing = false;
        m_anim = 0.0f;
        return false;
    }

    if (!m_wasConnected)
    {
        m_wasConnected = true;
        m_accepted = WasAccepted(playerName);
        if (!m_shownThisJoin && !m_accepted)
        {
            m_shownThisJoin = true;
            m_visible = true;
            m_closing = false;
            m_lastMouseDown = false;
            m_anim = 0.0f;
        }
    }
    return m_visible;
}

void CTest1Overlay::DrawImage(const Item& item, void* tex, int tw, int th, float tu, float tv,
                              float sw, float sh, float anim, ImVec2* outMin, ImVec2* outMax)
{
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    if (!dl || !tex) return;

    float baseW = (tw > th ? 760.0f : 360.0f) * (sh / 720.0f);
    float w = baseW * item.scale * (0.92f + 0.08f * anim);
    float h = w * ((tw > 0 && th > 0) ? ((float)th / (float)tw) : 1.0f);
    float x = sw * item.x - w * 0.5f;
    float y = sh * item.y - h * 0.5f + (1.0f - anim) * 34.0f;

    int alpha = (int)(255.0f * anim);
    dl->AddImage((ImTextureID)tex, ImVec2(x, y), ImVec2(x + w, y + h),
                 ImVec2(0, 0), ImVec2(tu, tv), IM_COL32(255, 255, 255, alpha));
    if (outMin) *outMin = ImVec2(x, y);
    if (outMax) *outMax = ImVec2(x + w, y + h);
}

void CTest1Overlay::Render()
{
    if (!ShouldAutoShow()) return;

    ImGuiIO& io = ImGui::GetIO();
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    if (!dl) return;

    float sw = io.DisplaySize.x;
    float sh = io.DisplaySize.y;
    float speed = m_closing ? 5.8f : 4.2f;
    m_anim = T1Clamp(m_anim + (m_closing ? -1.0f : 1.0f) * io.DeltaTime * speed, 0.0f, 1.0f);
    float e = T1Ease(m_anim);

    if (m_closing && m_anim <= 0.001f)
    {
        m_visible = false;
        m_closing = false;
        return;
    }

    void* bgTex = nullptr; int bgW = 0, bgH = 0; float bgU = 1.0f, bgV = 1.0f;
    void* btnTex = nullptr; int btnW = 0, btnH = 0; float btnU = 1.0f, btnV = 1.0f;
    InventoryTex::GetTest1Bg(&bgTex, &bgW, &bgH, &bgU, &bgV);
    InventoryTex::GetTest1Button(&btnTex, &btnW, &btnH, &btnU, &btnV);

    dl->AddRectFilled(ImVec2(0, 0), ImVec2(sw, sh), IM_COL32(0, 0, 0, (int)(135.0f * e)));

    ImVec2 smallMin(0.0f, 0.0f), smallMax(0.0f, 0.0f);
    DrawImage(m_items[0], bgTex, bgW, bgH, bgU, bgV, sw, sh, e, nullptr, nullptr);
    DrawImage(m_items[1], btnTex, btnW, btnH, btnU, btnV, sw, sh, e, &smallMin, &smallMax);

    ImVec2 mp = io.MousePos;
    bool down = io.MouseDown[0];
    bool clicked = down && !m_lastMouseDown;
    bool hitSmall = (mp.x >= smallMin.x && mp.x <= smallMax.x && mp.y >= smallMin.y && mp.y <= smallMax.y);
    if (clicked && hitSmall)
    {
        const char* playerName = nullptr;
        if (pNetGame && pNetGame->GetPlayerPool())
            playerName = pNetGame->GetPlayerPool()->GetLocalPlayerName();
        SaveAccepted(playerName);
        m_accepted = true;
        m_closing = true;
    }

    io.WantCaptureMouse = true;
    io.WantCaptureKeyboard = true;
    m_lastMouseDown = down;
}
