#include "../main.h"
#include "gametextoverlay.h"
#include "gui.h"
#include "../arabic.h"
#include "../vendor/imgui/imgui.h"
#include "../vendor/imgui/imgui_internal.h"
#include <cstring>
#include <cstdio>
#include <vector>
#include <string>

extern CGUI* pGUI;
CGameTextOverlay* pGameTextOverlay = nullptr;

// Approximate per-style position/size mapping inspired by GTA SA's
// AddBigMessage style table. Coordinates are NORMALIZED screen ratios.
struct StyleSpec
{
    float yRatio;    // vertical position (top of message block)
    float fontSize;  // base font px @ 1080p
    bool  centered;
};
static StyleSpec StyleFor(int t)
{
    switch (t)
    {
        case 0:  return { 0.42f, 80.0f, true  };  // Big top centered
        case 1:  return { 0.80f, 56.0f, true  };  // Bottom-centered status
        case 2:  return { 0.35f, 70.0f, true  };  // Mission complete
        case 3:  return { 0.55f, 56.0f, true  };  // Mid status
        case 4:  return { 0.66f, 50.0f, true  };  // Low status
        case 5:  return { 0.42f, 64.0f, true  };  // Centred medium
        case 6:  return { 0.30f, 90.0f, true  };  // Very large top
        default: return { 0.42f, 80.0f, true  };
    }
}

CGameTextOverlay::CGameTextOverlay()
{
    for (int i = 0; i < MAX_ENTRIES; ++i)
    {
        m_entries[i].active    = false;
        m_entries[i].text[0]   = '\0';
        m_entries[i].type      = 0;
        m_entries[i].remaining = 0.0f;
        m_entries[i].total     = 0.0f;
    }
}
CGameTextOverlay::~CGameTextOverlay() {}

void CGameTextOverlay::Clear()
{
    for (int i = 0; i < MAX_ENTRIES; ++i) m_entries[i].active = false;
}

bool CGameTextOverlay::TryShow(const char* utf8, int iTime, int iType)
{
    if (!utf8 || !utf8[0]) return false;
    if (!Arabic::ContainsArabic(utf8, -1)) return false;

    // Preempt any older entry with the same style slot first; otherwise pick
    // the first inactive slot.
    int slot = -1;
    for (int i = 0; i < MAX_ENTRIES; ++i)
    {
        if (m_entries[i].active && m_entries[i].type == iType) { slot = i; break; }
    }
    if (slot < 0)
    {
        for (int i = 0; i < MAX_ENTRIES; ++i)
            if (!m_entries[i].active) { slot = i; break; }
    }
    if (slot < 0) slot = 0; // overwrite oldest

    Entry& e = m_entries[slot];
    e.active = true;
    e.type   = iType;
    // SAMP iTime is in milliseconds.
    if (iTime <= 0) iTime = 5000;
    if (iTime > 30000) iTime = 30000;
    e.remaining = iTime / 1000.0f;
    e.total     = e.remaining;
    strncpy(e.text, utf8, sizeof(e.text) - 1);
    e.text[sizeof(e.text) - 1] = '\0';
    return true;
}

// Strip {RRGGBB[AA]} colour tags AND normalise GTA-style "~X~" tokens.
//   ~n~       -> newline
//   ~r~ ~g~ ~b~ ~y~ ~w~ ~h~ ~p~ ~l~  -> dropped (we don't recolour mid-text)
//   ~k~XXX~   -> dropped (key bind hint)
//   any other ~ ... ~ run is dropped to be safe.
// Outputs UTF-8 plain text where each '\n' is a logical line break.
static void StripColors(const char* in, char* out, size_t outlen)
{
    size_t j = 0;
    for (size_t i = 0; in[i] && j + 1 < outlen; ++i)
    {
        // {RRGGBB} / {RRGGBBAA} colour tag
        if (in[i] == '{')
        {
            size_t k = i + 1;
            int hexCount = 0;
            bool isColor = true;
            while (in[k] && in[k] != '}' && (k - i) < 12)
            {
                char c = in[k];
                if (!((c >= '0' && c <= '9') || (c >= 'A' && c <= 'F') ||
                      (c >= 'a' && c <= 'f')))
                { isColor = false; break; }
                hexCount++; k++;
            }
            if (isColor && in[k] == '}' && (hexCount == 6 || hexCount == 8))
            { i = k; continue; }
        }

        // GTA SA "~X~" markup. Specifically map ~n~ to newline so the
        // overlay can wrap multi-line GameText (e.g. /rlock messages).
        if (in[i] == '~')
        {
            // find closing '~'
            size_t k = i + 1;
            while (in[k] && in[k] != '~' && (k - i) < 8) k++;
            if (in[k] == '~' && (k - i) >= 1)
            {
                size_t taglen = k - i - 1;
                if (taglen == 1 && (in[i+1] == 'n' || in[i+1] == 'N'))
                {
                    if (j + 1 < outlen) out[j++] = '\n';
                }
                // Other ~X~ tokens are silently dropped.
                i = k;
                continue;
            }
        }

        out[j++] = in[i];
    }
    out[j] = '\0';
}

void CGameTextOverlay::Render()
{
    ImGuiIO& io = ImGui::GetIO();
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    float dt = io.DeltaTime;

    float scale = io.DisplaySize.y / 1080.0f;
    if (scale < 0.5f) scale = 0.5f;

    for (int i = 0; i < MAX_ENTRIES; ++i)
    {
        Entry& e = m_entries[i];
        if (!e.active) continue;
        e.remaining -= dt;
        if (e.remaining <= 0.0f) { e.active = false; continue; }

        // Strip colour codes / normalise ~X~ tokens for shaping.
        char clean[512];
        StripColors(e.text, clean, sizeof(clean));

        StyleSpec sp = StyleFor(e.type);
        float fontSize = sp.fontSize * scale;
        ImFont* font = ImGui::GetFont();

        // Fade in (first 0.25s) and fade out (last 0.5s).
        float a = 1.0f;
        float fadein  = 0.25f;
        float fadeout = 0.5f;
        if ((e.total - e.remaining) < fadein)
            a = (e.total - e.remaining) / fadein;
        else if (e.remaining < fadeout)
            a = e.remaining / fadeout;
        if (a < 0.0f) a = 0.0f;
        if (a > 1.0f) a = 1.0f;

        ImU32 colShadow = IM_COL32(0, 0, 0, (int)(220 * a));
        ImU32 colText   = IM_COL32(255, 255, 255, (int)(255 * a));

        // Split clean text into lines on '\n', shape each line independently
        // (so RTL reordering works per visual line), and stack them
        // vertically.
        struct LineEntry { std::string shaped; ImVec2 size; };
        std::vector<LineEntry> lines;
        const char* p = clean;
        while (true)
        {
            const char* nl = p;
            while (*nl && *nl != '\n') nl++;
            int len = (int)(nl - p);
            // Skip empty lines that come from "~n~~n~" runs collapsing into
            // adjacent newlines — keep one to give a small gap, but not
            // dozens.
            if (len > 0 || (lines.empty() ? false : !lines.back().shaped.empty()))
            {
                LineEntry le;
                if (len > 0)
                {
                    le.shaped = Arabic::Shape(p, len);
                }
                if (le.shaped.empty() && len == 0)
                    le.shaped = "";
                le.size   = font->CalcTextSizeA(fontSize, FLT_MAX, 0.0f,
                                                le.shaped.c_str());
                lines.push_back(le);
            }
            if (!*nl) break;
            p = nl + 1;
        }
        if (lines.empty()) continue;

        // Total block height + horizontal centering per line.
        float lineGap = fontSize * 0.18f;
        float totalH  = 0.0f;
        for (auto& le : lines) totalH += le.size.y + lineGap;
        if (totalH > 0) totalH -= lineGap;

        float yTop = io.DisplaySize.y * sp.yRatio;
        // For multi-line messages, lift up so the *block* sits at sp.yRatio.
        yTop -= totalH * 0.5f;
        if (yTop < 8.0f * scale) yTop = 8.0f * scale;

        for (auto& le : lines)
        {
            float x = (io.DisplaySize.x - le.size.x) * 0.5f;
            // Drop shadow + outline
            for (int oy = 1; oy <= 3; ++oy)
            for (int ox = -1; ox <= 1; ++ox)
            {
                if (ox == 0 && oy == 0) continue;
                dl->AddText(font, fontSize,
                            ImVec2(x + ox * scale, yTop + oy * scale),
                            colShadow, le.shaped.c_str());
            }
            dl->AddText(font, fontSize, ImVec2(x, yTop), colText, le.shaped.c_str());
            yTop += le.size.y + lineGap;
        }
    }
}
