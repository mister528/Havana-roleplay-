#!/usr/bin/env bash
# Builds and signs HavanaRp.apk from the apktool template.
# Run this from inside 03_apktool_template/ after replacing
# apk_full/lib/armeabi-v7a/libluxury.so with the freshly built libsamp.so.
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$DIR/.." && pwd)"

APKTOOL="$ROOT/04_tools/apktool_2.10.0.jar"
KS="$ROOT/02_signing/havana.keystore"
KS_PASS="havana123"
KEY_ALIAS="havana"

cd "$ROOT/03_apktool_template"
rm -f HavanaRp.unsigned.apk HavanaRp.aligned.apk HavanaRp.apk HavanaRp.apk.idsig

echo "[1/3] apktool b ..."
java -jar "$APKTOOL" b apk_full -o HavanaRp.unsigned.apk

echo "[2/3] zipalign ..."
zipalign -p -f 4 HavanaRp.unsigned.apk HavanaRp.aligned.apk

echo "[3/3] apksigner ..."
apksigner sign \
    --ks "$KS" \
    --ks-key-alias "$KEY_ALIAS" \
    --ks-pass "pass:$KS_PASS" \
    --key-pass "pass:$KS_PASS" \
    --v1-signing-enabled true \
    --v2-signing-enabled true \
    --v3-signing-enabled true \
    --out HavanaRp.apk \
    HavanaRp.aligned.apk

apksigner verify --print-certs HavanaRp.apk | grep -i "SHA-256" || true

echo "Done -> $(pwd)/HavanaRp.apk"
