#pragma once

// Lazy-loads the GTA:SA skin portrait for skinId (0..311) and returns a
// handle suitable for passing to ImGui::AddImage / ImGui::Image as
// ImTextureID (a `RwRaster*` pointer cast).
//
// outW/outH receive the *image* dimensions (used for aspect ratio).
// outU/outV receive the UV1 the caller should pass to AddImage so that
// only the actual image portion of the (possibly power-of-two padded)
// raster is sampled.
//
// Returns false if the skin id is unknown or PNG decoding failed.
bool SkinTex_Get(int skinId, void** outImTextureID,
                 int* outW, int* outH,
                 float* outU = nullptr, float* outV = nullptr);
