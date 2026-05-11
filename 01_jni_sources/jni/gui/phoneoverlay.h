#pragma once

#include <stdint.h>
#include <string>
#include <vector>

struct ImDrawList;

class CPhoneOverlay
{
public:
    CPhoneOverlay();
    ~CPhoneOverlay();

    bool TryHandleDialog(uint16_t dialogId, uint8_t style, const char* title, const char* body);
    void ApplyServerCommand(const char* payload);
    void Render();
    void Hide();
    void ShowLocal();
    bool IsVisible() const { return m_visible; }
    bool IsKeyboardActive() const { return m_keyboardMode != KB_NONE; }
    void OnKeyboardResult(const char* text);

private:
    enum Page
    {
        PAGE_HOME = 0,
        PAGE_MESSAGES,
        PAGE_ADD_FRIEND,
        PAGE_SETTINGS,
        PAGE_CHAT,
        PAGE_MONEY
    };

    enum KeyboardMode
    {
        KB_NONE = 0,
        KB_ADD_FRIEND,
        KB_CHAT_TEXT,
        KB_MONEY_AMOUNT
    };

    struct FriendItem
    {
        int id;
        std::string name;
    };

    struct MessageItem
    {
        int peerId;
        std::string peerName;
        bool outgoing;
        int type;
        int amount;
        float x;
        float y;
        float z;
        std::string text;
    };

    struct Rect
    {
        float x;
        float y;
        float w;
        float h;
    };

    bool Hit(float px, float py, const Rect& r) const;
    bool Button(const Rect& r, const char* label, unsigned int bg, unsigned int border, unsigned int text, float radius = 14.0f);
    void DrawText(ImDrawList* dl, const char* text, float x, float y, float size, unsigned int color, bool right = false, float maxW = 0.0f);
    void DrawTopBar(float x, float y, float w, float scale, const char* title, bool back);
    void DrawPhoneFrame(float& x, float& y, float& w, float& h, float scale);
    void DrawHome(float x, float y, float w, float h, float scale);
    void DrawMessages(float x, float y, float w, float h, float scale);
    void DrawAddFriend(float x, float y, float w, float h, float scale);
    void DrawSettings(float x, float y, float w, float h, float scale);
    void DrawChat(float x, float y, float w, float h, float scale);
    void DrawMoney(float x, float y, float w, float h, float scale);
    void OpenKeyboard(KeyboardMode mode);
    void SendCommand(const char* cmd);
    void SendDraftMessage();
    void SelectPeer(int id, const char* name);
    const char* PeerName(int id) const;

    bool m_visible;
    bool m_lastDown;
    Page m_page;
    KeyboardMode m_keyboardMode;
    uint16_t m_dialogId;
    float m_anim;
    int m_myId;
    int m_bank;
    int m_selectedPeer;
    std::string m_myName;
    std::string m_selectedName;
    std::string m_status;
    std::string m_chatDraft;
    std::vector<FriendItem> m_friends;
    std::vector<FriendItem> m_requests;
    std::vector<MessageItem> m_messages;
};

extern CPhoneOverlay* pPhoneOverlay;
