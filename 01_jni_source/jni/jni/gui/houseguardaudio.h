#pragma once

// Self-contained audio for the House Guard overlay. Uses BASS via dlsym so
// it does not depend on the rest of the engine being initialized in any
// particular order. All sounds are tiny synthesized PCM clips kept in
// memory; no asset files are required.
namespace HouseGuardAudio
{
    void Init();          // safe to call repeatedly; no-op after success
    void PlayClick();     // generic tap feedback
    void PlayHit();       // bright "ding" on a successful tap
    void PlayMiss();      // dull buzz on a wrong tap
    void PlayWin();       // success fanfare
    void PlayRetry();     // soft alert on retry
    void StartLoop();     // start the rotation hum (looped, low volume)
    void StopLoop();      // stop the rotation hum
}
