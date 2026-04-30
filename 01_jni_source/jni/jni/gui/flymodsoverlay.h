// =============================================================================
//  flymodsoverlay.h  -  HavanaRp /flymods cinematic admin camera (client side)
// -----------------------------------------------------------------------------
//  Server-side filterscript (flymods.pwn) validates that the player has
//  adminlevel >= 8 and then sends a prefixed ClientMessage:
//
//      "~FLYMODS~ON|<x>|<y>|<z>"   - enter cinematic camera mode
//      "~FLYMODS~OFF"              - exit cinematic camera mode
//      "~FLYMODS~POS|<x>|<y>|<z>|<lx>|<ly>|<lz>"   - per-tick camera update
//
//  netrpc.cpp::ClientMessage() intercepts this prefix, parses the payload, and
//  forwards to CFlyModsOverlay::ApplyServerCommand().
//
//  When active, the overlay:
//    * saves and clears every HUD element (chat, map, tags, buttons, hud, voice,
//      textlabels) so the screen is fully clean
//    * hides chat input and Java HUD/speed widgets
//    * drives the GTA SA camera matrix through CCamera::SetPosition each frame
//    * shows a single small "FLY MODE" indicator (top-right) plus a subtle
//      cinematic vignette so the admin always knows the mode is engaged
//
//  Exit conditions:
//    * server sends "~FLYMODS~OFF"
//    * /flymods is typed again locally (Hide() called from chatwindow.cpp)
//    * disconnect / pause (Hide() also called from main shutdown path)
// =============================================================================

#pragma once

#include <stdint.h>

class CFlyModsOverlay
{
public:
    CFlyModsOverlay();
    ~CFlyModsOverlay();

    // Activate cinematic camera mode at the given world position.
    // Saves the current HUD state so it can be restored on Hide().
    void Show(float fX, float fY, float fZ);

    // Deactivate and restore the previous HUD state.
    void Hide();

    // Update the camera position / look-at every frame from server.
    void UpdateCamera(float fX, float fY, float fZ,
                      float fLookX, float fLookY, float fLookZ);

    // Parse a "~FLYMODS~..." payload (without the prefix) and apply it.
    // szPayload format examples:
    //     "ON|1234.5|2345.6|10.0"
    //     "OFF"
    //     "POS|1234.5|2345.6|10.0|1240.0|2350.0|9.5"
    void ApplyServerCommand(const char* szPayload);

    // Render-time hook called from CGUI::Render() each frame.
    // Drives the camera + draws the cinematic indicator overlay.
    void Render();

    bool IsVisible() const { return m_bVisible; }

private:
    void SaveHudState();
    void RestoreHudState();
    void DriveCamera();

    bool      m_bVisible;
    bool      m_bSavedHud[7];      // index = HUD_ELEMENT_*
    bool      m_bSavedChatHidden;
    uint32_t  m_dwShownAt;         // ms tick when entered

    float     m_fCamX, m_fCamY, m_fCamZ;
    float     m_fLookX, m_fLookY, m_fLookZ;
    bool      m_bHaveLookAt;       // true if look-at has been set (vs SetPosition only)
    float     m_fYaw;              // current camera yaw in radians (client-side)
    uint32_t  m_dwLastTick;        // last tick we ran DriveCamera()
};

extern CFlyModsOverlay* pFlyModsOverlay;
