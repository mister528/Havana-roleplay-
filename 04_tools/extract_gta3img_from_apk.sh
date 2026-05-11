#!/usr/bin/env bash
# extract_gta3img_from_apk.sh — pull gta3.img out of a built APK and put it
# back into the apk_full source tree, so you can rebuild without bundling
# the 299MB gta3.img with the source kit.
#
# Run this BEFORE 04_tools/build_apk.sh on a fresh checkout of the dev kit.
#
# Usage:
#   bash 04_tools/extract_gta3img_from_apk.sh
#   bash 04_tools/extract_gta3img_from_apk.sh path/to/HavanaRp_v16_azelow.apk

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$DIR/.." && pwd)"

APK="${1:-$ROOT/08_artifacts/HavanaRp_v16_azelow.apk}"
DEST="$ROOT/03_apktool_template/apk_full/assets/data/gta3.img"

if [[ ! -f "$APK" ]]; then
    echo "ERROR: APK not found: $APK"
    echo "Pass an APK path as the first argument."
    exit 1
fi

mkdir -p "$(dirname "$DEST")"
echo "Extracting gta3.img from $APK ..."
unzip -p "$APK" assets/data/gta3.img > "$DEST"
SIZE=$(stat -c%s "$DEST")
echo "  -> $DEST ($SIZE bytes)"

echo "Done. You can now run: bash 04_tools/build_apk.sh"
