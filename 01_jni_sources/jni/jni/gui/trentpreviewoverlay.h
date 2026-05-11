#pragma once
#include <stdint.h>

// Trent Preview overlay. Activates when the gamemode sends a sentinel
// dialog with title "[!TRENT_PREVIEW_OPEN]" while the camera is parked
// over the showroom car. The overlay paints three large floating
// buttons (left / right rotation + exit) and forwards each tap as a
// chat command:
//      /tprev_left  (rotate camera 90° counter-clockwise)
//      /tprev_right (rotate camera 90° clockwise)
//      /tprev_exit  (close preview, restore player camera)

class CTrentPreviewOverlay
{
public:
    CTrentPreviewOverlay();
    ~CTrentPreviewOverlay();

    // Sentinel dialog interception. Returns true if consumed.
    bool TryHandleDialog(uint16_t dialogId, uint8_t style,
                         const char* title, const char* body);

    // Called whenever a *different* dialog arrives so the overlay can
    // dismiss itself in case the rental flow returns to a normal dialog
    // (e.g. the duration list after auto-return).
    void OnAnyDialog();

    void Hide();
    bool IsVisible() const { return m_bVisible; }

    void Render();

private:
    bool   m_bVisible;
    float  m_fAnimT;
    bool   m_prevDown;
    int    m_pressIdx;     // 0=left,1=right,2=exit, -1=none
    float  m_pressFlash;   // visual feedback timer for last press
    float  m_lastSendTick; // throttle to avoid double-fires on noisy taps
};

extern CTrentPreviewOverlay* pTrentPreviewOverlay;
