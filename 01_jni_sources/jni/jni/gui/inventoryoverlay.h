#pragma once

#include <stdint.h>

// [INVENTORY OVERLAY] Professional wide HUD triggered by server /inv command.
// Server sends a prefixed ClientMessage of the form:
//   "~INV_UI~name=Bob;level=15;job=2;skin=23;health=85;hunger=70;money=1234;
//            bank=98765;phone=120;drugs=10;mats=50;cigs=3;
//            aidkit=2;bandage=5;schiene=1;aspirin=4;morphine=0;adrenalin=1;
//            repairkit=2;gps=0;mask=1;rope=2;canister=3;seed=10;
//            ammo=120;guns=5"
// netrpc.cpp::ClientMessage parses the payload and calls CInventoryOverlay::Show().

class CInventoryOverlay
{
public:
    CInventoryOverlay();
    ~CInventoryOverlay();

    // Activate the overlay with a fresh snapshot of the player's resources.
    void ShowFromPayload(const char* payload);

    // Merge fresh values from the server into our cache without showing the
    // overlay (used for periodic wallet updates pushed by inv_ui.pwn).
    void UpdateFromPayload(const char* payload);

    // Intercept the gamemode's stock "Inventory" SAMP dialog and render the
    // overlay instead. Returns true if the dialog should be suppressed.
    // We auto-cancel the dialog server-side so the gamemode flow proceeds.
    bool TryHandleDialog(uint16_t dialogId, uint8_t style,
                         const char* title, const char* body);

    // Hide overlay (also triggered by tapping close button or clicking outside).
    void Hide();

    // Called from CGUI::Render each frame between ImGui::NewFrame() and Render().
    void Render();

    bool IsVisible() const { return m_bVisible; }
    // True whenever the overlay is occupying the screen and should eat
    // input (bag, popup, or the accessory control pad). Used by the
    // touch-hook to block the game / chat / dialogs underneath.
    bool IsModalActive() const
    {
        return m_bVisible || m_iAccMenuSlot >= 0 || m_iAccCtrlSlot >= 0;
    }

private:
    static const int kNameMax = 32;

    void   ParsePayload(const char* payload);
    int    GetField(const char* key, int def = 0) const;
    void   SetField(const char* key, const char* value);

    bool      m_bVisible;
    float     m_fAnimT;        // 0..1 eased intro animation

    // SAMP dialog id of the underlying "Inventory" dialog. Stored so we
    // can send Response(button=1,listitem=N) when the user taps an item
    // card, and Response(button=0) when the user closes via the X.
    uint16_t  m_iDialogId;
    bool      m_bDialogActive;

    char      m_szName[kNameMax];
    int       m_iLevel;
    int       m_iJob;
    int       m_iSkin;
    int       m_iHealth;       // 0..100
    int       m_iHunger;       // 0..100

    int64_t   m_iMoney;
    int64_t   m_iBank;
    int       m_iPhone;
    int       m_iDrugs;
    int       m_iMats;
    int       m_iCigs;

    // Medical pouch
    int       m_iAidKit;
    int       m_iBandage;
    int       m_iSchiene;      // splint
    int       m_iAspirin;
    int       m_iMorphine;
    int       m_iAdrenalin;

    // Tools
    int       m_iRepairKit;
    int       m_iGPS;
    int       m_iMask;
    int       m_iRope;
    int       m_iCanister;
    int       m_iSeed;

    // Combat
    int       m_iAmmo;
    int       m_iGuns;

    // Subscriptions
    int       m_iMusic;        // 1 = owns Music subscription (/music unlocked)
    int       m_iTheftKey;

    int       m_iIslandGunpowder;
    int       m_iIslandIron;
    int       m_iIslandScrap;
    int       m_iIslandWood;
    int       m_iIslandSpring;

    // Accessories: up to 8 slots. Filled from ~ACC_UI~ payload:
    //   s0=<model>,<used>,<arabicName>; s1=...
    // used=1 means currently equipped (SetPlayerAttachedObject active).
public:
    void      SetAccessorySlot(int slot, int model, int used, const char* name);
    void      ClearAccessorySlots();
private:
    static const int kAccMax = 8;
    static const int kAccNameMax = 48;
    int       m_accModel[kAccMax];
    int       m_accUsed [kAccMax];
    char      m_accName [kAccMax][kAccNameMax];

    // -1 = no popup. 0..7 = popup open for this accessory slot.
    int       m_iAccMenuSlot;
    // -1 = no floating control pad. 0..7 = pad open, bag hidden so the
    // player can see the accessory move in the world.
    int       m_iAccCtrlSlot;
    int       m_iPage;

    void RenderAccessoryPopup(float scrW, float scrH, float scale);
    void RenderAccessoryControlPad(float scrW, float scrH, float scale);
};

extern CInventoryOverlay* pInventoryOverlay;
