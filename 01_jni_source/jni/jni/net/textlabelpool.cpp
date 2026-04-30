#include "../main.h"
#include "../gui/gui.h"
#include "../game/game.h"
#include "../chatwindow.h"
#include "../arabic.h"
#include "netgame.h"
#include <vector>
#include <string>

extern CNetGame *pNetGame;
extern CChatWindow *pChatWindow;
extern CGUI *pGUI;

void TextWithColors(ImVec2 pos, ImColor col, const char* szStr, const char* szStrWithoutColors);

void CText3DLabelsPool::DrawNonAttached(TEXT_LABELS* pLabel)
{
	if (!pLabel)
	{
		return;
	}
	if (!pNetGame)
	{
		return;
	}
	if (!pNetGame->GetPlayerPool())
	{
		return;
	}
	VECTOR pos;
	memcpy((void*)&pos, (const void*)&(pLabel->pos), sizeof(VECTOR));
	DrawTextLabel(pLabel, &pos);
}

void CText3DLabelsPool::DrawAttachedToPlayer(TEXT_LABELS* pLabel)
{
	if (!pLabel)
	{
		return;
	}
	VECTOR pos;
	memset((void*)&pos, 0, sizeof(VECTOR));

	PLAYERID playerId = pLabel->attachedToPlayerID;

	CPlayerPool* pPlayerPool = nullptr;
	if (pNetGame)
	{
		pPlayerPool = pNetGame->GetPlayerPool();
	}
	if (!pPlayerPool)
	{
		return;
	}

	if (!pPlayerPool->GetSlotState(playerId))
	{
		return;
	}

	CRemotePlayer* pPlayer = pPlayerPool->GetAt(playerId);
	if (!pPlayer)
	{
		return;
	}
	if (!pPlayer->GetPlayerPed())
	{
		return;
	}
	CPlayerPed* pPlayerPed = pPlayer->GetPlayerPed();
	if (!pPlayerPed->IsAdded())
	{
		return;
	}
	VECTOR boneOut;
	pPlayerPed->GetBonePosition(5, &boneOut);

	memcpy((void*)&pos, (const void*)&boneOut, sizeof(VECTOR));

	pos.X += pLabel->offsetCoords.X;
	pos.Y += pLabel->offsetCoords.Y;
	pos.Z += pLabel->offsetCoords.Z;

	DrawTextLabel(pLabel, &pos);
}

void CText3DLabelsPool::DrawAttachedToVehicle(TEXT_LABELS* pLabel)
{
	if (!pLabel)
	{
		return;
	}
	VECTOR pos;
	memset((void*)&pos, 0, sizeof(VECTOR));

	VEHICLEID vehId = pLabel->attachedToVehicleID;

	CVehiclePool* pVehiclePool = nullptr;
	if (pNetGame)
	{
		pVehiclePool = pNetGame->GetVehiclePool();
	}
	if (!pVehiclePool)
	{
		return;
	}

	if (!pVehiclePool->GetSlotState(vehId))
	{
		return;
	}

	CVehicle* pVehicle = pVehiclePool->GetAt(vehId);
	if (!pVehicle)
	{
		return;
	}
	if (!pVehicle->IsAdded())
	{
		return;
	}
	MATRIX4X4 mat;
	memset((void*)& mat, 0, sizeof(MATRIX4X4));

	pVehicle->GetMatrix(&mat);

	memcpy((void*)& pos, (const void*)& mat.pos, sizeof(VECTOR));

	pos.X += pLabel->offsetCoords.X;
	pos.Y += pLabel->offsetCoords.Y;
	pos.Z += pLabel->offsetCoords.Z;

	DrawTextLabel(pLabel, &pos);
}

void CText3DLabelsPool::DrawTextLabel(TEXT_LABELS* pLabel, VECTOR* pPos)
{
	int hitEntity = 0;
	if (!pNetGame->GetPlayerPool()->GetLocalPlayer())
	{
		return;
	}
	CPlayerPed* pPed = pNetGame->GetPlayerPool()->GetLocalPlayer()->GetPlayerPed();
	if (!pPed)
	{
		return;
	}
	if (!pPed->IsAdded())
	{
		return;
	}

	if (pLabel->useLineOfSight)
	{
		CAMERA_AIM* pCam = GameGetInternalAim();
		if (!pCam)
		{
			return;
		}

		hitEntity = ScriptCommand(&get_line_of_sight,
			pPos->X, pPos->Y, pPos->Z,
			pCam->pos1x, pCam->pos1y, pCam->pos1z,
			1, 0, 0, 0, 0);
	}

	if (!pLabel->useLineOfSight || hitEntity)
	{
		if (pPed->GetDistanceFromPoint(pPos->X, pPos->Y, pPos->Z) <= pLabel->drawDistance)
		{
			VECTOR Out;
			memset((void*)&Out, 0, sizeof(VECTOR));
			// CSprite::CalcScreenCoors
			((void (*)(VECTOR*, VECTOR*, float*, float*, bool, bool))(g_libGTASA + 0x54EEC0 + 1))(pPos, &Out, 0, 0, 0, 0);
			if (Out.Z < 1.0f)
			{
				return;
			}

			ImVec2 pos = ImVec2(Out.X, Out.Y);

			if (pLabel->m_fTrueX < 0.0f)
			{
				char* curBegin = pLabel->textWithoutColors;
				char* curPos = pLabel->textWithoutColors;
				while (*curPos != '\0')
				{
					if (*curPos == '\n')
					{
						float width = ImGui::CalcTextSize(curBegin, (char*)(curPos - 1)).x;
						if (width > pLabel->m_fTrueX)
						{
							pLabel->m_fTrueX = width;
						}

						curBegin = curPos + 1;
					}

					curPos++;
				}

				if (pLabel->m_fTrueX < 0.0f)
				{
					pLabel->m_fTrueX = ImGui::CalcTextSize(pLabel->textWithoutColors).x;
				}

			}

			//pos.x -= (pLabel->m_fTrueX / 2.0f);

			TextWithColors(pos, __builtin_bswap32(pLabel->color), pLabel->text, pLabel->textWithoutColors);
		}
	}
}

CText3DLabelsPool::CText3DLabelsPool()
{
	for(int i = 0; i < TEXT_LABEL_POOL_SIZE; i++)
	{
		m_pTextLabels[i] = nullptr;
		m_bSlotState[i] = false;
	}
}

CText3DLabelsPool::~CText3DLabelsPool()
{
	for (int i = 0; i < TEXT_LABEL_POOL_SIZE; i++)
	{
		if (m_pTextLabels[i] && m_bSlotState[i])
		{
			m_bSlotState[i] = false;

			m_pTextLabels[i]->text[0] = '\0';

			delete m_pTextLabels[i];
			m_pTextLabels[i] = nullptr;
		}
	}
}

void FilterColors(char* szStr)
{
	if(!szStr) return;

	char szNonColored[2048+1];
	int iNonColoredMsgLen = 0;

	for(int pos = 0; pos < strlen(szStr) && szStr[pos] != '\0'; pos++)
	{
		if(pos+7 < strlen(szStr))
		{
			if(szStr[pos] == '{' && szStr[pos+7] == '}')
			{
				pos += 7;
				continue;
			}
		}

		szNonColored[iNonColoredMsgLen] = szStr[pos];
		iNonColoredMsgLen++;
	}

	szNonColored[iNonColoredMsgLen] = 0;
	strcpy(szStr, szNonColored);
}

void CText3DLabelsPool::CreateTextLabel(int labelID, char* text, uint32_t color, 
	float posX, float posY, float posZ, float drawDistance, bool useLOS, PLAYERID attachedToPlayerID, VEHICLEID attachedToVehicleID)
{
	if (labelID < 0 || labelID >= TEXT_LABEL_POOL_SIZE)
	{
		return;
	}
	if (m_pTextLabels[labelID])
	{
		delete m_pTextLabels[labelID];
		m_pTextLabels[labelID] = nullptr;
		m_bSlotState[labelID] = false;
	}

	TEXT_LABELS* pTextLabel = new TEXT_LABELS;
	Log("CREATE LABEL");
	if (pTextLabel)
	{
		//pTextLabel->text = text;
		cp1251_to_utf8(pTextLabel->text, text);
		cp1251_to_utf8(pTextLabel->textWithoutColors, text);
		FilterColors(pTextLabel->textWithoutColors);

		pTextLabel->color = color;
		pTextLabel->pos.X = posX;
		pTextLabel->pos.Y = posY;
		pTextLabel->pos.Z = posZ;
		pTextLabel->drawDistance = drawDistance;
		pTextLabel->useLineOfSight = useLOS;
		pTextLabel->attachedToPlayerID = attachedToPlayerID;
		pTextLabel->attachedToVehicleID = attachedToVehicleID;

		pTextLabel->m_fTrueX = -1.0f;

		if (attachedToVehicleID != INVALID_VEHICLE_ID || attachedToPlayerID != INVALID_PLAYER_ID)
		{
			pTextLabel->offsetCoords.X = posX;
			pTextLabel->offsetCoords.Y = posY;
			pTextLabel->offsetCoords.Z = posZ;
		}

		m_pTextLabels[labelID] = pTextLabel;
		m_bSlotState[labelID] = true;
	}
}

void CText3DLabelsPool::Delete(int labelID)
{
	if (labelID < 0 || labelID >= TEXT_LABEL_POOL_SIZE)
	{
		return;
	}
	Log("DELETE LABEL");
	m_bSlotState[labelID] = false;
	if (m_pTextLabels[labelID])
	{
		delete m_pTextLabels[labelID];
		m_pTextLabels[labelID] = nullptr;
	}
}

void CText3DLabelsPool::AttachToPlayer(int labelID, PLAYERID playerID, VECTOR pos)
{
	if (labelID < 0 || labelID >= TEXT_LABEL_POOL_SIZE)
	{
		return;
	}
	if (m_bSlotState[labelID] == true && m_pTextLabels[labelID])
	{
		//tempPlayerID = playerID;
		m_pTextLabels[labelID]->attachedToPlayerID = playerID;
		m_pTextLabels[labelID]->pos = pos;
		m_pTextLabels[labelID]->offsetCoords = pos;
	}
}

void CText3DLabelsPool::AttachToVehicle(int labelID, VEHICLEID vehicleID, VECTOR pos)
{
	if (labelID < 0 || labelID >= TEXT_LABEL_POOL_SIZE)
	{
		return;
	}
	if (m_bSlotState[labelID] == true && m_pTextLabels[labelID])
	{
		m_pTextLabels[labelID]->attachedToVehicleID = vehicleID;
		m_pTextLabels[labelID]->pos = pos;
		m_pTextLabels[labelID]->offsetCoords = pos;
	}
}

void CText3DLabelsPool::Update3DLabel(int labelID, uint32_t color, char* text)
{
	if (labelID < 0 || labelID >= TEXT_LABEL_POOL_SIZE)
	{
		return;
	}
	Log("UPDATE LABEL");
	if (m_bSlotState[labelID] == true && m_pTextLabels[labelID])
	{
		m_pTextLabels[labelID]->color = color;
		//m_pTextLabels[labelID]->text = text;
		cp1251_to_utf8(m_pTextLabels[labelID]->text, text);
	}
}

bool ProcessInlineHexColor(const char* start, const char* end, ImVec4& color);

namespace
{
	uint32_t PackColorTL(const ImColor& c)
	{
		auto clamp01 = [](float v) { return v < 0.0f ? 0.0f : (v > 1.0f ? 1.0f : v); };
		uint8_t r = (uint8_t)(clamp01(c.Value.x) * 255.0f + 0.5f);
		uint8_t g = (uint8_t)(clamp01(c.Value.y) * 255.0f + 0.5f);
		uint8_t b = (uint8_t)(clamp01(c.Value.z) * 255.0f + 0.5f);
		uint8_t a = (uint8_t)(clamp01(c.Value.w) * 255.0f + 0.5f);
		return (uint32_t(a) << 24) | (uint32_t(r) << 16) | (uint32_t(g) << 8) | uint32_t(b);
	}

	ImColor UnpackColorTL(uint32_t v)
	{
		float r = ((v >> 16) & 0xFF) / 255.0f;
		float g = ((v >>  8) & 0xFF) / 255.0f;
		float b = ((v      ) & 0xFF) / 255.0f;
		float a = ((v >> 24) & 0xFF) / 255.0f;
		return ImColor(r, g, b, a);
	}

	struct TLRenderCtx
	{
		ImVec2 origin; // top-left of this line
	};

	float TLDrawRunCb(const char* utf8, int len, uint32_t color_id,
	                  float x_off, void* user)
	{
		auto* ctx = static_cast<TLRenderCtx*>(user);
		ImVec2 drawPos(ctx->origin.x + x_off, ctx->origin.y);
		pGUI->RenderText(drawPos, UnpackColorTL(color_id), true,
		                 utf8, utf8 + len);
		return ImGui::CalcTextSize(utf8, utf8 + len).x;
	}
}

void TextWithColors(ImVec2 pos, ImColor col, const char* szStr, const char* szStrWithoutColors = nullptr)
{
	if (pNetGame)
	{
		if (pNetGame->GetPlayerPool())
		{
			if (pNetGame->GetPlayerPool()->GetLocalPlayer())
			{
				CLocalPlayer* pPlayer = pNetGame->GetPlayerPool()->GetLocalPlayer();
				if (pPlayer->GetPlayerPed())
				{
					if (pPlayer->GetPlayerPed()->GetActionTrigger() == ACTION_DEATH || pPlayer->GetPlayerPed()->IsDead())
					{
						return;
					}

					
				}
			}
		}
	}
	float fLineOffsets[100];

	int iCounter = 0;
	if (szStrWithoutColors)
	{
		const char* curBegin = szStrWithoutColors;
		const char* curPos = szStrWithoutColors;
		while (*curPos != '\0')
		{
			if (*curPos == '\n')
			{
				float width = ImGui::CalcTextSize(curBegin, (char*)(curPos - 1)).x;
				width /= 2.0f;

				fLineOffsets[iCounter] = width;
				iCounter++;

				curBegin = curPos + 1;
			}
			curPos++;
			if (*curPos == '\0')
			{
				float width = ImGui::CalcTextSize(curBegin, (char*)(curPos - 1)).x;
				width /= 2.0f;

				fLineOffsets[iCounter] = width;
				iCounter++;
			}
		}
	}
	
	iCounter = 0;
	char tempStr[4096];

	ImVec2 vecPos = pos;

	strcpy(tempStr, szStr);
	tempStr[sizeof(tempStr) - 1] = '\0';

	const char* textStart = tempStr;
	const char* textCur = tempStr;

	if (szStrWithoutColors)
	{
		vecPos.x -= fLineOffsets[0];
	}

	// Collect logical-order coloured chunks for the current line and
	// flush them through Arabic::RenderColouredLine on '\n' / end of
	// string. This makes BiDi work across the whole label paragraph
	// instead of each colour segment being shaped independently
	// (which placed Latin tokens in the wrong visual position when
	// the surrounding text was Arabic).
	std::vector<Arabic::ColouredChunk> chunks;
	std::vector<std::string>           chunk_storage; // owns chunk text

	auto flushLine = [&]()
	{
		if (chunks.empty())
		{
			vecPos.y += pGUI->GetFontSize();
			return;
		}
		// chunk.utf8 pointers come from chunk_storage[i].c_str().
		// Re-link in case any storage entries grew their backing buffer.
		for (size_t i = 0; i < chunks.size(); ++i)
			chunks[i].utf8 = chunk_storage[i].c_str();

		TLRenderCtx ctx;
		ctx.origin = vecPos;
		Arabic::RenderColouredLine(chunks.data(), (int)chunks.size(),
		                           TLDrawRunCb, &ctx);
		chunks.clear();
		chunk_storage.clear();
		vecPos.y += pGUI->GetFontSize();
	};

	auto pushChunk = [&](const char* a, const char* b)
	{
		if (a == b) return;
		chunk_storage.emplace_back(a, b);
		Arabic::ColouredChunk c;
		c.utf8     = chunk_storage.back().c_str();
		c.len      = (int)chunk_storage.back().size();
		c.color_id = PackColorTL(col);
		chunks.push_back(c);
	};

	while(textCur < (tempStr + sizeof(tempStr)) && *textCur != '\0')
	{
		if (*textCur == '{')
		{
			pushChunk(textStart, textCur);

			const char* colorStart = textCur + 1;
			do { ++textCur; } while (*textCur != '\0' && *textCur != '}');

			ImVec4 textColor;
			if (ProcessInlineHexColor(colorStart, textCur, textColor))
				col = textColor;

			textStart = textCur + 1;
		}
		else if (*textCur == '\n')
		{
			pushChunk(textStart, textCur);
			flushLine();
			iCounter++;

			vecPos.x = pos.x;
			if (szStrWithoutColors)
				vecPos.x -= fLineOffsets[iCounter];

			textStart = textCur + 1;
		}

		++textCur;
	}

	if (textCur != textStart)
		pushChunk(textStart, textCur);
	if (!chunks.empty())
		flushLine();
	else
		vecPos.y += pGUI->GetFontSize();
}

#include "..//game/game.h"
extern CGame* pGame;
void CText3DLabelsPool::Draw()
{
	if (!pGame->IsToggledHUDElement(HUD_ELEMENT_TEXTLABELS))
	{
		return;
	}
	for (int i = 0; i < TEXT_LABEL_POOL_SIZE; i++)
	{
		if (!m_pTextLabels[i] || !m_bSlotState[i])
		{
			continue;
		}
		TEXT_LABELS* pLabel = m_pTextLabels[i];
		if (!pNetGame->GetPlayerPool())
		{
			continue;
		}
		if (pLabel->attachedToPlayerID != INVALID_PLAYER_ID)
		{
			if (pLabel->attachedToPlayerID == pNetGame->GetPlayerPool()->GetLocalPlayerID())
			{
				continue;
			}
			DrawAttachedToPlayer(pLabel);
			continue;
		}
		else if (pLabel->attachedToVehicleID != INVALID_VEHICLE_ID)
		{
			DrawAttachedToVehicle(pLabel);
			continue;
		}
		else
		{
			DrawNonAttached(pLabel);
			continue;
		}

	}
}