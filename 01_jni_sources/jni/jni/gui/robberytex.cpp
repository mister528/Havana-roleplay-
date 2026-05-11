// =====================================================================
// robberytex.cpp
//
// Loads the 24/7 robbery overlay's vault background PNG (embedded into
// libsamp.so via .incbin from gui/robbery_data/vault.png) and converts
// it to an RwRaster usable as an ImGui ImTextureID.
//
// Mirrors skintex.cpp but for a single fixed asset.
// =====================================================================

#include "../main.h"
#include "robberytex.h"
#include "../game/RW/RenderWare.h"

// stb_image is implemented in skintex.cpp with STB_IMAGE_IMPLEMENTATION,
// so here we just declare the bits we need.
extern "C" {
    typedef unsigned char stbi_uc;
    stbi_uc* stbi_load_from_memory(const unsigned char* buffer, int len,
                                   int* x, int* y, int* channels_in_file,
                                   int desired_channels);
    void     stbi_image_free(void* retval_from_stbi_load);
}

#include <cstdint>
#include <cstring>

// ----- embedded vault background -----------------------------------------
__asm__(
    ".section .rodata                            \n"
    ".global _havana_vault_png_start             \n"
    ".global _havana_vault_png_end               \n"
    ".balign 4                                   \n"
    "_havana_vault_png_start:                    \n"
    ".incbin \"jni/gui/robbery_data/vault.png\"\n"
    "_havana_vault_png_end:                      \n"
    ".balign 4                                   \n"
    ".previous                                   \n"
);
extern "C" const uint8_t _havana_vault_png_start[];
extern "C" const uint8_t _havana_vault_png_end[];

namespace
{
    struct VaultTex { RwRaster* raster; int w; int h; float u; float v; bool tried; };
    static VaultTex g_vault = { nullptr, 0, 0, 0.0f, 0.0f, false };

    static inline int Pow2Ceil(int x)
    {
        int n = 1; while (n < x) n <<= 1;
        return n;
    }

    static RwRaster* MakeRasterFromPNG(const uint8_t* data, int len,
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

        if (img->cpPixels) memset(img->cpPixels, 0, (size_t)img->stride * img->height);

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
            int rasW = (raster->width  > 0) ? raster->width  : pw;
            int rasH = (raster->height > 0) ? raster->height : ph;
            *outU = (float)w / (float)rasW;
            *outV = (float)h / (float)rasH;
        }
        return raster;
    }
}

namespace RobberyTex
{
    bool GetVault(void** outImTextureID,
                  int* outW, int* outH,
                  float* outU, float* outV)
    {
        if (g_vault.raster)
        {
            if (outImTextureID) *outImTextureID = (void*)g_vault.raster;
            if (outW) *outW = g_vault.w;
            if (outH) *outH = g_vault.h;
            if (outU) *outU = g_vault.u;
            if (outV) *outV = g_vault.v;
            return true;
        }
        if (g_vault.tried) return false;
        g_vault.tried = true;

        const uint8_t* base = _havana_vault_png_start;
        const uint8_t* end  = _havana_vault_png_end;
        if (end <= base) return false;
        int sz = (int)(end - base);

        int w = 0, h = 0;
        float u = 1.0f, v = 1.0f;
        RwRaster* r = MakeRasterFromPNG(base, sz, &w, &h, &u, &v);
        if (!r) return false;

        g_vault.raster = r; g_vault.w = w; g_vault.h = h;
        g_vault.u = u; g_vault.v = v;
        if (outImTextureID) *outImTextureID = (void*)r;
        if (outW) *outW = w;
        if (outH) *outH = h;
        if (outU) *outU = u;
        if (outV) *outV = v;
        return true;
    }
}
