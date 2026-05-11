#include "../main.h"
#include "phoneoverlay.h"
#include "gui.h"
#include "../arabic.h"
#include "../keyboard.h"
#include "../dialog.h"
#include "../game/game.h"
#include "../util/CJavaWrapper.h"
#include "../vendor/imgui/imgui.h"
#include "../vendor/imgui/imgui_internal.h"
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <cmath>
#include <ctime>

extern CGUI* pGUI;
extern CKeyBoard* pKeyBoard;
extern CJavaWrapper* g_pJavaWrapper;
extern CGame* pGame;
extern CDialogWindow* pDialogWindow;
void Phone_SendChatCommand(const char* cmd);

CPhoneOverlay* pPhoneOverlay = nullptr;

static CPhoneOverlay* g_phoneKeyboardOwner = nullptr;

// Modern phone palette (blue/purple gradient, glass cards).
// Restyled v23 — visual update to match SAMP Phone Overlay design spec.
static const ImU32 kP_BgOuter   = IM_COL32( 10,  12,  18, 255);
static const ImU32 kP_BgPanel   = IM_COL32( 18,  22,  31, 248);
static const ImU32 kP_BgInner   = IM_COL32(  8,  10,  15, 255);
static const ImU32 kP_ScreenTop = IM_COL32( 20,  25,  38, 255);
static const ImU32 kP_Card      = IM_COL32( 31,  37,  52, 230);
static const ImU32 kP_CardSoft  = IM_COL32( 39,  47,  66, 210);
static const ImU32 kP_Border    = IM_COL32(255, 255, 255,  32);
static const ImU32 kP_Text      = IM_COL32(245, 247, 255, 255);
static const ImU32 kP_TextDim   = IM_COL32(166, 176, 196, 255);
static const ImU32 kP_TextSub   = IM_COL32(255, 255, 255,  92);
static const ImU32 kP_Accent1   = IM_COL32( 80, 170, 255, 255);
static const ImU32 kP_Accent2   = IM_COL32(160,  95, 255, 255);
static const ImU32 kP_Accent3   = IM_COL32(110, 130, 230, 255);
static const ImU32 kP_Accent4   = IM_COL32( 45,  55, 110, 255);
static const ImU32 kP_Success   = IM_COL32( 72, 211, 139, 255);
static const ImU32 kP_Warning   = IM_COL32(255, 190,  75, 255);
static const ImU32 kP_Danger    = IM_COL32(255,  92, 105, 255);
static const ImU32 kP_Online    = IM_COL32( 72, 211, 139, 255);
static const ImU32 kP_BtnBg     = IM_COL32(255, 255, 255,  20);
static const ImU32 kP_BtnHover  = IM_COL32(255, 255, 255,  35);

static float PhoneClamp(float v, float mn, float mx)
{
    if (v < mn) return mn;
    if (v > mx) return mx;
    return v;
}

static std::string Shape(const char* s)
{
    if (!s) return std::string();
    if (!Arabic::ContainsArabic(s)) return std::string(s);
    return Arabic::Shape(s);
}

static void PhoneKeyboardCallback(const char* text)
{
    if (g_phoneKeyboardOwner) g_phoneKeyboardOwner->OnKeyboardResult(text ? text : "");
}

static bool NextToken(const char*& p, char* out, size_t outSize)
{
    if (!p || !*p || !out || outSize == 0) return false;
    const char* sep = strchr(p, '|');
    size_t n = sep ? (size_t)(sep - p) : strlen(p);
    if (n >= outSize) n = outSize - 1;
    memcpy(out, p, n);
    out[n] = '\0';
    p = sep ? sep + 1 : p + strlen(p);
    return true;
}

CPhoneOverlay::CPhoneOverlay()
    : m_visible(false)
    , m_lastDown(false)
    , m_page(PAGE_HOME)
    , m_keyboardMode(KB_NONE)
    , m_dialogId(0)
    , m_anim(0.0f)
    , m_myId(0)
    , m_bank(0)
    , m_selectedPeer(0)
    , m_chatScrollY(0.0f)
    , m_chatScrollMax(0.0f)
    , m_chatDragging(false)
    , m_chatDragStartY(0.0f)
    , m_chatDragStartScroll(0.0f)
    , m_chatLastMsgCount(0)
    , m_pressStartX(-1.0f)
    , m_pressStartY(-1.0f)
{
}

CPhoneOverlay::~CPhoneOverlay() {}

void CPhoneOverlay::Hide()
{
    m_visible = false;
    m_anim = 0.0f;
    m_keyboardMode = KB_NONE;
    m_lastDown = false;
    g_phoneKeyboardOwner = nullptr;
    if (pKeyBoard && pKeyBoard->IsOpen()) pKeyBoard->Close();
    if (pDialogWindow) pDialogWindow->Clear();
    if (pGame && pGame->FindPlayerPed()) pGame->FindPlayerPed()->TogglePlayerControllable(true);
    if (pGUI) pGUI->ResetTouchState();
}

void CPhoneOverlay::ShowLocal()
{
    if (pDialogWindow) pDialogWindow->Clear();
    bool wasVisible = m_visible;
    m_visible = true;
    m_page = PAGE_HOME;
    m_keyboardMode = KB_NONE;
    m_anim = wasVisible ? m_anim : 0.0f;
    m_lastDown = false;
    m_status.clear();
    g_phoneKeyboardOwner = nullptr;
    if (pKeyBoard && pKeyBoard->IsOpen()) pKeyBoard->Close();
    if (pGame && pGame->FindPlayerPed()) pGame->FindPlayerPed()->TogglePlayerControllable(true);
    if (pGUI) pGUI->ResetTouchState();
    if (!wasVisible) SendCommand("/phone_sync");
}

bool CPhoneOverlay::TryHandleDialog(uint16_t dialogId, uint8_t /*style*/, const char* title, const char* body)
{
    if (!title) return false;
    if (strncmp(title, "[!PHONE_CLOSE]", 14) == 0)
    {
        Hide();
        return true;
    }
    if (strncmp(title, "[!PHONE_OPEN]", 13) != 0) return false;

    m_dialogId = dialogId;
    ShowLocal();
    return true;
}

void CPhoneOverlay::ApplyServerCommand(const char* payload)
{
    if (!payload || !payload[0]) return;

    const char* p = payload;
    char op[32];
    if (!NextToken(p, op, sizeof(op))) return;

    if (!strcmp(op, "OPEN") || !strcmp(op, "DATA"))
    {
        char id[24], bank[32], name[64];
        if (NextToken(p, id, sizeof(id))) m_myId = atoi(id);
        if (NextToken(p, bank, sizeof(bank))) m_bank = atoi(bank);
        if (NextToken(p, name, sizeof(name))) m_myName = name;
        m_visible = true;
    }
    else if (!strcmp(op, "F"))
    {
        char id[24], name[64];
        if (NextToken(p, id, sizeof(id)) && NextToken(p, name, sizeof(name)))
        {
            FriendItem it;
            it.id = atoi(id);
            it.name = name;
            bool found = false;
            for (size_t i = 0; i < m_friends.size(); ++i)
            {
                if (m_friends[i].id == it.id)
                {
                    m_friends[i] = it;
                    found = true;
                    break;
                }
            }
            if (!found) m_friends.push_back(it);
        }
    }
    else if (!strcmp(op, "R"))
    {
        char id[24], name[64];
        if (NextToken(p, id, sizeof(id)) && NextToken(p, name, sizeof(name)))
        {
            FriendItem it;
            it.id = atoi(id);
            it.name = name;
            bool found = false;
            for (size_t i = 0; i < m_requests.size(); ++i)
            {
                if (m_requests[i].id == it.id)
                {
                    m_requests[i] = it;
                    found = true;
                    break;
                }
            }
            if (!found) m_requests.push_back(it);
            if (m_visible && (m_page == PAGE_HOME || m_page == PAGE_MESSAGES))
            {
                m_page = PAGE_MESSAGES;
                m_status = "وصلك طلب صداقة جديد.";
            }
        }
    }
    else if (!strcmp(op, "PAGE"))
    {
        char page[32];
        if (NextToken(p, page, sizeof(page)) && !strcmp(page, "MESSAGES"))
            m_page = PAGE_MESSAGES;
    }
    else if (!strcmp(op, "CLEAR"))
    {
        m_friends.clear();
        m_requests.clear();
        m_messages.clear();
    }
    else if (!strcmp(op, "CLEARMSG"))
    {
        char peer[24];
        if (NextToken(p, peer, sizeof(peer)))
        {
            int id = atoi(peer);
            for (size_t i = 0; i < m_messages.size(); )
            {
                if (m_messages[i].peerId == id) m_messages.erase(m_messages.begin() + i);
                else ++i;
            }
        }
    }
    else if (!strcmp(op, "MSG") || !strcmp(op, "GPS") || !strcmp(op, "MONEY"))
    {
        char peer[24], name[64], dir[8], a[32], b[32], c[32];
        if (!NextToken(p, peer, sizeof(peer))) return;
        if (!NextToken(p, name, sizeof(name))) return;
        if (!NextToken(p, dir, sizeof(dir))) return;
        MessageItem m;
        m.peerId = atoi(peer);
        m.peerName = name;
        m.outgoing = atoi(dir) != 0;
        m.type = 0;
        m.amount = 0;
        m.x = m.y = m.z = 0.0f;
        if (!strcmp(op, "MSG"))
        {
            m.text = p ? p : "";
        }
        else if (!strcmp(op, "GPS"))
        {
            m.type = 1;
            if (NextToken(p, a, sizeof(a))) m.x = (float)atof(a);
            if (NextToken(p, b, sizeof(b))) m.y = (float)atof(b);
            if (NextToken(p, c, sizeof(c))) m.z = (float)atof(c);
            m.text = "موقع GPS";
        }
        else
        {
            m.type = 2;
            if (NextToken(p, a, sizeof(a))) m.amount = atoi(a);
            m.text = "تحويل مالي";
        }
        m_messages.push_back(m);
        if ((int)m_messages.size() > 80) m_messages.erase(m_messages.begin());
    }
    else if (!strcmp(op, "STATUS"))
    {
        m_status = p ? p : "";
    }
    else if (!strcmp(op, "BANK"))
    {
        char bank[32];
        if (NextToken(p, bank, sizeof(bank))) m_bank = atoi(bank);
    }
}

bool CPhoneOverlay::Hit(float px, float py, const Rect& r) const
{
    return px >= r.x && px <= r.x + r.w && py >= r.y && py <= r.y + r.h;
}

void CPhoneOverlay::DrawText(ImDrawList* dl, const char* text, float x, float y, float size, unsigned int color, bool right, float maxW)
{
    if (!dl || !text) return;
    ImFont* font = ImGui::GetFont();
    std::string shaped = Shape(text);
    const char* s = shaped.c_str();
    ImVec2 ts = font ? font->CalcTextSizeA(size, maxW > 0.0f ? maxW : FLT_MAX, 0.0f, s) : ImGui::CalcTextSize(s);
    if (right) x -= ts.x;
    dl->AddText(font, size, ImVec2(x + 1.5f, y + 1.5f), IM_COL32(0, 0, 0, 150), s);
    dl->AddText(font, size, ImVec2(x, y), color, s);
}

bool CPhoneOverlay::Button(const Rect& r, const char* label, unsigned int bg, unsigned int border, unsigned int text, float radius)
{
    ImGuiIO& io = ImGui::GetIO();
    ImVec2 mp = io.MousePos;
    bool hover = Hit(mp.x, mp.y, r);
    // A tap fires only when both the press AND the release happen on
    // this button. This prevents drag-to-scroll gestures (which can
    // start in the chat area and finger-slide over a button before
    // releasing) from accidentally triggering the button. It also
    // matches standard mobile UX (Android/iOS native buttons).
    bool clicked = hover && !io.MouseDown[0] && m_lastDown
                && Hit(m_pressStartX, m_pressStartY, r);
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    ImU32 c = hover ? kP_BtnHover : (ImU32)bg;
    dl->AddRectFilled(ImVec2(r.x + 1, r.y + 3), ImVec2(r.x + r.w + 1, r.y + r.h + 5), IM_COL32(0, 0, 0, 80), radius);
    dl->AddRectFilledMultiColor(ImVec2(r.x, r.y), ImVec2(r.x + r.w, r.y + r.h),
                                c, c, IM_COL32(255, 255, 255, 8), IM_COL32(255, 255, 255, 12));
    dl->AddRect(ImVec2(r.x, r.y), ImVec2(r.x + r.w, r.y + r.h), border ? border : IM_COL32(255,255,255,38), radius, ImDrawCornerFlags_All, 1.1f);
    ImFont* font = ImGui::GetFont();
    if (!font) return clicked;
    std::string shaped = Shape(label);
    float fs = r.h * 0.38f;
    ImVec2 ts = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, shaped.c_str());
    dl->AddText(font, fs, ImVec2(r.x + (r.w - ts.x) * 0.5f, r.y + (r.h - ts.y) * 0.5f - 1.0f), text, shaped.c_str());
    return clicked;
}

void CPhoneOverlay::SendCommand(const char* cmd)
{
    if (cmd && cmd[0]) Phone_SendChatCommand(cmd);
}

void CPhoneOverlay::OpenKeyboard(KeyboardMode mode)
{
    if (!pKeyBoard || mode == KB_NONE) return;
    if (!m_visible) return;
    m_keyboardMode = mode;
    g_phoneKeyboardOwner = this;
    pKeyBoard->Open(PhoneKeyboardCallback, false);
}

void CPhoneOverlay::OnKeyboardResult(const char* text)
{
    char cmd[512];
    const char* v = text ? text : "";
    if (m_keyboardMode == KB_ADD_FRIEND)
    {
        snprintf(cmd, sizeof(cmd), "/phone_add %s", v);
        SendCommand(cmd);
        m_status = "تم إرسال الطلب إذا كان الحساب موجوداً.";
        m_page = PAGE_MESSAGES;
    }
    else if (m_keyboardMode == KB_CHAT_TEXT)
    {
        m_chatDraft = v;
        m_page = PAGE_CHAT;
    }
    else if (m_keyboardMode == KB_MONEY_AMOUNT)
    {
        if (m_selectedPeer > 0 && v[0])
        {
            snprintf(cmd, sizeof(cmd), "/phone_money %d %s", m_selectedPeer, v);
            SendCommand(cmd);
            m_page = PAGE_CHAT;
        }
    }
    m_keyboardMode = KB_NONE;
}

void CPhoneOverlay::SendDraftMessage()
{
    if (m_selectedPeer <= 0 || m_chatDraft.empty()) return;
    char cmd[512];
    snprintf(cmd, sizeof(cmd), "/phone_msg %d %s", m_selectedPeer, m_chatDraft.c_str());
    SendCommand(cmd);
    m_chatDraft.clear();
    m_page = PAGE_CHAT;
}

const char* CPhoneOverlay::PeerName(int id) const
{
    for (size_t i = 0; i < m_friends.size(); ++i)
        if (m_friends[i].id == id) return m_friends[i].name.c_str();
    return "";
}

void CPhoneOverlay::SelectPeer(int id, const char* name)
{
    m_selectedPeer = id;
    m_selectedName = (name && name[0]) ? name : PeerName(id);
    m_chatDraft.clear();
    m_page = PAGE_CHAT;
    m_chatScrollY = 0.0f;
    m_chatScrollMax = 0.0f;
    m_chatDragging = false;
    m_chatLastMsgCount = 0;
    char cmd[64];
    snprintf(cmd, sizeof(cmd), "/phone_openchat %d", id);
    SendCommand(cmd);
}

void CPhoneOverlay::DrawPhoneFrame(float& x, float& y, float& w, float& h, float scale)
{
    ImGuiIO& io = ImGui::GetIO();
    h = io.DisplaySize.y * 0.985f;
    w = h * (410.0f / 760.0f);
    if (w > io.DisplaySize.x * 0.66f)
    {
        w = io.DisplaySize.x * 0.66f;
        h = w * (760.0f / 410.0f);
    }
    if (h > io.DisplaySize.y * 0.985f)
    {
        h = io.DisplaySize.y * 0.985f;
        w = h * (410.0f / 760.0f);
    }
    x = (io.DisplaySize.x - w) * 0.5f;
    float e = 1.0f - powf(1.0f - m_anim, 3.0f);
    float restY = (io.DisplaySize.y - h) * 0.5f;
    y = io.DisplaySize.y + (restY - io.DisplaySize.y) * e;
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    dl->AddRectFilled(ImVec2(0, 0), io.DisplaySize, IM_COL32(0, 0, 0, (int)(160 * e)));

    const float outerRound = 44.0f * scale;
    const float screenRound = 34.0f * scale;
    ImVec2 pa(x, y), pb(x + w, y + h);

    // Multi-layer drop shadow (8 fading rings, like the new design spec).
    for (int i = 8; i >= 1; --i)
    {
        const float spread = static_cast<float>(i) * 3.0f * scale;
        dl->AddRectFilled(ImVec2(pa.x - spread, pa.y - spread),
                          ImVec2(pb.x + spread, pb.y + spread),
                          IM_COL32(0, 0, 0, 8), outerRound + spread);
    }

    // Outer phone shell (rounded, glass-like).
    dl->AddRectFilled(pa, pb, kP_BgOuter, outerRound);
    dl->AddRect(pa, pb, IM_COL32(255, 255, 255, 38), outerRound, 0, 1.2f * scale);

    // Inner screen with vertical gradient (top brighter, bottom darker).
    float pad = 14.0f * scale;
    ImVec2 sa(x + pad, y + pad), sb(x + w - pad, y + h - pad);
    dl->AddRectFilledMultiColor(sa, sb, kP_ScreenTop, kP_ScreenTop, kP_BgInner, kP_BgInner);
    dl->AddRect(sa, sb, IM_COL32(255, 255, 255, 28), screenRound, 0, 1.0f * scale);

    // Faint blue/purple ambient lights inside screen for depth.
    dl->PushClipRect(sa, sb, true);
    dl->AddCircleFilled(ImVec2(sa.x + 42 * scale, sa.y + 92 * scale), 96 * scale, IM_COL32(80, 170, 255, 22), 36);
    dl->AddCircleFilled(ImVec2(sb.x - 34 * scale, sb.y - 130 * scale), 120 * scale, IM_COL32(160, 95, 255, 18), 36);
    dl->AddCircleFilled(ImVec2(sa.x + 36 * scale, sb.y - 58 * scale), 86 * scale, IM_COL32(45, 55, 110, 24), 36);
    dl->PopClipRect();

    // Dynamic Island (rounded pill at top, replaces the old notch look).
    float islandW = 116.0f * scale;
    float islandH = 29.0f * scale;
    ImVec2 islandPos(sa.x + (sb.x - sa.x - islandW) * 0.5f, sa.y + 13.0f * scale);
    dl->AddRectFilled(islandPos,
                      ImVec2(islandPos.x + islandW, islandPos.y + islandH),
                      IM_COL32(4, 5, 8, 245),
                      16.0f * scale);
    dl->AddCircleFilled(ImVec2(islandPos.x + islandW * 0.78f, islandPos.y + islandH * 0.5f),
                        4.0f * scale, IM_COL32(45, 53, 70, 255), 12);

    // Status bar (time on left, signal/battery on right) — drawn on top of shell.
    char timeBuffer[16] = "--:--";
    std::time_t now = std::time(nullptr);
    std::tm* localT = std::localtime(&now);
    if (localT != nullptr)
        std::strftime(timeBuffer, sizeof(timeBuffer), "%H:%M", localT);

    ImVec2 timePos(sa.x + 26.0f * scale, sa.y + 20.0f * scale);
    ImVec2 rightPos(sb.x - 89.0f * scale, sa.y + 20.0f * scale);
    dl->AddText(timePos, kP_Text, timeBuffer);
    dl->AddText(rightPos, kP_TextDim, "5G");
    // Battery icon: outline + green fill + tip.
    ImVec2 batA(rightPos.x + 33.0f * scale, rightPos.y + 2.0f * scale);
    ImVec2 batB(rightPos.x + 66.0f * scale, rightPos.y + 14.0f * scale);
    dl->AddRect(batA, batB, kP_TextDim, 3.0f * scale, 0, 1.1f * scale);
    dl->AddRectFilled(ImVec2(batA.x + 3.0f * scale, batA.y + 3.0f * scale),
                      ImVec2(batB.x - 6.0f * scale, batB.y - 3.0f * scale),
                      kP_Success, 2.0f * scale);
    dl->AddRectFilled(ImVec2(batB.x + 1.0f * scale, batA.y + 4.0f * scale),
                      ImVec2(batB.x + 4.0f * scale, batB.y - 4.0f * scale),
                      kP_TextDim, 2.0f * scale);

    // Home indicator pill at the bottom of the screen (subtle hint bar).
    float homeW = 112.0f * scale;
    float homeH = 4.5f * scale;
    ImVec2 homePos(sa.x + (sb.x - sa.x - homeW) * 0.5f, sb.y - 19.0f * scale);
    dl->AddRectFilled(homePos,
                      ImVec2(homePos.x + homeW, homePos.y + homeH),
                      IM_COL32(255, 255, 255, 105),
                      8.0f * scale);
}

void CPhoneOverlay::DrawTopBar(float x, float y, float w, float scale, const char* title, bool back)
{
    // Top bar pushed down ~24px to clear the new status bar + Dynamic Island.
    float hdrY = y + 60.0f * scale;
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    ImVec2 hba(x + 14.0f * scale, hdrY);
    ImVec2 hbb(x + w - 14.0f * scale, hdrY + 44.0f * scale);
    dl->AddRectFilled(hba, hbb, IM_COL32(255, 255, 255, 14), 22.0f * scale);
    dl->AddRect(hba, hbb, IM_COL32(255, 255, 255, 36), 22.0f * scale);
    dl->AddRectFilledMultiColor(ImVec2(hba.x + 18.0f * scale, hbb.y - 2.0f * scale),
                                ImVec2(hbb.x - 18.0f * scale, hbb.y),
                                IM_COL32(80, 170, 255,0), IM_COL32(80, 170, 255,140),
                                IM_COL32(160, 95, 255,140), IM_COL32(160, 95, 255,0));
    Rect navR = { hba.x + 6.0f * scale, hdrY + 6.0f * scale, 58.0f * scale, 32.0f * scale };
    if (back && Button(navR, "رجوع", kP_BtnBg, IM_COL32(255,255,255,50), kP_Text, 16.0f * scale))
    {
        if (pKeyBoard && pKeyBoard->IsOpen()) pKeyBoard->Close();
        m_keyboardMode = KB_NONE;
        if (m_page == PAGE_CHAT || m_page == PAGE_ADD_FRIEND || m_page == PAGE_SETTINGS) m_page = PAGE_MESSAGES;
        else if (m_page == PAGE_MONEY) m_page = PAGE_CHAT;
        else m_page = PAGE_HOME;
    }
    else if (!back)
    {
        if (Button(navR, "إغلاق", kP_BtnBg, IM_COL32(255,255,255,50), kP_Text, 16.0f * scale))
            Hide();
    }
    float rcx = hbb.x - 22.0f * scale, rcy = hdrY + 22.0f * scale;
    dl->AddCircleFilled(ImVec2(rcx, rcy), 14.0f * scale, IM_COL32(255,255,255,18), 20);
    dl->AddCircle(ImVec2(rcx, rcy), 14.0f * scale, IM_COL32(255,255,255,50), 20, 1.0f * scale);
    dl->AddRectFilled(ImVec2(rcx - 5.0f * scale, rcy - 6.0f * scale), ImVec2(rcx + 5.0f * scale, rcy + 6.0f * scale), kP_Accent1, 3.0f * scale);
    dl->AddCircleFilled(ImVec2(rcx, rcy - 7.0f * scale), 3.0f * scale, kP_Accent2, 10);
    std::string shapedTitle = Shape(title);
    ImVec2 ts = ImGui::CalcTextSize(shapedTitle.c_str());
    dl->AddText(ImVec2(x + (w - ts.x) * 0.5f, hdrY + 6.0f * scale), kP_Text, shapedTitle.c_str());
    const char* sub = "هافانا آر بي";
    std::string shapedSub = Shape(sub);
    ImVec2 ss = ImGui::CalcTextSize(shapedSub.c_str());
    dl->AddText(ImVec2(x + (w - ss.x) * 0.5f, hdrY + 24.0f * scale), kP_TextSub, shapedSub.c_str());
}

void CPhoneOverlay::DrawHome(float x, float y, float w, float h, float scale)
{
    DrawTopBar(x, y, w, scale, "هاتف هافانا", false);
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    float pad = 18.0f * scale;
    float cardX = x + pad;
    float cardY = y + 120.0f * scale;
    float cardW = w - pad * 2.0f;
    float cardH = 128.0f * scale;
    dl->AddRectFilled(ImVec2(cardX + 2, cardY + 4), ImVec2(cardX + cardW + 2, cardY + cardH + 6), IM_COL32(0,0,0,80), 18.0f * scale);
    dl->AddRectFilledMultiColor(ImVec2(cardX, cardY), ImVec2(cardX + cardW, cardY + cardH),
        IM_COL32(35, 52, 98,220), IM_COL32(60, 75, 140,220), IM_COL32(110, 90, 170,220), IM_COL32(45, 55, 110,220));
    dl->PushClipRect(ImVec2(cardX, cardY), ImVec2(cardX + cardW, cardY + cardH), true);
    dl->AddCircleFilled(ImVec2(cardX + 42 * scale, cardY + cardH + 12 * scale), 72 * scale, IM_COL32(80, 170, 255,70), 32);
    dl->AddCircleFilled(ImVec2(cardX + cardW - 55 * scale, cardY - 12 * scale), 84 * scale, IM_COL32(160, 95, 255,50), 32);
    dl->PopClipRect();
    dl->AddRect(ImVec2(cardX, cardY), ImVec2(cardX + cardW, cardY + cardH), IM_COL32(255,255,255,60), 18.0f * scale, 0, 1.2f * scale);
    dl->AddRectFilledMultiColor(ImVec2(cardX + 18 * scale, cardY + cardH - 3 * scale),
                                ImVec2(cardX + cardW - 18 * scale, cardY + cardH - scale),
                                IM_COL32(80, 170, 255,0), IM_COL32(80, 170, 255,210),
                                IM_COL32(160, 95, 255,210), IM_COL32(160, 95, 255,0));
    dl->AddCircleFilled(ImVec2(cardX + 28 * scale, cardY + 28 * scale), 6 * scale, IM_COL32(74,222,128,70), 16);
    dl->AddCircleFilled(ImVec2(cardX + 28 * scale, cardY + 28 * scale), 3 * scale, kP_Online, 16);
    dl->AddCircle(ImVec2(cardX + 28 * scale, cardY + 28 * scale), 10 * scale, IM_COL32(74,222,128,42), 18, 1.2f * scale);
    dl->AddRectFilled(ImVec2(cardX + 18 * scale, cardY + 18 * scale), ImVec2(cardX + 76 * scale, cardY + 42 * scale), IM_COL32(255,255,255,10), 12.0f * scale);
    DrawText(dl, "تطبيق الرسائل", cardX + cardW - 18 * scale, cardY + 18 * scale, 24.0f * scale, kP_Text, true, cardW - 36 * scale);
    DrawText(dl, "أصدقاء · دردشة · GPS · تحويل بنكي", cardX + cardW - 18 * scale, cardY + 55 * scale, 16.0f * scale, IM_COL32(200, 215, 245,235), true, cardW - 36 * scale);
    char idbuf[64]; snprintf(idbuf, sizeof(idbuf), "ID %d", m_myId);
    DrawText(dl, idbuf, cardX + cardW - 18 * scale, cardY + 84 * scale, 15.0f * scale, kP_TextDim, true);

    float gridY = cardY + cardH + 22 * scale;
    Rect msg = { x + 58 * scale, gridY, w - 116 * scale, 86 * scale };
    dl->AddRectFilled(ImVec2(msg.x - 4 * scale, msg.y - 4 * scale), ImVec2(msg.x + msg.w + 4 * scale, msg.y + msg.h + 6 * scale), IM_COL32(80, 170, 255,16), 24.0f * scale);
    if (Button(msg, "فتح الرسائل", IM_COL32(255,255,255,22), IM_COL32(255,255,255,42), kP_Text, 22.0f * scale))
    {
        m_page = PAGE_MESSAGES;
        SendCommand("/phone_sync");
    }
    float infoY = gridY + 106 * scale;
    dl->AddRectFilled(ImVec2(cardX, infoY), ImVec2(cardX + cardW, infoY + 82 * scale), IM_COL32(255,255,255,12), 18.0f * scale);
    dl->AddRect(ImVec2(cardX, infoY), ImVec2(cardX + cardW, infoY + 82 * scale), IM_COL32(255,255,255,24), 18.0f * scale);
    DrawText(dl, "لا يفتح الشات أو الكيبورد عند فتح الهاتف", cardX + cardW - 16 * scale, infoY + 18 * scale, 16.0f * scale, kP_TextDim, true, cardW - 32 * scale);
    DrawText(dl, "الكتابة فقط من زر كتابة رسالة", cardX + cardW - 16 * scale, infoY + 46 * scale, 15.0f * scale, kP_TextSub, true, cardW - 32 * scale);
}

void CPhoneOverlay::DrawMessages(float x, float y, float w, float h, float scale)
{
    DrawTopBar(x, y, w, scale, "الرسائل الخاصة", true);
    float top = y + 118 * scale;
    Rect add = { x + w - 142 * scale, top, 124 * scale, 40 * scale };
    Rect set = { x + 18 * scale, top, 108 * scale, 40 * scale };
    if (Button(add, "إضافة صديق", IM_COL32(255,255,255,20), IM_COL32(130, 195, 255,90), kP_Text, 16.0f * scale))
        m_page = PAGE_ADD_FRIEND;
    if (Button(set, "إعدادات", IM_COL32(255,255,255,20), IM_COL32(255,255,255,42), kP_Text, 16.0f * scale))
        m_page = PAGE_SETTINGS;

    ImDrawList* dl = ImGui::GetOverlayDrawList();
    float sx = x + 18 * scale;
    float sy = y + 174 * scale;
    float sw = w - 36 * scale;
    if (!m_status.empty())
        DrawText(dl, m_status.c_str(), x + w - 24 * scale, y + h - 64 * scale, 14.0f * scale, IM_COL32(200, 215, 245,235), true, sw);

    DrawText(dl, "طلبات الصداقة", x + w - 24 * scale, sy, 18.0f * scale, kP_Text, true);
    sy += 28 * scale;
    if (m_requests.empty())
    {
        dl->AddRectFilled(ImVec2(sx, sy), ImVec2(sx + sw, sy + 42 * scale), IM_COL32(255, 255, 255, 14), 14.0f * scale);
        dl->AddRect(ImVec2(sx, sy), ImVec2(sx + sw, sy + 42 * scale), IM_COL32(255, 255, 255, 24), 14.0f * scale);
        DrawText(dl, "لا توجد طلبات حالياً", sx + sw - 14 * scale, sy + 11 * scale, 15.0f * scale, kP_TextDim, true);
        sy += 54 * scale;
    }
    else
    {
        for (size_t i = 0; i < m_requests.size() && i < 3; ++i)
        {
            dl->AddRectFilled(ImVec2(sx, sy), ImVec2(sx + sw, sy + 58 * scale), IM_COL32(255, 255, 255, 18), 16.0f * scale);
            dl->AddRect(ImVec2(sx, sy), ImVec2(sx + sw, sy + 58 * scale), IM_COL32(255, 255, 255, 28), 16.0f * scale);
            char txt[96];
            snprintf(txt, sizeof(txt), "%s أرسل لك طلب صداقة", m_requests[i].name.c_str());
            DrawText(dl, txt, sx + sw - 14 * scale, sy + 9 * scale, 15.0f * scale, IM_COL32(245, 250, 255, 255), true, sw - 150 * scale);
            Rect accept = { sx + 84 * scale, sy + 13 * scale, 70 * scale, 31 * scale };
            Rect reject = { sx + 8 * scale, sy + 13 * scale, 66 * scale, 31 * scale };
            if (Button(accept, "قبول", IM_COL32(74,222,128,60), IM_COL32(74,222,128,120), kP_Text, 12.0f * scale))
            {
                char cmd[64]; snprintf(cmd, sizeof(cmd), "/phone_accept %d", m_requests[i].id); SendCommand(cmd);
            }
            if (Button(reject, "رفض", IM_COL32(160, 95, 255,55), IM_COL32(160, 95, 255,120), kP_Text, 12.0f * scale))
            {
                char cmd[64]; snprintf(cmd, sizeof(cmd), "/phone_reject %d", m_requests[i].id); SendCommand(cmd);
            }
            sy += 68 * scale;
        }
    }

    DrawText(dl, "الأصدقاء والرسائل", x + w - 24 * scale, sy, 18.0f * scale, kP_Text, true);
    sy += 34 * scale;
    if (m_friends.empty())
    {
        dl->AddRectFilled(ImVec2(sx, sy), ImVec2(sx + sw, sy + 72 * scale), IM_COL32(255, 255, 255, 14), 18.0f * scale);
        DrawText(dl, "أضف صديق باستخدام ID حتى تبدأ محادثة.", sx + sw - 18 * scale, sy + 22 * scale, 16.0f * scale, kP_TextDim, true, sw - 36 * scale);
    }
    else
    {
        float bottom = y + h - 95 * scale;
        for (size_t i = 0; i < m_friends.size() && sy + 58 * scale < bottom; ++i)
        {
            Rect row = { sx, sy, sw, 56 * scale };
            bool hover = Hit(ImGui::GetIO().MousePos.x, ImGui::GetIO().MousePos.y, row);
            ImU32 rowCol = hover ? IM_COL32(255, 255, 255, 28) : IM_COL32(255, 255, 255, 14);
            dl->AddRectFilled(ImVec2(row.x, row.y), ImVec2(row.x + row.w, row.y + row.h), rowCol, 17.0f * scale);
            dl->AddRect(ImVec2(row.x, row.y), ImVec2(row.x + row.w, row.y + row.h), IM_COL32(255,255,255,24), 17.0f * scale);
            dl->AddCircleFilled(ImVec2(row.x + row.w - 31 * scale, row.y + row.h * 0.5f), 18 * scale, kP_Online, 24);
            DrawText(dl, m_friends[i].name.c_str(), row.x + row.w - 60 * scale, row.y + 9 * scale, 18.0f * scale, IM_COL32(255, 255, 255, 255), true, row.w - 85 * scale);
            char idbuf[40]; snprintf(idbuf, sizeof(idbuf), "ID %d", m_friends[i].id);
            DrawText(dl, idbuf, row.x + row.w - 60 * scale, row.y + 31 * scale, 13.0f * scale, IM_COL32(155, 185, 220, 230), true);
            if (Button({ row.x + 12 * scale, row.y + 11 * scale, 72 * scale, 34 * scale }, "فتح", IM_COL32(255,255,255,18), IM_COL32(130, 195, 255,90), kP_Text, 14.0f * scale))
                SelectPeer(m_friends[i].id, m_friends[i].name.c_str());
            sy += 65 * scale;
        }
    }
}

void CPhoneOverlay::DrawAddFriend(float x, float y, float w, float h, float scale)
{
    DrawTopBar(x, y, w, scale, "إضافة صديق", true);
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    float sx = x + 24 * scale;
    float sy = y + 142 * scale;
    float sw = w - 48 * scale;
    dl->AddRectFilledMultiColor(ImVec2(sx, sy), ImVec2(sx + sw, sy + 176 * scale),
        IM_COL32(35, 52, 98,200), IM_COL32(60, 75, 140,190), IM_COL32(110, 90, 170,175), IM_COL32(45, 55, 110,195));
    dl->AddRect(ImVec2(sx, sy), ImVec2(sx + sw, sy + 176 * scale), IM_COL32(255,255,255,55), 22.0f * scale);
    DrawText(dl, "ضع ID أو اسم الحساب الذي تريد مراسلته.", sx + sw - 18 * scale, sy + 28 * scale, 19.0f * scale, kP_Text, true, sw - 36 * scale);
    DrawText(dl, "الكيبورد يفتح فقط بعد الضغط على الزر.", sx + sw - 18 * scale, sy + 65 * scale, 15.0f * scale, IM_COL32(200, 215, 245,235), true, sw - 36 * scale);
    if (Button({ sx + 34 * scale, sy + 116 * scale, sw - 68 * scale, 44 * scale }, "كتابة ID أو الاسم وإرسال", IM_COL32(255,255,255,22), IM_COL32(130, 195, 255,100), kP_Text, 18.0f * scale))
        OpenKeyboard(KB_ADD_FRIEND);
}

void CPhoneOverlay::DrawSettings(float x, float y, float w, float h, float scale)
{
    DrawTopBar(x, y, w, scale, "إعدادات الهاتف", true);
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    float sx = x + 24 * scale;
    float sy = y + 142 * scale;
    float sw = w - 48 * scale;
    dl->AddRectFilledMultiColor(ImVec2(sx, sy), ImVec2(sx + sw, sy + 190 * scale),
        IM_COL32(35, 52, 98,200), IM_COL32(60, 75, 140,190), IM_COL32(110, 90, 170,175), IM_COL32(45, 55, 110,195));
    dl->AddRect(ImVec2(sx, sy), ImVec2(sx + sw, sy + 190 * scale), IM_COL32(255,255,255,55), 24.0f * scale);
    DrawText(dl, "ID الخاص بك", sx + sw - 22 * scale, sy + 26 * scale, 20.0f * scale, kP_Text, true);
    char idbuf[64];
    snprintf(idbuf, sizeof(idbuf), "%d", m_myId);
    ImVec2 idSize = ImGui::CalcTextSize(idbuf);
    dl->AddText(ImVec2(sx + (sw - idSize.x) * 0.5f, sy + 72 * scale), IM_COL32(200, 215, 245,255), idbuf);
    if (Button({ sx + 42 * scale, sy + 130 * scale, sw - 84 * scale, 42 * scale }, "نسخ ID", IM_COL32(255,255,255,22), IM_COL32(130, 195, 255,100), kP_Text, 17.0f * scale))
    {
        if (g_pJavaWrapper) g_pJavaWrapper->SetClipboardString(idbuf);
        m_status = "تم نسخ ID.";
        if (pGUI) pGUI->ResetTouchState();
    }
}

void CPhoneOverlay::DrawChat(float x, float y, float w, float h, float scale)
{
    char title[96];
    snprintf(title, sizeof(title), "محادثة %s", m_selectedName.empty() ? "صديق" : m_selectedName.c_str());
    DrawTopBar(x, y, w, scale, title, true);
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    float sx = x + 18 * scale;
    float sy = y + 120 * scale;
    float sw = w - 36 * scale;
    float bottom = y + h - 150 * scale;
    dl->AddRectFilled(ImVec2(sx, sy), ImVec2(sx + sw, bottom), IM_COL32(255, 255, 255, 10), 18.0f * scale);
    dl->AddRect(ImVec2(sx, sy), ImVec2(sx + sw, bottom), IM_COL32(255, 255, 255, 22), 18.0f * scale);
    dl->PushClipRect(ImVec2(sx, sy), ImVec2(sx + sw, bottom), true);

    std::vector<const MessageItem*> rows;
    for (size_t i = 0; i < m_messages.size(); ++i)
        if (m_messages[i].peerId == m_selectedPeer) rows.push_back(&m_messages[i]);

    // ---------------------------------------------------------------------
    // Scrollable conversation log.
    //
    // Messages render newest-at-bottom, growing upward. We support drag
    // (touch) and mouse-wheel scrolling so the user can review older
    // messages that don't fit in the visible window.
    //
    // m_chatScrollY is in pixels and represents how far the entire
    // message stack has been pushed DOWN from the bottom-anchored
    // default. 0 = newest visible at bottom; larger values reveal older
    // messages from above.
    // ---------------------------------------------------------------------

    // Pre-compute total content height so we can clamp the scroll range.
    float totalH = 18.0f * scale;
    for (size_t i = 0; i < rows.size(); ++i)
    {
        const MessageItem* m = rows[i];
        float bh = (m->type == 0 ? 54.0f : 82.0f) * scale;
        totalH += bh + 10.0f * scale;
    }
    float viewH = bottom - sy;
    m_chatScrollMax = (totalH > viewH) ? (totalH - viewH) : 0.0f;

    // Auto-stick to bottom when a new message arrives AND the user was
    // already at (or very close to) the bottom. If the user has
    // intentionally scrolled up, preserve their view position by
    // shifting the scroll to match the height of the newly appended
    // messages — that way the older messages they were reading don't
    // jump around when peers are typing.
    if ((int)rows.size() != m_chatLastMsgCount)
    {
        if (m_chatScrollY < 4.0f)
        {
            m_chatScrollY = 0.0f;
        }
        else if ((int)rows.size() > m_chatLastMsgCount)
        {
            for (int i = m_chatLastMsgCount; i < (int)rows.size(); ++i)
            {
                float bh = (rows[i]->type == 0 ? 54.0f : 82.0f) * scale;
                m_chatScrollY += bh + 10.0f * scale;
            }
        }
        m_chatLastMsgCount = (int)rows.size();
    }

    // Drag-to-scroll. Engages only when the press starts inside the
    // chat content area; ends when the finger / button is released.
    ImVec2 mp2 = ImGui::GetIO().MousePos;
    bool inArea = (mp2.x >= sx && mp2.x <= sx + sw && mp2.y >= sy && mp2.y <= bottom);
    if (ImGui::GetIO().MouseDown[0] && !m_lastDown && inArea)
    {
        m_chatDragging = true;
        m_chatDragStartY = mp2.y;
        m_chatDragStartScroll = m_chatScrollY;
    }
    if (m_chatDragging)
    {
        if (ImGui::GetIO().MouseDown[0])
            m_chatScrollY = m_chatDragStartScroll + (mp2.y - m_chatDragStartY);
        else
            m_chatDragging = false;
    }

    // Mouse wheel for desktop / external pointers.
    if (inArea && ImGui::GetIO().MouseWheel != 0.0f)
        m_chatScrollY -= ImGui::GetIO().MouseWheel * 60.0f * scale;

    // Clamp scroll to valid range.
    if (m_chatScrollY < 0.0f) m_chatScrollY = 0.0f;
    if (m_chatScrollY > m_chatScrollMax) m_chatScrollY = m_chatScrollMax;

    float cy = bottom - 18 * scale + m_chatScrollY;
    for (int i = (int)rows.size() - 1; i >= 0; --i)
    {
        const MessageItem* m = rows[i];
        float bw = sw * (m->type == 0 ? 0.72f : 0.78f);
        float bh = (m->type == 0 ? 54.0f : 82.0f) * scale;
        float bx = m->outgoing ? (sx + sw - bw - 13 * scale) : (sx + 13 * scale);
        cy -= bh;
        // Stop iterating once we've gone above the visible top: every
        // older message will be even higher and clipped too.
        if (cy + bh < sy) break;
        // Skip messages below the visible area (only relevant when the
        // user has scrolled away from the bottom).
        if (cy > bottom)
        {
            cy -= 10 * scale;
            continue;
        }
        ImU32 bg1 = m->outgoing ? IM_COL32(80, 170, 255, 92) : IM_COL32(255, 255, 255, 22);
        ImU32 bg2 = m->outgoing ? IM_COL32(160, 95, 255, 76) : IM_COL32(255, 255, 255, 18);
        dl->AddRectFilledMultiColor(ImVec2(bx, cy), ImVec2(bx + bw, cy + bh), bg1, bg2, IM_COL32(45, 55, 110,72), bg1);
        dl->AddRect(ImVec2(bx, cy), ImVec2(bx + bw, cy + bh), IM_COL32(255,255,255,34), 17.0f * scale);
        if (m->type == 0)
        {
            DrawText(dl, m->text.c_str(), bx + bw - 14 * scale, cy + 13 * scale, 16.0f * scale, IM_COL32(255, 255, 255, 255), true, bw - 28 * scale);
        }
        else if (m->type == 1)
        {
            DrawText(dl, "رسالة GPS", bx + bw - 14 * scale, cy + 10 * scale, 17.0f * scale, IM_COL32(255, 255, 255, 255), true);
            DrawText(dl, "اضغط لتحديد موقع النقطة الحمراء", bx + bw - 14 * scale, cy + 34 * scale, 14.0f * scale, IM_COL32(220, 235, 255, 240), true, bw - 28 * scale);
            Rect r = { bx + 12 * scale, cy + 47 * scale, 112 * scale, 27 * scale };
            if (Button(r, "تحديد", IM_COL32(160, 95, 255,55), IM_COL32(160, 95, 255,130), kP_Text, 12.0f * scale))
            {
                char cmd[128];
                snprintf(cmd, sizeof(cmd), "/phone_setgps %.2f %.2f %.2f", m->x, m->y, m->z);
                SendCommand(cmd);
            }
        }
        else
        {
            char amt[96];
            snprintf(amt, sizeof(amt), "تحويل مالي: %d$", m->amount);
            DrawText(dl, amt, bx + bw - 14 * scale, cy + 15 * scale, 18.0f * scale, IM_COL32(255, 255, 255, 255), true);
            DrawText(dl, m->outgoing ? "تم إرسال المبلغ من البنك." : "وصل المبلغ إلى حسابك البنكي.", bx + bw - 14 * scale, cy + 43 * scale, 14.0f * scale, IM_COL32(225, 240, 255, 240), true, bw - 28 * scale);
        }
        cy -= 10 * scale;
    }
    if (rows.empty())
        DrawText(dl, "لا توجد رسائل بعد. اكتب من الصندوق بالأسفل.", sx + sw - 18 * scale, sy + 32 * scale, 15.0f * scale, kP_TextDim, true, sw - 36 * scale);

    // Thin scrollbar on the LEFT edge to give visual feedback that the
    // list is scrollable. Only shown when there is more content than
    // fits in the viewport.
    if (m_chatScrollMax > 0.5f)
    {
        float trackX = sx + 4 * scale;
        float trackW = 3.0f * scale;
        float trackH = viewH - 12 * scale;
        float trackY = sy + 6 * scale;
        dl->AddRectFilled(ImVec2(trackX, trackY), ImVec2(trackX + trackW, trackY + trackH), IM_COL32(255, 255, 255, 22), trackW * 0.5f);
        float thumbH = trackH * (viewH / totalH);
        if (thumbH < 18.0f * scale) thumbH = 18.0f * scale;
        // scrollY=0 -> thumb at bottom; scrollY=max -> thumb at top.
        float t = m_chatScrollMax > 0.0f ? (m_chatScrollY / m_chatScrollMax) : 0.0f;
        float thumbY = trackY + (trackH - thumbH) * (1.0f - t);
        dl->AddRectFilled(ImVec2(trackX, thumbY), ImVec2(trackX + trackW, thumbY + thumbH), IM_COL32(80, 170, 255, 200), trackW * 0.5f);
    }

    dl->PopClipRect();

    float by = y + h - 132 * scale;
    Rect input = { sx, by, sw - 74 * scale, 44 * scale };
    bool hasDraft = !m_chatDraft.empty();
    dl->AddRectFilled(ImVec2(input.x + 1, input.y + 3), ImVec2(input.x + input.w + 1, input.y + input.h + 5), IM_COL32(0,0,0,85), 22.0f * scale);
    dl->AddRectFilled(ImVec2(input.x, input.y), ImVec2(input.x + input.w, input.y + input.h), IM_COL32(255,255,255,22), 22.0f * scale);
    dl->AddRect(ImVec2(input.x, input.y), ImVec2(input.x + input.w, input.y + input.h), IM_COL32(255,255,255,46), 22.0f * scale);
    DrawText(dl, hasDraft ? m_chatDraft.c_str() : "اكتب رسالة...", input.x + input.w - 18 * scale, input.y + 12 * scale, 15.0f * scale, hasDraft ? kP_Text : kP_TextDim, true, input.w - 36 * scale);
    ImVec2 mp = ImGui::GetIO().MousePos;
    // Require both press AND release inside the input box. Without this
    // check a drag-scroll gesture in the chat list that finishes over
    // the input box would falsely pop the keyboard open.
    if (Hit(mp.x, mp.y, input) && !ImGui::GetIO().MouseDown[0] && m_lastDown
        && Hit(m_pressStartX, m_pressStartY, input))
        OpenKeyboard(KB_CHAT_TEXT);
    if (Button({ sx + sw - 66 * scale, by, 66 * scale, 44 * scale }, "إرسال", IM_COL32(80, 170, 255,68), IM_COL32(130, 195, 255,130), kP_Text, 17.0f * scale))
        SendDraftMessage();
    if (Button({ sx, by + 54 * scale, sw * 0.48f, 38 * scale }, "GPS", IM_COL32(160, 95, 255,50), IM_COL32(160, 95, 255,120), kP_Text, 17.0f * scale))
    {
        char cmd[64]; snprintf(cmd, sizeof(cmd), "/phone_gps %d", m_selectedPeer); SendCommand(cmd);
    }
    if (Button({ sx + sw * 0.52f, by + 54 * scale, sw * 0.48f, 38 * scale }, "المال", IM_COL32(74,222,128,50), IM_COL32(74,222,128,120), kP_Text, 17.0f * scale))
        m_page = PAGE_MONEY;
}

void CPhoneOverlay::DrawMoney(float x, float y, float w, float h, float scale)
{
    DrawTopBar(x, y, w, scale, "إرسال المال", true);
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    float sx = x + 24 * scale;
    float sy = y + 142 * scale;
    float sw = w - 48 * scale;
    dl->AddRectFilledMultiColor(ImVec2(sx, sy), ImVec2(sx + sw, sy + 205 * scale),
        IM_COL32(35, 52, 98,200), IM_COL32(60, 75, 140,190), IM_COL32(110, 90, 170,175), IM_COL32(45, 55, 110,195));
    dl->AddRect(ImVec2(sx, sy), ImVec2(sx + sw, sy + 205 * scale), IM_COL32(255,255,255,55), 24.0f * scale);
    char bal[96];
    snprintf(bal, sizeof(bal), "رصيد البنك: %d$", m_bank);
    DrawText(dl, bal, sx + sw - 22 * scale, sy + 27 * scale, 19.0f * scale, IM_COL32(200, 215, 245,255), true);
    DrawText(dl, "الكيبورد يفتح فقط بعد الضغط على زر المبلغ.", sx + sw - 22 * scale, sy + 68 * scale, 15.0f * scale, kP_TextDim, true, sw - 44 * scale);
    DrawText(dl, "يتم الخصم من البنك فقط إذا الرصيد كافي.", sx + sw - 22 * scale, sy + 96 * scale, 15.0f * scale, kP_TextSub, true, sw - 44 * scale);
    if (Button({ sx + 40 * scale, sy + 142 * scale, sw - 80 * scale, 42 * scale }, "كتابة المبلغ وإرساله", IM_COL32(255,255,255,22), IM_COL32(74,222,128,120), kP_Text, 18.0f * scale))
        OpenKeyboard(KB_MONEY_AMOUNT);
}

void CPhoneOverlay::Render()
{
    if (!m_visible || !pGUI) return;
    ImGuiIO& io = ImGui::GetIO();
    if (pKeyBoard && pKeyBoard->IsOpen())
    {
        if (m_keyboardMode == KB_NONE)
        {
            pKeyBoard->Close();
            if (pGUI) pGUI->ResetTouchState();
            return;
        }
        io.WantCaptureMouse = true;
        io.WantCaptureKeyboard = true;
        m_lastDown = io.MouseDown[0];
        return;
    }

    m_anim += io.DeltaTime * 8.0f;
    if (m_anim > 1.0f) m_anim = 1.0f;

    // Latch the position where the current finger / mouse press began.
    // Both Button() and the inline input-box tap check require press
    // and release to happen on the same widget; the chat scroll handler
    // also reads these to discriminate a drag from a stationary tap.
    if (io.MouseDown[0] && !m_lastDown)
    {
        m_pressStartX = io.MousePos.x;
        m_pressStartY = io.MousePos.y;
    }

    float scale = io.DisplaySize.y / 768.0f;
    if (scale < 0.65f) scale = 0.65f;
    float x, y, w, h;
    DrawPhoneFrame(x, y, w, h, scale);
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    dl->PushClipRect(ImVec2(x, y), ImVec2(x + w, y + h), true);
    switch (m_page)
    {
        case PAGE_HOME: DrawHome(x, y, w, h, scale); break;
        case PAGE_MESSAGES: DrawMessages(x, y, w, h, scale); break;
        case PAGE_ADD_FRIEND: DrawAddFriend(x, y, w, h, scale); break;
        case PAGE_SETTINGS: DrawSettings(x, y, w, h, scale); break;
        case PAGE_CHAT: DrawChat(x, y, w, h, scale); break;
        case PAGE_MONEY: DrawMoney(x, y, w, h, scale); break;
    }
    dl->PopClipRect();

    io.WantCaptureMouse = true;
    io.WantCaptureKeyboard = true;
    m_lastDown = io.MouseDown[0];
}
