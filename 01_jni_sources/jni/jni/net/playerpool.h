#pragma once

#define NO_TEAM 255

class CPlayerPool
{
public:
	CPlayerPool();
	~CPlayerPool();

	bool Process();
	PLAYERID GetCount();
	// LOCAL

	void UpdateScore(PLAYERID playerId, int iScore);
	void UpdatePing(PLAYERID playerId, uint32_t dwPing);

	int GetLocalPlayerScore() { return m_iLocalPlayerScore; }
	uint32_t GetLocalPlayerPing() { return m_dwLocalPlayerPing; }

	int GetRemotePlayerScore(PLAYERID playerId)
	{
		if (playerId > MAX_PLAYERS) return 0;
		return m_iPlayerScores[playerId];
	}

	uint32_t GetRemotePlayerPing(PLAYERID playerId)
	{
		if (playerId > MAX_PLAYERS) return 0;
		return m_dwPlayerPings[playerId];
	}

	void SetLocalPlayerName(const char* szName)
	{
		// [HARDEN] Bounded copy: a corrupt server packet must not be able to
		// overflow m_szLocalPlayerName[MAX_PLAYER_NAME+1] and corrupt heap,
		// which previously fed bad strings into GTA-SA's CFont/strncpy.
		if (!szName) { m_szLocalPlayerName[0] = '\0'; return; }
		size_t n = 0;
		while (szName[n] && n < MAX_PLAYER_NAME) { m_szLocalPlayerName[n] = szName[n]; ++n; }
		m_szLocalPlayerName[n] = '\0';
	}
	char* GetLocalPlayerName() { return m_szLocalPlayerName; }
	void SetLocalPlayerID(PLAYERID MyPlayerID)
	{
		if (MyPlayerID >= MAX_PLAYERS) return;
		// [HARDEN] Bounded copy from local name into the per-player name slot.
		size_t n = 0;
		while (m_szLocalPlayerName[n] && n < MAX_PLAYER_NAME)
		{
			m_szPlayerNames[MyPlayerID][n] = m_szLocalPlayerName[n];
			++n;
		}
		m_szPlayerNames[MyPlayerID][n] = '\0';
		m_LocalPlayerID = MyPlayerID;
	}
	PLAYERID GetLocalPlayerID() { return m_LocalPlayerID; }
	CLocalPlayer* GetLocalPlayer() { return m_pLocalPlayer; }
	// remote
	bool New(PLAYERID playerId, char* szPlayerName, bool bIsNPC);
	bool Delete(PLAYERID playerId, uint8_t byteReason);

	CRemotePlayer *GetAt(PLAYERID playerId)
	{
		if(playerId >= MAX_PLAYERS) return nullptr;
		return m_pPlayers[playerId];
	}

	bool GetSlotState(PLAYERID playerId)
	{
		if(playerId >= MAX_PLAYERS) return false;
		return m_bPlayerSlotState[playerId];
	};

	void SetPlayerName(PLAYERID playerId, char* szName)
	{
		// [HARDEN] Reject out-of-range slots and bound-copy the name so a
		// long / corrupt server-side rename can't overrun the 25-byte slot
		// (which then bleeds into adjacent player names and feeds invalid
		// strings to GTA's text engine → strncpy / CFont::GetNextSpace).
		if (playerId >= MAX_PLAYERS) return;
		if (!szName) { m_szPlayerNames[playerId][0] = '\0'; return; }
		size_t n = 0;
		while (szName[n] && n < MAX_PLAYER_NAME)
		{
			m_szPlayerNames[playerId][n] = szName[n];
			++n;
		}
		m_szPlayerNames[playerId][n] = '\0';
	}
	char* GetPlayerName(PLAYERID playerId){ return m_szPlayerNames[playerId]; }

	PLAYERID FindRemotePlayerIDFromGtaPtr(PED_TYPE * pActor);

private:
	// LOCAL
	PLAYERID		m_LocalPlayerID;
	CLocalPlayer	*m_pLocalPlayer;
	char			m_szLocalPlayerName[MAX_PLAYER_NAME+1];
	int				m_iLocalPlayerScore;
	uint32_t		m_dwLocalPlayerPing;

	// REMOTE
	CRemotePlayer	*m_pPlayers[MAX_PLAYERS];
	bool			m_bPlayerSlotState[MAX_PLAYERS];
	char			m_szPlayerNames[MAX_PLAYERS][MAX_PLAYER_NAME+1];
	int				m_iPlayerScores[MAX_PLAYERS];
	uint32_t		m_dwPlayerPings[MAX_PLAYERS];
};
