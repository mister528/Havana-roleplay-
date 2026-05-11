// =============================================================================
//  flymodsoverlay.cpp  -  HavanaRp /flymods cinematic admin camera (client side)
//
//  Server-driven entry/exit, fully client-driven motion:
//      "ON|<x>|<y>|<z>"   enter at world position (x,y,z)
//      "OFF"              exit
//
//  Camera is updated locally each frame from LocalPlayerKeys (the same struct
//  the rest of the launcher fills from the on-screen analog stick + buttons),
//  so the user can fly anywhere with the analog stick + ACTION/CROUCH/SPRINT.
// =============================================================================

#include "../main.h"
#include "flymodsoverlay.h"
#include "gui.h"
#include "../game/game.h"
#include "../game/common.h"
#include "../game/pad.h"
#include "../net/netgame.h"
#include "../net/localplayer.h"
#include "../util/CJavaWrapper.h"
#include "../chatwindow.h"

#include <cstdio>
#include <cstring>
#include <cstdlib>
#include <cmath>

CFlyModsOverlay* pFlyModsOverlay = nullptr;
bool g_bFlyModsActive = false;

extern CGame*         pGame;
extern CGUI*          pGUI;
extern CNetGame*      pNetGame;
extern CChatWindow*   pChatWindow;
extern CJavaWrapper*  g_pJavaWrapper;
extern bool           g_bChatHiddenByCommand;

// Tunables (all in-game units / units per second).
static const float kFmSpeedSlow      = 18.0f;
static const float kFmSpeedFast      = 60.0f;
static const float kFmYawRate        = 2.2f;    // rad/sec at full deflection
static const float kFmAnalogScale    = 1.0f / 128.0f;
static const float kFmLookAheadDist  = 8.0f;

CFlyModsOverlay::CFlyModsOverlay()
    : m_bVisible(false)
    , m_bSavedChatHidden(false)
    , m_dwShownAt(0)
    , m_fCamX(0.0f), m_fCamY(0.0f), m_fCamZ(0.0f)
    , m_fLookX(0.0f), m_fLookY(0.0f), m_fLookZ(0.0f)
    , m_bHaveLookAt(false)
    , m_fYaw(0.0f)
    , m_dwLastTick(0)
{
    for (int i = 0; i < 7; ++i) m_bSavedHud[i] = true;
}

CFlyModsOverlay::~CFlyModsOverlay() {}

void CFlyModsOverlay::SaveHudState()
{
    if (!pGame) return;
    for (int i = 0; i < 7; ++i)
    {
        m_bSavedHud[i] = pGame->IsToggledHUDElement(i);
    }
    m_bSavedChatHidden = g_bChatHiddenByCommand;
}

void CFlyModsOverlay::RestoreHudState()
{
    if (pGame)
    {
        for (int i = 0; i < 7; ++i)
        {
            pGame->ToggleHUDElement(i, m_bSavedHud[i]);
        }
    }
    g_bChatHiddenByCommand = m_bSavedChatHidden;

    if (g_pJavaWrapper)
    {
        g_pJavaWrapper->ShowHud();
        g_pJavaWrapper->ShowAllUI();
    }
}

void CFlyModsOverlay::Show(float fX, float fY, float fZ)
{
    if (m_bVisible) return;

    m_bVisible    = true;
    m_dwShownAt   = GetTickCount();
    m_dwLastTick  = m_dwShownAt;
    m_fCamX       = fX;
    m_fCamY       = fY;
    m_fCamZ       = fZ;
    m_bHaveLookAt = false;
    m_fYaw        = 0.0f;
    g_bFlyModsActive = true;

    // Detach the local player so the camera can roam freely; do NOT touch
    // any HUD / chat / Java widget so the rest of the game UI keeps working
    // exactly as it does outside of cinematic mode.
    if (pNetGame)
    {
        CPlayerPool* pPool = pNetGame->GetPlayerPool();
        if (pPool)
        {
            CLocalPlayer* pLocal = pPool->GetLocalPlayer();
            if (pLocal) pLocal->ToggleSpectating(true);
        }
    }

    if (pGame)
    {
        CCamera* pCam = pGame->GetCamera();
        if (pCam) pCam->SetPosition(fX, fY, fZ, 0.0f, 0.0f, 0.0f);
    }
}

void CFlyModsOverlay::Hide()
{
    if (!m_bVisible) return;
    m_bVisible        = false;
    g_bFlyModsActive  = false;

    if (pGame)
    {
        CCamera* pCam = pGame->GetCamera();
        if (pCam) pCam->SetBehindPlayer();
    }

    if (pNetGame)
    {
        CPlayerPool* pPool = pNetGame->GetPlayerPool();
        if (pPool)
        {
            CLocalPlayer* pLocal = pPool->GetLocalPlayer();
            if (pLocal) pLocal->ToggleSpectating(false);
        }
    }
}

void CFlyModsOverlay::UpdateCamera(float fX, float fY, float fZ,
                                   float fLookX, float fLookY, float fLookZ)
{
    m_fCamX  = fX;  m_fCamY  = fY;  m_fCamZ  = fZ;
    m_fLookX = fLookX; m_fLookY = fLookY; m_fLookZ = fLookZ;
    m_bHaveLookAt = true;
}

void CFlyModsOverlay::DriveCamera()
{
    if (!pGame) return;
    CCamera* pCam = pGame->GetCamera();
    if (!pCam) return;

    // Read on-screen input (analog stick + virtual buttons) the launcher
    // already populates from the touch overlay.
    int    lr      = (int)(int16_t)LocalPlayerKeys.wKeyLR;
    int    ud      = (int)(int16_t)LocalPlayerKeys.wKeyUD;
    bool   bSprint = LocalPlayerKeys.bKeys[KEY_SPRINT];
    bool   bUp     = LocalPlayerKeys.bKeys[KEY_ACTION];
    bool   bDown   = LocalPlayerKeys.bKeys[KEY_CROUCH];
    bool   bYawL   = LocalPlayerKeys.bKeys[KEY_LOOK_LEFT]
                  || LocalPlayerKeys.bKeys[KEY_ANALOG_LEFT];
    bool   bYawR   = LocalPlayerKeys.bKeys[KEY_LOOK_RIGHT]
                  || LocalPlayerKeys.bKeys[KEY_ANALOG_RIGHT];

    uint32_t now = GetTickCount();
    uint32_t dtMs = now - m_dwLastTick;
    if (dtMs == 0) dtMs = 1;
    if (dtMs > 250) dtMs = 250;            // clamp big stalls
    m_dwLastTick = now;
    float dt = (float)dtMs / 1000.0f;

    float fwd    = -(float)ud * kFmAnalogScale;     // up on stick = forward
    float strafe =  (float)lr * kFmAnalogScale;
    float yawIn  =  0.0f;
    if (bYawR) yawIn += 1.0f;
    if (bYawL) yawIn -= 1.0f;

    m_fYaw -= yawIn * kFmYawRate * dt;

    float speed = bSprint ? kFmSpeedFast : kFmSpeedSlow;

    float siny = sinf(m_fYaw);
    float cosy = cosf(m_fYaw);

    // Forward axis in SA world: (-sin(yaw),  cos(yaw)).
    // Right axis            : ( cos(yaw),  sin(yaw)).
    m_fCamX += ( -siny * fwd + cosy * strafe ) * speed * dt;
    m_fCamY += (  cosy * fwd + siny * strafe ) * speed * dt;

    if (bUp)   m_fCamZ += speed * dt;
    if (bDown) m_fCamZ -= speed * dt;

    // Compute look-at one unit ahead so the camera always faces the yaw.
    m_fLookX = m_fCamX + (-siny) * kFmLookAheadDist;
    m_fLookY = m_fCamY + ( cosy) * kFmLookAheadDist;
    m_fLookZ = m_fCamZ;
    m_bHaveLookAt = true;

    pCam->SetPosition(m_fCamX, m_fCamY, m_fCamZ, 0.0f, 0.0f, 0.0f);
    pCam->LookAtPoint(m_fLookX, m_fLookY, m_fLookZ, 2 /* CAM_MOVE_INSTANT */);
}

void CFlyModsOverlay::ApplyServerCommand(const char* szPayload)
{
    if (!szPayload) return;

    if (strncmp(szPayload, "تشغيل", 2) == 0)
    {
        float x = 0.0f, y = 0.0f, z = 50.0f;
        const char* p = szPayload + 2;
        if (*p == '|') sscanf(p + 1, "%f|%f|%f", &x, &y, &z);
        Show(x, y, z);
    }
    else if (strncmp(szPayload, "إيقاف", 3) == 0)
    {
        Hide();
    }
    // POS messages are ignored - movement is now fully client side.
}

void CFlyModsOverlay::Render()
{
    if (!m_bVisible) return;
    DriveCamera();
    // No on-screen overlay is rendered: per user request the screen stays
    // 100% clean while in cinematic mode.
}
