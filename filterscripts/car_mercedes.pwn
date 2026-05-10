// =============================================================================
//  car_mercedes — Mercedes-Benz E63 AMG W212 (replaces ALPHA, model id 602)
// -----------------------------------------------------------------------------
//  Filterscript for HavanaRp / SA-MP 0.3.7 R2.
//
//  * Spawns three Mercedes vehicles at the Rodeo showroom (LS).
//  * /mercedes           — teleports the caller into the nearest one.
//  * /spawnmercedes [c1] [c2] — anyone can spawn one in front of them.
//  * Engine auto-starts on entry, 250 km/h speed cap enforced server-side.
//  * Doors always unlocked, full fuel (bypasses gamemode's fuel check).
//  * Logs to scriptfiles/car_mercedes.log.
// =============================================================================

#include <a_samp>
#include <zcmd>

#define MERCEDES_MODEL       602
#define MERCEDES_LOGFILE     "car_mercedes.log"
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
//   1) CLIENT (handling.cfg patch in patch_8000_mercedes/): a tuned STALLION
//      line with higher TopSpeed, sharper Acceleration and better grip. This
//      is what gives the car its "fast & planted" feel during normal driving.
//   2) SERVER (this file): a *very* gentle additive thrust at a low frequency
//      (1 Hz) so the client physics has 999ms to settle naturally between
//      each touch. We only push forward, only when actively driving above the
//      min speed, and only enough to overcome any residual handling.cfg cap.
//
// Result: smooth vanilla-feel turning + steady climb to MERCEDES_MAX_SPEED.
// Mercedes E63 AMG — "strong, smooth, sharp brakes, sharp turning". Refined v2:
//   * 280 km/h cap with cubic soft-cap (no hard wall jitter near top speed)
//   * smooth yaw fade between SOFT/HARD turn rates (no thrust step-cut)
//   * heavy lateral grip (0.55) so the car follows its nose under load
//   * confident brake assist on off-gas (sharper, more deliberate stops)
//   * 2 Hz tick (500 ms) — snappy turns + smooth top-speed climb
#define MERCEDES_MAX_SPEED        280.0  // km/h hard cap
#define MERCEDES_MIN_BOOST         12.0  // km/h — thrust kicks in earlier so
                                        // launches feel torquey from low rev
#define MERCEDES_THRUST           0.050  // SA-MP velocity units added per tick
                                        // (0.050 * 180 ≈ +9 km/h per tick @2Hz
                                        //  scaled by yaw + cap fades)
#define MERCEDES_DECEL_THRESH      5.0   // km/h drop/tick that = off-gas
#define MERCEDES_ACCEL_LIMIT      22.0   // km/h rise/tick above which we assume
                                        // it's gravity (downhill), not engine.
#define MERCEDES_TURN_SOFT        18.0   // deg/sec — at or below this, full thrust
#define MERCEDES_TURN_HARD        38.0   // deg/sec — at or above this, no thrust
                                        // (between the two we fade smoothly so
                                        // there's no step-cut mid-corner)
#define MERCEDES_SLOPE_LIMIT      0.08   // |vz| above which we skip thrust
                                        // because the car is on a slope and
                                        // gravity is doing the work.
#define MERCEDES_LATERAL_GRIP     0.55   // 0..1 — fraction of lateral velocity
                                        // killed each tick. Strong but not
                                        // "on rails": the car still feels like
                                        // it has weight when you turn hard.
#define MERCEDES_BRAKE_BOOST      1.04   // when player is off the gas and
                                        // already decelerating, multiply the
                                        // forward velocity by 1/this every
                                        // tick → sharper, more confident stop.
#define MERCEDES_TICK_MS           500   // 2 Hz — snappy turns + faster
                                        // top-speed climb

// Conversion: SA-MP velocity magnitude * 180 ≈ km/h.
#define VEL_TO_KMH         180.0

// We track up to 64 dynamically spawned Mercedes vehicles (via /spawnmercedes)
// ON TOP of the three static ones — more than enough for a 50-slot server.
#define MERCEDES_MAX_DYN     64

// Three pre-placed spawn points outside the Wang Cars showroom (Las Venturas)
// so the Mercedes doesn't conflict with the Azelow's Rodeo spawns.
new const Float:gMercedesSpawns[][4] = {
    {  2127.0000,   1396.0000, 10.5200,  90.0000 },
    {  2127.0000,   1402.5000, 10.5200,  90.0000 },
    {  2127.0000,   1409.0000, 10.5200,  90.0000 }
};

new gMercedesStaticIds[sizeof(gMercedesSpawns)] = { -1, ... };

// Dynamic set filled by /spawnmercedes; -1 = empty slot.
new gMercedesDynIds[MERCEDES_MAX_DYN] = { -1, ... };

// Engine-keepalive timer id.
new gEngineTimer = -1;

// Last measured velocity magnitude per player (in raw SA-MP units).
// Used to detect whether the car is accelerating (gas) or decelerating
// (off-gas / braking). Reset on disconnect / state change.
new Float:gMercedesLastSpeed[MAX_PLAYERS];

// Last measured Z angle, used to derive yaw rate so we can suppress
// thrust during sharp turns (otherwise the boost feels like a sideways
// kick because it's applied along the heading vector mid-turn).
new Float:gMercedesLastZ[MAX_PLAYERS];


// -----------------------------------------------------------------------------
// helpers
// -----------------------------------------------------------------------------

LogMercedes(const text[])
{
    new File:fp = fopen(MERCEDES_LOGFILE, io_append);
    if (fp == File:0) return;
    new buf[256];
    new hh, mm, ss;
    gettime(hh, mm, ss);
    format(buf, sizeof(buf), "[%02d:%02d:%02d] %s\r\n", hh, mm, ss, text);
    fwrite(fp, buf);
    fclose(fp);
}

// Return true if `vid` is a Mercedes/ALPHA (model 602) regardless of who
// spawned it.  The static + dynamic id arrays remain only as targets for
// the /mercedes teleport command; the boost itself applies to ANY model-602
// vehicle so admin-spawned, gamemode-spawned, or third-party-FS-spawned
// Mercedeses all inherit the same physics.
stock IsMercedes(vid)
{
    if (vid == INVALID_VEHICLE_ID || vid == 0) return 0;
    return GetVehicleModel(vid) == MERCEDES_MODEL;
}

// Register a dynamically spawned Mercedes, returns 1 if stored ok.
stock RegisterDynMercedes(vid)
{
    for (new i = 0; i < MERCEDES_MAX_DYN; i++)
    {
        if (gMercedesDynIds[i] == -1)
        {
            gMercedesDynIds[i] = vid;
            return 1;
        }
    }
    return 0;
}

// Start the engine and unlock doors for a vehicle.
stock MercedesForceReady(vid)
{
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vid, VEHICLE_PARAMS_ON, lights, alarm, false, bonnet, boot, objective);
}


// -----------------------------------------------------------------------------
// Timer: keep engine alive for all occupied Mercedess (overrides gamemode fuel=0).
// Also enforces the 200 km/h speed cap.
// Runs every 500 ms.
// -----------------------------------------------------------------------------

forward MercedesEngineTick();
public  MercedesEngineTick()
{
    new Float:maxVel       = MERCEDES_MAX_SPEED      / VEL_TO_KMH;
    new Float:minBoost     = MERCEDES_MIN_BOOST      / VEL_TO_KMH;
    new Float:decelThresh  = -MERCEDES_DECEL_THRESH  / VEL_TO_KMH;
    new Float:accelLimit   =  MERCEDES_ACCEL_LIMIT   / VEL_TO_KMH;

    for (new p = 0; p < MAX_PLAYERS; p++)
    {
        if (!IsPlayerConnected(p)) continue;
        if (GetPlayerState(p) != PLAYER_STATE_DRIVER) continue;

        new vid = GetPlayerVehicleID(p);
        if (vid == 0 || !IsMercedes(vid)) continue;

        // --- engine keep-alive ---
        MercedesForceReady(vid);

        // --- velocity read ---
        new Float:vx, Float:vy, Float:vz;
        GetVehicleVelocity(vid, vx, vy, vz);

        // --- horizontal-only speed (ignores slope contribution) ---
        new Float:hSpeed = floatsqroot(vx*vx + vy*vy);

        // --- gas detection: speed must be in a reasonable band ---
        //   * delta > decelThresh  → not off-gas / braking
        //   * delta < accelLimit   → not free-falling down a hill
        new Float:lastSpeed = gMercedesLastSpeed[p];
        new Float:delta     = hSpeed - lastSpeed;
        gMercedesLastSpeed[p] = hSpeed;
        new bool:onGas = (delta > decelThresh && delta < accelLimit);

        // --- yaw rate (deg/sec) since last tick ---
        new Float:zAngle;
        GetVehicleZAngle(vid, zAngle);
        new Float:lastZ = gMercedesLastZ[p];
        new Float:angleDiff = zAngle - lastZ;
        if (angleDiff >  180.0) angleDiff -= 360.0;
        if (angleDiff < -180.0) angleDiff += 360.0;
        gMercedesLastZ[p] = zAngle;
        new Float:turnRate = floatabs(angleDiff) * 1000.0 / float(MERCEDES_TICK_MS);

        // --- forward heading; project velocity onto it (signed) ---
        new Float:fx = -floatsin(zAngle, degrees);
        new Float:fy =  floatcos(zAngle, degrees);
        new Float:fwdSpeed = vx*fx + vy*fy;

        // --- anti-drift: project onto heading axes, scale lateral down.
        //     A 0.55 grip means we keep 45% of the slide so the car still
        //     feels "weighted" through corners (not glued to rails) but no
        //     longer skates. We always apply this — even when off-gas — so
        //     coast-and-turn feels controlled.
        new Float:lx = -fy;
        new Float:ly =  fx;
        new Float:fwdMag = vx*fx + vy*fy;
        new Float:latMag = vx*lx + vy*ly;
        latMag *= (1.0 - MERCEDES_LATERAL_GRIP);
        new Float:nvx = fx*fwdMag + lx*latMag;
        new Float:nvy = fy*fwdMag + ly*latMag;
        new Float:nvz = vz;

        // --- smooth yaw fade: 1.0 below TURN_SOFT, 0.0 above TURN_HARD,
        //     linear in between.  Replaces the binary turn-rate guard so
        //     thrust no longer step-cuts mid-corner.
        new Float:yawFade = 1.0;
        if (turnRate >= MERCEDES_TURN_HARD)
            yawFade = 0.0;
        else if (turnRate > MERCEDES_TURN_SOFT)
            yawFade = (MERCEDES_TURN_HARD - turnRate)
                    / (MERCEDES_TURN_HARD - MERCEDES_TURN_SOFT);

        // --- soft cap: scale thrust by (1 - (speed/max)^3) so acceleration
        //     tapers to zero at the cap instead of hard-clipping. Removes
        //     the bouncy "hit the wall" feel near top speed.
        new Float:r = hSpeed / maxVel;
        if (r > 1.0) r = 1.0;
        new Float:capFade = 1.0 - r*r*r;
        if (capFade < 0.0) capFade = 0.0;

        new bool:doThrust =
            onGas
            && fwdSpeed > minBoost
            && hSpeed > 0.001
            && floatabs(vz) < MERCEDES_SLOPE_LIMIT     // not on a steep slope
            && capFade > 0.0
            && yawFade > 0.0;

        if (doThrust)
        {
            new Float:thrust = MERCEDES_THRUST * yawFade * capFade;

            // Add forward thrust along the *heading* (post-grip).
            new Float:nx = nvx + fx * thrust;
            new Float:ny = nvy + fy * thrust;
            new Float:newSpeed = floatsqroot(nx*nx + ny*ny + nvz*nvz);
            if (newSpeed > maxVel)
            {
                new Float:k = maxVel / newSpeed;
                nx *= k; ny *= k;
            }
            SetVehicleVelocity(vid, nx, ny, nvz);
            continue;
        }

        // --- off-gas brake assist: when the player has released the gas
        //     and the car is already slowing, apply an extra deceleration
        //     factor so stops feel sharp & confident (Mercedes signature).
        if (!onGas && fwdMag > minBoost)
        {
            new Float:k = 1.0 / MERCEDES_BRAKE_BOOST;
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
    print("[car_mercedes] -------------------------------------------");
    print("[car_mercedes]  Mercedes-Benz E63 AMG W212 filterscript loaded");
    print("[car_mercedes]  Model ID: 602 (ALPHA) | Open to all");
    print("[car_mercedes]  Speed cap: 280 km/h | Soft cap + heavy grip @2Hz | Fuel: infinite");
    print("[car_mercedes] -------------------------------------------");

    new spawned = 0;
    for (new i = 0; i < sizeof(gMercedesSpawns); i++)
    {
        gMercedesStaticIds[i] = CreateVehicle(
            MERCEDES_MODEL,
            gMercedesSpawns[i][0],
            gMercedesSpawns[i][1],
            gMercedesSpawns[i][2],
            gMercedesSpawns[i][3],
            -1, -1,
            -1
        );
        if (gMercedesStaticIds[i] != INVALID_VEHICLE_ID)
        {
            MercedesForceReady(gMercedesStaticIds[i]);
            spawned++;
        }
    }

    // Timer every MERCEDES_TICK_MS to keep engines alive + apply boost.
    gEngineTimer = SetTimer("MercedesEngineTick", MERCEDES_TICK_MS, true);

    new buf[96];
    format(buf, sizeof(buf), "OnFilterScriptInit: spawned %d/%d Mercedess, timer=%d",
        spawned, sizeof(gMercedesSpawns), gEngineTimer);
    LogMercedes(buf);
    return 1;
}

public OnFilterScriptExit()
{
    if (gEngineTimer != -1)
    {
        KillTimer(gEngineTimer);
        gEngineTimer = -1;
    }

    for (new i = 0; i < sizeof(gMercedesStaticIds); i++)
    {
        if (gMercedesStaticIds[i] != INVALID_VEHICLE_ID && gMercedesStaticIds[i] != -1)
        {
            DestroyVehicle(gMercedesStaticIds[i]);
            gMercedesStaticIds[i] = -1;
        }
    }
    for (new i = 0; i < MERCEDES_MAX_DYN; i++)
    {
        if (gMercedesDynIds[i] != -1)
        {
            DestroyVehicle(gMercedesDynIds[i]);
            gMercedesDynIds[i] = -1;
        }
    }

    LogMercedes("OnFilterScriptExit: cleaned up");
    return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    // When a player enters an Mercedes as driver, auto-start the engine
    // and reset the speed tracker so the boost ramps from the current
    // velocity, not from a stale (possibly large) value.
    if (newstate == PLAYER_STATE_DRIVER)
    {
        new vid = GetPlayerVehicleID(playerid);
        if (vid != 0 && IsMercedes(vid))
        {
            MercedesForceReady(vid);
            // Seed lastSpeed with the *current* horizontal velocity so the
            // first tick's `delta` is small and the gas detector doesn't
            // misclassify the entry as "free-falling downhill".
            new Float:vx, Float:vy, Float:vz;
            GetVehicleVelocity(vid, vx, vy, vz);
            #pragma unused vz
            gMercedesLastSpeed[playerid] = floatsqroot(vx*vx + vy*vy);
            new Float:zAngle;
            GetVehicleZAngle(vid, zAngle);
            gMercedesLastZ[playerid] = zAngle;
        }
    }
    else
    {
        gMercedesLastSpeed[playerid] = 0.0;
        gMercedesLastZ[playerid]     = 0.0;
    }
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    #pragma unused reason
    gMercedesLastSpeed[playerid] = 0.0;
    gMercedesLastZ[playerid]     = 0.0;
    return 1;
}


// -----------------------------------------------------------------------------
// commands
// -----------------------------------------------------------------------------

CMD:mercedes(playerid, params[])
{
    #pragma unused params

    new Float:px, Float:py, Float:pz;
    GetPlayerPos(playerid, px, py, pz);

    new bestVeh   = INVALID_VEHICLE_ID;
    new Float:best = 99999.0;

    // Check static Mercedess.
    for (new i = 0; i < sizeof(gMercedesStaticIds); i++)
    {
        new vid = gMercedesStaticIds[i];
        if (vid == INVALID_VEHICLE_ID || vid == -1) continue;
        new Float:vx, Float:vy, Float:vz;
        GetVehiclePos(vid, vx, vy, vz);
        new Float:d = floatsqroot(
            (vx-px)*(vx-px) + (vy-py)*(vy-py) + (vz-pz)*(vz-pz)
        );
        if (d < best) { best = d; bestVeh = vid; }
    }
    // Check dynamic Mercedess.
    for (new i = 0; i < MERCEDES_MAX_DYN; i++)
    {
        new vid = gMercedesDynIds[i];
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
            "{FF6464}* No Mercedes is currently spawned.");
        return 1;
    }

    PutPlayerInVehicle(playerid, bestVeh, 0);
    SendClientMessage(playerid, 0x66FF66FF,
        "{66FF66}* Teleported you into the nearest Mercedes-Benz E63 AMG Mercedes.");

    new buf[96], name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    format(buf, sizeof(buf), "%s used /mercedes (vehicleid=%d)", name, bestVeh);
    LogMercedes(buf);
    return 1;
}

CMD:spawnmercedes(playerid, params[])
{
    new col1 = -1, col2 = -1;
    if (params[0] != EOS) sscanf_two_ints(params, col1, col2);

    new Float:px, Float:py, Float:pz, Float:pa;
    GetPlayerPos(playerid, px, py, pz);
    GetPlayerFacingAngle(playerid, pa);

    new Float:fx = px + floatcos(pa+90.0, degrees) * 5.0;
    new Float:fy = py + floatsin(pa+90.0, degrees) * 5.0;

    new vid = CreateVehicle(MERCEDES_MODEL, fx, fy, pz, pa, col1, col2, -1);
    if (vid == INVALID_VEHICLE_ID)
    {
        SendClientMessage(playerid, 0xFF6464FF,
            "{FF6464}* CreateVehicle failed - server rejected the model.");
        return 1;
    }

    // Auto-ready + register for engine keep-alive.
    MercedesForceReady(vid);
    RegisterDynMercedes(vid);

    new buf[96], name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    format(buf, sizeof(buf),
        "* Spawned an Mercedes (id=%d, colours=%d/%d).", vid, col1, col2);
    SendClientMessage(playerid, 0x66FF66FF, buf);

    format(buf, sizeof(buf),
        "%s spawned Mercedes vid=%d at (%.1f,%.1f,%.1f)",
        name, vid, fx, fy, pz);
    LogMercedes(buf);
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
