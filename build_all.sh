#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# build_all.sh — orchestrates the full build:
#   1) (Re)compile arabonline.pwn into arabonline.amx (gamemode).
#   2) Compile car_azelow.pwn into car_azelow.amx (filterscript).
#
# Pre-reqs: ../HavanaRp_release_v15 must be unpacked next to this directory,
# i.e. side-by-side:
#   /your/dir/havanarp-vehicle-8000-azelow/
#   /your/dir/HavanaRp_release_v15/
# -----------------------------------------------------------------------------
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HAVANARP="${HAVANARP:-$(cd "$DIR/.." && pwd)/HavanaRp_release_v15}"

if [[ ! -d "$HAVANARP" ]]; then
    echo "error: HavanaRp_release_v15 not found at $HAVANARP" >&2
    echo "       set HAVANARP=/path/to/HavanaRp_release_v15 and re-run." >&2
    exit 1
fi

PAWNCC_DIR="$HAVANARP/06_pawncc"
SERVER_DIR="$HAVANARP/05_server"

echo "[1/2] Compiling arabonline.pwn -> arabonline.amx ..."
( cd "$SERVER_DIR" && \
    LD_LIBRARY_PATH="$PAWNCC_DIR" "$PAWNCC_DIR/pawncc" \
        arabonline.pwn \
        -i"$PAWNCC_DIR/include" \
        -d3 -O1 \
        "-;+" "-(+" >/tmp/azelow_arabonline.log 2>&1 || {
            tail -40 /tmp/azelow_arabonline.log
            echo "FAIL: arabonline.pwn did not compile — see /tmp/azelow_arabonline.log"
            exit 1
        }
)
echo "      OK: $SERVER_DIR/arabonline.amx ($(stat -c%s "$SERVER_DIR/arabonline.amx") bytes)"

echo "[2/2] Compiling car_azelow.pwn -> car_azelow.amx ..."
( cd "$DIR/filterscripts" && \
    LD_LIBRARY_PATH="$PAWNCC_DIR" "$PAWNCC_DIR/pawncc" \
        car_azelow.pwn \
        -i"$PAWNCC_DIR/include" \
        -d3 -O1 \
        "-;+" "-(+" )
echo "      OK: $DIR/filterscripts/car_azelow.amx ($(stat -c%s "$DIR/filterscripts/car_azelow.amx") bytes)"

echo
echo "Build complete. To deploy:"
echo "  bash deploy/deploy_to_ftp.sh"
