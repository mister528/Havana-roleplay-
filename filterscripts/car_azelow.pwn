// =============================================================================
//  car_azelow — Daewoo Gentra Azelow (replaces STALLION, model id 439)
// -----------------------------------------------------------------------------
//  Filterscript for HavanaRp / SA-MP 0.3.7 R2.
//
//  * Spawns three Azelow vehicles at the Rodeo showroom (LS).
//  * /azelow           — teleports the caller into the nearest one.
//  * /spawnazelow [c1] [c2] — anyone can spawn one in front of them.
//  * Engine auto-starts on entry, 250 km/h speed cap enforced server-side.
//  * Doors always unlocked, full fuel (bypasses gamemode's fuel check).
//  * Logs to scriptfiles/car_azelow.log.
// =============================================================================

#include <a_samp>
#include <zcmd>

#define AZELOW_MODEL       439
#define AZELOW_LOGFILE     "car_azelow.log"
// --- speed tuning ---
// Design notes (after research on Project Cerbera, sampwiki, sampforum):
//
// SA-MP's professional pattern for "a faster car" is to ship a modified
// handling.cfg that the client loads, NOT to override velocity from the
// server every tick. Server-side SetVehicleVelocity is rate-limited by the
// network update tick, so doing it 4-8 times per second snaps the client's
// physics simulation and makes turning/driving feel jittery.
//
// We split the work in two:
//   1) CLIENT (handling.cfg patch in patch_8000_azelow/): a tuned STALLION
//      line with higher TopSpeed, sharper Acceleration and better grip. This
//      is what gives the car its "fast & planted" feel during normal driving.
//   2) SERVER (this file): a *very* gentle additive thrust at a low frequency
//      (1 Hz) so the client physics has 999ms to settle naturally between
//      each touch. We only push forward, only when actively driving above the
//      min speed, and only enough to overcome any residual handling.cfg cap.
//
// Result: smooth vanilla-feel turning + steady climb to AZELOW_MAX_SPEED.
#define AZELOW_MAX_SPEED       250.0   // km/h hard cap
#define AZELOW_MIN_BOOST        20.0   // km/h - thrust only above this
#define AZELOW_THRUST           0.045  // SA-MP velocity units added per tick
                                       // (0.045 * 180 ≈ +8 km/h per tick)
#define AZELOW_DECEL_THRESH     5.0    // km/h drop/tick that = off-gas
#define AZELOW_TICK_MS         1000    // 1 Hz → client physics stays smooth

// Conversion: SA-MP velocity magnitude * 180 ≈ km/h.
#define VEL_TO_KMH         180.0

// We track up to 64 dynamically spawned Azelow vehicles (via /spawnazelow)
// ON TOP of the three static ones — more than enough for a 50-slot server.
#define AZELOW_MAX_DYN     64

// Three pre-placed spawn points around the Rodeo showroom (Los Santos).
new const Float:gAzelowSpawns[][4] = {
    {  392.4203,  -1503.1057, 23.4438,  88.7562 },
    {  396.7450,  -1496.9890, 23.4438,  88.7562 },
    {  401.2500,  -1490.7000, 23.4438,  88.7562 }
};

new gAzelowStaticIds[sizeof(gAzelowSpawns)] = { -1, ... };

// Dynamic set filled by /spawnazelow; -1 = empty slot.
new gAzelowDynIds[AZELOW_MAX_DYN] = { -1, ... };

// Engine-keepalive timer id.
new gEngineTimer = -1;

// Last measured velocity magnitude per player (in raw SA-MP units).
// Used to detect whether the car is accelerating (gas) or decelerating
// (off-gas / braking). Reset on disconnect / state change.
new Float:gAzelowLastSpeed[MAX_PLAYERS];


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

// Return true if `vid` belongs to our set (static or dynamic).
stock IsAzelow(vid)
{
    for (new i = 0; i < sizeof(gAzelowStaticIds); i++)
        if (gAzelowStaticIds[i] == vid) return 1;
    for (new i = 0; i < AZELOW_MAX_DYN; i++)
        if (gAzelowDynIds[i] == vid) return 1;
    return 0;
}

// Register a dynamically spawned Azelow, returns 1 if stored ok.
stock RegisterDynAzelow(vid)
{
    for (new i = 0; i < AZELOW_MAX_DYN; i++)
    {
        if (gAzelowDynIds[i] == -1)
        {
            gAzelowDynIds[i] = vid;
            return 1;
        }
    }
    return 0;
}

// Start the engine and unlock doors for a vehicle.
stock AzelowForceReady(vid)
{
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vid, VEHICLE_PARAMS_ON, lights, alarm, false, bonnet, boot, objective);
}


// -----------------------------------------------------------------------------
// Timer: keep engine alive for all occupied Azelows (overrides gamemode fuel=0).
// Also enforces the 200 km/h speed cap.
// Runs every 500 ms.
// -----------------------------------------------------------------------------

forward AzelowEngineTick();
public  AzelowEngineTick()
{
    new Float:maxVel       = AZELOW_MAX_SPEED      / VEL_TO_KMH;
    new Float:minBoost     = AZELOW_MIN_BOOST      / VEL_TO_KMH;
    new Float:decelThresh  = -AZELOW_DECEL_THRESH  / VEL_TO_KMH;

    new Float:thrust = AZELOW_THRUST;

    for (new p = 0; p < MAX_PLAYERS; p++)
    {
        if (!IsPlayerConnected(p)) continue;
        if (GetPlayerState(p) != PLAYER_STATE_DRIVER) continue;

        new vid = GetPlayerVehicleID(p);
        if (vid == 0 || !IsAzelow(vid)) continue;

        // --- engine keep-alive ---
        AzelowForceReady(vid);

        // --- velocity read ---
        new Float:vx, Float:vy, Float:vz;
        GetVehicleVelocity(vid, vx, vy, vz);
        new Float:speed = floatsqroot(vx*vx + vy*vy + vz*vz);

        // --- accel detection: was the car still gaining speed since
        //     last tick? if it dropped more than DECEL_THRESH km/h, the
        //     player is off-gas / braking, so we don't push.
        new Float:lastSpeed = gAzelowLastSpeed[p];
        new Float:delta     = speed - lastSpeed;
        gAzelowLastSpeed[p] = speed;
        new bool:onGas = (delta > decelThresh);

        // --- forward direction from the car's heading ---
        new Float:zAngle;
        GetVehicleZAngle(vid, zAngle);
        new Float:fx = -floatsin(zAngle, degrees);
        new Float:fy =  floatcos(zAngle, degrees);
        new Float:fwdSpeed = vx*fx + vy*fy;

        // --- single gentle additive shove forward, then hands off ---
        if (onGas && fwdSpeed > minBoost && speed < maxVel)
        {
            new Float:nx = vx + fx * thrust;
            new Float:ny = vy + fy * thrust;
            new Float:nz = vz;
            new Float:newSpeed = floatsqroot(nx*nx + ny*ny + nz*nz);
            if (newSpeed > maxVel)
            {
                new Float:k = maxVel / newSpeed;
                nx *= k; ny *= k;
            }
            SetVehicleVelocity(vid, nx, ny, nz);
            continue;
        }

        // --- safety cap when boost path didn't run ---
        if (speed > maxVel)
        {
            new Float:ratio = maxVel / speed;
            SetVehicleVelocity(vid, vx * ratio, vy * ratio, vz * ratio);
        }
    }
}


// -----------------------------------------------------------------------------
// hooks
// -----------------------------------------------------------------------------

public OnFilterScriptInit()
{
    print("[car_azelow] -------------------------------------------");
    print("[car_azelow]  Daewoo Gentra Azelow filterscript loaded");
    print("[car_azelow]  Model ID: 439 (STALLION) | Open to all");
    print("[car_azelow]  Speed cap: 250 km/h | Smooth thrust @1Hz | Fuel: infinite");
    print("[car_azelow] -------------------------------------------");

    new spawned = 0;
    for (new i = 0; i < sizeof(gAzelowSpawns); i++)
    {
        gAzelowStaticIds[i] = CreateVehicle(
            AZELOW_MODEL,
            gAzelowSpawns[i][0],
            gAzelowSpawns[i][1],
            gAzelowSpawns[i][2],
            gAzelowSpawns[i][3],
            -1, -1,
            -1
        );
        if (gAzelowStaticIds[i] != INVALID_VEHICLE_ID)
        {
            AzelowForceReady(gAzelowStaticIds[i]);
            spawned++;
        }
    }

    // Timer every AZELOW_TICK_MS to keep engines alive + apply boost.
    gEngineTimer = SetTimer("AzelowEngineTick", AZELOW_TICK_MS, true);

    new buf[96];
    format(buf, sizeof(buf), "OnFilterScriptInit: spawned %d/%d Azelows, timer=%d",
        spawned, sizeof(gAzelowSpawns), gEngineTimer);
    LogAzelow(buf);
    return 1;
}

public OnFilterScriptExit()
{
    if (gEngineTimer != -1)
    {
        KillTimer(gEngineTimer);
        gEngineTimer = -1;
    }

    for (new i = 0; i < sizeof(gAzelowStaticIds); i++)
    {
        if (gAzelowStaticIds[i] != INVALID_VEHICLE_ID && gAzelowStaticIds[i] != -1)
        {
            DestroyVehicle(gAzelowStaticIds[i]);
            gAzelowStaticIds[i] = -1;
        }
    }
    for (new i = 0; i < AZELOW_MAX_DYN; i++)
    {
        if (gAzelowDynIds[i] != -1)
        {
            DestroyVehicle(gAzelowDynIds[i]);
            gAzelowDynIds[i] = -1;
        }
    }

    LogAzelow("OnFilterScriptExit: cleaned up");
    return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    // When a player enters an Azelow as driver, auto-start the engine
    // and reset the speed tracker so the boost ramps from the current
    // velocity, not from a stale (possibly large) value.
    if (newstate == PLAYER_STATE_DRIVER)
    {
        new vid = GetPlayerVehicleID(playerid);
        if (vid != 0 && IsAzelow(vid))
        {
            AzelowForceReady(vid);
            gAzelowLastSpeed[playerid] = 0.0;
        }
    }
    else
    {
        gAzelowLastSpeed[playerid] = 0.0;
    }
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    #pragma unused reason
    gAzelowLastSpeed[playerid] = 0.0;
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

    // Check static Azelows.
    for (new i = 0; i < sizeof(gAzelowStaticIds); i++)
    {
        new vid = gAzelowStaticIds[i];
        if (vid == INVALID_VEHICLE_ID || vid == -1) continue;
        new Float:vx, Float:vy, Float:vz;
        GetVehiclePos(vid, vx, vy, vz);
        new Float:d = floatsqroot(
            (vx-px)*(vx-px) + (vy-py)*(vy-py) + (vz-pz)*(vz-pz)
        );
        if (d < best) { best = d; bestVeh = vid; }
    }
    // Check dynamic Azelows.
    for (new i = 0; i < AZELOW_MAX_DYN; i++)
    {
        new vid = gAzelowDynIds[i];
        if (vid == -1) continue;
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
    new col1 = -1, col2 = -1;
    if (params[0] != EOS) sscanf_two_ints(params, col1, col2);

    new Float:px, Float:py, Float:pz, Float:pa;
    GetPlayerPos(playerid, px, py, pz);
    GetPlayerFacingAngle(playerid, pa);

    new Float:fx = px + floatcos(pa+90.0, degrees) * 5.0;
    new Float:fy = py + floatsin(pa+90.0, degrees) * 5.0;

    new vid = CreateVehicle(AZELOW_MODEL, fx, fy, pz, pa, col1, col2, -1);
    if (vid == INVALID_VEHICLE_ID)
    {
        SendClientMessage(playerid, 0xFF6464FF,
            "{FF6464}* CreateVehicle failed - server rejected the model.");
        return 1;
    }

    // Auto-ready + register for engine keep-alive.
    AzelowForceReady(vid);
    RegisterDynAzelow(vid);

    new buf[96], name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    format(buf, sizeof(buf),
        "* Spawned an Azelow (id=%d, colours=%d/%d).", vid, col1, col2);
    SendClientMessage(playerid, 0x66FF66FF, buf);

    format(buf, sizeof(buf),
        "%s spawned Azelow vid=%d at (%.1f,%.1f,%.1f)",
        name, vid, fx, fy, pz);
    LogAzelow(buf);
    return 1;
}


// Tiny inline parser — two optional ints.
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
