#pragma once
#include <stdint.h>
#include <string>
#include <vector>

// 24/7 Shop overlay. Intercepts the "Shop 24/7" dialog sent by the
// gamemode and renders a big, market-style UI instead of the stock
// SA-MP list dialog. The overlay sends SendDialogResponse on tap so
// the server-side purchase flow proceeds as usual.

enum EShop247State
{
    SHOP247_NONE    = 0,
    SHOP247_ITEMS   = 1,
};

struct Shop247Item
{
    std::string name;       // e.g. "Mobile phone"
    std::string priceText;  // e.g. "$150"
    int         priceInt;   // parsed number (0 if parse failed)
    int         iconIdx;    // index into a small icon table (by name match)
};

class CShop247Overlay
{
public:
    CShop247Overlay();
    ~CShop247Overlay();

    bool TryHandleDialog(uint16_t dialogId, uint8_t style,
                         const char* title, const char* body);
    void Hide();
    bool IsVisible() const { return m_state != SHOP247_NONE; }
    void Render();

private:
    void ParseItems(const char* body);
    void SendPick(int listitem);

    EShop247State m_state;
    uint16_t      m_dialogId;
    std::vector<Shop247Item> m_items;

    float  m_fAnimT;
    float  m_fScroll;
    float  m_fScrollVelocity;

    // Touch/drag state (mirrors carrentoverlay.h)
    bool   m_bDragging;
    float  m_fDragStartY;
    float  m_fDragStartScroll;
    float  m_fLastTouchY;
    bool   m_bMovedSinceDown;
    float  m_fDownX;
    float  m_fDownY;
};

extern CShop247Overlay* pShop247Overlay;
