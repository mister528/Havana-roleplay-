#pragma once
#include <stdint.h>
#include <string>
#include <vector>
#include <pthread.h>

// =============================================================================
//  HavanaRp — YouTube / Direct-stream Music Overlay
//  ---------------------------------------------------------------------------
//  Pairs with the gamemode-side `/ytmusic` command. The server fires
//  ShowPlayerDialog() with title "HAVANA_YTMUSIC" (or "HAVANA_YTMUSIC_URL"
//  with a pre-filled URL in the body) and the launcher captures it,
//  closes the stock dialog and brings up a polished, phone-style media
//  player that slides in from the bottom of the screen.
//
//  Audio playback is handled via BASS (libbass.so resolved at runtime
//  through dlsym, mirroring houseguardaudio.cpp). For direct stream
//  URLs (mp3 / aac / shoutcast / icecast) BASS_StreamCreateURL is
//  invoked directly; for youtube.com / youtu.be / music.youtube.com
//  links we hit the public Cobalt API
//  (https://co.wuk.sh/api/json) through a minimal JNI bridge that
//  opens an HTTPS connection from the Android side, parses the
//  returned JSON, and feeds the resolved media stream URL back into
//  BASS_StreamCreateURL.
//
//  Visual style is inspired by samp-music-overlay/MusicPhone.tsx — a
//  vertical phone-style frame with an album-art square, ambient glow,
//  track info, progress bar with thumb, transport buttons (shuffle /
//  prev / play / next / repeat), and a server-bar at the bottom.
// =============================================================================

enum EYtmState
{
    YTM_HIDDEN = 0,
    YTM_OPEN   = 1
};

enum EYtmStream
{
    YTM_S_IDLE     = 0,
    YTM_S_RESOLVE  = 1,   // calling Cobalt to extract direct URL
    YTM_S_BUFFER   = 2,   // BASS_StreamCreateURL is opening
    YTM_S_PLAYING  = 3,
    YTM_S_PAUSED   = 4,
    YTM_S_ERROR    = 5
};

class CYtMusicOverlay
{
public:
    CYtMusicOverlay();
    ~CYtMusicOverlay();

    bool TryHandleDialog(uint16_t dialogId, uint8_t style,
                         const char* title, const char* body);
    void Show(const char* prefilledUrl);
    void Hide();
    bool IsVisible() const { return m_state == YTM_OPEN; }
    void Render();

    // ----- Multiplayer spatial-audio bridge
    //
    // The gamemode rebroadcasts every "[HAV_YTM]PLAY:<pid>:<idx>" /
    // "[HAV_YTM]STOP:<pid>" line via SendClientMessageToAll(). The
    // launcher's RPC handler (netrpc.cpp) detects the prefix, consumes
    // the line so it never hits chat, and forwards the parsed payload
    // to one of these functions. We then download the same top-10 file
    // and play it locally with a per-frame distance-based volume
    // attenuation (0..30m falloff), so other players in earshot hear
    // the broadcaster's track.
    void HandleRemotePlay(int playerid, int trackIdx);
    void HandleRemoteStop(int playerid);
    void HandleRemoteAll(); // wipe every remote stream (e.g. on disconnect)
    // Called every frame from CYtMusicOverlay::Render() (and indirectly
    // from gui.cpp). Walks the active remote streams, recomputes their
    // BASS volume based on distance to the local player.
    void TickRemoteVolumes();
    // Tell the server I started / stopped a top-10 track.  Implemented
    // via SendChatCommand("/_yt N") and "/_ytstop". The server side then
    // re-broadcasts as a [HAV_YTM]... client message.
    void NotifyServerPlay(int trackIdx);
    void NotifyServerStop();

private:
    // Vector icon ids — drawn with primitive shapes so we don't depend
    // on the bundled font having transport-control glyphs.
    enum EIcon
    {
        ICON_CLOSE   = 0,
        ICON_MORE    = 1,
        ICON_HEART   = 2,
        ICON_HEART_F = 3,
        ICON_SHUFFLE = 4,
        ICON_PREV    = 5,
        ICON_PLAY    = 6,
        ICON_PAUSE   = 7,
        ICON_NEXT    = 8,
        ICON_REPEAT  = 9,
        ICON_VOLUME  = 10,
        ICON_LOUD    = 11
    };

    // ----- Render passes
    void RenderPhone(float scrW, float scrH);
    void RenderMiniHUD(float scrW, float scrH);
    bool BigButton(const char* label, float x, float y, float w, float h,
                   unsigned col, unsigned colHover, unsigned colText);
    bool RoundIconBtn(const char* glyph, float cx, float cy, float r,
                      unsigned bg, unsigned tint);
    bool IconBtn(int icon, float cx, float cy, float r,
                 unsigned bg, unsigned tint);
    void DrawIcon(int icon, float cx, float cy, float size, unsigned tint);
    void DrawAlbumArt(float x, float y, float size);
    void DrawProgressBar(float x, float y, float w);
    void DrawVolumeBar(float x, float y, float w);
    void DrawServerBar(float x, float y, float w);

    // ----- Audio
    bool   EnsureBassLoaded();
    bool   StartStream(const char* url, const char* userAgent = nullptr);
    void   StopStream();
    void   PauseStream();
    void   ResumeStream();
    void   SetVolume(float v);
    double GetPosition();
    double GetDuration();

    // ----- YouTube resolution (calls into Java via JNI bridge)
    static bool IsYouTubeUrl(const char* url);
    void   StartResolve(const char* url);
    void   PollResolve();   // checks the JNI side for a finished resolve

    // ----- Top-10 playlist (pre-bundled tracks served by the relay)
    struct Top10Entry
    {
        int         idx;
        std::string title;
        std::string artist;
        int         duration;   // seconds
    };
    void   StartLoadTop10();
    void   PlayTop10(int idx);
    void   RenderTop10List(float cx, float cy, float w, float h);
    static void* Top10ThreadFn(void* arg);

    // ----- State
    EYtmState   m_state;
    EYtmStream  m_streamState;
    uint16_t    m_dialogId;
    float       m_animT;          // 0..1 slide-up animation
    float       m_lastFrameTime;  // for delta-time animation

    // URL input
    char        m_inputUrl[512];
    bool        m_inputFocused;

    // Track info
    std::string m_title;
    std::string m_artist;
    std::string m_resolvedUrl;
    std::string m_lastError;

    // BASS handles
    unsigned int m_streamHandle;
    float        m_volume;
    bool         m_loop;
    bool         m_shuffle;
    bool         m_liked;

    // Top-10 playlist state
    bool                     m_top10Open;       // panel is shown
    int                      m_top10LoadState;  // 0=idle 1=loading 2=loaded -1=err
    std::vector<Top10Entry>  m_top10Tracks;
    pthread_t                m_top10Thread;
    bool                     m_top10ThreadStarted;
    float                    m_top10Scroll;     // scroll offset in pixels
    int                      m_top10NowIdx;     // currently-playing top10 idx, 0 if none

public:
    // Public so the worker-thread arg struct (defined inside the .cpp's
    // anonymous namespace) can reference RemoteStream by name.
    struct RemoteStream
    {
        int          playerid;
        int          trackIdx;
        unsigned int handle;       // BASS handle (0 until ready)
        volatile int state;        // 0=loading 1=playing 2=err 3=stopping
        pthread_t    thread;
        bool         threadStarted;
        std::vector<unsigned char> data;
        float        lastVolume;
    };

private:
    std::vector<RemoteStream*> m_remoteStreams;
    static void* RemoteFetchThreadFn(void* arg);
    RemoteStream* FindRemote(int playerid);
};

extern CYtMusicOverlay* pYtMusicOverlay;
