/*
================================================================================
    HavanaRp — Fisherman Job (gamemode module)
    -----------------------------------------------------------------------------
    Standalone fishing-job module intended to be `#include`d from the main
    gamemode (arabonline.pwn).  All server callbacks are exposed as regular
    functions prefixed with `Fisherman_` and must be invoked from the matching
    gamemode public callbacks.
================================================================================
*/
#if defined _fisherman_included
    #endinput
#endif
#define _fisherman_included

// --------------------------------------------------------------------------
//  CONFIG
// --------------------------------------------------------------------------

#define FISH_NPC_X              581.246704
#define FISH_NPC_Y              -2091.282470
#define FISH_NPC_Z              6.391632
#define FISH_NPC_A              56.06
#define FISH_NPC_SKIN           136

#define BOAT_NPC_X              505.574829
#define BOAT_NPC_Y              -2087.931640
#define BOAT_NPC_Z              7.540138
#define BOAT_NPC_A              246.15
#define BOAT_NPC_SKIN           171

#define BOAT_SPAWN_X            492.241943
#define BOAT_SPAWN_Y            -2090.020507
#define BOAT_SPAWN_Z            -0.383024
#define BOAT_SPAWN_A            103.52
#define BOAT_MODEL              473

#define FISH_ZONE_CX            626.229736
#define FISH_ZONE_CY            -2566.131591
#define FISH_ZONE_HALF          250.0
#define FISH_ZONE_COLOR         0xFF000099
#define FISH_ZONE_COLOR_FLASH   0xFF0000CC

#define WORKER_SKIN             171

#define PRICE_BAIT              10
#define PRICE_ROD               500
#define PRICE_BOAT              250
#define PRICE_LIC_30            10000
#define PRICE_LIC_60            18000
#define PRICE_LIC_90            25000

#define MAX_BAG_FISH            40
// No cap on per-purchase bait quantity anymore (was 20). Kept for
// backward compatibility but unused.
#define MAX_BAIT_PURCHASE       999999

// Coordinates of the decorative "pickup" markers that appear directly
// in front of each NPC (taken from the player position feedback the
// user sent -- these are the tiles the player was standing on when
// interacting with each NPC).
#define FISH_PICKUP_X           580.599426
#define FISH_PICKUP_Y           -2090.743896
#define FISH_PICKUP_Z           6.391632

#define BOAT_PICKUP_X           506.863952
#define BOAT_PICKUP_Y           -2087.901367
#define BOAT_PICKUP_Z           7.540138

// Audio IDs (SA-MP sound IDs used for various fisherman events).
#define SND_CAST                1139    // rope swing / whoosh
#define SND_CATCH               1054    // collect coin -> "got a fish"
#define SND_MISS                1055    // deny / nothing bit
#define SND_BUY                 1052    // cash register
#define SND_BOAT                1133    // boat horn
#define SND_END                 1184    // bling / finish

#define ROD_OBJECT_MODEL        18632
#define ROD_SLOT                3

#define DLG_FISH_SHOP           31401
#define DLG_FISH_LIC            31402
#define DLG_FISH_BAIT           31403
#define DLG_FISH_ROD            31404
#define DLG_FISH_BOAT_RENT      31406
#define DLG_FISH_CAST           31407
#define DLG_FISH_RESULT         31408
#define DLG_FISH_STATS          31409
#define DLG_FISH_MSG            31411
#define DLG_FISH_HUD            31412

#define CAST_MIN_MS             1500
#define CAST_MAX_MS             6000

// Radius (m) around the rented boat within which the CAST HUD works.
#define FISH_BOAT_NEAR_R        10.0

// --------------------------------------------------------------------------
//  FISH SPECIES TABLE
// --------------------------------------------------------------------------

enum e_fish_species_t
{
    fs_name[32],
    fs_min_dg,
    fs_max_dg,
    fs_chance,
    fs_price_kg,
    fs_is_rare
}

// Weights are stored in decigrams (10 dg = 1 kg).
// Regular catches are clamped to 100-3000$ via CAP_COMMON_PRICE;
// rare catches (is_rare OR weight >= 1.0kg) pay PRICE_RARE once.
static const g_fish_species[][e_fish_species_t] = {
    // name               min  max chance $/kg  rare
    { "Sardine",           2,   6,    28,    350,  0 },
    { "Mackerel",          3,   8,    22,    500,  0 },
    { "Sea Bass",          3,   8,    16,    750,  0 },
    { "Red Snapper",       3,   7,    12,   1100,  0 },
    { "Tuna",              4,   9,    10,   1300,  0 },
    { "Salmon",            4,   9,     7,   1700,  0 },
    { "Grouper",           4,   8,     4,   2400,  0 },
    { "Swordfish",         5,  10,     3,   3000,  0 },
    { "Marlin",            8,  14,     1,   3500,  1 },
    { "Golden Tuna",      10,  16,     1,   4000,  1 }
};

#define PRICE_RARE          25000
#define CAP_COMMON_PRICE    3000
#define CAP_COMMON_MIN      100
#define CATCH_SUCCESS_PCT   45

enum e_fish_player_t
{
    bool:fp_has_license,
    fp_license_expire,
    fp_bait,
    bool:fp_has_rod,
    bool:fp_is_working,
    bool:fp_has_boat,
    fp_boat_vehicle,
    fp_orig_skin,
    bool:fp_casting,
    fp_bag_count,
    fp_bag_species [MAX_BAG_FISH],
    Float:fp_bag_weight[MAX_BAG_FISH],
    fp_bag_price  [MAX_BAG_FISH],
    fp_total_money,
    bool:fp_in_zone
}

static g_fp[MAX_PLAYERS][e_fish_player_t];
static bool:g_fp_loaded[MAX_PLAYERS] = { false, ... };
static g_FishCP         = -1;
static g_BoatCP         = -1;
static g_FishNPC        = -1;
static g_BoatNPC        = -1;
static g_FishZoneGZ     = -1;
static g_FishDecorObj   = -1; // rotating job-start marker above NPC
static g_BoatDecorObj   = -1; // rotating boat-rent marker above NPC
static bool:g_ZoneFlash = false;

forward Fisherman_ZoneFlash_Tick();
forward Fisherman_SetSkin(playerid, skin);
forward Fisherman_CastResolve(playerid);
forward Fisherman_CheckZone(playerid);
forward Fisherman_StartPost(playerid);
forward Fisherman_OnLoadCache(playerid);
forward Fisherman_LoadDB(playerid);
forward Fisherman_CamRestore(playerid);
forward Fisherman_CamRestoreEnd(playerid);

// --------------------------------------------------------------------------
//  HELPERS
// --------------------------------------------------------------------------

// Persistent money helper: mirrors the gamemode's give_money() behaviour.
// The main gamemode tracks every player's cash in p_info[playerid][money]
// and periodically flushes that value to the `u_money` SQL column.
// GivePlayerMoney() alone would only update the client-side HUD, so any
// fishing earnings would get wiped on reconnect.  This helper keeps both
// in sync and writes the new balance to the DB immediately.
static stock Fisherman_AddMoney(playerid, delta)
{
    p_info[playerid][money] += delta;
    GivePlayerMoney(playerid, delta);
    update_int_sql(playerid, "u_money", p_info[playerid][money]);
}

static stock Fisherman_FmtMoney(value, dest[], len)
{
    new tmp[32], i, j = 0, n = value, neg = 0;
    if (n < 0) { neg = 1; n = -n; }
    if (n == 0) { dest[0] = '$'; dest[1] = '0'; dest[2] = 0; return 1; }
    while (n > 0 && j < 30) { tmp[j++] = (n % 10) + '0'; n /= 10; }
    new out[32], k = 0;
    if (neg) out[k++] = '-';
    out[k++] = '$';
    for (i = j - 1; i >= 0; --i)
    {
        out[k++] = tmp[i];
        if (i > 0 && (i % 3) == 0) out[k++] = ',';
    }
    out[k] = 0;
    strmid(dest, out, 0, k, len);
    return 1;
}

static stock Fisherman_InZone(Float:x, Float:y)
{
    if (floatabs(x - FISH_ZONE_CX) > FISH_ZONE_HALF) return 0;
    if (floatabs(y - FISH_ZONE_CY) > FISH_ZONE_HALF) return 0;
    return 1;
}

static stock Fisherman_RandWeighted()
{
    new total = 0, i;
    for (i = 0; i < sizeof(g_fish_species); ++i)
        total += g_fish_species[i][fs_chance];
    new r = random(total) + 1;
    for (i = 0; i < sizeof(g_fish_species); ++i)
    {
        r -= g_fish_species[i][fs_chance];
        if (r <= 0) return i;
    }
    return 0;
}

static stock Fisherman_Reset(playerid)
{
    g_fp[playerid][fp_has_license]   = false;
    g_fp[playerid][fp_license_expire]= 0;
    g_fp[playerid][fp_bait]          = 0;
    g_fp[playerid][fp_has_rod]       = false;
    g_fp[playerid][fp_is_working]    = false;
    g_fp[playerid][fp_has_boat]      = false;
    g_fp[playerid][fp_boat_vehicle]  = 0;
    g_fp[playerid][fp_orig_skin]     = 0;
    g_fp[playerid][fp_casting]       = false;
    g_fp[playerid][fp_bag_count]     = 0;
    g_fp[playerid][fp_total_money]   = 0;
    g_fp[playerid][fp_in_zone]       = false;
    g_fp_loaded[playerid]            = false;
}

// --------------------------------------------------------------------------
//  DB PERSISTENCE  ( table: users, key: u_id )
//    u_fish_lic       TINYINT(1) -- legacy 0/1 flag
//    u_fish_lic_days  INT        -- days remaining on license
//    u_fish_bait      INT        -- number of bait in inventory
//    u_fish_rod       TINYINT(1) -- 1 if a rod is owned
// --------------------------------------------------------------------------

static stock Fisherman_SaveDB(playerid)
{
    if (!IsPlayerConnected(playerid))    return 0;
    if (!g_fp_loaded[playerid])          return 0;
    if (p_info[playerid][id] <= 0)       return 0;
    new days = 0;
    if (g_fp[playerid][fp_has_license])
    {
        new rem = g_fp[playerid][fp_license_expire] - gettime();
        if (rem > 0) days = rem / 86400 + 1;
    }
    new q[256];
    format(q, sizeof(q),
        "UPDATE `users` SET `u_fish_lic`='%d',`u_fish_lic_days`='%d',\
`u_fish_bait`='%d',`u_fish_rod`='%d' WHERE `u_id`='%d' LIMIT 1",
        g_fp[playerid][fp_has_license] ? 1 : 0,
        days,
        g_fp[playerid][fp_bait],
        g_fp[playerid][fp_has_rod] ? 1 : 0,
        p_info[playerid][id]);
    mysql_tquery(sql_connection, q, "", "");
    return 1;
}

public Fisherman_OnLoadCache(playerid)
{
    if (!IsPlayerConnected(playerid)) return 1;
    if (cache_get_row_count(sql_connection) < 1)
    {
        g_fp_loaded[playerid] = true;
        return 1;
    }
    new lic  = cache_get_field_content_int(0, "u_fish_lic",      sql_connection);
    new days = cache_get_field_content_int(0, "u_fish_lic_days", sql_connection);
    new bait = cache_get_field_content_int(0, "u_fish_bait",     sql_connection);
    new rod  = cache_get_field_content_int(0, "u_fish_rod",      sql_connection);
    if (days > 0)
    {
        g_fp[playerid][fp_has_license]    = true;
        g_fp[playerid][fp_license_expire] = gettime() + days * 86400;
    }
    else if (lic > 0)
    {
        // legacy license flag without stored days -- grant 30 days as a
        // grace period so existing players don't lose access.
        g_fp[playerid][fp_has_license]    = true;
        g_fp[playerid][fp_license_expire] = gettime() + 30 * 86400;
    }
    g_fp[playerid][fp_bait]    = bait;
    g_fp[playerid][fp_has_rod] = (rod > 0);
    g_fp_loaded[playerid]      = true;
    // If the player already owns a rod from a previous session, equip
    // it on their hand right away so it persists across logins.
    if (g_fp[playerid][fp_has_rod])
        Fisherman_AttachRod(playerid);
    return 1;
}

public Fisherman_LoadDB(playerid)
{
    if (!IsPlayerConnected(playerid))  return 1;
    if (p_info[playerid][id] <= 0)     return 1;
    if (g_fp_loaded[playerid])         return 1;
    new q[160];
    format(q, sizeof(q),
        "SELECT `u_fish_lic`,`u_fish_lic_days`,`u_fish_bait`,`u_fish_rod` \
FROM `users` WHERE `u_id`='%d' LIMIT 1", p_info[playerid][id]);
    mysql_tquery(sql_connection, q, "Fisherman_OnLoadCache", "i", playerid);
    return 1;
}

static stock Fisherman_RemoveRod(playerid)
{
    if (IsPlayerAttachedObjectSlotUsed(playerid, ROD_SLOT))
        RemovePlayerAttachedObject(playerid, ROD_SLOT);
}

static stock Fisherman_AttachRod(playerid)
{
    Fisherman_RemoveRod(playerid);
    SetPlayerAttachedObject(playerid, ROD_SLOT, ROD_OBJECT_MODEL, 6,
        0.093, 0.026, -0.015, 80.0, 55.0, 4.0, 1.0, 1.0, 1.0);
}

static stock Fisherman_CleanupBoat(playerid)
{
    if (g_fp[playerid][fp_has_boat] && g_fp[playerid][fp_boat_vehicle] > 0)
    {
        if (IsPlayerInVehicle(playerid, g_fp[playerid][fp_boat_vehicle]))
            RemovePlayerFromVehicle(playerid);
        DestroyVehicle(g_fp[playerid][fp_boat_vehicle]);
    }
    g_fp[playerid][fp_has_boat]     = false;
    g_fp[playerid][fp_boat_vehicle] = 0;
}

// Forward-declared (used before their definitions below)
forward Fisherman_ShowShop_(playerid);
forward Fisherman_ShowLic_(playerid);
forward Fisherman_ShowBait_(playerid);
forward Fisherman_ShowRod_(playerid);
forward Fisherman_ShowBoat_(playerid);
forward Fisherman_ShowCast_(playerid);
forward Fisherman_ShowHud_(playerid);
forward Fisherman_ShowMsg_(playerid, msg[]);
forward Fisherman_ShowStats_(playerid);

static stock Fisherman_Finish(playerid, bool:payout)
{
    // Make absolutely sure the camera is back in normal 3rd-person mode
    // before we tear the fishing job down, otherwise a player who ends the
    // job mid-cast could be left with a stuck underwater camera.
    SetCameraBehindPlayer(playerid);

    if (g_fp[playerid][fp_orig_skin] > 0)
        SetPlayerSkin(playerid, g_fp[playerid][fp_orig_skin]);

    Fisherman_RemoveRod(playerid);
    Fisherman_CleanupBoat(playerid);
    if (g_FishZoneGZ >= 0)
        GangZoneHideForPlayer(playerid, g_FishZoneGZ);

    new total_money = g_fp[playerid][fp_total_money];
    new total_fish  = g_fp[playerid][fp_bag_count];

    if (payout && total_fish > 0)
    {
        // 1) Credit the player's cash balance AND persist it to SQL via
        //    the gamemode's p_info[money] path (plain GivePlayerMoney
        //    would get overwritten on the next u_money flush).
        Fisherman_AddMoney(playerid, total_money);

        // 2) Big on-screen GameText for 5 seconds summarising the haul.
        new gt[144];
        format(gt, sizeof(gt),
            "~y~FISHING DAY ENDED~n~~w~~h~%d FISH~n~~g~+$%d",
            total_fish, total_money);
        GameTextForPlayer(playerid, gt, 5000, 3);

        // 3) Chat message (stays in log for reference).
        new cm[160];
        format(cm, sizeof(cm),
            "[Fishing] You ended the day with %d fish and earned $%d. Nice haul!",
            total_fish, total_money);
        SendClientMessage(playerid, 0x33E48CFF, cm);

        // 4) Finish sound.
        PlayerPlaySound(playerid, SND_END, 0.0, 0.0, 0.0);

        // 5) Detailed stats dialog (per-fish breakdown).
        Fisherman_ShowStats_(playerid);
    }
    else
    {
        SendClientMessage(playerid, 0x9AA0A6FF,
            "[Fishing] Job ended. No fish caught this session.");
    }

    // NOTE: keep fp_has_rod intact across sessions. The user owns the
    // physical rod once they bought it; ending a fishing session only
    // detaches it from the hand (Fisherman_RemoveRod above), it does
    // NOT take the rod away from the player. The next time they start
    // fishing the rod is re-attached automatically.
    g_fp[playerid][fp_is_working] = false;
    g_fp[playerid][fp_casting]    = false;
    g_fp[playerid][fp_bag_count]  = 0;
    g_fp[playerid][fp_total_money]= 0;
    Fisherman_SaveDB(playerid);
}

// --------------------------------------------------------------------------
//  DIALOGS
// --------------------------------------------------------------------------

public Fisherman_ShowShop_(playerid)
{
    new days_left = 0;
    if (g_fp[playerid][fp_has_license])
    {
        new rem = g_fp[playerid][fp_license_expire] - gettime();
        if (rem > 0) days_left = rem / 86400 + 1;
        else { g_fp[playerid][fp_has_license] = false; days_left = 0; }
    }
    new body[512];
    format(body, sizeof(body),
        "%d|%d|%d|%d|%d|%d",
        g_fp[playerid][fp_has_license] ? 1 : 0,
        days_left,
        g_fp[playerid][fp_bait],
        g_fp[playerid][fp_has_rod] ? 1 : 0,
        g_fp[playerid][fp_is_working] ? 1 : 0,
        GetPlayerMoney(playerid));
    ShowPlayerDialog(playerid, DLG_FISH_SHOP, DIALOG_STYLE_LIST,
        "HAVANA_FISH_SHOP", body, "Select", "Exit");
    return 1;
}

public Fisherman_ShowLic_(playerid)
{
    new body[256];
    format(body, sizeof(body),
        "30|%d\n60|%d\n90|%d",
        PRICE_LIC_30, PRICE_LIC_60, PRICE_LIC_90);
    ShowPlayerDialog(playerid, DLG_FISH_LIC, DIALOG_STYLE_LIST,
        "HAVANA_FISH_LIC", body, "Buy", "Back");
    return 1;
}

public Fisherman_ShowBait_(playerid)
{
    // First param = unit price, second = 0 (0 means "no upper limit")
    // which the overlay interprets as unlimited bait purchase.
    ShowPlayerDialog(playerid, DLG_FISH_BAIT, DIALOG_STYLE_INPUT,
        "HAVANA_FISH_BAIT",
        "10|0",
        "Buy", "Back");
    return 1;
}

public Fisherman_ShowRod_(playerid)
{
    new body[128];
    format(body, sizeof(body), "%d", PRICE_ROD);
    ShowPlayerDialog(playerid, DLG_FISH_ROD, DIALOG_STYLE_MSGBOX,
        "HAVANA_FISH_ROD", body, "Buy", "Back");
    return 1;
}

public Fisherman_ShowBoat_(playerid)
{
    new body[128];
    format(body, sizeof(body), "%d", PRICE_BOAT);
    ShowPlayerDialog(playerid, DLG_FISH_BOAT_RENT, DIALOG_STYLE_MSGBOX,
        "HAVANA_FISH_BOAT", body, "Rent", "Back");
    return 1;
}

// Returns 1 if the player is close enough to their rented boat to use
// the fishing HUD (i.e. they are either seated on the boat, or within
// FISH_BOAT_NEAR_R metres of it).
static stock Fisherman_NearBoat(playerid)
{
    if (!g_fp[playerid][fp_has_boat])            return 0;
    if (g_fp[playerid][fp_boat_vehicle] <= 0)    return 0;
    if (IsPlayerInVehicle(playerid,
            g_fp[playerid][fp_boat_vehicle])) return 1;
    new Float:vx, Float:vy, Float:vz;
    GetVehiclePos(g_fp[playerid][fp_boat_vehicle], vx, vy, vz);
    if (IsPlayerInRangeOfPoint(playerid, FISH_BOAT_NEAR_R, vx, vy, vz))
        return 1;
    return 0;
}

public Fisherman_ShowCast_(playerid)
{
    new body[256];
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    new in_zone = Fisherman_InZone(x, y);
    new on_boat = Fisherman_NearBoat(playerid);
    format(body, sizeof(body),
        "%d|%d|%d|%d|%d|%d",
        g_fp[playerid][fp_bait],
        g_fp[playerid][fp_bag_count],
        g_fp[playerid][fp_total_money],
        in_zone,
        on_boat,
        g_fp[playerid][fp_casting] ? 1 : 0);
    ShowPlayerDialog(playerid, DLG_FISH_CAST, DIALOG_STYLE_MSGBOX,
        "HAVANA_FISH_CAST", body, "Reel", "End");
    return 1;
}

public Fisherman_ShowHud_(playerid)
{
    new body[128];
    format(body, sizeof(body), "%d|%d|%d",
        g_fp[playerid][fp_bait],
        g_fp[playerid][fp_bag_count],
        g_fp[playerid][fp_total_money]);
    ShowPlayerDialog(playerid, DLG_FISH_HUD, DIALOG_STYLE_MSGBOX,
        "HAVANA_FISH_HUD", body, "Cast", "End");
    return 1;
}

public Fisherman_ShowMsg_(playerid, msg[])
{
    ShowPlayerDialog(playerid, DLG_FISH_MSG, DIALOG_STYLE_MSGBOX,
        "HAVANA_FISH_MSG", msg, "OK", "");
    return 1;
}

public Fisherman_ShowStats_(playerid)
{
    new body[2048], line[128];
    new n = g_fp[playerid][fp_bag_count];
    new total_price = g_fp[playerid][fp_total_money];
    new total_count = n;
    new Float:total_weight = 0.0;

    for (new i = 0; i < n; ++i)
        total_weight += g_fp[playerid][fp_bag_weight][i];

    format(body, sizeof(body), "TOTALS|%d|%d|%.1f\n",
        total_count, total_price, total_weight);

    for (new i = 0; i < n; ++i)
    {
        new idx = g_fp[playerid][fp_bag_species][i];
        new is_rare = (g_fish_species[idx][fs_is_rare] != 0
                      || g_fp[playerid][fp_bag_weight][i] >= 1.0) ? 1 : 0;
        format(line, sizeof(line), "%s|%.1f|%d|%d\n",
            g_fish_species[idx][fs_name],
            g_fp[playerid][fp_bag_weight][i],
            g_fp[playerid][fp_bag_price][i],
            is_rare);
        strcat(body, line, sizeof(body));
    }

    ShowPlayerDialog(playerid, DLG_FISH_STATS, DIALOG_STYLE_MSGBOX,
        "HAVANA_FISH_STATS", body, "OK", "");
    return 1;
}

// --------------------------------------------------------------------------
//  HOOKS
// --------------------------------------------------------------------------

stock Fisherman_OnGameModeInit()
{
    print("[Fisherman] HavanaRp fishing job — loading...");

    g_FishNPC = CreateDynamicActor(FISH_NPC_SKIN,
        FISH_NPC_X, FISH_NPC_Y, FISH_NPC_Z, FISH_NPC_A);
    SetDynamicActorInvulnerable(g_FishNPC, true);

    new Float:rad = FISH_NPC_A * 3.14159265 / 180.0;
    new Float:cpx = FISH_NPC_X + floatsin(-rad, radian) * 1.5;
    new Float:cpy = FISH_NPC_Y + floatcos(-rad, radian) * 1.5;
    g_FishCP = CreateDynamicCP(cpx, cpy, FISH_NPC_Z - 1.0, 2.0, -1, -1, -1, 60.0);

    // "Start work" pickup placed directly in front of the fisherman NPC
    // (clothesp model 1275).  Pickup type 1 = constant hover + rotation.
    g_FishDecorObj = CreateDynamicPickup(1275, 1,
        FISH_PICKUP_X, FISH_PICKUP_Y, FISH_PICKUP_Z,
        -1, -1, -1, 350.0);

    g_BoatNPC = CreateDynamicActor(BOAT_NPC_SKIN,
        BOAT_NPC_X, BOAT_NPC_Y, BOAT_NPC_Z, BOAT_NPC_A);
    SetDynamicActorInvulnerable(g_BoatNPC, true);

    new Float:brad = BOAT_NPC_A * 3.14159265 / 180.0;
    new Float:bcpx = BOAT_NPC_X + floatsin(-brad, radian) * 1.5;
    new Float:bcpy = BOAT_NPC_Y + floatcos(-brad, radian) * 1.5;
    g_BoatCP = CreateDynamicCP(bcpx, bcpy, BOAT_NPC_Z - 1.0, 2.0, -1, -1, -1, 60.0);

    // "Rent boat" pickup placed directly in front of the boat-rental NPC
    // (ArrowType2 model 19131).
    g_BoatDecorObj = CreateDynamicPickup(19131, 1,
        BOAT_PICKUP_X, BOAT_PICKUP_Y, BOAT_PICKUP_Z,
        -1, -1, -1, 350.0);

    g_FishZoneGZ = GangZoneCreate(
        FISH_ZONE_CX - FISH_ZONE_HALF, FISH_ZONE_CY - FISH_ZONE_HALF,
        FISH_ZONE_CX + FISH_ZONE_HALF, FISH_ZONE_CY + FISH_ZONE_HALF);

    SetTimer("Fisherman_ZoneFlash_Tick", 900, true);
    print("[Fisherman] loaded.");
    return 1;
}

// Called from gamemode's OnPlayerSpawn to (a) load the player's saved
// fisherman state from the DB the first time they spawn after login, and
// (b) refresh the local "Boat Yard" map icon for them.  MAPICON_LOCAL
// only renders while the player is close to the marker (~300 m), which
// matches the "~350 m show-when-near" behaviour requested by the user.
stock Fisherman_OnPlayerSpawn(playerid)
{
    // Icon 42 = "Boat Yard" (SA-MP boatyard radar sprite).  LOCAL mode
    // auto-hides the icon when the player is far from the marker, so
    // the map stays clean and only reveals the fishing job when the
    // player approaches the marina.
    SetPlayerMapIcon(playerid, 46,
        BOAT_NPC_X, BOAT_NPC_Y, BOAT_NPC_Z,
        42, 0, MAPICON_LOCAL);
    // Lazy-load fisherman state from DB (only once per session).
    if (!g_fp_loaded[playerid] && p_info[playerid][id] > 0)
        Fisherman_LoadDB(playerid);
    return 1;
}

public Fisherman_ZoneFlash_Tick()
{
    g_ZoneFlash = !g_ZoneFlash;
    new col = g_ZoneFlash ? FISH_ZONE_COLOR : FISH_ZONE_COLOR_FLASH;
    for (new i = 0; i < MAX_PLAYERS; ++i)
    {
        if (!IsPlayerConnected(i)) continue;
        if (g_fp[i][fp_is_working])
        {
            GangZoneStopFlashForPlayer(i, g_FishZoneGZ);
            GangZoneShowForPlayer(i, g_FishZoneGZ, col);
        }
    }
    return 1;
}

stock Fisherman_OnPlayerConnect(playerid)
{
    Fisherman_Reset(playerid);
    // Preload the SWORD animation library so the first ApplyAnimation call
    // during a cast does not freeze the client while it streams in.
    ApplyAnimation(playerid, "SWORD", "sword_block", 4.1, 0, 0, 0, 0, 1, 1);
    ClearAnimations(playerid);
    return 1;
}

stock Fisherman_OnPlayerDisconnect(playerid, reason)
{
    #pragma unused reason
    // Persist the player's fishing state to the DB before cleanup.
    Fisherman_SaveDB(playerid);
    Fisherman_CleanupBoat(playerid);
    Fisherman_RemoveRod(playerid);
    if (g_FishZoneGZ >= 0)
        GangZoneHideForPlayer(playerid, g_FishZoneGZ);
    Fisherman_Reset(playerid);
    return 1;
}

// Returns 1 if handled
stock Fisherman_OnPlayerEnterDynamicCP(playerid, checkpointid)
{
    if (checkpointid == g_FishCP)
    {
        Fisherman_ShowShop_(playerid);
        return 1;
    }
    if (checkpointid == g_BoatCP)
    {
        if (!g_fp[playerid][fp_is_working])
        {
            Fisherman_ShowMsg_(playerid,
                "You need to start the fishing job at the fisherman first.");
            return 1;
        }
        if (!g_fp[playerid][fp_has_rod])
        {
            Fisherman_ShowMsg_(playerid, "Buy a fishing rod first.");
            return 1;
        }
        if (g_fp[playerid][fp_bait] <= 0)
        {
            Fisherman_ShowMsg_(playerid, "Buy bait first.");
            return 1;
        }
        if (g_fp[playerid][fp_has_boat])
        {
            Fisherman_ShowMsg_(playerid, "Your boat is already at the dock.");
            return 1;
        }
        Fisherman_ShowBoat_(playerid);
        return 1;
    }
    return 0;
}

stock Fisherman_OnPlayerStateChange(playerid, newstate, oldstate)
{
    #pragma unused oldstate
    if (g_fp[playerid][fp_is_working] && newstate == PLAYER_STATE_DRIVER
        && g_fp[playerid][fp_has_boat])
    {
        SetTimerEx("Fisherman_CheckZone", 400, false, "i", playerid);
    }
    return 1;
}

public Fisherman_CheckZone(playerid)
{
    if (!IsPlayerConnected(playerid))          return 1;
    if (!g_fp[playerid][fp_is_working])        return 1;
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    if (Fisherman_InZone(x, y))
    {
        if (!g_fp[playerid][fp_in_zone])
        {
            g_fp[playerid][fp_in_zone] = true;
            SendClientMessage(playerid, 0x00FF00FF,
                "[Fishing] You entered the fishing zone. Tap CAST to fish.");
            if (g_fp[playerid][fp_bait] > 0 && !g_fp[playerid][fp_casting])
                Fisherman_ShowHud_(playerid);
        }
    }
    else
    {
        if (g_fp[playerid][fp_in_zone])
        {
            g_fp[playerid][fp_in_zone] = false;
            SendClientMessage(playerid, 0xFFCC00FF,
                "[Fishing] You left the fishing zone.");
        }
    }
    SetTimerEx("Fisherman_CheckZone", 800, false, "i", playerid);
    return 1;
}

public Fisherman_SetSkin(playerid, skin)
{
    SetPlayerSkin(playerid, skin);
    Fisherman_AttachRod(playerid);
    return 1;
}

public Fisherman_StartPost(playerid)
{
    if (!IsPlayerConnected(playerid))   return 1;
    if (!g_fp[playerid][fp_is_working]) return 1;
    // Only show the red fishing gang-zone on the map -- no waypoint
    // marker at the zone centre (removed per user request).
    GangZoneShowForPlayer(playerid, g_FishZoneGZ, FISH_ZONE_COLOR);
    return 1;
}

// --------------------------------------------------------------------------
//  CINEMATIC CAMERA  (flymod-style dive when casting, smooth rise when reeling)
// --------------------------------------------------------------------------
//
//   Fisherman_CamDive        -- called right after the cast animation; the
//                               camera glides down from the player's
//                               shoulder view into a low underwater view,
//                               pointing at the hook/float.  1.8 s.
//
//   Fisherman_CamSurface     -- called when a bite resolves (catch or
//                               miss); the camera rises back to the
//                               player's boat in 1.5 s, then
//                               SetCameraBehindPlayer to return full
//                               gameplay control.
//
//   Fisherman_CamRestore     -- timer target that fires when the surface
//                               interpolation finishes, used to snap the
//                               camera behind the player cleanly.
//
static stock Fisherman_CamDive(playerid)
{
    if (!IsPlayerConnected(playerid)) return 0;
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    // Facing angle -> unit forward vector (for "where the player is
    // looking"), so the hook sits ~5 m ahead of the player.
    new Float:a = 0.0;
    GetPlayerFacingAngle(playerid, a);
    new Float:rad = a * 3.14159265 / 180.0;
    new Float:fx = -floatsin(rad, radian);
    new Float:fy =  floatcos(rad, radian);

    // Start: slightly above+behind the player's shoulder (chase cam).
    new Float:sx = x - fx * 3.0,
        Float:sy = y - fy * 3.0,
        Float:sz = z + 2.5;
    new Float:slx = x + fx * 2.0,
        Float:sly = y + fy * 2.0,
        Float:slz = z + 0.4;

    // End: underwater, about 5 m ahead of the boat and 4 m below surface.
    new Float:ex = x + fx * 5.0,
        Float:ey = y + fy * 5.0,
        Float:ez = z - 4.0;
    new Float:elx = x + fx * 9.0,
        Float:ely = y + fy * 9.0,
        Float:elz = z - 6.5;

    // Kick off the dive — instant snap to the start frame then 1.8 s
    // interpolation into the underwater shot.
    SetPlayerCameraPos(playerid, sx, sy, sz);
    SetPlayerCameraLookAt(playerid, slx, sly, slz, CAMERA_CUT);
    InterpolateCameraPos(playerid, sx, sy, sz, ex, ey, ez, 1800, CAMERA_MOVE);
    InterpolateCameraLookAt(playerid,
        slx, sly, slz, elx, ely, elz, 1800, CAMERA_MOVE);
    return 1;
}

static stock Fisherman_CamSurface(playerid)
{
    if (!IsPlayerConnected(playerid)) return 0;
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    new Float:a = 0.0;
    GetPlayerFacingAngle(playerid, a);
    new Float:rad = a * 3.14159265 / 180.0;
    new Float:fx = -floatsin(rad, radian);
    new Float:fy =  floatcos(rad, radian);

    // Current underwater shot -> chase cam behind the player.
    new Float:sx = x + fx * 5.0,
        Float:sy = y + fy * 5.0,
        Float:sz = z - 4.0;
    new Float:slx = x + fx * 9.0,
        Float:sly = y + fy * 9.0,
        Float:slz = z - 6.5;

    new Float:ex = x - fx * 3.0,
        Float:ey = y - fy * 3.0,
        Float:ez = z + 2.5;
    new Float:elx = x + fx * 2.0,
        Float:ely = y + fy * 2.0,
        Float:elz = z + 0.4;

    SetPlayerCameraPos(playerid, sx, sy, sz);
    SetPlayerCameraLookAt(playerid, slx, sly, slz, CAMERA_CUT);
    InterpolateCameraPos(playerid, sx, sy, sz, ex, ey, ez, 1500, CAMERA_MOVE);
    InterpolateCameraLookAt(playerid,
        slx, sly, slz, elx, ely, elz, 1500, CAMERA_MOVE);

    // After the rise finishes, snap back to normal 3rd-person cam.
    SetTimerEx("Fisherman_CamRestore", 1600, false, "i", playerid);
    return 1;
}

public Fisherman_CamRestore(playerid)
{
    if (!IsPlayerConnected(playerid)) return 1;
    SetCameraBehindPlayer(playerid);
    return 1;
}

public Fisherman_CamRestoreEnd(playerid)
{
    if (!IsPlayerConnected(playerid)) return 1;
    SetCameraBehindPlayer(playerid);
    return 1;
}

public Fisherman_CastResolve(playerid)
{
    if (!IsPlayerConnected(playerid))    return 1;
    if (!g_fp[playerid][fp_casting])     return 1;
    g_fp[playerid][fp_casting] = false;
    // Rise back to the surface before showing the result dialog.
    Fisherman_CamSurface(playerid);

    new roll = random(100);
    new bool:caught = (roll < CATCH_SUCCESS_PCT);

    new body[256];
    if (!caught)
    {
        PlayerPlaySound(playerid, SND_MISS, 0.0, 0.0, 0.0);
        format(body, sizeof(body), "MISS|%d|%d",
            g_fp[playerid][fp_bait], g_fp[playerid][fp_bag_count]);
        ShowPlayerDialog(playerid, DLG_FISH_RESULT, DIALOG_STYLE_MSGBOX,
            "HAVANA_FISH_RESULT", body, "Continue", "End");
        return 1;
    }

    new idx = Fisherman_RandWeighted();
    new dg = g_fish_species[idx][fs_min_dg]
        + random(g_fish_species[idx][fs_max_dg]
               - g_fish_species[idx][fs_min_dg] + 1);
    new Float:weight = float(dg) / 10.0;

    new price;
    new bool:is_rare_catch = (weight >= 1.0 || g_fish_species[idx][fs_is_rare] != 0);
    if (is_rare_catch)
    {
        price = PRICE_RARE;
    }
    else
    {
        price = floatround(weight * float(g_fish_species[idx][fs_price_kg]));
        if (price < CAP_COMMON_MIN) price = CAP_COMMON_MIN;
        if (price > CAP_COMMON_PRICE) price = CAP_COMMON_PRICE;
    }

    new n = g_fp[playerid][fp_bag_count];
    if (n < MAX_BAG_FISH)
    {
        g_fp[playerid][fp_bag_species][n] = idx;
        g_fp[playerid][fp_bag_weight ][n] = weight;
        g_fp[playerid][fp_bag_price  ][n] = price;
        g_fp[playerid][fp_bag_count]      = n + 1;
        g_fp[playerid][fp_total_money]   += price;
    }

    new rare = is_rare_catch ? 1 : 0;
    PlayerPlaySound(playerid, SND_CATCH, 0.0, 0.0, 0.0);
    format(body, sizeof(body), "CATCH|%s|%.1f|%d|%d|%d|%d",
        g_fish_species[idx][fs_name], weight, price, rare,
        g_fp[playerid][fp_bait], g_fp[playerid][fp_bag_count]);
    ShowPlayerDialog(playerid, DLG_FISH_RESULT, DIALOG_STYLE_MSGBOX,
        "HAVANA_FISH_RESULT", body, "Continue", "End");
    return 1;
}

// Returns 1 if handled (so gamemode should `return 1` early).
stock Fisherman_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch (dialogid)
    {
        case DLG_FISH_SHOP:
        {
            if (!response) return 1;
            switch (listitem)
            {
                case 0: { Fisherman_ShowLic_(playerid); return 1; }
                case 1:
                {
                    if (!g_fp[playerid][fp_has_license])
                    {
                        Fisherman_ShowMsg_(playerid,
                            "You need a fishing license first.");
                        return 1;
                    }
                    Fisherman_ShowBait_(playerid);
                    return 1;
                }
                case 2:
                {
                    if (!g_fp[playerid][fp_has_license])
                    {
                        Fisherman_ShowMsg_(playerid,
                            "You need a fishing license first.");
                        return 1;
                    }
                    Fisherman_ShowRod_(playerid);
                    return 1;
                }
                case 3:
                {
                    if (g_fp[playerid][fp_is_working])
                    {
                        Fisherman_Finish(playerid, true);
                        return 1;
                    }
                    if (!g_fp[playerid][fp_has_license])
                    {
                        Fisherman_ShowMsg_(playerid,
                            "You need a fishing license to start.");
                        return 1;
                    }
                    if (!g_fp[playerid][fp_has_rod])
                    {
                        Fisherman_ShowMsg_(playerid,
                            "Buy a fishing rod first.");
                        return 1;
                    }
                    if (g_fp[playerid][fp_bait] <= 0)
                    {
                        Fisherman_ShowMsg_(playerid,
                            "Buy at least one bait first.");
                        return 1;
                    }
                    // Set the working flag + payload before any heavy ops so
                    // that the client sees the dialog close immediately.
                    g_fp[playerid][fp_orig_skin]  = GetPlayerSkin(playerid);
                    g_fp[playerid][fp_is_working] = true;
                    g_fp[playerid][fp_bag_count]  = 0;
                    g_fp[playerid][fp_total_money]= 0;
                    SendClientMessage(playerid, 0x00C8FFFF,
                        "[Fishing] Rent a boat at the marina and head to the red zone.");
                    // Defer skin/rod/gangzone/mapicon so the dialog closes
                    // without a frame-long freeze on slower devices.  The
                    // SWORD anim lib is preloaded in OnPlayerConnect.
                    SetTimerEx("Fisherman_SetSkin", 150, false, "ii",
                        playerid, WORKER_SKIN);
                    SetTimerEx("Fisherman_StartPost", 260, false, "i", playerid);
                    return 1;
                }
            }
            return 1;
        }
        case DLG_FISH_LIC:
        {
            if (!response)
            {
                Fisherman_ShowShop_(playerid);
                return 1;
            }
            new days = 30, price = PRICE_LIC_30;
            switch (listitem)
            {
                case 1: { days = 60; price = PRICE_LIC_60; }
                case 2: { days = 90; price = PRICE_LIC_90; }
            }
            if (GetPlayerMoney(playerid) < price)
            {
                Fisherman_ShowMsg_(playerid, "Not enough money.");
                return 1;
            }
            Fisherman_AddMoney(playerid, -price);
            PlayerPlaySound(playerid, SND_BUY, 0.0, 0.0, 0.0);
            g_fp[playerid][fp_has_license]   = true;
            g_fp[playerid][fp_license_expire]= gettime() + days * 86400;
            Fisherman_SaveDB(playerid);
            new msg[128];
            format(msg, sizeof(msg),
                "Fishing license purchased for %d days.", days);
            Fisherman_ShowMsg_(playerid, msg);
            return 1;
        }
        case DLG_FISH_BAIT:
        {
            if (!response)
            {
                Fisherman_ShowShop_(playerid);
                return 1;
            }
            new qty = 0;
            if (sscanf(inputtext, "i", qty) || qty <= 0)
            {
                Fisherman_ShowMsg_(playerid, "Invalid quantity.");
                return 1;
            }
            // Unlimited bait purchase (qty capped only by int32).
            new price = qty * PRICE_BAIT;
            if (price <= 0)
            {
                // integer overflow guard
                Fisherman_ShowMsg_(playerid, "Invalid quantity.");
                return 1;
            }
            if (GetPlayerMoney(playerid) < price)
            {
                Fisherman_ShowMsg_(playerid, "Not enough money.");
                return 1;
            }
            Fisherman_AddMoney(playerid, -price);
            PlayerPlaySound(playerid, SND_BUY, 0.0, 0.0, 0.0);
            g_fp[playerid][fp_bait] += qty;
            Fisherman_SaveDB(playerid);
            new msg[128];
            format(msg, sizeof(msg),
                "Bought %d bait(s). You now have %d.",
                qty, g_fp[playerid][fp_bait]);
            Fisherman_ShowMsg_(playerid, msg);
            return 1;
        }
        case DLG_FISH_ROD:
        {
            if (!response)
            {
                Fisherman_ShowShop_(playerid);
                return 1;
            }
            if (g_fp[playerid][fp_has_rod])
            {
                Fisherman_ShowMsg_(playerid, "You already have a rod.");
                return 1;
            }
            if (GetPlayerMoney(playerid) < PRICE_ROD)
            {
                Fisherman_ShowMsg_(playerid, "Not enough money.");
                return 1;
            }
            Fisherman_AddMoney(playerid, -PRICE_ROD);
            PlayerPlaySound(playerid, SND_BUY, 0.0, 0.0, 0.0);
            g_fp[playerid][fp_has_rod] = true;
            Fisherman_SaveDB(playerid);
            // Attach the FishingRod object (model 18632) to the player's
            // hand the moment the purchase succeeds. It will stay equipped
            // until the player ends the job (Fisherman_Finish / Stop).
            Fisherman_AttachRod(playerid);
            Fisherman_ShowMsg_(playerid, "Fishing rod purchased.");
            return 1;
        }
        case DLG_FISH_BOAT_RENT:
        {
            if (!response) return 1;
            if (GetPlayerMoney(playerid) < PRICE_BOAT)
            {
                Fisherman_ShowMsg_(playerid, "Not enough money.");
                return 1;
            }
            Fisherman_AddMoney(playerid, -PRICE_BOAT);
            new veh = CreateVehicle(BOAT_MODEL,
                BOAT_SPAWN_X, BOAT_SPAWN_Y, BOAT_SPAWN_Z, BOAT_SPAWN_A,
                -1, -1, -1);
            g_fp[playerid][fp_has_boat]     = true;
            g_fp[playerid][fp_boat_vehicle] = veh;
            // Full fuel + full engine health so the boat is ready to go.
            if (veh > 0)
            {
                veh_info[veh - 1][v_fuel] = 100.0;
                SetVehicleHealth(veh, 1000.0);
            }
            PutPlayerInVehicle(playerid, veh, 0);
            PlayerPlaySound(playerid, SND_BOAT, 0.0, 0.0, 0.0);
            SendClientMessage(playerid, 0x00C8FFFF,
                "[Fishing] Boat rented (full fuel). Head to the red fishing zone.");
            return 1;
        }
        case DLG_FISH_HUD, DLG_FISH_CAST:
        {
            if (!response)
            {
                if (g_fp[playerid][fp_bag_count] > 0)
                    Fisherman_Finish(playerid, true);
                else
                    Fisherman_Finish(playerid, false);
                return 1;
            }
            // If CAST dialog fired with response=1, it means the user tapped
            // "Reel" while already casting -> just re-show the waiting scene.
            if (dialogid == DLG_FISH_CAST && g_fp[playerid][fp_casting])
            {
                Fisherman_ShowCast_(playerid);
                return 1;
            }
            if (g_fp[playerid][fp_bait] <= 0)
            {
                Fisherman_ShowMsg_(playerid, "Out of bait.");
                return 1;
            }
            new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x, y, z);
            if (!Fisherman_InZone(x, y))
            {
                Fisherman_ShowMsg_(playerid,
                    "You need to be inside the red fishing zone.");
                return 1;
            }
            if (!Fisherman_NearBoat(playerid))
            {
                Fisherman_ShowMsg_(playerid,
                    "You need to be on (or within 10m of) your rented boat.");
                return 1;
            }
            g_fp[playerid][fp_casting] = true;
            g_fp[playerid][fp_bait] -= 1;
            Fisherman_SaveDB(playerid);
            PlayerPlaySound(playerid, SND_CAST, 0.0, 0.0, 0.0);
            ApplyAnimation(playerid, "SWORD", "sword_block", 4.1, 0, 0, 0, 0, 0, 1);
            Fisherman_CamDive(playerid);
            Fisherman_ShowCast_(playerid);
            new delay = CAST_MIN_MS
                + random(CAST_MAX_MS - CAST_MIN_MS);
            SetTimerEx("Fisherman_CastResolve", delay, false, "i", playerid);
            return 1;
        }
        case DLG_FISH_RESULT:
        {
            g_fp[playerid][fp_casting] = false;
            ClearAnimations(playerid);
            if (!response)
            {
                Fisherman_Finish(playerid, true);
                return 1;
            }
            if (g_fp[playerid][fp_bait] <= 0)
            {
                Fisherman_ShowMsg_(playerid,
                    "Out of bait. Return to the fisherman to finish.");
                return 1;
            }
            Fisherman_ShowHud_(playerid);
            return 1;
        }
        case DLG_FISH_STATS:
        {
            return 1;
        }
        case DLG_FISH_MSG:
        {
            return 1;
        }
    }
    return 0;
}
