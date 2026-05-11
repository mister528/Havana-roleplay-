#include "../main.h"
#include "font.h"

void CFont::AsciiToGxtChar(const char* ascii, uint16_t* gxt)
{
	return ((void(*)(const char*, uint16_t*))(g_libGTASA + 0x532D00 + 1))(ascii, gxt);
}

void CFont::SetScale(float x, float y)
{
	*(float*)(g_libGTASA + 0x99D750) = x;
	*(float*)(g_libGTASA + 0x99D754) = y;
}

void CFont::SetColor(uint32_t* dwColor)
{
	return ((void(*)(uint32_t*))(g_libGTASA + 0x5336F4 + 1))(dwColor);
}

void CFont::SetJustify(uint8_t justify)
{
	return ((void(*)(uint8_t))(g_libGTASA + 0x5339D0 + 1))(justify);
}

void CFont::SetOrientation(uint8_t orientation)
{
	return ((void(*)(uint8_t))(g_libGTASA + 0x5339E8 + 1))(orientation);
}

void CFont::SetWrapX(float wrapX)
{
	return ((void(*)(float))(g_libGTASA + 0x53381C + 1))(wrapX);
}

void CFont::SetCentreSize(float size)
{
	return ((void(*)(float))(g_libGTASA + 0x533834 + 1))(size);
}
void Font_SetRightJustifyWrap(float wrap)
{
	((int (*)(float))(g_libGTASA + 0x0053384C + 1))(wrap);
	//0053384C
}

void CFont::SetBackground(uint8_t bBackground, uint8_t bOnlyText)
{
	return ((void(*)(uint8_t, uint8_t))(g_libGTASA + 0x533988 + 1))(bBackground, bOnlyText);
}

void CFont::SetBackgroundColor(uint32_t* dwColor)
{
	return ((void(*)(uint32_t*))(g_libGTASA + 0x5339A4 + 1))(dwColor);
}

void CFont::SetProportional(uint8_t prop)
{
	return ((void(*)(uint8_t))(g_libGTASA + 0x533970 + 1))(prop);
}

void CFont::SetDropColor(uint32_t* dwColor)
{
	return ((void(*)(uint32_t*))(g_libGTASA + 0x53387C + 1))(dwColor);
}

void CFont::SetDropShadowPosition(uint8_t pos)
{
	return ((void(*)(uint8_t))(g_libGTASA + 0x5338DC + 1))(pos);
}

/*
void CFont::PrintString(float fX, float fY, const uint16_t* szText)
{
	return ((void(*)(float, float, const uint16_t*))(g_libGTASA + 0x5353B4 + 1))(fX, fY, szText);
}
*/

void CFont::PrintString(float posX, float posY, const char* string)
{
	// SA-MP textdraw strings can be up to 800 bytes, and the underlying
	// AsciiToGxtChar writes one UTF-16 code unit per input byte (plus some
	// expansion for colour/keycode tokens). The old 0xFF-sized buffer was
	// too small for anything longer than ~255 chars, which made CFont's
	// GetNextSpace walk past the end and crash when drawing long / Arabic
	// strings (map screen / HUD crashes).
	if (!string) return;
	const int kMax = 0x1000; // 4096 UTF-16 code units
	uint16_t* gxt_string = new uint16_t[kMax];
	// Zero the buffer so a missing terminator in AsciiToGxtChar can't let
	// the game walk into garbage past the end.
	for (int i = 0; i < kMax; ++i) gxt_string[i] = 0;

	// Defensively cap the input: if the caller somehow passes a huge blob
	// we slice it instead of letting AsciiToGxtChar overflow our buffer.
	size_t inLen = 0;
	while (string[inLen] && inLen < (size_t)(kMax - 2)) ++inLen;
	if (inLen == (size_t)(kMax - 2))
	{
		char tmp[0x1000];
		for (size_t i = 0; i < inLen; ++i) tmp[i] = string[i];
		tmp[inLen] = 0;
		CFont::AsciiToGxtChar(tmp, gxt_string);
	}
	else
	{
		CFont::AsciiToGxtChar(string, gxt_string);
	}
	// Guarantee a terminator at the end of our buffer.
	gxt_string[kMax - 1] = 0;

	((void (*)(float, float, uint16_t*))(g_libGTASA + 0x5353B4 + 1))(posX, posY, gxt_string);
	delete[] gxt_string;
	((void (*)())(g_libGTASA + 0x53411C + 1))();//53411C ; _DWORD CFont::RenderFontBuffer(CFont *__hidden this)
}

void CFont::SetFontStyle(uint8_t style)
{
	return ((void(*)(uint8_t))(g_libGTASA + 0x533748 + 1))(style);
}

void CFont::SetEdge(uint8_t edge)
{
	return ((void(*)(uint8_t))(g_libGTASA + 0x53394C + 1))(edge);
}