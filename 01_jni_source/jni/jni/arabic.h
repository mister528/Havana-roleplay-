#pragma once

#include <string>

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
}
