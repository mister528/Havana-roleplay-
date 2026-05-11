#pragma once

#include <stdint.h>

// [WEAPON CRAFT OVERLAY] Professional weapon-crafting HUD triggered by the
// craft-table pickup inside upgraded houses (improve_craftgun, 1.5M).
//
// Server (arabonline.pwn) drives the overlay through prefixed ClientMessage
// payloads parsed in netrpc.cpp:
//   "~CRAFT_UI~OPEN|<spring>|<iron>|<scrap>|<gunpowder>|<wood>"
//   "~CRAFT_UI~PROG|<percent>"
//   "~CRAFT_UI~DONE"
//   "~CRAFT_UI~HIDE"
// On success the launcher fires:
//   /craft_pick <weaponid>   when the player taps a weapon entry
//   /craft_done <weaponid>   when the border-trace minigame is solved
//   /craft_close             when the player closes the overlay manually

class CWeaponCraftOverlay
{
public:
    enum Mode
    {
        MODE_HIDDEN   = 0,
        MODE_LIST     = 1,
        MODE_TRACE    = 2,
        MODE_PROGRESS = 3,
        MODE_DONE     = 4
    };

    CWeaponCraftOverlay();
    ~CWeaponCraftOverlay();

    void ShowList(int spring, int iron, int scrap, int gunpowder, int wood);
    void ShowProgress(int percent);
    void ShowDone();
    void Hide();

    void Render();
    bool IsVisible() const { return m_mode != MODE_HIDDEN; }

private:
    void RenderBackdrop(struct ImDrawList* dl, float w, float h, float t);
    void RenderList();
    void RenderTrace();
    void RenderProgress();
    void RenderDone();

    void StartTrace(int weaponId);
    void RegisterMistake();
    void OnTraceCompleted();

    void SendCommand(const char* cmd);

    Mode  m_mode;
    float m_anim;
    float m_closeAnim;

    // Latest material counts received from server (~CRAFT_UI~OPEN payload).
    int   m_spring;
    int   m_iron;
    int   m_scrap;
    int   m_gunpowder;
    int   m_wood;

    // Selected weapon (server-side weapon id).
    int   m_selectedWeapon;

    // Border-trace minigame state.
    int   m_currentSeg;
    float m_progress;        // 0..1 along the current segment
    int   m_mistakes;
    int   m_maxMistakes;
    bool  m_lastDown;
    float m_mistakeCooldown;
    float m_mistakeFlash;
    float m_walkPhase;
    float m_lastFingerX;
    float m_lastFingerY;

    // Crafting progress overlay.
    int   m_progressPct;
    float m_progressShownT;
    float m_progressLastUpdateT;   // seconds since last PROG/DONE message
    float m_progressDisplayPct;    // smoothed progress for animation
    float m_doneTimer;             // auto-hide MODE_DONE after N seconds
    float m_doneCelebrate;         // celebration animation phase

    // Transient status messages.
    float m_statusTimer;
    char  m_statusText[256];
};

extern CWeaponCraftOverlay* pWeaponCraftOverlay;
