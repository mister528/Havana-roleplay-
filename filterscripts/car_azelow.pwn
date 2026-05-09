// =============================================================================
//  car_azelow — Daewoo Gentra Azelow (custom vehicle ID 8000)
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
//  Vehicle ID 8000 only renders if the GTA SA Mobile install has the matching
//  azelow.dff/azelow.txd in its IMG archive AND the model is declared in
//  data/vehicles.ide. See ../patch_8000_azelow/ for the client-side patch.
//  CreateVehicle still works server-side regardless because the HavanaRp
//  launcher (libluxury.so) accepts model IDs > 611 over the wire.
// =============================================================================

#include <a_samp>
#include <zcmd>

#define AZELOW_MODEL    8000
#define AZELOW_LOGFILE  "car_azelow.log"

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

stock IsPlayerAdminish(playerid)
{
    return IsPlayerAdmin(playerid);
}


// -----------------------------------------------------------------------------
// hooks
// -----------------------------------------------------------------------------

public OnFilterScriptInit()
{
    print("[car_azelow] -------------------------------------------");
    print("[car_azelow]  Daewoo Gentra Azelow filterscript loaded");
    print("[car_azelow]  Model ID: 8000");
    print("[car_azelow] -------------------------------------------");

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
            "{FF6464}* /spawnazelow is admin-only.");
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
            "{FF6464}* CreateVehicle failed (model 8000 may not exist on this server).");
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
