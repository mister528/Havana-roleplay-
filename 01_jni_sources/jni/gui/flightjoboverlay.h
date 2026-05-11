#pragma once

#include <stdint.h>

class CFlightJobOverlay
{
public:
    CFlightJobOverlay();
    ~CFlightJobOverlay();

    bool TryHandleDialog(uint16_t dialogId, uint8_t style, const char* title, const char* body);
    void Render();
    bool IsVisible() const { return m_visible; }

private:
    enum Page
    {
        PAGE_HOME = 0,
        PAGE_STATS
    };

    struct Rect
    {
        float x1;
        float y1;
        float x2;
        float y2;
    };

    bool Hit(float x, float y, const Rect& r) const;
    bool Button(const Rect& r, const char* text, unsigned int bg, unsigned int border, unsigned int textColor);
    void SendResponse(uint8_t button, uint16_t listitem);
    void DrawHome(float sw, float sh);
    void DrawStats(float sw, float sh);
    void DrawProgressBar(float x, float y, float w, float h, float value);
    void ParsePayload(const char* body);
    void PlaySound(int soundId);

    bool m_visible;
    bool m_lastDown;
    Page m_page;
    uint16_t m_dialogId;
    float m_anim;
    int m_level;
    int m_boxes;
    int m_reward;
    int m_toNext;
};

extern CFlightJobOverlay* pFlightJobOverlay;
