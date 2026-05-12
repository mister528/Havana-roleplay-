#pragma once
#include <stdint.h>
#include <string>
#include <vector>

// =============================================================================
//  HavanaRp — Fisherman Job Overlay
//  ---------------------------------------------------------------------------
//  Pairs with server-side filterscript fisherman.pwn. Intercepts a family of
//  ShowPlayerDialog() calls that use magic titles "HAVANA_FISH_*" and renders
//  a big, polished UI instead of SA-MP's stock dialog. Replies are delivered
//  back with SendDialogResponse() so the server-side flow is unchanged.
//
//  States (title -> state):
//    HAVANA_FISH_SHOP    -> FISH_SHOP     (main shop menu, laptop/marina)
//    HAVANA_FISH_LIC     -> FISH_LIC      (pick license duration)
//    HAVANA_FISH_BAIT    -> FISH_BAIT     (pick bait quantity)
//    HAVANA_FISH_ROD     -> FISH_ROD      (confirm rod purchase)
//    HAVANA_FISH_BOAT    -> FISH_BOAT     (confirm boat rental)
//    HAVANA_FISH_CAST    -> FISH_CAST     (underwater minigame / cast button)
//    HAVANA_FISH_RESULT  -> FISH_RESULT   (popup with caught fish or miss)
//    HAVANA_FISH_STATS   -> FISH_STATS    (end-of-job summary)
//    HAVANA_FISH_MSG     -> FISH_MSG      (generic info box)
// =============================================================================

enum EFishState
{
    FISH_NONE   = 0,
    FISH_SHOP   = 1,
    FISH_LIC    = 2,
    FISH_BAIT   = 3,
    FISH_ROD    = 4,
    FISH_BOAT   = 5,
    FISH_CAST   = 6,
    FISH_RESULT = 7,
    FISH_STATS  = 8,
    FISH_MSG    = 9,
    FISH_HUD    = 10,  // small on-screen CAST button when player is in the zone
    FISH_REEL   = 11   // local tap-to-fill mini-game, fired before the cast
};

struct FishLicenseOpt  { int days; int price; };
struct FishStatRow     { std::string name; float weight; int price; int rare; };

class CFishermanOverlay
{
public:
    CFishermanOverlay();
    ~CFishermanOverlay();

    // Intercept a fresh DialogBox RPC. Returns true if consumed.
    bool TryHandleDialog(uint16_t dialogId, uint8_t style,
                         const char* title, const char* body);

    void Hide();
    bool IsVisible() const { return m_state != FISH_NONE; }
    void Render();

private:
    // State routing
    void SetState(EFishState s, uint16_t dialogId,
                  const char* title, const char* body);

    // Reply helpers
    void SendPick(int listitem);
    void SendOk();
    void SendCancel();
    void SendInput(const char* text);

    // Per-state renderers
    void RenderShop();
    void RenderLicense();
    void RenderBait();
    void RenderRod();
    void RenderBoat();
    void RenderCast();
    void RenderResult();
    void RenderStats();
    void RenderMessage();
    void RenderHud();
    void RenderReel();        // tap-to-fill power meter before cast
    void StartReelMinigame(); // switch from HUD -> REEL

    // Shared widgets
    bool BigButton(const char* label, float x, float y, float w, float h,
                   unsigned col, unsigned colHover);
    void TitleStrip(const char* title, const char* subtitle,
                    float x, float y, float w);
    void UnderwaterBackdrop(float x, float y, float w, float h, float t);
    // Polished outer chrome shared by License/Bait/Rod/Boat sub-dialogs:
    // drop shadow, dark bezel, marine gradient, scanlines, brand pill,
    // optional money chip, and a subtle marina wave at the bottom.
    void DrawPanelFrame(float x, float y, float w, float h,
                        const char* brand, const char* subtitle,
                        bool showMoneyChip);

    // State
    EFishState  m_state;
    uint16_t    m_dialogId;
    float       m_animT;      // 0..1 panel fade-in

    // Shop
    int         m_shopHasLic;
    int         m_shopDaysLeft;
    int         m_shopBait;
    int         m_shopHasRod;
    int         m_shopWorking;
    int         m_shopMoney;

    // License opts
    std::vector<FishLicenseOpt> m_licOpts;

    // Bait input
    int         m_baitQty;
    int         m_baitUnitPrice;
    int         m_baitMaxQty;

    // Rod
    int         m_rodPrice;

    // Boat
    int         m_boatPrice;

    // Cast
    int         m_castBait;
    int         m_castBag;
    int         m_castMoney;
    int         m_castInZone;
    int         m_castOnBoat;
    float       m_waterAnim;   // continuous water animation time
    std::vector<float> m_fishSwimX;  // decorative fish positions
    std::vector<float> m_fishSwimY;
    std::vector<float> m_fishSwimVX;
    int                m_fishSwimInit;

    // Result
    int         m_rsIsCatch;   // 1=catch, 0=miss
    std::string m_rsName;
    float       m_rsWeight;
    int         m_rsPrice;
    int         m_rsRare;
    int         m_rsBaitLeft;
    int         m_rsBagCount;
    float       m_rsShowT;     // animation progress

    // Stats
    std::vector<FishStatRow> m_stRows;
    int         m_stTotalCount;
    int         m_stTotalPrice;
    float       m_stTotalWeight;

    // Generic message
    std::string m_msg;

    // Reel / tap-to-fill mini-game (runs purely on the client; once the
    // meter hits 100 we forward SendPick(1) to the server so the real
    // casting animation + resolve happens exactly as before).
    float       m_reelFill;       // 0..100
    float       m_reelDecayRate;  // how many % per frame drains when idle
    float       m_reelPerTap;     // how many % per tap
    float       m_reelLastFrame;  // timing
    uint16_t    m_reelDialogId;   // dialog id to answer when meter fills
    bool        m_reelPressed;    // last-frame mouse-down state (edge detect)
    int         m_reelTaps;       // stats
    float       m_reelStartT;     // start time
};

extern CFishermanOverlay* pFishermanOverlay;

// Used by netrpc.cpp to send SendDialogResponse() back to the server.
void Fisherman_SendDialogResponse(uint16_t id, uint8_t btn, uint16_t listitem,
                                   char* input);
