// =============================================================================
//  HavanaRp — YouTube / Direct-stream Music Overlay implementation
//  Visual style adapted from samp-music-overlay/MusicPhone.tsx.
// =============================================================================

#include "../main.h"
#include "../game/RW/RenderWare.h"
#include "../game/game.h"
#include "../net/netgame.h"
#include "../chatwindow.h"
#include "ytmusicoverlay.h"
#include "gui.h"
#include "../util/CJavaWrapper.h"
#include "../vendor/imgui/imgui.h"
#include "../vendor/imgui/imgui_internal.h"
#include <cstdio>
#include <cstring>
#include <cstdlib>
#include <cmath>
#include <cctype>
#include <dlfcn.h>
#include <jni.h>
#include <pthread.h>
#include <vector>

extern CJavaWrapper* g_pJavaWrapper;

// ---- Bridge to netrpc.cpp ---------------------------------------------------
class CNetGame;
extern CNetGame* pNetGame;
void YtMusic_SendDialogResponse(uint16_t id, uint8_t btn, uint16_t listitem,
                                char* input);

// JavaVM is cached in main.cpp's `javaVM` global at JNI_OnLoad time.
extern JavaVM* javaVM;
static JavaVM* GetJVM() { return javaVM; }

CYtMusicOverlay* pYtMusicOverlay = nullptr;
extern CGUI* pGUI;

// ----- palette (purple / orange neon) ---------------------------------------
static const ImU32 kY_BgOuter  = IM_COL32( 14,  10,  28, 255);
static const ImU32 kY_BgPanel  = IM_COL32( 22,  16,  42, 248);
static const ImU32 kY_BgInner  = IM_COL32( 13,  10,  24, 255);
static const ImU32 kY_Border   = IM_COL32(255, 255, 255,  18);
static const ImU32 kY_Text     = IM_COL32(255, 255, 255, 240);
static const ImU32 kY_TextDim  = IM_COL32(255, 255, 255, 140);
static const ImU32 kY_TextSub  = IM_COL32(255, 255, 255,  92);
static const ImU32 kY_Accent1  = IM_COL32(255, 138,  76, 255); // orange
static const ImU32 kY_Accent2  = IM_COL32(255,  77, 109, 255); // pink
static const ImU32 kY_Accent3  = IM_COL32(193,  53, 132, 255); // purple
static const ImU32 kY_Accent4  = IM_COL32( 91,  42, 134, 255); // deep purple
static const ImU32 kY_Heart    = IM_COL32(255,  93, 143, 255);
static const ImU32 kY_Online   = IM_COL32( 74, 222, 128, 255);
static const ImU32 kY_BtnBg    = IM_COL32(255, 255, 255,  20);
static const ImU32 kY_BtnHover = IM_COL32(255, 255, 255,  35);

// ----- helpers ---------------------------------------------------------------
static void StripColors(const char* in, char* out, size_t len)
{
    size_t j = 0;
    for (size_t i = 0; in[i] && j + 1 < len; ++i)
    {
        if (in[i] == '{')
        {
            size_t k = i + 1;
            int    hexCount = 0;
            bool   isColor = true;
            while (in[k] && in[k] != '}' && (k - i) < 12)
            {
                char c = in[k];
                if (!((c>='0'&&c<='9')||(c>='A'&&c<='F')||(c>='a'&&c<='f')))
                { isColor = false; break; }
                hexCount++;
                k++;
            }
            if (isColor && in[k] == '}' && (hexCount == 6 || hexCount == 8))
            { i = k; continue; }
        }
        out[j++] = in[i];
    }
    out[j] = '\0';
}

static bool PointInRect(ImVec2 p, ImVec2 a, ImVec2 b)
{ return p.x >= a.x && p.x <= b.x && p.y >= a.y && p.y <= b.y; }

static bool PointInCircle(ImVec2 p, ImVec2 c, float r)
{
    float dx = p.x - c.x, dy = p.y - c.y;
    return (dx*dx + dy*dy) <= r*r;
}

static void FormatTime(double sec, char* out, size_t len)
{
    if (sec < 0 || !std::isfinite(sec)) { snprintf(out, len, "--:--"); return; }
    int s = (int)sec;
    int m = s / 60;
    s = s % 60;
    snprintf(out, len, "%d:%02d", m, s);
}

// ============================================================================
//  BASS bridge (mirrors houseguardaudio.cpp pattern, adds streaming calls)
// ============================================================================
namespace
{
    using BOOL_  = int;
    using DWORD_ = unsigned int;
    using QWORD_ = unsigned long long;

    struct BassNetApi
    {
        DWORD_ (*StreamCreateURL)(const char* url, DWORD_ offset, DWORD_ flags,
                                  void* proc, void* user);
        BOOL_  (*StreamFree)(DWORD_ handle);
        BOOL_  (*ChannelPlay)(DWORD_ handle, BOOL_ restart);
        BOOL_  (*ChannelPause)(DWORD_ handle);
        BOOL_  (*ChannelStop)(DWORD_ handle);
        DWORD_ (*ChannelIsActive)(DWORD_ handle);
        BOOL_  (*ChannelSetAttribute)(DWORD_ handle, DWORD_ attrib, float value);
        QWORD_ (*ChannelGetLength)(DWORD_ handle, DWORD_ mode);
        QWORD_ (*ChannelGetPosition)(DWORD_ handle, DWORD_ mode);
        BOOL_  (*ChannelSetPosition)(DWORD_ handle, QWORD_ pos, DWORD_ mode);
        double (*ChannelBytes2Seconds)(DWORD_ handle, QWORD_ pos);
        QWORD_ (*ChannelSeconds2Bytes)(DWORD_ handle, double pos);
        int    (*ErrorGetCode)();
        BOOL_  (*SetConfigPtr)(DWORD_ option, const void* value);

        // HTTPS bridge — needed because the libbass.so shipped with the
        // launcher was built without SSL (BASS_ERROR_SSL = 10 on every
        // googlevideo URL). We feed bytes from a JNI HttpsURLConnection
        // into BASS via the buffer-push file system.
        DWORD_ (*StreamCreateFileUser)(DWORD_ system, DWORD_ flags,
                                       void* procs, void* user);
        DWORD_ (*StreamPutFileData)(DWORD_ handle, const void* buf,
                                    DWORD_ length);
        // Same path used by `houseguardaudio.cpp` for in-memory file
        // playback.  We pre-download the entire response, then create a
        // memory-backed BASS stream so the decoder has full random access
        // (which the BUFFERPUSH path doesn't allow).  This bypasses
        // BASS_ERROR_FILEFORM (=41) errors on shipped libbass.so builds
        // that are picky about partial / streaming MP3 input.
        DWORD_ (*StreamCreateFile)(BOOL_ mem, const void* file,
                                   QWORD_ offset, QWORD_ length,
                                   DWORD_ flags);
    };
    static const DWORD_ BASS_CONFIG_NET_AGENT_   = 16;
    static const DWORD_ BASS_CONFIG_NET_TIMEOUT_ = 11;
    static const DWORD_ BASS_CONFIG_NET_PREBUF_  = 15;
    static const DWORD_ STREAMFILE_BUFFERPUSH_   = 2;
    static const DWORD_ BASS_FILEDATA_END_       = 0;
    static const DWORD_ BASS_STREAM_BLOCK_       = 0x100000;
    static const DWORD_ BASS_STREAM_AUTOFREE_X   = 0x40000;

    static BassNetApi g_bassNet = {};
    static bool       g_loaded     = false;
    static bool       g_loadFailed = false;

    static const DWORD_ BASS_ATTRIB_VOL_      = 2;
    static const DWORD_ BASS_POS_BYTE_        = 0;
    static const DWORD_ BASS_STREAM_AUTOFREE_ = 0x40000;
    static const DWORD_ BASS_ACTIVE_PLAYING_  = 1;
    static const DWORD_ BASS_ACTIVE_PAUSED_   = 3;
    static const DWORD_ BASS_ACTIVE_STALLED_  = 2;

    static bool LoadBass()
    {
        if (g_loaded) return true;
        if (g_loadFailed) return false;
        // libbass.so is loaded by the host process (libluxury), so we can
        // resolve symbols out of the existing image with RTLD_DEFAULT.
        // If that fails we fall back to dlopen("libbass.so").
        void* h = RTLD_DEFAULT;
#define RES(name) g_bassNet.name = (decltype(g_bassNet.name))dlsym(h, "BASS_" #name)
        RES(StreamCreateURL);
        if (!g_bassNet.StreamCreateURL)
        {
            h = dlopen("libbass.so", RTLD_NOW);
            if (!h) { g_loadFailed = true; return false; }
            RES(StreamCreateURL);
        }
        RES(StreamFree);
        RES(ChannelPlay);
        RES(ChannelPause);
        RES(ChannelStop);
        RES(ChannelIsActive);
        RES(ChannelSetAttribute);
        RES(ChannelGetLength);
        RES(ChannelGetPosition);
        RES(ChannelSetPosition);
        RES(ChannelBytes2Seconds);
        RES(ChannelSeconds2Bytes);
        RES(ErrorGetCode);
        RES(SetConfigPtr);
        RES(StreamCreateFileUser);
        RES(StreamPutFileData);
        RES(StreamCreateFile);
#undef RES
        if (!g_bassNet.StreamCreateURL || !g_bassNet.ChannelPlay)
        { g_loadFailed = true; return false; }
        g_loaded = true;
        return true;
    }
}

// ============================================================================
//  YouTube resolve helper
//  ---------------------------------------------------------------------------
//  Calls Cobalt API (https://co.wuk.sh/api/json) via Java-side
//  HttpsURLConnection through JNI. This avoids pulling mbedtls/openssl
//  into the C++ build. The response JSON is parsed with a tiny ad-hoc
//  matcher that looks for `"url"` and `"audio"` fields.
//
//  Runs on its own pthread so the main render loop stays at 60 fps.
// ============================================================================
namespace
{
    struct ResolveJob
    {
        char        ytUrl[512];
        std::string resolvedUrl;
        std::string streamUA;     // User-Agent BASS must use to fetch the URL
        std::string title;
        std::string artist;
        std::string error;
        volatile int done; // 0 in progress, 1 done, -1 fail
    };
    static ResolveJob* g_job = nullptr;
    static pthread_t   g_jobThread;

    // Tiny JSON value extractor: finds `"key"` and returns the string after
    // the next ':' up to the closing '"' (handles \" escapes minimally).
    static std::string JsonStr(const std::string& src, const char* key)
    {
        std::string needle = "\""; needle += key; needle += "\"";
        size_t p = src.find(needle);
        if (p == std::string::npos) return std::string();
        p = src.find(':', p);
        if (p == std::string::npos) return std::string();
        ++p;
        while (p < src.size() && (src[p]==' '||src[p]=='\t'||src[p]=='\n'))
            ++p;
        if (p >= src.size() || src[p] != '"') return std::string();
        ++p;
        std::string out;
        while (p < src.size() && src[p] != '"')
        {
            if (src[p] == '\\' && p + 1 < src.size())
            {
                char c = src[p+1];
                if (c == 'u' && p + 5 < src.size())
                {
                    // \uXXXX -> UTF-8. We need this for googlevideo URLs
                    // where InnerTube returns "&" as "\u0026".
                    auto hex = [&](size_t i) -> int {
                        char h = src[i];
                        if (h >= '0' && h <= '9') return h - '0';
                        if (h >= 'a' && h <= 'f') return 10 + h - 'a';
                        if (h >= 'A' && h <= 'F') return 10 + h - 'A';
                        return -1;
                    };
                    int h0=hex(p+2), h1=hex(p+3), h2=hex(p+4), h3=hex(p+5);
                    if (h0<0||h1<0||h2<0||h3<0) { out += c; p += 2; continue; }
                    unsigned cp = (h0<<12)|(h1<<8)|(h2<<4)|h3;
                    if (cp < 0x80)
                        out += (char)cp;
                    else if (cp < 0x800)
                    {
                        out += (char)(0xC0 | (cp >> 6));
                        out += (char)(0x80 | (cp & 0x3F));
                    }
                    else
                    {
                        out += (char)(0xE0 | (cp >> 12));
                        out += (char)(0x80 | ((cp >> 6) & 0x3F));
                        out += (char)(0x80 | (cp & 0x3F));
                    }
                    p += 6;
                    continue;
                }
                if (c=='n') out += '\n';
                else if (c=='t') out += '\t';
                else if (c=='r') out += '\r';
                else if (c=='/') out += '/';
                else out += c;
                p += 2;
            }
            else
            { out += src[p]; ++p; }
        }
        return out;
    }

    // Minimal HTTPS GET/POST via JNI -> java.net.URL+HttpsURLConnection.
    // Returns the response body, or empty string on error. If postBody is
    // null the request is a GET. On non-2xx the error stream is read so we
    // can surface real upstream messages instead of "getInputStream".
    static std::string HttpsRequest(const char* url, const char* postBody,
                                    std::string& errOut,
                                    const char* userAgent = nullptr,
                                    const char* extraHdr1Name = nullptr,
                                    const char* extraHdr1Val  = nullptr,
                                    const char* extraHdr2Name = nullptr,
                                    const char* extraHdr2Val  = nullptr,
                                    const char* extraHdr3Name = nullptr,
                                    const char* extraHdr3Val  = nullptr)
    {
        JavaVM* vm = GetJVM();
        if (!vm) { errOut = "no JVM"; return std::string(); }
        JNIEnv* env = nullptr;
        bool attached = false;
        int gerr = vm->GetEnv((void**)&env, JNI_VERSION_1_4);
        if (gerr == JNI_EDETACHED)
        {
            if (vm->AttachCurrentThread(&env, nullptr) != 0)
            { errOut = "attach failed"; return std::string(); }
            attached = true;
        }
        std::string result;
        do {
            jclass clsURL = env->FindClass("java/net/URL");
            jclass clsHC  = env->FindClass("javax/net/ssl/HttpsURLConnection");
            jclass clsOS  = env->FindClass("java/io/OutputStream");
            jclass clsIS  = env->FindClass("java/io/InputStream");
            jclass clsBR  = env->FindClass("java/io/BufferedReader");
            jclass clsISR = env->FindClass("java/io/InputStreamReader");
            jclass clsSB  = env->FindClass("java/lang/StringBuilder");
            jclass clsStr = env->FindClass("java/lang/String");
            if (!clsURL || !clsHC || !clsBR || !clsISR || !clsSB || !clsStr)
            { errOut = "find class"; break; }

            jmethodID mURL    = env->GetMethodID(clsURL, "<init>",
                                                 "(Ljava/lang/String;)V");
            jmethodID mOpen   = env->GetMethodID(clsURL, "openConnection",
                                                 "()Ljava/net/URLConnection;");
            jmethodID mSetMethod = env->GetMethodID(
                env->FindClass("java/net/HttpURLConnection"), "setRequestMethod",
                "(Ljava/lang/String;)V");
            jmethodID mSetDO  = env->GetMethodID(
                env->FindClass("java/net/URLConnection"), "setDoOutput", "(Z)V");
            jmethodID mSetCT  = env->GetMethodID(
                env->FindClass("java/net/URLConnection"), "setRequestProperty",
                "(Ljava/lang/String;Ljava/lang/String;)V");
            jmethodID mGetOS  = env->GetMethodID(
                env->FindClass("java/net/URLConnection"), "getOutputStream",
                "()Ljava/io/OutputStream;");
            jmethodID mGetIS  = env->GetMethodID(
                env->FindClass("java/net/URLConnection"), "getInputStream",
                "()Ljava/io/InputStream;");
            jclass clsHttp = env->FindClass("java/net/HttpURLConnection");
            jmethodID mGetCode = env->GetMethodID(clsHttp,
                "getResponseCode", "()I");
            jmethodID mGetErrS = env->GetMethodID(clsHttp,
                "getErrorStream", "()Ljava/io/InputStream;");
            jmethodID mWriteB = env->GetMethodID(clsOS, "write", "([B)V");
            jmethodID mFlush  = env->GetMethodID(clsOS, "flush", "()V");
            jmethodID mCloseO = env->GetMethodID(clsOS, "close", "()V");
            jmethodID mISRctor= env->GetMethodID(clsISR, "<init>",
                "(Ljava/io/InputStream;Ljava/lang/String;)V");
            jmethodID mBRctor = env->GetMethodID(clsBR, "<init>",
                "(Ljava/io/Reader;)V");
            jmethodID mReadL  = env->GetMethodID(clsBR, "readLine",
                "()Ljava/lang/String;");
            jmethodID mSBctor = env->GetMethodID(clsSB, "<init>", "()V");
            jmethodID mSBapp  = env->GetMethodID(clsSB, "append",
                "(Ljava/lang/String;)Ljava/lang/StringBuilder;");
            jmethodID mSBstr  = env->GetMethodID(clsSB, "toString",
                "()Ljava/lang/String;");
            jmethodID mGetBytes = env->GetMethodID(clsStr, "getBytes",
                "(Ljava/lang/String;)[B");
            jmethodID mSetCT2 = env->GetMethodID(
                env->FindClass("java/net/URLConnection"),
                "setConnectTimeout", "(I)V");
            jmethodID mSetRT  = env->GetMethodID(
                env->FindClass("java/net/URLConnection"),
                "setReadTimeout", "(I)V");

            jstring jurl  = env->NewStringUTF(url);
            jobject oURL  = env->NewObject(clsURL, mURL, jurl);
            if (env->ExceptionCheck())
            { env->ExceptionClear(); errOut = "URL ctor"; break; }
            jobject oCon  = env->CallObjectMethod(oURL, mOpen);
            if (env->ExceptionCheck())
            { env->ExceptionClear(); errOut = "openConnection"; break; }

            env->CallVoidMethod(oCon, mSetCT2, (jint)8000);
            env->CallVoidMethod(oCon, mSetRT,  (jint)15000);

            jstring jmeth = env->NewStringUTF(postBody ? "POST" : "GET");
            env->CallVoidMethod(oCon, mSetMethod, jmeth);
            env->DeleteLocalRef(jmeth);

            if (postBody)
            {
                jstring jct1 = env->NewStringUTF("Content-Type");
                jstring jct2 = env->NewStringUTF("application/json");
                env->CallVoidMethod(oCon, mSetCT, jct1, jct2);
                env->DeleteLocalRef(jct1); env->DeleteLocalRef(jct2);
            }
            jstring ja1 = env->NewStringUTF("Accept");
            jstring ja2 = env->NewStringUTF("application/json");
            env->CallVoidMethod(oCon, mSetCT, ja1, ja2);
            env->DeleteLocalRef(ja1); env->DeleteLocalRef(ja2);

            jstring jua1 = env->NewStringUTF("User-Agent");
            jstring jua2 = env->NewStringUTF(userAgent ? userAgent :
                "Mozilla/5.0 (Linux; Android 10; HavanaRP) "
                "AppleWebKit/537.36 (KHTML, like Gecko) "
                "Chrome/120.0.0.0 Mobile Safari/537.36");
            env->CallVoidMethod(oCon, mSetCT, jua1, jua2);
            env->DeleteLocalRef(jua1); env->DeleteLocalRef(jua2);

            // Optional per-call headers (X-YouTube-Client-Name, etc).
            const char* extras[6] = {
                extraHdr1Name, extraHdr1Val,
                extraHdr2Name, extraHdr2Val,
                extraHdr3Name, extraHdr3Val
            };
            for (int hi = 0; hi < 6; hi += 2)
            {
                if (!extras[hi] || !extras[hi+1]) continue;
                jstring jn = env->NewStringUTF(extras[hi]);
                jstring jv = env->NewStringUTF(extras[hi+1]);
                env->CallVoidMethod(oCon, mSetCT, jn, jv);
                env->DeleteLocalRef(jn); env->DeleteLocalRef(jv);
            }

            if (postBody)
            {
                env->CallVoidMethod(oCon, mSetDO, JNI_TRUE);
                jobject oOS = env->CallObjectMethod(oCon, mGetOS);
                if (env->ExceptionCheck())
                { env->ExceptionClear(); errOut = "getOutputStream"; break; }
                jstring jbody = env->NewStringUTF(postBody);
                jstring jenc  = env->NewStringUTF("UTF-8");
                jobject jbytes = env->CallObjectMethod(jbody, mGetBytes, jenc);
                env->DeleteLocalRef(jenc); env->DeleteLocalRef(jbody);
                env->CallVoidMethod(oOS, mWriteB, jbytes);
                env->CallVoidMethod(oOS, mFlush);
                env->CallVoidMethod(oOS, mCloseO);
                env->DeleteLocalRef(jbytes); env->DeleteLocalRef(oOS);
            }

            // Read the response body (success or error). On non-2xx
            // getInputStream throws; we then fall back to getErrorStream so
            // we can extract the upstream JSON error.
            jint code = env->CallIntMethod(oCon, mGetCode);
            if (env->ExceptionCheck())
            { env->ExceptionClear(); errOut = "getResponseCode"; break; }

            bool ok = (code >= 200 && code < 300);
            jobject oIS = nullptr;
            if (ok)
            {
                oIS = env->CallObjectMethod(oCon, mGetIS);
                if (env->ExceptionCheck()) { env->ExceptionClear(); oIS = nullptr; }
            }
            if (!oIS)
            {
                oIS = env->CallObjectMethod(oCon, mGetErrS);
                if (env->ExceptionCheck()) { env->ExceptionClear(); oIS = nullptr; }
            }
            if (!oIS)
            {
                char codeMsg[64]; snprintf(codeMsg, sizeof(codeMsg),
                                            "HTTP %d (no body)", (int)code);
                errOut = codeMsg;
                break;
            }
            jstring juenc = env->NewStringUTF("UTF-8");
            jobject oISR  = env->NewObject(clsISR, mISRctor, oIS, juenc);
            env->DeleteLocalRef(juenc);
            jobject oBR   = env->NewObject(clsBR, mBRctor, oISR);
            jobject oSB   = env->NewObject(clsSB, mSBctor);
            for (;;)
            {
                jstring jline = (jstring)env->CallObjectMethod(oBR, mReadL);
                if (!jline) break;
                env->CallObjectMethod(oSB, mSBapp, jline);
                env->DeleteLocalRef(jline);
            }
            jstring joined = (jstring)env->CallObjectMethod(oSB, mSBstr);
            const char* cs = env->GetStringUTFChars(joined, nullptr);
            if (cs) result = cs;
            env->ReleaseStringUTFChars(joined, cs);
            env->DeleteLocalRef(joined); env->DeleteLocalRef(oSB);
            env->DeleteLocalRef(oBR); env->DeleteLocalRef(oISR);
            env->DeleteLocalRef(oIS); env->DeleteLocalRef(oCon);
            env->DeleteLocalRef(oURL); env->DeleteLocalRef(jurl);

            if (!ok)
            {
                char codeMsg[64]; snprintf(codeMsg, sizeof(codeMsg),
                                            "HTTP %d", (int)code);
                errOut = codeMsg;
            }
        } while (false);

        if (attached) vm->DetachCurrentThread();
        return result;
    }

    // Convenience wrappers.
    static std::string HttpsGet(const char* url, std::string& errOut)
    { return HttpsRequest(url, nullptr, errOut); }
    static std::string HttpsPost(const char* url, const char* body,
                                 std::string& errOut)
    { return HttpsRequest(url, body, errOut); }

    // Extract the YouTube video ID from any YouTube/youtu.be/music URL.
    // Returns empty string if not recognised.
    static std::string ExtractVideoId(const char* url)
    {
        if (!url) return std::string();
        const char* p = strstr(url, "v=");
        if (p)
        {
            p += 2;
            std::string id;
            while (*p && *p != '&' && *p != '#' && id.size() < 16) id += *p++;
            return id;
        }
        p = strstr(url, "youtu.be/");
        if (p)
        {
            p += 9;
            std::string id;
            while (*p && *p != '?' && *p != '&' && *p != '#' && id.size() < 16)
                id += *p++;
            return id;
        }
        p = strstr(url, "/shorts/");
        if (p)
        {
            p += 8;
            std::string id;
            while (*p && *p != '?' && *p != '&' && *p != '#' && id.size() < 16)
                id += *p++;
            return id;
        }
        p = strstr(url, "/embed/");
        if (p)
        {
            p += 7;
            std::string id;
            while (*p && *p != '?' && *p != '&' && *p != '#' && id.size() < 16)
                id += *p++;
            return id;
        }
        return std::string();
    }

    // Tiny "find the audio stream URL" helper — Piped's /streams response
    // contains an `audioStreams` array with `url`, `mimeType`, `bitrate`
    // fields per stream. We pick the first audio/mp4 (m4a) stream, or
    // failing that, the first audio/* stream.
    static std::string PickAudioUrlFromPiped(const std::string& json)
    {
        size_t p = json.find("\"audioStreams\"");
        if (p == std::string::npos) return std::string();
        p = json.find('[', p);
        if (p == std::string::npos) return std::string();
        size_t end = json.find(']', p);
        if (end == std::string::npos) end = json.size();
        std::string arr = json.substr(p, end - p);

        // Prefer audio/mp4 (m4a) -> wider BASS support than webm/opus.
        size_t first = std::string::npos;
        size_t pref  = std::string::npos;
        size_t cur = 0;
        while (true)
        {
            size_t obj = arr.find('{', cur);
            if (obj == std::string::npos) break;
            size_t obend = arr.find('}', obj);
            if (obend == std::string::npos) break;
            std::string item = arr.substr(obj, obend - obj + 1);
            if (item.find("\"audio") == std::string::npos) { cur = obend+1; continue; }
            if (first == std::string::npos) first = obj;
            if (item.find("audio/mp4")    != std::string::npos ||
                item.find("audio/webm; codecs=\\\"opus\\\"") != std::string::npos)
            {
                pref = obj;
            }
            cur = obend + 1;
        }
        size_t pick = (pref != std::string::npos) ? pref :
                      (first != std::string::npos) ? first : std::string::npos;
        if (pick == std::string::npos) return std::string();
        size_t obend = arr.find('}', pick);
        std::string item = arr.substr(pick, obend - pick + 1);
        return JsonStr(item, "url");
    }

    // ------------------------------------------------------------------
    // Approach: call YouTube's own InnerTube /youtubei/v1/player endpoint
    // directly from the device. This is what the official YouTube/YouTube
    // Music apps do, so YouTube's bot-detection rarely blocks residential
    // mobile IPs (which is what the player's phone has). We try multiple
    // "embedded player" clients in order — at least one usually returns a
    // pre-signed audio URL that BASS can stream straight away.
    //
    // If every InnerTube client gets bounced (LOGIN_REQUIRED, etc.) we
    // fall through to the last few open Piped instances as a courtesy.
    // ------------------------------------------------------------------
    struct InnerTubeClient
    {
        const char* clientName;
        const char* clientVersion;
        const char* userAgent;
        int         clientNumber;   // X-YouTube-Client-Name header
        bool        sendThirdParty; // embed clients need thirdParty.embedUrl
    };

    static const InnerTubeClient kIT[] = {
        // ANDROID_VR — currently the most permissive for anonymous music.
        { "ANDROID_VR",            "1.62.27",
          "com.google.android.apps.youtube.vr.oculus/1.62.27 "
          "(Linux; U; Android 12L; eureka-user Build/SQ3A.220605.009.A1)",
          28, false },
        // ANDROID_MUSIC — YT Music Android. Bypasses many copyright blocks
        // that hit the regular video clients.
        { "ANDROID_MUSIC",         "7.27.52",
          "com.google.android.apps.youtube.music/7.27.52 "
          "(Linux; U; Android 14; SM-S928B Build/UP1A.231005.007)",
          21, false },
        // IOS_MUSIC — iOS YouTube Music. Same idea, often serves when
        // ANDROID_MUSIC is throttled.
        { "IOS_MUSIC",             "7.27.0",
          "com.google.ios.youtubemusic/7.27.0 (iPhone16,2; U; CPU iOS 18_3 "
          "like Mac OS X; en_US)",
          26, false },
        // WEB_REMIX — desktop YouTube Music client. Returns clean
        // adaptiveFormats with URLs even for age-gated music.
        { "WEB_REMIX",             "1.20240403.01.00",
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
          "AppleWebKit/537.36 (KHTML, like Gecko) "
          "Chrome/123.0.0.0 Safari/537.36",
          67, false },
        // IOS — historically worked well; YouTube has narrowed it but we try.
        { "IOS",                   "20.10.4",
          "com.google.ios.youtube/20.10.4 (iPhone16,2; U; CPU iOS 18_3_2 "
          "like Mac OS X; en_US)",
          5, false },
        // ANDROID_TESTSUITE — sometimes returns formats other clients don't.
        { "ANDROID_TESTSUITE",     "1.9",
          "com.google.android.youtube/1.9 (Linux; U; Android 14)",
          30, false },
        // MWEB — mobile-web client; lighter checks than WEB.
        { "MWEB",                  "2.20240726.00.00",
          "Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) "
          "AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 "
          "Mobile/15E148 Safari/604.1",
          2, false },
        // TVHTML5_SIMPLY_EMBEDDED_PLAYER — embeds, useful for age-restricted.
        { "TVHTML5_SIMPLY_EMBEDDED_PLAYER", "2.0",
          "Mozilla/5.0",
          85, true },
        // WEB_EMBEDDED_PLAYER — last-ditch web fallback.
        { "WEB_EMBEDDED_PLAYER",   "1.20240731.00.00",
          "Mozilla/5.0",
          56, true },
        { nullptr, nullptr, nullptr, 0, false }
    };

    // Pick the highest-bitrate audio adaptiveFormat that has a usable
    // (non-ciphered) `url` field. Returns empty if none.
    static std::string PickAudioUrlFromInnerTube(const std::string& json,
                                                 std::string* outMime)
    {
        size_t p = json.find("\"adaptiveFormats\"");
        if (p == std::string::npos) return std::string();
        p = json.find('[', p);
        if (p == std::string::npos) return std::string();

        // Walk the array and pick the highest-bitrate audio that:
        //  (a) has a usable `url` (no signatureCipher we'd need JS for), and
        //  (b) is in audio/mp4 (m4a/AAC) — BASS's built-in network reader
        //      handles AAC/MP4 reliably, but webm/opus needs an extra
        //      plugin we don't ship. We fall back to webm only if no m4a
        //      stream is available at all.
        std::string bestM4aUrl,  bestM4aMime;  long long bestM4aBr  = -1;
        std::string bestAnyUrl,  bestAnyMime;  long long bestAnyBr  = -1;
        size_t depth = 0;
        size_t objStart = std::string::npos;
        for (size_t i = p; i < json.size(); ++i)
        {
            char c = json[i];
            if (c == '{')
            {
                if (depth == 0) objStart = i;
                ++depth;
            }
            else if (c == '}')
            {
                --depth;
                if (depth == 0 && objStart != std::string::npos)
                {
                    std::string item = json.substr(objStart, i - objStart + 1);
                    objStart = std::string::npos;
                    std::string mime = JsonStr(item, "mimeType");
                    if (mime.find("audio") == std::string::npos) continue;
                    std::string url  = JsonStr(item, "url");
                    if (url.empty()) continue;     // signatureCipher form
                    // Bitrate is a JSON number; quick scan.
                    long long br = 0;
                    size_t bpos = item.find("\"bitrate\"");
                    if (bpos != std::string::npos)
                    {
                        bpos = item.find(':', bpos);
                        if (bpos != std::string::npos)
                        {
                            ++bpos;
                            while (bpos < item.size() &&
                                   (item[bpos]==' '||item[bpos]=='\t'))
                                ++bpos;
                            br = atoll(item.c_str()+bpos);
                        }
                    }
                    bool isM4a = (mime.find("audio/mp4") != std::string::npos);
                    if (isM4a)
                    {
                        if (br > bestM4aBr)
                        { bestM4aBr = br; bestM4aUrl = url; bestM4aMime = mime; }
                    }
                    if (br > bestAnyBr)
                    { bestAnyBr = br; bestAnyUrl = url; bestAnyMime = mime; }
                }
            }
            else if (c == ']' && depth == 0)
                break;
        }
        if (!bestM4aUrl.empty())
        { if (outMime) *outMime = bestM4aMime; return bestM4aUrl; }
        if (outMime) *outMime = bestAnyMime;
        return bestAnyUrl;
    }

    // Build the InnerTube POST body for a given client + video id.
    static std::string BuildInnerTubeBody(const InnerTubeClient& c,
                                          const std::string& vid)
    {
        std::string body;
        body.reserve(512);
        body += "{\"videoId\":\""; body += vid; body += "\",\"context\":";
        body += "{\"client\":{\"clientName\":\"";
        body += c.clientName;
        body += "\",\"clientVersion\":\"";
        body += c.clientVersion;
        body += "\",\"hl\":\"en\",\"gl\":\"US\"";
        if (strcmp(c.clientName, "ANDROID_VR") == 0)
            body += ",\"androidSdkVersion\":32,\"osName\":\"Android\","
                    "\"osVersion\":\"12L\"";
        else if (strcmp(c.clientName, "ANDROID_MUSIC") == 0)
            body += ",\"androidSdkVersion\":34,\"osName\":\"Android\","
                    "\"osVersion\":\"14\",\"deviceMake\":\"samsung\","
                    "\"deviceModel\":\"SM-S928B\"";
        else if (strcmp(c.clientName, "IOS") == 0)
            body += ",\"deviceMake\":\"Apple\",\"deviceModel\":\"iPhone16,2\","
                    "\"osName\":\"iOS\",\"osVersion\":\"18.3.2.22D82\"";
        else if (strcmp(c.clientName, "IOS_MUSIC") == 0)
            body += ",\"deviceMake\":\"Apple\",\"deviceModel\":\"iPhone16,2\","
                    "\"osName\":\"iOS\",\"osVersion\":\"18.3.0.22D60\"";
        else if (strcmp(c.clientName, "ANDROID_TESTSUITE") == 0)
            body += ",\"androidSdkVersion\":34";
        else if (strcmp(c.clientName, "MWEB") == 0)
            body += ",\"deviceMake\":\"Apple\",\"deviceModel\":\"iPhone\","
                    "\"osName\":\"iOS\",\"osVersion\":\"16.6.0.20G75\","
                    "\"platform\":\"MOBILE\"";
        else if (strcmp(c.clientName, "WEB_REMIX") == 0)
            body += ",\"platform\":\"DESKTOP\","
                    "\"originalUrl\":\"https://music.youtube.com/\"";
        body += "}";
        if (c.sendThirdParty)
            body += ",\"thirdParty\":{\"embedUrl\":\"https://www.youtube.com/\"}";
        body += "},\"playbackContext\":{\"contentPlaybackContext\":"
                "{\"html5Preference\":\"HTML5_PREF_WANTS\"}},"
                "\"racyCheckOk\":true,\"contentCheckOk\":true}";
        return body;
    }

    // Last-ditch Piped fallback. Most public Piped instances are gone but
    // a couple are still online; if we got blocked by InnerTube we try
    // them so the user is never stuck.
    static const char* kPipedHosts[] = {
        "https://api.piped.private.coffee",
        "https://pipedapi.in.projectsegfau.lt",
        "https://pipedapi.kavin.rocks",
        nullptr
    };

    static void* ResolveThreadFn(void* arg)
    {
        ResolveJob* job = (ResolveJob*)arg;
        if (!job) return nullptr;

        std::string vid = ExtractVideoId(job->ytUrl);
        if (vid.empty())
        {
            job->error = "Bad YouTube URL";
            job->done = -1;
            return nullptr;
        }

        std::string lastErr;
        std::string firstReason;     // first non-empty playabilityStatus.reason
        int triedCount = 0;
        std::string seenTitle;
        std::string seenAuthor;

        // 0) HavanaRP relay — the proxy runs yt-dlp on the server side AND
        //    streams the audio bytes back to the launcher.  We deliberately
        //    bypass the JSON `/extract` endpoint and hand BASS the relay's
        //    `/stream?url=<id>` URL: googlevideo's signed URLs are bound to
        //    the requesting IP, so resolving on the relay then fetching
        //    from the phone fails with HTTP 403.  Streaming through the
        //    relay keeps the egress IP stable.
        //
        //    We still call `/extract` first to capture title/artist for the
        //    overlay UI (cheap; the relay caches the resolution for 30 min)
        //    and to confirm the video is actually playable before BASS
        //    spends time on the streaming URL.
        {
            std::string relayErr;
            char metaUrl[256];
            snprintf(metaUrl, sizeof(metaUrl),
                     "https://yt-proxy-jsqytjvy.fly.dev/extract?url=%s",
                     vid.c_str());
            std::string metaResp = HttpsGet(metaUrl, relayErr);
            if (relayErr.empty() && !metaResp.empty()
                && !JsonStr(metaResp, "url").empty())
            {
                std::string title  = JsonStr(metaResp, "title");
                std::string author = JsonStr(metaResp, "artist");
                char streamUrl[256];
                snprintf(streamUrl, sizeof(streamUrl),
                         "https://yt-proxy-jsqytjvy.fly.dev/stream?url=%s",
                         vid.c_str());
                job->resolvedUrl = streamUrl;
                // The relay terminates the googlevideo TLS itself; the
                // phone only needs a generic UA when talking to the relay.
                job->streamUA = "HavanaRP-launcher/1.0";
                if (!title.empty())  job->title  = title;
                if (!author.empty()) job->artist = author;
                job->done = 1;
                return nullptr;
            }
            if (!relayErr.empty())
                lastErr = "relay: " + relayErr;
            else if (!metaResp.empty())
            {
                std::string detail = JsonStr(metaResp, "detail");
                if (!detail.empty()) lastErr = "relay: " + detail;
            }
        }

        // 1) InnerTube clients — direct YouTube call, residential IP.
        for (int i = 0; kIT[i].clientName; ++i)
        {
            ++triedCount;
            std::string body = BuildInnerTubeBody(kIT[i], vid);
            const char* ep = "https://www.youtube.com/youtubei/v1/player?"
                             "key=AIzaSyA8eiZmM1FaDVjRy-df2KTyQ_vz_yYM39w&"
                             "prettyPrint=false";
            std::string err;
            char clientNum[8];
            snprintf(clientNum, sizeof(clientNum), "%d", kIT[i].clientNumber);
            std::string resp = HttpsRequest(
                ep, body.c_str(), err,
                kIT[i].userAgent,
                "X-YouTube-Client-Name",    clientNum,
                "X-YouTube-Client-Version", kIT[i].clientVersion,
                "Origin",                   "https://www.youtube.com");
            if (!err.empty() && resp.empty())
            { lastErr = std::string(kIT[i].clientName) + ": " + err; continue; }
            // Successful HTTP — parse out an audio URL.
            std::string mime;
            std::string url = PickAudioUrlFromInnerTube(resp, &mime);
            if (!url.empty())
            {
                std::string title  = JsonStr(resp, "title");
                std::string author = JsonStr(resp, "author");
                if (title.empty())  title  = JsonStr(resp, "videoTitle");
                if (author.empty()) author = JsonStr(resp, "channelName");
                job->resolvedUrl = url;
                // BASS must request the URL with the SAME User-Agent that
                // we used for InnerTube — googlevideo binds the URL to the
                // requesting client and returns 403 otherwise.
                job->streamUA = kIT[i].userAgent
                                ? kIT[i].userAgent : "";
                if (!title.empty())  job->title  = title;
                if (!author.empty()) job->artist = author;
                job->done = 1;
                return nullptr;
            }
            // Couldn't pick a URL — capture the upstream reason and any
            // metadata so the UI can still show the song info.
            std::string status = JsonStr(resp, "status");
            std::string reason = JsonStr(resp, "reason");
            std::string ttl    = JsonStr(resp, "title");
            if (ttl.empty())   ttl = JsonStr(resp, "videoTitle");
            std::string aut    = JsonStr(resp, "author");
            if (aut.empty())   aut = JsonStr(resp, "channelName");
            if (seenTitle.empty()  && !ttl.empty()) seenTitle  = ttl;
            if (seenAuthor.empty() && !aut.empty()) seenAuthor = aut;
            if (!reason.empty())
                lastErr = std::string(kIT[i].clientName) + ": " + reason;
            else if (!status.empty())
                lastErr = std::string(kIT[i].clientName) + ": " + status;
            else
                lastErr = std::string(kIT[i].clientName) + ": no audio URL";
            if (firstReason.empty() && !reason.empty())
                firstReason = reason;
        }

        // 2) Piped fallback (mostly aspirational at this point).
        for (int i = 0; kPipedHosts[i]; ++i)
        {
            char ep[256];
            snprintf(ep, sizeof(ep), "%s/streams/%s",
                     kPipedHosts[i], vid.c_str());
            std::string err;
            std::string resp = HttpsGet(ep, err);
            if (!err.empty() || resp.empty()) continue;
            std::string audioUrl = PickAudioUrlFromPiped(resp);
            if (audioUrl.empty()) continue;
            std::string title  = JsonStr(resp, "title");
            std::string author = JsonStr(resp, "uploader");
            job->resolvedUrl = audioUrl;
            if (!title.empty())  job->title  = title;
            if (!author.empty()) job->artist = author;
            job->done = 1;
            return nullptr;
        }

        // Surface the title we collected even if every client refused the
        // stream — the UI looks much friendlier when the song name shows
        // alongside the explanation.
        if (!seenTitle.empty())  job->title  = seenTitle;
        if (!seenAuthor.empty()) job->artist = seenAuthor;
        char trail[64];
        snprintf(trail, sizeof(trail), " (tried %d clients)", triedCount);
        std::string composed;
        if (!firstReason.empty())
            composed = firstReason;        // YouTube's own human reason
        else if (!lastErr.empty())
            composed = lastErr;
        else
            composed = "YouTube blocked anonymous access";
        composed += trail;
        job->error = composed;
        job->done = -1;
        return nullptr;
    }
}

// ============================================================================
//  CYtMusicOverlay
// ============================================================================
CYtMusicOverlay::CYtMusicOverlay()
    : m_state(YTM_HIDDEN), m_streamState(YTM_S_IDLE), m_dialogId(0),
      m_animT(0.0f), m_lastFrameTime(0.0f),
      m_inputFocused(false),
      m_streamHandle(0), m_volume(0.62f), m_loop(false),
      m_shuffle(false), m_liked(false),
      m_top10Open(false), m_top10LoadState(0),
      m_top10ThreadStarted(false), m_top10Scroll(0.0f), m_top10NowIdx(0)
{
    m_inputUrl[0] = '\0';
}

CYtMusicOverlay::~CYtMusicOverlay()
{
    StopStream();
}

bool CYtMusicOverlay::TryHandleDialog(uint16_t dialogId, uint8_t /*style*/,
                                      const char* title, const char* body)
{
    if (!title) return false;
    char tclean[128];
    StripColors(title, tclean, sizeof(tclean));
    if (strncmp(tclean, "HAVANA_YTMUSIC", 14) != 0) return false;

    m_dialogId = dialogId;
    // Body may carry a pre-filled URL; drop color tags first.
    char bclean[1024];
    StripColors(body ? body : "", bclean, sizeof(bclean));
    Show(bclean);

    // Auto-cancel the stock dialog so SA-MP doesn't draw it underneath.
    YtMusic_SendDialogResponse(dialogId, 0, 0, (char*)"");
    return true;
}

void CYtMusicOverlay::Show(const char* prefilledUrl)
{
    m_state = YTM_OPEN;
    m_animT = 0.0f;
    m_inputFocused = false;
    if (prefilledUrl && *prefilledUrl)
    {
        // Trim leading whitespace / leftover tabs.
        const char* p = prefilledUrl;
        while (*p == ' ' || *p == '\t' || *p == '\r' || *p == '\n') ++p;
        snprintf(m_inputUrl, sizeof(m_inputUrl), "%s", p);
        // Strip trailing whitespace.
        size_t n = strlen(m_inputUrl);
        while (n > 0 && (m_inputUrl[n-1]==' '||m_inputUrl[n-1]=='\n'||
                         m_inputUrl[n-1]=='\r'||m_inputUrl[n-1]=='\t'))
            m_inputUrl[--n] = '\0';
    }
    // Pre-fetch the curated Top 10 list in the background so it's ready
    // to render the moment the user taps the TOP 10 tab.
    if (m_top10LoadState == 0)
        StartLoadTop10();
}

// ----- Top 10 -------------------------------------------------------------
//
// We hit `https://yt-proxy-jsqytjvy.fly.dev/top10/list` once per overlay
// open (cached for the lifetime of the launcher).  The relay bakes 10
// pre-resolved m4a files into its container, so playback is immune to
// YouTube's "Sign in to confirm you're not a bot" wall.

void* CYtMusicOverlay::Top10ThreadFn(void* arg)
{
    CYtMusicOverlay* self = (CYtMusicOverlay*)arg;
    if (!self) return nullptr;
    std::string err;
    std::string body = HttpsGet(
        "https://yt-proxy-jsqytjvy.fly.dev/top10/list", err);
    if (!err.empty() || body.empty())
    {
        self->m_top10LoadState = -1;
        return nullptr;
    }
    // Parse the JSON array — we expect 10 small objects with idx / title /
    // artist / duration.  We re-use the JsonStr helper by walking object
    // boundaries manually since the array is simple and well-formed.
    std::vector<Top10Entry> tmp;
    size_t pos = 0;
    while (pos < body.size())
    {
        size_t ob = body.find('{', pos);
        if (ob == std::string::npos) break;
        int depth = 1;
        size_t oe = ob + 1;
        for (; oe < body.size(); ++oe)
        {
            char c = body[oe];
            if (c == '{') ++depth;
            else if (c == '}') { if (--depth == 0) break; }
        }
        if (oe >= body.size()) break;
        std::string item = body.substr(ob, oe - ob + 1);
        Top10Entry e;
        std::string idxs = JsonStr(item, "idx");
        std::string durs = JsonStr(item, "duration");
        // JsonStr only handles string values; idx / duration come back as
        // bare ints.  Pull them with a tiny scan instead.
        auto bareInt = [&](const char* key) -> int {
            std::string n = "\""; n += key; n += "\"";
            size_t kp = item.find(n);
            if (kp == std::string::npos) return 0;
            kp = item.find(':', kp);
            if (kp == std::string::npos) return 0;
            ++kp;
            while (kp < item.size() && (item[kp]==' '||item[kp]=='\t'))
                ++kp;
            int sign = 1, val = 0;
            if (kp < item.size() && item[kp] == '-') { sign = -1; ++kp; }
            while (kp < item.size() && item[kp] >= '0' && item[kp] <= '9')
            { val = val*10 + (item[kp]-'0'); ++kp; }
            return sign*val;
        };
        e.idx      = bareInt("idx");
        e.duration = bareInt("duration");
        e.title    = JsonStr(item, "title");
        e.artist   = JsonStr(item, "artist");
        if (e.idx > 0 && !e.title.empty()) tmp.push_back(e);
        pos = oe + 1;
    }
    self->m_top10Tracks = tmp;
    self->m_top10LoadState = tmp.empty() ? -1 : 2;
    return nullptr;
}

void CYtMusicOverlay::StartLoadTop10()
{
    if (m_top10LoadState == 1 || m_top10LoadState == 2) return;
    m_top10LoadState = 1;
    if (m_top10ThreadStarted)
        pthread_join(m_top10Thread, nullptr);
    m_top10ThreadStarted = true;
    pthread_create(&m_top10Thread, nullptr, &CYtMusicOverlay::Top10ThreadFn,
                   this);
}

void CYtMusicOverlay::PlayTop10(int idx)
{
    const Top10Entry* e = nullptr;
    for (size_t i = 0; i < m_top10Tracks.size(); ++i)
        if (m_top10Tracks[i].idx == idx) { e = &m_top10Tracks[i]; break; }
    if (!e) return;
    char streamUrl[160];
    snprintf(streamUrl, sizeof(streamUrl),
             "https://yt-proxy-jsqytjvy.fly.dev/top10/%d", idx);
    m_title       = e->title;
    m_artist      = e->artist;
    m_resolvedUrl = streamUrl;
    m_top10NowIdx = idx;
    // Reset the URL input so the overlay doesn't show the previous link
    // alongside the now-playing track from the playlist.
    m_inputUrl[0] = '\0';
    StartStream(streamUrl, "HavanaRP-launcher/1.0");
    m_top10Open = false;     // collapse panel and show the player

    // Tell the server we started a track so it can re-broadcast the
    // [HAV_YTM]PLAY:<pid>:<idx> message to every other client.  Their
    // launchers will spawn a remote stream attenuated by distance.
    NotifyServerPlay(idx);
}

void CYtMusicOverlay::Hide()
{
    if (m_state == YTM_HIDDEN) return;
    m_state = YTM_HIDDEN;
    m_animT = 0.0f;
    // Note: we deliberately do NOT stop playback on Hide so the user can
    // close the overlay and keep the audio rolling in the background.
}

bool CYtMusicOverlay::IsYouTubeUrl(const char* url)
{
    if (!url) return false;
    return (strstr(url, "youtube.com")     != nullptr) ||
           (strstr(url, "youtu.be")        != nullptr) ||
           (strstr(url, "music.youtube")   != nullptr);
}

bool CYtMusicOverlay::EnsureBassLoaded()
{
    return LoadBass();
}

// ============================================================================
//  HTTPS-bridge streaming
//  ---------------------------------------------------------------------------
//  The libbass.so shipped with the launcher was built without SSL/TLS
//  (BASS_ERROR_SSL = 10 on every https URL), so BASS_StreamCreateURL
//  cannot fetch googlevideo content directly.  We work around it by
//  downloading the bytes ourselves through Java's HttpsURLConnection
//  (proven to work for the InnerTube call) and feeding them to BASS via
//  the buffer-push file system (BASS_StreamCreateFileUser +
//  BASS_StreamPutFileData).
// ============================================================================
namespace
{
    struct HttpsBridge
    {
        std::string url;
        std::string ua;
        DWORD_      handle;          // BASS stream handle (0 until ready)
        volatile int state;          // 0 = connecting, 1 = playing,
                                     // 2 = error, 3 = stopping
        std::string error;
        float       volume;
        pthread_t   thread;
        // Backing memory for the in-memory BASS stream.  Must outlive
        // the BASS handle, so we keep it on the bridge struct rather than
        // on the thread stack.
        std::vector<unsigned char> data;
    };
    static HttpsBridge* g_bridge = nullptr;

    // Dummy callbacks — STREAMFILE_BUFFERPUSH never invokes read/seek/length
    // for media playback, but BASS still wants the struct to be non-null.
    static void  Bridge_Close (void* /*u*/)           {}
    static QWORD_ Bridge_Length(void* /*u*/)          { return 0; }
    static DWORD_ Bridge_Read  (void* /*b*/, DWORD_ l, void* /*u*/) { return 0; }
    static int   Bridge_Seek  (QWORD_ /*o*/, void* /*u*/) { return 0; }

    struct BridgeFileProcs
    {
        void*  close;
        void*  length;
        void*  read;
        void*  seek;
    };

    // Producer thread: opens an HTTPS connection, creates the BASS stream
    // once enough data has been prebuffered, then keeps pushing chunks
    // until EOF or stop.
    static void* HttpsBridgeThread(void* arg)
    {
        HttpsBridge* br = (HttpsBridge*)arg;
        JavaVM* vm = javaVM;
        if (!vm) { br->error = "no JVM"; br->state = 2; return nullptr; }
        JNIEnv* env = nullptr;
        bool attached = false;
        if (vm->GetEnv((void**)&env, JNI_VERSION_1_4) == JNI_EDETACHED)
        {
            if (vm->AttachCurrentThread(&env, nullptr) != 0)
            { br->error = "attach failed"; br->state = 2; return nullptr; }
            attached = true;
        }

        DWORD_ handle = 0;
        const size_t kPrebufBytes = 96 * 1024;     // unused (memory mode)
        const size_t kReadChunk   = 32 * 1024;
        const char*  errMsg       = nullptr;
        std::string  detailedErr;                  // surfaced when set

        // ----- Java-side: open URL, set headers, get InputStream
        // (mirrors the InnerTube HttpsRequest path so we can surface real
        //  HTTP error codes / Java exception text instead of a bare
        //  "getInputStream").
        jobject oCon = nullptr;
        jobject oIn  = nullptr;
        do {
            jclass clsURL  = env->FindClass("java/net/URL");
            jclass clsCon  = env->FindClass("java/net/URLConnection");
            jclass clsHttp = env->FindClass("java/net/HttpURLConnection");
            jclass clsIS   = env->FindClass("java/io/InputStream");
            jclass clsThr  = env->FindClass("java/lang/Throwable");
            jclass clsBA   = env->FindClass("java/io/ByteArrayOutputStream");
            if (!clsURL || !clsCon || !clsHttp || !clsIS || !clsThr || !clsBA)
            { errMsg = "find class"; break; }

            jmethodID mURL    = env->GetMethodID(clsURL, "<init>",
                                                  "(Ljava/lang/String;)V");
            jmethodID mOpen   = env->GetMethodID(clsURL, "openConnection",
                                                  "()Ljava/net/URLConnection;");
            jmethodID mSetCT  = env->GetMethodID(clsCon, "setConnectTimeout",
                                                  "(I)V");
            jmethodID mSetRT  = env->GetMethodID(clsCon, "setReadTimeout",
                                                  "(I)V");
            jmethodID mSetRP  = env->GetMethodID(clsCon, "setRequestProperty",
                                                  "(Ljava/lang/String;Ljava/lang/String;)V");
            jmethodID mGetIS  = env->GetMethodID(clsCon, "getInputStream",
                                                  "()Ljava/io/InputStream;");
            jmethodID mSetUC  = env->GetMethodID(clsCon, "setUseCaches",
                                                  "(Z)V");
            jmethodID mSetMethod = env->GetMethodID(clsHttp,
                "setRequestMethod", "(Ljava/lang/String;)V");
            jmethodID mSetFR  = env->GetMethodID(clsHttp,
                "setInstanceFollowRedirects", "(Z)V");
            jmethodID mGetCode = env->GetMethodID(clsHttp,
                "getResponseCode", "()I");
            jmethodID mGetMsg  = env->GetMethodID(clsHttp,
                "getResponseMessage", "()Ljava/lang/String;");
            jmethodID mGetErrS = env->GetMethodID(clsHttp,
                "getErrorStream", "()Ljava/io/InputStream;");
            jmethodID mDisc    = env->GetMethodID(clsHttp,
                "disconnect", "()V");
            jmethodID mRead    = env->GetMethodID(clsIS, "read", "([B)I");
            jmethodID mClose   = env->GetMethodID(clsIS, "close", "()V");
            jmethodID mThrMsg  = env->GetMethodID(clsThr, "getMessage",
                                                  "()Ljava/lang/String;");
            jmethodID mThrCls  = env->GetMethodID(clsThr, "toString",
                                                  "()Ljava/lang/String;");

            // Helper: pull the (already-thrown) exception's message into a
            // C++ string and clear the JNI exception state.
            auto captureThrowable = [&](const char* fallback) -> std::string {
                jthrowable t = env->ExceptionOccurred();
                env->ExceptionClear();
                if (!t) return fallback ? fallback : "";
                jstring js = (jstring)env->CallObjectMethod(t, mThrMsg);
                std::string out;
                if (js) {
                    const char* cs = env->GetStringUTFChars(js, nullptr);
                    if (cs) { out = cs; env->ReleaseStringUTFChars(js, cs); }
                    env->DeleteLocalRef(js);
                }
                if (out.empty()) {
                    js = (jstring)env->CallObjectMethod(t, mThrCls);
                    if (js) {
                        const char* cs = env->GetStringUTFChars(js, nullptr);
                        if (cs) { out = cs; env->ReleaseStringUTFChars(js, cs); }
                        env->DeleteLocalRef(js);
                    }
                }
                env->DeleteLocalRef(t);
                if (out.empty() && fallback) out = fallback;
                return out;
            };

            jstring jurl = env->NewStringUTF(br->url.c_str());
            jobject oURL = env->NewObject(clsURL, mURL, jurl);
            if (env->ExceptionCheck())
            { detailedErr = captureThrowable("URL ctor");
              errMsg = detailedErr.c_str(); break; }
            oCon = env->CallObjectMethod(oURL, mOpen);
            if (env->ExceptionCheck() || !oCon)
            { detailedErr = captureThrowable("openConnection");
              errMsg = detailedErr.c_str(); break; }
            env->CallVoidMethod(oCon, mSetCT, (jint)10000);
            env->CallVoidMethod(oCon, mSetRT, (jint)20000);
            env->CallVoidMethod(oCon, mSetUC, JNI_FALSE);
            // Force GET and follow http<->https redirects (googlevideo
            // occasionally hops through a redir.googlevideo.com host).
            {
                jstring jget = env->NewStringUTF("GET");
                env->CallVoidMethod(oCon, mSetMethod, jget);
                if (env->ExceptionCheck()) env->ExceptionClear();
                env->DeleteLocalRef(jget);
            }
            env->CallVoidMethod(oCon, mSetFR, JNI_TRUE);
            if (env->ExceptionCheck()) env->ExceptionClear();
            // Mandatory: the User-Agent that requested the URL via InnerTube.
            if (!br->ua.empty())
            {
                jstring jk = env->NewStringUTF("User-Agent");
                jstring jv = env->NewStringUTF(br->ua.c_str());
                env->CallVoidMethod(oCon, mSetRP, jk, jv);
                env->DeleteLocalRef(jk); env->DeleteLocalRef(jv);
            }
            // googlevideo prefers an Accept-Encoding hint that won't
            // compress the audio stream.
            {
                jstring jk = env->NewStringUTF("Accept-Encoding");
                jstring jv = env->NewStringUTF("identity");
                env->CallVoidMethod(oCon, mSetRP, jk, jv);
                env->DeleteLocalRef(jk); env->DeleteLocalRef(jv);
            }
            // Accept any media type — googlevideo otherwise sometimes
            // 403s when Accept is left at the JVM default ("text/html").
            {
                jstring jk = env->NewStringUTF("Accept");
                jstring jv = env->NewStringUTF("*/*");
                env->CallVoidMethod(oCon, mSetRP, jk, jv);
                env->DeleteLocalRef(jk); env->DeleteLocalRef(jv);
            }
            // Range: bytes=0- — googlevideo serves the actual audio bytes
            // only when a Range header is present. Without it the
            // connection often hangs or returns an empty body, which
            // surfaces as "getInputStream" once Java's read() times out.
            {
                jstring jk = env->NewStringUTF("Range");
                jstring jv = env->NewStringUTF("bytes=0-");
                env->CallVoidMethod(oCon, mSetRP, jk, jv);
                env->DeleteLocalRef(jk); env->DeleteLocalRef(jv);
            }
            // Connection: keep-alive — matches what browsers send and
            // prevents some googlevideo POPs from closing the socket
            // immediately after the headers.
            {
                jstring jk = env->NewStringUTF("Connection");
                jstring jv = env->NewStringUTF("keep-alive");
                env->CallVoidMethod(oCon, mSetRP, jk, jv);
                env->DeleteLocalRef(jk); env->DeleteLocalRef(jv);
            }
            // Origin/Referer — harmless for googlevideo but required by
            // some CDN edges that mirror the YouTube web client policy.
            {
                jstring jk = env->NewStringUTF("Referer");
                jstring jv = env->NewStringUTF("https://www.youtube.com/");
                env->CallVoidMethod(oCon, mSetRP, jk, jv);
                env->DeleteLocalRef(jk); env->DeleteLocalRef(jv);
            }

            // Probe the response code BEFORE getInputStream so that on
            // non-2xx we can read the error body and surface a real
            // diagnostic instead of a bare "getInputStream".
            jint httpCode = env->CallIntMethod(oCon, mGetCode);
            if (env->ExceptionCheck())
            { detailedErr = captureThrowable("getResponseCode");
              errMsg = detailedErr.c_str(); break; }

            if (httpCode < 200 || httpCode >= 400)
            {
                // 3xx is auto-followed by setInstanceFollowRedirects(true)
                // so anything we see here is genuinely a failure.
                std::string respMsg;
                jstring jrm = (jstring)env->CallObjectMethod(oCon, mGetMsg);
                if (env->ExceptionCheck()) env->ExceptionClear();
                if (jrm) {
                    const char* cs = env->GetStringUTFChars(jrm, nullptr);
                    if (cs) { respMsg = cs; env->ReleaseStringUTFChars(jrm, cs); }
                    env->DeleteLocalRef(jrm);
                }
                // Drain the error stream (first ~256 bytes) for context.
                std::string errBody;
                jobject oErr = env->CallObjectMethod(oCon, mGetErrS);
                if (env->ExceptionCheck()) env->ExceptionClear();
                if (oErr) {
                    jbyteArray ebuf = env->NewByteArray(256);
                    jint en = env->CallIntMethod(oErr, mRead, ebuf);
                    if (env->ExceptionCheck()) env->ExceptionClear();
                    if (en > 0) {
                        jbyte* raw = env->GetByteArrayElements(ebuf, nullptr);
                        errBody.assign((const char*)raw, (size_t)en);
                        env->ReleaseByteArrayElements(ebuf, raw, JNI_ABORT);
                    }
                    env->DeleteLocalRef(ebuf);
                    env->CallVoidMethod(oErr, mClose);
                    if (env->ExceptionCheck()) env->ExceptionClear();
                    env->DeleteLocalRef(oErr);
                }
                char tmp[160];
                if (!errBody.empty()) {
                    if (errBody.size() > 96) errBody.resize(96);
                    for (char& c : errBody)
                        if (c == '\n' || c == '\r' || c == '\t') c = ' ';
                    snprintf(tmp, sizeof(tmp), "HTTP %d %s: %s",
                             (int)httpCode,
                             respMsg.empty() ? "" : respMsg.c_str(),
                             errBody.c_str());
                } else {
                    snprintf(tmp, sizeof(tmp), "HTTP %d %s",
                             (int)httpCode,
                             respMsg.empty() ? "" : respMsg.c_str());
                }
                detailedErr = tmp;
                errMsg = detailedErr.c_str();
                env->CallVoidMethod(oCon, mDisc);
                if (env->ExceptionCheck()) env->ExceptionClear();
                break;
            }

            oIn = env->CallObjectMethod(oCon, mGetIS);
            if (env->ExceptionCheck() || !oIn)
            { detailedErr = captureThrowable("getInputStream");
              errMsg = detailedErr.c_str(); break; }

            // Read the entire response into memory before handing to BASS.
            // This is what the launcher's existing in-app audio code does
            // (see houseguardaudio.cpp) and avoids the BASS_ERROR_FILEFORM
            // (=41) we got with the streaming BUFFERPUSH path on shipped
            // libbass.so builds.  Top-10 tracks are at most ~7 MB so the
            // up-front buffering cost is small (typically 1-2 seconds on
            // mobile data, instant on Wi-Fi).
            jbyteArray buf = env->NewByteArray((jsize)kReadChunk);
            for (;;)
            {
                if (br->state == 3) { errMsg = "stopped"; break; }
                jint n = env->CallIntMethod(oIn, mRead, buf);
                if (env->ExceptionCheck())
                { env->ExceptionClear(); errMsg = "read"; break; }
                if (n <= 0) break;       // EOF (-1) or zero
                jbyte* raw = env->GetByteArrayElements(buf, nullptr);
                size_t old = br->data.size();
                br->data.resize(old + (size_t)n);
                memcpy(br->data.data() + old, raw, (size_t)n);
                env->ReleaseByteArrayElements(buf, raw, JNI_ABORT);
            }
            env->CallVoidMethod(oIn, mClose);
            if (env->ExceptionCheck()) env->ExceptionClear();
            env->DeleteLocalRef(buf);

            if (br->state == 3) { /* stopped on user request */ break; }
            if (br->data.empty())
            { errMsg = "no data"; break; }

            // Create the in-memory BASS stream now that we have the full
            // file.  The data buffer is owned by the bridge struct and
            // outlives the BASS handle.
            if (!g_bassNet.StreamCreateFile)
            { errMsg = "BASS missing CreateFile API"; break; }
            handle = g_bassNet.StreamCreateFile(
                /*mem=*/1, br->data.data(), 0,
                (QWORD_)br->data.size(), 0);
            if (!handle)
            {
                char b[64]; int code = g_bassNet.ErrorGetCode
                                       ? g_bassNet.ErrorGetCode() : 0;
                snprintf(b, sizeof(b), "BASS create %d", code);
                br->error = b; br->state = 2; errMsg = nullptr;
                break;
            }
            br->handle = handle;
            g_bassNet.ChannelSetAttribute(handle, BASS_ATTRIB_VOL_,
                                          br->volume);
            g_bassNet.ChannelPlay(handle, 0);
            br->state = 1;
            // (no further pushes — random-access memory file)
            (void)kPrebufBytes; (void)Bridge_Read; (void)Bridge_Seek;
            (void)Bridge_Length; (void)Bridge_Close;
        } while (false);

        if (errMsg && br->state != 1)
        {
            br->error = errMsg;
            br->state = 2;
        }

        if (attached) vm->DetachCurrentThread();
        return nullptr;
    }

    static bool StartHttpsBridge(const std::string& url,
                                 const std::string& ua,
                                 float volume,
                                 std::string& errOut)
    {
        if (g_bridge)
        {
            g_bridge->state = 3;     // ask current bridge to stop
            // Don't join — it will exit on its own and self-close.
            // (Letting it run prevents a brief audio gap.)
            // But we still have to delete it. Since detach is set in
            // the thread we just leak the struct here; this only
            // happens once per stream change.
            g_bridge = nullptr;
        }
        g_bridge = new HttpsBridge();
        g_bridge->url    = url;
        g_bridge->ua     = ua;
        g_bridge->handle = 0;
        g_bridge->state  = 0;
        g_bridge->volume = volume;
        if (pthread_create(&g_bridge->thread, nullptr,
                           HttpsBridgeThread, g_bridge) != 0)
        {
            errOut = "thread create failed";
            delete g_bridge; g_bridge = nullptr;
            return false;
        }
        pthread_detach(g_bridge->thread);
        return true;
    }
}

bool CYtMusicOverlay::StartStream(const char* url, const char* userAgent)
{
    if (!EnsureBassLoaded() || !url || !*url) return false;
    StopStream();

    // googlevideo URLs are bound to the User-Agent that requested them via
    // InnerTube, so set it globally on BASS before opening the stream.
    // For direct audio URLs (mp3 / icecast / ...) a generic mobile UA is
    // also fine.
    const char* effUA = (userAgent && *userAgent)
                       ? userAgent
                       : "Mozilla/5.0 (Linux; Android 10) "
                         "AppleWebKit/537.36 (KHTML, like Gecko) "
                         "Chrome/120.0.0.0 Mobile Safari/537.36";
    if (g_bassNet.SetConfigPtr)
        g_bassNet.SetConfigPtr(BASS_CONFIG_NET_AGENT_, effUA);

    // ---- HTTPS bridge path -----------------------------------------------
    // The shipped libbass.so was built without SSL support, so any
    // https:// URL fails inside BASS_StreamCreateURL with code 10
    // (BASS_ERROR_SSL).  Detect that up front and download the bytes
    // ourselves through Java's HttpsURLConnection instead.
    bool isHttps = (strncmp(url, "https://", 8) == 0);
    if (isHttps && g_bassNet.StreamCreateFileUser
                && g_bassNet.StreamPutFileData)
    {
        std::string err;
        if (!StartHttpsBridge(url, effUA, m_volume, err))
        {
            m_lastError   = err.empty() ? "https bridge failed" : err;
            m_streamState = YTM_S_ERROR;
            return false;
        }
        m_streamState = YTM_S_BUFFER;
        m_lastError.clear();
        m_streamHandle = 0;          // not assigned yet — bridge will set it
        return true;
    }

    DWORD_ h = g_bassNet.StreamCreateURL(url, 0, 0, nullptr, nullptr);
    if (!h)
    {
        char b[96];
        int code = g_bassNet.ErrorGetCode ? g_bassNet.ErrorGetCode() : 0;
        const char* what = "BASS error";
        switch (code)
        {
            case 2:  what = "memory";              break;
            case 3:  what = "file open";           break;
            case 4:  what = "file format";         break;
            case 6:  what = "no internet";         break;
            case 8:  what = "BASS init missing";   break;
            case 18: what = "URL invalid";         break;
            case 19: what = "decode-only stream";  break;
            case 20: what = "DNS / connect fail";  break;
            case 21: what = "timeout";             break;
            case 22: what = "unsupported codec";   break;
            case 23: what = "speaker count";       break;
            case 32: what = "missing codec";       break;
            case 40: what = "blocked by server";   break;
            case 41: what = "ssl handshake";       break;
            default: what = "BASS";                break;
        }
        snprintf(b, sizeof(b), "Stream failed (%s, code %d)", what, code);
        m_lastError   = b;
        m_streamState = YTM_S_ERROR;
        return false;
    }
    m_streamHandle = h;
    g_bassNet.ChannelSetAttribute(h, BASS_ATTRIB_VOL_, m_volume);
    g_bassNet.ChannelPlay(h, 0);
    m_streamState = YTM_S_PLAYING;
    m_lastError.clear();
    return true;
}

void CYtMusicOverlay::StopStream()
{
    bool wasTop10 = (m_top10NowIdx > 0);
    if (g_bridge)
    {
        g_bridge->state = 3;
        g_bridge = nullptr;   // detached thread will exit & free itself
    }
    if (m_streamHandle && g_bassNet.ChannelStop)
    {
        g_bassNet.ChannelStop(m_streamHandle);
        if (g_bassNet.StreamFree) g_bassNet.StreamFree(m_streamHandle);
    }
    m_streamHandle = 0;
    m_streamState  = YTM_S_IDLE;
    m_top10NowIdx  = 0;
    if (wasTop10)
        NotifyServerStop();
}

void CYtMusicOverlay::PauseStream()
{
    if (m_streamHandle && g_bassNet.ChannelPause)
    { g_bassNet.ChannelPause(m_streamHandle); m_streamState = YTM_S_PAUSED; }
}

void CYtMusicOverlay::ResumeStream()
{
    if (m_streamHandle && g_bassNet.ChannelPlay)
    { g_bassNet.ChannelPlay(m_streamHandle, 0); m_streamState = YTM_S_PLAYING; }
}

void CYtMusicOverlay::SetVolume(float v)
{
    if (v < 0) v = 0; if (v > 1) v = 1;
    m_volume = v;
    if (m_streamHandle && g_bassNet.ChannelSetAttribute)
        g_bassNet.ChannelSetAttribute(m_streamHandle, BASS_ATTRIB_VOL_, v);
}

double CYtMusicOverlay::GetPosition()
{
    if (!m_streamHandle || !g_bassNet.ChannelGetPosition ||
        !g_bassNet.ChannelBytes2Seconds) return 0.0;
    QWORD_ bytes = g_bassNet.ChannelGetPosition(m_streamHandle, BASS_POS_BYTE_);
    return g_bassNet.ChannelBytes2Seconds(m_streamHandle, bytes);
}

double CYtMusicOverlay::GetDuration()
{
    if (!m_streamHandle || !g_bassNet.ChannelGetLength ||
        !g_bassNet.ChannelBytes2Seconds) return 0.0;
    QWORD_ bytes = g_bassNet.ChannelGetLength(m_streamHandle, BASS_POS_BYTE_);
    return g_bassNet.ChannelBytes2Seconds(m_streamHandle, bytes);
}

void CYtMusicOverlay::StartResolve(const char* url)
{
    if (g_job && g_job->done == 0) return; // already in flight
    if (g_job) { delete g_job; g_job = nullptr; }
    g_job = new ResolveJob();
    snprintf(g_job->ytUrl, sizeof(g_job->ytUrl), "%s", url);
    g_job->done = 0;
    pthread_create(&g_jobThread, nullptr, ResolveThreadFn, g_job);
    pthread_detach(g_jobThread);
    m_streamState = YTM_S_RESOLVE;
    m_lastError.clear();
}

void CYtMusicOverlay::PollResolve()
{
    // Pump the HTTPS bridge state into the player UI.
    if (g_bridge)
    {
        if (g_bridge->state == 1 && g_bridge->handle != 0 &&
            m_streamHandle != g_bridge->handle)
        {
            m_streamHandle = g_bridge->handle;
            m_streamState  = YTM_S_PLAYING;
            m_lastError.clear();
        }
        else if (g_bridge->state == 2)
        {
            m_lastError   = g_bridge->error.empty()
                            ? std::string("https bridge failed")
                            : g_bridge->error;
            m_streamState = YTM_S_ERROR;
            // Bridge thread has exited — release the struct.
            HttpsBridge* dead = g_bridge;
            g_bridge = nullptr;
            delete dead;
        }
    }

    if (!g_job) return;
    if (g_job->done == 0) return;
    if (g_job->done == 1)
    {
        m_resolvedUrl = g_job->resolvedUrl;
        if (!g_job->title.empty())  m_title  = g_job->title;
        if (!g_job->artist.empty()) m_artist = g_job->artist;
        StartStream(m_resolvedUrl.c_str(),
                    g_job->streamUA.empty() ? nullptr
                                            : g_job->streamUA.c_str());
    }
    else
    {
        m_lastError   = g_job->error.empty() ? "resolve failed" : g_job->error;
        m_streamState = YTM_S_ERROR;
    }
    delete g_job; g_job = nullptr;
}

// ============================================================================
//  Multiplayer spatial-audio bridge
//  ---------------------------------------------------------------------------
//  When the local player starts a top-10 track, we send a chat command
//  (`/_yt N`) to the server. The gamemode handler picks it up and
//  rebroadcasts a "[HAV_YTM]PLAY:<pid>:<idx>" to every connected
//  client via SendClientMessageToAll. Each launcher's RPC handler
//  detects the prefix, consumes the line and forwards it here. We
//  download the same `/top10/<idx>` mp3 in a worker thread, then play
//  it locally via BASS_StreamCreateFile (memory mode). Every frame we
//  recompute the volume based on `distance(localPlayer, broadcaster)`
//  so the music fades smoothly with proximity (audible up to 30m).
// ============================================================================

CYtMusicOverlay::RemoteStream* CYtMusicOverlay::FindRemote(int playerid)
{
    for (size_t i = 0; i < m_remoteStreams.size(); ++i)
        if (m_remoteStreams[i]->playerid == playerid)
            return m_remoteStreams[i];
    return nullptr;
}

void CYtMusicOverlay::NotifyServerPlay(int trackIdx)
{
    if (!pNetGame) return;
    char buf[32];
    snprintf(buf, sizeof(buf), "/_yt %d", trackIdx);
    pNetGame->SendChatCommand(buf);
}

void CYtMusicOverlay::NotifyServerStop()
{
    if (!pNetGame) return;
    pNetGame->SendChatCommand("/_ytstop");
}

namespace
{
    // Background fetcher for a single RemoteStream. Mirrors HttpsBridgeThread
    // but stores results directly on the RemoteStream rather than a global.
    struct RemoteFetchArg
    {
        CYtMusicOverlay::RemoteStream* rs;
    };
}

void* CYtMusicOverlay::RemoteFetchThreadFn(void* arg)
{
    RemoteFetchArg* fa = (RemoteFetchArg*)arg;
    RemoteStream* rs = fa->rs;
    delete fa;
    if (!pYtMusicOverlay) { rs->state = 2; return nullptr; }

    JavaVM* vm = javaVM;
    if (!vm) { rs->state = 2; return nullptr; }
    JNIEnv* env = nullptr;
    bool attached = false;
    if (vm->GetEnv((void**)&env, JNI_VERSION_1_4) == JNI_EDETACHED)
    {
        if (vm->AttachCurrentThread(&env, nullptr) != 0)
        { rs->state = 2; return nullptr; }
        attached = true;
    }

    char url[160];
    snprintf(url, sizeof(url),
             "https://yt-proxy-jsqytjvy.fly.dev/top10/%d", rs->trackIdx);

    do {
        jclass clsURL  = env->FindClass("java/net/URL");
        jclass clsHttp = env->FindClass("java/net/HttpURLConnection");
        jclass clsIS   = env->FindClass("java/io/InputStream");
        if (!clsURL || !clsHttp || !clsIS) { rs->state = 2; break; }

        jmethodID mURL  = env->GetMethodID(clsURL, "<init>",
                                            "(Ljava/lang/String;)V");
        jmethodID mOpen = env->GetMethodID(clsURL, "openConnection",
                                            "()Ljava/net/URLConnection;");
        jmethodID mGetIS = env->GetMethodID(clsHttp, "getInputStream",
                                            "()Ljava/io/InputStream;");
        jmethodID mRead  = env->GetMethodID(clsIS, "read", "([B)I");
        jmethodID mClose = env->GetMethodID(clsIS, "close", "()V");
        if (!mURL || !mOpen || !mGetIS || !mRead || !mClose)
        { rs->state = 2; break; }

        jstring jUrl = env->NewStringUTF(url);
        jobject jUrlObj = env->NewObject(clsURL, mURL, jUrl);
        env->DeleteLocalRef(jUrl);
        if (env->ExceptionCheck() || !jUrlObj)
        { env->ExceptionClear(); rs->state = 2; break; }
        jobject oCon = env->CallObjectMethod(jUrlObj, mOpen);
        env->DeleteLocalRef(jUrlObj);
        if (env->ExceptionCheck() || !oCon)
        { env->ExceptionClear(); rs->state = 2; break; }
        jobject oIn = env->CallObjectMethod(oCon, mGetIS);
        env->DeleteLocalRef(oCon);
        if (env->ExceptionCheck() || !oIn)
        { env->ExceptionClear(); rs->state = 2; break; }

        const size_t kReadChunk = 32 * 1024;
        jbyteArray buf = env->NewByteArray((jsize)kReadChunk);
        for (;;)
        {
            if (rs->state == 3) break;     // user requested stop
            jint n = env->CallIntMethod(oIn, mRead, buf);
            if (env->ExceptionCheck()) { env->ExceptionClear(); break; }
            if (n <= 0) break;
            jbyte* raw = env->GetByteArrayElements(buf, nullptr);
            size_t old = rs->data.size();
            rs->data.resize(old + (size_t)n);
            memcpy(rs->data.data() + old, raw, (size_t)n);
            env->ReleaseByteArrayElements(buf, raw, JNI_ABORT);
        }
        env->CallVoidMethod(oIn, mClose);
        if (env->ExceptionCheck()) env->ExceptionClear();
        env->DeleteLocalRef(buf);

        if (rs->state == 3) break;
        if (rs->data.empty()) { rs->state = 2; break; }
        if (!g_bassNet.StreamCreateFile) { rs->state = 2; break; }

        unsigned int h = g_bassNet.StreamCreateFile(
            /*mem=*/1, rs->data.data(), 0,
            (unsigned long long)rs->data.size(), 0);
        if (!h) { rs->state = 2; break; }
        rs->handle = h;
        // Start muted; TickRemoteVolumes will set the right volume next frame.
        if (g_bassNet.ChannelSetAttribute)
            g_bassNet.ChannelSetAttribute(h, 2 /*BASS_ATTRIB_VOL*/, 0.0f);
        if (g_bassNet.ChannelPlay)
            g_bassNet.ChannelPlay(h, 0);
        rs->state = 1;
    } while (false);

    if (attached) vm->DetachCurrentThread();
    return nullptr;
}

void CYtMusicOverlay::HandleRemotePlay(int playerid, int trackIdx)
{
    if (!EnsureBassLoaded()) return;
    if (trackIdx < 1 || trackIdx > 100) return;

    // If this player already has a stream, stop & replace.
    HandleRemoteStop(playerid);

    RemoteStream* rs = new RemoteStream();
    rs->playerid       = playerid;
    rs->trackIdx       = trackIdx;
    rs->handle         = 0;
    rs->state          = 0;
    rs->threadStarted  = false;
    rs->lastVolume     = 0.0f;
    m_remoteStreams.push_back(rs);

    RemoteFetchArg* fa = new RemoteFetchArg{rs};
    if (pthread_create(&rs->thread, nullptr,
                       &CYtMusicOverlay::RemoteFetchThreadFn, fa) == 0)
    {
        rs->threadStarted = true;
        pthread_detach(rs->thread);
    }
    else
    {
        delete fa;
        rs->state = 2;
    }
}

void CYtMusicOverlay::HandleRemoteStop(int playerid)
{
    for (size_t i = 0; i < m_remoteStreams.size(); ++i)
    {
        RemoteStream* rs = m_remoteStreams[i];
        if (rs->playerid != playerid) continue;
        rs->state = 3;
        if (rs->handle && g_bassNet.ChannelStop)
        {
            g_bassNet.ChannelStop(rs->handle);
            if (g_bassNet.StreamFree) g_bassNet.StreamFree(rs->handle);
        }
        rs->handle = 0;
        // Leak the struct (worker thread may still be active). It will
        // notice rs->state==3 and exit; the data buffer is small.
        m_remoteStreams.erase(m_remoteStreams.begin() + i);
        break;
    }
}

void CYtMusicOverlay::HandleRemoteAll()
{
    while (!m_remoteStreams.empty())
        HandleRemoteStop(m_remoteStreams.back()->playerid);
}

void CYtMusicOverlay::TickRemoteVolumes()
{
    if (m_remoteStreams.empty()) return;
    if (!pNetGame || !pNetGame->GetPlayerPool()) return;
    CPlayerPool* pool = pNetGame->GetPlayerPool();
    CLocalPlayer* localP = pool->GetLocalPlayer();
    if (!localP || !localP->GetPlayerPed()) return;
    MATRIX4X4 localMat;
    localP->GetPlayerPed()->GetMatrix(&localMat);
    const float lx = localMat.pos.X;
    const float ly = localMat.pos.Y;
    const float lz = localMat.pos.Z;

    const float kMaxDist = 30.0f;

    for (size_t i = 0; i < m_remoteStreams.size(); ++i)
    {
        RemoteStream* rs = m_remoteStreams[i];
        if (rs->state != 1 || rs->handle == 0) continue;

        float vol = 0.0f;
        if (rs->playerid >= 0 && rs->playerid < MAX_PLAYERS &&
            pool->GetSlotState(rs->playerid))
        {
            CRemotePlayer* rp = pool->GetAt(rs->playerid);
            if (rp && rp->GetPlayerPed())
            {
                MATRIX4X4 rm;
                rp->GetPlayerPed()->GetMatrix(&rm);
                float dx = rm.pos.X - lx;
                float dy = rm.pos.Y - ly;
                float dz = rm.pos.Z - lz;
                float dist = sqrtf(dx*dx + dy*dy + dz*dz);
                vol = 1.0f - (dist / kMaxDist);
                if (vol < 0.0f) vol = 0.0f;
                if (vol > 1.0f) vol = 1.0f;
                // Smooth quadratic falloff so it sounds more natural.
                vol = vol * vol;
            }
        }
        // Smooth toward target volume to avoid audible volume snaps.
        const float kAlpha = 0.20f;
        float v = rs->lastVolume + (vol - rs->lastVolume) * kAlpha;
        rs->lastVolume = v;
        if (g_bassNet.ChannelSetAttribute)
            g_bassNet.ChannelSetAttribute(rs->handle,
                                          2 /*BASS_ATTRIB_VOL*/, v);
    }
}

// ============================================================================
//  Render
// ============================================================================
void CYtMusicOverlay::Render()
{
    // Run remote-stream tick every frame even when overlay is hidden, so
    // background music keeps fading in/out as players move around.
    TickRemoteVolumes();
    if (m_state == YTM_HIDDEN) return;
    PollResolve();

    ImGuiIO& io = ImGui::GetIO();
    float dt = io.DeltaTime;
    if (dt <= 0 || dt > 0.5f) dt = 1.0f / 60.0f;

    // Slide-up animation: m_animT 0->1 over ~360ms with ease-out.
    if (m_animT < 1.0f)
    {
        m_animT += dt / 0.36f;
        if (m_animT > 1.0f) m_animT = 1.0f;
    }

    RenderPhone(io.DisplaySize.x, io.DisplaySize.y);
}

bool CYtMusicOverlay::BigButton(const char* label, float x, float y,
                                 float w, float h, unsigned col,
                                 unsigned colHover, unsigned colText)
{
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    ImGuiIO& io = ImGui::GetIO();
    ImVec2 a(x, y), b(x+w, y+h);
    bool inside = PointInRect(io.MousePos, a, b);
    bool hover  = inside && io.MouseDown[0];
    dl->AddRectFilled(a, b, hover ? colHover : col, 14.0f);
    dl->AddRect(a, b, kY_Border, 14.0f);
    ImVec2 ts = ImGui::CalcTextSize(label);
    dl->AddText(ImVec2(x + (w-ts.x)*0.5f, y + (h-ts.y)*0.5f), colText, label);
    return inside && ImGui::IsMouseClicked(0);
}

bool CYtMusicOverlay::RoundIconBtn(const char* glyph, float cx, float cy,
                                    float r, unsigned bg, unsigned tint)
{
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    ImGuiIO& io = ImGui::GetIO();
    bool inside = PointInCircle(io.MousePos, ImVec2(cx, cy), r);
    bool hover  = inside && io.MouseDown[0];
    dl->AddCircleFilled(ImVec2(cx, cy), r, hover ? kY_BtnHover : bg, 32);
    ImVec2 ts = ImGui::CalcTextSize(glyph);
    dl->AddText(ImVec2(cx - ts.x*0.5f, cy - ts.y*0.5f), tint, glyph);
    return inside && ImGui::IsMouseClicked(0);
}

bool CYtMusicOverlay::IconBtn(int icon, float cx, float cy, float r,
                               unsigned bg, unsigned tint)
{
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    ImGuiIO& io = ImGui::GetIO();
    bool inside = PointInCircle(io.MousePos, ImVec2(cx, cy), r);
    bool hover  = inside && io.MouseDown[0];
    dl->AddCircleFilled(ImVec2(cx, cy), r, hover ? kY_BtnHover : bg, 32);
    DrawIcon(icon, cx, cy, r * 0.85f, tint);
    return inside && ImGui::IsMouseClicked(0);
}

// Draws a vector glyph centered at (cx, cy) inscribed in a `size` x `size`
// box. Uses a few simple primitives — no font dependency.
void CYtMusicOverlay::DrawIcon(int icon, float cx, float cy, float s,
                                unsigned col)
{
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    float th = s * 0.18f;
    if (th < 1.5f) th = 1.5f;

    auto line = [&](float x1, float y1, float x2, float y2)
    { dl->AddLine(ImVec2(cx+x1, cy+y1), ImVec2(cx+x2, cy+y2), col, th); };

    switch (icon)
    {
    case ICON_CLOSE:
        line(-s*0.5f, -s*0.5f,  s*0.5f,  s*0.5f);
        line( s*0.5f, -s*0.5f, -s*0.5f,  s*0.5f);
        break;
    case ICON_MORE:
        dl->AddCircleFilled(ImVec2(cx-s*0.45f, cy), th, col, 12);
        dl->AddCircleFilled(ImVec2(cx,         cy), th, col, 12);
        dl->AddCircleFilled(ImVec2(cx+s*0.45f, cy), th, col, 12);
        break;
    case ICON_HEART:
    case ICON_HEART_F: {
        // Two circles + a triangle — classic heart silhouette.
        float h = s * 0.55f;
        float cy0 = cy - s*0.10f;
        ImVec2 cl(cx - h*0.5f, cy0);
        ImVec2 cr(cx + h*0.5f, cy0);
        if (icon == ICON_HEART_F)
        {
            dl->AddCircleFilled(cl, h*0.55f, col, 24);
            dl->AddCircleFilled(cr, h*0.55f, col, 24);
            dl->AddTriangleFilled(
                ImVec2(cx - h, cy0 + h*0.05f),
                ImVec2(cx + h, cy0 + h*0.05f),
                ImVec2(cx,       cy + h*0.85f), col);
        }
        else
        {
            dl->AddCircle(cl, h*0.55f, col, 24, th);
            dl->AddCircle(cr, h*0.55f, col, 24, th);
            line(-h, cy0 + h*0.05f - cy, 0, cy + h*0.85f - cy);
            line( h, cy0 + h*0.05f - cy, 0, cy + h*0.85f - cy);
        }
        break;
    }
    case ICON_SHUFFLE: {
        // Two crossing arrows.
        float w = s*0.55f;
        float h = s*0.35f;
        line(-w, -h,  w*0.55f, -h);
        line(-w,  h,  w*0.55f,  h);
        // Arrowheads
        line(w*0.55f, -h, w*0.20f, -h-h*0.6f);
        line(w*0.55f, -h, w*0.20f, -h+h*0.6f);
        line(w*0.55f,  h, w*0.20f,  h-h*0.6f);
        line(w*0.55f,  h, w*0.20f,  h+h*0.6f);
        // Crossover
        line(-w*0.5f, -h,  w*0.55f,  h);
        line(-w*0.5f,  h,  w*0.55f, -h);
        break;
    }
    case ICON_PREV:
    case ICON_NEXT: {
        float dir = (icon == ICON_NEXT) ? 1.0f : -1.0f;
        ImVec2 a(cx + dir * (-s*0.45f), cy - s*0.45f);
        ImVec2 b(cx + dir * ( s*0.10f), cy);
        ImVec2 c(cx + dir * (-s*0.45f), cy + s*0.45f);
        dl->AddTriangleFilled(a, b, c, col);
        ImVec2 ba(cx + dir * (s*0.20f), cy - s*0.45f);
        ImVec2 bb(cx + dir * (s*0.40f), cy + s*0.45f);
        if (dir > 0) dl->AddRectFilled(ba, bb, col);
        else         dl->AddRectFilled(bb, ba, col);
        break;
    }
    case ICON_PLAY: {
        ImVec2 a(cx - s*0.32f, cy - s*0.50f);
        ImVec2 b(cx + s*0.50f, cy);
        ImVec2 c(cx - s*0.32f, cy + s*0.50f);
        dl->AddTriangleFilled(a, b, c, col);
        break;
    }
    case ICON_PAUSE: {
        float bw = s*0.18f, bh = s*0.55f, gp = s*0.10f;
        dl->AddRectFilled(ImVec2(cx - gp - bw, cy - bh),
                          ImVec2(cx - gp,      cy + bh), col, 2.0f);
        dl->AddRectFilled(ImVec2(cx + gp,      cy - bh),
                          ImVec2(cx + gp + bw, cy + bh), col, 2.0f);
        break;
    }
    case ICON_REPEAT: {
        // Rounded rect outline + small arrowhead bottom-right.
        float w = s*0.55f, h = s*0.40f;
        dl->AddRect(ImVec2(cx-w, cy-h), ImVec2(cx+w, cy+h), col, 6.0f, 0xF, th);
        // Arrowhead.
        line(w*0.55f,  h, w*0.95f,  h - h*0.45f);
        line(w*0.55f,  h, w*0.95f,  h + h*0.45f);
        // Cut-line to suggest looping break.
        line(-w*0.85f,  h, -w*0.55f, h);
        break;
    }
    case ICON_VOLUME:
    case ICON_LOUD: {
        // Speaker triangle + body + (loud only) one or two waves.
        float w = s*0.45f, h = s*0.35f;
        dl->AddRectFilled(ImVec2(cx-w, cy-h*0.45f),
                          ImVec2(cx-w*0.45f, cy+h*0.45f), col);
        dl->AddTriangleFilled(
            ImVec2(cx-w*0.45f, cy-h*0.45f),
            ImVec2(cx+w*0.10f, cy-h),
            ImVec2(cx+w*0.10f, cy+h), col);
        dl->AddTriangleFilled(
            ImVec2(cx-w*0.45f, cy+h*0.45f),
            ImVec2(cx+w*0.10f, cy+h),
            ImVec2(cx+w*0.10f, cy-h), col);
        if (icon == ICON_LOUD)
        {
            // Two arcs to suggest sound waves.
            for (int i = 1; i <= 2; ++i)
            {
                float r = w*(0.30f + 0.25f*i);
                dl->PathArcTo(ImVec2(cx+w*0.10f, cy), r,
                              -0.6f, 0.6f, 12);
                dl->PathStroke(col, false, th);
            }
        }
        break;
    }
    default: break;
    }
}

void CYtMusicOverlay::DrawAlbumArt(float x, float y, float size)
{
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    ImVec2 a(x, y), b(x+size, y+size);

    // Diagonal gradient fill (orange -> pink -> purple).
    dl->AddRectFilledMultiColor(a, b,
        kY_Accent1, kY_Accent2, kY_Accent4, kY_Accent3);
    dl->AddRect(a, b, IM_COL32(255,255,255,30), 22.0f, 0, 1.0f);

    // Decorative blurred orbs — clipped to the art square so they never
    // bleed outside the phone frame the way the previous halo did.
    dl->PushClipRect(a, b, true);
    dl->AddCircleFilled(ImVec2(x+size*0.30f, y+size*0.30f),
                        size*0.30f, IM_COL32(255,220,180,70), 40);
    dl->AddCircleFilled(ImVec2(x+size*0.78f, y+size*0.72f),
                        size*0.22f, IM_COL32(91,42,134,110), 40);
    // Soft top sheen.
    dl->AddRectFilledMultiColor(a, ImVec2(x+size, y+size*0.35f),
        IM_COL32(255,255,255,30), IM_COL32(255,255,255,10),
        IM_COL32(255,255,255,2), IM_COL32(255,255,255,12));
    dl->PopClipRect();

    // "Live · 320kbps" pill, bottom-left.
    char pill[48];
    bool playing = (m_streamState == YTM_S_PLAYING);
    const char* pillText = "READY";
    if      (playing)                          pillText = "LIVE  320 kbps";
    else if (m_streamState == YTM_S_BUFFER)    pillText = "BUFFERING...";
    else if (m_streamState == YTM_S_RESOLVE)   pillText = "RESOLVING...";
    else if (m_streamState == YTM_S_ERROR)     pillText = "ERROR";
    snprintf(pill, sizeof(pill), "%s", pillText);
    ImVec2 pillSize = ImGui::CalcTextSize(pill);
    ImVec2 pa(x+10, y+size-26), pb(pa.x+pillSize.x+18, pa.y+22);
    dl->AddRectFilled(pa, pb, IM_COL32(0,0,0,140), 12.0f);
    dl->AddRect(pa, pb, IM_COL32(255,255,255,40), 12.0f);
    dl->AddText(ImVec2(pa.x+9, pa.y+(22-pillSize.y)*0.5f), kY_Text, pill);
}

void CYtMusicOverlay::DrawProgressBar(float x, float y, float w)
{
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    ImGuiIO& io = ImGui::GetIO();
    double pos = GetPosition();
    double dur = GetDuration();
    float frac = 0.0f;
    if (dur > 0.5) frac = (float)(pos / dur);
    if (frac < 0) frac = 0; if (frac > 1) frac = 1;

    // Track
    dl->AddRectFilled(ImVec2(x, y), ImVec2(x+w, y+5),
                      IM_COL32(255,255,255,28), 3.0f);
    // Filled portion (orange->pink gradient)
    dl->AddRectFilledMultiColor(ImVec2(x, y), ImVec2(x+w*frac, y+5),
        kY_Accent1, kY_Accent2, kY_Accent2, kY_Accent1);
    // Thumb
    float tx = x + w*frac;
    dl->AddCircleFilled(ImVec2(tx, y+2), 7, IM_COL32(255,255,255,255), 16);
    dl->AddCircle(ImVec2(tx, y+2), 8, IM_COL32(255,77,109,180), 16, 1.5f);

    // Click-to-seek
    ImVec2 hitA(x, y-10), hitB(x+w, y+15);
    if (io.MouseDown[0] && PointInRect(io.MousePos, hitA, hitB))
    {
        float fr = (io.MousePos.x - x) / w;
        if (fr < 0) fr = 0; if (fr > 1) fr = 1;
        if (m_streamHandle && g_bassNet.ChannelSeconds2Bytes &&
            g_bassNet.ChannelSetPosition && dur > 0.5)
        {
            QWORD_ b = g_bassNet.ChannelSeconds2Bytes(m_streamHandle, dur*fr);
            g_bassNet.ChannelSetPosition(m_streamHandle, b, BASS_POS_BYTE_);
        }
    }

    char a[16], b[16];
    FormatTime(pos, a, sizeof(a));
    FormatTime(dur > 0.5 ? (dur - pos) : -1, b, sizeof(b));
    char rem[20]; snprintf(rem, sizeof(rem), "-%s",
                           (dur > 0.5) ? b : "--:--");
    dl->AddText(ImVec2(x, y+12), kY_TextSub, a);
    ImVec2 rs = ImGui::CalcTextSize(rem);
    dl->AddText(ImVec2(x+w-rs.x, y+12), kY_TextSub, rem);
}

void CYtMusicOverlay::DrawVolumeBar(float x, float y, float w)
{
    ImGuiIO& io = ImGui::GetIO();
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    DrawIcon(ICON_VOLUME, x + 8, y + 7, 14.0f, kY_TextDim);
    float bx = x + 28, bw = w - 56;
    dl->AddRectFilled(ImVec2(bx, y+5), ImVec2(bx+bw, y+8),
                      IM_COL32(255,255,255,28), 2.0f);
    dl->AddRectFilled(ImVec2(bx, y+5), ImVec2(bx+bw*m_volume, y+8),
                      IM_COL32(255,255,255,220), 2.0f);
    DrawIcon(ICON_LOUD, x + w - 14, y + 7, 14.0f, kY_TextDim);

    ImVec2 hitA(bx, y-4), hitB(bx+bw, y+16);
    if (io.MouseDown[0] && PointInRect(io.MousePos, hitA, hitB))
    {
        float v = (io.MousePos.x - bx) / bw;
        SetVolume(v);
    }
}

void CYtMusicOverlay::DrawServerBar(float x, float y, float w)
{
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    ImVec2 a(x, y), b(x+w, y+44);
    dl->AddRectFilled(a, b, IM_COL32(255,255,255,18), 14.0f);
    dl->AddRect(a, b, IM_COL32(255,255,255,28), 14.0f);
    // SA pill
    dl->AddRectFilledMultiColor(ImVec2(x+8, y+6), ImVec2(x+38, y+36),
        kY_Accent1, kY_Accent2, kY_Accent2, kY_Accent1);
    dl->AddText(ImVec2(x+12, y+13), IM_COL32(255,255,255,255), "SA");

    dl->AddCircleFilled(ImVec2(x+50, y+15), 3, kY_Online, 12);
    dl->AddText(ImVec2(x+58, y+8), kY_Text, "Havana RP");
    dl->AddText(ImVec2(x+58, y+24), kY_TextDim, "samp.havana-rp.com:2826");
}

void CYtMusicOverlay::RenderTop10List(float lx, float ly, float lw, float lh)
{
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    ImGuiIO& io = ImGui::GetIO();

    // Header
    const char* hdr = "TOP 10 \xE2\x80\xA2 GLOBAL"; // bullet middle dot UTF-8
    dl->AddText(ImVec2(lx, ly), kY_TextSub, hdr);
    ly += 22;
    lh -= 22;

    // Loading / error states
    if (m_top10LoadState == 1 || m_top10LoadState == 0)
    {
        const char* msg = "Loading curated tracks...";
        ImVec2 ts = ImGui::CalcTextSize(msg);
        dl->AddText(ImVec2(lx + (lw - ts.x) * 0.5f, ly + lh * 0.5f - 7),
                    kY_TextDim, msg);
        return;
    }
    if (m_top10LoadState == -1 || m_top10Tracks.empty())
    {
        const char* msg = "Could not load list — tap TOP 10 again to retry";
        ImVec2 ts = ImGui::CalcTextSize(msg);
        dl->AddText(ImVec2(lx + (lw - ts.x) * 0.5f, ly + lh * 0.5f - 7),
                    kY_Heart, msg);
        if (io.MouseClicked[0])
        {
            m_top10LoadState = 0;
            StartLoadTop10();
        }
        return;
    }

    // 10 rows.  Compute row height so they fit the available column.
    int n = (int)m_top10Tracks.size();
    float rowGap = 6.0f;
    float rowH   = (lh - rowGap * (n - 1)) / (float)n;
    if (rowH > 56.0f) rowH = 56.0f;
    if (rowH < 36.0f) rowH = 36.0f;

    for (int i = 0; i < n; ++i)
    {
        const Top10Entry& t = m_top10Tracks[i];
        float ry = ly + i * (rowH + rowGap);
        ImVec2 ra(lx, ry), rb(lx + lw, ry + rowH);
        bool hover = PointInRect(io.MousePos, ra, rb);
        bool nowPlaying = (t.idx == m_top10NowIdx);

        unsigned rowCol = nowPlaying
            ? IM_COL32(255, 138, 76, 70)
            : (hover ? IM_COL32(255, 255, 255, 32)
                     : IM_COL32(255, 255, 255, 16));
        dl->AddRectFilled(ra, rb, rowCol, 12.0f);
        dl->AddRect(ra, rb, IM_COL32(255, 255, 255, 30), 12.0f);

        // Index badge on the left.
        float badgeR = rowH * 0.32f;
        ImVec2 bc(ra.x + 8 + badgeR, ra.y + rowH * 0.5f);
        dl->AddCircleFilled(bc, badgeR, IM_COL32(255, 255, 255, 30), 24);
        char idxBuf[8]; snprintf(idxBuf, sizeof(idxBuf), "%d", t.idx);
        ImVec2 its = ImGui::CalcTextSize(idxBuf);
        dl->AddText(ImVec2(bc.x - its.x * 0.5f, bc.y - its.y * 0.5f),
                    kY_Text, idxBuf);

        // Duration on the right (mm:ss).
        char dbuf[16];
        int mm = t.duration / 60, ss = t.duration % 60;
        snprintf(dbuf, sizeof(dbuf), "%d:%02d", mm, ss);
        ImVec2 dts = ImGui::CalcTextSize(dbuf);
        float durX = rb.x - 10 - dts.x;
        dl->AddText(ImVec2(durX, ra.y + rowH * 0.5f - dts.y * 0.5f),
                    kY_TextDim, dbuf);

        // Title + artist column, clipped so long names don't overflow into
        // the duration label on the right.
        float textX = ra.x + 8 + badgeR * 2 + 12;
        ImVec2 clipA(textX, ra.y);
        ImVec2 clipB(durX - 8, rb.y);
        dl->PushClipRect(clipA, clipB, true);
        dl->AddText(ImVec2(textX, ra.y + rowH * 0.5f - 16),
                    nowPlaying ? IM_COL32(255, 230, 200, 255) : kY_Text,
                    t.title.c_str());
        dl->AddText(ImVec2(textX, ra.y + rowH * 0.5f + 0),
                    kY_TextDim, t.artist.c_str());
        dl->PopClipRect();

        // Tap to play.
        if (hover && io.MouseClicked[0])
            PlayTop10(t.idx);
    }
}

void CYtMusicOverlay::RenderPhone(float scrW, float scrH)
{
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    ImGuiIO& io = ImGui::GetIO();

    // Layout — center the phone, scaled to height. Slightly wider/taller
    // than the previous build so the album art and URL can breathe.
    float phoneH = scrH * 0.98f;
    float phoneW = phoneH * (380.0f / 760.0f);
    if (phoneW > scrW * 0.58f) { phoneW = scrW * 0.58f;
                                  phoneH = phoneW * (760.0f / 380.0f); }
    if (phoneH > scrH * 0.98f)  { phoneH = scrH * 0.98f;
                                  phoneW = phoneH * (380.0f / 760.0f); }
    float phoneX = (scrW - phoneW) * 0.5f;

    // Slide-up: animate Y from below the screen up to centered.
    float t = m_animT; // 0..1
    // Ease out cubic
    float eased = 1.0f - powf(1.0f - t, 3.0f);
    float restY = (scrH - phoneH) * 0.5f;
    float startY = scrH;
    float phoneY = startY + (restY - startY) * eased;

    // Dim the rest of the screen as the panel rises.
    unsigned dimA = (unsigned)(160 * eased);
    dl->AddRectFilled(ImVec2(0,0), ImVec2(scrW, scrH),
                      IM_COL32(0,0,0,dimA));

    // Phone outer body (rounded)
    ImVec2 pa(phoneX, phoneY), pb(phoneX+phoneW, phoneY+phoneH);
    dl->AddRectFilled(pa, pb, kY_BgOuter, 36.0f);
    dl->AddRect(pa, pb, IM_COL32(255,255,255,18), 36.0f, 0, 1.5f);

    // Inner screen
    float pad = 8;
    ImVec2 sa(phoneX+pad, phoneY+pad);
    ImVec2 sb(phoneX+phoneW-pad, phoneY+phoneH-pad);
    dl->AddRectFilled(sa, sb, kY_BgInner, 28.0f);

    // Subtle top sheen — kept INSIDE the inner screen so it doesn't bleed
    // out above the phone like the previous radial halo did.
    dl->PushClipRect(sa, sb, true);
    for (int i = 0; i < 5; ++i)
    {
        unsigned a2 = (unsigned)(28 - i*5);
        dl->AddRectFilled(ImVec2(sa.x, sa.y + i*4),
                          ImVec2(sb.x, sa.y + i*4 + 18),
                          IM_COL32(255,138,76, a2), 28.0f);
    }
    dl->PopClipRect();

    // Notch
    float notchW = phoneW * 0.30f;
    float notchH = 22.0f;
    ImVec2 na(sa.x+(phoneW-2*pad-notchW)*0.5f, sa.y+4);
    ImVec2 nb(na.x+notchW, na.y+notchH);
    dl->AddRectFilled(na, nb, IM_COL32(0,0,0,255), 12.0f);

    float cx = sa.x;
    float cy = sa.y;
    float w  = sb.x - sa.x;

    // Header — close (X) on the left, "NOW PLAYING" / server name in the
    // middle, and a small kebab on the right. We deliberately drop the
    // 9:41 / WiFi placeholders so the overlay doesn't pretend to be a real
    // phone status bar.
    float hdrY = cy + 36;
    if (IconBtn(ICON_CLOSE, cx+24, hdrY+18, 16, kY_BtnBg, kY_Text))
        Hide();
    const char* nowPlaying = "NOW PLAYING";
    ImVec2 npSize = ImGui::CalcTextSize(nowPlaying);
    dl->AddText(ImVec2(cx + (w-npSize.x)*0.5f, hdrY+4), kY_TextSub, nowPlaying);
    const char* serverName = "Havana RP";
    ImVec2 srvSize = ImGui::CalcTextSize(serverName);
    dl->AddText(ImVec2(cx + (w-srvSize.x)*0.5f, hdrY+22), kY_Text, serverName);
    // Top right — TOP 10 toggle (replaces the old kebab menu).  Tapping
    // switches the overlay between the regular YouTube-URL player and a
    // curated playlist of pre-bundled tracks served by the relay.
    {
        const char* tlbl = m_top10Open ? "BACK" : "TOP 10";
        ImVec2 tsz = ImGui::CalcTextSize(tlbl);
        float btnW = tsz.x + 18;
        float btnH = 22;
        float bx   = cx + w - 18 - btnW;
        float by   = hdrY + 18 - btnH * 0.5f;
        unsigned bg = m_top10Open
            ? IM_COL32(255, 138, 76, 220)
            : IM_COL32(255, 255, 255, 30);
        unsigned tx = m_top10Open
            ? IM_COL32(0, 0, 0, 255)
            : kY_Text;
        if (BigButton(tlbl, bx, by, btnW, btnH, bg, bg, tx))
        {
            m_top10Open = !m_top10Open;
            if (m_top10Open && m_top10LoadState == 0)
                StartLoadTop10();
        }
    }

    // URL input — directly under the header, above the album art.
    float ipY  = hdrY + 50;
    float ipH  = 38;
    float ipPad = 18;
    ImVec2 ipa(cx + ipPad, ipY), ipb(cx + w - ipPad, ipY + ipH);
    dl->AddRectFilled(ipa, ipb, IM_COL32(255,255,255,18), 12.0f);
    dl->AddRect(ipa, ipb, IM_COL32(255,255,255,40), 12.0f);

    // PASTE / PLAY share the right edge of the input pill — reserve their
    // width up front so the URL display has a hard right boundary.
    float pasteW = 56;
    float playW  = 56;
    float pasteX = ipb.x - pasteW - playW - 8;
    float urlMaxX = pasteX - 8;

    // URL display — drawn manually with a clip rect so long links never
    // bleed into the PASTE/PLAY buttons or, worse, escape the phone frame.
    ImVec2 urlClipA(ipa.x + 4, ipa.y);
    ImVec2 urlClipB(urlMaxX,   ipb.y);
    dl->PushClipRect(urlClipA, urlClipB, true);
    if (m_inputUrl[0])
    {
        // Right-align the tail of the URL so the most useful part (the
        // video id at the end) is always on screen.
        ImVec2 ts = ImGui::CalcTextSize(m_inputUrl);
        float xpos = ipa.x + 12;
        if (xpos + ts.x > urlMaxX - 6)
            xpos = urlMaxX - 6 - ts.x;
        dl->AddText(ImVec2(xpos, ipa.y+(ipH-14)*0.5f), kY_Text, m_inputUrl);
    }
    else
    {
        dl->AddText(ImVec2(ipa.x+12, ipa.y+(ipH-14)*0.5f), kY_TextDim,
                    "Tap PASTE to load URL from clipboard");
    }
    dl->PopClipRect();

    // PASTE button — grabs the clipboard contents on tap.
    if (BigButton("PASTE", pasteX, ipa.y+4, pasteW, ipH-8,
                  IM_COL32(255,255,255,30), IM_COL32(255,255,255,55),
                  IM_COL32(255,255,255,235)))
    {
        if (g_pJavaWrapper)
        {
            std::string clip = g_pJavaWrapper->GetClipboardString();
            if (!clip.empty())
            {
                size_t n = clip.size();
                if (n >= sizeof(m_inputUrl)) n = sizeof(m_inputUrl) - 1;
                memcpy(m_inputUrl, clip.data(), n);
                m_inputUrl[n] = '\0';
                // Trim trailing whitespace.
                while (n > 0 && (m_inputUrl[n-1]==' '||m_inputUrl[n-1]=='\n'||
                                 m_inputUrl[n-1]=='\r'||m_inputUrl[n-1]=='\t'))
                    m_inputUrl[--n] = '\0';
            }
        }
    }

    // PLAY button — starts the stream.
    float pbX = ipb.x - playW;
    if (BigButton("PLAY", pbX, ipa.y+4, playW, ipH-8,
                  IM_COL32(255,255,255,235), IM_COL32(255,255,255,255),
                  IM_COL32(0,0,0,255)))
    {
        if (m_inputUrl[0])
        {
            if (IsYouTubeUrl(m_inputUrl))
                StartResolve(m_inputUrl);
            else
            {
                m_resolvedUrl = m_inputUrl;
                m_title  = "Direct stream";
                m_artist = m_inputUrl;
                StartStream(m_inputUrl);
            }
        }
    }

    // When the TOP 10 panel is open we hand the lower body off to the
    // playlist renderer and skip the album-art / progress / controls.
    if (m_top10Open)
    {
        float listY = ipY + ipH + 12;
        float listH = (sb.y - 70) - listY;
        RenderTop10List(cx + ipPad, listY, w - 2*ipPad, listH);
        DrawServerBar(cx+ipPad, sb.y - 60, w - 2*ipPad);
        float hiW = 90, hiH = 4;
        dl->AddRectFilled(ImVec2(sb.x - phoneW*0.5f - hiW*0.5f + 4, sb.y - 8),
                          ImVec2(sb.x - phoneW*0.5f + hiW*0.5f + 4, sb.y - 8 + hiH),
                          IM_COL32(255,255,255,80), 2.0f);
        if (io.KeysDown[256/*ESC*/] ||
            (io.MouseClicked[0] && !PointInRect(io.MousePos, pa, pb)))
            Hide();
        return;
    }

    // Album art (square)
    float artPad = ipPad;
    float artSize = w - 2*artPad;
    if (artSize > phoneH * 0.36f) artSize = phoneH * 0.36f;
    float artY = ipY + ipH + 14;
    DrawAlbumArt(cx + (w-artSize)*0.5f, artY, artSize);

    // Track info
    float infoY = artY + artSize + 14;
    char buf[256];
    if (m_streamState == YTM_S_RESOLVE)
        snprintf(buf, sizeof(buf), "Resolving YouTube...");
    else if (!m_title.empty())
        snprintf(buf, sizeof(buf), "%s", m_title.c_str());
    else
        snprintf(buf, sizeof(buf), "Midnight Boulevard");
    dl->AddText(ImVec2(cx+ipPad, infoY), kY_Text, buf);

    // Second line: artist on success, or the error message if there is one.
    if (m_streamState == YTM_S_ERROR && !m_lastError.empty())
        snprintf(buf, sizeof(buf), "Error: %s", m_lastError.c_str());
    else if (!m_artist.empty())
        snprintf(buf, sizeof(buf), "%s", m_artist.c_str());
    else
        snprintf(buf, sizeof(buf), "Neon Drift  ·  Late Night Cruise");
    dl->AddText(ImVec2(cx+ipPad, infoY+18),
                m_streamState == YTM_S_ERROR ? kY_Heart : kY_TextDim, buf);

    // Heart (like) toggle
    if (IconBtn(m_liked ? ICON_HEART_F : ICON_HEART,
                cx + w - ipPad - 14, infoY + 14, 14,
                kY_BtnBg, m_liked ? kY_Heart : kY_TextDim))
        m_liked = !m_liked;

    // Progress bar
    float pgY = infoY + 50;
    DrawProgressBar(cx+ipPad, pgY, w - 2*ipPad);

    // Controls row
    float ctrlY = pgY + 38;
    float midX = cx + w * 0.5f;
    if (IconBtn(ICON_SHUFFLE, cx+ipPad+18, ctrlY, 18,
                kY_BtnBg, m_shuffle ? kY_Accent1 : kY_TextDim))
        m_shuffle = !m_shuffle;
    if (IconBtn(ICON_PREV, midX-58, ctrlY, 22, kY_BtnBg, kY_Text))
    {
        // skip-prev: rewind 30s
        if (m_streamHandle && g_bassNet.ChannelSeconds2Bytes &&
            g_bassNet.ChannelSetPosition)
        {
            double now = GetPosition();
            double t2 = now - 30; if (t2 < 0) t2 = 0;
            QWORD_ b2 = g_bassNet.ChannelSeconds2Bytes(m_streamHandle, t2);
            g_bassNet.ChannelSetPosition(m_streamHandle, b2, BASS_POS_BYTE_);
        }
    }

    // Big Play / Pause — black filled circle to match TSX reference.
    bool isPlaying = (m_streamState == YTM_S_PLAYING);
    if (IconBtn(isPlaying ? ICON_PAUSE : ICON_PLAY, midX, ctrlY, 32,
                IM_COL32(255,255,255,240), IM_COL32(0,0,0,255)))
    {
        if (m_streamHandle == 0)
        {
            // No stream loaded yet — try to start from input
            if (m_inputUrl[0])
            {
                if (IsYouTubeUrl(m_inputUrl)) StartResolve(m_inputUrl);
                else StartStream(m_inputUrl);
            }
        }
        else if (isPlaying)
            PauseStream();
        else
            ResumeStream();
    }

    if (IconBtn(ICON_NEXT, midX+58, ctrlY, 22, kY_BtnBg, kY_Text))
    {
        // skip-next: fast-forward 30s
        if (m_streamHandle && g_bassNet.ChannelSeconds2Bytes &&
            g_bassNet.ChannelSetPosition)
        {
            double now = GetPosition();
            double t2 = now + 30;
            QWORD_ b2 = g_bassNet.ChannelSeconds2Bytes(m_streamHandle, t2);
            g_bassNet.ChannelSetPosition(m_streamHandle, b2, BASS_POS_BYTE_);
        }
    }

    if (IconBtn(ICON_REPEAT, cx+w-ipPad-18, ctrlY, 18,
                kY_BtnBg, m_loop ? kY_Accent1 : kY_TextDim))
        m_loop = !m_loop;

    // Volume
    float volY = ctrlY + 40;
    DrawVolumeBar(cx+ipPad, volY, w - 2*ipPad);

    // Server bar at bottom
    DrawServerBar(cx+ipPad, sb.y - 60, w - 2*ipPad);

    // Home indicator
    float hiW = 90, hiH = 4;
    dl->AddRectFilled(ImVec2(sb.x - phoneW*0.5f - hiW*0.5f + 4, sb.y - 8),
                      ImVec2(sb.x - phoneW*0.5f + hiW*0.5f + 4, sb.y - 8 + hiH),
                      IM_COL32(255,255,255,80), 2.0f);

    // ESC closes the overlay (and a tap outside the phone area too).
    if (io.KeysDown[256/*ESC*/] ||
        (io.MouseClicked[0] && !PointInRect(io.MousePos, pa, pb)))
    {
        // Slide back down on close (but for simplicity, just hide directly).
        Hide();
    }
}
