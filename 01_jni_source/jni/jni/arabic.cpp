#include "arabic.h"

#include <cstdint>
#include <cstring>
#include <vector>

// ============================================================================
//   Arabic shaping + minimal BiDi for ImGui-style font rendering.
//
// Approach
//   1. Decode UTF-8 -> codepoints.
//   2. Tag each codepoint with a joining type (R/D/L/U/T) using a hand-written
//      table extracted from the Unicode character database for the basic
//      Arabic block (U+0600..U+06FF). Letters outside the table are treated
//      as non-joining (U).
//   3. Walk through and pick a contextual presentation form for each
//      shapable letter using the standard rules:
//          isolated  if neither neighbour links;
//          initial   if next links and previous does not;
//          medial    if both neighbours link;
//          final     if previous links and next does not.
//      The mapping table maps base cp -> {isolated, final, initial, medial}.
//   4. Detect a LAM + ALEF combination and replace it with the
//      corresponding U+FEFB..U+FEFE ligature.
//   5. Reorder for visual presentation: split into runs, reverse Arabic runs,
//      keep Latin/digit/punctuation runs in logical order.
//   6. Encode codepoints back to UTF-8.
// ============================================================================

namespace
{
        // Joining types.
        enum JoinType : uint8_t {
                JT_U = 0,  // non-joining
                JT_R,      // right-joining   (links only on its right side)
                JT_D,      // dual-joining    (links both sides)
                JT_L,      // left-joining    (rare, e.g. Hebrew-style)
                JT_T,      // transparent     (combining marks)
                JT_C       // join-causing    (zwj-like)
        };

        // Joining type for U+0620..U+06FF.
        // Generated from Unicode's ArabicShaping.txt (Unicode 15) – truncated
        // at 0x06FF; codepoints not in the table fall back to JT_U via the
        // helper below.
        static const uint8_t kJoinType[] = {
	/*0620*/ JT_D, JT_U, JT_R, JT_R, JT_R, JT_R, JT_D, JT_R,
	/*0628*/ JT_D, JT_R, JT_D, JT_D, JT_D, JT_D, JT_D, JT_R,
	/*0630*/ JT_R, JT_R, JT_R, JT_D, JT_D, JT_D, JT_D, JT_D,
	/*0638*/ JT_D, JT_D, JT_D, JT_D, JT_D, JT_D, JT_D, JT_D,
	/*0640*/ JT_C, JT_D, JT_D, JT_D, JT_D, JT_D, JT_D, JT_D,
	/*0648*/ JT_R, JT_D, JT_D, JT_U, JT_U, JT_U, JT_U, JT_U,
	/*0650*/ JT_U, JT_U, JT_U, JT_U, JT_U, JT_U, JT_U, JT_U,
	/*0658*/ JT_U, JT_U, JT_U, JT_U, JT_U, JT_U, JT_U, JT_U,
	/*0660*/ JT_U, JT_U, JT_U, JT_U, JT_U, JT_U, JT_U, JT_U,
	/*0668*/ JT_U, JT_U, JT_U, JT_U, JT_U, JT_U, JT_D, JT_D,
	/*0670*/ JT_U, JT_R, JT_R, JT_R, JT_U, JT_R, JT_R, JT_R,
	/*0678*/ JT_D, JT_D, JT_D, JT_D, JT_D, JT_D, JT_D, JT_D,
	/*0680*/ JT_D, JT_D, JT_D, JT_D, JT_D, JT_D, JT_D, JT_D,
	/*0688*/ JT_R, JT_R, JT_R, JT_R, JT_R, JT_R, JT_R, JT_R,
	/*0690*/ JT_R, JT_R, JT_R, JT_R, JT_R, JT_R, JT_R, JT_R,
	/*0698*/ JT_R, JT_R, JT_D, JT_D, JT_D, JT_D, JT_D, JT_D,
	/*06A0*/ JT_D, JT_D, JT_D, JT_D, JT_D, JT_D, JT_D, JT_D,
	/*06A8*/ JT_D, JT_D, JT_D, JT_D, JT_D, JT_D, JT_D, JT_D,
	/*06B0*/ JT_D, JT_D, JT_D, JT_D, JT_D, JT_D, JT_D, JT_D,
	/*06B8*/ JT_D, JT_D, JT_D, JT_D, JT_D, JT_D, JT_D, JT_D,
	/*06C0*/ JT_R, JT_D, JT_D, JT_R, JT_R, JT_R, JT_R, JT_R,
	/*06C8*/ JT_R, JT_R, JT_R, JT_R, JT_D, JT_R, JT_D, JT_R,
	/*06D0*/ JT_D, JT_D, JT_R, JT_R, JT_U, JT_R, JT_U, JT_U,
	/*06D8*/ JT_U, JT_U, JT_U, JT_U, JT_U, JT_U, JT_U, JT_U,
	/*06E0*/ JT_U, JT_U, JT_U, JT_U, JT_U, JT_U, JT_U, JT_U,
	/*06E8*/ JT_U, JT_U, JT_U, JT_U, JT_U, JT_U, JT_R, JT_R,
	/*06F0*/ JT_U, JT_U, JT_U, JT_U, JT_U, JT_U, JT_U, JT_U,
	/*06F8*/ JT_U, JT_U, JT_D, JT_D, JT_D, JT_U, JT_U, JT_D,
};

        JoinType GetJoinType(uint32_t cp)
        {
                if (cp >= 0x0620 && cp < 0x0620 + sizeof(kJoinType))
                        return (JoinType)kJoinType[cp - 0x0620];
                return JT_U;
        }

        bool IsArabicCp(uint32_t cp)
        {
                return (cp >= 0x0600 && cp <= 0x06FF) ||
                       (cp >= 0xFB50 && cp <= 0xFDFF) ||
                       (cp >= 0xFE70 && cp <= 0xFEFF);
        }

        // Mapping of base Arabic letters (U+0621..U+064A and a few extended)
        // to {isolated, final, initial, medial} presentation forms.
        // 0 means "no such form, fall back to isolated".
        struct FormSet { uint32_t iso, fin, ini, med; };

        static const struct { uint32_t base; FormSet f; } kFormTable[] = {
                {0x0621, {0xFE80,      0,      0,      0}}, // hamza
                {0x0622, {0xFE81, 0xFE82,      0,      0}}, // alef madda
                {0x0623, {0xFE83, 0xFE84,      0,      0}}, // alef hamza above
                {0x0624, {0xFE85, 0xFE86,      0,      0}}, // waw hamza
                {0x0625, {0xFE87, 0xFE88,      0,      0}}, // alef hamza below
                {0x0626, {0xFE89, 0xFE8A, 0xFE8B, 0xFE8C}}, // yeh hamza
                {0x0627, {0xFE8D, 0xFE8E,      0,      0}}, // alef
                {0x0628, {0xFE8F, 0xFE90, 0xFE91, 0xFE92}}, // beh
                {0x0629, {0xFE93, 0xFE94,      0,      0}}, // teh marbuta
                {0x062A, {0xFE95, 0xFE96, 0xFE97, 0xFE98}}, // teh
                {0x062B, {0xFE99, 0xFE9A, 0xFE9B, 0xFE9C}}, // theh
                {0x062C, {0xFE9D, 0xFE9E, 0xFE9F, 0xFEA0}}, // jeem
                {0x062D, {0xFEA1, 0xFEA2, 0xFEA3, 0xFEA4}}, // hah
                {0x062E, {0xFEA5, 0xFEA6, 0xFEA7, 0xFEA8}}, // khah
                {0x062F, {0xFEA9, 0xFEAA,      0,      0}}, // dal
                {0x0630, {0xFEAB, 0xFEAC,      0,      0}}, // thal
                {0x0631, {0xFEAD, 0xFEAE,      0,      0}}, // reh
                {0x0632, {0xFEAF, 0xFEB0,      0,      0}}, // zain
                {0x0633, {0xFEB1, 0xFEB2, 0xFEB3, 0xFEB4}}, // seen
                {0x0634, {0xFEB5, 0xFEB6, 0xFEB7, 0xFEB8}}, // sheen
                {0x0635, {0xFEB9, 0xFEBA, 0xFEBB, 0xFEBC}}, // sad
                {0x0636, {0xFEBD, 0xFEBE, 0xFEBF, 0xFEC0}}, // dad
                {0x0637, {0xFEC1, 0xFEC2, 0xFEC3, 0xFEC4}}, // tah
                {0x0638, {0xFEC5, 0xFEC6, 0xFEC7, 0xFEC8}}, // zah
                {0x0639, {0xFEC9, 0xFECA, 0xFECB, 0xFECC}}, // ain
                {0x063A, {0xFECD, 0xFECE, 0xFECF, 0xFED0}}, // ghain
                {0x0640, {0x0640, 0x0640, 0x0640, 0x0640}}, // tatweel
                {0x0641, {0xFED1, 0xFED2, 0xFED3, 0xFED4}}, // feh
                {0x0642, {0xFED5, 0xFED6, 0xFED7, 0xFED8}}, // qaf
                {0x0643, {0xFED9, 0xFEDA, 0xFEDB, 0xFEDC}}, // kaf
                {0x0644, {0xFEDD, 0xFEDE, 0xFEDF, 0xFEE0}}, // lam
                {0x0645, {0xFEE1, 0xFEE2, 0xFEE3, 0xFEE4}}, // meem
                {0x0646, {0xFEE5, 0xFEE6, 0xFEE7, 0xFEE8}}, // noon
                {0x0647, {0xFEE9, 0xFEEA, 0xFEEB, 0xFEEC}}, // heh
                {0x0648, {0xFEED, 0xFEEE,      0,      0}}, // waw
                {0x0649, {0xFEEF, 0xFEF0,      0,      0}}, // alef maksura
                {0x064A, {0xFEF1, 0xFEF2, 0xFEF3, 0xFEF4}}, // yeh
        };

        const FormSet* GetForms(uint32_t cp)
        {
                for (size_t i = 0; i < sizeof(kFormTable)/sizeof(kFormTable[0]); ++i)
                        if (kFormTable[i].base == cp) return &kFormTable[i].f;
                return nullptr;
        }

        // LAM-ALEF ligatures (U+FEFB..U+FEFE).
        struct LamAlef { uint32_t alef, iso, fin; };
        static const LamAlef kLamAlef[] = {
                {0x0622, 0xFEF5, 0xFEF6}, // lam + alef madda
                {0x0623, 0xFEF7, 0xFEF8}, // lam + alef hamza above
                {0x0625, 0xFEF9, 0xFEFA}, // lam + alef hamza below
                {0x0627, 0xFEFB, 0xFEFC}, // lam + alef
        };

        // -------- UTF-8 decode/encode --------

        bool DecodeUtf8(const char* s, int len, std::vector<uint32_t>& out)
        {
                out.clear();
                if (len < 0) len = (int)std::strlen(s);
                int i = 0;
                while (i < len)
                {
                        uint8_t c0 = (uint8_t)s[i];
                        uint32_t cp = 0;
                        int extra = 0;
                        if (c0 < 0x80)        { cp = c0; extra = 0; }
                        else if ((c0 & 0xE0) == 0xC0) { cp = c0 & 0x1F; extra = 1; }
                        else if ((c0 & 0xF0) == 0xE0) { cp = c0 & 0x0F; extra = 2; }
                        else if ((c0 & 0xF8) == 0xF0) { cp = c0 & 0x07; extra = 3; }
                        else { ++i; continue; }
                        if (i + extra >= len) break;
                        for (int k = 0; k < extra; ++k)
                        {
                                cp = (cp << 6) | ((uint8_t)s[i + 1 + k] & 0x3F);
                        }
                        out.push_back(cp);
                        i += 1 + extra;
                }
                return true;
        }

        void EncodeUtf8(uint32_t cp, std::string& out)
        {
                if (cp < 0x80)      out.push_back((char)cp);
                else if (cp < 0x800){ out.push_back((char)(0xC0 | (cp >> 6))); out.push_back((char)(0x80 | (cp & 0x3F))); }
                else if (cp < 0x10000){ out.push_back((char)(0xE0 | (cp >> 12))); out.push_back((char)(0x80 | ((cp >> 6) & 0x3F))); out.push_back((char)(0x80 | (cp & 0x3F))); }
                else                 { out.push_back((char)(0xF0 | (cp >> 18))); out.push_back((char)(0x80 | ((cp >> 12) & 0x3F))); out.push_back((char)(0x80 | ((cp >> 6) & 0x3F))); out.push_back((char)(0x80 | (cp & 0x3F))); }
        }

        bool LinksOnRight(JoinType jt)  { return jt == JT_D || jt == JT_R || jt == JT_C; } // joins on its right side
        bool LinksOnLeft (JoinType jt)  { return jt == JT_D || jt == JT_L || jt == JT_C; } // joins on its left side
}

bool Arabic::ContainsArabic(const char* utf8, int len)
{
        if (!utf8) return false;
        if (len < 0) len = (int)std::strlen(utf8);
        std::vector<uint32_t> cps;
        DecodeUtf8(utf8, len, cps);
        for (size_t i = 0; i < cps.size(); ++i)
                if (IsArabicCp(cps[i])) return true;
        return false;
}

std::string Arabic::Shape(const char* utf8, int len)
{
        if (!utf8) return std::string();
        if (len < 0) len = (int)std::strlen(utf8);

        std::vector<uint32_t> cps;
        DecodeUtf8(utf8, len, cps);
        if (cps.empty()) return std::string();

        // Pre-compute join types and shaped variants per glyph.
        struct G { uint32_t cp; JoinType jt; bool isArabic; };
        std::vector<G> glyphs;
        glyphs.reserve(cps.size());
        for (size_t i = 0; i < cps.size(); ++i)
        {
                G g;
                g.cp = cps[i];
                g.isArabic = IsArabicCp(g.cp);
                g.jt = g.isArabic ? GetJoinType(g.cp) : JT_U;
                glyphs.push_back(g);
        }

        // Helper to look at the next/prev *non-transparent* glyph for join
        // decisions (combining marks must not break joining).
        auto NextNonT = [&](size_t i) -> int {
                for (size_t j = i + 1; j < glyphs.size(); ++j)
                        if (glyphs[j].jt != JT_T) return (int)j;
                return -1;
        };
        auto PrevNonT = [&](size_t i) -> int {
                if (i == 0) return -1;
                for (int j = (int)i - 1; j >= 0; --j)
                        if (glyphs[(size_t)j].jt != JT_T) return j;
                return -1;
        };

        // Shape: pick presentation form for each Arabic glyph.
        std::vector<uint32_t> shaped(glyphs.size());
        for (size_t i = 0; i < glyphs.size(); ++i)
        {
                shaped[i] = glyphs[i].cp;
                if (!glyphs[i].isArabic || glyphs[i].jt == JT_T) continue;

                const FormSet* f = GetForms(glyphs[i].cp);
                if (!f) continue;

                int prev = PrevNonT(i);
                int next = NextNonT(i);

                bool prevLinks = (prev >= 0) && glyphs[(size_t)prev].isArabic && LinksOnLeft(glyphs[(size_t)prev].jt);
                bool selfLinksLeft  = LinksOnLeft(glyphs[i].jt);   // can this glyph link to its left
                bool selfLinksRight = LinksOnRight(glyphs[i].jt);  // can this glyph link to its right
                bool nextLinks = (next >= 0) && glyphs[(size_t)next].isArabic && LinksOnRight(glyphs[(size_t)next].jt);

                bool linkPrev = prevLinks && selfLinksRight;
                bool linkNext = nextLinks && selfLinksLeft;

                uint32_t pick = f->iso;
                if      ( linkPrev &&  linkNext && f->med) pick = f->med;
                else if (!linkPrev &&  linkNext && f->ini) pick = f->ini;
                else if ( linkPrev && !linkNext && f->fin) pick = f->fin;
                else                                       pick = f->iso;
                shaped[i] = pick;
        }

        // LAM + ALEF ligatures: walk the shaped string and merge.
        std::vector<uint32_t> ligatured;
        ligatured.reserve(shaped.size());
        for (size_t i = 0; i < shaped.size(); ++i)
        {
                bool merged = false;
                if (i + 1 < shaped.size() && glyphs[i].cp == 0x0644 /* lam */)
                {
                        for (size_t k = 0; k < sizeof(kLamAlef)/sizeof(kLamAlef[0]); ++k)
                        {
                                if (glyphs[i + 1].cp == kLamAlef[k].alef)
                                {
                                        // The lam took its initial/medial form
                                        // depending on context; if it's medial/final
                                        // we use the "fin" (i.e. linked) ligature,
                                        // else "iso".
                                        bool lamLinked = (shaped[i] == GetForms(0x0644)->med || shaped[i] == GetForms(0x0644)->fin);
                                        ligatured.push_back(lamLinked ? kLamAlef[k].fin : kLamAlef[k].iso);
                                        ++i; // skip the alef
                                        merged = true;
                                        break;
                                }
                        }
                }
                if (!merged) ligatured.push_back(shaped[i]);
        }

        // BiDi reorder for an LTR-only renderer (ImGui).
        //
        // The message is treated as an RTL paragraph because we only enter
        // this function when ContainsArabic() is true. We split the line into
        // runs of strong direction (RTL Arabic vs. LTR Latin/digit), with
        // neutrals (spaces, punctuation, brackets) attached to the correct
        // surrounding strong direction, then:
        //   * reverse the run ORDER (so the first logical run ends up on the
        //     right side of the rendered output),
        //   * reverse the CHARACTERS inside each RTL run (because ImGui will
        //     paint them left-to-right),
        //   * keep characters of LTR runs in original order.
        //
        // Example:
        //     logical : "هذا الأمر استخدم /menu, إلى تعرف"
        //     visual  : "فرعت ىلإ ,/menu مدختسا رمألا اذه"
        // Reading the visual right-to-left yields the original logical
        // sentence, with the Latin token "/menu," kept LTR in the middle.
        auto isStrongLtr = [](uint32_t cp) {
                return (cp >= 'A' && cp <= 'Z') || (cp >= 'a' && cp <= 'z') ||
                       (cp >= '0' && cp <= '9');
        };
        auto isStrongRtl = [](uint32_t cp) {
                // Arabic, plus shaped presentation forms produced earlier in
                // this function.
                return (cp >= 0x0590 && cp <= 0x08FF) ||
                       (cp >= 0xFB1D && cp <= 0xFDFF) ||
                       (cp >= 0xFE70 && cp <= 0xFEFF);
        };

        // Direction tag per codepoint: 'R' = RTL strong, 'L' = LTR strong,
        // 'N' = neutral (everything else: spaces, punctuation, ZWJ, etc.).
        const size_t N = ligatured.size();
        std::vector<char> dir(N, 'N');
        for (size_t k = 0; k < N; ++k)
        {
                if      (isStrongRtl(ligatured[k])) dir[k] = 'R';
                else if (isStrongLtr(ligatured[k])) dir[k] = 'L';
        }

        // Resolve neutrals: a run of neutrals between two strongs of the same
        // direction takes that direction; otherwise it takes the paragraph
        // direction (RTL here).
        size_t k = 0;
        while (k < N)
        {
                if (dir[k] != 'N') { ++k; continue; }
                size_t s = k;
                while (k < N && dir[k] == 'N') ++k;
                char prev = (s == 0)   ? 'R' : dir[s - 1]; // start of line uses paragraph dir
                char next = (k == N)   ? 'R' : dir[k];     // end of line uses paragraph dir
                char take = (prev == next) ? prev : 'R';
                for (size_t q = s; q < k; ++q) dir[q] = take;
        }

        // Build runs of contiguous same-direction codepoints.
        struct Run { size_t lo, hi; char d; }; // [lo, hi)
        std::vector<Run> runs;
        for (size_t s = 0; s < N; )
        {
                size_t e = s + 1;
                while (e < N && dir[e] == dir[s]) ++e;
                runs.push_back({s, e, dir[s]});
                s = e;
        }

        // Emit visual buffer: reversed run order; reverse chars of RTL runs;
        // keep chars of LTR runs as-is.
        std::vector<uint32_t> visual;
        visual.reserve(N);
        for (size_t r = runs.size(); r-- > 0; )
        {
                const Run& run = runs[r];
                if (run.d == 'L')
                {
                        for (size_t q = run.lo; q < run.hi; ++q)
                                visual.push_back(ligatured[q]);
                }
                else
                {
                        for (size_t q = run.hi; q-- > run.lo; )
                                visual.push_back(ligatured[q]);
                }
        }

        // Encode back to UTF-8.
        std::string out;
        out.reserve(visual.size() * 2);
        for (size_t k = 0; k < visual.size(); ++k) EncodeUtf8(visual[k], out);
        return out;
}
