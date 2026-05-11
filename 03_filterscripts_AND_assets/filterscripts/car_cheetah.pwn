// =============================================================================
//  car_cheetah — Ferrari 849 Testarossa (replaces CHEETAH, model id 415)
// -----------------------------------------------------------------------------
//  Filterscript for HavanaRp / SA-MP 0.3.7 R2.
//
//  * Spawns three Cheetah vehicles at the Rodeo showroom (LS).
//  * /cheetah           — teleports the caller into the nearest one.
//  * /spawncheetah [c1] [c2] — anyone can spawn one in front of them.
//  * Engine auto-starts on entry, 250 km/h speed cap enforced server-side.
//  * Doors always unlocked, full fuel (bypasses gamemode's fuel check).
//  * Logs to scriptfiles/car_cheetah.log.
// =============================================================================

#include <a_samp>
#include <zcmd>

#define CHEETAH_MODEL       415
#define CHEETAH_LOGFILE     "car_cheetah.log"
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
//   1) CLIENT (handling.cfg patch in patch_8000_cheetah/): a tuned STALLION
//      line with higher TopSpeed, sharper Acceleration and better grip. This
//      is what gives the car its "fast & planted" feel during normal driving.
//   2) SERVER (this file): a *very* gentle additive thrust at a low frequency
//      (1 Hz) so the client physics has 999ms to settle naturally between
//      each touch. We only push forward, only when actively driving above the
//      min speed, and only enough to overcome any residual handling.cfg cap.
//
// Result: smooth vanilla-feel turning + steady climb to CHEETAH_MAX_SPEED.
// Cheetah (Ferrari 849 Testarossa) physics: refined v2 — "fast but planted".
//   * 320 km/h cap with cubic soft-cap (no hard wall jitter)
//   * 2 Hz tick (500 ms) — snappier turn detection, smoother thrust feel
//   * mild lateral grip (0.30) so the car follows its nose without skating
//   * smooth yaw suppression: thrust fades 0..1 between SOFT/HARD turn rates
//   * gentle brake assist when the player lets off the gas at speed
//   * effective thrust per tick ~0.040 base × 0..1 yaw fade × 0..1 cap fade
#define CHEETAH_MAX_SPEED        320.0  // km/h hard cap
#define CHEETAH_MIN_BOOST          8.0  // km/h — thrust kicks in earlier for
                                        // snappy launches
#define CHEETAH_THRUST           0.045  // SA-MP velocity units added per tick
                                        // (0.045 * 180 ≈ +8 km/h per tick @2Hz
                                        // → ~16 km/h/sec at low speed,
                                        //   tapering smoothly to 0 at cap)
#define CHEETAH_DECEL_THRESH      5.0   // km/h drop/tick that = off-gas
#define CHEETAH_ACCEL_LIMIT      22.0   // km/h rise/tick above which we assume
                                        // it's gravity (downhill), not engine.
#define CHEETAH_TURN_SOFT        12.0   // deg/sec — at or below this, full thrust
#define CHEETAH_TURN_HARD        28.0   // deg/sec — at or above this, no thrust
                                        // (between the two we fade smoothly)
#define CHEETAH_SLOPE_LIMIT      0.08   // |vz| above which we skip thrust
                                        // because the car is on a slope and
                                        // gravity is doing the work.
#define CHEETAH_LATERAL_GRIP     0.30   // 0..1 — fraction of lateral velocity
                                        // killed each tick. Light grip keeps
                                        // it agile but planted (vs Mercedes
                                        // 0.55 which is heavier-feeling).
#define CHEETAH_BRAKE_BOOST      1.02   // off-gas brake assist multiplier
                                        // (very gentle — Ferrari coasts long)
#define CHEETAH_TICK_MS           500   // 2 Hz — same cadence as Mercedes for
                                        // consistent feel across the fleet

// Conversion: SA-MP velocity magnitude * 180 ≈ km/h.
#define VEL_TO_KMH         180.0

// We track up to 64 dynamically spawned Cheetah vehicles (via /spawncheetah)
// ON TOP of the three static ones — more than enough for a 50-slot server.
#define CHEETAH_MAX_DYN     64

// Three pre-placed spawn points at the Doherty showroom (San Fierro)
// so the Cheetah doesn't conflict with Azelow (Rodeo) or Mercedes (LV).
new const Float:gCheetahSpawns[][4] = {
    { -1668.0000,    410.0000, 6.6500,  90.0000 },
    { -1668.0000,    417.0000, 6.6500,  90.0000 },
    { -1668.0000,    424.0000, 6.6500,  90.0000 }
};

new gCheetahStaticIds[sizeof(gCheetahSpawns)] = { -1, ... };

// Dynamic set filled by /spawncheetah; -1 = empty slot.
new gCheetahDynIds[CHEETAH_MAX_DYN] = { -1, ... };

// Engine-keepalive timer id.
new gEngineTimer = -1;

// Last measured velocity magnitude per player (in raw SA-MP units).
// Used to detect whether the car is accelerating (gas) or decelerating
// (off-gas / braking). Reset on disconnect / state change.
new Float:gCheetahLastSpeed[MAX_PLAYERS];

// Last measured Z angle, used to derive yaw rate so we can suppress
// thrust during sharp turns (otherwise the boost feels like a sideways
// kick because it's applied along the heading vector mid-turn).
new Float:gCheetahLastZ[MAX_PLAYERS];


// -----------------------------------------------------------------------------
// helpers
// -----------------------------------------------------------------------------

LogCheetah(const text[])
{
    new File:fp = fopen(CHEETAH_LOGFILE, io_append);
    if (fp == File:0) return;
    new buf[256];
    new hh, mm, ss;
    gettime(hh, mm, ss);
    format(buf, sizeof(buf), "[%02d:%02d:%02d] %s\r\n", hh, mm, ss, text);
    fwrite(fp, buf);
    fclose(fp);
}

// Return true if `vid` is a CHEETAH (model 415) regardless of who spawned it.
// The static + dynamic id arrays remain only as targets for the /cheetah
// teleport command; the boost itself applies to ANY model-415 vehicle so
// admin-spawned, gamemode-spawned, or third-party-FS-spawned Cheetahs all
// inherit the same physics.  This was the root cause of the "my Cheetah is
// stuck at 150 km/h" report — those vehicles weren't in the registered set.
stock IsCheetah(vid)
{
    if (vid == INVALID_VEHICLE_ID || vid == 0) return 0;
    return GetVehicleModel(vid) == CHEETAH_MODEL;
}

// Register a dynamically spawned Cheetah, returns 1 if stored ok.
stock RegisterDynCheetah(vid)
{
    for (new i = 0; i < CHEETAH_MAX_DYN; i++)
    {
        if (gCheetahDynIds[i] == -1)
        {
            gCheetahDynIds[i] = vid;
            return 1;
        }
    }
    return 0;
}

// Start the engine and unlock doors for a vehicle.
stock CheetahForceReady(vid)
{
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vid, VEHICLE_PARAMS_ON, lights, alarm, false, bonnet, boot, objective);
}


// -----------------------------------------------------------------------------
// Timer: keep engine alive for all occupied Cheetahs (overrides gamemode fuel=0).
// Also enforces the 200 km/h speed cap.
// Runs every 500 ms.
// -----------------------------------------------------------------------------

forward CheetahEngineTick();
public  CheetahEngineTick()
{
    new Float:maxVel       = CHEETAH_MAX_SPEED      / VEL_TO_KMH;
    new Float:minBoost     = CHEETAH_MIN_BOOST      / VEL_TO_KMH;
    new Float:decelThresh  = -CHEETAH_DECEL_THRESH  / VEL_TO_KMH;
    new Float:accelLimit   =  CHEETAH_ACCEL_LIMIT   / VEL_TO_KMH;

    for (new p = 0; p < MAX_PLAYERS; p++)
    {
        if (!IsPlayerConnected(p)) continue;
        if (GetPlayerState(p) != PLAYER_STATE_DRIVER) continue;

        new vid = GetPlayerVehicleID(p);
        if (vid == 0 || !IsCheetah(vid)) continue;

        // --- engine keep-alive ---
        CheetahForceReady(vid);

        // --- velocity read ---
        new Float:vx, Float:vy, Float:vz;
        GetVehicleVelocity(vid, vx, vy, vz);

        // --- horizontal-only speed (ignores slope contribution) ---
        new Float:hSpeed = floatsqroot(vx*vx + vy*vy);

        // --- gas detection: speed must be in a reasonable band ---
        //   * delta > decelThresh  → not off-gas / braking
        //   * delta < accelLimit   → not free-falling down a hill
        new Float:lastSpeed = gCheetahLastSpeed[p];
        new Float:delta     = hSpeed - lastSpeed;
        gCheetahLastSpeed[p] = hSpeed;
        new bool:onGas = (delta > decelThresh && delta < accelLimit);

        // --- yaw rate (deg/sec) since last tick ---
        new Float:zAngle;
        GetVehicleZAngle(vid, zAngle);
        new Float:lastZ = gCheetahLastZ[p];
        new Float:angleDiff = zAngle - lastZ;
        if (angleDiff >  180.0) angleDiff -= 360.0;
        if (angleDiff < -180.0) angleDiff += 360.0;
        gCheetahLastZ[p] = zAngle;
        new Float:turnRate = floatabs(angleDiff) * 1000.0 / float(CHEETAH_TICK_MS);

        // --- forward heading; project velocity onto it (signed) ---
        new Float:fx = -floatsin(zAngle, degrees);
        new Float:fy =  floatcos(zAngle, degrees);
        new Float:fwdSpeed = vx*fx + vy*fy;

        // --- anti-drift: project onto heading-aligned axes, scale lateral.
        //     Light grip (0.30) keeps the car agile but stops it from
        //     skating sideways at high speed.  Always applied so coast-and-
        //     turn feels controlled, not just under throttle.
        new Float:lx = -fy;
        new Float:ly =  fx;
        new Float:fwdMag = vx*fx + vy*fy;
        new Float:latMag = vx*lx + vy*ly;
        latMag *= (1.0 - CHEETAH_LATERAL_GRIP);
        new Float:nvx = fx*fwdMag + lx*latMag;
        new Float:nvy = fy*fwdMag + ly*latMag;
        new Float:nvz = vz;

        // --- smooth yaw fade: 1.0 below TURN_SOFT, 0.0 above TURN_HARD,
        //     linear in between.  Prevents the abrupt thrust-cut that made
        //     the old binary guard feel like the car "hit a step" mid-turn.
        new Float:yawFade = 1.0;
        if (turnRate >= CHEETAH_TURN_HARD)
            yawFade = 0.0;
        else if (turnRate > CHEETAH_TURN_SOFT)
            yawFade = (CHEETAH_TURN_HARD - turnRate)
                    / (CHEETAH_TURN_HARD - CHEETAH_TURN_SOFT);

        // --- soft cap: scale thrust by (1 - (speed/max)^3) so acceleration
        //     tapers to zero at the cap instead of hard-clipping. Eliminates
        //     the bouncy "hit the wall" feel near top speed.
        new Float:r = hSpeed / maxVel;
        if (r > 1.0) r = 1.0;
        new Float:capFade = 1.0 - r*r*r;
        if (capFade < 0.0) capFade = 0.0;

        new bool:doThrust =
            onGas
            && fwdSpeed > minBoost
            && hSpeed > 0.001
            && floatabs(vz) < CHEETAH_SLOPE_LIMIT     // not on a steep slope
            && capFade > 0.0
            && yawFade > 0.0;

        if (doThrust)
        {
            new Float:thrust = CHEETAH_THRUST * yawFade * capFade;

            // Push along the actual VELOCITY direction (not heading) so a
            // mid-turn boost doesn't appear as a sideways shove. The car
            // gets faster in whatever direction it's actually traveling.
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

        // --- off-gas brake assist: very gentle multiplier so the Ferrari
        //     still coasts long, but stops feel deliberate when the player
        //     wants them to.
        if (!onGas && fwdMag > minBoost)
        {
            new Float:k = 1.0 / CHEETAH_BRAKE_BOOST;
            nvx *= k; nvy *= k;
        }

        // --- safety cap on the post-grip velocity (rarely hit) ---
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
    print("[car_cheetah] -------------------------------------------");
    print("[car_cheetah]  Ferrari 849 Testarossa filterscript loaded");
    print("[car_cheetah]  Model ID: 415 (CHEETAH) | Open to all");
    print("[car_cheetah]  Speed cap: 320 km/h | Soft cap + lateral grip @2Hz | Fuel: infinite");
    print("[car_cheetah] -------------------------------------------");

    new spawned = 0;
    for (new i = 0; i < sizeof(gCheetahSpawns); i++)
    {
        gCheetahStaticIds[i] = CreateVehicle(
            CHEETAH_MODEL,
            gCheetahSpawns[i][0],
            gCheetahSpawns[i][1],
            gCheetahSpawns[i][2],
            gCheetahSpawns[i][3],
            -1, -1,
            -1
        );
        if (gCheetahStaticIds[i] != INVALID_VEHICLE_ID)
        {
            CheetahForceReady(gCheetahStaticIds[i]);
            spawned++;
        }
    }

    // Timer every CHEETAH_TICK_MS to keep engines alive + apply boost.
    gEngineTimer = SetTimer("CheetahEngineTick", CHEETAH_TICK_MS, true);

    new buf[96];
    format(buf, sizeof(buf), "OnFilterScriptInit: spawned %d/%d Cheetahs, timer=%d",
        spawned, sizeof(gCheetahSpawns), gEngineTimer);
    LogCheetah(buf);
    return 1;
}

public OnFilterScriptExit()
{
    if (gEngineTimer != -1)
    {
        KillTimer(gEngineTimer);
        gEngineTimer = -1;
    }

    for (new i = 0; i < sizeof(gCheetahStaticIds); i++)
    {
        if (gCheetahStaticIds[i] != INVALID_VEHICLE_ID && gCheetahStaticIds[i] != -1)
        {
            DestroyVehicle(gCheetahStaticIds[i]);
            gCheetahStaticIds[i] = -1;
        }
    }
    for (new i = 0; i < CHEETAH_MAX_DYN; i++)
    {
        if (gCheetahDynIds[i] != -1)
        {
            DestroyVehicle(gCheetahDynIds[i]);
            gCheetahDynIds[i] = -1;
        }
    }

    LogCheetah("OnFilterScriptExit: cleaned up");
    return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    // When a player enters an Cheetah as driver, auto-start the engine
    // and reset the speed tracker so the boost ramps from the current
    // velocity, not from a stale (possibly large) value.
    if (newstate == PLAYER_STATE_DRIVER)
    {
        new vid = GetPlayerVehicleID(playerid);
        if (vid != 0 && IsCheetah(vid))
        {
            CheetahForceReady(vid);
            // Seed lastSpeed with the *current* horizontal velocity so the
            // first tick's `delta` is small and the gas detector doesn't
            // misclassify the entry as "free-falling downhill". Otherwise
            // jumping into a moving Cheetah would skip the very first boost.
            new Float:vx, Float:vy, Float:vz;
            GetVehicleVelocity(vid, vx, vy, vz);
            #pragma unused vz
            gCheetahLastSpeed[playerid] = floatsqroot(vx*vx + vy*vy);
            new Float:zAngle;
            GetVehicleZAngle(vid, zAngle);
            gCheetahLastZ[playerid] = zAngle;
        }
    }
    else
    {
        gCheetahLastSpeed[playerid] = 0.0;
        gCheetahLastZ[playerid]     = 0.0;
    }
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    #pragma unused reason
    gCheetahLastSpeed[playerid] = 0.0;
    gCheetahLastZ[playerid]     = 0.0;
    return 1;
}


// -----------------------------------------------------------------------------
// commands
// -----------------------------------------------------------------------------

CMD:cheetah(playerid, params[])
{
    #pragma unused params

    new Float:px, Float:py, Float:pz;
    GetPlayerPos(playerid, px, py, pz);

    new bestVeh   = INVALID_VEHICLE_ID;
    new Float:best = 99999.0;

    // Check static Cheetahs.
    for (new i = 0; i < sizeof(gCheetahStaticIds); i++)
    {
        new vid = gCheetahStaticIds[i];
        if (vid == INVALID_VEHICLE_ID || vid == -1) continue;
        new Float:vx, Float:vy, Float:vz;
        GetVehiclePos(vid, vx, vy, vz);
        new Float:d = floatsqroot(
            (vx-px)*(vx-px) + (vy-py)*(vy-py) + (vz-pz)*(vz-pz)
        );
        if (d < best) { best = d; bestVeh = vid; }
    }
    // Check dynamic Cheetahs.
    for (new i = 0; i < CHEETAH_MAX_DYN; i++)
    {
        new vid = gCheetahDynIds[i];
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
            "{FF6464}* No Cheetah is currently spawned.");
        return 1;
    }

    PutPlayerInVehicle(playerid, bestVeh, 0);
    SendClientMessage(playerid, 0x66FF66FF,
        "{66FF66}* Teleported you into the nearest Ferrari 849 Testarossa Cheetah.");

    new buf[96], name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    format(buf, sizeof(buf), "%s used /cheetah (vehicleid=%d)", name, bestVeh);
    LogCheetah(buf);
    return 1;
}

CMD:spawncheetah(playerid, params[])
{
    new col1 = -1, col2 = -1;
    if (params[0] != EOS) sscanf_two_ints(params, col1, col2);

    new Float:px, Float:py, Float:pz, Float:pa;
    GetPlayerPos(playerid, px, py, pz);
    GetPlayerFacingAngle(playerid, pa);

    new Float:fx = px + floatcos(pa+90.0, degrees) * 5.0;
    new Float:fy = py + floatsin(pa+90.0, degrees) * 5.0;

    new vid = CreateVehicle(CHEETAH_MODEL, fx, fy, pz, pa, col1, col2, -1);
    if (vid == INVALID_VEHICLE_ID)
    {
        SendClientMessage(playerid, 0xFF6464FF,
            "{FF6464}* CreateVehicle failed - server rejected the model.");
        return 1;
    }

    // Auto-ready + register for engine keep-alive.
    CheetahForceReady(vid);
    RegisterDynCheetah(vid);

    new buf[96], name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    format(buf, sizeof(buf),
        "* Spawned an Cheetah (id=%d, colours=%d/%d).", vid, col1, col2);
    SendClientMessage(playerid, 0x66FF66FF, buf);

    format(buf, sizeof(buf),
        "%s spawned Cheetah vid=%d at (%.1f,%.1f,%.1f)",
        name, vid, fx, fy, pz);
    LogCheetah(buf);
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
