#pragma once

// [BRAND OVERLAY v1] HavanaRp — bottom-left server branding HUD.
//
// A non-interactive watermark drawn every frame on the ImGui overlay
// draw list. Renders a circular "HR" badge welded to a green gradient
// banner with a swooped right edge that reads "HAVANA RP". Inspired
// by the Texas-RP corner branding, restyled to the Havana palette.
//
// Lives bottom-left of the screen, hides automatically while the
// scoreboard is open, while a dialog has focus, or when the player
// has toggled the SAMP HUD off (same rule as the existing sidebar
// key strip).

class CBrandOverlay
{
public:
    CBrandOverlay();
    ~CBrandOverlay();

    void Render();

private:
    void RenderLogo(float sw, float sh);
    float m_x;
    float m_y;
    float m_scale;
};

extern CBrandOverlay* pBrandOverlay;
