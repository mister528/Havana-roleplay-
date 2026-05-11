#include "../main.h"
#include "../game/game.h"
#include "flightjoboverlay.h"
#include "../arabic.h"
#include "../vendor/imgui/imgui.h"
#include "../vendor/imgui/imgui_internal.h"

#include <stdlib.h>
#include <stdio.h>
#include <string>

CFlightJobOverlay* pFlightJobOverlay = nullptr;
extern CGame* pGame;
extern void FlightJob_SendDialogResponse(uint16_t id, uint8_t btn, uint16_t listitem, char* input);

static float FJClamp(float v, float lo, float hi)
{
    if (v < lo) return lo;
    if (v > hi) return hi;
    return v;
}

static float FJEase(float v)
{
    v = FJClamp(v, 0.0f, 1.0f);
    return 1.0f - (1.0f - v) * (1.0f - v) * (1.0f - v);
}

static unsigned int C(int r, int g, int b, int a)
{
    return IM_COL32(r, g, b, a);
}

static std::string A(const char* s)
{
    return Arabic::Shape(s);
}

CFlightJobOverlay::CFlightJobOverlay()
    : m_visible(false)
    , m_lastDown(false)
    , m_page(PAGE_HOME)
    , m_dialogId(0)
    , m_anim(0.0f)
    , m_level(1)
    , m_boxes(0)
    , m_reward(10000)
    , m_toNext(3)
{
}

CFlightJobOverlay::~CFlightJobOverlay() {}

bool CFlightJobOverlay::TryHandleDialog(uint16_t dialogId, uint8_t style, const char* title, const char* body)
{
    (void)style;
    if (!title || strcmp(title, "~FLIGHTJOB~") != 0) return false;
    m_dialogId = dialogId;
    ParsePayload(body);
    m_visible = true;
    m_lastDown = false;
    m_page = PAGE_HOME;
    m_anim = 0.0f;
    PlaySound(1052);
    return true;
}

void CFlightJobOverlay::ParsePayload(const char* body)
{
    if (!body) return;
    int lvl = 1, boxes = 0, reward = 10000, toNext = 3;
    sscanf(body, "%d|%d|%d|%d", &lvl, &boxes, &reward, &toNext);
    if (lvl < 1) lvl = 1;
    if (lvl > 50) lvl = 50;
    if (boxes < 0) boxes = 0;
    if (reward < 10000) reward = 10000;
    if (toNext < 0) toNext = 0;
    m_level = lvl;
    m_boxes = boxes;
    m_reward = reward;
    m_toNext = toNext;
}

bool CFlightJobOverlay::Hit(float x, float y, const Rect& r) const
{
    return x >= r.x1 && x <= r.x2 && y >= r.y1 && y <= r.y2;
}

void CFlightJobOverlay::PlaySound(int soundId)
{
    if (!pGame) return;
    CPlayerPed* ped = pGame->FindPlayerPed();
    if (!ped) return;
    MATRIX4X4 mat;
    ped->GetMatrix(&mat);
    pGame->PlaySound(soundId, mat.pos.X, mat.pos.Y, mat.pos.Z);
}

void CFlightJobOverlay::SendResponse(uint8_t button, uint16_t listitem)
{
    char empty[] = "";
    if (m_dialogId != 0xFFFF) FlightJob_SendDialogResponse(m_dialogId, button, listitem, empty);
    m_visible = false;
    PlaySound(button ? 1053 : 1054);
}

bool CFlightJobOverlay::Button(const Rect& r, const char* text, unsigned int bg, unsigned int border, unsigned int textColor)
{
    ImGuiIO& io = ImGui::GetIO();
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    bool hover = Hit(io.MousePos.x, io.MousePos.y, r);
    bool clicked = hover && io.MouseDown[0] && !m_lastDown;
    unsigned int fill = bg;
    if (hover) fill = IM_COL32((bg >> IM_COL32_R_SHIFT) & 255, (bg >> IM_COL32_G_SHIFT) & 255, (bg >> IM_COL32_B_SHIFT) & 255, 255);
    dl->AddRectFilled(ImVec2(r.x1, r.y1), ImVec2(r.x2, r.y2), fill, 18.0f);
    dl->AddRect(ImVec2(r.x1, r.y1), ImVec2(r.x2, r.y2), border, 18.0f, 0, 2.0f);
    std::string shaped = A(text);
    ImVec2 ts = ImGui::CalcTextSize(shaped.c_str());
    dl->AddText(ImVec2((r.x1 + r.x2 - ts.x) * 0.5f, (r.y1 + r.y2 - ts.y) * 0.5f), textColor, shaped.c_str());
    return clicked;
}

void CFlightJobOverlay::DrawProgressBar(float x, float y, float w, float h, float value)
{
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    value = FJClamp(value, 0.0f, 1.0f);
    dl->AddRectFilled(ImVec2(x, y), ImVec2(x + w, y + h), C(15, 24, 34, 235), h * 0.5f);
    dl->AddRectFilled(ImVec2(x, y), ImVec2(x + w * value, y + h), C(47, 174, 255, 245), h * 0.5f);
    dl->AddRect(ImVec2(x, y), ImVec2(x + w, y + h), C(225, 245, 255, 90), h * 0.5f, 0, 1.6f);
}

void CFlightJobOverlay::DrawHome(float sw, float sh)
{
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    float e = FJEase(m_anim);
    dl->AddRectFilled(ImVec2(0, 0), ImVec2(sw, sh), C(0, 7, 15, (int)(205 * e)));

    float w = sw * 0.60f;
    float h = sh * 0.66f;
    if (w > 900.0f) w = 900.0f;
    if (h > 480.0f) h = 480.0f;
    float x = (sw - w) * 0.5f;
    float y = (sh - h) * 0.5f + (1.0f - e) * 46.0f;

    dl->AddRectFilled(ImVec2(x + 14.0f, y + 18.0f), ImVec2(x + w + 14.0f, y + h + 18.0f), C(0, 0, 0, (int)(115 * e)), 32.0f);
    dl->AddRectFilled(ImVec2(x, y), ImVec2(x + w, y + h), C(5, 14, 25, (int)(250 * e)), 32.0f);
    dl->AddRectFilled(ImVec2(x, y), ImVec2(x + w, y + 108.0f), C(9, 70, 110, (int)(238 * e)), 32.0f);
    dl->AddRectFilled(ImVec2(x, y + 74.0f), ImVec2(x + w, y + 122.0f), C(5, 14, 25, (int)(125 * e)), 0.0f);
    dl->AddLine(ImVec2(x + 34.0f, y + h - 118.0f), ImVec2(x + w - 34.0f, y + h - 118.0f), C(75, 190, 242, (int)(70 * e)), 1.4f);
    dl->AddLine(ImVec2(x + 62.0f, y + 132.0f), ImVec2(x + w - 62.0f, y + 132.0f), C(255, 216, 112, (int)(38 * e)), 1.0f);
    dl->AddRect(ImVec2(x, y), ImVec2(x + w, y + h), C(73, 194, 248, (int)(155 * e)), 32.0f, 0, 2.2f);

    float planeX = x + 76.0f;
    float planeY = y + 56.0f;
    dl->AddCircleFilled(ImVec2(planeX, planeY), 44.0f, C(12, 31, 48, (int)(245 * e)), 48);
    dl->AddCircle(ImVec2(planeX, planeY), 44.0f, C(255, 216, 112, (int)(245 * e)), 48, 3.0f);
    dl->AddTriangleFilled(ImVec2(planeX - 18.0f, planeY + 5.0f), ImVec2(planeX + 27.0f, planeY - 3.0f), ImVec2(planeX - 18.0f, planeY - 12.0f), C(235, 248, 255, (int)(255 * e)));
    dl->AddTriangleFilled(ImVec2(planeX - 4.0f, planeY - 4.0f), ImVec2(planeX - 28.0f, planeY - 25.0f), ImVec2(planeX - 12.0f, planeY - 2.0f), C(95, 209, 255, (int)(255 * e)));
    dl->AddTriangleFilled(ImVec2(planeX - 5.0f, planeY + 2.0f), ImVec2(planeX - 30.0f, planeY + 24.0f), ImVec2(planeX - 13.0f, planeY + 4.0f), C(95, 209, 255, (int)(255 * e)));

    std::string title = A("عمل الطيران");
    std::string sub = A("رحلات شحن • مستويات • مكافآت");
    dl->AddText(nullptr, 38.0f, ImVec2(x + w - 332.0f, y + 32.0f), C(246, 252, 255, (int)(255 * e)), title.c_str());
    dl->AddText(ImVec2(x + w - 342.0f, y + 78.0f), C(186, 226, 242, (int)(255 * e)), sub.c_str());

    char lvl[32];
    snprintf(lvl, sizeof(lvl), "%d / 50", m_level);
    dl->AddRectFilled(ImVec2(x + w - 156.0f, y + 30.0f), ImVec2(x + w - 42.0f, y + 86.0f), C(255, 217, 99, (int)(30 * e)), 18.0f);
    dl->AddRect(ImVec2(x + w - 156.0f, y + 30.0f), ImVec2(x + w - 42.0f, y + 86.0f), C(255, 217, 99, (int)(210 * e)), 18.0f, 0, 1.8f);
    dl->AddText(nullptr, 27.0f, ImVec2(x + w - 137.0f, y + 43.0f), C(255, 243, 204, (int)(255 * e)), lvl);

    float cy = y + 148.0f;
    float leftW = w * 0.39f;
    float rightX = x + leftW + 48.0f;
    dl->AddRectFilled(ImVec2(x + 42.0f, cy), ImVec2(x + leftW, y + h - 100.0f), C(10, 29, 45, (int)(235 * e)), 24.0f);
    dl->AddRect(ImVec2(x + 42.0f, cy), ImVec2(x + leftW, y + h - 100.0f), C(65, 150, 194, (int)(90 * e)), 24.0f, 0, 1.4f);
    std::string route = A("مسار الرحلة");
    std::string r1 = A("استلام الصندوق");
    std::string r2 = A("تحميل الطائرة");
    std::string r3 = A("تسليم الشحنة");
    dl->AddText(ImVec2(x + leftW - 36.0f - ImGui::CalcTextSize(route.c_str()).x, cy + 24.0f), C(232, 246, 255, (int)(255 * e)), route.c_str());
    for (int i = 0; i < 3; ++i)
    {
        float py = cy + 76.0f + i * 54.0f;
        dl->AddCircleFilled(ImVec2(x + 78.0f, py + 10.0f), 10.0f, i == 0 ? C(74, 203, 255, (int)(255 * e)) : C(255, 216, 95, (int)(245 * e)), 24);
        if (i < 2) dl->AddLine(ImVec2(x + 78.0f, py + 22.0f), ImVec2(x + 78.0f, py + 52.0f), C(90, 150, 175, (int)(150 * e)), 2.0f);
    }
    dl->AddText(ImVec2(x + leftW - 44.0f - ImGui::CalcTextSize(r1.c_str()).x, cy + 76.0f), C(214, 238, 249, (int)(255 * e)), r1.c_str());
    dl->AddText(ImVec2(x + leftW - 44.0f - ImGui::CalcTextSize(r2.c_str()).x, cy + 130.0f), C(214, 238, 249, (int)(255 * e)), r2.c_str());
    dl->AddText(ImVec2(x + leftW - 44.0f - ImGui::CalcTextSize(r3.c_str()).x, cy + 184.0f), C(214, 238, 249, (int)(255 * e)), r3.c_str());

    float cardW = w - (rightX - x) - 42.0f;
    char rewardBuf[48], boxesBuf[48];
    snprintf(rewardBuf, sizeof(rewardBuf), "%d$", m_reward);
    snprintf(boxesBuf, sizeof(boxesBuf), "%d", m_boxes);
    std::string reward = A("مكافأة الرحلة");
    std::string boxes = A("الصناديق المنجزة");
    dl->AddRectFilled(ImVec2(rightX, cy), ImVec2(rightX + cardW, cy + 76.0f), C(14, 33, 50, (int)(240 * e)), 22.0f);
    dl->AddRectFilled(ImVec2(rightX, cy + 96.0f), ImVec2(rightX + cardW, cy + 172.0f), C(14, 33, 50, (int)(240 * e)), 22.0f);
    dl->AddText(ImVec2(rightX + cardW - 28.0f - ImGui::CalcTextSize(reward.c_str()).x, cy + 18.0f), C(178, 213, 229, (int)(255 * e)), reward.c_str());
    dl->AddText(nullptr, 32.0f, ImVec2(rightX + 32.0f, cy + 39.0f), C(255, 223, 103, (int)(255 * e)), rewardBuf);
    dl->AddText(ImVec2(rightX + cardW - 28.0f - ImGui::CalcTextSize(boxes.c_str()).x, cy + 112.0f), C(178, 213, 229, (int)(255 * e)), boxes.c_str());
    dl->AddText(nullptr, 32.0f, ImVec2(rightX + 32.0f, cy + 132.0f), C(99, 218, 255, (int)(255 * e)), boxesBuf);

    float progress = m_level >= 50 ? 1.0f : ((float)(3 - m_toNext) / 3.0f);
    DrawProgressBar(rightX, cy + 204.0f, cardW, 16.0f, progress);
    char nextBuf[96];
    if (m_level >= 50) snprintf(nextBuf, sizeof(nextBuf), "%s", "وصلت إلى أعلى مستوى");
    else snprintf(nextBuf, sizeof(nextBuf), "المتبقي للمستوى القادم: %d صناديق", m_toNext);
    std::string next = A(nextBuf);
    dl->AddText(ImVec2(rightX + cardW - ImGui::CalcTextSize(next.c_str()).x, cy + 230.0f), C(204, 233, 245, (int)(255 * e)), next.c_str());

    Rect close = { x + 42.0f, y + h - 68.0f, x + 190.0f, y + h - 18.0f };
    Rect stats = { x + w - 462.0f, y + h - 68.0f, x + w - 248.0f, y + h - 18.0f };
    Rect start = { x + w - 226.0f, y + h - 68.0f, x + w - 42.0f, y + h - 18.0f };
    if (Button(close, "إغلاق", C(74, 35, 42, (int)(225 * e)), C(178, 94, 100, (int)(180 * e)), C(255,232,232,(int)(255*e)))) SendResponse(0, 0);
    if (Button(stats, "الإحصائيات", C(25, 47, 69, (int)(240 * e)), C(95, 178, 222, (int)(185 * e)), C(235,248,255,(int)(255*e)))) { m_page = PAGE_STATS; PlaySound(1052); }
    if (Button(start, "بدء العمل", C(17, 154, 218, (int)(248 * e)), C(175, 238, 255, (int)(220 * e)), C(255,255,255,(int)(255*e)))) SendResponse(1, 0);
}

void CFlightJobOverlay::DrawStats(float sw, float sh)
{
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    float e = FJEase(m_anim);
    dl->AddRectFilled(ImVec2(0, 0), ImVec2(sw, sh), C(0, 7, 15, (int)(205 * e)));

    float w = sw * 0.58f;
    float h = sh * 0.60f;
    if (w > 840.0f) w = 840.0f;
    if (h > 450.0f) h = 450.0f;
    float x = (sw - w) * 0.5f;
    float y = (sh - h) * 0.5f + (1.0f - e) * 42.0f;

    dl->AddRectFilled(ImVec2(x + 12.0f, y + 16.0f), ImVec2(x + w + 12.0f, y + h + 16.0f), C(0, 0, 0, (int)(115 * e)), 30.0f);
    dl->AddRectFilled(ImVec2(x, y), ImVec2(x + w, y + h), C(7, 17, 29, (int)(250 * e)), 30.0f);
    dl->AddRectFilled(ImVec2(x, y), ImVec2(x + w, y + 100.0f), C(11, 58, 89, (int)(225 * e)), 30.0f);
    dl->AddRect(ImVec2(x, y), ImVec2(x + w, y + h), C(73, 194, 248, (int)(155 * e)), 30.0f, 0, 2.0f);

    std::string title = A("إحصائيات الطيران");
    dl->AddText(nullptr, 38.0f, ImVec2(x + w - 360.0f, y + 34.0f), C(246, 252, 255, (int)(255 * e)), title.c_str());
    dl->AddCircle(ImVec2(x + 76.0f, y + 52.0f), 28.0f, C(255, 216, 112, (int)(230 * e)), 32, 2.5f);
    dl->AddLine(ImVec2(x + 62.0f, y + 56.0f), ImVec2(x + 92.0f, y + 48.0f), C(235,248,255,(int)(255*e)), 3.0f);
    dl->AddLine(ImVec2(x + 75.0f, y + 52.0f), ImVec2(x + 65.0f, y + 38.0f), C(95,209,255,(int)(255*e)), 3.0f);

    char b1[96], b2[96], b3[96], b4[96];
    snprintf(b1, sizeof(b1), "المستوى الحالي: %d من 50", m_level);
    snprintf(b2, sizeof(b2), "الصناديق المسلمة: %d", m_boxes);
    snprintf(b3, sizeof(b3), "مكافأة الرحلة: %d دولار", m_reward);
    if (m_level >= 50) snprintf(b4, sizeof(b4), "%s", "تم الوصول إلى أعلى مستوى");
    else snprintf(b4, sizeof(b4), "المتبقي للمستوى القادم: %d صناديق", m_toNext);
    const char* rows[4] = { b1, b2, b3, b4 };
    unsigned int accents[4] = { C(93, 211, 255, (int)(255 * e)), C(255, 217, 99, (int)(255 * e)), C(93, 255, 176, (int)(255 * e)), C(180, 135, 255, (int)(255 * e)) };
    for (int i = 0; i < 4; ++i)
    {
        float ry = y + 132.0f + i * 64.0f;
        dl->AddRectFilled(ImVec2(x + 58.0f, ry), ImVec2(x + w - 58.0f, ry + 48.0f), C(13, 32, 49, (int)(235 * e)), 16.0f);
        dl->AddRectFilled(ImVec2(x + w - 70.0f, ry + 10.0f), ImVec2(x + w - 62.0f, ry + 38.0f), accents[i], 6.0f);
        std::string t = A(rows[i]);
        dl->AddText(ImVec2(x + w - 92.0f - ImGui::CalcTextSize(t.c_str()).x, ry + 13.0f), C(225,244,255,(int)(255*e)), t.c_str());
    }

    Rect back = { x + w - 242.0f, y + h - 72.0f, x + w - 58.0f, y + h - 22.0f };
    Rect start = { x + 58.0f, y + h - 72.0f, x + 242.0f, y + h - 22.0f };
    if (Button(back, "رجوع", C(25, 47, 69, (int)(240 * e)), C(95, 178, 222, (int)(185 * e)), C(235,248,255,(int)(255*e)))) { m_page = PAGE_HOME; PlaySound(1052); }
    if (Button(start, "بدء العمل", C(17, 154, 218, (int)(248 * e)), C(175, 238, 255, (int)(220 * e)), C(255,255,255,(int)(255*e)))) SendResponse(1, 0);
}

void CFlightJobOverlay::Render()
{
    if (!m_visible) return;
    ImGuiIO& io = ImGui::GetIO();
    m_anim = FJClamp(m_anim + (io.DeltaTime > 0.0f ? io.DeltaTime : 0.016f) * 4.0f, 0.0f, 1.0f);
    if (m_page == PAGE_HOME) DrawHome(io.DisplaySize.x, io.DisplaySize.y);
    else DrawStats(io.DisplaySize.x, io.DisplaySize.y);
    io.WantCaptureMouse = true;
    io.WantCaptureKeyboard = true;
    m_lastDown = io.MouseDown[0];
}
