# HavanaRp · Vehicle ID 8000 — Daewoo Gentra Azelow patch

Adds a brand-new vehicle (model id **8000**, "Daewoo Gentra Azelow") to the
HavanaRp SA-MP server without replacing any stock vehicle.

| What | Where |
|------|-------|
| Vehicle assets | [`patch_8000_azelow/data/azelow.dff`](patch_8000_azelow/data/azelow.dff), [`.txd`](patch_8000_azelow/data/azelow.txd) |
| Data-file snippets | [`patch_8000_azelow/snippets/`](patch_8000_azelow/snippets/) |
| Idempotent installer | [`patch_8000_azelow/apply_patch.py`](patch_8000_azelow/apply_patch.py) |
| Server-side filterscript | [`filterscripts/car_azelow.pwn`](filterscripts/car_azelow.pwn) (compiled: [`.amx`](filterscripts/car_azelow.amx)) |
| Build orchestrator | [`build_all.sh`](build_all.sh) |
| FTP deployer | [`deploy/deploy_to_ftp.sh`](deploy/deploy_to_ftp.sh) |
| Arabic install guide | [`docs/INSTALL_AR.md`](docs/INSTALL_AR.md) |
| Launcher notes | [`docs/LAUNCHER_PATCH.md`](docs/LAUNCHER_PATCH.md) |

## Quickstart

```bash
# 1. unpack HavanaRp_release_v15/ side-by-side with this folder
# 2. compile gamemode + filterscript
bash build_all.sh
# 3. push to the FTP and patch server.cfg
FTP_HOST=51.210.223.180 \
FTP_USER=gs108396 \
FTP_PASS='Gs108396!Aa' \
bash deploy/deploy_to_ftp.sh
# 4. inside SA-MP: /rcon login <password> && /rcon loadfs car_azelow
```

In-game commands:
- `/azelow` — teleport into the nearest spawned Azelow.
- `/spawnazelow [c1] [c2]` — admin only, spawns one in front of you.

For the client-side data-file patch (so the model actually renders on the
players' devices), see [`docs/INSTALL_AR.md §4`](docs/INSTALL_AR.md#4-خطوات-التثبيت--جانب-العميل-الapk).

## Source attribution

- Vehicle model files: provided by the user (`daewoo-gentra-azelow_1777894442_811364.zip`).
- Reference for the dataset edits: ["Добавление новых машин в GTA San Andreas" — pawno-info.ru](https://pawno-info.ru/threads/dobavlenie-novyx-mashin-v-gta-san-andreas.325870/), translated/adapted for HavanaRp's Linux + Android pipeline.
- Pawn compiler: bundled `pawncc 3.10.10` Linux x86_64 (in `HavanaRp_release_v15/06_pawncc/`).

## Notes on vehicle id 8000

- **Network**: the launcher's range guard in `jni/net/netrpc.cpp` is already
  commented out, so the server can send `CreateVehicle(8000, …)` and the
  client accepts it without any further change.
- **Audio**: bumping `VehicleAudioData.ini` `ToID_1` from `615` to `19000`
  makes engine/horn sounds available for the new id (this is the fix from
  the Russian guide).
- **Rendering**: relies on the GTA SA Mobile install having `azelow.dff` /
  `.txd` inside its IMG archive, plus the entry in `vehicles.ide`. If a
  player's install doesn't have the patch applied, they'll see the
  vehicle as missing/glitched but the rest of the server keeps working.
