#include "main.h"
#include "scoreboard.h"
#include "game/game.h"
#include "net/netgame.h"
#include "gui/gui.h"
#include "vendor/imgui/imgui_internal.h"
#include "CSettings.h"
#include <jni.h>
#ifndef min
#define min(a,b) (((a) < (b)) ? (a) : (b))
#endif

extern CNetGame* pNetGame;
extern CGame* pGame;
extern CGUI* pGUI;
extern CSettings* pSettings;

ImGuiWindowFlags fScoreBoardFlags =
    ImGuiWindowFlags_NoMove |
    ImGuiWindowFlags_NoResize |
    ImGuiWindowFlags_NoSavedSettings |
    ImGuiWindowFlags_NoCollapse |
    ImGuiWindowFlags_NoTitleBar |
    ImGuiWindowFlags_NoScrollbar |
    ImGuiWindowFlags_NoScrollWithMouse;

CScoreBoard::CScoreBoard()
{
    m_iOffset = 0;
    m_bSorted = false;
    m_bToggle = false;
    m_iLastEndPlayer = 0;
    m_fScrollY = 0.0f;

    m_fScoreBoardSizeX = pGUI->ScaleX(pSettings->GetReadOnly().fScoreBoardSizeX);
    m_fScoreBoardSizeY = pGUI->ScaleY(pSettings->GetReadOnly().fScoreBoardSizeY);

    m_pPlayers = 0;
    m_pPlayerCount = 0;
}

CScoreBoard::~CScoreBoard() {}

void SwapPlayerInfo(PLAYER_SCORE_INFO* psi1, PLAYER_SCORE_INFO* psi2)
{
    PLAYER_SCORE_INFO plrinf;
    memcpy(&plrinf, psi1, sizeof(PLAYER_SCORE_INFO));
    memcpy(psi1, psi2, sizeof(PLAYER_SCORE_INFO));
    memcpy(psi2, &plrinf, sizeof(PLAYER_SCORE_INFO));
}

// =====================================================================
// Local helpers — pure draw primitives, no ImGui state changes.
// =====================================================================
static inline ImU32 ColMix(ImU32 a, ImU32 b, float t)
{
    int ar = (a)&0xff, ag = (a>>8)&0xff, ab = (a>>16)&0xff, aa = (a>>24)&0xff;
    int br = (b)&0xff, bg = (b>>8)&0xff, bb = (b>>16)&0xff, ba = (b>>24)&0xff;
    int rr = (int)(ar + (br - ar) * t);
    int gg = (int)(ag + (bg - ag) * t);
    int bbb= (int)(ab + (bb - ab) * t);
    int aaa= (int)(aa + (ba - aa) * t);
    return IM_COL32(rr, gg, bbb, aaa);
}

static void DrawShadowedText(ImDrawList* dl, ImFont* font, float fs,
                             ImVec2 p, ImU32 col, const char* s)
{
    if (!s || !*s) return;
    if (font)
    {
        dl->AddText(font, fs, ImVec2(p.x + 1, p.y + 1),
                    IM_COL32(0, 0, 0, 200), s);
        dl->AddText(font, fs, p, col, s);
    }
    else
    {
        dl->AddText(ImVec2(p.x + 1, p.y + 1), IM_COL32(0, 0, 0, 200), s);
        dl->AddText(p, col, s);
    }
}

static ImFont* GetUIFont()
{
    ImGuiIO& io = ImGui::GetIO();
    return (io.Fonts && io.Fonts->Fonts.Size > 0)
         ? io.Fonts->Fonts[0] : NULL;
}

// =====================================================================
// Draw — professional scoreboard panel
// =====================================================================
void CScoreBoard::Draw()
{
    ProcessUpdating();

    if (!m_bToggle) return;
    if (!m_pPlayers) return;

    PLAYERID endplayer = m_pPlayerCount;

    ImGuiIO& io = ImGui::GetIO();

    // -----------------------------------------------------------------
    // Sizing — adapt to display, capped to a sensible max so very large
    // tablets don't end up with a 6000 px wide list.
    // -----------------------------------------------------------------
    float panelW = io.DisplaySize.x * 0.70f;
    float panelH = io.DisplaySize.y * 0.80f;
    if (panelW > 1500.0f) panelW = 1500.0f;
    if (panelH >  920.0f) panelH = 920.0f;
    if (panelW <  640.0f) panelW = 640.0f;
    if (panelH <  420.0f) panelH = 420.0f;

    float scale = io.DisplaySize.y / 1080.0f;
    if (scale < 0.55f) scale = 0.55f;
    if (scale > 1.40f) scale = 1.40f;

    // Push frame size for hit-test on the close-by-tap-outside logic.
    m_fWindowSizeX = panelW * 0.5f;
    m_fWindowSizeY = panelH * 0.5f;
    m_fDisplaySizeX = io.DisplaySize.x;
    m_fDisplaySizeY = io.DisplaySize.y;

    ImGui::SetNextWindowSize(ImVec2(panelW, panelH), NULL);
    ImGui::SetNextWindowPos(
        ImVec2(io.DisplaySize.x * 0.5f, io.DisplaySize.y * 0.5f),
        ImGuiCond_Always, ImVec2(0.5f, 0.5f));

    // Lock down padding so our custom draw owns the visuals.
    ImGuiStyle& _sbStyle  = ImGui::GetStyle();
    float  _sb_oWR   = _sbStyle.WindowRounding;
    float  _sb_oWBS  = _sbStyle.WindowBorderSize;
    ImVec2 _sb_oWP   = _sbStyle.WindowPadding;
    float  _sb_oSS   = _sbStyle.ScrollbarSize;
    float  _sb_oSR   = _sbStyle.ScrollbarRounding;
    _sbStyle.WindowRounding    = 0.0f;
    _sbStyle.WindowBorderSize  = 0.0f;
    _sbStyle.WindowPadding     = ImVec2(0.0f, 0.0f);
    ImGui::PushStyleColor(ImGuiCol_WindowBg, IM_COL32(0, 0, 0, 0));

    ImGui::Begin("###HavanaScoreBoard", NULL, fScoreBoardFlags);

    ImDrawList* dl   = ImGui::GetWindowDrawList();
    ImVec2 pMin      = ImGui::GetWindowPos();
    ImVec2 pMax      = ImVec2(pMin.x + panelW, pMin.y + panelH);
    ImFont* font     = GetUIFont();

    // Color palette
    const ImU32 kBg          = IM_COL32(  8,  14,  10, 245);
    const ImU32 kBgGradTop   = IM_COL32( 18,  30,  22, 245);
    const ImU32 kBgGradBot   = IM_COL32(  6,  12,   8, 245);
    const ImU32 kBorder      = IM_COL32( 90, 130, 100, 230);
    const ImU32 kAccent      = IM_COL32( 80, 200, 130, 255);
    const ImU32 kAccentDim   = IM_COL32( 30,  90,  50, 230);
    const ImU32 kHeaderBg    = IM_COL32( 14,  44,  26, 240);
    const ImU32 kRowOdd      = IM_COL32( 14,  20,  15, 235);
    const ImU32 kRowEven     = IM_COL32( 22,  32,  24, 235);
    const ImU32 kText        = IM_COL32(232, 240, 232, 255);
    const ImU32 kTextDim     = IM_COL32(170, 188, 174, 255);
    const ImU32 kPingGood    = IM_COL32( 80, 200, 110, 255);
    const ImU32 kPingMid     = IM_COL32(220, 200,  90, 255);
    const ImU32 kPingBad     = IM_COL32(220, 110,  90, 255);

    // -----------------------------------------------------------------
    // Outer plate + gradient + border + accent strip
    // -----------------------------------------------------------------
    float radius = 22.0f * scale;
    dl->AddRectFilledMultiColor(pMin, pMax,
        kBgGradTop, kBgGradTop, kBgGradBot, kBgGradBot);
    dl->AddRect(pMin, pMax, kBorder, radius, 0, 2.5f * scale);

    // Top accent stripe
    dl->AddRectFilled(pMin,
        ImVec2(pMax.x, pMin.y + 4.0f * scale),
        kAccent);

    // -----------------------------------------------------------------
    // Header
    // -----------------------------------------------------------------
    float headerH = 116.0f * scale;
    ImVec2 hMin(pMin.x, pMin.y + 4.0f * scale);
    ImVec2 hMax(pMax.x, hMin.y + headerH);
    dl->AddRectFilledMultiColor(hMin, hMax,
        kHeaderBg, kHeaderBg, kBgGradTop, kBgGradTop);
    dl->AddLine(ImVec2(hMin.x, hMax.y),
                ImVec2(hMax.x, hMax.y),
                kAccentDim, 1.6f * scale);

    // Logo dot
    float dotR = 18.0f * scale;
    ImVec2 dotC(hMin.x + 32.0f * scale + dotR, hMin.y + headerH * 0.5f);
    dl->AddCircleFilled(dotC, dotR + 4.0f * scale,
        IM_COL32(0, 0, 0, 200), 24);
    dl->AddCircleFilled(dotC, dotR, kAccent, 24);
    dl->AddCircle      (dotC, dotR, IM_COL32(255, 255, 255, 200), 24, 1.5f);

    DrawShadowedText(dl, font, 38.0f * scale,
        ImVec2(hMin.x + 100.0f * scale, hMin.y + 18.0f * scale),
        kText, "HAVANA  RP");
    DrawShadowedText(dl, font, 18.0f * scale,
        ImVec2(hMin.x + 100.0f * scale, hMin.y + 64.0f * scale),
        kTextDim, pNetGame ? pNetGame->m_szHostName : "");

    // Player-count badge (top right)
    char szCount[32];
    snprintf(szCount, sizeof(szCount), "%d  ONLINE", (int)m_pPlayerCount);
    float badgeW = 220.0f * scale, badgeH = 56.0f * scale;
    ImVec2 bMin(hMax.x - badgeW - 26.0f * scale, hMin.y + (headerH - badgeH) * 0.5f);
    ImVec2 bMax(bMin.x + badgeW, bMin.y + badgeH);
    dl->AddRectFilled(bMin, bMax, kAccentDim, badgeH * 0.5f);
    dl->AddRect      (bMin, bMax, kAccent,    badgeH * 0.5f, 0, 1.6f * scale);
    if (font)
    {
        ImVec2 tsz = font->CalcTextSizeA(22.0f * scale, FLT_MAX, 0.0f, szCount);
        DrawShadowedText(dl, font, 22.0f * scale,
            ImVec2((bMin.x + bMax.x) * 0.5f - tsz.x * 0.5f,
                   (bMin.y + bMax.y) * 0.5f - 13.0f * scale),
            kText, szCount);
    }

    // -----------------------------------------------------------------
    // Column header row
    // -----------------------------------------------------------------
    float colY = hMax.y + 16.0f * scale;
    float colH = 44.0f * scale;
    float padX = 28.0f * scale;
    float colIdW    = 90.0f * scale;
    float colPingW  = 130.0f * scale;
    float colScoreW = 160.0f * scale;
    float colNameX  = pMin.x + padX + colIdW + 16.0f * scale;
    float colScoreX = pMax.x - padX - colPingW - 12.0f * scale - colScoreW;
    float colPingX  = pMax.x - padX - colPingW;

    dl->AddRectFilled(
        ImVec2(pMin.x + padX, colY),
        ImVec2(pMax.x - padX, colY + colH),
        IM_COL32(0, 0, 0, 120),
        10.0f * scale);

    DrawShadowedText(dl, font, 20.0f * scale,
        ImVec2(pMin.x + padX + 12.0f * scale, colY + 10.0f * scale),
        kTextDim, "ID");
    DrawShadowedText(dl, font, 20.0f * scale,
        ImVec2(colNameX, colY + 10.0f * scale),
        kTextDim, "PLAYER NAME");
    DrawShadowedText(dl, font, 20.0f * scale,
        ImVec2(colScoreX, colY + 10.0f * scale),
        kTextDim, "SCORE");
    DrawShadowedText(dl, font, 20.0f * scale,
        ImVec2(colPingX, colY + 10.0f * scale),
        kTextDim, "PING");

    // -----------------------------------------------------------------
    // Player rows — scrollable child
    // -----------------------------------------------------------------
    float listTop = colY + colH + 10.0f * scale;
    float listBot = pMax.y - 60.0f * scale;
    float rowH    = 64.0f * scale;

    ImGui::SetCursorScreenPos(ImVec2(pMin.x + padX, listTop));

    ImGui::PushStyleColor(ImGuiCol_ChildBg,            IM_COL32(0, 0, 0, 0));
    ImGui::PushStyleColor(ImGuiCol_ScrollbarBg,        IM_COL32(0, 0, 0, 80));
    ImGui::PushStyleColor(ImGuiCol_ScrollbarGrab,      kAccentDim);
    ImGui::PushStyleColor(ImGuiCol_ScrollbarGrabHovered, kAccent);
    ImGui::PushStyleColor(ImGuiCol_ScrollbarGrabActive,  kAccent);
    _sbStyle.ScrollbarSize     = 14.0f * scale;
    _sbStyle.ScrollbarRounding =  7.0f * scale;

    ImGui::BeginChild("###PlrList",
        ImVec2(panelW - 2 * padX, listBot - listTop), false,
        ImGuiWindowFlags_AlwaysVerticalScrollbar);

    ImDrawList* cdl = ImGui::GetWindowDrawList();
    ImVec2 cPos    = ImGui::GetWindowPos();

    int visibleCount = (int)endplayer - m_iOffset;
    if (visibleCount < 0) visibleCount = 0;

    for (int i = 0; i < visibleCount; i++)
    {
        if (!m_bToggle || !m_pPlayers) break;

        int p = m_iOffset + i;
        if (p < 0 || p >= (int)endplayer) break;

        unsigned char r = (m_pPlayers[p].dwColor >> 16) & 0xFF;
        unsigned char g = (m_pPlayers[p].dwColor >>  8) & 0xFF;
        unsigned char b = (m_pPlayers[p].dwColor      ) & 0xFF;
        ImU32 plrCol = IM_COL32(r, g, b, 255);

        float rowY = cPos.y + i * (rowH + 6.0f * scale)
                            - ImGui::GetScrollY();

        // Cull rows offscreen
        if (rowY + rowH < cPos.y) {
            ImGui::Dummy(ImVec2(1, rowH + 6.0f * scale));
            continue;
        }
        if (rowY > cPos.y + (listBot - listTop)) break;

        ImVec2 rMin(cPos.x, rowY);
        ImVec2 rMax(cPos.x + (panelW - 2 * padX) - 16.0f * scale,
                    rowY + rowH);

        // Row background (alternating)
        ImU32 rowBg = (i & 1) ? kRowEven : kRowOdd;
        cdl->AddRectFilled(rMin, rMax, rowBg, 10.0f * scale);

        // Left accent stripe in player color
        cdl->AddRectFilled(
            ImVec2(rMin.x, rMin.y),
            ImVec2(rMin.x + 5.0f * scale, rMax.y),
            plrCol, 10.0f * scale);

        // ID badge
        char szId[12];
        snprintf(szId, sizeof(szId), "%u", (unsigned)m_pPlayers[p].dwID);
        ImVec2 idBoxMin(rMin.x + 14.0f * scale, rMin.y + 10.0f * scale);
        ImVec2 idBoxMax(idBoxMin.x + colIdW - 14.0f * scale,
                        rMax.y - 10.0f * scale);
        cdl->AddRectFilled(idBoxMin, idBoxMax,
            ColMix(plrCol, IM_COL32(0,0,0,255), 0.55f),
            8.0f * scale);
        cdl->AddRect      (idBoxMin, idBoxMax, plrCol,
            8.0f * scale, 0, 1.4f * scale);
        if (font)
        {
            ImVec2 ts = font->CalcTextSizeA(22.0f * scale, FLT_MAX, 0.0f, szId);
            DrawShadowedText(cdl, font, 22.0f * scale,
                ImVec2((idBoxMin.x + idBoxMax.x) * 0.5f - ts.x * 0.5f,
                       (idBoxMin.y + idBoxMax.y) * 0.5f - 13.0f * scale),
                kText, szId);
        }

        // Name
        DrawShadowedText(cdl, font, 24.0f * scale,
            ImVec2(rMin.x + colIdW + 18.0f * scale,
                   rMin.y + (rowH - 26.0f * scale) * 0.5f),
            plrCol,
            m_pPlayers[p].szName ? m_pPlayers[p].szName : "");

        // Score (right-aligned-ish in its slot)
        char szScore[12];
        snprintf(szScore, sizeof(szScore), "%d", m_pPlayers[p].iScore);
        DrawShadowedText(cdl, font, 24.0f * scale,
            ImVec2(rMin.x + (colScoreX - pMin.x - padX),
                   rMin.y + (rowH - 26.0f * scale) * 0.5f),
            kText, szScore);

        // Ping pill — colored by latency band
        int ping = (int)m_pPlayers[p].dwPing;
        ImU32 pingCol =
            ping <  90 ? kPingGood :
            ping < 180 ? kPingMid  : kPingBad;
        char szPing[12];
        snprintf(szPing, sizeof(szPing), "%d", ping);

        float pillW = 110.0f * scale, pillH = 34.0f * scale;
        ImVec2 pillMin(rMin.x + (colPingX - pMin.x - padX),
                       rMin.y + (rowH - pillH) * 0.5f);
        ImVec2 pillMax(pillMin.x + pillW, pillMin.y + pillH);
        cdl->AddRectFilled(pillMin, pillMax,
            IM_COL32(0, 0, 0, 180), pillH * 0.5f);
        cdl->AddRect      (pillMin, pillMax, pingCol,
            pillH * 0.5f, 0, 1.6f * scale);
        if (font)
        {
            ImVec2 ts = font->CalcTextSizeA(20.0f * scale, FLT_MAX, 0.0f, szPing);
            DrawShadowedText(cdl, font, 20.0f * scale,
                ImVec2((pillMin.x + pillMax.x) * 0.5f - ts.x * 0.5f,
                       (pillMin.y + pillMax.y) * 0.5f - 11.0f * scale),
                pingCol, szPing);
        }

        ImGui::Dummy(ImVec2(1, rowH + 6.0f * scale));
    }

    ImGui::EndChild();
    /* scrollbar style restored at end of Draw() */
    ImGui::PopStyleColor(5);

    // -----------------------------------------------------------------
    // Footer
    // -----------------------------------------------------------------
    DrawShadowedText(dl, font, 18.0f * scale,
        ImVec2(pMin.x + 28.0f * scale, pMax.y - 36.0f * scale),
        kTextDim, "Tap outside the panel  to close");

    ImGui::End();

    ImGui::PopStyleColor(1);
    _sbStyle.WindowRounding    = _sb_oWR;
    _sbStyle.WindowBorderSize  = _sb_oWBS;
    _sbStyle.WindowPadding     = _sb_oWP;
    _sbStyle.ScrollbarSize     = _sb_oSS;
    _sbStyle.ScrollbarRounding = _sb_oSR;
}

// =====================================================================
// Toggle / data refresh — unchanged from upstream.
// =====================================================================
void CScoreBoard::Toggle()
{
    m_bToggle = !m_bToggle;
    if (m_bToggle)
    {
        // Freeze player
        pNetGame->GetPlayerPool()->GetLocalPlayer()->GetPlayerPed()->TogglePlayerControllableWithoutLock(false);

        // Get player list
        pNetGame->UpdatePlayerScoresAndPings();

        CPlayerPool* pPlayerPool = pNetGame->GetPlayerPool();
        PLAYERID playercount = pPlayerPool->GetCount() + 1;
        m_pPlayerCount = playercount;

        if (m_iOffset > (playercount - 20)) m_iOffset = (playercount - 20);
        if (m_iOffset < 0) m_iOffset = 0;

        m_pPlayers = (PLAYER_SCORE_INFO*)malloc(playercount * sizeof(PLAYER_SCORE_INFO));
        memset(m_pPlayers, 0, playercount * sizeof(PLAYER_SCORE_INFO));
        m_pPlayers[0].dwID    = pPlayerPool->GetLocalPlayerID();
        m_pPlayers[0].szName  = pPlayerPool->GetLocalPlayerName();
        m_pPlayers[0].iScore  = pPlayerPool->GetLocalPlayerScore();
        m_pPlayers[0].dwPing  = pPlayerPool->GetLocalPlayerPing();
        m_pPlayers[0].dwColor = pPlayerPool->GetLocalPlayer()->GetPlayerColorAsARGB();
        PLAYERID i = 1, x;
        for (x = 0; x < MAX_PLAYERS; x++)
        {
            if (!pPlayerPool->GetSlotState(x)) continue;
            m_pPlayers[i].dwID    = x;
            m_pPlayers[i].szName  = pPlayerPool->GetPlayerName(x);
            m_pPlayers[i].iScore  = pPlayerPool->GetRemotePlayerScore(x);
            m_pPlayers[i].dwPing  = pPlayerPool->GetRemotePlayerPing(x);
            m_pPlayers[i].dwColor = pPlayerPool->GetAt(x)->GetPlayerColorAsARGB();
            m_pPlayers[i].iState  = (int)pPlayerPool->GetAt(x)->GetState();

            i++;
        }

        if (m_bSorted)
        {
            for (i = 0; i < playercount - 1; i++)
            {
                for (PLAYERID j = 0; j < playercount - 1 - i; j++)
                {
                    if (m_pPlayers[j + 1].iScore > m_pPlayers[j].iScore)
                    {
                        SwapPlayerInfo(&m_pPlayers[j], &m_pPlayers[j + 1]);
                    }
                }
            }
        }
    }
    else
    {
        // Unfreeze player
        pNetGame->GetPlayerPool()->GetLocalPlayer()->GetPlayerPed()->TogglePlayerControllableWithoutLock(true);

        if (m_pPlayers)
        {
            memset(m_pPlayers, 0, m_pPlayerCount * sizeof(PLAYER_SCORE_INFO));
            free(m_pPlayers);
        }
        m_pPlayers = 0;
    }
}

bool CScoreBoard::OnTouchEvent(int type, bool multi, float x, float y)
{
    if (!m_bToggle) return true;

    static bool bWannaCloseTab = false;

    switch (type)
    {
    case TOUCH_PUSH:
        if (
            x < (m_fDisplaySizeX * 0.5f - m_fWindowSizeX) || x >(m_fDisplaySizeX * 0.5f + m_fWindowSizeX) ||
            y < (m_fDisplaySizeY * 0.5f - m_fWindowSizeY) || y >(m_fDisplaySizeY * 0.5f + m_fWindowSizeY)
            )
        {
            bWannaCloseTab = true;
        }
        break;
    case TOUCH_POP:
        if (
            bWannaCloseTab &&
            x < (m_fDisplaySizeX * 0.5f - m_fWindowSizeX) || x >(m_fDisplaySizeX * 0.5f + m_fWindowSizeX) ||
            y < (m_fDisplaySizeY * 0.5f - m_fWindowSizeY) || y >(m_fDisplaySizeY * 0.5f + m_fWindowSizeY)
            )
        {
            Toggle();
            bWannaCloseTab = false;
        }
        break;
    }
    return true;
}

void CScoreBoard::ProcessUpdating()
{
    if (pNetGame)
    {
        if ((GetTickCount() - m_tickProcessingUpdate) >= 2000)
        {
            m_tickProcessingUpdate = GetTickCount();
            pNetGame->UpdatePlayerScoresAndPings();
        }
    }
}
