#include "../main.h"
#include "inventorytex.h"
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
    ".global _havana_healme_jpg_start                  \n"
    ".global _havana_healme_jpg_end                    \n"
    ".global _havana_mask_png_start                    \n"
    ".global _havana_mask_png_end                      \n"
    ".global _havana_music_png_start                   \n"
    ".global _havana_music_png_end                     \n"
    ".global _havana_backpack_png_start                \n"
    ".global _havana_backpack_png_end                  \n"
    ".global _havana_accessory_png_start               \n"
    ".global _havana_accessory_png_end                 \n"
    ".global _havana_headphones_png_start              \n"
    ".global _havana_headphones_png_end                \n"
    ".global _havana_logo_png_start                    \n"
    ".global _havana_logo_png_end                      \n"
    ".global _havana_hat_png_start                     \n"
    ".global _havana_hat_png_end                       \n"
    ".global _havana_chain_png_start                   \n"
    ".global _havana_chain_png_end                     \n"
    ".global _havana_gps_png_start                     \n"
    ".global _havana_gps_png_end                       \n"
    ".global _havana_car_key_png_start                 \n"
    ".global _havana_car_key_png_end                   \n"
    ".global _havana_rope_png_start                    \n"
    ".global _havana_rope_png_end                      \n"
    ".global _havana_repair_png_start                  \n"
    ".global _havana_repair_png_end                    \n"
    ".global _havana_island_gunpowder_png_start        \n"
    ".global _havana_island_gunpowder_png_end          \n"
    ".global _havana_island_iron_png_start             \n"
    ".global _havana_island_iron_png_end               \n"
    ".global _havana_island_scrap_png_start            \n"
    ".global _havana_island_scrap_png_end              \n"
    ".global _havana_island_wood_png_start             \n"
    ".global _havana_island_wood_png_end               \n"
    ".global _havana_island_spring_png_start           \n"
    ".global _havana_island_spring_png_end             \n"
    ".global _havana_testinv_png_start                 \n"
    ".global _havana_testinv_png_end                   \n"
    ".global _havana_testinv_exit_png_start            \n"
    ".global _havana_testinv_exit_png_end              \n"
    ".global _havana_testinv_page_png_start            \n"
    ".global _havana_testinv_page_png_end              \n"
    ".global _havana_test1_bg_png_start                \n"
    ".global _havana_test1_bg_png_end                  \n"
    ".global _havana_test1_button_png_start            \n"
    ".global _havana_test1_button_png_end              \n"
    ".global _havana_test3_bg_png_start                \n"
    ".global _havana_test3_bg_png_end                  \n"
    ".global _havana_test3_box_png_start               \n"
    ".global _havana_test3_box_png_end                 \n"
    ".global _havana_greenzone_png_start               \n"
    ".global _havana_greenzone_png_end                 \n"
    ".balign 4                                         \n"
    "_havana_healme_jpg_start:                         \n"
    ".incbin \"jni/gui/inventory_data/healme.jpg\"     \n"
    "_havana_healme_jpg_end:                           \n"
    ".balign 4                                         \n"
    "_havana_mask_png_start:                           \n"
    ".incbin \"jni/gui/inventory_data/mask.png\"       \n"
    "_havana_mask_png_end:                             \n"
    ".balign 4                                         \n"
    "_havana_music_png_start:                          \n"
    ".incbin \"jni/gui/inventory_data/music.png\"      \n"
    "_havana_music_png_end:                            \n"
    ".balign 4                                         \n"
    "_havana_backpack_png_start:                       \n"
    ".incbin \"jni/gui/inventory_data/backpack.png\"   \n"
    "_havana_backpack_png_end:                         \n"
    ".balign 4                                         \n"
    "_havana_accessory_png_start:                      \n"
    ".incbin \"jni/gui/inventory_data/accessory.png\"  \n"
    "_havana_accessory_png_end:                        \n"
    ".balign 4                                         \n"
    "_havana_headphones_png_start:                     \n"
    ".incbin \"jni/gui/inventory_data/headphones.png\" \n"
    "_havana_headphones_png_end:                       \n"
    ".balign 4                                         \n"
    "_havana_logo_png_start:                           \n"
    ".incbin \"jni/gui/inventory_data/havana_logo.png\"\n"
    "_havana_logo_png_end:                             \n"
    ".balign 4                                         \n"
    "_havana_hat_png_start:                            \n"
    ".incbin \"jni/gui/inventory_data/hat.png\"        \n"
    "_havana_hat_png_end:                              \n"
    ".balign 4                                         \n"
    "_havana_chain_png_start:                          \n"
    ".incbin \"jni/gui/inventory_data/chain.png\"      \n"
    "_havana_chain_png_end:                            \n"
    ".balign 4                                         \n"
    "_havana_gps_png_start:                            \n"
    ".incbin \"jni/gui/inventory_data/gps.png\"        \n"
    "_havana_gps_png_end:                              \n"
    ".balign 4                                         \n"
    "_havana_car_key_png_start:                        \n"
    ".incbin \"jni/gui/inventory_data/car_key.png\"    \n"
    "_havana_car_key_png_end:                          \n"
    ".balign 4                                         \n"
    "_havana_rope_png_start:                           \n"
    ".incbin \"jni/gui/inventory_data/rope.png\"       \n"
    "_havana_rope_png_end:                             \n"
    ".balign 4                                         \n"
    "_havana_repair_png_start:                         \n"
    ".incbin \"jni/gui/inventory_data/repair.png\"     \n"
    "_havana_repair_png_end:                           \n"
    ".balign 4                                         \n"
    "_havana_island_gunpowder_png_start:               \n"
    ".incbin \"jni/gui/inventory_data/island_gunpowder.png\" \n"
    "_havana_island_gunpowder_png_end:                 \n"
    ".balign 4                                         \n"
    "_havana_island_iron_png_start:                    \n"
    ".incbin \"jni/gui/inventory_data/island_iron.png\" \n"
    "_havana_island_iron_png_end:                      \n"
    ".balign 4                                         \n"
    "_havana_island_scrap_png_start:                   \n"
    ".incbin \"jni/gui/inventory_data/island_scrap.png\" \n"
    "_havana_island_scrap_png_end:                     \n"
    ".balign 4                                         \n"
    "_havana_island_wood_png_start:                    \n"
    ".incbin \"jni/gui/inventory_data/island_wood.png\" \n"
    "_havana_island_wood_png_end:                      \n"
    ".balign 4                                         \n"
    "_havana_island_spring_png_start:                  \n"
    ".incbin \"jni/gui/inventory_data/island_spring.png\" \n"
    "_havana_island_spring_png_end:                    \n"
    ".balign 4                                         \n"
    "_havana_testinv_png_start:                        \n"
    ".incbin \"jni/gui/inventory_data/testinv.png\"    \n"
    "_havana_testinv_png_end:                          \n"
    ".balign 4                                         \n"
    "_havana_testinv_exit_png_start:                   \n"
    ".incbin \"jni/gui/inventory_data/testinv_exit.png\"\n"
    "_havana_testinv_exit_png_end:                     \n"
    ".balign 4                                         \n"
    "_havana_testinv_page_png_start:                   \n"
    ".incbin \"jni/gui/inventory_data/testinv_page.png\"\n"
    "_havana_testinv_page_png_end:                     \n"
    ".balign 4                                         \n"
    "_havana_test1_bg_png_start:                       \n"
    ".incbin \"jni/gui/inventory_data/test1_bg.png\"   \n"
    "_havana_test1_bg_png_end:                         \n"
    ".balign 4                                         \n"
    "_havana_test1_button_png_start:                   \n"
    ".incbin \"jni/gui/inventory_data/test1_button.png\"\n"
    "_havana_test1_button_png_end:                     \n"
    ".balign 4                                         \n"
    "_havana_test3_bg_png_start:                       \n"
    ".incbin \"jni/gui/inventory_data/test3_bg.png\"   \n"
    "_havana_test3_bg_png_end:                         \n"
    ".balign 4                                         \n"
    "_havana_test3_box_png_start:                      \n"
    ".incbin \"jni/gui/inventory_data/test3_box.png\"  \n"
    "_havana_test3_box_png_end:                        \n"
    ".balign 4                                         \n"
    "_havana_greenzone_png_start:                      \n"
    ".incbin \"jni/gui/inventory_data/greenzone.png\"  \n"
    "_havana_greenzone_png_end:                        \n"
    ".balign 4                                         \n"
    ".previous                                         \n"
);

extern "C" const uint8_t _havana_healme_jpg_start[];
extern "C" const uint8_t _havana_healme_jpg_end[];
extern "C" const uint8_t _havana_mask_png_start[];
extern "C" const uint8_t _havana_mask_png_end[];
extern "C" const uint8_t _havana_music_png_start[];
extern "C" const uint8_t _havana_music_png_end[];
extern "C" const uint8_t _havana_backpack_png_start[];
extern "C" const uint8_t _havana_backpack_png_end[];
extern "C" const uint8_t _havana_accessory_png_start[];
extern "C" const uint8_t _havana_accessory_png_end[];
extern "C" const uint8_t _havana_headphones_png_start[];
extern "C" const uint8_t _havana_headphones_png_end[];
extern "C" const uint8_t _havana_logo_png_start[];
extern "C" const uint8_t _havana_logo_png_end[];
extern "C" const uint8_t _havana_hat_png_start[];
extern "C" const uint8_t _havana_hat_png_end[];
extern "C" const uint8_t _havana_chain_png_start[];
extern "C" const uint8_t _havana_chain_png_end[];
extern "C" const uint8_t _havana_gps_png_start[];
extern "C" const uint8_t _havana_gps_png_end[];
extern "C" const uint8_t _havana_car_key_png_start[];
extern "C" const uint8_t _havana_car_key_png_end[];
extern "C" const uint8_t _havana_rope_png_start[];
extern "C" const uint8_t _havana_rope_png_end[];
extern "C" const uint8_t _havana_repair_png_start[];
extern "C" const uint8_t _havana_repair_png_end[];
extern "C" const uint8_t _havana_island_gunpowder_png_start[];
extern "C" const uint8_t _havana_island_gunpowder_png_end[];
extern "C" const uint8_t _havana_island_iron_png_start[];
extern "C" const uint8_t _havana_island_iron_png_end[];
extern "C" const uint8_t _havana_island_scrap_png_start[];
extern "C" const uint8_t _havana_island_scrap_png_end[];
extern "C" const uint8_t _havana_island_wood_png_start[];
extern "C" const uint8_t _havana_island_wood_png_end[];
extern "C" const uint8_t _havana_island_spring_png_start[];
extern "C" const uint8_t _havana_island_spring_png_end[];
extern "C" const uint8_t _havana_testinv_png_start[];
extern "C" const uint8_t _havana_testinv_png_end[];
extern "C" const uint8_t _havana_testinv_exit_png_start[];
extern "C" const uint8_t _havana_testinv_exit_png_end[];
extern "C" const uint8_t _havana_testinv_page_png_start[];
extern "C" const uint8_t _havana_testinv_page_png_end[];
extern "C" const uint8_t _havana_test1_bg_png_start[];
extern "C" const uint8_t _havana_test1_bg_png_end[];
extern "C" const uint8_t _havana_test1_button_png_start[];
extern "C" const uint8_t _havana_test1_button_png_end[];
extern "C" const uint8_t _havana_test3_bg_png_start[];
extern "C" const uint8_t _havana_test3_bg_png_end[];
extern "C" const uint8_t _havana_test3_box_png_start[];
extern "C" const uint8_t _havana_test3_box_png_end[];
extern "C" const uint8_t _havana_greenzone_png_start[];
extern "C" const uint8_t _havana_greenzone_png_end[];

namespace
{
    struct InvTex { RwRaster* raster; int w; int h; float u; float v; bool tried; };
    static InvTex g_healme = { nullptr, 0, 0, 0.0f, 0.0f, false };
    static InvTex g_mask   = { nullptr, 0, 0, 0.0f, 0.0f, false };
    static InvTex g_music  = { nullptr, 0, 0, 0.0f, 0.0f, false };
    static InvTex g_backpack = { nullptr, 0, 0, 0.0f, 0.0f, false };
    static InvTex g_accessory = { nullptr, 0, 0, 0.0f, 0.0f, false };
    static InvTex g_headphones = { nullptr, 0, 0, 0.0f, 0.0f, false };
    static InvTex g_havana_logo = { nullptr, 0, 0, 0.0f, 0.0f, false };
    static InvTex g_hat = { nullptr, 0, 0, 0.0f, 0.0f, false };
    static InvTex g_chain = { nullptr, 0, 0, 0.0f, 0.0f, false };
    static InvTex g_gps = { nullptr, 0, 0, 0.0f, 0.0f, false };
    static InvTex g_car_key = { nullptr, 0, 0, 0.0f, 0.0f, false };
    static InvTex g_rope = { nullptr, 0, 0, 0.0f, 0.0f, false };
    static InvTex g_repair = { nullptr, 0, 0, 0.0f, 0.0f, false };
    static InvTex g_island_gunpowder = { nullptr, 0, 0, 0.0f, 0.0f, false };
    static InvTex g_island_iron = { nullptr, 0, 0, 0.0f, 0.0f, false };
    static InvTex g_island_scrap = { nullptr, 0, 0, 0.0f, 0.0f, false };
    static InvTex g_island_wood = { nullptr, 0, 0, 0.0f, 0.0f, false };
    static InvTex g_island_spring = { nullptr, 0, 0, 0.0f, 0.0f, false };
    static InvTex g_testinv= { nullptr, 0, 0, 0.0f, 0.0f, false };
    static InvTex g_testinv_exit = { nullptr, 0, 0, 0.0f, 0.0f, false };
    static InvTex g_testinv_page = { nullptr, 0, 0, 0.0f, 0.0f, false };
    static InvTex g_test1_bg = { nullptr, 0, 0, 0.0f, 0.0f, false };
    static InvTex g_test1_button = { nullptr, 0, 0, 0.0f, 0.0f, false };
    static InvTex g_test3_bg = { nullptr, 0, 0, 0.0f, 0.0f, false };
    static InvTex g_test3_box = { nullptr, 0, 0, 0.0f, 0.0f, false };
    static InvTex g_greenzone = { nullptr, 0, 0, 0.0f, 0.0f, false };

    static int Pow2Ceil(int x)
    {
        int n = 1; while (n < x) n <<= 1;
        return n;
    }

    static RwRaster* MakeRaster(const uint8_t* data, int len,
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
}

namespace InventoryTex
{
    static bool GetEmbedded(InvTex* tex,
                            const uint8_t* base,
                            const uint8_t* end,
                            void** outImTextureID,
                            int* outW, int* outH,
                            float* outU, float* outV)
    {
        if (tex->raster)
        {
            if (outImTextureID) *outImTextureID = (void*)tex->raster;
            if (outW) *outW = tex->w;
            if (outH) *outH = tex->h;
            if (outU) *outU = tex->u;
            if (outV) *outV = tex->v;
            return true;
        }
        if (tex->tried) return false;
        tex->tried = true;
        if (end <= base) return false;

        int w = 0, h = 0;
        float u = 1.0f, v = 1.0f;
        RwRaster* r = MakeRaster(base, (int)(end - base), &w, &h, &u, &v);
        if (!r) return false;

        tex->raster = r; tex->w = w; tex->h = h;
        tex->u = u; tex->v = v;
        if (outImTextureID) *outImTextureID = (void*)r;
        if (outW) *outW = w;
        if (outH) *outH = h;
        if (outU) *outU = u;
        if (outV) *outV = v;
        return true;
    }

    bool GetHealme(void** outImTextureID,
                   int* outW, int* outH,
                   float* outU, float* outV)
    {
        return GetEmbedded(&g_healme,
                           _havana_healme_jpg_start, _havana_healme_jpg_end,
                           outImTextureID, outW, outH, outU, outV);
    }

    bool GetMask(void** outImTextureID,
                 int* outW, int* outH,
                 float* outU, float* outV)
    {
        return GetEmbedded(&g_mask,
                           _havana_mask_png_start, _havana_mask_png_end,
                           outImTextureID, outW, outH, outU, outV);
    }

    bool GetMusic(void** outImTextureID,
                  int* outW, int* outH,
                  float* outU, float* outV)
    {
        return GetEmbedded(&g_music,
                           _havana_music_png_start, _havana_music_png_end,
                           outImTextureID, outW, outH, outU, outV);
    }

    bool GetBackpack(void** outImTextureID,
                     int* outW, int* outH,
                     float* outU, float* outV)
    {
        return GetEmbedded(&g_backpack,
                           _havana_backpack_png_start, _havana_backpack_png_end,
                           outImTextureID, outW, outH, outU, outV);
    }

    bool GetAccessory(void** outImTextureID,
                      int* outW, int* outH,
                      float* outU, float* outV)
    {
        return GetEmbedded(&g_accessory,
                           _havana_accessory_png_start, _havana_accessory_png_end,
                           outImTextureID, outW, outH, outU, outV);
    }

    bool GetHeadphones(void** outImTextureID,
                       int* outW, int* outH,
                       float* outU, float* outV)
    {
        return GetEmbedded(&g_headphones,
                           _havana_headphones_png_start, _havana_headphones_png_end,
                           outImTextureID, outW, outH, outU, outV);
    }

    bool GetHavanaLogo(void** outImTextureID,
                       int* outW, int* outH,
                       float* outU, float* outV)
    {
        return GetEmbedded(&g_havana_logo,
                           _havana_logo_png_start, _havana_logo_png_end,
                           outImTextureID, outW, outH, outU, outV);
    }

    bool GetHat(void** outImTextureID,
                int* outW, int* outH,
                float* outU, float* outV)
    {
        return GetEmbedded(&g_hat,
                           _havana_hat_png_start, _havana_hat_png_end,
                           outImTextureID, outW, outH, outU, outV);
    }

    bool GetChain(void** outImTextureID,
                  int* outW, int* outH,
                  float* outU, float* outV)
    {
        return GetEmbedded(&g_chain,
                           _havana_chain_png_start, _havana_chain_png_end,
                           outImTextureID, outW, outH, outU, outV);
    }

    bool GetGps(void** outImTextureID,
                int* outW, int* outH,
                float* outU, float* outV)
    {
        return GetEmbedded(&g_gps,
                           _havana_gps_png_start, _havana_gps_png_end,
                           outImTextureID, outW, outH, outU, outV);
    }

    bool GetCarKey(void** outImTextureID,
                   int* outW, int* outH,
                   float* outU, float* outV)
    {
        return GetEmbedded(&g_car_key,
                           _havana_car_key_png_start, _havana_car_key_png_end,
                           outImTextureID, outW, outH, outU, outV);
    }

    bool GetRope(void** outImTextureID,
                 int* outW, int* outH,
                 float* outU, float* outV)
    {
        return GetEmbedded(&g_rope,
                           _havana_rope_png_start, _havana_rope_png_end,
                           outImTextureID, outW, outH, outU, outV);
    }

    bool GetRepair(void** outImTextureID,
                   int* outW, int* outH,
                   float* outU, float* outV)
    {
        return GetEmbedded(&g_repair,
                           _havana_repair_png_start, _havana_repair_png_end,
                           outImTextureID, outW, outH, outU, outV);
    }

    bool GetIslandGunpowder(void** outImTextureID,
                            int* outW, int* outH,
                            float* outU, float* outV)
    {
        return GetEmbedded(&g_island_gunpowder,
                           _havana_island_gunpowder_png_start, _havana_island_gunpowder_png_end,
                           outImTextureID, outW, outH, outU, outV);
    }

    bool GetIslandIron(void** outImTextureID,
                       int* outW, int* outH,
                       float* outU, float* outV)
    {
        return GetEmbedded(&g_island_iron,
                           _havana_island_iron_png_start, _havana_island_iron_png_end,
                           outImTextureID, outW, outH, outU, outV);
    }

    bool GetIslandScrap(void** outImTextureID,
                        int* outW, int* outH,
                        float* outU, float* outV)
    {
        return GetEmbedded(&g_island_scrap,
                           _havana_island_scrap_png_start, _havana_island_scrap_png_end,
                           outImTextureID, outW, outH, outU, outV);
    }

    bool GetIslandWood(void** outImTextureID,
                       int* outW, int* outH,
                       float* outU, float* outV)
    {
        return GetEmbedded(&g_island_wood,
                           _havana_island_wood_png_start, _havana_island_wood_png_end,
                           outImTextureID, outW, outH, outU, outV);
    }

    bool GetIslandSpring(void** outImTextureID,
                         int* outW, int* outH,
                         float* outU, float* outV)
    {
        return GetEmbedded(&g_island_spring,
                           _havana_island_spring_png_start, _havana_island_spring_png_end,
                           outImTextureID, outW, outH, outU, outV);
    }

    bool GetTestInv(void** outImTextureID,
                    int* outW, int* outH,
                    float* outU, float* outV)
    {
        return GetEmbedded(&g_testinv,
                           _havana_testinv_png_start, _havana_testinv_png_end,
                           outImTextureID, outW, outH, outU, outV);
    }

    bool GetTestInvExit(void** outImTextureID,
                        int* outW, int* outH,
                        float* outU, float* outV)
    {
        return GetEmbedded(&g_testinv_exit,
                           _havana_testinv_exit_png_start, _havana_testinv_exit_png_end,
                           outImTextureID, outW, outH, outU, outV);
    }

    bool GetTestInvPage(void** outImTextureID,
                        int* outW, int* outH,
                        float* outU, float* outV)
    {
        return GetEmbedded(&g_testinv_page,
                           _havana_testinv_page_png_start, _havana_testinv_page_png_end,
                           outImTextureID, outW, outH, outU, outV);
    }

    bool GetTest1Bg(void** outImTextureID,
                    int* outW, int* outH,
                    float* outU, float* outV)
    {
        return GetEmbedded(&g_test1_bg,
                           _havana_test1_bg_png_start, _havana_test1_bg_png_end,
                           outImTextureID, outW, outH, outU, outV);
    }

    bool GetTest1Button(void** outImTextureID,
                        int* outW, int* outH,
                        float* outU, float* outV)
    {
        return GetEmbedded(&g_test1_button,
                           _havana_test1_button_png_start, _havana_test1_button_png_end,
                           outImTextureID, outW, outH, outU, outV);
    }

    bool GetTest3Bg(void** outImTextureID,
                    int* outW, int* outH,
                    float* outU, float* outV)
    {
        return GetEmbedded(&g_test3_bg,
                           _havana_test3_bg_png_start, _havana_test3_bg_png_end,
                           outImTextureID, outW, outH, outU, outV);
    }

    bool GetTest3Box(void** outImTextureID,
                     int* outW, int* outH,
                     float* outU, float* outV)
    {
        return GetEmbedded(&g_test3_box,
                           _havana_test3_box_png_start, _havana_test3_box_png_end,
                           outImTextureID, outW, outH, outU, outV);
    }

    bool GetGreenZone(void** outImTextureID,
                      int* outW, int* outH,
                      float* outU, float* outV)
    {
        return GetEmbedded(&g_greenzone,
                           _havana_greenzone_png_start, _havana_greenzone_png_end,
                           outImTextureID, outW, outH, outU, outV);
    }
}
