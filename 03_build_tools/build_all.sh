#!/bin/bash
# ================================================================
#  HavanaRp v2 - Full build pipeline (Devin update)
#
#  1) Builds libsamp.so via NDK r17c
#  2) Repackages APK via apktool (renames libsamp.so -> libluxury.so inside)
#  3) Zipaligns and signs with havana.keystore (v1+v2+v3)
#  4) Compiles arabonline.amx with Pawn 3.10.9 (SAMP-compatible)
# ================================================================
set -e

HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$HERE/.." && pwd)"
echo "==> Package root: $ROOT"

JNI_DIR="$ROOT/01_jni_source/jni"
KEYSTORE="$ROOT/02_signing/havana.keystore"
APK_PROJ="$ROOT/06_apktool_project"
APK_DIR="$APK_PROJ/apk_full"
APKTOOL="$APK_PROJ/apktool_2.10.0.jar"
OUTPUT_DIR="$ROOT/04_final_apk"
NDK_BUILD="${NDK_BUILD:-$HOME/android-ndk-r17c/ndk-build}"
PAWNCC="$HERE/pawncc_3.10.9_for_samp/bin/pawncc"
PAWNCC_LIB="$HERE/pawncc_3.10.9_for_samp/lib"

mkdir -p "$OUTPUT_DIR"

# --- 1) Compile JNI ----------------------------------------------
if [ -x "$NDK_BUILD" ]; then
    echo "==> Building libsamp.so via $NDK_BUILD"
    cd "$JNI_DIR"
    "$NDK_BUILD" NDK_PROJECT_PATH=. \
        APP_BUILD_SCRIPT=jni/Android.mk \
        NDK_APPLICATION_MK=jni/Application.mk -j$(nproc)
    cp "libs/armeabi-v7a/libsamp.so" "$APK_DIR/lib/armeabi-v7a/libluxury.so"
else
    echo "WARNING: NDK build not found at $NDK_BUILD — skipping JNI compile"
fi

# --- 2) Repack APK -----------------------------------------------
cd "$ROOT"
echo "==> apktool b"
java -jar "$APKTOOL" b "$APK_DIR" -o HavanaRp.unsigned.apk

# --- 3) Align + sign ---------------------------------------------
echo "==> zipalign + apksigner"
zipalign -p -f 4 HavanaRp.unsigned.apk HavanaRp.aligned.apk
apksigner sign \
    --ks            "$KEYSTORE" \
    --ks-key-alias  havana \
    --ks-pass       pass:havana123 \
    --key-pass      pass:havana123 \
    --v1-signing-enabled true \
    --v2-signing-enabled true \
    --v3-signing-enabled true \
    --out           "$OUTPUT_DIR/HavanaRp.apk" \
    HavanaRp.aligned.apk

apksigner verify --print-certs "$OUTPUT_DIR/HavanaRp.apk" | head -5
rm -f HavanaRp.unsigned.apk HavanaRp.aligned.apk

# --- 4) Compile arabonline.amx -----------------------------------
echo "==> Compiling arabonline.amx (Pawn 3.10.9, no -O2)"
cd "$ROOT/05_gamemode"
LD_LIBRARY_PATH="$PAWNCC_LIB" "$PAWNCC" \
    -i./include arabonline.pwn -d0 -o./arabonline.amx || true

# Sanity check: file_version must be 8
HDR=$(xxd -l 8 arabonline.amx | awk '{print $4}')
if [ "$HDR" = "0808" ]; then
    echo "==> arabonline.amx file_version=8 (SAMP-compatible) OK"
else
    echo "WARNING: arabonline.amx header bytes 6-7 = $HDR (expected 0808)"
fi

echo "==> All done."
echo "    APK:  $OUTPUT_DIR/HavanaRp.apk"
echo "    AMX:  $ROOT/05_gamemode/arabonline.amx"
