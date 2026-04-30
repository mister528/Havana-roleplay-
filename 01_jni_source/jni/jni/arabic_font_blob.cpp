// Embeds Noto Naskh Arabic Regular into libluxury.so so the launcher's
// font atlas always has Arabic Presentation Forms available even when the
// user-selected SAMP/fonts/<name>.ttf does not include Arabic glyphs.

#include <cstddef>
#include <cstdint>

asm(
    ".section .rodata\n"
    ".global _havana_arabic_ttf_start             \n"
    ".global _havana_arabic_ttf_end               \n"
    ".balign 4                                    \n"
    "_havana_arabic_ttf_start:                    \n"
    ".incbin \"jni/arabic_font.ttf\"              \n"
    "_havana_arabic_ttf_end:                      \n"
    ".byte 0                                      \n"
);

extern "C" const uint8_t _havana_arabic_ttf_start[];
extern "C" const uint8_t _havana_arabic_ttf_end[];

const void*  g_pHavanaArabicFontData = _havana_arabic_ttf_start;
unsigned int g_pHavanaArabicFontSize = (unsigned int)(_havana_arabic_ttf_end - _havana_arabic_ttf_start);
