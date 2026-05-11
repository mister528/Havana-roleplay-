#pragma once
#include <stdint.h>

// Renders server-sent GameText messages that contain Arabic with proper
// shaping and BiDi reordering. The native GTA SA text engine doesn't shape
// Arabic, so we intercept those messages here and draw them with ImGui.
//
// Usage: CGame::DisplayGameText() forwards the message to TryShow(), which
// returns true if it consumed the message (Arabic detected) so DisplayGameText
// should skip the native rendering path.

class CGameTextOverlay
{
public:
    CGameTextOverlay();
    ~CGameTextOverlay();

    // Returns true if the message was queued (input contained Arabic).
    bool TryShow(const char* utf8, int iTime, int iType);

    // Forcibly clear all queued messages.
    void Clear();

    // Render any active messages. Call from gui.cpp Render chain.
    void Render();

private:
    static const int MAX_ENTRIES = 4;
    struct Entry
    {
        bool   active;
        char   text[512];     // logical-order UTF-8
        int    type;          // SAMP gametext style (0..6)
        float  remaining;     // seconds remaining
        float  total;         // initial duration (for fade)
    };
    Entry m_entries[MAX_ENTRIES];
};

extern CGameTextOverlay* pGameTextOverlay;
