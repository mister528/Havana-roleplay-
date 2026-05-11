#pragma once
#include <stdint.h>

// =============================================================================
// Car Shop Overlay
//
// Activated by sentinel dialog title "[!CARSHOP_OPEN]" with body
//     "<model>|<price>|<rot>|<category_name>"
// and dismissed by "[!CARSHOP_CLOSE]".
// =============================================================================

class CCarShopOverlay
{
public:
    CCarShopOverlay();
    ~CCarShopOverlay();

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
    float  m_lastSendTick;

    // Palette mode (shows colour swatches instead of main buttons).
    bool   m_paletteOpen;

    // Eye-toggle: when true, all overlay UI is collapsed except the eye icon.
    bool   m_bHidden;

    int    m_currentModel;
    int    m_currentPrice;
    int    m_rotStep;
    char   m_szCat[32];
    char   m_szPrice[32];
};

extern CCarShopOverlay* pCarShopOverlay;
