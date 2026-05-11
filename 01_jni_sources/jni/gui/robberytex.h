#pragma once

// Loads the vault background PNG embedded in libsamp.so and exposes it
// as an ImGui ImTextureID (RwRaster*).
namespace RobberyTex
{
    bool GetVault(void** outImTextureID,
                  int* outW, int* outH,
                  float* outU, float* outV);
}
