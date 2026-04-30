#include "../main.h"
#include "game.h"
#include "CAdjustableHudPosition.h"
#include "..//chatwindow.h"

#include <sstream>
#include <iomanip>
extern CChatWindow* pChatWindow;
CVector2D CAdjustableHudPosition::m_aPosition[E_HUD_ELEMENT::HUD_SIZE];

// [FIX] The m_aPosition array is static -> zero-initialized by default. The
// CFont__PrintString_hook decides whether to override money/ammo/wanted
// positions by checking "X != -1". Because the default is 0 (not -1), the
// hook was overriding every HUD element's position to ScaleX(0) = 0 = the
// top-left corner of the screen, so money and ammo text were being rendered
// on top of the radar. This helper runs before main() via the global ctor
// and seeds every slot with (-1, -1) so unconfigured elements use the stock
// GTA:SA HUD layout (money top-right, ammo below weapon icon, etc.).
struct _AdjustableHudPositionDefaults
{
	_AdjustableHudPositionDefaults()
	{
		for (int i = 0; i < E_HUD_ELEMENT::HUD_SIZE; i++)
		{
			CAdjustableHudPosition::m_aPosition[i].X = -1;
			CAdjustableHudPosition::m_aPosition[i].Y = -1;
		}
	}
};
static _AdjustableHudPositionDefaults g_AdjustableHudPositionDefaults;

CVector2D CAdjustableHudPosition::GetElementPosition(E_HUD_ELEMENT id)
{
	if (id < E_HUD_ELEMENT::HUD_HP || id >= E_HUD_ELEMENT::HUD_SIZE)
	{
		return CVector2D();
	}

	CVector2D retn = m_aPosition[id];
	return retn;
}

void CAdjustableHudPosition::SetElementPosition(E_HUD_ELEMENT id, int x, int y)
{
	if (id < E_HUD_ELEMENT::HUD_HP || id >= E_HUD_ELEMENT::HUD_SIZE)
	{
		return;
	}

	m_aPosition[id].X = x;
	m_aPosition[id].Y = y;

	if (x <= 5)
	{
		m_aPosition[id].X = -1;
	}
	if (y <= 5)
	{
		m_aPosition[id].Y = -1;
	}

}
