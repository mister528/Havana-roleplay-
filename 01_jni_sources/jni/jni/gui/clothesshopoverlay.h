#pragma once
#include <stdint.h>

// =============================================================================
// Clothes Shop Overlay (NEW - 2026-04)
//
// Replaces the legacy `td_skinshop[19]`-based clothes purchase UI.
// Activates when the gamemode opens a sentinel dialog with the title
// "[!CLOTHES_SHOP_OPEN]" and a body string of the form "<skin_id>|<price>".
//
// While active the overlay paints a polished, fully-Arabic UI:
//   ◄ (left arrow)   - sends /clshop_left
//   ► (right arrow)  - sends /clshop_right
//   شراء (buy)       - sends /clshop_buy
//   خروج (exit)      - sends /clshop_exit
//
// The price banner reads its number from the dialog body so the gamemode
// can refresh it by re-issuing the sentinel after each skin change.
//
// The sentinel dialog itself is auto-dismissed server-side via
// CarRent_SendDialogResponse(id, 0, 0, "") so p_dialog clears.
// =============================================================================

class CClothesShopOverlay
{
public:
    CClothesShopOverlay();
    ~CClothesShopOverlay();

    // Returns true if the dialog was the clothes-shop sentinel and was
    // consumed by this overlay.
    bool TryHandleDialog(uint16_t dialogId, uint8_t style,
                         const char* title, const char* body);

    // Any other dialog dismisses the overlay.
    void OnAnyDialog();

    void Hide();
    bool IsVisible() const { return m_bVisible; }

    void Render();

private:
    bool   m_bVisible;
    float  m_fAnimT;
    bool   m_prevDown;
    int    m_pressIdx;     // 0=left,1=right,2=buy,3=exit, -1=none
    float  m_pressFlash;
    float  m_lastSendTick;

    int    m_currentSkinId;
    int    m_currentPrice;
    char   m_szPrice[32];
};

extern CClothesShopOverlay* pClothesShopOverlay;
