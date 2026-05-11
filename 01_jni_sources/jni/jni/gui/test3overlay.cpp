#include "../main.h"
#include "../game/game.h"
#include "test3overlay.h"
#include "inventorytex.h"
#include "../arabic.h"
#include "../vendor/imgui/imgui.h"
#include "../vendor/imgui/imgui_internal.h"

#include <math.h>
#include <stdio.h>
#include <string>

CTest3Overlay* pTest3Overlay = nullptr;
extern CGame* pGame;
extern void Inventory_SendChatCommand(const char* cmd);

static float T3Clamp(float v, float lo, float hi)
{
    if (v < lo) return lo;
    if (v > hi) return hi;
    return v;
}

static float T3EaseOut(float v)
{
    v = T3Clamp(v, 0.0f, 1.0f);
    return 1.0f - (1.0f - v) * (1.0f - v) * (1.0f - v);
}

static float T3EaseInOut(float v)
{
    v = T3Clamp(v, 0.0f, 1.0f);
    return v < 0.5f ? 4.0f * v * v * v : 1.0f - powf(-2.0f * v + 2.0f, 3.0f) * 0.5f;
}

CTest3Overlay::CTest3Overlay()
    : m_visible(false)
    , m_lastMouseDown(false)
    , m_draggingBox(false)
    , m_dragSoundPlayed(false)
    , m_hudFrozen(false)
    , m_sendFinishCommand(false)
    , m_stage(STAGE_DRAG)
    , m_anim(0.0f)
    , m_stageTime(0.0f)
    , m_insertFromX(0.0f)
    , m_insertFromY(0.0f)
    , m_insertFromScale(1.0f)
    , m_dragOffset(0.0f, 0.0f)
{
    m_bg.x = 0.496819f;
    m_bg.y = 0.502778f;
    m_bg.scale = 2.199999f;
    m_box.x = 0.177481f;
    m_box.y = 0.736111f;
    m_box.scale = 0.550000f;
    for (int i = 0; i < 7; ++i) m_prevHud[i] = true;
}

CTest3Overlay::~CTest3Overlay() {}

void CTest3Overlay::ShowEditor()
{
    ShowFlightBox();
    m_sendFinishCommand = false;
}

void CTest3Overlay::ShowFlightBox()
{
    m_sendFinishCommand = true;
    m_visible = true;
    m_lastMouseDown = false;
    m_draggingBox = false;
    m_dragSoundPlayed = false;
    m_stage = STAGE_DRAG;
    m_anim = 0.0f;
    m_stageTime = 0.0f;
    m_bg.x = 0.496819f;
    m_bg.y = 0.502778f;
    m_bg.scale = 2.199999f;
    m_box.x = 0.177481f;
    m_box.y = 0.736111f;
    m_box.scale = 0.550000f;
    SetHudFrozen(true);
}

bool CTest3Overlay::Hit(const ImVec2& p, const ImVec2& mn, const ImVec2& mx) const
{
    return p.x >= mn.x && p.x <= mx.x && p.y >= mn.y && p.y <= mx.y;
}

bool CTest3Overlay::IsBoxOnTarget(const ImVec2& boxMin, const ImVec2& boxMax,
                                  const ImVec2& targetMin, const ImVec2& targetMax) const
{
    float cx = (boxMin.x + boxMax.x) * 0.5f;
    float cy = (boxMin.y + boxMax.y) * 0.5f;
    return cx >= targetMin.x && cx <= targetMax.x && cy >= targetMin.y && cy <= targetMax.y;
}

void CTest3Overlay::PlayUiSound(int soundId)
{
    if (!pGame) return;
    CPlayerPed* ped = pGame->FindPlayerPed();
    if (!ped) return;
    MATRIX4X4 mat;
    ped->GetMatrix(&mat);
    pGame->PlaySound(soundId, mat.pos.X, mat.pos.Y, mat.pos.Z);
}

void CTest3Overlay::SetHudFrozen(bool freeze)
{
    if (!pGame) return;
    if (freeze)
    {
        if (m_hudFrozen) return;
        for (int i = 0; i < 7; ++i)
            m_prevHud[i] = pGame->IsToggledHUDElement(i);
        pGame->ToggleHUDElement(HUD_ELEMENT_CHAT, false);
        pGame->ToggleHUDElement(HUD_ELEMENT_MAP, false);
        pGame->ToggleHUDElement(HUD_ELEMENT_TAGS, false);
        pGame->ToggleHUDElement(HUD_ELEMENT_BUTTONS, false);
        pGame->ToggleHUDElement(HUD_ELEMENT_HUD, false);
        pGame->ToggleHUDElement(HUD_ELEMENT_VOICE, false);
        pGame->ToggleHUDElement(HUD_ELEMENT_TEXTLABELS, false);
        pGame->HandleChangedHUDStatus();
        m_hudFrozen = true;
    }
    else
    {
        if (!m_hudFrozen) return;
        for (int i = 0; i < 7; ++i)
            pGame->ToggleHUDElement(i, m_prevHud[i]);
        pGame->HandleChangedHUDStatus();
        m_hudFrozen = false;
    }
}

void CTest3Overlay::DrawImage(const Item& item, void* tex, int tw, int th, float tu, float tv,
                              float sw, float sh, float anim, ImVec2* outMin, ImVec2* outMax)
{
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    if (!dl || !tex) return;

    float baseW = (tw >= th ? 720.0f : 360.0f) * (sh / 720.0f);
    float w = baseW * item.scale * (0.94f + 0.06f * anim);
    float h = w * ((tw > 0 && th > 0) ? ((float)th / (float)tw) : 1.0f);
    float x = sw * item.x - w * 0.5f;
    float y = sh * item.y - h * 0.5f + (1.0f - anim) * 36.0f;
    int alpha = (int)(255.0f * anim);
    dl->AddImage((ImTextureID)tex, ImVec2(x, y), ImVec2(x + w, y + h), ImVec2(0, 0), ImVec2(tu, tv), IM_COL32(255, 255, 255, alpha));
    if (outMin) *outMin = ImVec2(x, y);
    if (outMax) *outMax = ImVec2(x + w, y + h);
}

void CTest3Overlay::DrawToast(float sw, float sh, float e)
{
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    if (!dl) return;

    std::string msg = Arabic::Shape("تم وضع الصندوق");
    ImVec2 textSize = ImGui::CalcTextSize(msg.c_str());
    float w = textSize.x + 72.0f;
    float h = 72.0f;
    float x = (sw - w) * 0.5f;
    float y = sh - 122.0f + (1.0f - e) * 125.0f;
    ImVec2 mn(x, y), mx(x + w, y + h);
    dl->AddRectFilled(ImVec2(x + 8.0f, y + 10.0f), ImVec2(x + w + 8.0f, y + h + 10.0f), IM_COL32(0, 0, 0, (int)(95.0f * e)), 24.0f);
    dl->AddRectFilled(mn, mx, IM_COL32(12, 22, 17, (int)(242.0f * e)), 24.0f);
    dl->AddRectFilled(ImVec2(x + 2.0f, y + 2.0f), ImVec2(x + w - 2.0f, y + h * 0.52f), IM_COL32(36, 58, 42, (int)(105.0f * e)), 22.0f);
    dl->AddRect(mn, mx, IM_COL32(255, 218, 120, (int)(215.0f * e)), 24.0f, 0, 2.2f);
    ImVec2 ic(x + 40.0f, y + h * 0.5f);
    dl->AddCircleFilled(ic, 21.0f, IM_COL32(38, 145, 75, (int)(255.0f * e)), 32);
    dl->AddCircle(ic, 21.0f, IM_COL32(255, 238, 160, (int)(230.0f * e)), 32, 2.0f);
    dl->AddLine(ImVec2(ic.x - 8.0f, ic.y), ImVec2(ic.x - 2.0f, ic.y + 7.0f), IM_COL32(255, 255, 255, (int)(255.0f * e)), 3.2f);
    dl->AddLine(ImVec2(ic.x - 2.0f, ic.y + 7.0f), ImVec2(ic.x + 11.0f, ic.y - 8.0f), IM_COL32(255, 255, 255, (int)(255.0f * e)), 3.2f);
    dl->AddText(ImVec2(x + 64.0f, y + (h - textSize.y) * 0.5f), IM_COL32(255, 245, 220, (int)(255.0f * e)), msg.c_str());
}

void CTest3Overlay::Render()
{
    if (!m_visible) return;
    SetHudFrozen(true);

    ImGuiIO& io = ImGui::GetIO();
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    if (!dl) return;

    float sw = io.DisplaySize.x;
    float sh = io.DisplaySize.y;
    float dt = io.DeltaTime > 0.0f ? io.DeltaTime : 0.016f;
    m_stageTime += dt;
    m_anim = T3Clamp(m_anim + dt * 4.5f, 0.0f, 1.0f);

    void* bgTex = nullptr; int bgW = 0, bgH = 0; float bgU = 1.0f, bgV = 1.0f;
    void* boxTex = nullptr; int boxW = 0, boxH = 0; float boxU = 1.0f, boxV = 1.0f;
    InventoryTex::GetTest3Bg(&bgTex, &bgW, &bgH, &bgU, &bgV);
    InventoryTex::GetTest3Box(&boxTex, &boxW, &boxH, &boxU, &boxV);

    Item targetBox;
    targetBox.x = 0.720000f;
    targetBox.y = 0.690000f;
    targetBox.scale = 0.440000f;

    ImVec2 targetMin(0, 0), targetMax(0, 0), bgMin(0, 0), bgMax(0, 0), boxMin(0, 0), boxMax(0, 0);
    float screenAlpha = 1.0f;
    if (m_stage == STAGE_INSERT)
    {
        float t = T3EaseInOut(m_stageTime / 0.82f);
        m_box.x = m_insertFromX + (targetBox.x - m_insertFromX) * t;
        m_box.y = m_insertFromY + (targetBox.y - m_insertFromY) * t;
        m_box.scale = m_insertFromScale + (targetBox.scale - m_insertFromScale) * t;
        if (m_stageTime >= 0.82f)
        {
            m_stage = STAGE_CLOSE;
            m_stageTime = 0.0f;
            PlayUiSound(1057);
        }
    }
    else if (m_stage == STAGE_CLOSE)
    {
        screenAlpha = 1.0f - T3EaseInOut(m_stageTime / 0.95f);
        if (m_stageTime >= 0.95f)
        {
            m_stage = STAGE_TOAST;
            m_stageTime = 0.0f;
            PlayUiSound(1058);
        }
    }

    float e = T3EaseOut(m_anim) * screenAlpha;
    if (m_stage != STAGE_TOAST)
    {
        dl->AddRectFilled(ImVec2(0, 0), ImVec2(sw, sh), IM_COL32(0, 0, 0, (int)(80.0f * e)));
        DrawImage(m_bg, bgTex, bgW, bgH, bgU, bgV, sw, sh, e, &bgMin, &bgMax);
        DrawImage(targetBox, boxTex, boxW, boxH, boxU, boxV, sw, sh, 0.18f * e, &targetMin, &targetMax);
        if (e > 0.01f && m_stage == STAGE_CLOSE)
            dl->AddRectFilled(ImVec2(0, 0), ImVec2(sw, sh), IM_COL32(255, 240, 165, (int)(52.0f * (1.0f - screenAlpha))));
        DrawImage(m_box, boxTex, boxW, boxH, boxU, boxV, sw, sh, e, &boxMin, &boxMax);
    }

    ImVec2 mp = io.MousePos;
    bool down = io.MouseDown[0];
    bool clicked = down && !m_lastMouseDown;

    if (m_stage == STAGE_DRAG)
    {
        if (clicked && Hit(mp, boxMin, boxMax))
        {
            m_draggingBox = true;
            m_dragOffset = ImVec2(mp.x - sw * m_box.x, mp.y - sh * m_box.y);
            if (!m_dragSoundPlayed)
            {
                PlayUiSound(1052);
                m_dragSoundPlayed = true;
            }
        }
        if (down && m_draggingBox)
        {
            m_box.x = T3Clamp((mp.x - m_dragOffset.x) / sw, -0.50f, 1.50f);
            m_box.y = T3Clamp((mp.y - m_dragOffset.y) / sh, -0.50f, 1.50f);
        }
        if (!down && m_draggingBox)
        {
            m_draggingBox = false;
            m_dragSoundPlayed = false;
            if (IsBoxOnTarget(boxMin, boxMax, targetMin, targetMax))
            {
                m_stage = STAGE_INSERT;
                m_stageTime = 0.0f;
                m_insertFromX = m_box.x;
                m_insertFromY = m_box.y;
                m_insertFromScale = m_box.scale;
                PlayUiSound(1053);
            }
        }
    }

    if (m_stage == STAGE_TOAST)
    {
        float toastE = 1.0f;
        if (m_stageTime < 0.45f) toastE = T3EaseOut(m_stageTime / 0.45f);
        else if (m_stageTime > 3.00f) toastE = 1.0f - T3EaseInOut((m_stageTime - 3.00f) / 0.55f);
        DrawToast(sw, sh, T3Clamp(toastE, 0.0f, 1.0f));
        if (m_stageTime > 3.55f)
        {
            m_stage = STAGE_DRAG;
            m_visible = false;
            SetHudFrozen(false);
            if (m_sendFinishCommand)
            {
                m_sendFinishCommand = false;
                Inventory_SendChatCommand("/flightboxdone");
            }
        }
    }

    io.WantCaptureMouse = true;
    io.WantCaptureKeyboard = true;
    m_lastMouseDown = down;
}
