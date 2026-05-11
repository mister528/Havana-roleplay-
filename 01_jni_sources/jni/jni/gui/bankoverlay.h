#pragma once

#include <stdint.h>

// [BANK OVERLAY v11] Professional bank-style HUD triggered by server /bank command.
// Server sends a prefixed ClientMessage "~BANK_UI~<cash>|<bank>" which the launcher
// parses in netrpc.cpp and forwards to CBankOverlay::Show(cash, bank).

class CBankOverlay
{
public:
    CBankOverlay();
    ~CBankOverlay();

    // Activate the overlay with latest balances from server.
    void Show(int64_t cash, int64_t bank);

    // Hide overlay (also triggered by tapping close button).
    void Hide();

    // Called from CGUI::Render each frame between ImGui::NewFrame() and ImGui::Render().
    void Render();

    bool IsVisible() const { return m_bVisible; }

private:
    bool      m_bVisible;
    int64_t   m_iCash;
    int64_t   m_iBank;
    uint32_t  m_dwShownAt;   // ms time when shown; used for open animation
    float     m_fAnimT;      // 0..1 eased progress
};

extern CBankOverlay* pBankOverlay;
