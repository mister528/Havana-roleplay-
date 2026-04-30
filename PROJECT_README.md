# HavanaRp — Full Package (v3 Final, Devin update)

This ZIP contains every source file, tool, and credential you need to
rebuild and re-sign the launcher APK and the SAMP gamemode.

```
HavanaRp_v3_Final/
├── 01_jni_source/        ← Native launcher source (libsamp.so / libluxury.so)
│                            • inventoryoverlay.cpp  ← bag overlay (Arabic, 6×4 grid)
│                            • netrpc.cpp            ← Inventory_SendChatCommand bridge
├── 02_signing/           ← APK keystore + credentials
│                            • havana.keystore
│                            • SIGNING_INFO.txt
├── 03_build_tools/       ← Pawn compiler + build script
│                            • build_all.sh        (one-click full rebuild)
│                            • pawncc_3.10.9_for_samp/  (SAMP-compatible amx output)
│                            • pawncc_3.10.10_64bit/    (rebuilt from source)
├── 04_final_apk/         ← Signed APK ready for install
│                            • HavanaRp.apk
├── 05_gamemode/          ← Pawn gamemode source + compiled amx
│                            • arabonline.pwn / arabonline.amx
│                            • include/fisherman.inc  ← FishingRod attach on purchase
│                            • filterscripts/inv_ui.* / bank_ui.*
└── 06_apktool_project/   ← Decompiled APK + apktool jar
                             • apktool_2.10.0.jar
                             • apk_full/ (smali + lib/*/libluxury.so)
```

## ✦ Quick rebuild (one shot)

Requires:
  - Android NDK r17c at `~/android-ndk-r17c/` (env: `NDK_BUILD`)
  - Java 8+ on PATH (`java`, `apksigner`, `zipalign`)

```
cd 03_build_tools
./build_all.sh
```

Outputs:
  - `04_final_apk/HavanaRp.apk`   ← signed launcher
  - `05_gamemode/arabonline.amx`  ← compiled gamemode

## ✦ What's new in v3

### Launcher (`01_jni_source`)
1. **Bag overlay (Arabic, 6×4 grid)** — see `jni/jni/gui/inventoryoverlay.cpp`
   - Uses live ownership data from `inv_ui.pwn` (only items the player owns
     are filled; empty slots are dimmed).
   - Polished procedural icons for every item: phone, mask, fuel can,
     wrench/screwdriver, syringe, pistol, ammo cartridges, sprouted seed,
     coiled rope, bandage roll, crate, cigarette pack, etc.
   - Tap-to-use sends `/cmd` to the server via `Inventory_SendChatCommand`
     — no longer relies on dialog responses.
   - Underlying SAMP dialog is auto-acked on open, so chat and HUD
     buttons stay fully responsive while the bag is visible.

### Gamemode (`05_gamemode`)
2. **FishingRod attaches on purchase** — see `include/fisherman.inc`
   - `case DLG_FISH_ROD`: after a successful buy, calls
     `Fisherman_AttachRod(playerid)` to pin object **18632 FishingRod**
     to the player's right hand (slot 3) immediately.
   - `Fisherman_OnLoadCache`: re-equips the rod on login if the player
     already owns one (`u_fish_rod = 1`).
   - Existing detach paths (`Fisherman_Finish`, `Fisherman_Reset`,
     `Fisherman_Stop`) call `Fisherman_RemoveRod`, so the rod
     disappears from the hand the moment the job ends.

## ✦ Manual rebuild steps

### Compile launcher only
```
cd 01_jni_source/jni
~/android-ndk-r17c/ndk-build NDK_PROJECT_PATH=. \
    APP_BUILD_SCRIPT=jni/Android.mk \
    NDK_APPLICATION_MK=jni/Application.mk -j$(nproc)
cp libs/armeabi-v7a/libsamp.so \
   ../../06_apktool_project/apk_full/lib/armeabi-v7a/libluxury.so
```

### Repack + sign APK
```
cd ../../
java -jar 06_apktool_project/apktool_2.10.0.jar \
    b 06_apktool_project/apk_full -o /tmp/HavanaRp.unsigned.apk
zipalign -p -f 4 /tmp/HavanaRp.unsigned.apk /tmp/HavanaRp.aligned.apk
apksigner sign \
    --ks 02_signing/havana.keystore --ks-key-alias havana \
    --ks-pass pass:havana123 --key-pass pass:havana123 \
    --v1-signing-enabled true --v2-signing-enabled true --v3-signing-enabled true \
    --out 04_final_apk/HavanaRp.apk /tmp/HavanaRp.aligned.apk
apksigner verify --print-certs 04_final_apk/HavanaRp.apk
```

The SHA-256 fingerprint must equal:
```
59:63:0a:15:84:bf:a9:9f:8a:f3:75:72:a4:74:a1:87:
23:3a:1e:9f:5d:71:16:7c:79:6d:8f:78:60:60:eb:4f
```

### Compile gamemode only (Pawn 3.10.9, SAMP-compatible AMX)
```
cd 05_gamemode
PAWNCC_DIR=../03_build_tools/pawncc_3.10.9_for_samp
LD_LIBRARY_PATH="$PAWNCC_DIR/lib" \
    "$PAWNCC_DIR/bin/pawncc" -i./include arabonline.pwn -d0 -o./arabonline.amx
xxd -l 8 arabonline.amx | awk '{print $4}'   # must print 0808
```

### Upload to FTP server (51.210.223.180)
After compiling, push `arabonline.amx` to `/gamemodes/`:
```
curl -T 05_gamemode/arabonline.amx \
     ftp://gs108396:Gs108396%21Aa@51.210.223.180/gamemodes/arabonline.amx
```
Filterscripts (`inv_ui.amx`, `bank_ui.amx`) → `/filterscripts/`.

Then in-game: `rcon gmx` (or `rcon reloadfs <name>` for filterscripts).

## ✦ Credentials reference (already inside this ZIP)

| Item                | Value                                  |
|---------------------|----------------------------------------|
| Keystore            | `02_signing/havana.keystore`           |
| Keystore password   | `havana123`                            |
| Key alias           | `havana`                               |
| Key password        | `havana123`                            |
| FTP host            | `51.210.223.180:21`                    |
| FTP user / pass     | `gs108396` / `Gs108396!Aa`             |

>  Security tip: rotate the FTP password after the build; it's only
>  here so future updates can be automated.
