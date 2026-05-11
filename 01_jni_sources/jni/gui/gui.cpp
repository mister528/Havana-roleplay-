#include "../main.h"
#include "gui.h"
#include "../game/game.h"
#include "../net/netgame.h"
#include "../game/RW/RenderWare.h"
#include "../chatwindow.h"
#include "../playertags.h"
#include "../dialog.h"
#include "../keyboard.h"
#include "../CSettings.h"
#include "..//scoreboard.h"
#include "../util/CJavaWrapper.h"
#include "../util/util.h"
#include "../game/vehicle.h"
#include "bankoverlay.h"
#include "carrentoverlay.h"
#include "trentpreviewoverlay.h"
#include "gametextoverlay.h"
#include "shop247overlay.h"
#include "inventoryoverlay.h"
#include "skinshopoverlay.h"
#include "clothesshopoverlay.h"
#include "accessoryshopoverlay.h"
#include "carshopoverlay.h"
#include "houseguardoverlay.h"
#include "brandoverlay.h"
#include "test1overlay.h"
#include "test3overlay.h"
#include "flightjoboverlay.h"
#include "fishermanoverlay.h"
#include "ytmusicoverlay.h"
#include "robberyoverlay.h"
#include "carjackoverlay.h"
#include "policehudoverlay.h"
#include "testinvoverlay.h"
#include "flymodsoverlay.h"
#include "greenzoneoverlay.h"
#include "phoneoverlay.h"
#include "objecteditoroverlay.h"
#include "islandtoolsoverlay.h"

extern CScoreBoard* pScoreBoard;
extern CChatWindow *pChatWindow;
extern CPlayerTags *pPlayerTags;
extern CDialogWindow *pDialogWindow;
extern CSettings *pSettings;
extern CKeyBoard *pKeyBoard;
extern CNetGame *pNetGame;
extern CJavaWrapper *g_pJavaWrapper;

/* imgui_impl_renderware.h */
void ImGui_ImplRenderWare_RenderDrawData(ImDrawData* draw_data);
bool ImGui_ImplRenderWare_Init();
void ImGui_ImplRenderWare_NewFrame();
void ImGui_ImplRenderWare_ShutDown();

/*
	Все координаты GUI-элементов задаются
	относительно разрешения 1920x1080
*/
#define MULT_X	0.00052083333f	// 1/1920
#define MULT_Y	0.00092592592f 	// 1/1080

CGUI::CGUI()
{
	Log("Initializing GUI..");

	m_bMouseDown = 0;
	m_vTouchPos = ImVec2(-1, -1);
	m_bNextClear = false;
	m_bNeedClearMousePos = false;

	// setup ImGUI
	IMGUI_CHECKVERSION();
	ImGui::CreateContext();
	ImGuiIO &io = ImGui::GetIO();

	ImGui_ImplRenderWare_Init();

	// scale
	m_vecScale.x = io.DisplaySize.x * MULT_X;
	m_vecScale.y = io.DisplaySize.y * MULT_Y;
	// font Size
	m_fFontSize = ScaleY( pSettings->GetReadOnly().fFontSize );

	Log("GUI | Scale factor: %f, %f Font size: %f", m_vecScale.x, m_vecScale.y, m_fFontSize);

	// setup style
	ImGuiStyle& style = ImGui::GetStyle();
	style.ScrollbarSize = ScaleY(55.0f);
	style.WindowBorderSize = 0.0f;
	ImGui::StyleColorsDark();

	// load fonts
	char path[0xFF];
	sprintf(path, "%sSAMP/fonts/%s", g_pszStorage, pSettings->GetReadOnly().szFont);
	// cp1251 ranges
	static const ImWchar ranges[] = 
	{
		0x0020, 0x0080,
		0x00A0, 0x00C0,
		0x0400, 0x0460,
		0x0490, 0x04A0,
		0x2010, 0x2040,
		0x20A0, 0x20B0,
		0x2110, 0x2130,
		0x0600, 0x06FF,
		0xFB50, 0xFDFF,
		0xFE70, 0xFEFF,
		0
	};
	Log("GUI | Loading font: %s", pSettings->GetReadOnly().szFont);
	m_pFont = io.Fonts->AddFontFromFileTTF(path, m_fFontSize, nullptr, ranges);
	Log("GUI | ImFont pointer = 0x%X", m_pFont);

	extern const void* g_pHavanaArabicFontData;
	extern unsigned int g_pHavanaArabicFontSize;
	if (g_pHavanaArabicFontData && g_pHavanaArabicFontSize > 0)
	{
		static const ImWchar arabicRanges[] = { 0x0600,0x06FF, 0xFB50,0xFDFF, 0xFE70,0xFEFF, 0 };
		ImFontConfig cfg;
		cfg.MergeMode = true;
		cfg.PixelSnapH = true;
		cfg.FontDataOwnedByAtlas = false;
		io.Fonts->AddFontFromMemoryTTF((void*)g_pHavanaArabicFontData, (int)g_pHavanaArabicFontSize, m_fFontSize, &cfg, arabicRanges);
		Log("GUI | Merged Arabic font (%u bytes)", g_pHavanaArabicFontSize);
	}

	style.WindowRounding = 0.0f;

	m_pSplashTexture = nullptr;

	m_pSplashTexture = (RwTexture*)LoadTextureFromDB("txd", "splash_icon");

	CRadarRect::LoadTextures();

	m_bKeysStatus = false;
}

CGUI::~CGUI()
{
	ImGui_ImplRenderWare_ShutDown();
	ImGui::DestroyContext();
}
#include "..//CServerManager.h"
bool g_IsVoiceServer()
{
	return true;
}

extern float g_fMicrophoneButtonPosX;
extern float g_fMicrophoneButtonPosY;
extern uint32_t g_uiLastTickVoice;
#include "..//voice/CVoiceChatClient.h"
extern CVoiceChatClient* pVoice;

void CGUI::PreProcessInput()
{
	ImGuiIO& io = ImGui::GetIO();

	io.MousePos = m_vTouchPos;
	io.MouseDown[0] = m_bMouseDown;
	if (!m_bNeedClearMousePos && m_bNextClear)
	{
		m_bNextClear = false;
	}
	if (m_bNeedClearMousePos && m_bNextClear)
	{
		io.MousePos = ImVec2(-1, -1);
		m_bNextClear = true;
	}
}

void CGUI::PostProcessInput()
{
	ImGuiIO& io = ImGui::GetIO();

	if (m_bNeedClearMousePos && io.MouseDown[0])
	{
		return;
	}

	if (m_bNeedClearMousePos && !io.MouseDown[0])
	{
		io.MousePos = ImVec2(-1, -1);
		m_bNextClear = true;
	}
}

void CGUI::ResetTouchState()
{
	ImGuiIO& io = ImGui::GetIO();
	m_bMouseDown = false;
	m_vTouchPos = ImVec2(-1, -1);
	m_bNeedClearMousePos = false;
	m_bNextClear = false;
	io.MouseDown[0] = false;
	io.MousePos = ImVec2(-1, -1);
}
#include "..//CDebugInfo.h"
extern CGame* pGame;

void CGUI::SetHealth(float fhpcar){
   bHealth = static_cast<int>(fhpcar);
}

int CGUI::GetHealth(){
	return 1;//static_cast<int>(pVehicle->GetHealth());
}

void CGUI::SetDoor(int door){
	bDoor = door;
}

void CGUI::SetEngine(int engine){
	bEngine = engine;
}

void CGUI::SetLights(int lights){
	bLights = lights;
}

void CGUI::SetMeliage(float meliage){
	bMeliage = static_cast<int>(meliage);
}

void CGUI::SetEat(float eate){
	eat = static_cast<int>(eate);
}

int CGUI::GetEat(){
	return eat;
}

void CGUI::SetFuel(float fuel){
   m_fuel = static_cast<int>(fuel);
}

void CGUI::ShowSpeed(){
	if (!pGame || !pNetGame || !pGame->FindPlayerPed()->IsInVehicle()) {
		g_pJavaWrapper->HideSpeed();
		bMeliage =0;
		m_fuel = 0;
		return;
	}
	if (pGame->FindPlayerPed()->IsAPassenger()) {
		g_pJavaWrapper->HideSpeed();
		bMeliage =0;
		m_fuel = 0;
		return;
	}

	int i_speed = 0;
	bDoor =0;
	bEngine = 0;
	bLights = 0;
	float fHealth = 0;
	CVehicle *pVehicle = nullptr;
	CVehiclePool *pVehiclePool = pNetGame->GetVehiclePool();
	CPlayerPed *pPlayerPed = pGame->FindPlayerPed();
    VEHICLEID id = pVehiclePool->FindIDFromGtaPtr(pPlayerPed->GetGtaVehicle());
    pVehicle = pVehiclePool->GetAt(id);
    
    if(pPlayerPed)
    {
        if(pVehicle)
        {
            VECTOR vecMoveSpeed;
            pVehicle->GetMoveSpeedVector(&vecMoveSpeed);
            i_speed = sqrt((vecMoveSpeed.X * vecMoveSpeed.X) + (vecMoveSpeed.Y * vecMoveSpeed.Y) + (vecMoveSpeed.Z * vecMoveSpeed.Z)) * 180;
            bHealth = pVehicle->GetHealth();
            bDoor = pVehicle->GetDoorState();
            bEngine = pVehicle->GetEngineState();
            bLights = pVehicle->GetLightsState();
        }
    }
	g_pJavaWrapper->ShowSpeed();
	g_pJavaWrapper->UpdateSpeedInfo(i_speed, m_fuel, bHealth, bMeliage, bEngine, bLights, 0, bDoor);
}

void CGUI::Render()
{
	PreProcessInput();

	ProcessPushedTextdraws();
	if (pChatWindow)
	{
		pChatWindow->ProcessPushedCommands();
	}

	ImGui_ImplRenderWare_NewFrame();
	ImGui::NewFrame();

	

	RenderVersion();
	//RenderRakNetStatistics();

	if (pKeyBoard)
	{
		pKeyBoard->ProcessInputCommands();
	}

	if (pPlayerTags) pPlayerTags->Render();
	
	if(pNetGame && pNetGame->GetLabelPool())
	{
		pNetGame->GetLabelPool()->Draw();
	}

	if (pChatWindow) pChatWindow->Render();
	if(pGame) CGUI::ShowSpeed();
	if (pScoreBoard) pScoreBoard->Draw();
	if (pKeyBoard) pKeyBoard->Render();
	if (pDialogWindow) pDialogWindow->Render();
    if (pBankOverlay) pBankOverlay->Render();
    if (pCarRentOverlay) pCarRentOverlay->Render();
    if (pTrentPreviewOverlay) pTrentPreviewOverlay->Render();
    if (pGameTextOverlay) pGameTextOverlay->Render();
    if (pShop247Overlay) pShop247Overlay->Render();
    if (pInventoryOverlay) pInventoryOverlay->Render();
    if (pSkinShopOverlay)  pSkinShopOverlay->Render();
    if (pClothesShopOverlay) pClothesShopOverlay->Render();
    if (pAccessoryShopOverlay) pAccessoryShopOverlay->Render();
    if (pCarShopOverlay) pCarShopOverlay->Render();
    if (pHouseGuardOverlay) pHouseGuardOverlay->Render();
    if (pBrandOverlay)     pBrandOverlay->Render();
    if (pTest1Overlay)     pTest1Overlay->Render();
    if (pTest3Overlay)    pTest3Overlay->Render();
    if (pFlightJobOverlay) pFlightJobOverlay->Render();
    if (pFishermanOverlay) pFishermanOverlay->Render();
    if (pYtMusicOverlay)   pYtMusicOverlay->Render();
    if (pRobberyOverlay)   pRobberyOverlay->Render();
    if (pCarJackOverlay)   pCarJackOverlay->Render();
    if (pPoliceHudOverlay) pPoliceHudOverlay->Render();
    if (pTestInvOverlay)   pTestInvOverlay->Render();
    if (pFlyModsOverlay)   pFlyModsOverlay->Render();
    if (pGreenZoneOverlay) pGreenZoneOverlay->Render();
    if (pObjectEditorOverlay) pObjectEditorOverlay->Render();
    if (pIslandToolsOverlay) pIslandToolsOverlay->Render();

	if (pNetGame && !pDialogWindow->m_bIsActive && (!pPhoneOverlay || !pPhoneOverlay->IsVisible()) && pGame->IsToggledHUDElement(HUD_ELEMENT_BUTTONS))
	{
		ImGuiIO& io = ImGui::GetIO();
		ImVec2 vecButSize = ImVec2(ImGui::GetFontSize() * 3.5, ImGui::GetFontSize() * 2.5);
		ImGui::SetNextWindowPos(ImVec2(2.0f, io.DisplaySize.y / 2.8 - vecButSize.x / 2));

		// =========================================================
		// HavanaRp — professional sidebar key strip styling
		// =========================================================
		ImGuiStyle& _kbStyle = ImGui::GetStyle();
		float  _kb_oFR  = _kbStyle.FrameRounding;
		float  _kb_oFBS = _kbStyle.FrameBorderSize;
		float  _kb_oWR  = _kbStyle.WindowRounding;
		float  _kb_oWBS = _kbStyle.WindowBorderSize;
		ImVec2 _kb_oWP  = _kbStyle.WindowPadding;
		ImVec2 _kb_oIS  = _kbStyle.ItemSpacing;
		ImVec2 _kb_oIIS = _kbStyle.ItemInnerSpacing;
		_kbStyle.FrameRounding    = 14.0f;
		_kbStyle.FrameBorderSize  =  1.6f;
		_kbStyle.WindowRounding   = 18.0f;
		_kbStyle.WindowBorderSize =  1.4f;
		_kbStyle.WindowPadding    = ImVec2(10.0f, 8.0f);
		_kbStyle.ItemSpacing      = ImVec2(6.0f, 6.0f);
		_kbStyle.ItemInnerSpacing = ImVec2(6.0f, 6.0f);
		ImGui::PushStyleColor(ImGuiCol_WindowBg,        IM_COL32(14,  20,  16, 235));
		ImGui::PushStyleColor(ImGuiCol_Border,          IM_COL32(70,  90,  78, 220));
		ImGui::PushStyleColor(ImGuiCol_Button,          IM_COL32(28,  38,  32, 240));
		ImGui::PushStyleColor(ImGuiCol_ButtonHovered,   IM_COL32(54,  86,  64, 250));
		ImGui::PushStyleColor(ImGuiCol_ButtonActive,    IM_COL32(80, 170, 110, 255));
		ImGui::PushStyleColor(ImGuiCol_Text,            IM_COL32(232, 240, 232, 255));

		ImGui::Begin("###keys", nullptr,
			ImGuiWindowFlags_NoTitleBar |
			ImGuiWindowFlags_NoResize |
			ImGuiWindowFlags_NoScrollbar |
			ImGuiWindowFlags_NoSavedSettings |
			ImGuiWindowFlags_AlwaysAutoResize);

		if (ImGui::Button(m_bKeysStatus ? "<<" : ">>", vecButSize))
		{
			if (m_bKeysStatus)
				m_bKeysStatus = false;
			else
				m_bKeysStatus = true;
		}


		ImGui::SameLine();
		if(!pScoreBoard->m_bToggle) 
		{
			if (ImGui::Button("TAB", vecButSize))
			{
				pScoreBoard->Toggle();
			}
		}
		else 
		{
			if (ImGui::Button("X", vecButSize))
			{
				pScoreBoard->Toggle();
			}
		}
		ImGui::SameLine();
		if (ImGui::Button("Alt", vecButSize))
		{
			CPlayerPool* pPlayerPool = pNetGame->GetPlayerPool();
			if (pPlayerPool)
			{
				CLocalPlayer* pLocalPlayer;
				if (!pPlayerPool->GetLocalPlayer()->GetPlayerPed()->IsInVehicle() && !pPlayerPool->GetLocalPlayer()->GetPlayerPed()->IsAPassenger())
					LocalPlayerKeys.bKeys[ePadKeys::KEY_WALK] = true;
				else
					LocalPlayerKeys.bKeys[ePadKeys::KEY_FIRE] = true;
			}
		}

		ImGui::SameLine();
		CVehiclePool* pVehiclePool = pNetGame->GetVehiclePool();
		if (pVehiclePool)
		{
			VEHICLEID ClosetVehicleID = pVehiclePool->FindNearestToLocalPlayerPed();
			if (ClosetVehicleID < MAX_VEHICLES && pVehiclePool->GetSlotState(ClosetVehicleID))
			{
				CVehicle* pVehicle = pVehiclePool->GetAt(ClosetVehicleID);
				if (pVehicle)
				{
					if (pVehicle->GetDistanceFromLocalPlayerPed() < 5.0f)
					{
						CPlayerPool* pPlayerPool = pNetGame->GetPlayerPool();
						if (pPlayerPool)
						{
							CLocalPlayer* pLocalPlayer;
							if (!pPlayerPool->GetLocalPlayer()->GetPlayerPed()->IsInVehicle() && !pPlayerPool->GetLocalPlayer()->GetPlayerPed()->IsAPassenger())
							{
								if (ImGui::Button("G", vecButSize))
								{
									if (pNetGame)
									{
										if (pPlayerPool)
										{
											pLocalPlayer = pPlayerPool->GetLocalPlayer();
											if (pLocalPlayer)
											{
												pLocalPlayer->HandlePassengerEntryEx();
											}
										}
									}
								}
							}
							else
								if (pPlayerPool->GetLocalPlayer()->GetPlayerPed()->IsInVehicle() && !pPlayerPool->GetLocalPlayer()->GetPlayerPed()->IsAPassenger())
								{
									if (ImGui::Button("L. Ctrl", vecButSize))
									{
										LocalPlayerKeys.bKeys[ePadKeys::KEY_ACTION] = true;
									}
								}
							ImGui::SameLine();
						}
					}
				}
			}
		}
		if (m_bKeysStatus)
		{
			ImGui::SameLine();
			if (ImGui::Button("Y", vecButSize))
				LocalPlayerKeys.bKeys[ePadKeys::KEY_YES] = true;
			ImGui::SameLine();
			if (ImGui::Button("N", vecButSize))
				LocalPlayerKeys.bKeys[ePadKeys::KEY_NO] = true;
			ImGui::SameLine();
			if (ImGui::Button("H", vecButSize))
				LocalPlayerKeys.bKeys[ePadKeys::KEY_CTRL_BACK] = true;

		}
		ImGui::End();
		ImGui::PopStyleColor(6);
		_kbStyle.FrameRounding    = _kb_oFR;
		_kbStyle.FrameBorderSize  = _kb_oFBS;
		_kbStyle.WindowRounding   = _kb_oWR;
		_kbStyle.WindowBorderSize = _kb_oWBS;
		_kbStyle.WindowPadding    = _kb_oWP;
		_kbStyle.ItemSpacing      = _kb_oIS;
		_kbStyle.ItemInnerSpacing = _kb_oIIS;
	}

	extern bool g_bFlyModsActive;
	if (pNetGame && !g_bFlyModsActive)
	{
		if (pVoice && g_IsVoiceServer())
		{
			if (pVoice->IsRecording() && GetTickCount() - g_uiLastTickVoice >= 20000)
			{
				char buf[64];
				sprintf(&buf[0], "%d", (int)((30000 - (GetTickCount() - g_uiLastTickVoice)) / 1000) + 1);
				ImVec2 test(ScaleX(pSettings->GetReadOnly().fButtonMicrophoneX + pSettings->GetReadOnly().fButtonMicrophoneSize / 2.0f) - ImGui::CalcTextSize(&buf[0]).x / 2.0f, ScaleY(g_fMicrophoneButtonPosY) - GetFontSize() * 2.6f);
				//RenderText(test, 0xFF0000FF, true, &buf[0]);
			}
			ImVec2 centre(ScaleX(35.0f), ScaleY(35.0f));
			if (pVoice->IsDisconnected())
			{
				ImGui::GetBackgroundDrawList()->AddCircleFilled(centre, 18.0f, ImColor(1.0f, 0.0f, 0.0f));
			}
			if (pVoice->GetNetworkState() == VOICECHAT_CONNECTING || pVoice->GetNetworkState() == VOICECHAT_WAIT_CONNECT)
			{
				ImGui::GetBackgroundDrawList()->AddCircleFilled(centre, 18.0f, ImColor(1.0f, 1.0f, 0.0f));
			}
			if (pVoice->GetNetworkState() == VOICECHAT_CONNECTED)
			{
				ImGui::GetBackgroundDrawList()->AddCircleFilled(centre, 18.0f, ImColor(0.0f, 1.0f, 0.0f));
			}
		}
	}
    if (pPhoneOverlay)     pPhoneOverlay->Render();

	if (!g_bFlyModsActive) CDebugInfo::Draw();

	ImGui::EndFrame();
	ImGui::Render();
	ImGui_ImplRenderWare_RenderDrawData(ImGui::GetDrawData());

	PostProcessInput();
}

bool CGUI::OnTouchEvent(int type, bool multi, int x, int y)
{
	if (pPhoneOverlay && pPhoneOverlay->IsVisible())
	{
		if (pPhoneOverlay->IsKeyboardActive() && pKeyBoard && pKeyBoard->IsOpen())
			pKeyBoard->OnTouchEvent(type, multi, x, y);
		else if (pKeyBoard && pKeyBoard->IsOpen())
			pKeyBoard->Close();
		if (!pPhoneOverlay->IsVisible())
		{
			ResetTouchState();
			return false;
		}
		switch(type)
		{
			case TOUCH_PUSH:
				m_vTouchPos = ImVec2(x, y);
				m_bMouseDown = true;
				m_bNeedClearMousePos = false;
				break;
			case TOUCH_POP:
				m_bMouseDown = false;
				m_bNeedClearMousePos = true;
				break;
			case TOUCH_MOVE:
				m_bNeedClearMousePos = false;
				m_vTouchPos = ImVec2(x, y);
				break;
		}
		return false;
	}

	if (pObjectEditorOverlay && pObjectEditorOverlay->IsVisible() && pObjectEditorOverlay->HitTest((float)x, (float)y))
	{
		switch(type)
		{
			case TOUCH_PUSH:
				m_vTouchPos = ImVec2(x, y);
				m_bMouseDown = true;
				m_bNeedClearMousePos = false;
				break;

			case TOUCH_POP:
				m_bMouseDown = false;
				m_bNeedClearMousePos = true;
				break;

			case TOUCH_MOVE:
				m_bNeedClearMousePos = false;
				m_vTouchPos = ImVec2(x, y);
				break;
		}
		return false;
	}

	if ((pTest1Overlay && pTest1Overlay->IsVisible()) ||
        (pTestInvOverlay && pTestInvOverlay->IsVisible()))
	{
		switch(type)
		{
			case TOUCH_PUSH:
				m_vTouchPos = ImVec2(x, y);
				m_bMouseDown = true;
				m_bNeedClearMousePos = false;
				break;

			case TOUCH_POP:
				m_bMouseDown = false;
				m_bNeedClearMousePos = true;
				break;

			case TOUCH_MOVE:
				m_bNeedClearMousePos = false;
				m_vTouchPos = ImVec2(x, y);
				break;
		}
		return false;
	}

	if(!pKeyBoard->OnTouchEvent(type, multi, x, y)) return false;

	if (!pScoreBoard->OnTouchEvent(type, multi, x, y)) return false;

	bool bFalse = true;
	if (pNetGame)
	{
		if (pNetGame->GetTextDrawPool()->OnTouchEvent(type, multi, x, y))
		{
			if (!pChatWindow->OnTouchEvent(type, multi, x, y)) return false;
		}
		else
		{
			bFalse = false;
		}
	}

	switch(type)
	{
		case TOUCH_PUSH:
		{
			m_vTouchPos = ImVec2(x, y);
			m_bMouseDown = true;
			m_bNeedClearMousePos = false;
			break;
		}

		case TOUCH_POP:
		{
			m_bMouseDown = false;
			m_bNeedClearMousePos = true;
			break;
		}

		case TOUCH_MOVE:
		{
			m_bNeedClearMousePos = false;
			m_vTouchPos = ImVec2(x, y);
			break;
		}
	}
	if (!bFalse)
	{
		return false;
	}
	return true;
}

void CGUI::RenderVersion()
{
	return;

	ImGui::GetOverlayDrawList()->AddText(
		ImVec2(ScaleX(10), ScaleY(10)), 
		ImColor(IM_COL32_BLACK), PORT_VERSION);
}

void CGUI::ProcessPushedTextdraws()
{
	BUFFERED_COMMAND_TEXTDRAW* pCmd = nullptr;
	while (pCmd = m_BufferedCommandTextdraws.ReadLock())
	{
		RakNet::BitStream bs;
		bs.Write(pCmd->textdrawId);
		pNetGame->GetRakClient()->RPC(&RPC_ClickTextDraw, &bs, HIGH_PRIORITY, RELIABLE_SEQUENCED, 0, false, UNASSIGNED_NETWORK_ID, 0);
		m_BufferedCommandTextdraws.ReadUnlock();
	}
}

void CGUI::RenderRakNetStatistics()
{
		//StatisticsToString(rss, message, 0);

		/*ImGui::GetOverlayDrawList()->AddText(
			ImVec2(ScaleX(10), ScaleY(400)),
			ImColor(IM_COL32_BLACK), message);*/
}

extern uint32_t g_uiBorderedText;
void CGUI::RenderTextForChatWindow(ImVec2& posCur, ImU32 col, bool bOutline, const char* text_begin, const char* text_end)
{
	int iOffset = pSettings->GetReadOnly().iFontOutline;

	ImColor colOutline = ImColor(IM_COL32_BLACK);
	ImColor colDef = ImColor(col);
	colOutline.Value.w = colDef.Value.w;

	if (bOutline)
	{
		if (g_uiBorderedText)
		{
			posCur.x -= iOffset;
			ImGui::GetBackgroundDrawList()->AddText(posCur, colOutline, text_begin, text_end);
			posCur.x += iOffset;
			// right 
			posCur.x += iOffset;
			ImGui::GetBackgroundDrawList()->AddText(posCur, colOutline, text_begin, text_end);
			posCur.x -= iOffset;
			// above
			posCur.y -= iOffset;
			ImGui::GetBackgroundDrawList()->AddText(posCur, colOutline, text_begin, text_end);
			posCur.y += iOffset;
			// below
			posCur.y += iOffset;
			ImGui::GetBackgroundDrawList()->AddText(posCur, colOutline, text_begin, text_end);
			posCur.y -= iOffset;
		}
		else
		{
			ImColor co(0.0f, 0.0f, 0.0f, 0.4f);
			if (colOutline.Value.w <= 0.4)
			{
				co.Value.w = colOutline.Value.w;
			}
			ImVec2 b(posCur.x + ImGui::CalcTextSize(text_begin, text_end).x, posCur.y + GetFontSize());
			ImGui::GetBackgroundDrawList()->AddRectFilled(posCur, b, co);
		}
	}

	ImGui::GetBackgroundDrawList()->AddText(posCur, col, text_begin, text_end);
}

void CGUI::PushToBufferedQueueTextDrawPressed(uint16_t textdrawId)
{
	BUFFERED_COMMAND_TEXTDRAW* pCmd = m_BufferedCommandTextdraws.WriteLock();

	pCmd->textdrawId = textdrawId;

	m_BufferedCommandTextdraws.WriteUnlock();
}

void CGUI::RenderText(ImVec2& posCur, ImU32 col, bool bOutline, const char* text_begin, const char* text_end)
{
	int iOffset = pSettings->GetReadOnly().iFontOutline;

	if (bOutline)
	{
		if (g_uiBorderedText)
		{
			posCur.x -= iOffset;
			ImGui::GetBackgroundDrawList()->AddText(posCur, ImColor(IM_COL32_BLACK), text_begin, text_end);
			posCur.x += iOffset;
			// right 
			posCur.x += iOffset;
			ImGui::GetBackgroundDrawList()->AddText(posCur, ImColor(IM_COL32_BLACK), text_begin, text_end);
			posCur.x -= iOffset;
			// above
			posCur.y -= iOffset;
			ImGui::GetBackgroundDrawList()->AddText(posCur, ImColor(IM_COL32_BLACK), text_begin, text_end);
			posCur.y += iOffset;
			// below
			posCur.y += iOffset;
			ImGui::GetBackgroundDrawList()->AddText(posCur, ImColor(IM_COL32_BLACK), text_begin, text_end);
			posCur.y -= iOffset;
		}
		else
		{
			ImVec2 b(posCur.x + ImGui::CalcTextSize(text_begin, text_end).x, posCur.y + GetFontSize());
			if (m_pSplashTexture)
			{
				ImColor co(1.0f, 1.0f, 1.0f, 0.4f);
				ImGui::GetBackgroundDrawList()->AddImage((ImTextureID)m_pSplashTexture->raster, posCur, b, ImVec2(0, 0), ImVec2(1, 1), co);
			}
			else
			{
				ImColor co(0.0f, 0.0f, 0.0f, 0.4f);
				ImGui::GetBackgroundDrawList()->AddRectFilled(posCur, b, co);
			}
		}
	}

	ImGui::GetBackgroundDrawList()->AddText(posCur, col, text_begin, text_end);
}