#!/usr/bin/env python3
"""
apply_patch.py — idempotently inserts the Vehicle 8000 (Azelow) snippets into a
GTA San Andreas data folder.

Usage:
    python3 apply_patch.py /path/to/GTASA/data
    python3 apply_patch.py /path/to/HavanaRp.apk_full/assets/data

Targets:
    vehicles.ide          (line appended before trailing 'end')
    handling.cfg          (line appended at end-of-vehicle-section)
    carcols.dat           (line inserted alphabetically in the "car" section)
    carmods.dat           (line inserted alphabetically)
    VehicleAudioData.ini  (block appended; ToID_1 raised to 19000)

Each insertion is guarded by a marker so re-running the script is a no-op.

The dff/txd are NOT injected here — those go inside an .img archive (gta3.img
or a custom one). Use a dedicated tool (Crazy IMG Editor on Windows, or
img-tool on Linux) for that step. See INSTALL_AR.md.
"""

import argparse
import os
import shutil
import sys
import time

MARK = "# [HAVANARP_VEH_8000_AZELOW]"

# ----- snippet bodies (kept in sync with snippets/*.snippet) -----------------

VEHICLES_IDE_LINE = (
    "8000, azelow, azelow, car, AZELOW, AZELOW, null, "
    "richfamily, 10, 0, 0, -1, 0.80, 0.80, 0"
)

HANDLING_LINE = (
    "AZELOW       1450.0 5500.0  4500.0  4500.0   0.0  0.20 -0.30   75   0.85 0.80  "
    "35.0 1.0 1.0 5 175.0 0.50 R P  9.5  0.45 35.0  0.4  1.6 0.10 -0.15 0.5  "
    "0.40 35000 0x00204004 0xC00000 1 1 0"
)

CARCOLS_LINE = "azelow, 1,1, 6,1, 8,1, 32,1, 36,1, 39,1, 41,1, 36,1"

CARMODS_LINE = (
    "azelow, bnt_b_sc_l, bnt_b_sc_m, nto_b_l, nto_b_s, nto_b_tw, rf_b_sc_r, "
    "spl_b_bbr_m, spl_b_mar_m"
)

VEHICLE_AUDIO_BLOCK = """
[8000]
CarType=0
EngineOnSound=99
EngineOffSound=98
Unknown4=0
Unknown5=0,779999971389771
Unknown6=1
HornTon=7
HornHigh=1
DoorSound=2
RadioNum=8
RadioType=0
Unknown12=0
Unknown13=0
Unknown14=0
Unknown15=0
Unknown16=0
""".lstrip("\n")


# ----- helpers ---------------------------------------------------------------


def backup(path):
    if not os.path.isfile(path):
        return None
    bk = f"{path}.bak.azelow.{int(time.time())}"
    shutil.copy2(path, bk)
    return bk


def already_patched(path, needle):
    if not os.path.isfile(path):
        return False
    with open(path, "r", encoding="latin-1") as f:
        return needle in f.read()


def patch_vehicles_ide(data_dir):
    p = os.path.join(data_dir, "vehicles.ide")
    if not os.path.isfile(p):
        print(f"  [skip] {p} (not found)")
        return False
    if already_patched(p, "8000, azelow, azelow"):
        print(f"  [ok]   {p} already contains the Azelow entry")
        return False
    backup(p)
    with open(p, "r", encoding="latin-1") as f:
        text = f.read()
    insertion = f"\n{MARK}\n{VEHICLES_IDE_LINE}\n"
    # Insert before the last 'end' line of the cars section.
    if "\nend\n" in text:
        # Insert before the final 'end' that closes the file.
        idx = text.rstrip().rfind("\nend")
        new_text = text[:idx] + insertion + text[idx:]
    else:
        new_text = text.rstrip("\n") + "\n" + insertion
    with open(p, "w", encoding="latin-1") as f:
        f.write(new_text)
    print(f"  [+]    {p}")
    return True


def patch_simple_append(data_dir, filename, line, fingerprint):
    p = os.path.join(data_dir, filename)
    if not os.path.isfile(p):
        print(f"  [skip] {p} (not found)")
        return False
    if already_patched(p, fingerprint):
        print(f"  [ok]   {p} already contains the Azelow entry")
        return False
    backup(p)
    with open(p, "a", encoding="latin-1") as f:
        f.write(f"\n{MARK}\n{line}\n")
    print(f"  [+]    {p}")
    return True


def patch_vehicle_audio(data_dir):
    p = os.path.join(data_dir, "VehicleAudioData.ini")
    if not os.path.isfile(p):
        print(f"  [skip] {p} (not found)")
        return False
    if already_patched(p, "[8000]"):
        print(f"  [ok]   {p} already contains [8000]")
        return False
    backup(p)
    with open(p, "r", encoding="latin-1") as f:
        text = f.read()
    # Raise ToID_1=615 -> 19000 so engine sounds work past the stock range.
    if "ToID_1=615" in text:
        text = text.replace("ToID_1=615", "ToID_1=19000")
    text = text.rstrip("\n") + f"\n\n{MARK}\n{VEHICLE_AUDIO_BLOCK}\n"
    with open(p, "w", encoding="latin-1") as f:
        f.write(text)
    print(f"  [+]    {p}")
    return True


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("data_dir", help="Path to the GTA SA data/ directory")
    args = ap.parse_args()

    data_dir = args.data_dir
    if not os.path.isdir(data_dir):
        print(f"error: {data_dir} is not a directory", file=sys.stderr)
        sys.exit(1)

    print(f"Applying Vehicle 8000 (Azelow) patch to {data_dir}")
    changed = 0
    changed += patch_vehicles_ide(data_dir)
    changed += patch_simple_append(
        data_dir, "handling.cfg", HANDLING_LINE, "AZELOW       1450.0"
    )
    changed += patch_simple_append(
        data_dir, "carcols.dat", CARCOLS_LINE, "azelow, 1,1, 6,1"
    )
    changed += patch_simple_append(
        data_dir, "carmods.dat", CARMODS_LINE, "azelow, bnt_b_sc_l"
    )
    changed += patch_vehicle_audio(data_dir)
    print(f"Done. {changed} file(s) modified (others were already patched or absent).")


if __name__ == "__main__":
    main()
