#pragma once

// Self-contained audio for the Fisherman overlay. Mirrors the
// HouseGuardAudio pattern: loads BASS via dlsym, generates short
// synthesized PCM clips on the fly, plays them on demand. No asset
// files required, no global engine order dependency.
namespace FishermanAudio
{
    void Init();         // safe to call repeatedly
    void PlayCast();     // rod whip + splash on rod cast
    void PlayReel();     // mechanical reel click (per tap)
    void PlayBite();     // fish bite notification
    void PlayCatch();    // bright catch fanfare
    void PlayMiss();     // fish got away (descending thud)
    void PlaySuccess();  // job-complete triple note
    void PlayClick();    // generic UI tap feedback
}
