// =====================================================================
// skintex.cpp
//
// Loads a 2D portrait PNG for any GTA:SA skin id (0..311) on demand and
// returns it as an RwRaster suitable for use as an ImGui ImTextureID
// (the imgui_impl_renderware backend in this project treats ImTextureID
// as a `RwRaster*` directly - see imgui_impl_renderware.cpp:105).
//
// PNGs are embedded into libsamp.so via .incbin from
// gui/skins_data/skins.dat. The blob layout is:
//      uint32  count                              (== 312)
//      [count] { uint32 offset; uint32 size; }    per skin id
//      raw PNG bytes                              (referenced by offset)
// =====================================================================

#include "../main.h"
#include "skintex.h"
#include "../game/RW/RenderWare.h"

#define STB_IMAGE_IMPLEMENTATION
#define STBI_NO_HDR
#define STBI_NO_LINEAR
#define STBI_NO_PIC
#define STBI_NO_PSD
#define STBI_NO_TGA
#define STBI_NO_GIF
#define STBI_NO_BMP
#define STBI_ONLY_PNG
#include "../vendor/imgui/stb_image.h"

#include <cstdint>
#include <cstring>
#include <cstdio>

// ----- embedded skin atlas -----------------------------------------------
__asm__(
    ".section .rodata                            \n"
    ".global _havana_skins_dat_start             \n"
    ".global _havana_skins_dat_end               \n"
    ".balign 4                                   \n"
    "_havana_skins_dat_start:                    \n"
    ".incbin \"jni/gui/skins_data/skins.dat\"\n"
    "_havana_skins_dat_end:                      \n"
    ".balign 4                                   \n"
    ".previous                                   \n"
);
extern "C" const uint8_t _havana_skins_dat_start[];
extern "C" const uint8_t _havana_skins_dat_end[];

// ----- cache -------------------------------------------------------------
namespace {
struct CachedTex { RwRaster* raster; int w; int h; float u; float v; bool tried; };
constexpr int kMaxSkin = 312;
CachedTex g_tex[kMaxSkin] = { {nullptr,0,0,0.0f,0.0f,false} };

bool ReadEntry(int skinId, const uint8_t** outPtr, uint32_t* outSize)
{
    const uint8_t* base = _havana_skins_dat_start;
    const uint8_t* end  = _havana_skins_dat_end;
    if (end <= base) return false;
    if (skinId < 0)  return false;

    uint32_t count = (uint32_t)base[0] | ((uint32_t)base[1] << 8)
                  | ((uint32_t)base[2] << 16) | ((uint32_t)base[3] << 24);
    if ((uint32_t)skinId >= count) return false;

    const uint8_t* tocEntry = base + 4 + skinId * 8;
    uint32_t off  = (uint32_t)tocEntry[0] | ((uint32_t)tocEntry[1] << 8)
                 | ((uint32_t)tocEntry[2] << 16) | ((uint32_t)tocEntry[3] << 24);
    uint32_t size = (uint32_t)tocEntry[4] | ((uint32_t)tocEntry[5] << 8)
                 | ((uint32_t)tocEntry[6] << 16) | ((uint32_t)tocEntry[7] << 24);
    if (size == 0) return false;
    if ((size_t)off + size > (size_t)(end - base)) return false;

    *outPtr  = base + off;
    *outSize = size;
    return true;
}

// Round up to next power of two (>= 1).
static inline int Pow2Ceil(int x)
{
    int n = 1; while (n < x) n <<= 1;
    return n;
}

// Decode the PNG bytes and turn them into an RwRaster the same way the
// font atlas in imgui_impl_renderware.cpp does it.  Most GLES drivers
// require power-of-two textures; we therefore allocate the destination
// RwImage at pow2 dimensions and place the actual decoded pixels in the
// top-left corner, leaving the rest transparent.  outU/outV receive the
// UV (in [0..1]) of the right/bottom edge of the real image so the
// caller can avoid sampling the empty padding area.
RwRaster* MakeRasterFromPNG(const uint8_t* data, int len,
                            int* outW, int* outH,
                            float* outU, float* outV)
{
    int w = 0, h = 0, ch = 0;
    stbi_uc* px = stbi_load_from_memory(data, len, &w, &h, &ch, 4);
    if (!px) return nullptr;

    int pw = Pow2Ceil(w);
    int ph = Pow2Ceil(h);

    RwImage* img = RwImageCreate(pw, ph, 32);
    if (!img) { stbi_image_free(px); return nullptr; }
    RwImageAllocatePixels(img);

    // Clear the whole image first (alpha = 0 everywhere).
    if (img->cpPixels) memset(img->cpPixels, 0, (size_t)img->stride * img->height);

    // Copy decoded rows into the top-left of the padded image.
    RwUInt8* dst = img->cpPixels;
    for (int y = 0; y < h; ++y)
    {
        memcpy(dst, px + y * w * 4, (size_t)w * 4);
        dst += img->stride;
    }
    stbi_image_free(px);

    RwInt32 rw, rh, rd, rflags;
    RwImageFindRasterFormat(img, rwRASTERTYPETEXTURE,
                            &rw, &rh, &rd, &rflags);
    RwRaster* raster = RwRasterCreate(rw, rh, rd, rflags);
    if (raster) raster = RwRasterSetFromImage(raster, img);
    RwImageDestroy(img);

    if (raster)
    {
        *outW = w; *outH = h;
        // The raster reports its (possibly further-padded) width/height.
        // UV1 = real_image / raster_size.
        int rasW = (raster->width  > 0) ? raster->width  : pw;
        int rasH = (raster->height > 0) ? raster->height : ph;
        *outU = (float)w / (float)rasW;
        *outV = (float)h / (float)rasH;
    }
    return raster;
}
} // namespace

// ----- public API --------------------------------------------------------
bool SkinTex_Get(int skinId, void** outImTextureID,
                 int* outW, int* outH,
                 float* outU, float* outV)
{
    if (skinId < 0 || skinId >= kMaxSkin) return false;
    CachedTex& c = g_tex[skinId];
    if (c.raster)
    {
        if (outImTextureID) *outImTextureID = (void*)c.raster;
        if (outW) *outW = c.w;
        if (outH) *outH = c.h;
        if (outU) *outU = c.u;
        if (outV) *outV = c.v;
        return true;
    }
    if (c.tried) return false;
    c.tried = true;

    const uint8_t* p = nullptr; uint32_t sz = 0;
    if (!ReadEntry(skinId, &p, &sz)) return false;

    int w = 0, h = 0;
    float u = 1.0f, v = 1.0f;
    RwRaster* r = MakeRasterFromPNG(p, (int)sz, &w, &h, &u, &v);
    if (!r) return false;

    c.raster = r; c.w = w; c.h = h; c.u = u; c.v = v;
    if (outImTextureID) *outImTextureID = (void*)r;
    if (outW) *outW = w;
    if (outH) *outH = h;
    if (outU) *outU = u;
    if (outV) *outV = v;
    return true;
}
