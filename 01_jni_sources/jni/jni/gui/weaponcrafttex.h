#pragma once

namespace WeaponCraftTex
{
    bool GetMinigameImage(void** outImTextureID,
                          int* outW, int* outH,
                          float* outU, float* outV);

    // RPG launcher icon used in the weapon list (the embedded rpg.png).
    bool GetWeaponIcon(void** outImTextureID,
                       int* outW, int* outH,
                       float* outU, float* outV);

    // Called once per frame from CGUI::Render() while the GTA renderer is
    // active.  After enough frames have elapsed the rasters are eagerly
    // pre-loaded from a guaranteed-safe place (NOT during overlay paint),
    // which avoids any first-show race with RenderWare.
    void Tick();
}
