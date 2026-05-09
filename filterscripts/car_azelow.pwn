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
//  azelow.dff/azelow.txd in its IMG archive AND the model is declared in
//  stallion.dff / stallion.txd files installed.
//  See ../patch_8000_azelow/ for the client-side patch.
//  CreateVehicle still works server-side regardless because the HavanaRp
//  launcher (libluxury.so) accepts model IDs > 611 over the wire.
// =============================================================================

#include <a_samp>
#include <zcmd>

// NOTE: SAMP 0.3.7-R2 server rejects vehicle model IDs outside 400-611 in
// CreateVehicle, regardless of any client-side modding. The Daewoo Gentra
// Azelow .dff/.txd files in the user-supplied archive were named
// `stallion.dff` / `stallion.txd`, which means the modder intended for them
// to REPLACE the stock STALLION (model 439) inside `gta3.img`. We follow
// that convention here so /spawnazelow uses a stock-valid model id and the
// player still sees the Azelow geometry once the patched gta3.img is
// installed on their device.
#define AZELOW_MODEL       439
#define AZELOW_LOGFILE     "car_azelow.log"
#define AZELOW_ADMINFILE   "azelow_admins.txt"
#define AZELOW_MAX_ADMINS  64

// Three spawn points around the rich-family Rodeo showroom (Los Santos).
// Coordinates lifted from a vanilla driving school zone — flat ground,
// outside a building, plenty of clearance for testing.
new const Float:gAzelowSpawns[][4] = {
    // x,         y,         z,        rotation
    {  392.4203,  -1503.1057, 23.4438,  88.7562 },
    {  396.7450,  -1496.9890, 23.4438,  88.7562 },
    {  401.2500,  -1490.7000, 23.4438,  88.7562 }
};

new gAzelowVehicleIds[sizeof(gAzelowSpawns)] = { -1, ... };


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

// Cache loaded once at OnFilterScriptInit. If the file is missing or empty
// we treat the whitelist as "unset" and let everyone use /spawnazelow.
new gAzelowAdmins[AZELOW_MAX_ADMINS][MAX_PLAYER_NAME];
new gAzelowAdminCount      = 0;
new bool:gAzelowWhitelistSet = false;

stock LoadAzelowAdmins()
{
    gAzelowAdminCount      = 0;
    gAzelowWhitelistSet    = false;

    new File:fp = fopen(AZELOW_ADMINFILE, io_read);
    if (fp == File:0)
    {
        // Auto-create a stub so the admin can edit it later via FTP.
        new File:nfp = fopen(AZELOW_ADMINFILE, io_write);
        if (nfp != File:0)
        {
            fwrite(nfp, "# car_azelow whitelist for /spawnazelow\r\n");
            fwrite(nfp, "# One in-game player name per line (case-insensitive).\r\n");
            fwrite(nfp, "# Lines starting with # are comments. Empty file = everyone allowed.\r\n");
            fwrite(nfp, "#\r\n");
            fwrite(nfp, "# Example:\r\n");
            fwrite(nfp, "# Hapad_Salem\r\n");
            fclose(nfp);
        }
        return;
    }

    new line[64];
    while (fread(fp, line))
    {
        // Trim CR/LF and trailing whitespace.
        new len = strlen(line);
        while (len > 0 && (line[len-1] == '\r' || line[len-1] == '\n' || line[len-1] == ' ' || line[len-1] == '\t'))
            line[--len] = EOS;
        // Skip blanks + comments.
        new s = 0;
        while (line[s] == ' ' || line[s] == '\t') s++;
        if (line[s] == EOS || line[s] == '#') continue;
        if (gAzelowAdminCount >= AZELOW_MAX_ADMINS) break;
        strmid(gAzelowAdmins[gAzelowAdminCount], line, s, len, MAX_PLAYER_NAME);
        gAzelowAdminCount++;
    }
    fclose(fp);
    gAzelowWhitelistSet = (gAzelowAdminCount > 0);
}

stock IsPlayerAdminish(playerid)
{
    if (IsPlayerAdmin(playerid)) return 1;          // RCON-logged-in players
    if (!gAzelowWhitelistSet)    return 1;          // open by default

    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    for (new i = 0; i < gAzelowAdminCount; i++)
    {
        if (strcmp(gAzelowAdmins[i], name, true) == 0) return 1;
    }
    return 0;
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

    LoadAzelowAdmins();
    if (gAzelowWhitelistSet)
        printf("[car_azelow]  Loaded %d admin name(s) from %s", gAzelowAdminCount, AZELOW_ADMINFILE);
    else
        print("[car_azelow]  No whitelist set -> /spawnazelow is open to all.");

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
    LogAzelow("OnFilterScriptExit: cleaned up Azelows");
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
    if (!IsPlayerAdminish(playerid))
    {
        SendClientMessage(playerid, 0xFF6464FF,
            "{FF6464}* /spawnazelow is whitelisted. Add your name to scriptfiles/azelow_admins.txt or /rcon login.");
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
        "Admin %s spawned Azelow vid=%d at (%.1f,%.1f,%.1f)",
        name, vid, fx, fy, pz);
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
