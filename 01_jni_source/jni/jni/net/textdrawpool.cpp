#include "../main.h"
#include "../game/game.h"
#include "netgame.h"
#include "../gui/gui.h"

extern CGame* pGame;
extern CGUI* pGUI;

//----------------------------------------------------

CTextDrawPool::CTextDrawPool()
{
	CTouchListenerLock(this);

	int x = 0;
	while (x != MAX_TEXT_DRAWS) {
		m_pTextDraw[x] = NULL;
		m_bSlotState[x] = FALSE;
		x++;
	}
	m_bSelectState = false;
}

//----------------------------------------------------

CTextDrawPool::~CTextDrawPool()
{
	CTouchListenerLock(this);

	int x = 0;
	while (x != MAX_TEXT_DRAWS)
	{
		if (m_pTextDraw[x]) {
			delete m_pTextDraw[x];
			m_pTextDraw[x] = NULL;
			m_bSlotState[x] = FALSE;
		}
		x++;
	}
}

//----------------------------------------------------

CTextDraw* CTextDrawPool::New(uint16_t wText, TEXT_DRAW_TRANSMIT* TextDrawTransmit, char* szText)
{
	if (wText > MAX_TEXT_DRAWS || wText < 0) return nullptr;
	if (m_pTextDraw[wText]) Delete(wText);

	CTextDraw* pTextDraw = new CTextDraw(TextDrawTransmit, szText);

	if (pTextDraw)
	{
		CTouchListenerLock(this);

		m_pTextDraw[wText] = pTextDraw;
		m_bSlotState[wText] = TRUE;

		return pTextDraw;
	}
	return NULL;
}

//----------------------------------------------------

void CTextDrawPool::Delete(uint16_t wText)
{
	if (m_pTextDraw[wText])
	{
		CTouchListenerLock(this);

		delete m_pTextDraw[wText];
		m_pTextDraw[wText] = NULL;
		m_bSlotState[wText] = FALSE;
	}
}

//----------------------------------------------------

// [SKIN SHOP OVERLAY] Allow the skin-shop overlay to hide a small set of
// gamemode-supplied textdraws (price banner / SELECT / EXIT / arrows) while
// our replacement professional UI is on screen. The overlay sets the IDs
// to suppress; we just skip them during Draw().
extern bool SkinShop_IsTextdrawHidden(int td_id);

void CTextDrawPool::Draw()
{
	int x = 0;

	while (x != MAX_TEXT_DRAWS) {
		if (m_bSlotState[x])
		{
			if (!SkinShop_IsTextdrawHidden(x))
			{
				m_pTextDraw[x]->Draw();
			}
		}
		x++;
	}
}
#include "..//chatwindow.h"
#include "..//dialog.h"
extern CDialogWindow* pDialogWindow;
extern CChatWindow* pChatWindow;
bool CTextDrawPool::OnTouchEvent(int type, int num, int x, int y)
{
	CTouchListenerLock(this);
	if (m_bSelectState == false) return true;

	// [SKIN SHOP OVERLAY] Skip native hit-testing for textdraws our
	// replacement UI is currently consuming so the touch flows through
	// to ImGui and our big buttons can fire.
	(void)0;

	static bool bWannaClick = false;

	if (pDialogWindow)
	{
		if (pDialogWindow->m_bRendered)
		{
			return true;
		}
	}

	int id = 0;

	while (id != MAX_TEXT_DRAWS)
	{
		if (m_bSlotState[id] && m_pTextDraw[id])
		{
			if (!m_pTextDraw[id]->m_TextDrawData.byteSelectable)
			{
				id++;
				continue;
			}

			// [SKIN SHOP OVERLAY] If this textdraw is one our replacement
			// shop UI is responsible for, skip native click handling so
			// the touch flows through to our overlay button.
			if (SkinShop_IsTextdrawHidden(id))
			{
				id++;
				continue;
			}

			switch (type)
			{
			case TOUCH_PUSH:
				if (IsPointInRect(x, y, &(m_pTextDraw[id]->m_rectArea)))
				{
					bWannaClick = true;
					return false;
				}
				break;

			case TOUCH_POP:
				if (IsPointInRect(x, y, &(m_pTextDraw[id]->m_rectArea)))
				{
					//Log("%f %f %f %f", m_pTextDraw[id]->m_rectArea.fLeft, m_pTextDraw[id]->m_rectArea.fRight, m_pTextDraw[id]->m_rectArea.fBottom, m_pTextDraw[id]->m_rectArea.fTop);
					pGUI->PushToBufferedQueueTextDrawPressed((uint16_t)id);
					return false;
				}
				bWannaClick = false;
				break;

			case TOUCH_MOVE:
				break;
			}
		}
		id++;
	}

	return true;
}

void CTextDrawPool::SetSelectState(bool bState, uint32_t dwColor)
{
	if (bState)
	{
		m_bSelectState = true;
		pGame->DisplayHUD(false);
		pGame->FindPlayerPed()->TogglePlayerControllable(false);
	}
	else {
		m_bSelectState = false;
		pGame->DisplayHUD(true);
		pGame->FindPlayerPed()->TogglePlayerControllable(true);
	}
}

void CTextDrawPool::SnapshotProcess()
{
	for (int i = 0; i < MAX_TEXT_DRAWS; i++)
	{
		if (m_bSlotState[i] && m_pTextDraw[i]) {
			m_pTextDraw[i]->SnapshotProcess();
		}
	}
}

//----------------------------------------------------