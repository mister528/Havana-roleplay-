// =============================================================================
//  car_gentra2 — Daewoo Gentra 511 Tuning Uzbekistan
//                (replaces SULTAN, model id 560)
// -----------------------------------------------------------------------------
//  Filterscript for HavanaRp / SA-MP 0.3.7 R2.
//
//  Sits alongside car_azelow (Gentra at the STALLION slot, model 439). This
//  one is the *tuning* variant at the SULTAN slot, with a lighter, more
//  responsive feel.
//
//  * Spawns three Gentra-Tuning vehicles at the Wang Cars showroom (LV).
//  * /gentra2                  — teleports the caller into the nearest one.
//  * /spawngentra2 [c1] [c2]   — anyone can spawn one in front of them.
//  * Engine auto-starts on entry, 210 km/h cap enforced server-side.
//  * Doors always unlocked, full fuel.
//  * Logs to scriptfiles/car_gentra2.log.
//
//  Physics target ("light & planted, 0-150 in 5s"):
//   * 210 km/h hard cap with cubic soft-cap (smooth taper at the top).
//   * Strong launch: thrust 0.100 → ~+18 km/h per tick at low speed,
//     0–150 km/h in ~5 s (matches user spec).
//   * Lateral grip 0.70 — high. *No skid*, even in tight S-bends.
//   * Smooth yaw fade in a tight 13→26 °/s window — turn-in stays planted
//     and silky; no thrust step-cut mid-corner.
//   * Brake assist 1.04 on off-gas — light, decisive stops.
//   * 2 Hz tick (500 ms) — matches the rest of the fleet.
//   * Boosts ANY model-560 vehicle (admin-spawned, gamemode-spawned, etc.).
// =============================================================================

#include <a_samp>
#include <zcmd>

#define GENTRA2_MODEL         560
#define GENTRA2_LOGFILE       "car_gentra2.log"

// --- speed tuning ---
#define GENTRA2_MAX_SPEED     210.0  // km/h hard cap
#define GENTRA2_MIN_BOOST       5.0  // km/h — thrust kicks in immediately
#define GENTRA2_THRUST        0.100  // SA-MP velocity units / tick
                                     // (0.100 * 180 = +18 km/h per tick @2Hz
                                     //  → 0–150 km/h in ~5s with the soft cap)
#define GENTRA2_DECEL_THRESH    5.0  // km/h drop/tick = off-gas
#define GENTRA2_ACCEL_LIMIT    28.0  // km/h rise/tick above which we assume
                                     // gravity (downhill), not engine.
#define GENTRA2_TURN_SOFT      13.0  // deg/sec — full thrust at or below
#define GENTRA2_TURN_HARD      26.0  // deg/sec — no thrust at or above.
                                     // Tight 13→26 band → silky turn-in.
#define GENTRA2_SLOPE_LIMIT    0.08  // |vz| above which we skip thrust
#define GENTRA2_LATERAL_GRIP   0.70  // 0..1 — fraction of lateral velocity
                                     // killed each tick. High = *no skid*.
#define GENTRA2_BRAKE_BOOST    1.04  // off-gas brake assist multiplier
#define GENTRA2_TICK_MS         500  // 2 Hz — matches the rest of the fleet

#define VEL_TO_KMH         180.0

#define GENTRA2_MAX_DYN        64

// Three pre-placed spawn points at the Wang Cars showroom (Las Venturas),
// one row past the Camry block.
new const Float:gGentra2Spawns[][4] = {
    {  2127.0000,   1470.0000, 10.5200,  90.0000 },
    {  2127.0000,   1477.0000, 10.5200,  90.0000 },
    {  2127.0000,   1484.0000, 10.5200,  90.0000 }
};

new gGentra2StaticIds[sizeof(gGentra2Spawns)] = { -1, ... };
new gGentra2DynIds[GENTRA2_MAX_DYN]            = { -1, ... };

new gEngineTimer = -1;

new Float:gGentra2LastSpeed[MAX_PLAYERS];
new Float:gGentra2LastZ[MAX_PLAYERS];


// -----------------------------------------------------------------------------
// helpers
// -----------------------------------------------------------------------------

LogGentra2(const text[])
{
    new File:fp = fopen(GENTRA2_LOGFILE, io_append);
    if (fp == File:0) return;
    new buf[256];
    new hh, mm, ss;
    gettime(hh, mm, ss);
    format(buf, sizeof(buf), "[%02d:%02d:%02d] %s\r\n", hh, mm, ss, text);
    fwrite(fp, buf);
    fclose(fp);
}

// Return true if `vid` is a Gentra2/SULTAN (model 560) regardless of spawner.
stock IsGentra2(vid)
{
    if (vid == INVALID_VEHICLE_ID || vid == 0) return 0;
    return GetVehicleModel(vid) == GENTRA2_MODEL;
}

stock RegisterDynGentra2(vid)
{
    for (new i = 0; i < GENTRA2_MAX_DYN; i++)
    {
        if (gGentra2DynIds[i] == -1)
        {
            gGentra2DynIds[i] = vid;
            return 1;
        }
    }
    return 0;
}

stock Gentra2ForceReady(vid)
{
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vid, VEHICLE_PARAMS_ON, lights, alarm, false, bonnet, boot, objective);
}


// -----------------------------------------------------------------------------
// Timer: keep engine alive + apply tuned thrust for all occupied Gentras.
// -----------------------------------------------------------------------------

forward Gentra2EngineTick();
public  Gentra2EngineTick()
{
    new Float:maxVel      = GENTRA2_MAX_SPEED      / VEL_TO_KMH;
    new Float:minBoost    = GENTRA2_MIN_BOOST      / VEL_TO_KMH;
    new Float:decelThresh = -GENTRA2_DECEL_THRESH  / VEL_TO_KMH;
    new Float:accelLimit  =  GENTRA2_ACCEL_LIMIT   / VEL_TO_KMH;

    for (new p = 0; p < MAX_PLAYERS; p++)
    {
        if (!IsPlayerConnected(p)) continue;
        if (GetPlayerState(p) != PLAYER_STATE_DRIVER) continue;

        new vid = GetPlayerVehicleID(p);
        if (vid == 0 || !IsGentra2(vid)) continue;

        Gentra2ForceReady(vid);

        new Float:vx, Float:vy, Float:vz;
        GetVehicleVelocity(vid, vx, vy, vz);

        new Float:hSpeed = floatsqroot(vx*vx + vy*vy);

        new Float:lastSpeed   = gGentra2LastSpeed[p];
        new Float:delta       = hSpeed - lastSpeed;
        gGentra2LastSpeed[p]  = hSpeed;
        new bool:onGas = (delta > decelThresh && delta < accelLimit);

        new Float:zAngle;
        GetVehicleZAngle(vid, zAngle);
        new Float:lastZ = gGentra2LastZ[p];
        new Float:angleDiff = zAngle - lastZ;
        if (angleDiff >  180.0) angleDiff -= 360.0;
        if (angleDiff < -180.0) angleDiff += 360.0;
        gGentra2LastZ[p] = zAngle;
        new Float:turnRate = floatabs(angleDiff) * 1000.0 / float(GENTRA2_TICK_MS);

        new Float:fx = -floatsin(zAngle, degrees);
        new Float:fy =  floatcos(zAngle, degrees);
        new Float:fwdSpeed = vx*fx + vy*fy;

        new Float:lx = -fy;
        new Float:ly =  fx;
        new Float:fwdMag = vx*fx + vy*fy;
        new Float:latMag = vx*lx + vy*ly;
        latMag *= (1.0 - GENTRA2_LATERAL_GRIP);
        new Float:nvx = fx*fwdMag + lx*latMag;
        new Float:nvy = fy*fwdMag + ly*latMag;
        new Float:nvz = vz;

        new Float:yawFade = 1.0;
        if (turnRate >= GENTRA2_TURN_HARD)
            yawFade = 0.0;
        else if (turnRate > GENTRA2_TURN_SOFT)
            yawFade = (GENTRA2_TURN_HARD - turnRate)
                    / (GENTRA2_TURN_HARD - GENTRA2_TURN_SOFT);

        new Float:r = hSpeed / maxVel;
        if (r > 1.0) r = 1.0;
        new Float:capFade = 1.0 - r*r*r;
        if (capFade < 0.0) capFade = 0.0;

        new bool:doThrust =
            onGas
            && fwdSpeed > minBoost
            && hSpeed > 0.001
            && floatabs(vz) < GENTRA2_SLOPE_LIMIT
            && capFade > 0.0
            && yawFade > 0.0;

        if (doThrust)
        {
            new Float:thrust = GENTRA2_THRUST * yawFade * capFade;
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

        if (!onGas && fwdMag > minBoost)
        {
            new Float:k = 1.0 / GENTRA2_BRAKE_BOOST;
            nvx *= k; nvy *= k;
        }

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
    print("[car_gentra2] ----------------------------------------");
    print("[car_gentra2]  Daewoo Gentra 511 Tuning UZB filterscript loaded");
    print("[car_gentra2]  Model ID: 560 (SULTAN) | Open to all");
    print("[car_gentra2]  Speed cap: 210 km/h | 0-150 in ~5s | No skid");
    print("[car_gentra2] ----------------------------------------");

    new spawned = 0;
    for (new i = 0; i < sizeof(gGentra2Spawns); i++)
    {
        gGentra2StaticIds[i] = CreateVehicle(
            GENTRA2_MODEL,
            gGentra2Spawns[i][0],
            gGentra2Spawns[i][1],
            gGentra2Spawns[i][2],
            gGentra2Spawns[i][3],
            -1, -1,
            -1
        );
        if (gGentra2StaticIds[i] != INVALID_VEHICLE_ID)
        {
            Gentra2ForceReady(gGentra2StaticIds[i]);
            spawned++;
        }
    }

    gEngineTimer = SetTimer("Gentra2EngineTick", GENTRA2_TICK_MS, true);

    new buf[96];
    format(buf, sizeof(buf), "OnFilterScriptInit: spawned %d/%d Gentras, timer=%d",
        spawned, sizeof(gGentra2Spawns), gEngineTimer);
    LogGentra2(buf);
    return 1;
}

public OnFilterScriptExit()
{
    if (gEngineTimer != -1)
    {
        KillTimer(gEngineTimer);
        gEngineTimer = -1;
    }
    for (new i = 0; i < sizeof(gGentra2StaticIds); i++)
    {
        if (gGentra2StaticIds[i] != INVALID_VEHICLE_ID && gGentra2StaticIds[i] != -1)
        {
            DestroyVehicle(gGentra2StaticIds[i]);
            gGentra2StaticIds[i] = -1;
        }
    }
    for (new i = 0; i < GENTRA2_MAX_DYN; i++)
    {
        if (gGentra2DynIds[i] != -1)
        {
            DestroyVehicle(gGentra2DynIds[i]);
            gGentra2DynIds[i] = -1;
        }
    }
    LogGentra2("OnFilterScriptExit: cleaned up");
    return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    #pragma unused oldstate
    if (newstate == PLAYER_STATE_DRIVER)
    {
        new vid = GetPlayerVehicleID(playerid);
        if (vid != 0 && IsGentra2(vid))
        {
            Gentra2ForceReady(vid);
            new Float:vx, Float:vy, Float:vz;
            GetVehicleVelocity(vid, vx, vy, vz);
            #pragma unused vz
            gGentra2LastSpeed[playerid] = floatsqroot(vx*vx + vy*vy);
            new Float:zAngle;
            GetVehicleZAngle(vid, zAngle);
            gGentra2LastZ[playerid] = zAngle;
        }
    }
    else
    {
        gGentra2LastSpeed[playerid] = 0.0;
        gGentra2LastZ[playerid]     = 0.0;
    }
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    #pragma unused reason
    gGentra2LastSpeed[playerid] = 0.0;
    gGentra2LastZ[playerid]     = 0.0;
    return 1;
}


// -----------------------------------------------------------------------------
// commands
// -----------------------------------------------------------------------------

CMD:gentra2(playerid, params[])
{
    #pragma unused params
    new Float:px, Float:py, Float:pz;
    GetPlayerPos(playerid, px, py, pz);

    new bestVeh   = INVALID_VEHICLE_ID;
    new Float:best = 99999.0;

    for (new i = 0; i < sizeof(gGentra2StaticIds); i++)
    {
        new vid = gGentra2StaticIds[i];
        if (vid == INVALID_VEHICLE_ID || vid == -1) continue;
        new Float:vx, Float:vy, Float:vz;
        GetVehiclePos(vid, vx, vy, vz);
        new Float:d = floatsqroot((vx-px)*(vx-px) + (vy-py)*(vy-py) + (vz-pz)*(vz-pz));
        if (d < best) { best = d; bestVeh = vid; }
    }
    for (new i = 0; i < GENTRA2_MAX_DYN; i++)
    {
        new vid = gGentra2DynIds[i];
        if (vid == -1) continue;
        new Float:vx, Float:vy, Float:vz;
        GetVehiclePos(vid, vx, vy, vz);
        new Float:d = floatsqroot((vx-px)*(vx-px) + (vy-py)*(vy-py) + (vz-pz)*(vz-pz));
        if (d < best) { best = d; bestVeh = vid; }
    }

    if (bestVeh == INVALID_VEHICLE_ID)
    {
        SendClientMessage(playerid, 0xFF6464FF,
            "{FF6464}* No Gentra Tuning is currently spawned.");
        return 1;
    }

    PutPlayerInVehicle(playerid, bestVeh, 0);
    SendClientMessage(playerid, 0x66FF66FF,
        "{66FF66}* Teleported you into the nearest Gentra 511 Tuning.");

    new buf[96], name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    format(buf, sizeof(buf), "%s used /gentra2 (vehicleid=%d)", name, bestVeh);
    LogGentra2(buf);
    return 1;
}

CMD:spawngentra2(playerid, params[])
{
    new col1 = -1, col2 = -1;
    if (params[0] != EOS) sscanf_two_ints(params, col1, col2);

    new Float:px, Float:py, Float:pz, Float:pa;
    GetPlayerPos(playerid, px, py, pz);
    GetPlayerFacingAngle(playerid, pa);

    new Float:fx = px + floatcos(pa+90.0, degrees) * 5.0;
    new Float:fy = py + floatsin(pa+90.0, degrees) * 5.0;

    new vid = CreateVehicle(GENTRA2_MODEL, fx, fy, pz, pa, col1, col2, -1);
    if (vid == INVALID_VEHICLE_ID)
    {
        SendClientMessage(playerid, 0xFF6464FF,
            "{FF6464}* CreateVehicle failed - server rejected the model.");
        return 1;
    }
    Gentra2ForceReady(vid);
    RegisterDynGentra2(vid);

    new buf[96], name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    format(buf, sizeof(buf),
        "* Spawned a Gentra Tuning (id=%d, colours=%d/%d).", vid, col1, col2);
    SendClientMessage(playerid, 0x66FF66FF, buf);

    format(buf, sizeof(buf),
        "%s spawned Gentra2 vid=%d at (%.1f,%.1f,%.1f)",
        name, vid, fx, fy, pz);
    LogGentra2(buf);
    return 1;
}


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
