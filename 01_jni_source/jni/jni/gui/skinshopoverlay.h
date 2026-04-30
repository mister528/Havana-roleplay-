#pragma once

#include <stdint.h>

// [SKIN SHOP OVERLAY] Replacement UI for the gamemode's clothes/skin shop.
//
// The HavanaRp gamemode (`arabonline.pwn`) drives the clothes shop with a
// cluster of native SAMP textdraws (price banner + ◄ SELECT ► EXIT). On
// Android these have very small hit areas and many builds of the launcher
// drop the click because the gamemode never marks them as Selectable. The
// player ends up unable to browse skins.
//
// This class sits between the SAMP textdraw pool and the user. Each frame
// we look at the currently-shown global textdraws; if the four shop
// buttons are present we:
//   1) hide the original textdraws (CTextDrawPool::Draw skips them while
//      we own them).
//   2) render a big, professional, ImGui-based panel with PREV / SELECT /
//      NEXT / EXIT buttons that are easy to tap.
//   3) on tap we forward the click to the server using the same RPC the
//      native touch path would have used (CGUI::PushToBufferedQueue
//      TextDrawPressed) so the gamemode flow proceeds untouched.
//
// The overlay shows the price (read from one of the captured textdraws if
// possible) and the current skin id (read from the local player ped) so
// the user knows what they are buying.

class CSkinShopOverlay
{
public:
    CSkinShopOverlay();
    ~CSkinShopOverlay();

    // Called every frame from CGUI::Render(). Detects the skin shop
    // textdraw cluster, draws the replacement UI, dispatches taps.
    void Render();

    bool IsVisible() const { return m_bVisible; }

    // Called from CTextDrawPool::Draw to suppress the original textdraws
    // while our overlay is active.
    bool IsTextdrawHidden(int td_id) const;

private:
    void DetectFromPool();
    void ResetCaptured();
    bool MatchSelect(const char* t) const;
    bool MatchExit(const char* t) const;
    bool MatchLeft(const char* t) const;
    bool MatchRight(const char* t) const;
    bool LooksLikePriceBanner(const char* t) const;

    void DrawButton(struct ImDrawList* dl, struct ImVec2 c, float w, float h,
                    unsigned col, unsigned colHov, unsigned colTxt,
                    const char* label, int touchId, int textdrawId,
                    bool primary);

    // Captured textdraw IDs (when -1, not yet found). After Render's scan
    // we know which IDs to dispatch on tap. m_pricePtId is for the
    // PlayerTextDraw price banner (if any).
    // Captured DECORATION (visible) ids — what we read text labels from.
    int m_prevId;
    int m_nextId;
    int m_buyId;
    int m_exitId;
    // Captured CLICK-AREA (selectable) ids — what we send to the server
    // when a button is tapped. These are the LD_SPAC:white invisible
    // overlays the gamemode places over each visible label.
    int m_prevClickId;
    int m_nextClickId;
    int m_buyClickId;
    int m_exitClickId;
    int m_priceTdId;
    int m_otherIds[24];   // any other shop chrome we want hidden
    int m_otherCount;

    bool  m_bVisible;
    float m_fAnimT;       // 0..1 ease-in
    float m_lastDispatchTime;
    int   m_lastDispatchTd;
    bool  m_btnWasDown[8];   // per-button rising-edge state

    // Cached label text for the price banner (e.g. "$405600")
    char  m_szPrice[32];
};

extern CSkinShopOverlay* pSkinShopOverlay;
