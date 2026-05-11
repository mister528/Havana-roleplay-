#include "../main.h"
#include "weaponcrafttex.h"
#include "../game/RW/RenderWare.h"

extern "C" {
    typedef unsigned char stbi_uc;
    stbi_uc* stbi_load_from_memory(const unsigned char* buffer, int len,
                                   int* x, int* y, int* channels_in_file,
                                   int desired_channels);
    void     stbi_image_free(void* retval_from_stbi_load);
}

#include <cstdint>
#include <cstring>

__asm__(
    ".section .rodata                                  \n"
    ".global _havana_craft_minigame_png_start          \n"
    ".global _havana_craft_minigame_png_end            \n"
    ".balign 4                                         \n"
    "_havana_craft_minigame_png_start:                 \n"
    ".incbin \"jni/gui/inventory_data/craft_minigame.png\" \n"
    "_havana_craft_minigame_png_end:                   \n"
    ".balign 4                                         \n"
    ".global _havana_craft_rpg_png_start               \n"
    ".global _havana_craft_rpg_png_end                 \n"
    "_havana_craft_rpg_png_start:                      \n"
    ".incbin \"jni/gui/inventory_data/rpg.png\"        \n"
    "_havana_craft_rpg_png_end:                        \n"
    ".balign 4                                         \n"
    ".previous                                         \n"
);

extern "C" const uint8_t _havana_craft_minigame_png_start[];
extern "C" const uint8_t _havana_craft_minigame_png_end[];
extern "C" const uint8_t _havana_craft_rpg_png_start[];
extern "C" const uint8_t _havana_craft_rpg_png_end[];

namespace
{
    struct CraftTex { RwRaster* raster; int w; int h; float u; float v; bool tried; };
    static CraftTex g_minigame = { nullptr, 0, 0, 0.0f, 0.0f, false };
    static CraftTex g_rpgicon  = { nullptr, 0, 0, 0.0f, 0.0f, false };

    // ----- safety gate ---------------------------------------------------
    // RenderWare textures must only be created while the engine is fully
    // initialised AND from a frame-tick context (NOT during a hot overlay
    // paint).  We therefore expose a Tick() to be called once per frame from
    // CGUI::Render() and only allow MakeRaster after several frames have
    // elapsed.  This eliminates first-show races that have been linked to
    // tombstones inside RwRasterCreate / RwImageAllocatePixels on devices
    // that come up slow on RenderWare initialisation.
    static int  g_tickFrames        = 0;
    static bool g_engineReady       = false;
    static const int kMinTickFrames = 60;   // ~1 second @60fps before any load

    static int Pow2Ceil(int x)
    {
        int n = 1; while (n < x) n <<= 1;
        return n;
    }

    // Decodes a PNG from memory and uploads it as a RenderWare raster.
    // Returns nullptr on any failure (decode, RenderWare alloc, etc.) so the
    // caller can fall back to vector primitives.  All RenderWare calls are
    // null-checked because they may legitimately fail before the GTA engine
    // has finished initialising.
    static RwRaster* MakeRaster(const uint8_t* data, int len,
                                int* outW, int* outH,
                                float* outU, float* outV)
    {
        if (!data || len <= 0) return nullptr;

        int w = 0, h = 0, ch = 0;
        stbi_uc* px = stbi_load_from_memory(data, len, &w, &h, &ch, 4);
        if (!px) return nullptr;
        if (w <= 0 || h <= 0 || w > 4096 || h > 4096) { stbi_image_free(px); return nullptr; }

        int pw = Pow2Ceil(w);
        int ph = Pow2Ceil(h);
        RwImage* img = RwImageCreate(pw, ph, 32);
        if (!img) { stbi_image_free(px); return nullptr; }
        RwImageAllocatePixels(img);
        if (!img->cpPixels) { RwImageDestroy(img); stbi_image_free(px); return nullptr; }
        memset(img->cpPixels, 0, (size_t)img->stride * img->height);

        RwUInt8* dst = img->cpPixels;
        for (int y = 0; y < h; ++y)
        {
            memcpy(dst, px + y * w * 4, (size_t)w * 4);
            dst += img->stride;
        }
        stbi_image_free(px);

        RwInt32 rw = 0, rh = 0, rd = 0, rflags = 0;
        RwImageFindRasterFormat(img, rwRASTERTYPETEXTURE, &rw, &rh, &rd, &rflags);
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

    static bool LoadInto(CraftTex& tex,
                         const uint8_t* start, const uint8_t* end,
                         void** outImTextureID,
                         int* outW, int* outH,
                         float* outU, float* outV)
    {
        if (tex.raster)
        {
            if (outImTextureID) *outImTextureID = (void*)tex.raster;
            if (outW) *outW = tex.w;
            if (outH) *outH = tex.h;
            if (outU) *outU = tex.u;
            if (outV) *outV = tex.v;
            return true;
        }
        if (tex.tried) return false;
        // Refuse to attempt RenderWare allocation until the engine has been
        // ticking for a stable number of frames.  Don't set tex.tried so the
        // eventual eager pre-load (or a later overlay paint) can still try.
        if (!g_engineReady) return false;
        tex.tried = true;
        if (!start || !end || end <= start) return false;

        int w = 0, h = 0;
        float u = 1.0f, v = 1.0f;
        RwRaster* r = MakeRaster(start, (int)(end - start), &w, &h, &u, &v);
        if (!r) return false;

        tex.raster = r;
        tex.w = w; tex.h = h;
        tex.u = u; tex.v = v;
        if (outImTextureID) *outImTextureID = (void*)r;
        if (outW) *outW = w;
        if (outH) *outH = h;
        if (outU) *outU = u;
        if (outV) *outV = v;
        return true;
    }
}

namespace WeaponCraftTex
{
    bool GetMinigameImage(void** outImTextureID,
                          int* outW, int* outH,
                          float* outU, float* outV)
    {
        return LoadInto(g_minigame,
                        _havana_craft_minigame_png_start,
                        _havana_craft_minigame_png_end,
                        outImTextureID, outW, outH, outU, outV);
    }

    bool GetWeaponIcon(void** outImTextureID,
                       int* outW, int* outH,
                       float* outU, float* outV)
    {
        return LoadInto(g_rpgicon,
                        _havana_craft_rpg_png_start,
                        _havana_craft_rpg_png_end,
                        outImTextureID, outW, outH, outU, outV);
    }

    void Tick()
    {
        if (g_tickFrames < 100000) ++g_tickFrames;
        if (!g_engineReady && g_tickFrames >= kMinTickFrames)
        {
            g_engineReady = true;
            // Eagerly preload BOTH textures from a known-safe place: the
            // outer GUI tick (which always runs after RW init).  Failures
            // are silent — overlays will fall back to vector primitives.
            void*  dummy_id = nullptr;
            int    dw = 0, dh = 0;
            float  du = 1.0f, dv = 1.0f;
            (void)GetMinigameImage(&dummy_id, &dw, &dh, &du, &dv);
            (void)GetWeaponIcon  (&dummy_id, &dw, &dh, &du, &dv);
        }
    }
}
