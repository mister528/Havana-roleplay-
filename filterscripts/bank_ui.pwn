// ============================================================================
//  bank_ui.pwn   - HavanaRp Bank Overlay trigger (launcher-side UI)
// ----------------------------------------------------------------------------
//  Adds /bank command: queries the current player's cash + bank balance from
//  the `users` table and sends a prefixed client message that the HavanaRp
//  launcher (v11+) intercepts to display a professional bank overlay.
//
//  Message protocol:
//      "~BANK_UI~<cash>|<bank>"
//  The launcher hooks RPC ClientMessage in netrpc.cpp, matches this prefix,
//  parses the two integers, and calls CBankOverlay::Show(cash, bank).
// ============================================================================

#define FILTERSCRIPT

#include <a_samp>
#include <a_mysql>

// MySQL connection details mirror the main gamemode (arabonline.pwn line 38705).
// Matches arabonline.pwn line 38705 exactly:
//   sql_connection = mysql_connect("51.210.223.180", "gs108396", "gs108396", "2ymgifcr");
// mysql R39 signature: mysql_connect(host, user, database, password, ...)
#define BANK_SQL_HOST   "51.210.223.180"
#define BANK_SQL_USER   "gs108396"
#define BANK_SQL_DB     "gs108396"
#define BANK_SQL_PASS   "2ymgifcr"

new g_bank_sql = -1;
new g_bank_pname[MAX_PLAYERS][MAX_PLAYER_NAME + 1];

forward BankUI_OnQueryResult(playerid);

public OnFilterScriptInit()
{
    printf("[bank_ui] loading...");

    g_bank_sql = mysql_connect(BANK_SQL_HOST, BANK_SQL_USER, BANK_SQL_DB, BANK_SQL_PASS);

    new errcode = 0;
    if(g_bank_sql > 0)
        errcode = mysql_errno(g_bank_sql);

    if(g_bank_sql <= 0 || errcode != 0)
    {
        printf("[bank_ui] MySQL connect failed (handle=%d err=%d)", g_bank_sql, errcode);
        g_bank_sql = -1;
    }
    else
    {
        printf("[bank_ui] MySQL connected OK (handle=%d)", g_bank_sql);
    }

    // Cache names of already-connected players (in case FS loaded at runtime).
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i))
            GetPlayerName(i, g_bank_pname[i], MAX_PLAYER_NAME);
    }
    return 1;
}

public OnFilterScriptExit()
{
    if(g_bank_sql > 0)
    {
        mysql_close(g_bank_sql);
        g_bank_sql = -1;
    }
    return 1;
}

public OnPlayerConnect(playerid)
{
    GetPlayerName(playerid, g_bank_pname[playerid], MAX_PLAYER_NAME);
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    g_bank_pname[playerid][0] = '\0';
    return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    // Trim leading spaces + trailing whitespace for a tolerant match.
    new idx = 0;
    while(cmdtext[idx] == ' ') idx++;

    if(cmdtext[idx] != '/') return 0;
    idx++;

    // Accept "/bank" with optional trailing whitespace / newline.
    new ch0 = cmdtext[idx + 0];
    new ch1 = cmdtext[idx + 1];
    new ch2 = cmdtext[idx + 2];
    new ch3 = cmdtext[idx + 3];
    new ch4 = cmdtext[idx + 4];

    // Lowercase the 4 chars for case-insensitive compare.
    if(ch0 >= 'A' && ch0 <= 'Z') ch0 += 32;
    if(ch1 >= 'A' && ch1 <= 'Z') ch1 += 32;
    if(ch2 >= 'A' && ch2 <= 'Z') ch2 += 32;
    if(ch3 >= 'A' && ch3 <= 'Z') ch3 += 32;

    if(ch0 == 'b' && ch1 == 'a' && ch2 == 'n' && ch3 == 'k'
        && (ch4 == '\0' || ch4 == ' '))
    {
        if(g_bank_sql <= 0)
        {
            SendClientMessage(playerid, 0xFF5050FF, "[البنك] الخدمة متوقفة مؤقتاً.");
            return 1;
        }

        new query[256];
        mysql_format(g_bank_sql, query, sizeof(query),
            "SELECT `u_money`, `u_bank` FROM `users` WHERE `u_name` = '%e' LIMIT 1",
            g_bank_pname[playerid]);

        mysql_tquery(g_bank_sql, query, "BankUI_OnQueryResult", "d", playerid);
        return 1;
    }

    return 0;
}

public BankUI_OnQueryResult(playerid)
{
    if(!IsPlayerConnected(playerid)) return 1;

    if(cache_get_row_count(g_bank_sql) == 0)
    {
        SendClientMessage(playerid, 0xFF5050FF, "[البنك] سجل الحساب ما تم العثور عليه. رجاءً سجّل دخولك من جديد.");
        return 1;
    }

    new cash = cache_get_field_content_int(0, "u_money", g_bank_sql);
    new bank = cache_get_field_content_int(0, "u_bank",  g_bank_sql);

    new payload[96];
    format(payload, sizeof(payload), "~BANK_UI~%d|%d", cash, bank);

    // dwColor = -1 (white) is fine; the launcher consumes the message before chat.
    SendClientMessage(playerid, -1, payload);
    return 1;
}
