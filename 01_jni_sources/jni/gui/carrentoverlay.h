#pragma once
#include <stdint.h>
#include <string>
#include <vector>

// Car-Rental overlay. Intercepts the three dialog steps that
// arabonline.pwn sends for the rental flow and renders a big,
// professional UI instead of the stock SA-MP dialog.
//
//   State 0 (CARS)     : list of vehicles + hourly prices
//   State 1 (DURATIONS): list of durations + final prices
//   State 2 (CONFIRM)  : summary + Confirm / Back buttons
//
// On user action we call pNetGame->SendDialogResponse(dialogId,
// button, listitem, "") so the server-side flow proceeds normally.

enum ECarRentState
{
    CARRENT_NONE      = 0,
    CARRENT_CARS      = 1,
    CARRENT_PREVIEW   = 2,
    CARRENT_DURATIONS = 3,
    CARRENT_CONFIRM   = 4
};

struct CarRentItem
{
    std::string label;     // e.g. "Infernus" or "3 Hours"
    std::string priceText; // e.g. "$1000" or "$2700"
    int         priceInt;  // parsed numeric value (or 0)
};

class CCarRentOverlay
{
public:
    CCarRentOverlay();
    ~CCarRentOverlay();

    // Returns true if the dialog should be consumed (not shown as SAMP dialog).
    bool TryHandleDialog(uint16_t dialogId, uint8_t style,
                         const char* title, const char* body);

    void Hide();
    bool IsVisible() const { return m_state != CARRENT_NONE; }

    void Render();

private:
    void ParseItems(const char* body, bool hasHeader);
    void SetState(ECarRentState s, uint16_t dialogId, const char* title, const char* body);

    // Helpers
    void RenderCarsOrDurations(const char* headerText);
    void RenderConfirm();
    void SendPick(int listitem);
    void SendCancel();

    ECarRentState m_state;
    uint16_t      m_dialogId;
    std::string   m_title;
    std::string   m_subtitle;
    std::string   m_confirmBody;   // raw body for confirm screen
    std::vector<CarRentItem> m_items;

    float  m_fAnimT;
    float  m_fScroll;
    float  m_fScrollVelocity;
    int    m_hoverIdx;

    // Touch-drag scroll tracking
    bool   m_bDragging;
    float  m_fDragStartY;
    float  m_fDragStartScroll;
    float  m_fLastTouchY;
    bool   m_bMovedSinceDown;
    float  m_fDownY;
    float  m_fDownX;
};

extern CCarRentOverlay* pCarRentOverlay;
