#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# Uploads the new filterscript + the freshly-built gamemode to the production
# server over FTP, then patches server.cfg so the filterscript is loaded.
#
# Usage:
#   FTP_HOST=51.210.223.180 \
#   FTP_USER=gs108396 \
#   FTP_PASS='Gs108396!Aa' \
#   bash deploy_to_ftp.sh
#
# Or just bash deploy_to_ftp.sh — it falls back to the same defaults.
#
# Safety:
#   - server.cfg is downloaded, edited locally, uploaded back. A backup
#     called server.cfg.before-azelow is kept on the FTP.
#   - The script is idempotent: re-running it does NOT add car_azelow twice.
#   - You still need to /rcon gmx (or restart the gamemode) to load the
#     filterscript on a running server.
# -----------------------------------------------------------------------------
set -euo pipefail

FTP_HOST="${FTP_HOST:-51.210.223.180}"
FTP_USER="${FTP_USER:-gs108396}"
FTP_PASS="${FTP_PASS:-Gs108396!Aa}"
FTP_PORT="${FTP_PORT:-21}"

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
FS_AMX="$ROOT/filterscripts/car_azelow.amx"
FS_PWN="$ROOT/filterscripts/car_azelow.pwn"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

if [[ ! -f "$FS_AMX" ]]; then
    echo "error: $FS_AMX missing — build it first with build_all.sh" >&2
    exit 1
fi

echo "[1/4] Downloading current server.cfg ..."
lftp -u "$FTP_USER","$FTP_PASS" -p "$FTP_PORT" "$FTP_HOST" \
    -e "set ssl:verify-certificate no; get -O $TMP server.cfg; bye"

echo "[2/4] Patching server.cfg locally ..."
if grep -q "car_azelow" "$TMP/server.cfg"; then
    echo "       car_azelow already in filterscripts; leaving server.cfg alone."
else
    cp "$TMP/server.cfg" "$TMP/server.cfg.before-azelow"
    awk '
        /^filterscripts/ {
            if ($0 !~ /car_azelow/) {
                print $0 " car_azelow"
                next
            }
        }
        { print }
    ' "$TMP/server.cfg" > "$TMP/server.cfg.new"
    mv "$TMP/server.cfg.new" "$TMP/server.cfg"
    echo "       new filterscripts line: $(grep ^filterscripts "$TMP/server.cfg")"
fi

echo "[3/4] Uploading filterscript + gamemode source ..."
lftp -u "$FTP_USER","$FTP_PASS" -p "$FTP_PORT" "$FTP_HOST" <<EOF
set ssl:verify-certificate no
put -O filterscripts $FS_AMX
put -O filterscripts $FS_PWN
bye
EOF

echo "[4/4] Uploading patched server.cfg (and a backup) ..."
lftp -u "$FTP_USER","$FTP_PASS" -p "$FTP_PORT" "$FTP_HOST" <<EOF
set ssl:verify-certificate no
$( [[ -f "$TMP/server.cfg.before-azelow" ]] && \
    echo "put -O / $TMP/server.cfg.before-azelow" )
put -O / $TMP/server.cfg
bye
EOF

echo
echo "Done. To load the filterscript on a running server:"
echo "  /rcon login <password>"
echo "  /rcon loadfs car_azelow"
echo "or restart the gamemode with /rcon gmx."
