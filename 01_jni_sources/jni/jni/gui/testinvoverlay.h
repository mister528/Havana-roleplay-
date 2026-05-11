#pragma once
#include <stdint.h>

class CTestInvOverlay
{
public:
    CTestInvOverlay();
    ~CTestInvOverlay();

    bool TryHandleDialog(uint16_t dialogId, uint8_t style,
                         const char* title, const char* body);
    void Render();
    void Hide();
    bool IsVisible() const { return m_visible || m_iAccCtrlSlot >= 0; }
    void SetInventoryPayload(const char* payload);
    void MergeInventoryPayload(const char* payload, bool resetMissing);
    void ShowFromPayload(const char* payload);
    void ClearAccessorySlots();
    void SetAccessorySlot(int slot, int model, int used, const char* name);

private:
    void LoadLayout();
    void DrawFixedImage(void* tex, float u, float v,
                        float sw, float sh, float scale, float xNorm, float yNorm, float e);
    void DrawAccessoryPreview(float x, float y, float size, float e, bool used, const char* kind);
    void RenderAccessoryPopup(float sw, float sh, float base);
    void RenderAccessoryControlPad(float sw, float sh, float base);
    void RenderInfoPopup(float sw, float sh, float base);
    bool  m_visible;
    bool  m_closing;
    bool  m_lastMouseDown;
    float m_anim;
    float m_closeAnim;
    float m_skinX;
    float m_skinY;
    float m_skinScale;
    float m_exitX;
    float m_exitY;
    float m_exitScale;
    float m_imageX[2];
    float m_imageY[2];
    float m_imageScale[2];
    int   m_iPhone;
    int   m_iDrugs;
    int   m_iMats;
    int   m_iCigs;
    int   m_iAidKit;
    int   m_iBandage;
    int   m_iSchiene;
    int   m_iAspirin;
    int   m_iMorphine;
    int   m_iAdrenalin;
    int   m_iRepairKit;
    int   m_iGPS;
    int   m_iMask;
    int   m_iRope;
    int   m_iCanister;
    int   m_iSeed;
    int   m_iAmmo;
    int   m_iGuns;
    int   m_iMusic;
    int   m_iTheftKey;
    int   m_iIslandGunpowder;
    int   m_iIslandIron;
    int   m_iIslandScrap;
    int   m_iIslandWood;
    int   m_iIslandSpring;
    bool  m_infoVisible;
    char  m_infoLabel[48];
    char  m_infoKind[32];
    int   m_infoCount;
    int   m_iAccMenuSlot;
    int   m_iAccCtrlSlot;
    int   m_iPage;
    static const int kAccMax = 8;
    static const int kAccNameMax = 48;
    int   m_accModel[kAccMax];
    int   m_accUsed[kAccMax];
    char  m_accName[kAccMax][kAccNameMax];
    int   m_skinId;
};

extern CTestInvOverlay* pTestInvOverlay;
