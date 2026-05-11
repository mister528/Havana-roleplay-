#include "main.h"
#include "cmdsuggest.h"
#include "cmdsuggest_data.h"

#include "imgui/imgui.h"
#include "gui/gui.h"
#include "util/util.h"
#include "keyboard.h"

#include <cstdio>

#include <algorithm>
#include <cctype>
#include <cstring>
#include <vector>

extern CGUI* pGUI;

namespace
{
        struct ChipRect
        {
                float x0, y0, x1, y1;
                int   cmdIdx;
        };

        // Per-frame state computed in Render() and consumed in HandleTouch().
        std::vector<ChipRect> g_chips;
        float                 g_stripY  = 0.0f;
        float                 g_stripH  = 0.0f;
        float                 g_stripX0 = 0.0f;
        float                 g_stripX1 = 0.0f;
        float                 g_scroll  = 0.0f;
        float                 g_contentW = 0.0f;

        // Drag-to-scroll state.
        bool                  g_dragging   = false;
        int                   g_dragStartX = 0;
        float                 g_scrollAtDragStart = 0.0f;
        bool                  g_movedWhileDragging = false;

        // Local player admin level — populated from server chat messages.
        int                   g_adminLevel = 0;

        std::string ToLower(const std::string& s)
        {
                std::string r = s;
                for (size_t i = 0; i < r.size(); ++i) r[i] = (char)std::tolower((unsigned char)r[i]);
                return r;
        }

        // Extract the prefix (without leading '/') the user is currently
        // typing. Returns empty optional unless the input starts with '/' and
        // hasn't yet contained a space (i.e. we're still typing the command
        // name).
        bool ExtractPrefix(const std::string& in, std::string& prefixOut)
        {
                if (in.empty() || in[0] != '/') return false;
                size_t end = 1;
                while (end < in.size() && in[end] != ' ' && in[end] != '\t') ++end;
                if (end < in.size()) return false;
                prefixOut = ToLower(in.substr(1, end - 1));
                return true;
        }

        bool VisibleToPlayer(int idx)
        {
                int req = kCmdSuggestList[idx].adminLevel;
                return req == 0 || g_adminLevel >= req;
        }

        std::vector<int> Match(const std::string& prefix)
        {
                std::vector<int> out;
                out.reserve(64);

                for (size_t i = 0; i < kCmdSuggestCount; ++i)
                {
                        if (!VisibleToPlayer((int)i)) continue;
                        std::string lc = ToLower(kCmdSuggestList[i].name);
                        if (lc.compare(0, prefix.size(), prefix) == 0)
                        {
                                out.push_back((int)i);
                                if (out.size() >= 80) break;
                        }
                }

                if (out.size() < 12 && prefix.size() >= 2)
                {
                        for (size_t i = 0; i < kCmdSuggestCount; ++i)
                        {
                                if (!VisibleToPlayer((int)i)) continue;
                                std::string lc = ToLower(kCmdSuggestList[i].name);
                                size_t pos = lc.find(prefix);
                                if (pos != std::string::npos && pos != 0)
                                {
                                        out.push_back((int)i);
                                        if (out.size() >= 80) break;
                                }
                        }
                }
                return out;
        }

        // Replace cp1251Input with `/cmd ` and rebuild the visible utf8 view.
        void Replace(const char* cmd,
                     std::string& cp1251Input,
                     char*        utf8Input,
                     int&         inputOffset)
        {
                std::string next = "/";
                next += cmd;
                next += " ";
                if ((int)next.size() > MAX_INPUT_LEN) next.resize(MAX_INPUT_LEN);

                cp1251Input = next;
                inputOffset = 0;
                if (utf8Input) cp1251_to_utf8(utf8Input, cp1251Input.c_str());
        }
}

void CmdSuggest::Render(const ImVec2& keyboardPos,
                        const ImVec2& keyboardSize,
                        float          fontSize,
                        const std::string& cp1251Input)
{
        g_chips.clear();
        g_stripY = g_stripH = 0.0f;
        g_contentW = 0.0f;

        std::string prefix;
        if (!ExtractPrefix(cp1251Input, prefix)) return;

        std::vector<int> matches = Match(prefix);
        if (matches.empty()) return;

        if (!pGUI || !pGUI->GetFont()) return;
        ImFont* font = pGUI->GetFont();
        ImDrawList* dl = ImGui::GetOverlayDrawList();
        if (!dl) return;

        const float chipPadX = fontSize * 0.55f;
        const float chipPadY = fontSize * 0.30f;
        const float chipGap  = fontSize * 0.40f;
        const float chipH    = fontSize + chipPadY * 2.0f;
        const float stripPad = fontSize * 0.30f;
        const float stripH   = chipH + stripPad * 2.0f;
        const float stripX0  = keyboardPos.x;
        const float stripX1  = keyboardSize.x;
        const float stripY   = keyboardPos.y - stripH;

        g_stripY  = stripY;
        g_stripH  = stripH;
        g_stripX0 = stripX0;
        g_stripX1 = stripX1;

        // Background + top border.
        dl->AddRectFilled(ImVec2(stripX0, stripY), ImVec2(stripX1, stripY + stripH), 0xE0181818);
        dl->AddLine(ImVec2(stripX0, stripY + stripH), ImVec2(stripX1, stripY + stripH), 0xFF3291F5, 2.0f);

        // Render chips horizontally, scrolled by g_scroll.
        float xCursor = stripX0 + stripPad - g_scroll;
        for (size_t mi = 0; mi < matches.size(); ++mi)
        {
                int idx = matches[mi];
                const char* name = kCmdSuggestList[idx].name;

                char label[96];
                snprintf(label, sizeof(label), "/%s", name);

                ImVec2 textSize = font->CalcTextSizeA(fontSize, FLT_MAX, 0.0f, label, nullptr, nullptr);
                float chipW = textSize.x + chipPadX * 2.0f;
                float chipX = xCursor;
                float chipY = stripY + stripPad;

                // Clip-aware draw: only render if any part is in the visible band.
                if (chipX + chipW >= stripX0 && chipX <= stripX1)
                {
                        dl->AddRectFilled(ImVec2(chipX, chipY),
                                          ImVec2(chipX + chipW, chipY + chipH),
                                          0xFF2A2F3A,
                                          fontSize * 0.45f);
                        dl->AddRect(ImVec2(chipX, chipY),
                                    ImVec2(chipX + chipW, chipY + chipH),
                                    0xFF3291F5,
                                    fontSize * 0.45f);
                        dl->AddText(font, fontSize,
                                    ImVec2(chipX + chipPadX, chipY + chipPadY),
                                    0xFFFFFFFF, label);
                }

                ChipRect cr;
                cr.x0 = chipX;
                cr.y0 = chipY;
                cr.x1 = chipX + chipW;
                cr.y1 = chipY + chipH;
                cr.cmdIdx = idx;
                g_chips.push_back(cr);

                xCursor += chipW + chipGap;
        }

        g_contentW = (xCursor + g_scroll) - (stripX0 + stripPad);
}

bool CmdSuggest::HandleTouch(int type, int x, int y,
                             const ImVec2& keyboardPos,
                             const ImVec2& keyboardSize,
                             float          fontSize,
                             std::string&  cp1251Input,
                             char*         utf8Input,
                             int&          inputOffset)
{
        (void)keyboardSize;
        (void)fontSize;
        (void)keyboardPos;

        if (g_stripH <= 0.0f) return false;
        const bool inside = (y >= g_stripY && y <= g_stripY + g_stripH &&
                             x >= g_stripX0 && x <= g_stripX1);

        // gui/gui.h: TOUCH_POP = 1, TOUCH_PUSH = 2, TOUCH_MOVE = 3.
        if (type == 2 /*TOUCH_PUSH*/)
        {
                if (!inside) return false;
                g_dragging = true;
                g_dragStartX = x;
                g_scrollAtDragStart = g_scroll;
                g_movedWhileDragging = false;
                return true;
        }

        if (type == 3 /*TOUCH_MOVE*/)
        {
                if (!g_dragging) return inside;
                int dx = x - g_dragStartX;
                if (std::abs(dx) > 6) g_movedWhileDragging = true;
                float maxScroll = std::max(0.0f, g_contentW - (g_stripX1 - g_stripX0) + 8.0f);
                g_scroll = g_scrollAtDragStart - (float)dx;
                if (g_scroll < 0.0f) g_scroll = 0.0f;
                if (g_scroll > maxScroll) g_scroll = maxScroll;
                return true;
        }

        if (type == 1 /*TOUCH_POP*/)
        {
                bool wasDragging = g_dragging;
                bool moved = g_movedWhileDragging;
                g_dragging = false;
                g_movedWhileDragging = false;

                if (!wasDragging) return inside;
                if (moved) return true;  // consumed as scroll, no chip activation
                if (!inside) return false;

                for (size_t i = 0; i < g_chips.size(); ++i)
                {
                        const ChipRect& c = g_chips[i];
                        if (x >= c.x0 && x <= c.x1 && y >= c.y0 && y <= c.y1)
                        {
                                Replace(kCmdSuggestList[c.cmdIdx].name, cp1251Input, utf8Input, inputOffset);
                                return true;
                        }
                }
                return inside;
        }

        return false;
}

void CmdSuggest::SetAdminLevel(int level)
{
        if (level < 0) level = 0;
        g_adminLevel = level;
}

int CmdSuggest::GetAdminLevel()
{
        return g_adminLevel;
}

void CmdSuggest::OnIncomingClientMessage(const char* msg, const char* localName)
{
        if (!msg || !localName || !*localName) return;

        // Server gamemode broadcasts to all admins:
        //   "<ADM> {color}NAME[ID](LEVEL) logged in successfully (IP: x)"
        //   "<ADM>{color} Administrator NAME[ID] has logged out of the admin panel."
        // Only the local player's broadcast updates our level.
        const char* tag = std::strstr(msg, "<ADM>");
        if (!tag) return;
        const char* nm = std::strstr(tag, localName);
        if (!nm) return;

        if (std::strstr(nm, "logged in successfully") ||
            std::strstr(nm, "successfully entered the admin panel"))
        {
                // Pull the admin level out of the "(LEVEL)" group right after
                // the player id "[ID]".
                const char* idClose = std::strchr(nm, ']');
                if (!idClose) return;
                const char* lvOpen = idClose + 1;
                while (*lvOpen == ' ' || *lvOpen == '\t') ++lvOpen;
                if (*lvOpen != '(') return;
                int lv = std::atoi(lvOpen + 1);
                if (lv > 0) SetAdminLevel(lv);
                return;
        }

        if (std::strstr(nm, "has logged out of the admin panel") ||
            std::strstr(nm, "logged out of the admin panel"))
        {
                SetAdminLevel(0);
                return;
        }
}
