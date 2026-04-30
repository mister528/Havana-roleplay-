#include "arabic.h"

#include <cstdint>
#include <cstring>
#include <vector>
#include <string>

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
        // We only return true when the input contains *unshaped* Arabic
        // (basic block U+0600..U+06FF). Strings made up exclusively of
        // Arabic Presentation Forms (U+FE70..U+FEFF and U+FB50..U+FDFF)
        // have already been shaped + bidi-reordered by an earlier call
        // to Shape(); re-running Shape() on them would reverse the BiDi
        // ordering a second time. Guarding here keeps re-entry safe so
        // callers like CChatWindow::RenderText can pre-shape a whole
        // colour-tagged paragraph and then hand individual visual runs
        // off to ImDrawList::AddText without it shaping each run again.
        if (!utf8) return false;
        if (len < 0) len = (int)std::strlen(utf8);
        std::vector<uint32_t> cps;
        DecodeUtf8(utf8, len, cps);
        for (size_t i = 0; i < cps.size(); ++i)
                if (cps[i] >= 0x0600 && cps[i] <= 0x06FF) return true;
        return false;
}

// ---------------------------------------------------------------------------
// Internal shaping core
// ---------------------------------------------------------------------------
//
// Operates entirely on codepoint arrays. Produces:
//   * `out_visual` - codepoints in visual (left-to-right paint) order.
//   * `out_src`    - parallel array; out_src[k] is the index of the source
//                    codepoint (0..cps.size()-1) that out_visual[k] came
//                    from. For LAM+ALEF ligatures we record the index of
//                    the LAM (first of the two source codepoints).
//
// `Arabic::Shape` is now a thin UTF-8 wrapper around this helper.
namespace
{
        void ShapeCodepoints(const std::vector<uint32_t>& cps,
                             std::vector<uint32_t>& out_visual,
                             std::vector<int>&      out_src)
        {
                out_visual.clear();
                out_src.clear();
                if (cps.empty()) return;

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
        // Track the original source-codepoint index of each ligatured glyph
        // so callers can map output codepoints back to colour tags etc.
        std::vector<uint32_t> ligatured;
        std::vector<int>      ligatured_src;
        ligatured.reserve(shaped.size());
        ligatured_src.reserve(shaped.size());
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
                                        ligatured_src.push_back((int)i); // attribute ligature to the LAM
                                        ++i; // skip the alef
                                        merged = true;
                                        break;
                                }
                        }
                }
                if (!merged)
                {
                        ligatured.push_back(shaped[i]);
                        ligatured_src.push_back((int)i);
                }
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
        size_t countR = 0, countL = 0;
        for (size_t k = 0; k < N; ++k)
        {
                if      (isStrongRtl(ligatured[k])) { dir[k] = 'R'; ++countR; }
                else if (isStrongLtr(ligatured[k])) { dir[k] = 'L'; ++countL; }
        }

        // Pick paragraph base direction.
        //
        // For lines that are mostly Arabic (e.g. system / admin announcements
        // such as "* إداري ahmadgatga عند تم مسحه chat.") we use RTL base so
        // the line reads correctly right-to-left.
        //
        // For lines that are mostly Latin with an Arabic word embedded
        // (e.g. player-list rows "- علا (ahmadgatga) [0]") we use LTR base so
        // the brackets and level fields stay in the same visual position as
        // the all-Latin rows ("- hi (ahmadgatga) [0]"). Without this the
        // surrounding LTR runs would get reordered around the embedded
        // Arabic name and produce "(ahmadgatga) [0] ﻼﻋ -" instead of
        // "- ﻼﻋ (ahmadgatga) [0]".
        const char paraDir = (countL > countR) ? 'L' : 'R';

        // ---- Unicode BiDi rule N0: paired bracket resolution. ----
        // Match opening / closing brackets with a stack and assign both
        // brackets in a pair the direction of the strong characters they
        // enclose. This stops a Latin name in parens (e.g. "(ahmadgatga)")
        // from having one bracket attached to the surrounding Arabic run
        // and the other to the Latin run, which produced "]ahmadgatga) [0("
        // garbage when the line starts with an Arabic player name.
        {
                auto bracketKind = [](uint32_t cp) -> int {
                        switch (cp) {
                                case '(': case '[': case '{': return +1;
                                case ')': case ']': case '}': return -1;
                        }
                        return 0;
                };
                auto bracketsMatch = [](uint32_t op, uint32_t cl) {
                        return (op == '(' && cl == ')') ||
                               (op == '[' && cl == ']') ||
                               (op == '{' && cl == '}');
                };
                struct BPair { size_t open_idx, close_idx; };
                std::vector<BPair> bpairs;
                std::vector<size_t> bstack;
                for (size_t i = 0; i < N; ++i)
                {
                        int kind = bracketKind(ligatured[i]);
                        if (kind == +1) bstack.push_back(i);
                        else if (kind == -1)
                        {
                                for (size_t s = bstack.size(); s-- > 0; )
                                {
                                        if (bracketsMatch(ligatured[bstack[s]],
                                                          ligatured[i]))
                                        {
                                                bpairs.push_back({bstack[s], i});
                                                bstack.resize(s);
                                                break;
                                        }
                                }
                        }
                }
                for (size_t p = 0; p < bpairs.size(); ++p)
                {
                        char hasR = 0, hasL = 0;
                        for (size_t q = bpairs[p].open_idx + 1;
                             q < bpairs[p].close_idx; ++q)
                        {
                                if (dir[q] == 'R') hasR = 1;
                                if (dir[q] == 'L') hasL = 1;
                        }
                        char take = 0;
                        if      (hasR) take = 'R';
                        else if (hasL) take = 'L';
                        if (take)
                        {
                                dir[bpairs[p].open_idx ] = take;
                                dir[bpairs[p].close_idx] = take;
                        }
                }
        }

        // Resolve neutrals: a run of neutrals between two strongs of the same
        // direction takes that direction; otherwise it takes the paragraph
        // base direction.
        size_t k = 0;
        while (k < N)
        {
                if (dir[k] != 'N') { ++k; continue; }
                size_t s = k;
                while (k < N && dir[k] == 'N') ++k;
                char prev = (s == 0)   ? paraDir : dir[s - 1];
                char next = (k == N)   ? paraDir : dir[k];
                char take = (prev == next) ? prev : paraDir;
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

        // Emit visual buffer:
        //   * Run order: reversed for RTL paragraphs, kept logical for LTR.
        //   * LTR runs: characters in original order.
        //   * RTL runs: characters reversed because ImGui paints LTR.
        out_visual.reserve(N);
        out_src.reserve(N);
        auto emitRun = [&](const Run& run)
        {
                if (run.d == 'L')
                {
                        for (size_t q = run.lo; q < run.hi; ++q)
                        {
                                out_visual.push_back(ligatured[q]);
                                out_src.push_back(ligatured_src[q]);
                        }
                }
                else
                {
                        for (size_t q = run.hi; q-- > run.lo; )
                        {
                                // Mirror brackets that ended up in the RTL
                                // run so they still "open" on the correct
                                // side when read right-to-left.
                                uint32_t cp = ligatured[q];
                                switch (cp) {
                                        case '(': cp = ')'; break;
                                        case ')': cp = '('; break;
                                        case '[': cp = ']'; break;
                                        case ']': cp = '['; break;
                                        case '{': cp = '}'; break;
                                        case '}': cp = '{'; break;
                                }
                                out_visual.push_back(cp);
                                out_src.push_back(ligatured_src[q]);
                        }
                }
        };
        if (paraDir == 'R')
        {
                for (size_t r = runs.size(); r-- > 0; ) emitRun(runs[r]);
        }
        else
        {
                for (size_t r = 0; r < runs.size(); ++r) emitRun(runs[r]);
        }
        }

        // ----- LTR-only fallback used when the input has no Arabic -----
        // Keeps the codepoint order; produces an identity src map.
        void PassThroughCodepoints(const std::vector<uint32_t>& cps,
                                   std::vector<uint32_t>& out_visual,
                                   std::vector<int>&      out_src)
        {
                out_visual.assign(cps.begin(), cps.end());
                out_src.resize(cps.size());
                for (size_t i = 0; i < cps.size(); ++i) out_src[i] = (int)i;
        }
} // anonymous namespace

// ---------------------------------------------------------------------------
// Public API
// ---------------------------------------------------------------------------

std::string Arabic::Shape(const char* utf8, int len)
{
        if (!utf8) return std::string();
        if (len < 0) len = (int)std::strlen(utf8);

        std::vector<uint32_t> cps;
        DecodeUtf8(utf8, len, cps);
        if (cps.empty()) return std::string();

        std::vector<uint32_t> visual;
        std::vector<int>      src;
        ShapeCodepoints(cps, visual, src);

        std::string out;
        out.reserve(visual.size() * 2);
        for (size_t k = 0; k < visual.size(); ++k) EncodeUtf8(visual[k], out);
        return out;
}

void Arabic::ShapeWithSourceMap(const char* utf8, int len,
                                std::string& out_utf8,
                                std::vector<int>& out_src_cp_idx,
                                int* out_src_cp_count)
{
        out_utf8.clear();
        out_src_cp_idx.clear();
        if (!utf8) { if (out_src_cp_count) *out_src_cp_count = 0; return; }
        if (len < 0) len = (int)std::strlen(utf8);

        std::vector<uint32_t> cps;
        DecodeUtf8(utf8, len, cps);
        if (out_src_cp_count) *out_src_cp_count = (int)cps.size();
        if (cps.empty()) return;

        std::vector<uint32_t> visual;

        // Only run the BiDi/shape pass when the paragraph actually has
        // Arabic; otherwise rendering RTL-context rules onto a pure LTR
        // line would mis-place punctuation.
        bool hasArabic = false;
        for (size_t i = 0; i < cps.size(); ++i)
                if (IsArabicCp(cps[i])) { hasArabic = true; break; }

        if (hasArabic) ShapeCodepoints(cps, visual, out_src_cp_idx);
        else           PassThroughCodepoints(cps, visual, out_src_cp_idx);

        out_utf8.reserve(visual.size() * 2);
        for (size_t k = 0; k < visual.size(); ++k) EncodeUtf8(visual[k], out_utf8);
}

int Arabic::CountCodepoints(const char* utf8, int len)
{
        if (!utf8) return 0;
        if (len < 0) len = (int)std::strlen(utf8);
        std::vector<uint32_t> cps;
        DecodeUtf8(utf8, len, cps);
        return (int)cps.size();
}

float Arabic::RenderColouredLine(const ColouredChunk* chunks, int n_chunks,
                                 DrawRunFn draw_run, void* user)
{
        if (!chunks || n_chunks <= 0 || !draw_run) return 0.0f;

        // 1. Concatenate every chunk into a single UTF-8 buffer and build
        //    a per-source-codepoint colour array.
        std::string concat;
        std::vector<uint32_t> cp_color;
        bool hasArabic = false;

        for (int i = 0; i < n_chunks; ++i)
        {
                const char* p = chunks[i].utf8;
                int         L = chunks[i].len;
                if (!p) continue;
                if (L < 0) L = (int)std::strlen(p);
                if (L <= 0) continue;

                std::vector<uint32_t> cps;
                DecodeUtf8(p, L, cps);
                for (size_t k = 0; k < cps.size(); ++k)
                {
                        cp_color.push_back(chunks[i].color_id);
                        if (IsArabicCp(cps[k])) hasArabic = true;
                }
                concat.append(p, p + L);
        }

        if (cp_color.empty()) return 0.0f;

        // 2. If there's no Arabic at all the original logical order is
        //    correct; emit each chunk as its own visual run to preserve
        //    fast-path width arithmetic.
        if (!hasArabic)
        {
                float x = 0.0f;
                for (int i = 0; i < n_chunks; ++i)
                {
                        const char* p = chunks[i].utf8;
                        int L = chunks[i].len;
                        if (!p) continue;
                        if (L < 0) L = (int)std::strlen(p);
                        if (L <= 0) continue;
                        x += draw_run(p, L, chunks[i].color_id, x, user);
                }
                return x;
        }

        // 3. Shape + BiDi-reorder the whole concatenated string.
        std::string visual_utf8;
        std::vector<int> src_cp;
        int src_cp_count = 0;
        ShapeWithSourceMap(concat.c_str(), (int)concat.size(),
                           visual_utf8, src_cp, &src_cp_count);

        // Sanity-check: the colour array must be at least src_cp_count
        // entries long. If for some reason it isn't (shouldn't happen),
        // fall back to logical order to avoid OOB reads.
        if ((int)cp_color.size() != src_cp_count)
        {
                float x = 0.0f;
                for (int i = 0; i < n_chunks; ++i)
                {
                        const char* p = chunks[i].utf8;
                        int L = chunks[i].len;
                        if (!p) continue;
                        if (L < 0) L = (int)std::strlen(p);
                        if (L <= 0) continue;
                        x += draw_run(p, L, chunks[i].color_id, x, user);
                }
                return x;
        }

        // 4. Walk the visual UTF-8, grouping consecutive codepoints with
        //    the same source colour into one drawn run.
        const char* vp     = visual_utf8.c_str();
        const char* vend   = vp + visual_utf8.size();
        int         out_cp = 0;
        float       x_off  = 0.0f;

        while (vp < vend)
        {
                uint32_t color = cp_color[src_cp[out_cp]];
                const char* run_begin = vp;

                // Advance over one codepoint at a time while the colour
                // (looked up via src_cp[out_cp]) stays the same.
                while (vp < vend)
                {
                        uint8_t b = (uint8_t)*vp;
                        int step = 1;
                        if      ((b & 0x80) == 0x00) step = 1;
                        else if ((b & 0xE0) == 0xC0) step = 2;
                        else if ((b & 0xF0) == 0xE0) step = 3;
                        else if ((b & 0xF8) == 0xF0) step = 4;

                        if (vp + step > vend) break;
                        if (cp_color[src_cp[out_cp]] != color) break;

                        vp     += step;
                        out_cp += 1;
                }

                int run_len = (int)(vp - run_begin);
                if (run_len > 0)
                        x_off += draw_run(run_begin, run_len, color, x_off, user);
        }

        return x_off;
}
