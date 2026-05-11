#pragma once

#include <stdint.h>
#include <string>
#include <vector>

// =====================================================================
// [HAVANA] WANTED LIST OVERLAY
//
// On-duty cops/FBI get TWO independent on-screen elements:
//
//   1) Cuff icon  -> drawn by policehudoverlay (tap = /cuffnear).
//   2) Wanted icon -> drawn by THIS overlay. Tap to toggle the wanted-
//      list panel; the panel itself contains [tap], [info] buttons and
//      a "cuff nearest" footer button as a convenience.
//
// Both icons can be repositioned + resized independently from the /hud
// editor. The launcher receives the layouts via two separate dialog
// title sentinels:
//
//   "[!POLICE_HUD_CFG]"   body = "X Y SIZE"   -> cuff icon
//   "[!WANTED_HUD_CFG]"   body = "X Y SIZE"   -> wanted icon
//
// While the player is in /hud edit mode the server pushes a single
// "[!POLICE_HUD_EDIT]" with body = "CX CY CSZ WX WY WSZ" so the
// launcher can present BOTH icons as draggable handles in one screen
// and persist the answer with one /hudset.
//
// List + info dialog protocol (unchanged):
//   "[!POLICE_HUD_LIST]"  body = "id|name|stars|level\n..."
//   "[!POLICE_HUD_INFO]"  body = "id|name|stars|level|reason|by|hh:mm:ss"
//
// Chat tap shortcuts the server understands:
//   /wantedlocate <id> /wantedinfo <id> /wantedrefresh /cuffnear
// =====================================================================

struct WantedRow
{
    int           id;
    int           stars;
    int           level;
    std::string   name;
};

struct WantedInfo
{
    int           id;
    int           stars;
    int           level;
    std::string   name;
    std::string   reason;
    std::string   byName;
    std::string   sinceHms;
    bool          valid;
};

class CWantedOverlay
{
public:
    CWantedOverlay();
    ~CWantedOverlay() {}

    bool TryHandleDialog(uint16_t dialogId, uint8_t style,
                         const char* title, const char* body);

    // Called every frame from gui.cpp.
    void Render();

    void Show()  { m_bVisible = true; }
    void Hide()  { m_bVisible = false; m_infoOpen = false; }
    bool IsVisible() const { return m_bVisible; }
    bool IsBlockingInput() const;

    // Tap on the floating wanted icon flips the panel.
    void Toggle();
    bool IsAvailable() const { return m_hudActive; }

    // Anchor used by the LIST PANEL (kept in sync with the cuff HUD so
    // the panel slides out next to the cuff icon by default).
    void SetAnchor(float cfgX, float cfgY, float cfgSize, bool active);

    // Anchor of the floating wanted-icon (independent of cuff). The
    // values are 0..1 fractions of the screen.
    void SetIconAnchor(float x, float y, float sz);
    void GetIconAnchor(float& x, float& y, float& sz) const
    { x = m_iconX; y = m_iconY; sz = m_iconSize; }

    // Police HUD's /hud edit mode drives this so we know to skip the
    // tap-to-toggle hit test (the icon is being dragged instead).
    void SetIconEditMode(bool on) { m_iconEditMode = on; }
    bool IsIconEditMode() const   { return m_iconEditMode; }

    // Used by the police HUD edit chrome to know where the icon sits in
    // pixels (so the edit chrome can hit-test drags itself).
    float GetIconRadiusPx(float baseScale) const;
    void  GetIconCenterPx(float displayW, float displayH,
                          float& cx, float& cy, float& radius) const;

private:
    bool   m_bVisible;
    bool   m_infoOpen;
    bool   m_hudActive;          // mirror of police HUD on/off
    float  m_cfgX, m_cfgY, m_cfgSize;     // panel anchor (mirrors cuff)

    // floating wanted icon (independent of cuff)
    float  m_iconX, m_iconY, m_iconSize;
    bool   m_iconEditMode;
    float  m_iconPulse;
    float  m_iconPressAnim;
    bool   m_iconLastMouseDown;

    bool   m_lastMouseDown;
    float  m_openAnim;
    float  m_scrollY;
    float  m_scrollVel;
    float  m_scrollMax;
    bool   m_dragScroll;
    bool   m_dragPending;       // press recorded, not yet upgraded to drag
    float  m_dragStartY;
    float  m_dragStartX;
    float  m_dragStartScroll;

    std::vector<WantedRow> m_rows;
    WantedInfo             m_info;

    void RenderIcon();
    void RenderPanel();
    void RenderInfoCard();

    static void Trim(std::string& s);
    static void ParseList(const char* body, std::vector<WantedRow>& out);
    static bool ParseInfo(const char* body, WantedInfo& out);
};

extern CWantedOverlay* pWantedOverlay;
