#pragma once

#include "../vendor/imgui/imgui.h"

class CTest3Overlay
{
public:
    CTest3Overlay();
    ~CTest3Overlay();

    void ShowEditor();
    void ShowFlightBox();
    void Render();
    bool IsVisible() const { return m_visible; }

private:
    enum Stage
    {
        STAGE_IDLE = 0,
        STAGE_DRAG,
        STAGE_INSERT,
        STAGE_CLOSE,
        STAGE_TOAST
    };

    struct Item
    {
        float x;
        float y;
        float scale;
    };

    void DrawImage(const Item& item, void* tex, int tw, int th, float tu, float tv,
                   float sw, float sh, float anim, ImVec2* outMin, ImVec2* outMax);
    bool Hit(const ImVec2& p, const ImVec2& mn, const ImVec2& mx) const;
    bool IsBoxOnTarget(const ImVec2& boxMin, const ImVec2& boxMax,
                       const ImVec2& targetMin, const ImVec2& targetMax) const;
    void PlayUiSound(int soundId);
    void SetHudFrozen(bool freeze);
    void DrawToast(float sw, float sh, float e);

    bool  m_visible;
    bool  m_lastMouseDown;
    bool  m_draggingBox;
    bool  m_dragSoundPlayed;
    bool  m_hudFrozen;
    bool  m_sendFinishCommand;
    bool  m_prevHud[7];
    Stage m_stage;
    float m_anim;
    float m_stageTime;
    float m_insertFromX;
    float m_insertFromY;
    float m_insertFromScale;
    ImVec2 m_dragOffset;
    Item  m_bg;
    Item  m_box;
};

extern CTest3Overlay* pTest3Overlay;
