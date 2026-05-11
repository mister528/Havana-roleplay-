#include "../main.h"
#include "objecteditoroverlay.h"
#include "../arabic.h"
#include "../game/game.h"
#include "../net/netgame.h"
#include "../vendor/imgui/imgui.h"
#include "../vendor/imgui/imgui_internal.h"
#include <cstdio>
#include <cstring>
#include <cmath>
#include <string>
#include <vector>

CObjectEditorOverlay* pObjectEditorOverlay = nullptr;
extern void Inventory_SendChatCommand(const char* cmd);
extern CNetGame* pNetGame;

struct ObjEditScaleRecord
{
    int model;
    float x, y, z;
    float scale;
};

static std::vector<ObjEditScaleRecord> g_objeditScaleRecords;

static void ObjEditApplyScaleToObject(CObject* obj, float s)
{
    if (!obj || !obj->m_pEntity || !obj->m_pEntity->mat) return;
    MATRIX4X4 mat;
    obj->GetMatrix(&mat);
    float rl = sqrtf(mat.right.X * mat.right.X + mat.right.Y * mat.right.Y + mat.right.Z * mat.right.Z);
    float ul = sqrtf(mat.up.X * mat.up.X + mat.up.Y * mat.up.Y + mat.up.Z * mat.up.Z);
    float al = sqrtf(mat.at.X * mat.at.X + mat.at.Y * mat.at.Y + mat.at.Z * mat.at.Z);
    if (rl > 0.001f) { mat.right.X /= rl; mat.right.Y /= rl; mat.right.Z /= rl; }
    if (ul > 0.001f) { mat.up.X /= ul; mat.up.Y /= ul; mat.up.Z /= ul; }
    if (al > 0.001f) { mat.at.X /= al; mat.at.Y /= al; mat.at.Z /= al; }
    mat.right.X *= s; mat.right.Y *= s; mat.right.Z *= s;
    mat.up.X *= s; mat.up.Y *= s; mat.up.Z *= s;
    mat.at.X *= s; mat.at.Y *= s; mat.at.Z *= s;
    obj->SetMatrix(mat);
    obj->UpdateRwMatrixAndFrame();
}

static std::string ObjEditShapeText(const char* s)
{
    if (!s) return std::string();
    if (!Arabic::ContainsArabic(s)) return std::string(s);
    return Arabic::Shape(s);
}

static ImVec2 ObjEditCalcTextSize(ImFont* font, float size, const std::string& text)
{
    if (!font) return ImGui::CalcTextSize(text.c_str());
    return font->CalcTextSizeA(size, FLT_MAX, 0.0f, text.c_str());
}

static bool ObjHitRect(ImVec2 p, float x, float y, float w, float h)
{
    return p.x >= x && p.x <= x + w && p.y >= y && p.y <= y + h;
}

CObjectEditorOverlay::CObjectEditorOverlay()
    : m_bVisible(false)
    , m_iActiveSlot(-1)
    , m_iActiveModel(0)
    , m_iObjCount(0)
    , m_iAttached(0)
    , m_fX(0), m_fY(0), m_fZ(0)
    , m_fRX(0), m_fRY(0), m_fRZ(0)
    , m_fScale(1.0f)
    , m_fPadX(0), m_fPadY(0), m_fPadW(0), m_fPadH(0)
{
}

CObjectEditorOverlay::~CObjectEditorOverlay()
{
}

void CObjectEditorOverlay::Hide()
{
    m_bVisible = false;
    m_iActiveSlot = -1;
}

void CObjectEditorOverlay::ApplyServerCommand(const char* payload)
{
    if (!payload) return;

    if (strncmp(payload, "HIDE", 4) == 0)
    {
        Hide();
        return;
    }

    // SHOW|slot|model|count|attached|x|y|z|rx|ry|rz|scale|project
    if (strncmp(payload, "SHOW|", 5) == 0)
    {
        char buf[512];
        strncpy(buf, payload + 5, sizeof(buf) - 1);
        buf[sizeof(buf) - 1] = '\0';

        char* save = nullptr;
        char* tok;
        int idx = 0;
        tok = strtok_r(buf, "|", &save);
        while (tok)
        {
            switch (idx)
            {
                case 0: m_iActiveSlot  = atoi(tok); break;
                case 1: m_iActiveModel = atoi(tok); break;
                case 2: m_iObjCount    = atoi(tok); break;
                case 3: m_iAttached    = atoi(tok); break;
                case 4: m_fX  = (float)atof(tok); break;
                case 5: m_fY  = (float)atof(tok); break;
                case 6: m_fZ  = (float)atof(tok); break;
                case 7: m_fRX = (float)atof(tok); break;
                case 8: m_fRY = (float)atof(tok); break;
                case 9: m_fRZ = (float)atof(tok); break;
                case 10: m_fScale = (float)atof(tok); break;
                case 11: m_sProjectName = tok; break;
            }
            idx++;
            tok = strtok_r(nullptr, "|", &save);
        }
        m_bVisible = true;
        return;
    }

    // SCALE|model|x|y|z|scale - permanent saved object scale
    if (strncmp(payload, "SCALE|", 6) == 0)
    {
        char buf[256];
        strncpy(buf, payload + 6, sizeof(buf) - 1);
        buf[sizeof(buf) - 1] = '\0';
        char* save = nullptr;
        char* tok = strtok_r(buf, "|", &save);
        ObjEditScaleRecord rec;
        rec.model = 0; rec.x = rec.y = rec.z = 0.0f; rec.scale = 1.0f;
        int idx = 0;
        while (tok)
        {
            switch (idx)
            {
                case 0: rec.model = atoi(tok); break;
                case 1: rec.x = (float)atof(tok); break;
                case 2: rec.y = (float)atof(tok); break;
                case 3: rec.z = (float)atof(tok); break;
                case 4: rec.scale = (float)atof(tok); break;
            }
            idx++;
            tok = strtok_r(nullptr, "|", &save);
        }
        if (rec.model > 0 && rec.scale > 0.01f)
        {
            bool updated = false;
            for (size_t i = 0; i < g_objeditScaleRecords.size(); ++i)
            {
                ObjEditScaleRecord& oldRec = g_objeditScaleRecords[i];
                float dx = oldRec.x - rec.x;
                float dy = oldRec.y - rec.y;
                float dz = oldRec.z - rec.z;
                if (oldRec.model == rec.model && (dx*dx + dy*dy + dz*dz) < 0.25f)
                {
                    oldRec = rec;
                    updated = true;
                    break;
                }
            }
            if (!updated) g_objeditScaleRecords.push_back(rec);
        }
        return;
    }

    // STATUS|text
    if (strncmp(payload, "STATUS|", 7) == 0)
    {
        m_sStatus = payload + 7;
        return;
    }
}


bool CObjectEditorOverlay::HitTest(float x, float y) const
{
    if (!m_bVisible) return false;
    return x >= m_fPadX && x <= m_fPadX + m_fPadW && y >= m_fPadY && y <= m_fPadY + m_fPadH;
}

void CObjectEditorOverlay::ApplyClientScale()
{
    if (!pNetGame || !pNetGame->GetObjectPool()) return;
    int model = m_iActiveModel;
    CObjectPool* pool = pNetGame->GetObjectPool();
    CObject* bestObj = nullptr;
    float bestDist = 999999.0f;
    for (uint16_t i = 0; i < MAX_OBJECTS; ++i)
    {
        CObject* obj = pool->GetAt(i);
        if (!obj || !obj->m_pEntity || !obj->m_pEntity->mat) continue;
        if (obj->GetModelIndex() != model) continue;
        MATRIX4X4 mat;
        obj->GetMatrix(&mat);
        float dx = mat.pos.X - m_fX;
        float dy = mat.pos.Y - m_fY;
        float dz = mat.pos.Z - m_fZ;
        float d = dx*dx + dy*dy + dz*dz;
        if (d < bestDist)
        {
            bestDist = d;
            bestObj = obj;
        }
    }
    if (bestObj) ObjEditApplyScaleToObject(bestObj, m_fScale);
}

void CObjectEditorOverlay::ApplySavedScales()
{
    if (!pNetGame || !pNetGame->GetObjectPool()) return;
    if (g_objeditScaleRecords.empty()) return;
    CObjectPool* pool = pNetGame->GetObjectPool();
    for (size_t r = 0; r < g_objeditScaleRecords.size(); ++r)
    {
        const ObjEditScaleRecord& rec = g_objeditScaleRecords[r];
        CObject* bestObj = nullptr;
        float bestDist = 999999.0f;
        for (uint16_t i = 0; i < MAX_OBJECTS; ++i)
        {
            CObject* obj = pool->GetAt(i);
            if (!obj || !obj->m_pEntity || !obj->m_pEntity->mat) continue;
            if (obj->GetModelIndex() != rec.model) continue;
            MATRIX4X4 mat;
            obj->GetMatrix(&mat);
            float dx = mat.pos.X - rec.x;
            float dy = mat.pos.Y - rec.y;
            float dz = mat.pos.Z - rec.z;
            float d = dx*dx + dy*dy + dz*dz;
            if (d < bestDist)
            {
                bestDist = d;
                bestObj = obj;
            }
        }
        if (bestObj && bestDist < 9.0f) ObjEditApplyScaleToObject(bestObj, rec.scale);
    }
}

void CObjectEditorOverlay::Render()
{
    ApplySavedScales();
    if (!m_bVisible) return;

    ImGuiIO& io = ImGui::GetIO();
    float sw = io.DisplaySize.x;
    float sh = io.DisplaySize.y;
    if (sw < 1 || sh < 1) return;

    float base = sh / 1080.0f;

    RenderControlPad(sw, sh, base);
    if (m_fScale != 1.0f) ApplyClientScale();
}

void CObjectEditorOverlay::RenderControlPad(float sw, float sh, float base)
{
    ImGuiIO& io = ImGui::GetIO();
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    ImFont* font = ImGui::GetFont();

    float padW = 560.0f * base;
    float padH = 980.0f * base;
    if (padW > sw * 0.48f) padW = sw * 0.48f;
    if (padH > sh * 0.98f) padH = sh * 0.98f;
    float padX = sw - padW - 20.0f * base;
    float padY = (sh - padH) * 0.5f;
    ImVec2 pMin(padX, padY);
    ImVec2 pMax(padX + padW, padY + padH);
    m_fPadX = padX; m_fPadY = padY; m_fPadW = padW; m_fPadH = padH;
    float cr = 22.0f * base;

    // Glow border
    for (int s = 0; s < 7; ++s)
    {
        float off = (s + 1) * 2.0f * base;
        int a = 22 - s * 2; if (a < 0) a = 0;
        dl->AddRectFilled(ImVec2(pMin.x - off, pMin.y - off),
                          ImVec2(pMax.x + off, pMax.y + off),
                          IM_COL32(80, 180, 220, a), cr + off);
    }

    // Background gradient
    dl->AddRectFilledMultiColor(pMin, pMax,
        IM_COL32(28, 42, 68, 248), IM_COL32(36, 52, 82, 248),
        IM_COL32(16, 22, 36, 248), IM_COL32(14, 18, 30, 248));

    // Top highlight
    dl->AddRectFilledMultiColor(ImVec2(pMin.x, pMin.y), ImVec2(pMax.x, pMin.y + 110.0f * base),
        IM_COL32(100, 200, 255, 30), IM_COL32(100, 200, 255, 30),
        IM_COL32(100, 200, 255, 0), IM_COL32(100, 200, 255, 0));

    // Border
    dl->AddRect(pMin, pMax, IM_COL32(80, 180, 255, 180), cr, 0, 2.0f * base);

    // Separator line
    dl->AddRectFilledMultiColor(ImVec2(pMin.x + 25.0f * base, pMin.y + 108.0f * base),
        ImVec2(pMax.x - 25.0f * base, pMin.y + 112.0f * base),
        IM_COL32(60, 180, 255, 180), IM_COL32(120, 80, 220, 220),
        IM_COL32(120, 80, 220, 220), IM_COL32(60, 180, 255, 180));

    // Title
    if (font)
    {
        const char* title = "\xd9\x85\xd8\xad\xd8\xb1\xd8\xb1 \xd8\xa7\xd9\x84\xd8\xa3\xd9\x88\xd8\xa8\xd8\xac\xd9\x83\xd8\xaa\xd8\xa7\xd8\xaa"; // محرر الأوبجكتات
        float fsT = 42.0f * base;
        std::string titleText = ObjEditShapeText(title);
        ImVec2 ts = ObjEditCalcTextSize(font, fsT, titleText);
        dl->AddText(font, fsT, ImVec2(pMin.x + (padW - ts.x) * 0.5f, pMin.y + 20.0f * base),
                    IM_COL32(120, 210, 255, 255), titleText.c_str());
    }

    // Info line: project/slot/model
    if (font)
    {
        char infoBuf[256];
        snprintf(infoBuf, sizeof(infoBuf), "%s | #%d | ID:%d | %d/%d",
                 m_sProjectName.c_str(), m_iActiveSlot + 1, m_iActiveModel,
                 m_iActiveSlot + 1, m_iObjCount);
        float fsI = 28.0f * base;
        std::string infoText(infoBuf);
        ImVec2 is = ObjEditCalcTextSize(font, fsI, infoText);
        dl->AddText(font, fsI, ImVec2(pMin.x + (padW - is.x) * 0.5f, pMin.y + 68.0f * base),
                    IM_COL32(200, 220, 255, 220), infoText.c_str());
    }

    // Buttons
    struct Btn { const char* label; const char* cmd; ImU32 col; ImU32 colHi; bool canRepeat; };
    Btn btns[] = {
        {"\xd8\xb1\xd9\x81\xd8\xb9",   "/obj_up",      IM_COL32(50,130,210,230), IM_COL32(90,170,255,255), true},   // رفع
        {"\xd9\x86\xd8\xb2\xd9\x88\xd9\x84", "/obj_dn",  IM_COL32(50,130,210,230), IM_COL32(90,170,255,255), true},  // نزول
        {"\xd8\xa3\xd9\x85\xd8\xa7\xd9\x85", "/obj_fw",  IM_COL32(70,100,190,235), IM_COL32(120,140,255,255), true}, // أمام
        {"\xd8\xae\xd9\x84\xd9\x81",   "/obj_bk",      IM_COL32(70,100,190,235), IM_COL32(120,140,255,255), true},   // خلف
        {"\xd9\x8a\xd8\xb3\xd8\xa7\xd8\xb1", "/obj_left", IM_COL32(90,80,190,235), IM_COL32(140,120,255,255), true}, // يسار
        {"\xd9\x8a\xd9\x85\xd9\x8a\xd9\x86", "/obj_right",IM_COL32(90,80,190,235), IM_COL32(140,120,255,255), true}, // يمين
        {"\xd8\xaf\xd9\x88\xd8\xb1\xd8\xa7\xd9\x86 X", "/obj_rx", IM_COL32(150,100,60,230), IM_COL32(200,140,90,255), true},  // دوران X
        {"\xd8\xaf\xd9\x88\xd8\xb1\xd8\xa7\xd9\x86 Y", "/obj_ry", IM_COL32(150,100,60,230), IM_COL32(200,140,90,255), true},  // دوران Y
        {"\xd8\xaf\xd9\x88\xd8\xb1\xd8\xa7\xd9\x86 Z", "/obj_rz", IM_COL32(150,100,60,230), IM_COL32(200,140,90,255), true},  // دوران Z
        {"\xd8\xaa\xd9\x83\xd8\xa8\xd9\x8a\xd8\xb1", "/obj_big", IM_COL32(80,130,90,230), IM_COL32(120,180,130,255), true}, // تكبير
        {"\xd8\xaa\xd8\xb5\xd8\xba\xd9\x8a\xd8\xb1", "/obj_sml", IM_COL32(80,130,90,230), IM_COL32(120,180,130,255), true}, // تصغير
        {"\xd8\xaa\xd8\xb1\xd8\xa7\xd8\xac\xd8\xb9", "/obj_undo", IM_COL32(100,90,120,230), IM_COL32(140,130,160,255), false},// تراجع
        {"\xd8\xa7\xd9\x84\xd8\xb3\xd8\xa7\xd8\xa8\xd9\x82", "/obj_prev", IM_COL32(60,140,100,230), IM_COL32(90,190,130,255), false}, // السابق
        {"\xd8\xa7\xd9\x84\xd8\xaa\xd8\xa7\xd9\x84\xd9\x8a", "/obj_next", IM_COL32(60,140,100,230), IM_COL32(90,190,130,255), false}, // التالي
        {"\xd8\xaa\xd8\xab\xd8\xa8\xd9\x8a\xd8\xaa", "/obj_attach", IM_COL32(180,130,50,230), IM_COL32(220,170,80,255), false},// تثبيت
        {"\xd9\x81\xd9\x83",         "/obj_detach",  IM_COL32(160,80,80,230), IM_COL32(200,110,110,255), false},      // فك
        {"\xd8\xad\xd8\xb0\xd9\x81", "/obj_del",    IM_COL32(180,50,50,230), IM_COL32(220,80,80,255), false},        // حذف
        {"\xd8\xad\xd9\x81\xd8\xb8", "/obj_save",   IM_COL32(50,160,80,230), IM_COL32(80,200,110,255), false},       // حفظ
        {"\xd8\xaf\xd8\xa7\xd8\xa6\xd9\x85", "/obj_perm",   IM_COL32(50,110,170,230), IM_COL32(80,150,210,255), false},       // دائم
    };
    int btnCount = sizeof(btns) / sizeof(btns[0]);
    float btnW = (padW - 70.0f * base) * 0.5f;
    float btnH = 56.0f * base;
    float gx = pMin.x + 25.0f * base;
    float gy = pMin.y + 125.0f * base;
    float gap = 10.0f * base;

    static bool s_down = false;
    bool edge = io.MouseDown[0] && !s_down;
    static double s_lastFireByButton[32] = {};
    double now = ImGui::GetTime();

    for (int i = 0; i < btnCount; ++i)
    {
        int row = i / 2, col = i % 2;
        ImVec2 bMin(gx + col * (btnW + gap), gy + row * (btnH + gap));
        ImVec2 bMax(bMin.x + btnW, bMin.y + btnH);
        bool hov = ObjHitRect(io.MousePos, bMin.x, bMin.y, btnW, btnH);

        dl->AddRectFilled(bMin, bMax, hov ? btns[i].colHi : btns[i].col, btnH * 0.30f);
        dl->AddRect(bMin, bMax, IM_COL32(255,255,255,60), btnH * 0.30f, 0, 1.2f * base);

        if (font)
        {
            float fs = 32.0f * base;
            std::string btnLabel = ObjEditShapeText(btns[i].label);
            ImVec2 ts = ObjEditCalcTextSize(font, fs, btnLabel);
            dl->AddText(font, fs, ImVec2(bMin.x + (btnW - ts.x) * 0.5f, bMin.y + (btnH - fs) * 0.5f),
                        IM_COL32(255,255,255,255), btnLabel.c_str());
        }

        bool repeat = io.MouseDown[0] && (now - s_lastFireByButton[i]) > 0.09;
        bool fire = btns[i].canRepeat ? (edge || repeat) : edge;
        if (hov && fire)
        {
            Inventory_SendChatCommand(btns[i].cmd);
            if (strcmp(btns[i].cmd, "/obj_big") == 0)
            {
                m_fScale += 0.05f;
                if (m_fScale > 5.0f) m_fScale = 5.0f;
                ApplyClientScale();
            }
            else if (strcmp(btns[i].cmd, "/obj_sml") == 0)
            {
                m_fScale -= 0.05f;
                if (m_fScale < 0.20f) m_fScale = 0.20f;
                ApplyClientScale();
            }
            s_lastFireByButton[i] = now;
        }
    }

    // Close button
    float closeY = gy + ((btnCount + 1) / 2) * (btnH + gap) + 8.0f * base;
    ImVec2 cMin(gx, closeY);
    ImVec2 cMax(gx + padW - 50.0f * base, closeY + btnH);
    bool hov = ObjHitRect(io.MousePos, cMin.x, cMin.y, cMax.x - cMin.x, btnH);
    dl->AddRectFilled(cMin, cMax, hov ? IM_COL32(200,60,60,255) : IM_COL32(160,50,50,235), btnH * 0.30f);
    dl->AddRect(cMin, cMax, IM_COL32(255,255,255,80), btnH * 0.30f, 0, 1.2f * base);
    if (font)
    {
        const char* lbl = "\xd8\xa5\xd8\xba\xd9\x84\xd8\xa7\xd9\x82"; // إغلاق
        float fs = 36.0f * base;
        std::string label = ObjEditShapeText(lbl);
        ImVec2 ts = ObjEditCalcTextSize(font, fs, label);
        dl->AddText(font, fs, ImVec2(cMin.x + ((padW - 50.0f * base) - ts.x) * 0.5f, cMin.y + (btnH - fs) * 0.5f),
                    IM_COL32(255,255,255,255), label.c_str());
    }
    if (hov && edge)
    {
        Inventory_SendChatCommand("/obj_close");
        Hide();
    }

    // Status text at bottom
    if (font && !m_sStatus.empty())
    {
        float fsS = 24.0f * base;
        std::string statusText = ObjEditShapeText(m_sStatus.c_str());
        ImVec2 ss = ObjEditCalcTextSize(font, fsS, statusText);
        float sy = closeY + btnH + 10.0f * base;
        dl->AddText(font, fsS, ImVec2(pMin.x + (padW - ss.x) * 0.5f, sy),
                    IM_COL32(255, 220, 100, 220), statusText.c_str());
    }

    s_down = io.MouseDown[0];
}
