#pragma once

#include "imgui/imgui.h"

#include <string>

namespace CmdSuggest
{
        // Render the suggestion strip directly above `keyboardPos.y`. Safe to
        // call every frame; renders nothing when the input doesn't start with
        // '/' or no commands match.
        void Render(const ImVec2& keyboardPos,
                    const ImVec2& keyboardSize,
                    float          fontSize,
                    const std::string& cp1251Input);

        // Handle a touch event in the suggestion strip area. Returns true if
        // the touch hit a suggestion chip; on hit, updates `cp1251Input`,
        // `utf8Input` and `inputOffset` so the keyboard reflects the new text.
        // The caller should NOT process the event further when this returns
        // true.
        bool HandleTouch(int type, int x, int y,
                         const ImVec2& keyboardPos,
                         const ImVec2& keyboardSize,
                         float          fontSize,
                         std::string&  cp1251Input,
                         char*         utf8Input,
                         int&          inputOffset);

        // Set/get the local player's admin level. Commands gated above this
        // level are filtered out of the suggestion strip. Default is 0.
        void SetAdminLevel(int level);
        int  GetAdminLevel();

        // Snoop an incoming server message (the same string passed to
        // CChatWindow::AddClientMessage) and update the admin level when the
        // gamemode broadcasts an alogin / alogout for the local player.
        void OnIncomingClientMessage(const char* msg, const char* localName);
}
