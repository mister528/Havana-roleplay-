#pragma once

class CIslandToolsOverlay
{
public:
    CIslandToolsOverlay();
    void Show(int progress, const char* name);
    void Hide();
    void Render();
    bool IsVisible() const { return m_visible || m_closing; }
private:
    bool m_visible;
    bool m_closing;
    float m_anim;
    float m_closeAnim;
    int m_progress;
    char m_name[64];
};

extern CIslandToolsOverlay* pIslandToolsOverlay;
