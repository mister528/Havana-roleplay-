// =============================================================================
//  car_byd — BYD Destroyer 05 (replaces ADMIRAL, model id 445)
// -----------------------------------------------------------------------------
//  Filterscript for HavanaRp / SA-MP 0.3.7 R2.
//
//  * Spawns three BYD vehicles in the Las Venturas showroom row.
//  * /byd                     — teleports the caller into the nearest one.
//  * /spawnbyd [c1] [c2]      — anyone can spawn one in front of them.
//  * Engine auto-starts on entry, 210 km/h speed cap enforced server-side.
//  * Doors always unlocked, full fuel (bypasses gamemode's fuel check).
//  * Logs to scriptfiles/car_byd.log.
//
//  Physics (refined v3, same family as car_cheetah / car_mercedes):
//   * 210 km/h cap with cubic soft-cap (no jitter near the wall)
//   * Strong, smooth thrust: ~+10 km/h per tick at low speed, fading to 0
//   * Lateral grip 0.45 — planted but not on rails (between Cheetah & MB)
//   * Smooth yaw fade: thrust scales linearly between SOFT/HARD turn rates
//   * Confident off-gas brake assist for a deliberate, balanced feel
//   * 2 Hz tick (500 ms) — snappy turn detection, smooth top-speed climb
//   * Boosts ANY model-445 vehicle (admin-spawned, gamemode-spawned, etc.)
// =============================================================================

#include <a_samp>
#include <zcmd>

#define BYD_MODEL           445
#define BYD_LOGFILE         "car_byd.log"

// --- speed tuning ---
#define BYD_MAX_SPEED       210.0  // km/h hard cap
#define BYD_MIN_BOOST         8.0  // km/h — thrust kicks in early for snappy
                                   // launches off the line
#define BYD_THRUST          0.055  // SA-MP velocity units added per tick
                                   // (0.055 * 180 ≈ +10 km/h per tick @2Hz
                                   //  scaled by yaw + cap fades)
#define BYD_DECEL_THRESH      5.0  // km/h drop/tick that = off-gas
#define BYD_ACCEL_LIMIT      22.0  // km/h rise/tick above which we assume
                                   // it's gravity (downhill), not engine.
#define BYD_TURN_SOFT        15.0  // deg/sec — full thrust at or below this
#define BYD_TURN_HARD        32.0  // deg/sec — no thrust at or above this
                                   // (smooth linear fade between the two)
#define BYD_SLOPE_LIMIT      0.08  // |vz| above which we skip thrust because
                                   // the car is on a slope and gravity is
                                   // doing the work.
#define BYD_LATERAL_GRIP     0.45  // 0..1 — fraction of lateral velocity
                                   // killed each tick. Mid-weight grip:
                                   // sedan-feel, planted in turns without
                                   // killing the natural slide.
#define BYD_BRAKE_BOOST      1.03  // off-gas brake assist multiplier
                                   // (moderate — the BYD is a sedan, not a
                                   // race car, so stops should feel measured)
#define BYD_TICK_MS           500  // 2 Hz — same cadence as Cheetah/Mercedes

// Conversion: SA-MP velocity magnitude * 180 ≈ km/h.
#define VEL_TO_KMH         180.0

// We track up to 64 dynamically spawned BYDs (via /spawnbyd) ON TOP of the
// three static ones — more than enough for a 50-slot server.
#define BYD_MAX_DYN          64

// Three pre-placed spawn points at the Wang Cars showroom (Las Venturas),
// offset from the Mercedes row so the two cars don't fight for space.
new const Float:gBydSpawns[][4] = {
    {  2127.0000,   1430.0000, 10.5200,  90.0000 },
    {  2127.0000,   1437.0000, 10.5200,  90.0000 },
    {  2127.0000,   1444.0000, 10.5200,  90.0000 }
};

new gBydStaticIds[sizeof(gBydSpawns)] = { -1, ... };

// Dynamic set filled by /spawnbyd; -1 = empty slot.
new gBydDynIds[BYD_MAX_DYN] = { -1, ... };

// Engine-keepalive timer id.
new gEngineTimer = -1;

// Last measured horizontal velocity per player (raw SA-MP units).
new Float:gBydLastSpeed[MAX_PLAYERS];
// Last measured Z angle per player (for yaw-rate derivation).
new Float:gBydLastZ[MAX_PLAYERS];


// -----------------------------------------------------------------------------
// helpers
// -----------------------------------------------------------------------------

LogByd(const text[])
{
    new File:fp = fopen(BYD_LOGFILE, io_append);
    if (fp == File:0) return;
    new buf[256];
    new hh, mm, ss;
    gettime(hh, mm, ss);
    format(buf, sizeof(buf), "[%02d:%02d:%02d] %s\r\n", hh, mm, ss, text);
    fwrite(fp, buf);
    fclose(fp);
}

// Return true if `vid` is a BYD/ADMIRAL (model 445) regardless of spawner.
// The static + dynamic id arrays remain only as targets for the /byd
// teleport command; the boost itself applies to ANY model-445 vehicle so
// admin-spawned, gamemode-spawned, or third-party-FS-spawned BYDs all
// inherit the same physics.
stock IsByd(vid)
{
    if (vid == INVALID_VEHICLE_ID || vid == 0) return 0;
    return GetVehicleModel(vid) == BYD_MODEL;
}

// Register a dynamically spawned BYD, returns 1 if stored ok.
stock RegisterDynByd(vid)
{
    for (new i = 0; i < BYD_MAX_DYN; i++)
    {
        if (gBydDynIds[i] == -1)
        {
            gBydDynIds[i] = vid;
            return 1;
        }
    }
    return 0;
}

// Start the engine and unlock doors for a vehicle.
stock BydForceReady(vid)
{
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vid, VEHICLE_PARAMS_ON, lights, alarm, false, bonnet, boot, objective);
}


// -----------------------------------------------------------------------------
// Timer: keep engine alive + apply tuned thrust for all occupied BYDs.
// Runs every BYD_TICK_MS ms.
// -----------------------------------------------------------------------------

forward BydEngineTick();
public  BydEngineTick()
{
    new Float:maxVel       = BYD_MAX_SPEED      / VEL_TO_KMH;
    new Float:minBoost     = BYD_MIN_BOOST      / VEL_TO_KMH;
    new Float:decelThresh  = -BYD_DECEL_THRESH  / VEL_TO_KMH;
    new Float:accelLimit   =  BYD_ACCEL_LIMIT   / VEL_TO_KMH;

    for (new p = 0; p < MAX_PLAYERS; p++)
    {
        if (!IsPlayerConnected(p)) continue;
        if (GetPlayerState(p) != PLAYER_STATE_DRIVER) continue;

        new vid = GetPlayerVehicleID(p);
        if (vid == 0 || !IsByd(vid)) continue;

        // --- engine keep-alive ---
        BydForceReady(vid);

        // --- velocity read ---
        new Float:vx, Float:vy, Float:vz;
        GetVehicleVelocity(vid, vx, vy, vz);

        // --- horizontal-only speed (ignores slope contribution) ---
        new Float:hSpeed = floatsqroot(vx*vx + vy*vy);

        // --- gas detection ---
        new Float:lastSpeed = gBydLastSpeed[p];
        new Float:delta     = hSpeed - lastSpeed;
        gBydLastSpeed[p]    = hSpeed;
        new bool:onGas = (delta > decelThresh && delta < accelLimit);

        // --- yaw rate (deg/sec) since last tick ---
        new Float:zAngle;
        GetVehicleZAngle(vid, zAngle);
        new Float:lastZ = gBydLastZ[p];
        new Float:angleDiff = zAngle - lastZ;
        if (angleDiff >  180.0) angleDiff -= 360.0;
        if (angleDiff < -180.0) angleDiff += 360.0;
        gBydLastZ[p] = zAngle;
        new Float:turnRate = floatabs(angleDiff) * 1000.0 / float(BYD_TICK_MS);

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
        latMag *= (1.0 - BYD_LATERAL_GRIP);
        new Float:nvx = fx*fwdMag + lx*latMag;
        new Float:nvy = fy*fwdMag + ly*latMag;
        new Float:nvz = vz;

        // --- smooth yaw fade: 1.0 below TURN_SOFT, 0.0 above TURN_HARD,
        //     linear in between.
        new Float:yawFade = 1.0;
        if (turnRate >= BYD_TURN_HARD)
            yawFade = 0.0;
        else if (turnRate > BYD_TURN_SOFT)
            yawFade = (BYD_TURN_HARD - turnRate)
                    / (BYD_TURN_HARD - BYD_TURN_SOFT);

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
            && floatabs(vz) < BYD_SLOPE_LIMIT
            && capFade > 0.0
            && yawFade > 0.0;

        if (doThrust)
        {
            new Float:thrust = BYD_THRUST * yawFade * capFade;

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

        // --- off-gas brake assist: gentle, deliberate stops ---
        if (!onGas && fwdMag > minBoost)
        {
            new Float:k = 1.0 / BYD_BRAKE_BOOST;
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
    print("[car_byd] -------------------------------------------");
    print("[car_byd]  BYD Destroyer 05 filterscript loaded");
    print("[car_byd]  Model ID: 445 (ADMIRAL) | Open to all");
    print("[car_byd]  Speed cap: 210 km/h | Soft cap + grip @2Hz | Fuel: infinite");
    print("[car_byd] -------------------------------------------");

    new spawned = 0;
    for (new i = 0; i < sizeof(gBydSpawns); i++)
    {
        gBydStaticIds[i] = CreateVehicle(
            BYD_MODEL,
            gBydSpawns[i][0],
            gBydSpawns[i][1],
            gBydSpawns[i][2],
            gBydSpawns[i][3],
            -1, -1,
            -1
        );
        if (gBydStaticIds[i] != INVALID_VEHICLE_ID)
        {
            BydForceReady(gBydStaticIds[i]);
            spawned++;
        }
    }

    gEngineTimer = SetTimer("BydEngineTick", BYD_TICK_MS, true);

    new buf[96];
    format(buf, sizeof(buf), "OnFilterScriptInit: spawned %d/%d BYDs, timer=%d",
        spawned, sizeof(gBydSpawns), gEngineTimer);
    LogByd(buf);
    return 1;
}

public OnFilterScriptExit()
{
    if (gEngineTimer != -1)
    {
        KillTimer(gEngineTimer);
        gEngineTimer = -1;
    }

    for (new i = 0; i < sizeof(gBydStaticIds); i++)
    {
        if (gBydStaticIds[i] != INVALID_VEHICLE_ID && gBydStaticIds[i] != -1)
        {
            DestroyVehicle(gBydStaticIds[i]);
            gBydStaticIds[i] = -1;
        }
    }
    for (new i = 0; i < BYD_MAX_DYN; i++)
    {
        if (gBydDynIds[i] != -1)
        {
            DestroyVehicle(gBydDynIds[i]);
            gBydDynIds[i] = -1;
        }
    }

    LogByd("OnFilterScriptExit: cleaned up");
    return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    #pragma unused oldstate
    if (newstate == PLAYER_STATE_DRIVER)
    {
        new vid = GetPlayerVehicleID(playerid);
        if (vid != 0 && IsByd(vid))
        {
            BydForceReady(vid);
            // Seed lastSpeed with the *current* horizontal velocity so the
            // first tick's `delta` is small and the gas detector doesn't
            // misclassify the entry as "free-falling downhill".
            new Float:vx, Float:vy, Float:vz;
            GetVehicleVelocity(vid, vx, vy, vz);
            #pragma unused vz
            gBydLastSpeed[playerid] = floatsqroot(vx*vx + vy*vy);
            new Float:zAngle;
            GetVehicleZAngle(vid, zAngle);
            gBydLastZ[playerid] = zAngle;
        }
    }
    else
    {
        gBydLastSpeed[playerid] = 0.0;
        gBydLastZ[playerid]     = 0.0;
    }
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    #pragma unused reason
    gBydLastSpeed[playerid] = 0.0;
    gBydLastZ[playerid]     = 0.0;
    return 1;
}


// -----------------------------------------------------------------------------
// commands
// -----------------------------------------------------------------------------

CMD:byd(playerid, params[])
{
    #pragma unused params

    new Float:px, Float:py, Float:pz;
    GetPlayerPos(playerid, px, py, pz);

    new bestVeh   = INVALID_VEHICLE_ID;
    new Float:best = 99999.0;

    for (new i = 0; i < sizeof(gBydStaticIds); i++)
    {
        new vid = gBydStaticIds[i];
        if (vid == INVALID_VEHICLE_ID || vid == -1) continue;
        new Float:vx, Float:vy, Float:vz;
        GetVehiclePos(vid, vx, vy, vz);
        new Float:d = floatsqroot(
            (vx-px)*(vx-px) + (vy-py)*(vy-py) + (vz-pz)*(vz-pz)
        );
        if (d < best) { best = d; bestVeh = vid; }
    }
    for (new i = 0; i < BYD_MAX_DYN; i++)
    {
        new vid = gBydDynIds[i];
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
            "{FF6464}* No BYD is currently spawned.");
        return 1;
    }

    PutPlayerInVehicle(playerid, bestVeh, 0);
    SendClientMessage(playerid, 0x66FF66FF,
        "{66FF66}* Teleported you into the nearest BYD Destroyer 05.");

    new buf[96], name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    format(buf, sizeof(buf), "%s used /byd (vehicleid=%d)", name, bestVeh);
    LogByd(buf);
    return 1;
}

CMD:spawnbyd(playerid, params[])
{
    new col1 = -1, col2 = -1;
    if (params[0] != EOS) sscanf_two_ints(params, col1, col2);

    new Float:px, Float:py, Float:pz, Float:pa;
    GetPlayerPos(playerid, px, py, pz);
    GetPlayerFacingAngle(playerid, pa);

    new Float:fx = px + floatcos(pa+90.0, degrees) * 5.0;
    new Float:fy = py + floatsin(pa+90.0, degrees) * 5.0;

    new vid = CreateVehicle(BYD_MODEL, fx, fy, pz, pa, col1, col2, -1);
    if (vid == INVALID_VEHICLE_ID)
    {
        SendClientMessage(playerid, 0xFF6464FF,
            "{FF6464}* CreateVehicle failed - server rejected the model.");
        return 1;
    }

    BydForceReady(vid);
    RegisterDynByd(vid);

    new buf[96], name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    format(buf, sizeof(buf),
        "* Spawned a BYD (id=%d, colours=%d/%d).", vid, col1, col2);
    SendClientMessage(playerid, 0x66FF66FF, buf);

    format(buf, sizeof(buf),
        "%s spawned BYD vid=%d at (%.1f,%.1f,%.1f)",
        name, vid, fx, fy, pz);
    LogByd(buf);
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
