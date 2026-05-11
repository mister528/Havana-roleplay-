#pragma once

#include <stdint.h>

// =====================================================================
// [HAVANA] POLICE HUD - small circular always-on HUD shown to on-duty
// LSPD/FBI players. Contains a single big handcuff button. Tapping it
// sends "/cuffnear" so the server can auto-cuff the closest wanted
// player within reach.
//
// Server protocol (reuses the standard SAMP DialogBox RPC):
//   ShowPlayerDialog(.., title="[!POLICE_HUD_ON]",  ..)              -> show
//   ShowPlayerDialog(.., title="[!POLICE_HUD_OFF]", ..)              -> hide
//   ShowPlayerDialog(.., title="[!POLICE_HUD_CFG]", body="X Y SIZE") -> set
//                       layout (position fractions 0..1, size 0.5..2.0)
//   ShowPlayerDialog(.., title="[!POLICE_HUD_EDIT]", body="X Y SIZE")-> edit
//                       mode (drag + size buttons + Save/Cancel)
// =====================================================================

class CPoliceHudOverlay
{
public:
    CPoliceHudOverlay();
    ~CPoliceHudOverlay() {}

    bool TryHandleDialog(uint16_t dialogId, uint8_t style,
                         const char* title, const char* body);

    void Render();
    void Hide() { m_bVisible = false; }
    bool IsVisible() const { return m_bVisible; }
    bool IsBlockingInput() const;

private:
    bool   m_bVisible;
    float  m_pulse;
    float  m_pressAnim;
    bool   m_lastMouseDown;

    // Persisted layout (proportions of screen + size multiplier).
    float  m_cfgX;        // 0..1 fraction of width  (default 0.96)
    float  m_cfgY;        // 0..1 fraction of height (default 0.42)
    float  m_cfgSize;     // 0.5..2.0 multiplier     (default 1.00)

    // Edit-mode state.
    bool   m_editMode;
    bool   m_dragging;
    float  m_savedX, m_savedY, m_savedSize; // snapshot for Cancel

    void RenderHud(float cx, float cy, float radius, float scale,
                   bool inEdit);
    void RenderEditChrome(float cx, float cy, float radius, float scale);
};

extern CPoliceHudOverlay* pPoliceHudOverlay;
