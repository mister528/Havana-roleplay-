// Self-contained audio for the Fisherman overlay. Uses BASS via dlsym.
// All sounds are synthesized PCM clips kept in memory.

#include "fishermanaudio.h"

#include <dlfcn.h>
#include <cmath>
#include <cstdint>
#include <cstring>
#include <cstdlib>
#include <vector>

namespace
{
    using BOOL_ = int;
    using DWORD_ = unsigned int;
    using QWORD_ = unsigned long long;
    using HSAMPLE_ = unsigned int;
    using HCHANNEL_ = unsigned int;

    struct BassApi
    {
        HSAMPLE_ (*SampleLoad)(BOOL_ mem, const void* file, QWORD_ offset,
                               DWORD_ length, DWORD_ max, DWORD_ flags);
        HCHANNEL_ (*SampleGetChannel)(HSAMPLE_ handle, BOOL_ onlynew);
        BOOL_ (*ChannelPlay)(DWORD_ handle, BOOL_ restart);
        BOOL_ (*ChannelSetAttribute)(DWORD_ handle, DWORD_ attrib, float value);
    };

    static BassApi g_bass = {};
    static bool    g_loaded = false;
    static bool    g_loadFailed = false;

    static HSAMPLE_ g_sCast    = 0;
    static HSAMPLE_ g_sReel    = 0;
    static HSAMPLE_ g_sBite    = 0;
    static HSAMPLE_ g_sCatch   = 0;
    static HSAMPLE_ g_sMiss    = 0;
    static HSAMPLE_ g_sSuccess = 0;
    static HSAMPLE_ g_sClick   = 0;

    static std::vector<std::vector<uint8_t>> g_keepAlive;

    static const DWORD_ BASS_ATTRIB_VOL_ = 2;
    static const DWORD_ BASS_ATTRIB_PAN_ = 3;

    static void Wav16(std::vector<uint8_t>& out,
                      const std::vector<int16_t>& samples,
                      uint32_t sampleRate)
    {
        out.clear();
        const uint32_t dataBytes = (uint32_t)(samples.size() * sizeof(int16_t));
        const uint32_t fileSize  = 36 + dataBytes;
        out.resize(44 + dataBytes);
        uint8_t* p = out.data();
        memcpy(p, "RIFF", 4); p += 4;
        memcpy(p, &fileSize, 4); p += 4;
        memcpy(p, "WAVE", 4); p += 4;
        memcpy(p, "fmt ", 4); p += 4;
        uint32_t fmtLen = 16;       memcpy(p, &fmtLen, 4);   p += 4;
        uint16_t fmtTag = 1;        memcpy(p, &fmtTag, 2);   p += 2;
        uint16_t chans  = 1;        memcpy(p, &chans, 2);    p += 2;
        memcpy(p, &sampleRate, 4);  p += 4;
        uint32_t byteRate = sampleRate * chans * 2;
        memcpy(p, &byteRate, 4);    p += 4;
        uint16_t blockAlign = chans * 2;
        memcpy(p, &blockAlign, 2);  p += 2;
        uint16_t bps = 16;          memcpy(p, &bps, 2);      p += 2;
        memcpy(p, "data", 4);       p += 4;
        memcpy(p, &dataBytes, 4);   p += 4;
        memcpy(p, samples.data(), dataBytes);
    }

    static int16_t Clamp16(float v)
    {
        if (v >  32767.0f) v =  32767.0f;
        if (v < -32768.0f) v = -32768.0f;
        return (int16_t)v;
    }

    // ---- Sound generators ----

    // Cast: whip swoosh (fast falling pitch) + water splash (burst noise).
    static void GenCast(std::vector<uint8_t>& out)
    {
        const uint32_t sr = 44100;
        const float dur = 0.55f;
        const int n = (int)(sr * dur);
        std::vector<int16_t> s(n);
        const float pi2 = 6.2831853f;
        unsigned seed = 0x17a5;
        for (int i = 0; i < n; ++i)
        {
            float t = (float)i / (float)sr;
            float v = 0.0f;

            // Whip swoosh: 0..180ms, freq falls 1600->350 Hz
            if (t < 0.22f)
            {
                float wt = t / 0.22f;
                float f = 1600.0f - 1250.0f * wt;
                float env = sinf(3.14159f * wt); // bell
                v += sinf(pi2 * f * t) * env * 0.45f;
                // airy noise layer
                seed = seed * 1664525u + 1013904223u;
                float nz = ((int)(seed >> 16) - 32768) / 32768.0f;
                v += nz * env * 0.15f;
            }

            // Splash: 0.20s..0.55s, filtered noise, decays
            if (t > 0.20f)
            {
                float st = (t - 0.20f) / 0.35f;
                float env = expf(-st * 5.5f) * (1.0f - expf(-st * 40.0f));
                seed = seed * 1664525u + 1013904223u;
                float nz = ((int)(seed >> 16) - 32768) / 32768.0f;
                // low-pass feel via simple sin modulation
                float body = nz * 0.55f
                           + sinf(pi2 * 320.0f * t) * 0.10f
                           + sinf(pi2 * 180.0f * t) * 0.08f;
                v += body * env * 0.55f;
            }

            s[i] = Clamp16(v * 19000.0f);
        }
        Wav16(out, s, sr);
    }

    // Reel: short mechanical click (per-tap), ~22ms.
    static void GenReel(std::vector<uint8_t>& out)
    {
        const uint32_t sr = 44100;
        const float dur = 0.028f;
        const int n = (int)(sr * dur);
        std::vector<int16_t> s(n);
        const float pi2 = 6.2831853f;
        for (int i = 0; i < n; ++i)
        {
            float t = (float)i / (float)sr;
            float env = expf(-t * 140.0f);
            if (t < 0.0004f) env *= (t / 0.0004f);
            float v = sinf(pi2 * 2200.0f * t) * 0.50f
                    + sinf(pi2 * 1350.0f * t) * 0.35f;
            s[i] = Clamp16(v * env * 15000.0f);
        }
        Wav16(out, s, sr);
    }

    // Bite: quick "bloop" — bright upward chirp, ~120ms.
    static void GenBite(std::vector<uint8_t>& out)
    {
        const uint32_t sr = 44100;
        const float dur = 0.14f;
        const int n = (int)(sr * dur);
        std::vector<int16_t> s(n);
        const float pi2 = 6.2831853f;
        for (int i = 0; i < n; ++i)
        {
            float t = (float)i / (float)sr;
            float env = expf(-t * 12.0f);
            if (t < 0.003f) env *= (t / 0.003f);
            float f = 520.0f + 1400.0f * t; // up-chirp
            float v = sinf(pi2 * f * t) * 0.55f
                    + sinf(pi2 * (f * 1.5f) * t) * 0.20f;
            s[i] = Clamp16(v * env * 17000.0f);
        }
        Wav16(out, s, sr);
    }

    // Catch: bright rising arpeggio (C5-E5-G5) + shimmer, ~360ms.
    static void GenCatch(std::vector<uint8_t>& out)
    {
        const uint32_t sr = 44100;
        const float dur = 0.40f;
        const int n = (int)(sr * dur);
        std::vector<int16_t> s(n);
        const float pi2 = 6.2831853f;
        for (int i = 0; i < n; ++i)
        {
            float t = (float)i / (float)sr;
            float env = expf(-t * 4.5f);
            if (t < 0.004f) env *= (t / 0.004f);
            float f;
            if      (t < 0.10f) f = 523.25f; // C5
            else if (t < 0.22f) f = 659.25f; // E5
            else                f = 783.99f; // G5
            float v = sinf(pi2 * f * t) * 0.55f
                    + sinf(pi2 * (f * 2.0f) * t) * 0.20f
                    + sinf(pi2 * (f * 3.0f) * t) * 0.08f;
            s[i] = Clamp16(v * env * 18500.0f);
        }
        Wav16(out, s, sr);
    }

    // Miss: dull descending thud 320 -> 90 Hz, ~200ms.
    static void GenMiss(std::vector<uint8_t>& out)
    {
        const uint32_t sr = 44100;
        const float dur = 0.22f;
        const int n = (int)(sr * dur);
        std::vector<int16_t> s(n);
        const float pi2 = 6.2831853f;
        for (int i = 0; i < n; ++i)
        {
            float t = (float)i / (float)sr;
            float env = expf(-t * 6.0f);
            if (t < 0.004f) env *= (t / 0.004f);
            float f = 320.0f - 230.0f * (t / dur);
            if (f < 90.0f) f = 90.0f;
            float v = sinf(pi2 * f * t) * 0.60f;
            s[i] = Clamp16(v * env * 16000.0f);
        }
        Wav16(out, s, sr);
    }

    // Success (job complete): triple-note fanfare + sustain.
    static void GenSuccess(std::vector<uint8_t>& out)
    {
        const uint32_t sr = 44100;
        const float dur = 0.85f;
        const int n = (int)(sr * dur);
        std::vector<int16_t> s(n);
        const float pi2 = 6.2831853f;
        for (int i = 0; i < n; ++i)
        {
            float t = (float)i / (float)sr;
            float env = expf(-t * 1.8f);
            if (t < 0.004f) env *= (t / 0.004f);
            float f;
            if      (t < 0.16f) f = 659.25f; // E5
            else if (t < 0.32f) f = 783.99f; // G5
            else                f = 1046.5f; // C6 hold
            float v = sinf(pi2 * f * t) * 0.50f
                    + sinf(pi2 * (f * 2.0f) * t) * 0.18f
                    + sinf(pi2 * (f * 0.5f) * t) * 0.12f;
            s[i] = Clamp16(v * env * 18000.0f);
        }
        Wav16(out, s, sr);
    }

    // Generic UI click (slightly softer than cast).
    static void GenClick(std::vector<uint8_t>& out)
    {
        const uint32_t sr = 44100;
        const float dur = 0.03f;
        const int n = (int)(sr * dur);
        std::vector<int16_t> s(n);
        const float pi2 = 6.2831853f;
        for (int i = 0; i < n; ++i)
        {
            float t = (float)i / (float)sr;
            float env = expf(-t * 80.0f);
            if (t < 0.0008f) env *= (t / 0.0008f);
            float v = sinf(pi2 * 1500.0f * t) * 0.45f
                    + sinf(pi2 * 1100.0f * t) * 0.35f;
            s[i] = Clamp16(v * env * 15000.0f);
        }
        Wav16(out, s, sr);
    }

    static bool LoadBassApi()
    {
        if (g_loaded) return true;
        if (g_loadFailed) return false;

        void* h = dlopen("/data/data/com.luxury.mobile/lib/libbass.so", 3);
        if (!h) h = dlopen("libbass.so", 3);
        if (!h) { g_loadFailed = true; return false; }

        g_bass.SampleLoad          = (decltype(g_bass.SampleLoad))dlsym(h, "BASS_SampleLoad");
        g_bass.SampleGetChannel    = (decltype(g_bass.SampleGetChannel))dlsym(h, "BASS_SampleGetChannel");
        g_bass.ChannelPlay         = (decltype(g_bass.ChannelPlay))dlsym(h, "BASS_ChannelPlay");
        g_bass.ChannelSetAttribute = (decltype(g_bass.ChannelSetAttribute))dlsym(h, "BASS_ChannelSetAttribute");

        if (!g_bass.SampleLoad || !g_bass.SampleGetChannel ||
            !g_bass.ChannelPlay || !g_bass.ChannelSetAttribute)
        { g_loadFailed = true; return false; }

        g_loaded = true;
        return true;
    }

    static HSAMPLE_ MakeSample(void (*gen)(std::vector<uint8_t>&),
                               DWORD_ maxChans = 8)
    {
        std::vector<uint8_t> wav;
        gen(wav);
        if (wav.empty()) return 0;
        HSAMPLE_ samp = g_bass.SampleLoad(1, wav.data(), 0,
                                          (DWORD_)wav.size(), maxChans, 0);
        g_keepAlive.push_back(std::move(wav));
        return samp;
    }

    static void PlayOnce(HSAMPLE_ samp, float vol = 0.85f, float pan = 0.0f)
    {
        if (!samp || !g_loaded) return;
        HCHANNEL_ ch = g_bass.SampleGetChannel(samp, 0);
        if (!ch) return;
        g_bass.ChannelSetAttribute(ch, BASS_ATTRIB_VOL_, vol);
        g_bass.ChannelSetAttribute(ch, BASS_ATTRIB_PAN_, pan);
        g_bass.ChannelPlay(ch, 1);
    }
}

namespace FishermanAudio
{
    void Init()
    {
        if (!g_loaded && !g_loadFailed) { if (!LoadBassApi()) return; }
        if (!g_loaded) return;
        if (g_sCast) return;
        g_sCast    = MakeSample(GenCast);
        g_sReel    = MakeSample(GenReel, 16); // many overlapping taps
        g_sBite    = MakeSample(GenBite);
        g_sCatch   = MakeSample(GenCatch);
        g_sMiss    = MakeSample(GenMiss);
        g_sSuccess = MakeSample(GenSuccess);
        g_sClick   = MakeSample(GenClick, 12);
    }

    void PlayCast()    { Init(); PlayOnce(g_sCast,    0.92f); }
    void PlayReel()    { Init(); PlayOnce(g_sReel,    0.65f); }
    void PlayBite()    { Init(); PlayOnce(g_sBite,    0.85f); }
    void PlayCatch()   { Init(); PlayOnce(g_sCatch,   0.90f); }
    void PlayMiss()    { Init(); PlayOnce(g_sMiss,    0.80f); }
    void PlaySuccess() { Init(); PlayOnce(g_sSuccess, 0.92f); }
    void PlayClick()   { Init(); PlayOnce(g_sClick,   0.55f); }
}
