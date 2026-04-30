#pragma once

#include <string>
#include <vector>
#include <cstdint>

namespace Arabic
{
        // Returns true if the UTF-8 string contains any Arabic codepoint
        // (range U+0600..U+06FF or the Arabic Presentation Forms blocks).
        bool ContainsArabic(const char* utf8, int len = -1);

        // Shapes and bidi-reorders an Arabic-containing UTF-8 string for
        // visual rendering with a font that supports U+FE70..U+FEFF
        // presentation forms. Latin/digit runs are kept in logical order;
        // only Arabic runs are reversed and contextually shaped.
        //
        // The output is a fresh UTF-8 std::string; safe to use as a
        // temporary buffer feeding ImDrawList::AddText / ImFont::CalcTextSizeA.
        std::string Shape(const char* utf8, int len = -1);

        // Like Shape() but also returns a mapping from each output
        // codepoint back to the index of the source codepoint (0-based)
        // it originated from.
        //
        //  - For RTL runs, characters within a run are reversed so the
        //    indices in `out_src_cp_idx` for that run are in DESCENDING
        //    order in the output.
        //  - For LAM+ALEF ligatures the index of the LAM (the first of
        //    the two source codepoints) is used.
        //  - The number of source codepoints is returned via
        //    `out_src_cp_count` so callers that built a per-codepoint
        //    attribute array (e.g. one ImColor per source codepoint)
        //    can sanity-check it matches.
        //
        // This is the API CChatWindow / dialog renderers use to keep
        // {HEX} colour tags attached to the visually-correct piece of
        // text once Arabic BiDi reordering has happened.
        void ShapeWithSourceMap(const char* utf8, int len,
                                std::string& out_utf8,
                                std::vector<int>& out_src_cp_idx,
                                int* out_src_cp_count = nullptr);

        // Number of UTF-8 codepoints in a buffer of `len` bytes (or until
        // the first NUL when len < 0). Useful for sizing per-codepoint
        // attribute arrays before feeding ShapeWithSourceMap.
        int CountCodepoints(const char* utf8, int len = -1);

        // Convenience: split a colour-tagged UTF-8 chat line into pieces
        // and emit them to `RenderRunFn` in *visual* order, with proper
        // RTL paragraph ordering when the line contains Arabic. Each
        // emitted run is one contiguous span of same-coloured shaped
        // text; callers draw it at the supplied X coordinate and advance.
        //
        // `chunks` describes the input as logical-order pieces, each
        // tagged with an opaque colour identifier (typically an ImU32).
        // `RenderRunFn` is called once per visual run with:
        //     (utf8, byte_len, color_id)
        // and must return the rendered width so the algorithm can
        // accumulate the X offset for the next run.
        struct ColouredChunk
        {
                const char* utf8;
                int         len;        // bytes; -1 means strlen(utf8)
                uint32_t    color_id;   // opaque, returned to caller per run
        };

        // Render `chunks` in visual order. `draw_run` is called for every
        // visual run with (utf8_ptr, byte_len, color_id, x_offset). It
        // must return the width consumed by the run so x_offset can be
        // advanced for the next run.
        //
        // Returns the total visual width.
        typedef float (*DrawRunFn)(const char* utf8, int len, uint32_t color_id,
                                   float x_offset, void* user);
        float RenderColouredLine(const ColouredChunk* chunks, int n_chunks,
                                 DrawRunFn draw_run, void* user);

        // BiDi-only reorder for renderers that DON'T have presentation
        // forms in their font (e.g. GTA-SA's stock CFont used by SAMP
        // TextDraws). Decomposes the UTF-8 input to codepoints, runs the
        // same RTL/LTR resolution + bracket pairing as Shape() does, but
        // emits the basic-block Arabic codepoints unchanged in visual
        // order rather than converting them to U+FE70..U+FEFF
        // presentation forms. Brackets that resolve as RTL are still
        // mirrored.
        std::string BidiReorderKeepBaseForms(const char* utf8, int len = -1);
}
