// Self-contained audio for the House Guard overlay.
//
// Uses BASS via dlsym so we do not depend on chatwindow.cpp's symbol
// imports. WAV data is synthesized on the fly into memory buffers and
// loaded with BASS_SampleLoad. Each "play" then takes a fresh channel,
// which lets multiple overlapping sounds layer without restarting any
// in-flight sample.

#include "houseguardaudio.h"

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
        BOOL_ (*ChannelStop)(DWORD_ handle);
        BOOL_ (*ChannelSetAttribute)(DWORD_ handle, DWORD_ attrib, float value);
        BOOL_ (*ChannelFlags)(DWORD_ handle, DWORD_ flags, DWORD_ mask);
        BOOL_ (*ChannelIsActive)(DWORD_ handle);
    };

    static BassApi g_bass = {};
    static bool    g_loaded = false;
    static bool    g_loadFailed = false;

    static HSAMPLE_ g_sClick = 0;
    static HSAMPLE_ g_sHit   = 0;
    static HSAMPLE_ g_sMiss  = 0;
    static HSAMPLE_ g_sWin   = 0;
    static HSAMPLE_ g_sRetry = 0;
    static HSAMPLE_ g_sLoop  = 0;
    static HCHANNEL_ g_loopChan = 0;
    static bool      g_loopActive = false;

    // Hold WAV byte buffers alive for the lifetime of the process. BASS
    // copies them internally for samples, but keeping them allocated is
    // harmless and means we can reload if needed.
    static std::vector<std::vector<uint8_t>> g_keepAlive;

    // ---- BASS constants we need ------------------------------------------
    static const DWORD_ BASS_SAMPLE_LOOP_     = 4;
    static const DWORD_ BASS_SAMPLE_OVER_VOL_ = 0x10000;
    static const DWORD_ BASS_ATTRIB_VOL_      = 2;
    static const DWORD_ BASS_ATTRIB_PAN_      = 3;
    static const DWORD_ BASS_ACTIVE_STOPPED_  = 0;

    // ---- WAV synthesis helpers -------------------------------------------
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

    static void GenClick(std::vector<uint8_t>& out)
    {
        // Short two-tone snap: 1200 Hz over 1700 Hz, ~28 ms total.
        const uint32_t sr = 44100;
        const float dur = 0.03f;
        const int n = (int)(sr * dur);
        std::vector<int16_t> s(n);
        const float pi2 = 6.2831853f;
        for (int i = 0; i < n; ++i)
        {
            float t = (float)i / (float)sr;
            // Fast attack, exponential decay
            float env = expf(-t * 80.0f);
            if (t < 0.0008f) env *= (t / 0.0008f);
            float v = sinf(pi2 * 1700.0f * t) * 0.5f
                    + sinf(pi2 * 1200.0f * t) * 0.4f;
            s[i] = Clamp16(v * env * 18000.0f);
        }
        Wav16(out, s, sr);
    }

    static void GenHit(std::vector<uint8_t>& out)
    {
        // Bright two-note "ding": rising fifth, ~140 ms.
        const uint32_t sr = 44100;
        const float dur = 0.16f;
        const int n = (int)(sr * dur);
        std::vector<int16_t> s(n);
        const float pi2 = 6.2831853f;
        for (int i = 0; i < n; ++i)
        {
            float t = (float)i / (float)sr;
            float env = expf(-t * 8.0f);
            if (t < 0.003f) env *= (t / 0.003f);
            float f = (t < 0.04f) ? 1320.0f : 1980.0f;
            float v = sinf(pi2 * f * t) * 0.6f
                    + sinf(pi2 * (f * 2.0f) * t) * 0.18f;
            s[i] = Clamp16(v * env * 19000.0f);
        }
        Wav16(out, s, sr);
    }

    static void GenMiss(std::vector<uint8_t>& out)
    {
        // Dull descending thud, ~180 ms.
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
            float f = 320.0f - 180.0f * t * 4.0f;
            if (f < 90.0f) f = 90.0f;
            float v = sinf(pi2 * f * t) * 0.55f
                    + (((float)rand() / (float)RAND_MAX) - 0.5f) * 0.18f;
            s[i] = Clamp16(v * env * 17000.0f);
        }
        Wav16(out, s, sr);
    }

    static void GenWin(std::vector<uint8_t>& out)
    {
        // Three-note arpeggio: C5, E5, G5, ~520 ms total.
        const uint32_t sr = 44100;
        const float dur = 0.55f;
        const int n = (int)(sr * dur);
        std::vector<int16_t> s(n);
        const float pi2 = 6.2831853f;
        const float notes[3] = { 523.25f, 659.25f, 783.99f };
        for (int i = 0; i < n; ++i)
        {
            float t = (float)i / (float)sr;
            int idx = (int)(t / 0.13f);
            if (idx > 2) idx = 2;
            float lt = t - idx * 0.13f;
            float env = expf(-lt * 5.0f);
            if (lt < 0.005f) env *= (lt / 0.005f);
            float f = notes[idx];
            float v = sinf(pi2 * f * t) * 0.55f
                    + sinf(pi2 * (f * 2.0f) * t) * 0.18f;
            s[i] = Clamp16(v * env * 19000.0f);
        }
        Wav16(out, s, sr);
    }

    static void GenRetry(std::vector<uint8_t>& out)
    {
        // Two-tone descending alert, ~280 ms.
        const uint32_t sr = 44100;
        const float dur = 0.32f;
        const int n = (int)(sr * dur);
        std::vector<int16_t> s(n);
        const float pi2 = 6.2831853f;
        for (int i = 0; i < n; ++i)
        {
            float t = (float)i / (float)sr;
            float env = expf(-t * 5.0f);
            if (t < 0.005f) env *= (t / 0.005f);
            float f = (t < 0.13f) ? 660.0f : 440.0f;
            float v = sinf(pi2 * f * t) * 0.5f;
            s[i] = Clamp16(v * env * 17000.0f);
        }
        Wav16(out, s, sr);
    }

    static void GenLoop(std::vector<uint8_t>& out)
    {
        // 1.0 s loop of a soft 110 Hz pad with 7 Hz tremolo. Loops at zero
        // crossings so it's seamless. Volume is intentionally low — the
        // overlay plays it at ~0.18 master.
        const uint32_t sr = 44100;
        const int n = sr; // exactly 1 second
        std::vector<int16_t> s(n);
        const float pi2 = 6.2831853f;
        for (int i = 0; i < n; ++i)
        {
            float t = (float)i / (float)sr;
            float trem = 0.5f + 0.5f * sinf(pi2 * 7.0f * t);
            float v = sinf(pi2 * 110.0f * t) * 0.40f
                    + sinf(pi2 * 220.0f * t) * 0.15f
                    + sinf(pi2 * 165.0f * t) * 0.10f;
            // Soft fade-in/out at the seam to remove click on loop.
            float seam = 1.0f;
            const float fadeT = 0.01f;
            if (t < fadeT)         seam = t / fadeT;
            else if (t > 1.0f - fadeT) seam = (1.0f - t) / fadeT;
            s[i] = Clamp16(v * (0.4f + 0.6f * trem) * seam * 12000.0f);
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

        g_bass.SampleLoad         = (decltype(g_bass.SampleLoad))dlsym(h, "BASS_SampleLoad");
        g_bass.SampleGetChannel   = (decltype(g_bass.SampleGetChannel))dlsym(h, "BASS_SampleGetChannel");
        g_bass.ChannelPlay        = (decltype(g_bass.ChannelPlay))dlsym(h, "BASS_ChannelPlay");
        g_bass.ChannelStop        = (decltype(g_bass.ChannelStop))dlsym(h, "BASS_ChannelStop");
        g_bass.ChannelSetAttribute= (decltype(g_bass.ChannelSetAttribute))dlsym(h, "BASS_ChannelSetAttribute");
        g_bass.ChannelFlags       = (decltype(g_bass.ChannelFlags))dlsym(h, "BASS_ChannelFlags");
        g_bass.ChannelIsActive    = (decltype(g_bass.ChannelIsActive))dlsym(h, "BASS_ChannelIsActive");

        if (!g_bass.SampleLoad || !g_bass.SampleGetChannel ||
            !g_bass.ChannelPlay || !g_bass.ChannelSetAttribute)
        { g_loadFailed = true; return false; }

        g_loaded = true;
        return true;
    }

    static HSAMPLE_ MakeSample(void (*gen)(std::vector<uint8_t>&), DWORD_ flags = 0)
    {
        std::vector<uint8_t> wav;
        gen(wav);
        if (wav.empty()) return 0;
        HSAMPLE_ samp = g_bass.SampleLoad(1 /*mem*/, wav.data(), 0,
                                          (DWORD_)wav.size(), 8, flags);
        // Even though BASS copies the data internally, keep the buffer alive
        // anyway so older BASS builds don't surprise us.
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

namespace HouseGuardAudio
{
    void Init()
    {
        if (g_loaded || g_loadFailed) {} else if (!LoadBassApi()) return;
        if (g_sClick) return; // already built
        g_sClick = MakeSample(GenClick);
        g_sHit   = MakeSample(GenHit);
        g_sMiss  = MakeSample(GenMiss);
        g_sWin   = MakeSample(GenWin);
        g_sRetry = MakeSample(GenRetry);
        g_sLoop  = MakeSample(GenLoop, BASS_SAMPLE_LOOP_);
    }

    void PlayClick() { Init(); PlayOnce(g_sClick, 0.75f); }
    void PlayHit()   { Init(); PlayOnce(g_sHit,   0.85f); }
    void PlayMiss()  { Init(); PlayOnce(g_sMiss,  0.80f); }
    void PlayWin()   { Init(); PlayOnce(g_sWin,   0.90f); }
    void PlayRetry() { Init(); PlayOnce(g_sRetry, 0.80f); }

    void StartLoop()
    {
        Init();
        if (!g_loaded || !g_sLoop) return;
        if (g_loopActive && g_loopChan)
        {
            // already running
            return;
        }
        g_loopChan = g_bass.SampleGetChannel(g_sLoop, 0);
        if (!g_loopChan) return;
        g_bass.ChannelSetAttribute(g_loopChan, BASS_ATTRIB_VOL_, 0.18f);
        g_bass.ChannelPlay(g_loopChan, 1);
        g_loopActive = true;
    }

    void StopLoop()
    {
        if (!g_loaded || !g_loopActive || !g_loopChan) return;
        if (g_bass.ChannelStop) g_bass.ChannelStop(g_loopChan);
        g_loopChan = 0;
        g_loopActive = false;
    }
}
