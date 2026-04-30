#include "../main.h"
#include "game.h"
#include "CAdjustableHudScale.h"
#include "..//chatwindow.h"

#include <sstream>
#include <iomanip>
extern CChatWindow* pChatWindow;
CVector2D CAdjustableHudScale::m_aScale[E_HUD_ELEMENT::HUD_SIZE];

// [FIX] Same bug as in CAdjustableHudPosition.cpp: static array defaults to
// (0, 0), but the HUD hook treats only (-1, -1) as "unset". Seed every slot
// with -1 so the native GTA:SA scale is used when the user hasn't customized.
struct _AdjustableHudScaleDefaults
{
	_AdjustableHudScaleDefaults()
	{
		for (int i = 0; i < E_HUD_ELEMENT::HUD_SIZE; i++)
		{
			CAdjustableHudScale::m_aScale[i].X = -1;
			CAdjustableHudScale::m_aScale[i].Y = -1;
		}
	}
};
static _AdjustableHudScaleDefaults g_AdjustableHudScaleDefaults;

CVector2D CAdjustableHudScale::GetElementScale(E_HUD_ELEMENT id)
{
	if (id < E_HUD_ELEMENT::HUD_HP || id >= E_HUD_ELEMENT::HUD_SIZE)
	{
		return CVector2D();
	}
	return m_aScale[id];
}

void CAdjustableHudScale::SetElementScale(E_HUD_ELEMENT id, int x, int y)
{
	if (id < E_HUD_ELEMENT::HUD_HP || id >= E_HUD_ELEMENT::HUD_SIZE)
	{
		return;
	}

	m_aScale[id].X = x;
	m_aScale[id].Y = y;

	if (x <= 5)
	{
		m_aScale[id].X = -1;
	}
	if (y <= 5)
	{
		m_aScale[id].Y = -1;
	}
}
