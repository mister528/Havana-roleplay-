// =============================================================================
//  car_azelow — Daewoo Gentra Azelow (replaces STALLION, model id 439)
// -----------------------------------------------------------------------------
//  Filterscript for HavanaRp / SA-MP 0.3.7 R2.
//
//  What it does
//  ------------
//  * Spawns three Azelow vehicles at the rich-family showroom in Rodeo (LS).
//  * Adds /azelow              — teleports the player into the nearest one.
//  * Adds /spawnazelow [color1] [color2]
//                              — spawns a new Azelow in front of the caller (admin only).
//  * Logs every spawn/use to scriptfiles/car_azelow.log.
//
//  Admin check
//  -----------
//  /spawnazelow checks `users_admins.u_a_level >= 1` for the calling player
//  in the same MySQL database the gamemode uses. RCON-logged players are
//  always allowed. Admin level is cached at OnPlayerConnect; if the cache
//  is missing we re-query on demand.
//
//  Why a separate filterscript
//  ---------------------------
//  The main gamemode (arabonline.amx) ships obfuscated and is too risky to
//  edit directly. Adding the new car as an isolated filterscript keeps it
//  reversible: drop the .amx, list it in server.cfg's `filterscripts ...`,
//  and you are done. Removing it only takes deleting the line.
//
//  Important
//  ---------
//  This filterscript spawns vehicles using the stock STALLION model id (439)
//  because SAMP 0.3.7-R2 rejects custom ids outside 400-611 server-side.
//  Players see the Azelow geometry only if their gta3.img has the matching
//  azelow.dff/azelow.txd installed in place of the stock stallion files.
//  See ../patch_8000_azelow/ for the client-side patch.
// =============================================================================

#include <a_samp>
#include <a_mysql>
#include <zcmd>

#define AZELOW_MODEL       439
#define AZELOW_LOGFILE     "car_azelow.log"

// MySQL credentials lifted from arabonline.pwn @ line 40617.
// The gamemode opens its own pool on connection handle 1; we open a tiny
// dedicated handle so we never collide with its query queue.
#define AZELOW_SQL_HOST    "51.210.223.180"
#define AZELOW_SQL_USER    "gs108396"
#define AZELOW_SQL_PASS    "gs108396"
#define AZELOW_SQL_DB      "2ymgifcr"
#define AZELOW_SQL_POOL    1

// Three spawn points around the rich-family Rodeo showroom (Los Santos).
new const Float:gAzelowSpawns[][4] = {
    // x,         y,         z,        rotation
    {  392.4203,  -1503.1057, 23.4438,  88.7562 },
    {  396.7450,  -1496.9890, 23.4438,  88.7562 },
    {  401.2500,  -1490.7000, 23.4438,  88.7562 }
};

new gAzelowVehicleIds[sizeof(gAzelowSpawns)] = { -1, ... };

// MySQL connection handle (own pool, separate from gamemode's).
// R39-5 returns a plain int handle; <= 0 means failed/closed.
#define AZELOW_SQL_INVALID  (0)
new gAzelowSql = AZELOW_SQL_INVALID;

// Per-player cached admin level.
//   -1 = not yet queried (or query in flight)
//    0 = not admin
//    1..8 = admin level
new gAzelowAdminLevel[MAX_PLAYERS];


// -----------------------------------------------------------------------------
// helpers
// -----------------------------------------------------------------------------

LogAzelow(const text[])
{
    new File:fp = fopen(AZELOW_LOGFILE, io_append);
    if (fp == File:0) return;
    new buf[256];
    new hh, mm, ss;
    gettime(hh, mm, ss);
    format(buf, sizeof(buf), "[%02d:%02d:%02d] %s\r\n", hh, mm, ss, text);
    fwrite(fp, buf);
    fclose(fp);
}

stock IsPlayerAdminish(playerid)
{
    if (IsPlayerAdmin(playerid)) return 1;          // RCON-logged-in players
    if (gAzelowAdminLevel[playerid] >= 1) return 1; // gamemode admin (DB-backed)
    return 0;
}

// Fire an async query for `name`'s admin level. Result is captured in
// OnAzelowAdminLoaded(playerid).
stock AzelowQueryAdmin(playerid)
{
    if (gAzelowSql == AZELOW_SQL_INVALID) return;
    if (!IsPlayerConnected(playerid)) return;

    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));

    new query[160];
    mysql_format(gAzelowSql, query, sizeof(query),
        "SELECT `u_a_level` FROM `users_admins` WHERE `u_a_name` = '%e' LIMIT 1",
        name);
    mysql_pquery(gAzelowSql, query, "OnAzelowAdminLoaded", "d", playerid);
}

forward OnAzelowAdminLoaded(playerid);
public  OnAzelowAdminLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        gAzelowAdminLevel[playerid] = -1;
        return 1;
    }

    new rows = cache_num_rows();
    if (rows < 1)
    {
        gAzelowAdminLevel[playerid] = 0;
        return 1;
    }

    new lvl = cache_get_field_content_int(0, "u_a_level", gAzelowSql);
    gAzelowAdminLevel[playerid] = lvl;

    new buf[96], name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    format(buf, sizeof(buf), "Admin level %d cached for %s", lvl, name);
    LogAzelow(buf);
    return 1;
}


// -----------------------------------------------------------------------------
// hooks
// -----------------------------------------------------------------------------

public OnFilterScriptInit()
{
    print("[car_azelow] -------------------------------------------");
    print("[car_azelow]  Daewoo Gentra Azelow filterscript loaded");
    print("[car_azelow]  Model ID: 439 (STALLION slot, replaced by Azelow)");
    print("[car_azelow] -------------------------------------------");

    // Open a dedicated MySQL pool. Handle is independent of the gamemode's.
    gAzelowSql = mysql_connect(
        AZELOW_SQL_HOST, AZELOW_SQL_USER, AZELOW_SQL_DB, AZELOW_SQL_PASS,
        3306, true, AZELOW_SQL_POOL);

    if (gAzelowSql <= AZELOW_SQL_INVALID)
    {
        gAzelowSql = AZELOW_SQL_INVALID;
        print("[car_azelow]  WARNING: MySQL connect failed - admin check disabled.");
        LogAzelow("OnFilterScriptInit: MySQL connect FAILED");
    }
    else
    {
        print("[car_azelow]  MySQL: connected to users_admins lookup pool.");
        LogAzelow("OnFilterScriptInit: MySQL connected");
    }

    for (new i = 0; i < MAX_PLAYERS; i++) gAzelowAdminLevel[i] = -1;

    // Players already on the server when /loadfs runs need a re-query.
    for (new i = 0; i < MAX_PLAYERS; i++)
        if (IsPlayerConnected(i))
            AzelowQueryAdmin(i);

    new spawned = 0;
    for (new i = 0; i < sizeof(gAzelowSpawns); i++)
    {
        gAzelowVehicleIds[i] = CreateVehicle(
            AZELOW_MODEL,
            gAzelowSpawns[i][0],
            gAzelowSpawns[i][1],
            gAzelowSpawns[i][2],
            gAzelowSpawns[i][3],
            -1, -1,           // random colours
            -1                // never auto-respawn
        );
        if (gAzelowVehicleIds[i] != INVALID_VEHICLE_ID) spawned++;
    }

    new buf[96];
    format(buf, sizeof(buf), "OnFilterScriptInit: spawned %d/%d Azelows", spawned, sizeof(gAzelowSpawns));
    LogAzelow(buf);
    return 1;
}

public OnFilterScriptExit()
{
    for (new i = 0; i < sizeof(gAzelowVehicleIds); i++)
    {
        if (gAzelowVehicleIds[i] != INVALID_VEHICLE_ID && gAzelowVehicleIds[i] != -1)
        {
            DestroyVehicle(gAzelowVehicleIds[i]);
            gAzelowVehicleIds[i] = -1;
        }
    }

    if (gAzelowSql != AZELOW_SQL_INVALID)
    {
        mysql_close(gAzelowSql);
        gAzelowSql = AZELOW_SQL_INVALID;
    }

    LogAzelow("OnFilterScriptExit: cleaned up Azelows + MySQL");
    return 1;
}

public OnPlayerConnect(playerid)
{
    gAzelowAdminLevel[playerid] = -1;
    // Defer the actual lookup a bit so the gamemode's own login flow (which
    // populates `users_admins` with rows for new admins) finishes first.
    SetTimerEx("AzelowQueryAdminTimed", 4000, false, "d", playerid);
    return 1;
}

forward AzelowQueryAdminTimed(playerid);
public  AzelowQueryAdminTimed(playerid) { AzelowQueryAdmin(playerid); }

public OnPlayerDisconnect(playerid, reason)
{
    #pragma unused reason
    gAzelowAdminLevel[playerid] = -1;
    return 1;
}


// -----------------------------------------------------------------------------
// commands
// -----------------------------------------------------------------------------

CMD:azelow(playerid, params[])
{
    #pragma unused params

    new Float:px, Float:py, Float:pz;
    GetPlayerPos(playerid, px, py, pz);

    new bestVeh   = INVALID_VEHICLE_ID;
    new Float:best = 99999.0;
    for (new i = 0; i < sizeof(gAzelowVehicleIds); i++)
    {
        new vid = gAzelowVehicleIds[i];
        if (vid == INVALID_VEHICLE_ID || vid == -1) continue;
        new Float:vx, Float:vy, Float:vz;
        GetVehiclePos(vid, vx, vy, vz);
        new Float:d = floatsqroot(
            (vx-px)*(vx-px) + (vy-py)*(vy-py) + (vz-pz)*(vz-pz)
        );
        if (d < best) { best = d; bestVeh = vid; }
    }

    if (bestVeh == INVALID_VEHICLE_ID)
    {
        SendClientMessage(playerid, 0xFF6464FF,
            "{FF6464}* No Azelow is currently spawned.");
        return 1;
    }

    PutPlayerInVehicle(playerid, bestVeh, 0);
    SendClientMessage(playerid, 0x66FF66FF,
        "{66FF66}* Teleported you into the nearest Daewoo Gentra Azelow.");

    new buf[96], name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    format(buf, sizeof(buf), "%s used /azelow (vehicleid=%d)", name, bestVeh);
    LogAzelow(buf);
    return 1;
}

CMD:spawnazelow(playerid, params[])
{
    // If the cache is still cold (admin just connected, or filterscript was
    // just /loadfs'd), trigger a fresh query and ask the player to retry.
    if (gAzelowAdminLevel[playerid] < 0)
    {
        AzelowQueryAdmin(playerid);
        SendClientMessage(playerid, 0xFFC864FF,
            "{FFC864}* Checking admin status, try again in 1-2 seconds.");
        return 1;
    }

    if (!IsPlayerAdminish(playerid))
    {
        SendClientMessage(playerid, 0xFF6464FF,
            "{FF6464}* /spawnazelow is for admins only.");
        return 1;
    }

    new col1 = -1, col2 = -1;
    if (params[0] != EOS) sscanf_two_ints(params, col1, col2);

    new Float:px, Float:py, Float:pz, Float:pa;
    GetPlayerPos(playerid, px, py, pz);
    GetPlayerFacingAngle(playerid, pa);

    // Drop the spawn ~5m in front of the caller, on the same z-level.
    new Float:fx = px + floatcos(pa+90.0, degrees) * 5.0;
    new Float:fy = py + floatsin(pa+90.0, degrees) * 5.0;

    new vid = CreateVehicle(AZELOW_MODEL, fx, fy, pz, pa, col1, col2, -1);
    if (vid == INVALID_VEHICLE_ID)
    {
        SendClientMessage(playerid, 0xFF6464FF,
            "{FF6464}* CreateVehicle failed - server rejected the model.");
        return 1;
    }

    new buf[96], name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    format(buf, sizeof(buf),
        "* Spawned an Azelow (id=%d, colours=%d/%d).", vid, col1, col2);
    SendClientMessage(playerid, 0x66FF66FF, buf);

    format(buf, sizeof(buf),
        "Admin %s (lvl %d) spawned Azelow vid=%d at (%.1f,%.1f,%.1f)",
        name, gAzelowAdminLevel[playerid], vid, fx, fy, pz);
    LogAzelow(buf);
    return 1;
}


// Tiny inline parser so we don't pull in sscanf just for two optional ints.
sscanf_two_ints(const params[], &c1, &c2)
{
    new pos = 0, len = strlen(params);
    new tok[12];
    new tokIdx = 0;
    while (pos < len && params[pos] == ' ') pos++;
    while (pos < len && params[pos] != ' ' && tokIdx < (sizeof(tok) - 1))
        tok[tokIdx++] = params[pos++];
    tok[tokIdx] = EOS;
    if (tokIdx > 0) c1 = strval(tok);

    while (pos < len && params[pos] == ' ') pos++;
    tokIdx = 0;
    while (pos < len && params[pos] != ' ' && tokIdx < (sizeof(tok) - 1))
        tok[tokIdx++] = params[pos++];
    tok[tokIdx] = EOS;
    if (tokIdx > 0) c2 = strval(tok);
}
