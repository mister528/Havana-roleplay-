#pragma once
#include <stdint.h>

// =============================================================================
// Accessory Shop Overlay (NEW - 2026-05)
//
// Companion to CClothesShopOverlay.  Activated when the gamemode opens a
// sentinel dialog with title "[!ACC_SHOP_OPEN]" and body "<model_id>|<price>".
//
// The preview model is spawned server-side as a slowly-rotating
// CreateDynamicObject in front of the preview camera.  This overlay simply
// draws the UI:
//   ◄  (left)   - /accshop_left
//   ►  (right)  - /accshop_right
//   🔄 (rotate) - /accshop_rotate   (toggles auto-rotation on server)
//   شراء (buy)  - /accshop_buy
//   خروج (exit) - /accshop_exit
// =============================================================================

class CAccessoryShopOverlay
{
public:
    CAccessoryShopOverlay();
    ~CAccessoryShopOverlay();

    bool TryHandleDialog(uint16_t dialogId, uint8_t style,
                         const char* title, const char* body);
    void OnAnyDialog();
    void Hide();
    bool IsVisible() const { return m_bVisible; }
    void Render();

private:
    bool   m_bVisible;
    float  m_fAnimT;
    bool   m_prevDown;
    int    m_pressIdx;
    float  m_pressFlash;
    float  m_lastSendTick;

    int    m_currentModelId;
    int    m_currentPrice;
    char   m_szPrice[32];
};

extern CAccessoryShopOverlay* pAccessoryShopOverlay;
