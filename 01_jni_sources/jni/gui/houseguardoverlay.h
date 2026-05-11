#pragma once

#include <stdint.h>

// [HOUSE GUARD OVERLAY v12] Skill minigame overlay used during the
// House Guard job. The server triggers the overlay by sending a
// DialogBox with the title "~HOUSEGUARD_UI~"; the body is a payload
// of the form  "<houseIdx>|<totalHouses>|<rewardPerHouse>".
//
// While the overlay is active the launcher renders a large circular
// dial with a sweeping arrow and a small green target arc on the
// rim. The player has to tap when the arrow is inside the green
// zone, five times, with at most two misses.  Speed and difficulty
// scale with the house index (1..5).
//
// When the round ends the overlay calls SendDialogResponse on the
// originating dialog:
//   button=1  -> house secured (reward + advance)
//   button=0  -> player gave up / exited
// All other UX (hits, misses, retries) is handled locally so a
// single dialog round-trip per house is enough.

class CHouseGuardOverlay
{
public:
    CHouseGuardOverlay();
    ~CHouseGuardOverlay();

    // Inspect a freshly received DialogBox RPC. If the title matches
    // the houseguard prefix, the overlay starts and we return true so
    // the caller suppresses the regular dialog.
    bool TryHandleDialog(uint16_t dialogId, uint8_t style,
                         const char* title, const char* body);

    // Hide the overlay without sending any dialog response.
    void Hide();

    // Called from CGUI::Render every frame.
    void Render();

    bool IsVisible() const { return m_bVisible; }

private:
    // Called when player completed all required hits.
    void FinishSuccess();
    // Called when player taps the "Give up" button.
    void Cancel();
    // Reset attempt-local state for the current house (hits=0, misses=0).
    void ResetAttempt();
    // Pick a fresh random green-arc position for the next hit.
    void NewTarget();

    // Speed (radians per second) and arc width (radians) for house 1..5.
    float SpeedForHouse(int idx) const;
    float ArcForHouse(int idx) const;

    bool      m_bVisible;
    uint16_t  m_dialogId;
    int       m_houseIdx;        // 1-based
    int       m_totalHouses;
    int       m_reward;

    // Current attempt state
    int       m_hits;            // 0..5
    int       m_misses;          // 0..2 (reset to 0 on retry)
    static const int kRequiredHits = 5;
    static const int kMaxMisses = 2;

    // Animation state for the rotating arrow.
    float     m_angle;           // current arrow angle in radians (0..2pi)
    float     m_targetCenter;    // current green arc center angle
    float     m_targetHalfArc;   // half-width of the arc, radians

    // Feedback animations
    float     m_flashHit;        // 0..1, decays to 0 (green flash)
    float     m_flashMiss;       // 0..1, decays to 0 (red flash)

    // Press edge detection
    bool      m_lastMouseDown;

    // Outcome screens
    enum Phase { PHASE_PLAY, PHASE_RETRY, PHASE_SUCCESS };
    Phase     m_phase;
    float     m_phaseT;          // time spent in current overlay-overlay phase

    // Open animation
    float     m_openT;
};

extern CHouseGuardOverlay* pHouseGuardOverlay;
