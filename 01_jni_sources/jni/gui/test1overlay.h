#pragma once

#include "../vendor/imgui/imgui.h"

class CTest1Overlay
{
public:
    CTest1Overlay();
    ~CTest1Overlay();

    void Render();
    bool IsVisible() const { return m_visible; }

private:
    struct Item
    {
        float x;
        float y;
        float scale;
    };

    void DrawImage(const Item& item, void* tex, int tw, int th, float tu, float tv,
                   float sw, float sh, float anim, ImVec2* outMin, ImVec2* outMax);
    bool ShouldAutoShow();
    bool WasAccepted(const char* name);
    void SaveAccepted(const char* name);

    bool  m_visible;
    bool  m_closing;
    bool  m_shownThisJoin;
    bool  m_wasConnected;
    bool  m_accepted;
    bool  m_lastMouseDown;
    float m_anim;
    Item  m_items[2];
};

extern CTest1Overlay* pTest1Overlay;
