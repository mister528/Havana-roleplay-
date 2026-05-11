#pragma once

class CGreenZoneOverlay
{
public:
    CGreenZoneOverlay();
    ~CGreenZoneOverlay();

    void SetActive(bool active);
    void Render();

private:
    bool  m_active;
    float m_anim;
};

extern CGreenZoneOverlay* pGreenZoneOverlay;
