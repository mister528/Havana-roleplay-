// =============================================================================
//  car_camry — Toyota Camry XSE V6 3.5 (replaces NEBULA, model id 516)
// -----------------------------------------------------------------------------
//  Filterscript for HavanaRp / SA-MP 0.3.7 R2.
//
//  * Spawns three Camry vehicles at the Wang Cars showroom (LV).
//  * /camry                    — teleports the caller into the nearest one.
//  * /spawncamry [c1] [c2]     — anyone can spawn one in front of them.
//  * Engine auto-starts on entry, 260 km/h speed cap enforced server-side.
//  * Doors always unlocked, full fuel (bypasses gamemode's fuel check).
//  * Logs to scriptfiles/car_camry.log.
//
//  Physics target (v3 — "Azelow-style smooth steering, V6 muscle"):
//   * 260 km/h hard cap with cubic soft-cap (no jitter near top speed)
//   * Strong V6 thrust: ~+16 km/h per tick at low speed, fades smoothly to 0
//     → 0–200 km/h in ~7 seconds (matches user's spec for 3.5 V6 Camry)
//   * Smooth yaw fade in a tight 11→24 °/s window — turn-in feels like the
//     Azelow (predictable, planted, no sideways shove mid-corner).
//   * Lateral grip 0.50 — sedan-level grip, planted but not on rails.
//   * Brake assist 1.04 on off-gas — confident, decisive stops.
//   * 2 Hz tick (500 ms) — same cadence as the rest of the fleet.
//   * Boosts ANY model-516 vehicle (admin-spawned, gamemode-spawned, etc.).
// =============================================================================

#include <a_samp>
#include <zcmd>

#define CAMRY_MODEL         516
#define CAMRY_LOGFILE       "car_camry.log"

// --- speed tuning ---
#define CAMRY_MAX_SPEED     260.0  // km/h hard cap
#define CAMRY_MIN_BOOST       5.0  // km/h — thrust kicks in immediately for
                                   // a torquey launch from a standstill
#define CAMRY_THRUST        0.090  // SA-MP velocity units / tick
                                   // (0.090 * 180 ≈ +16.2 km/h per tick @2Hz
                                   //  → 0–200 km/h in ~7s with the soft cap)
#define CAMRY_DECEL_THRESH    5.0  // km/h drop/tick that = off-gas
#define CAMRY_ACCEL_LIMIT    25.0  // km/h rise/tick above which we assume
                                   // it's gravity (downhill), not engine.
                                   // Higher than Cheetah/Mercedes because
                                   // base thrust is bigger here.
#define CAMRY_TURN_SOFT      11.0  // deg/sec — full thrust at or below this
#define CAMRY_TURN_HARD      24.0  // deg/sec — no thrust at or above this.
                                   // Tight 11→24 band gives the same buttery
                                   // smooth turn-in as the Azelow without
                                   // step-cutting thrust mid-corner.
#define CAMRY_SLOPE_LIMIT    0.08  // |vz| above which we skip thrust because
                                   // the car is on a slope and gravity is
                                   // doing the work.
#define CAMRY_LATERAL_GRIP   0.50  // 0..1 — fraction of lateral velocity
                                   // killed each tick. Mid-heavy: planted
                                   // sedan feel without going on rails.
#define CAMRY_BRAKE_BOOST    1.04  // off-gas brake assist multiplier —
                                   // confident, decisive sedan stops.
#define CAMRY_TICK_MS         500  // 2 Hz — matches the rest of the fleet

// Conversion: SA-MP velocity magnitude * 180 ≈ km/h.
#define VEL_TO_KMH         180.0

// We track up to 64 dynamically spawned Camrys (via /spawncamry) ON TOP of
// the three static ones — more than enough for a 50-slot server.
#define CAMRY_MAX_DYN        64

// Three pre-placed spawn points at the Wang Cars showroom (Las Venturas),
// offset further down from the BYD row so the cars don't fight for space.
new const Float:gCamrySpawns[][4] = {
    {  2127.0000,   1450.0000, 10.5200,  90.0000 },
    {  2127.0000,   1457.0000, 10.5200,  90.0000 },
    {  2127.0000,   1464.0000, 10.5200,  90.0000 }
};

new gCamryStaticIds[sizeof(gCamrySpawns)] = { -1, ... };

// Dynamic set filled by /spawncamry; -1 = empty slot.
new gCamryDynIds[CAMRY_MAX_DYN] = { -1, ... };

// Engine-keepalive timer id.
new gEngineTimer = -1;

// Last measured horizontal velocity per player (raw SA-MP units).
new Float:gCamryLastSpeed[MAX_PLAYERS];
// Last measured Z angle per player (for yaw-rate derivation).
new Float:gCamryLastZ[MAX_PLAYERS];


// -----------------------------------------------------------------------------
// helpers
// -----------------------------------------------------------------------------

LogCamry(const text[])
{
    new File:fp = fopen(CAMRY_LOGFILE, io_append);
    if (fp == File:0) return;
    new buf[256];
    new hh, mm, ss;
    gettime(hh, mm, ss);
    format(buf, sizeof(buf), "[%02d:%02d:%02d] %s\r\n", hh, mm, ss, text);
    fwrite(fp, buf);
    fclose(fp);
}

// Return true if `vid` is a Camry/NEBULA (model 516) regardless of spawner.
// The static + dynamic id arrays remain only as targets for the /camry
// teleport command; the boost itself applies to ANY model-516 vehicle so
// admin-spawned, gamemode-spawned, or third-party-FS-spawned Camrys all
// inherit the same physics.
stock IsCamry(vid)
{
    if (vid == INVALID_VEHICLE_ID || vid == 0) return 0;
    return GetVehicleModel(vid) == CAMRY_MODEL;
}

// Register a dynamically spawned Camry, returns 1 if stored ok.
stock RegisterDynCamry(vid)
{
    for (new i = 0; i < CAMRY_MAX_DYN; i++)
    {
        if (gCamryDynIds[i] == -1)
        {
            gCamryDynIds[i] = vid;
            return 1;
        }
    }
    return 0;
}

// Start the engine and unlock doors for a vehicle.
stock CamryForceReady(vid)
{
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vid, VEHICLE_PARAMS_ON, lights, alarm, false, bonnet, boot, objective);
}


// -----------------------------------------------------------------------------
// Timer: keep engine alive + apply tuned thrust for all occupied Camrys.
// Runs every CAMRY_TICK_MS ms.
// -----------------------------------------------------------------------------

forward CamryEngineTick();
public  CamryEngineTick()
{
    new Float:maxVel       = CAMRY_MAX_SPEED      / VEL_TO_KMH;
    new Float:minBoost     = CAMRY_MIN_BOOST      / VEL_TO_KMH;
    new Float:decelThresh  = -CAMRY_DECEL_THRESH  / VEL_TO_KMH;
    new Float:accelLimit   =  CAMRY_ACCEL_LIMIT   / VEL_TO_KMH;

    for (new p = 0; p < MAX_PLAYERS; p++)
    {
        if (!IsPlayerConnected(p)) continue;
        if (GetPlayerState(p) != PLAYER_STATE_DRIVER) continue;

        new vid = GetPlayerVehicleID(p);
        if (vid == 0 || !IsCamry(vid)) continue;

        // --- engine keep-alive ---
        CamryForceReady(vid);

        // --- velocity read ---
        new Float:vx, Float:vy, Float:vz;
        GetVehicleVelocity(vid, vx, vy, vz);

        // --- horizontal-only speed ---
        new Float:hSpeed = floatsqroot(vx*vx + vy*vy);

        // --- gas detection ---
        new Float:lastSpeed = gCamryLastSpeed[p];
        new Float:delta     = hSpeed - lastSpeed;
        gCamryLastSpeed[p]  = hSpeed;
        new bool:onGas = (delta > decelThresh && delta < accelLimit);

        // --- yaw rate (deg/sec) since last tick ---
        new Float:zAngle;
        GetVehicleZAngle(vid, zAngle);
        new Float:lastZ = gCamryLastZ[p];
        new Float:angleDiff = zAngle - lastZ;
        if (angleDiff >  180.0) angleDiff -= 360.0;
        if (angleDiff < -180.0) angleDiff += 360.0;
        gCamryLastZ[p] = zAngle;
        new Float:turnRate = floatabs(angleDiff) * 1000.0 / float(CAMRY_TICK_MS);

        // --- forward heading; project velocity onto it (signed) ---
        new Float:fx = -floatsin(zAngle, degrees);
        new Float:fy =  floatcos(zAngle, degrees);
        new Float:fwdSpeed = vx*fx + vy*fy;

        // --- anti-drift: project onto heading-aligned axes, scale lateral.
        //     Always applied so coast-and-turn feels controlled.
        new Float:lx = -fy;
        new Float:ly =  fx;
        new Float:fwdMag = vx*fx + vy*fy;
        new Float:latMag = vx*lx + vy*ly;
        latMag *= (1.0 - CAMRY_LATERAL_GRIP);
        new Float:nvx = fx*fwdMag + lx*latMag;
        new Float:nvy = fy*fwdMag + ly*latMag;
        new Float:nvz = vz;

        // --- smooth yaw fade: 1.0 below TURN_SOFT, 0.0 above TURN_HARD,
        //     linear in between. Tight band so turning feels Azelow-smooth.
        new Float:yawFade = 1.0;
        if (turnRate >= CAMRY_TURN_HARD)
            yawFade = 0.0;
        else if (turnRate > CAMRY_TURN_SOFT)
            yawFade = (CAMRY_TURN_HARD - turnRate)
                    / (CAMRY_TURN_HARD - CAMRY_TURN_SOFT);

        // --- soft cap: scale thrust by (1 - (speed/max)^3). Acceleration
        //     tapers smoothly to zero at the cap.
        new Float:r = hSpeed / maxVel;
        if (r > 1.0) r = 1.0;
        new Float:capFade = 1.0 - r*r*r;
        if (capFade < 0.0) capFade = 0.0;

        new bool:doThrust =
            onGas
            && fwdSpeed > minBoost
            && hSpeed > 0.001
            && floatabs(vz) < CAMRY_SLOPE_LIMIT
            && capFade > 0.0
            && yawFade > 0.0;

        if (doThrust)
        {
            new Float:thrust = CAMRY_THRUST * yawFade * capFade;

            // Push along the actual VELOCITY direction so a mid-turn boost
            // doesn't appear as a sideways shove.
            new Float:dirX = vx / hSpeed;
            new Float:dirY = vy / hSpeed;
            new Float:nx = nvx + dirX * thrust;
            new Float:ny = nvy + dirY * thrust;
            new Float:newSpeed = floatsqroot(nx*nx + ny*ny + nvz*nvz);
            if (newSpeed > maxVel)
            {
                new Float:k = maxVel / newSpeed;
                nx *= k; ny *= k;
            }
            SetVehicleVelocity(vid, nx, ny, nvz);
            continue;
        }

        // --- off-gas brake assist: confident, decisive stops ---
        if (!onGas && fwdMag > minBoost)
        {
            new Float:k = 1.0 / CAMRY_BRAKE_BOOST;
            nvx *= k; nvy *= k;
        }

        // --- safety cap on the post-grip velocity ---
        new Float:newSpeed2 = floatsqroot(nvx*nvx + nvy*nvy + nvz*nvz);
        if (newSpeed2 > maxVel)
        {
            new Float:k = maxVel / newSpeed2;
            nvx *= k; nvy *= k;
        }
        SetVehicleVelocity(vid, nvx, nvy, nvz);
    }
}


// -----------------------------------------------------------------------------
// hooks
// -----------------------------------------------------------------------------

public OnFilterScriptInit()
{
    print("[car_camry] -------------------------------------------");
    print("[car_camry]  Toyota Camry XSE V6 filterscript loaded");
    print("[car_camry]  Model ID: 516 (NEBULA) | Open to all");
    print("[car_camry]  Speed cap: 260 km/h | 0-200 in ~7s | Fuel: infinite");
    print("[car_camry] -------------------------------------------");

    new spawned = 0;
    for (new i = 0; i < sizeof(gCamrySpawns); i++)
    {
        gCamryStaticIds[i] = CreateVehicle(
            CAMRY_MODEL,
            gCamrySpawns[i][0],
            gCamrySpawns[i][1],
            gCamrySpawns[i][2],
            gCamrySpawns[i][3],
            -1, -1,
            -1
        );
        if (gCamryStaticIds[i] != INVALID_VEHICLE_ID)
        {
            CamryForceReady(gCamryStaticIds[i]);
            spawned++;
        }
    }

    gEngineTimer = SetTimer("CamryEngineTick", CAMRY_TICK_MS, true);

    new buf[96];
    format(buf, sizeof(buf), "OnFilterScriptInit: spawned %d/%d Camrys, timer=%d",
        spawned, sizeof(gCamrySpawns), gEngineTimer);
    LogCamry(buf);
    return 1;
}

public OnFilterScriptExit()
{
    if (gEngineTimer != -1)
    {
        KillTimer(gEngineTimer);
        gEngineTimer = -1;
    }

    for (new i = 0; i < sizeof(gCamryStaticIds); i++)
    {
        if (gCamryStaticIds[i] != INVALID_VEHICLE_ID && gCamryStaticIds[i] != -1)
        {
            DestroyVehicle(gCamryStaticIds[i]);
            gCamryStaticIds[i] = -1;
        }
    }
    for (new i = 0; i < CAMRY_MAX_DYN; i++)
    {
        if (gCamryDynIds[i] != -1)
        {
            DestroyVehicle(gCamryDynIds[i]);
            gCamryDynIds[i] = -1;
        }
    }

    LogCamry("OnFilterScriptExit: cleaned up");
    return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    #pragma unused oldstate
    if (newstate == PLAYER_STATE_DRIVER)
    {
        new vid = GetPlayerVehicleID(playerid);
        if (vid != 0 && IsCamry(vid))
        {
            CamryForceReady(vid);
            // Seed lastSpeed with the *current* horizontal velocity so the
            // first tick's `delta` is small and the gas detector doesn't
            // misclassify the entry as "free-falling downhill".
            new Float:vx, Float:vy, Float:vz;
            GetVehicleVelocity(vid, vx, vy, vz);
            #pragma unused vz
            gCamryLastSpeed[playerid] = floatsqroot(vx*vx + vy*vy);
            new Float:zAngle;
            GetVehicleZAngle(vid, zAngle);
            gCamryLastZ[playerid] = zAngle;
        }
    }
    else
    {
        gCamryLastSpeed[playerid] = 0.0;
        gCamryLastZ[playerid]     = 0.0;
    }
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    #pragma unused reason
    gCamryLastSpeed[playerid] = 0.0;
    gCamryLastZ[playerid]     = 0.0;
    return 1;
}


// -----------------------------------------------------------------------------
// commands
// -----------------------------------------------------------------------------

CMD:camry(playerid, params[])
{
    #pragma unused params

    new Float:px, Float:py, Float:pz;
    GetPlayerPos(playerid, px, py, pz);

    new bestVeh   = INVALID_VEHICLE_ID;
    new Float:best = 99999.0;

    for (new i = 0; i < sizeof(gCamryStaticIds); i++)
    {
        new vid = gCamryStaticIds[i];
        if (vid == INVALID_VEHICLE_ID || vid == -1) continue;
        new Float:vx, Float:vy, Float:vz;
        GetVehiclePos(vid, vx, vy, vz);
        new Float:d = floatsqroot(
            (vx-px)*(vx-px) + (vy-py)*(vy-py) + (vz-pz)*(vz-pz)
        );
        if (d < best) { best = d; bestVeh = vid; }
    }
    for (new i = 0; i < CAMRY_MAX_DYN; i++)
    {
        new vid = gCamryDynIds[i];
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
            "{FF6464}* No Camry is currently spawned.");
        return 1;
    }

    PutPlayerInVehicle(playerid, bestVeh, 0);
    SendClientMessage(playerid, 0x66FF66FF,
        "{66FF66}* Teleported you into the nearest Toyota Camry XSE V6.");

    new buf[96], name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    format(buf, sizeof(buf), "%s used /camry (vehicleid=%d)", name, bestVeh);
    LogCamry(buf);
    return 1;
}

CMD:spawncamry(playerid, params[])
{
    new col1 = -1, col2 = -1;
    if (params[0] != EOS) sscanf_two_ints(params, col1, col2);

    new Float:px, Float:py, Float:pz, Float:pa;
    GetPlayerPos(playerid, px, py, pz);
    GetPlayerFacingAngle(playerid, pa);

    new Float:fx = px + floatcos(pa+90.0, degrees) * 5.0;
    new Float:fy = py + floatsin(pa+90.0, degrees) * 5.0;

    new vid = CreateVehicle(CAMRY_MODEL, fx, fy, pz, pa, col1, col2, -1);
    if (vid == INVALID_VEHICLE_ID)
    {
        SendClientMessage(playerid, 0xFF6464FF,
            "{FF6464}* CreateVehicle failed - server rejected the model.");
        return 1;
    }

    CamryForceReady(vid);
    RegisterDynCamry(vid);

    new buf[96], name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    format(buf, sizeof(buf),
        "* Spawned a Camry (id=%d, colours=%d/%d).", vid, col1, col2);
    SendClientMessage(playerid, 0x66FF66FF, buf);

    format(buf, sizeof(buf),
        "%s spawned Camry vid=%d at (%.1f,%.1f,%.1f)",
        name, vid, fx, fy, pz);
    LogCamry(buf);
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
