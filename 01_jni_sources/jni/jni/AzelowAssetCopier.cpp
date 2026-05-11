// AzelowAssetCopier.cpp
//
// On the very first run after the player installs (or updates to) the new
// HavanaRp APK, this drops *only* handling.cfg into <storage>/SAMP/.
//
//   apk:assets/data/handling.cfg   ->  <storage>/SAMP/handling.cfg
//
// All vehicle DFF/TXD assets (Azelow, Mercedes …) are baked directly into
// the player's gta3.img, so we no longer ship sidecar files in the APK.
// On upgrade we also actively delete any stale sidecars from previous
// versions to clean up the SAMP/ folder.
//
// We do NOT ship gta3.img inside the APK and we do NOT auto-inject. Auto
// extraction across launchers/OBB layouts proved unreliable, so we keep
// the APK small (~60 MB instead of 360 MB) and rely on the player to drop
// a custom gta3.img into <storage>/SAMP/ manually. The NvFOpen hook in
// game/hooks.cpp redirects all MODELS/GTA3.IMG opens to that file when
// it exists, otherwise it falls through to the original OBB image.
//
// Marker file ".azelow_v4.installed" prevents re-extraction on every
// launch; bumping AZELOW_PATCH_VERSION triggers a fresh copy on next start.
// We also write a human-readable diagnostic log to
// `<storage>/SAMP/.azelow_install.log` so a player or admin can verify the
// patch landed without needing logcat.
//
// This file is intentionally self-contained — JNI + AAssetManager + POSIX
// file I/O only.

#include <jni.h>
#include <android/asset_manager.h>
#include <android/asset_manager_jni.h>
#include <android/log.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <ctype.h>
#include <stdarg.h>

#define AZELOW_LOG_TAG       "AzelowAssetCopier"
#define AZELOW_PATCH_VERSION "v6"
#define IMG_SECTOR           2048

static FILE* g_diag = NULL;

static void DiagOpen(const char* sampDir)
{
    if (g_diag) return;
    char p[1024];
    snprintf(p, sizeof(p), "%s/.azelow_install.log", sampDir);
    g_diag = fopen(p, "w");
}
static void DiagClose(void) { if (g_diag) { fclose(g_diag); g_diag = NULL; } }
static void Diag(const char* fmt, ...)
{
    if (!g_diag) return;
    va_list ap; va_start(ap, fmt);
    vfprintf(g_diag, fmt, ap);
    va_end(ap);
    fputc('\n', g_diag);
    fflush(g_diag);
}

#define AZLOG(fmt, ...) \
    __android_log_print(ANDROID_LOG_INFO,  AZELOW_LOG_TAG, fmt, ##__VA_ARGS__)
#define AZLOGE(fmt, ...) \
    __android_log_print(ANDROID_LOG_ERROR, AZELOW_LOG_TAG, fmt, ##__VA_ARGS__)


// ---------------------------------------------------------------------------
// helpers

static void EnsureDir(const char* path)
{
    char tmp[1024];
    snprintf(tmp, sizeof(tmp), "%s", path);
    size_t len = strlen(tmp);
    if (len == 0) return;
    if (tmp[len-1] == '/') tmp[len-1] = '\0';
    for (char* p = tmp + 1; *p; ++p)
    {
        if (*p == '/')
        {
            *p = '\0';
            mkdir(tmp, 0755);
            *p = '/';
        }
    }
    mkdir(tmp, 0755);
}


static bool CopyAssetToPath(AAssetManager* mgr,
                            const char* assetName,
                            const char* destPath)
{
    AAsset* asset = AAssetManager_open(mgr, assetName, AASSET_MODE_STREAMING);
    if (!asset) { AZLOGE("asset not found: %s", assetName); return false; }

    FILE* out = fopen(destPath, "wb");
    if (!out) { AZLOGE("open dest failed: %s", destPath); AAsset_close(asset); return false; }

    char buf[64 * 1024]; int n; long total = 0;
    while ((n = AAsset_read(asset, buf, sizeof(buf))) > 0)
    {
        if (fwrite(buf, 1, n, out) != (size_t)n)
        { AZLOGE("write fail %s", destPath); fclose(out); AAsset_close(asset); return false; }
        total += n;
    }
    fclose(out); AAsset_close(asset);
    AZLOG("copied %s -> %s (%ld B)", assetName, destPath, total);
    return true;
}


// Read a whole asset into memory (caller frees). Returns size in `*outSize`.
static unsigned char* SlurpAsset(AAssetManager* mgr, const char* name, long* outSize)
{
    AAsset* a = AAssetManager_open(mgr, name, AASSET_MODE_BUFFER);
    if (!a) { AZLOGE("slurp: missing asset %s", name); return NULL; }
    long sz = AAsset_getLength(a);
    unsigned char* buf = (unsigned char*)malloc((size_t)sz);
    if (!buf) { AAsset_close(a); return NULL; }
    int n = AAsset_read(a, buf, (size_t)sz);
    AAsset_close(a);
    if (n != sz) { free(buf); AZLOGE("slurp %s short read", name); return NULL; }
    *outSize = sz;
    return buf;
}


static long RoundUp(long n, long m) { return ((n + m - 1) / m) * m; }


// Find the directory entry index whose 24-char name matches `target`
// (case-insensitive). Reads the gta3.img header + directory once.
//
// `count` will hold the total entry count on success.
// Returns the entry index, or -1 if not found.
static int FindEntry(FILE* img, const char* target, uint32_t* count)
{
    if (fseek(img, 0, SEEK_SET) != 0) return -1;

    char magic[4]; uint32_t cnt;
    if (fread(magic, 1, 4, img) != 4)            return -1;
    if (memcmp(magic, "VER2", 4) != 0)
    { AZLOGE("not VER2 IMG"); return -1; }
    if (fread(&cnt, 4, 1, img) != 1)             return -1;
    *count = cnt;

    for (uint32_t i = 0; i < cnt; ++i)
    {
        if (fseek(img, 8 + (long)i * 32, SEEK_SET) != 0) return -1;
        unsigned char rec[32];
        if (fread(rec, 1, 32, img) != 32)                return -1;

        // name is 24 bytes nul-padded ASCII at offset 8
        char name[25] = {0};
        memcpy(name, rec + 8, 24);
        // strip trailing junk
        for (int k = 0; k < 24; ++k) if (name[k] < 32 || name[k] > 126) { name[k] = 0; break; }

        // case-insensitive compare
        if (strcasecmp(name, target) == 0) return (int)i;
    }
    return -1;
}


// Append `payload` (sector-aligned) to the end of `img`, then patch the
// directory entry at `idx` to point to it. Returns true on success.
static bool InjectInto(FILE* img, int idx, const unsigned char* payload, long payloadSize)
{
    if (idx < 0 || !payload || payloadSize <= 0) return false;

    // pad current end to sector
    if (fseek(img, 0, SEEK_END) != 0) return false;
    long endPos = ftell(img);
    long aligned = RoundUp(endPos, IMG_SECTOR);
    if (aligned > endPos)
    {
        long pad = aligned - endPos;
        unsigned char zero[IMG_SECTOR] = {0};
        while (pad > 0)
        {
            long w = pad > IMG_SECTOR ? IMG_SECTOR : pad;
            if (fwrite(zero, 1, (size_t)w, img) != (size_t)w) return false;
            pad -= w;
        }
    }

    // remember start sector
    if (fseek(img, 0, SEEK_END) != 0) return false;
    long startBytes = ftell(img);
    if (startBytes % IMG_SECTOR != 0) return false;
    uint32_t startSector = (uint32_t)(startBytes / IMG_SECTOR);
    uint32_t sizeSectors = (uint32_t)(RoundUp(payloadSize, IMG_SECTOR) / IMG_SECTOR);

    // write payload + tail-pad
    if (fwrite(payload, 1, (size_t)payloadSize, img) != (size_t)payloadSize) return false;
    long rem = payloadSize % IMG_SECTOR;
    if (rem)
    {
        unsigned char zero[IMG_SECTOR] = {0};
        long tail = IMG_SECTOR - rem;
        if (fwrite(zero, 1, (size_t)tail, img) != (size_t)tail) return false;
    }

    // patch directory entry: offset (uint32) + streaming-size (uint16) +
    // archive-size (uint16). For our purposes, encode sizeSectors into the
    // streaming-size field and zero the archive-size field.
    if (fseek(img, 8 + (long)idx * 32, SEEK_SET) != 0) return false;
    uint32_t off = startSector;
    uint16_t s_stream = (uint16_t)sizeSectors;
    uint16_t s_arch   = 0;
    if (fwrite(&off,      4, 1, img) != 1) return false;
    if (fwrite(&s_stream, 2, 1, img) != 1) return false;
    if (fwrite(&s_arch,   2, 1, img) != 1) return false;
    fflush(img);

    AZLOG("injected idx=%d -> sector=%u size=%u (%ld B)",
          idx, startSector, sizeSectors, payloadSize);
    return true;
}


// Patch gta3.img with one asset under the given slot name.
//   slotName : e.g. "stallion.dff" — must match the existing directory entry
//   assetKey : asset path inside the APK, e.g. "data/stallion.dff"
static bool PatchSlot(FILE* img, AAssetManager* mgr,
                      const char* slotName, const char* assetKey)
{
    long sz = 0;
    unsigned char* buf = SlurpAsset(mgr, assetKey, &sz);
    if (!buf) return false;

    uint32_t count = 0;
    int idx = FindEntry(img, slotName, &count);
    if (idx < 0)
    { AZLOGE("entry %s not in gta3.img", slotName); free(buf); return false; }

    bool ok = InjectInto(img, idx, buf, sz);
    free(buf);
    return ok;
}


// ---------------------------------------------------------------------------
// public entry point

extern "C" void AzelowEnsureAssetsInstalled(JNIEnv* env, jobject thiz,
                                            const char* storagePath)
{
    if (!env || !thiz || !storagePath || !*storagePath)
    { AZLOGE("bad args"); return; }

    char sampDir[1024];
    snprintf(sampDir, sizeof(sampDir), "%sSAMP", storagePath);
    EnsureDir(sampDir);

    DiagOpen(sampDir);
    Diag("AzelowAssetCopier %s starting; storage=%s sampDir=%s",
         AZELOW_PATCH_VERSION, storagePath, sampDir);

    char marker[1024];
    snprintf(marker, sizeof(marker), "%s/.azelow_%s.installed",
             sampDir, AZELOW_PATCH_VERSION);
    if (access(marker, F_OK) == 0)
    { AZLOG("patch %s already installed", AZELOW_PATCH_VERSION);
      Diag("marker already exists, skipping: %s", marker);
      DiagClose(); return; }

    AZLOG("installing vehicle patch %s ...", AZELOW_PATCH_VERSION);
    Diag("no marker found, performing extraction");

    jclass    ctxCls    = env->GetObjectClass(thiz);
    jmethodID getAssets = env->GetMethodID(ctxCls, "getAssets",
                                           "()Landroid/content/res/AssetManager;");
    if (!getAssets)
    { AZLOGE("no getAssets()"); Diag("no getAssets() method");
      env->DeleteLocalRef(ctxCls); DiagClose(); return; }

    jobject jAssetMgr = env->CallObjectMethod(thiz, getAssets);
    AAssetManager* mgr = AAssetManager_fromJava(env, jAssetMgr);
    if (!mgr)
    { AZLOGE("AAssetManager NULL"); Diag("AAssetManager NULL");
      env->DeleteLocalRef(jAssetMgr); env->DeleteLocalRef(ctxCls);
      DiagClose(); return; }

    // 1) handling.cfg — straight copy (drives the 250 km/h top speed +
    //    AWD / traction tweaks on the STALLION slot).
    char destHdl[1024];
    snprintf(destHdl, sizeof(destHdl), "%s/handling.cfg", sampDir);
    bool okHdl = CopyAssetToPath(mgr, "data/handling.cfg", destHdl);
    Diag("handling.cfg copied: %d", okHdl);

    // 2) clean up any stale sidecar DFF/TXD left by older versions of the
    //    APK (v4..v5 used to ship them, v6+ no longer does).
    static const char* kStaleSidecars[] = {
        "stallion.dff", "stallion.txd",
        "huntley.dff",  "huntley.txd",
        "alpha.dff",    "alpha.txd",
    };
    for (size_t i = 0; i < sizeof(kStaleSidecars) / sizeof(kStaleSidecars[0]); ++i)
    {
        char p[1024];
        snprintf(p, sizeof(p), "%s/%s", sampDir, kStaleSidecars[i]);
        if (access(p, F_OK) == 0)
        {
            int r = remove(p);
            Diag("cleanup stale sidecar %s -> remove rc=%d", kStaleSidecars[i], r);
        }
    }

    // 3) gta3.img: leave alone. The launcher's NvFOpen hook already
    //    redirects MODELS/GTA3.IMG to <storage>/SAMP/gta3.img if and only
    //    if the player has placed a custom one there (manual install
    //    via the Crazy IMG Editor / inject_dff_txd.py route). Otherwise
    //    the OBB original is used and STALLION renders as the stock car.
    char destImg[1024];
    snprintf(destImg, sizeof(destImg), "%s/gta3.img", sampDir);
    if (access(destImg, R_OK) == 0)
        Diag("custom gta3.img already present at %s — launcher will use it",
             destImg);
    else
        Diag("no custom gta3.img at %s — launcher will use OBB original",
             destImg);

    if (okHdl)
    {
        FILE* m = fopen(marker, "w");
        if (m) { fputs(AZELOW_PATCH_VERSION, m); fclose(m); }
        AZLOG("vehicle patch %s installed", AZELOW_PATCH_VERSION);
        Diag("all good — marker dropped: %s", marker);
    }
    else
    {
        AZLOGE("patch incomplete (hdl=%d) — will retry", okHdl);
        Diag("NOT dropping marker (hdl=%d) — retrying next launch", okHdl);
    }

    env->DeleteLocalRef(jAssetMgr);
    env->DeleteLocalRef(ctxCls);
    DiagClose();
}
