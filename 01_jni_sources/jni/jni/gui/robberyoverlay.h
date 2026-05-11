#pragma once

#include <stdint.h>

// =====================================================================
// [HAVANA] 24/7 STORE ROBBERY — 5-pin lockpick overlay.
//
// The server raises this overlay by sending a DialogBox RPC with the
// title "[!ROB247_OPEN]". The body holds a difficulty hint (currently
// "5" for five pins). The overlay replies with SendDialogResponse:
//
//   button = 1, inputtext = "<score 0..100>"  on success
//   button = 0, inputtext = ""                on cancel / fail
//
// Each of the 5 pins has a horizontal indicator that bounces up and
// down inside a vertical channel. A small "sweet zone" band is set
// at a random height per pin, and gets narrower as the player advances
// through the pins. The player taps a column (or the big PICK button)
// when the indicator is inside the sweet zone.
// =====================================================================

class CRobberyOverlay
{
public:
    CRobberyOverlay();
    ~CRobberyOverlay();

    bool TryHandleDialog(uint16_t dialogId, uint8_t style,
                         const char* title, const char* body);

    // Hide the overlay without sending any dialog response.
    void Hide();

    // Called from CGUI::Render every frame.
    void Render();

    bool IsVisible() const { return m_bVisible; }
    bool IsProgressMode() const { return m_progressMode; }

private:
    enum { kPins = 5, kMaxMisses = 10 };

    void Begin(uint16_t dialogId, int totalPins);
    void BeginProgress(uint16_t dialogId, int durationMs);
    void NewPin(int idx);
    void TryPick();        // attempt to pick the current pin
    void Cancel();         // user pressed cancel
    void FinishSuccess();  // last pin done
    void RenderLockpick(); // 5-pin minigame screen
    void RenderProgress(); // post-success robbery progress screen

    bool      m_bVisible;
    bool      m_progressMode; // true while playing post-success progress bar
    uint16_t  m_dialogId;
    int       m_totalPins;
    int       m_currentPin;
    int       m_misses;
    int       m_progStartMs;  // platform tick at start of progress
    int       m_progDurationMs;

    // Per-pin sweet-zone center (0..1, top->bottom of channel).
    float     m_pinTarget   [kPins];
    float     m_pinHalfArc  [kPins];   // half-height of the sweet zone
    float     m_pinSpeed    [kPins];   // cycles/sec of indicator
    float     m_pinPhase    [kPins];   // current phase
    bool      m_pinLocked   [kPins];
    float     m_pinAccuracy [kPins];   // 0..1, 1 = perfect

    float     m_flashHit;              // per-pin success flash 0..1
    float     m_flashMiss;             // per-pin miss flash    0..1
    float     m_openT;                 // overlay-open animation 0..1
    float     m_closeT;                // overlay-close animation
    bool      m_closing;

    bool      m_lastMouseDown;
    int       m_pressedColumn;         // -1 if none
};

extern CRobberyOverlay* pRobberyOverlay;
