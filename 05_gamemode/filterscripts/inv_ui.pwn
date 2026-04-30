// ============================================================================
//  inv_ui.pwn   - HavanaRp Inventory Overlay data feed (launcher-side UI)
// ----------------------------------------------------------------------------
//  - Pushes a periodic wallet snapshot (cash/bank/phone/mats/cigs/drugs/level
//    /job/skin/health/hunger and counters) for every authenticated player to
//    the launcher via a prefixed ClientMessage. The launcher (HavanaRp v7+)
//    parses the message and merges the values into its inventory overlay
//    cache so that when the gamemode shows the in-game "Inventory" dialog
//    the launcher's overlay already has accurate live data.
//
//  - Also keeps the legacy /inv (and /inventory, /bag) command which fires
//    a synchronous "show" payload, in case anyone runs without the gamemode
//    inventory dialog.
//
//  Message protocols:
//      "~INV_DATA~k=v;k=v;..."  -> launcher merges silently (no overlay).
//      "~INV_UI~k=v;k=v;..."    -> launcher merges + shows overlay (legacy).
// ============================================================================

#define FILTERSCRIPT

#include <a_samp>
#include <a_mysql>

// MySQL connection details mirror the main gamemode (arabonline.pwn line 38705).
//   sql_connection = mysql_connect("51.210.223.180", "gs108396", "gs108396", "2ymgifcr");
// mysql R39 signature: mysql_connect(host, user, database, password, ...)
#define INV_SQL_HOST   "51.210.223.180"
#define INV_SQL_USER   "gs108396"
#define INV_SQL_DB     "gs108396"
#define INV_SQL_PASS   "2ymgifcr"

// Period of the silent wallet refresh. 4500ms keeps things fresh without
// hammering the database; the overlay typically opens in <500ms after the
// player triggers /inv so any short staleness is invisible.
#define INV_REFRESH_MS 4500

new g_inv_sql = -1;
new g_inv_pname[MAX_PLAYERS][MAX_PLAYER_NAME + 1];
new g_inv_timer = -1;
new g_inv_cursor = 0;

forward InvUI_OnQueryResult(playerid, showOverlay);
forward InvUI_OnTick();

// ----------------------------------------------------------------------------
//  init / shutdown
// ----------------------------------------------------------------------------
public OnFilterScriptInit()
{
    printf("[inv_ui] loading...");

    g_inv_sql = mysql_connect(INV_SQL_HOST, INV_SQL_USER, INV_SQL_DB, INV_SQL_PASS);

    new errcode = 0;
    if(g_inv_sql > 0)
        errcode = mysql_errno(g_inv_sql);

    if(g_inv_sql <= 0 || errcode != 0)
    {
        printf("[inv_ui] MySQL connect failed (handle=%d err=%d)", g_inv_sql, errcode);
        g_inv_sql = -1;
    }
    else
    {
        printf("[inv_ui] MySQL connected OK (handle=%d)", g_inv_sql);
    }

    // Cache names of already-connected players (in case FS loaded at runtime).
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i))
            GetPlayerName(i, g_inv_pname[i], MAX_PLAYER_NAME);
    }

    // Drive the silent refresh; we round-robin one player per tick to spread
    // the SQL load across the period.
    g_inv_timer = SetTimer("InvUI_OnTick", 250, 1);
    return 1;
}

public OnFilterScriptExit()
{
    if(g_inv_timer != -1) { KillTimer(g_inv_timer); g_inv_timer = -1; }
    if(g_inv_sql > 0)
    {
        mysql_close(g_inv_sql);
        g_inv_sql = -1;
    }
    return 1;
}

public OnPlayerConnect(playerid)
{
    GetPlayerName(playerid, g_inv_pname[playerid], MAX_PLAYER_NAME);
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    g_inv_pname[playerid][0] = '\0';
    return 1;
}

// ----------------------------------------------------------------------------
//  Tolerant /inv (or /inventory) parser
// ----------------------------------------------------------------------------
stock _InvUiMatchesCmd(const cmdtext[])
{
    new idx = 0;
    while(cmdtext[idx] == ' ') idx++;
    if(cmdtext[idx] != '/') return 0;
    idx++;

    // Lowercase a window of up to 10 chars for case-insensitive compare.
    // Stop at end-of-string so we never read past cmdtext[].
    new ch[11];
    new len = strlen(cmdtext);
    for(new i = 0; i < 10; i++)
    {
        if(idx + i >= len) { ch[i] = 0; continue; }
        new c = cmdtext[idx + i];
        if(c >= 'A' && c <= 'Z') c += 32;
        ch[i] = c;
    }
    ch[10] = 0;

    // /inv  (terminator: end-of-string or space)
    if(ch[0] == 'i' && ch[1] == 'n' && ch[2] == 'v'
        && (ch[3] == '\0' || ch[3] == ' '))
        return 1;

    // /inventory
    if(ch[0] == 'i' && ch[1] == 'n' && ch[2] == 'v' && ch[3] == 'e'
        && ch[4] == 'n' && ch[5] == 't' && ch[6] == 'o' && ch[7] == 'r'
        && ch[8] == 'y' && (ch[9] == '\0' || ch[9] == ' '))
        return 1;

    // /bag (Arabic-RP friendly alias)
    if(ch[0] == 'b' && ch[1] == 'a' && ch[2] == 'g'
        && (ch[3] == '\0' || ch[3] == ' '))
        return 1;

    return 0;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    if(!_InvUiMatchesCmd(cmdtext)) return 0;
    InvUI_DispatchSnapshot(playerid, 1 /* showOverlay */);
    return 0; // let the gamemode also process the command if it wants
}

// ----------------------------------------------------------------------------
//  Periodic round-robin refresh - schedules an SQL query per tick so each
//  player gets refreshed roughly every (INV_REFRESH_MS) ms regardless of how
//  many are connected (we just visit MAX_PLAYERS / period_in_ticks per tick).
// ----------------------------------------------------------------------------
public InvUI_OnTick()
{
    if(g_inv_sql <= 0) return 1;

    // How many players we visit each 250ms tick to cover everyone within
    // INV_REFRESH_MS. Scale with the connected count; minimum 1.
    new visits = (MAX_PLAYERS * 250) / INV_REFRESH_MS;
    if(visits < 1) visits = 1;
    if(visits > 8) visits = 8;     // upper cap so we don't burst the DB

    new visited = 0;
    new safety  = 0;
    while(visited < visits && safety < MAX_PLAYERS)
    {
        new pid = g_inv_cursor;
        g_inv_cursor = (g_inv_cursor + 1) % MAX_PLAYERS;
        safety++;

        if(IsPlayerConnected(pid) && !IsPlayerNPC(pid) && g_inv_pname[pid][0])
        {
            InvUI_DispatchSnapshot(pid, 0 /* silent */);
            visited++;
        }
    }
    return 1;
}

stock InvUI_DispatchSnapshot(playerid, showOverlay)
{
    if(g_inv_sql <= 0) return 0;
    if(!IsPlayerConnected(playerid)) return 0;
    if(g_inv_pname[playerid][0] == '\0') return 0;

    new query[512];
    mysql_format(g_inv_sql, query, sizeof(query),
        "SELECT \
            `u_money`,`u_bank`,`u_phohe_balance`,`u_drugs`,\
            `u_health`,`u_hunger`,`u_skin`,`u_level`,`u_job`,\
            `u_aidkit`,`u_bandage`,`u_schiene`,`u_aspirin`,`u_morphine`,`u_adrenalin`,\
            `u_repairkit`,`u_gps_tracker`,`u_mask`,`u_rope`,`u_canister`,`u_seed`,\
            `u_ammo`,`u_guns`\
         FROM `users` WHERE `u_name` = '%e' LIMIT 1",
        g_inv_pname[playerid]);

    mysql_tquery(g_inv_sql, query, "InvUI_OnQueryResult", "dd", playerid, showOverlay);
    return 1;
}

// ----------------------------------------------------------------------------
//  Query callback - format payload and send to client
// ----------------------------------------------------------------------------
public InvUI_OnQueryResult(playerid, showOverlay)
{
    if(!IsPlayerConnected(playerid)) return 1;

    if(cache_get_row_count(g_inv_sql) == 0)
    {
        if(showOverlay)
            SendClientMessage(playerid, 0xFF5050FF, "[المخزون] سجل الحساب ما تم العثور عليه. رجاءً سجّل دخولك من جديد.");
        return 1;
    }

    new money     = cache_get_field_content_int(0, "u_money",         g_inv_sql);
    new bank      = cache_get_field_content_int(0, "u_bank",          g_inv_sql);
    new phone_bal = cache_get_field_content_int(0, "u_phohe_balance", g_inv_sql);
    new drugs     = cache_get_field_content_int(0, "u_drugs",         g_inv_sql);
    new health    = cache_get_field_content_int(0, "u_health",        g_inv_sql);
    new hunger    = cache_get_field_content_int(0, "u_hunger",        g_inv_sql);
    new skin      = cache_get_field_content_int(0, "u_skin",          g_inv_sql);
    new level     = cache_get_field_content_int(0, "u_level",         g_inv_sql);
    new job       = cache_get_field_content_int(0, "u_job",           g_inv_sql);

    new aidkit    = cache_get_field_content_int(0, "u_aidkit",        g_inv_sql);
    new bandage   = cache_get_field_content_int(0, "u_bandage",       g_inv_sql);
    new schiene   = cache_get_field_content_int(0, "u_schiene",       g_inv_sql);
    new aspirin   = cache_get_field_content_int(0, "u_aspirin",       g_inv_sql);
    new morphine  = cache_get_field_content_int(0, "u_morphine",      g_inv_sql);
    new adrenalin = cache_get_field_content_int(0, "u_adrenalin",     g_inv_sql);

    new repairkit = cache_get_field_content_int(0, "u_repairkit",     g_inv_sql);
    new gps       = cache_get_field_content_int(0, "u_gps_tracker",   g_inv_sql);
    new mask      = cache_get_field_content_int(0, "u_mask",          g_inv_sql);
    new rope      = cache_get_field_content_int(0, "u_rope",          g_inv_sql);
    new canister  = cache_get_field_content_int(0, "u_canister",      g_inv_sql);
    new seed      = cache_get_field_content_int(0, "u_seed",          g_inv_sql);

    new ammo      = cache_get_field_content_int(0, "u_ammo",          g_inv_sql);
    new guns      = cache_get_field_content_int(0, "u_guns",          g_inv_sql);

    if(health > 100) health = 100;
    if(health < 0)   health = 0;
    if(hunger > 100) hunger = 100;
    if(hunger < 0)   hunger = 0;

    new payload[760];
    new tail[400];

    // The launcher accepts both "~INV_DATA~" (silent merge) and
    // "~INV_UI~" (merge + show). We pick based on the showOverlay flag.
    new const prefix[] =
        "~INV_DATA~name=%s;level=%d;job=%d;skin=%d;health=%d;hunger=%d;money=%d;bank=%d;phone=%d;drugs=%d;mats=%d;cigs=%d;";
    new const prefix_show[] =
        "~INV_UI~name=%s;level=%d;job=%d;skin=%d;health=%d;hunger=%d;money=%d;bank=%d;phone=%d;drugs=%d;mats=%d;cigs=%d;";

    if(showOverlay)
        format(payload, sizeof(payload), prefix_show,
            g_inv_pname[playerid], level, job, skin, health, hunger,
            money, bank, phone_bal, drugs, 0, 0);
    else
        format(payload, sizeof(payload), prefix,
            g_inv_pname[playerid], level, job, skin, health, hunger,
            money, bank, phone_bal, drugs, 0, 0);

    format(tail, sizeof(tail),
        "aidkit=%d;bandage=%d;schiene=%d;aspirin=%d;morphine=%d;adrenalin=%d;repairkit=%d;gps=%d;mask=%d;rope=%d;canister=%d;seed=%d;ammo=%d;guns=%d",
        aidkit, bandage, schiene, aspirin, morphine, adrenalin,
        repairkit, gps, mask, rope, canister, seed,
        ammo, guns);

    strcat(payload, tail, sizeof(payload));

    // dwColor = -1 (white). Launcher consumes the message before chat.
    SendClientMessage(playerid, -1, payload);
    return 1;
}
