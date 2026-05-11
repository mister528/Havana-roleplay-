#include "../main.h"
#include "weaponcraftoverlay.h"
#include "weaponcrafttex.h"
#include "gui.h"
#include "../arabic.h"
#include "../vendor/imgui/imgui.h"
#include "../vendor/imgui/imgui_internal.h"

#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <cmath>
#include <string>

extern CGUI* pGUI;

// Bridge implemented in netrpc.cpp - we reuse Inventory_SendChatCommand which
// just forwards a string command (e.g. "/craft_pick 1") to the server.
extern void Inventory_SendChatCommand(const char* cmd);

CWeaponCraftOverlay* pWeaponCraftOverlay = nullptr;

namespace
{
    // ------------------------------------------------------------------
    //  Visual palette (deep gunmetal + warm amber accents).
    // ------------------------------------------------------------------
    static const ImU32 kColScrim   = IM_COL32(  6,   8,  14, 232);
    static const ImU32 kColPanel   = IM_COL32( 18,  21,  30, 248);
    static const ImU32 kColPanel2  = IM_COL32( 26,  30,  42, 248);
    static const ImU32 kColInner   = IM_COL32( 11,  13,  20, 252);
    static const ImU32 kColBorder  = IM_COL32(255, 195,  76, 215);
    static const ImU32 kColBorderD = IM_COL32(255, 195,  76,  90);
    static const ImU32 kColAccent  = IM_COL32(255, 173,  54, 255);
    static const ImU32 kColAccent2 = IM_COL32(255, 220, 120, 255);
    static const ImU32 kColRed     = IM_COL32(232,  72,  85, 255);
    static const ImU32 kColRedDim  = IM_COL32(232,  72,  85,  85);
    static const ImU32 kColGreen   = IM_COL32( 72, 222, 128, 255);
    static const ImU32 kColText    = IM_COL32(248, 248, 248, 250);
    static const ImU32 kColTextDim = IM_COL32(248, 248, 248, 165);
    static const ImU32 kColTextSub = IM_COL32(248, 248, 248,  92);
    static const ImU32 kColYellow  = IM_COL32(255, 218,  68, 255);
    static const ImU32 kColYellowD = IM_COL32(255, 218,  68, 110);

    // Easing helpers.
    static float EaseOut(float t) { if (t < 0.0f) t = 0.0f; if (t > 1.0f) t = 1.0f; return 1.0f - (1.0f - t) * (1.0f - t); }
    static float Lerp(float a, float b, float t) { return a + (b - a) * t; }
    static float Clampf(float v, float lo, float hi) { if (v < lo) return lo; if (v > hi) return hi; return v; }

    // Arabic shaping - returns shaped string for RTL display.
    static std::string Shape(const char* s)
    {
        if (!s) return std::string();
        if (!Arabic::ContainsArabic(s)) return std::string(s);
        return Arabic::Shape(s);
    }

    // ------------------------------------------------------------------
    //  Border-trace path (normalized 0..1 in trace area).  Approximates
    //  the silhouette of an RPG-7 launcher: long barrel + front warhead
    //  cone + back exhaust cone + pistol grip on the underside.  The
    //  player must drag their finger from waypoint to waypoint and the
    //  segment they're currently tracing is highlighted in bright yellow.
    // ------------------------------------------------------------------
    struct PathPt { float x, y; };
    static const PathPt kPath[] = {
        { 0.080f, 0.470f }, // 0  back-top of exhaust
        { 0.140f, 0.430f }, // 1
        { 0.205f, 0.345f }, // 2  rise to top sight
        { 0.270f, 0.320f }, // 3  top sight peak
        { 0.345f, 0.395f }, // 4  back down to barrel top
        { 0.560f, 0.395f }, // 5  top of barrel midline
        { 0.745f, 0.355f }, // 6  warhead rise
        { 0.905f, 0.495f }, // 7  warhead tip
        { 0.745f, 0.625f }, // 8  warhead descent
        { 0.560f, 0.585f }, // 9  bottom of barrel
        { 0.490f, 0.715f }, // 10 grip top
        { 0.420f, 0.870f }, // 11 grip back-bottom
        { 0.345f, 0.870f }, // 12 grip front-bottom
        { 0.305f, 0.715f }, // 13 grip front-top
        { 0.225f, 0.585f }, // 14 underside of barrel
        { 0.130f, 0.555f }, // 15 back exhaust bottom
        { 0.080f, 0.470f }  // 16 close the loop
    };
    static const int kPathCount = (int)(sizeof(kPath) / sizeof(kPath[0]));
    static const int kSegmentCount = kPathCount - 1;

    // Project point P onto segment AB, return projection parameter t in [0..1]
    // and perpendicular distance.
    static void ProjectOnSegment(float ax, float ay, float bx, float by,
                                 float px, float py,
                                 float* outT, float* outDist)
    {
        float dx = bx - ax;
        float dy = by - ay;
        float len2 = dx * dx + dy * dy;
        float t = 0.0f;
        if (len2 > 1e-6f) t = ((px - ax) * dx + (py - ay) * dy) / len2;
        if (t < 0.0f) t = 0.0f;
        if (t > 1.0f) t = 1.0f;
        float qx = ax + t * dx;
        float qy = ay + t * dy;
        float ex = px - qx;
        float ey = py - qy;
        *outT = t;
        *outDist = sqrtf(ex * ex + ey * ey);
    }

    // Pulse used for the active waypoint marker.
    static float PulseWave(float phase)
    {
        return 0.5f + 0.5f * sinf(phase * 6.2831853f);
    }
}

CWeaponCraftOverlay::CWeaponCraftOverlay()
    : m_mode(MODE_HIDDEN)
    , m_anim(0.0f)
    , m_closeAnim(0.0f)
    , m_spring(0)
    , m_iron(0)
    , m_scrap(0)
    , m_gunpowder(0)
    , m_wood(0)
    , m_selectedWeapon(0)
    , m_currentSeg(0)
    , m_progress(0.0f)
    , m_mistakes(0)
    , m_maxMistakes(5)
    , m_lastDown(false)
    , m_mistakeCooldown(0.0f)
    , m_mistakeFlash(0.0f)
    , m_walkPhase(0.0f)
    , m_lastFingerX(-1.0f)
    , m_lastFingerY(-1.0f)
    , m_progressPct(0)
    , m_progressShownT(0.0f)
    , m_progressLastUpdateT(0.0f)
    , m_progressDisplayPct(0.0f)
    , m_doneTimer(0.0f)
    , m_doneCelebrate(0.0f)
    , m_statusTimer(0.0f)
{
    m_statusText[0] = '\0';
}

CWeaponCraftOverlay::~CWeaponCraftOverlay() {}

void CWeaponCraftOverlay::SendCommand(const char* cmd)
{
    if (cmd && cmd[0]) Inventory_SendChatCommand(cmd);
    if (pGUI) pGUI->ResetTouchState();
}

void CWeaponCraftOverlay::ShowList(int spring, int iron, int scrap, int gunpowder, int wood)
{
    m_spring    = spring;
    m_iron      = iron;
    m_scrap     = scrap;
    m_gunpowder = gunpowder;
    m_wood      = wood;
    if (m_mode != MODE_LIST) m_anim = 0.0f;
    m_mode = MODE_LIST;
    m_closeAnim = 0.0f;
    m_lastDown = false;
    m_statusTimer = 0.0f;
    m_statusText[0] = '\0';
    if (pGUI) pGUI->ResetTouchState();
}

void CWeaponCraftOverlay::ShowProgress(int percent)
{
    if (percent < 0) percent = 0;
    if (percent > 100) percent = 100;
    m_progressPct = percent;
    if (m_mode != MODE_PROGRESS)
    {
        m_anim = 0.0f;
        m_progressShownT = 0.0f;
        m_progressDisplayPct = 0.0f;
    }
    m_mode = MODE_PROGRESS;
    m_closeAnim = 0.0f;
    m_lastDown = false;
    m_progressLastUpdateT = 0.0f;
    if (pGUI) pGUI->ResetTouchState();
}

void CWeaponCraftOverlay::ShowDone()
{
    // Idempotent: a server-side ~CRAFT_UI~DONE may arrive shortly after the
    // client has already self-promoted to MODE_DONE.  Don't restart the
    // celebration animation in that case — it would cause a visible blink.
    if (m_mode == MODE_DONE) return;
    m_anim = 0.0f;
    m_mode = MODE_DONE;
    m_closeAnim = 0.0f;
    m_progressPct = 100;
    m_progressDisplayPct = 100.0f;
    m_doneTimer = 2.6f;     // auto-hide after celebration
    m_doneCelebrate = 0.0f;
    m_lastDown = false;
    if (pGUI) pGUI->ResetTouchState();
}

void CWeaponCraftOverlay::Hide()
{
    m_mode = MODE_HIDDEN;
    m_anim = 0.0f;
    m_closeAnim = 0.0f;
    m_lastDown = false;
    m_statusTimer = 0.0f;
    m_statusText[0] = '\0';
    m_doneTimer = 0.0f;
    m_doneCelebrate = 0.0f;
    m_progressDisplayPct = 0.0f;
    m_progressLastUpdateT = 0.0f;
    if (pGUI) pGUI->ResetTouchState();
}

void CWeaponCraftOverlay::StartTrace(int weaponId)
{
    m_selectedWeapon = weaponId;
    m_mode = MODE_TRACE;
    m_anim = 0.0f;
    m_currentSeg = 0;
    m_progress = 0.0f;
    m_mistakes = 0;
    m_lastDown = false;
    m_mistakeCooldown = 0.0f;
    m_mistakeFlash = 0.0f;
    m_walkPhase = 0.0f;
    m_lastFingerX = -1.0f;
    m_lastFingerY = -1.0f;
    if (pGUI) pGUI->ResetTouchState();
}

void CWeaponCraftOverlay::RegisterMistake()
{
    if (m_mistakeCooldown > 0.0f) return;
    if (m_mistakes >= m_maxMistakes) return;
    m_mistakes++;
    m_mistakeCooldown = 0.55f;
    m_mistakeFlash = 1.0f;

    if (m_mistakes >= m_maxMistakes)
    {
        // Failed.  Reset to LIST after a short delay; meanwhile show banner.
        snprintf(m_statusText, sizeof(m_statusText),
                 "%s",
                 "فشل التصنيع! اخرجت من الحدود اكثر من 5 مرات");
        m_statusTimer = 2.6f;
        SendCommand("/craft_close");
        m_mode = MODE_LIST;
        m_anim = 0.0f;
    }
}

void CWeaponCraftOverlay::OnTraceCompleted()
{
    char cmd[64];
    snprintf(cmd, sizeof(cmd), "/craft_done %d", m_selectedWeapon);
    SendCommand(cmd);
    // Server will follow up with ~CRAFT_UI~PROG|... messages.  Show a 0%
    // overlay immediately so the player sees instant feedback.
    ShowProgress(0);
}

// ----------------------------------------------------------------------
//  Backdrop (vignette + soft particles) used behind every mode.
// ----------------------------------------------------------------------
void CWeaponCraftOverlay::RenderBackdrop(ImDrawList* dl, float w, float h, float t)
{
    // Full-screen scrim.
    dl->AddRectFilled(ImVec2(0, 0), ImVec2(w, h), kColScrim);
    // Top/bottom vignette accents.
    dl->AddRectFilledMultiColor(ImVec2(0, 0), ImVec2(w, h * 0.32f),
        IM_COL32(0, 0, 0, (int)(180 * t)), IM_COL32(0, 0, 0, (int)(180 * t)),
        IM_COL32(0, 0, 0, 0), IM_COL32(0, 0, 0, 0));
    dl->AddRectFilledMultiColor(ImVec2(0, h * 0.68f), ImVec2(w, h),
        IM_COL32(0, 0, 0, 0), IM_COL32(0, 0, 0, 0),
        IM_COL32(0, 0, 0, (int)(190 * t)), IM_COL32(0, 0, 0, (int)(190 * t)));
}

// ======================================================================
//  Master Render dispatcher.  Heavily defensive: refuses to draw anything
//  if the ImGui context is not yet ready (e.g. while the menu is still
//  initialising), since touching ImDrawList vertex buffers before NewFrame
//  has been called crashes deep inside PrimReserve on ARM.
// ======================================================================
void CWeaponCraftOverlay::Render()
{
    if (m_mode == MODE_HIDDEN) return;

    // Bail out if ImGui isn't ready for drawing yet.  The very first frame
    // after the launcher loads can fire ClientMessage / Render before NewFrame
    // has produced a valid OverlayDrawList; in that state CmdBuffer.Size is 0
    // and PrimReserve scribbles past the head of the array, taking the
    // process down at the next vertex write.  Skipping a frame is cheap.
    if (!ImGui::GetCurrentContext()) return;
    if (ImGui::GetFrameCount() <= 0) return;
    ImDrawList* probe = ImGui::GetOverlayDrawList();
    if (!probe || probe->CmdBuffer.Size <= 0) return;

    ImGuiIO& io = ImGui::GetIO();
    float dt = io.DeltaTime;
    if (dt < 0.0f) dt = 0.0f;
    if (dt > 0.1f) dt = 0.1f;

    // Anim ramp + cooldowns.
    if (m_anim < 1.0f) { m_anim += dt * 4.0f; if (m_anim > 1.0f) m_anim = 1.0f; }
    if (m_mistakeCooldown > 0.0f) { m_mistakeCooldown -= dt; if (m_mistakeCooldown < 0.0f) m_mistakeCooldown = 0.0f; }
    if (m_mistakeFlash > 0.0f)    { m_mistakeFlash -= dt * 1.6f; if (m_mistakeFlash < 0.0f) m_mistakeFlash = 0.0f; }
    if (m_statusTimer > 0.0f)     { m_statusTimer -= dt; if (m_statusTimer < 0.0f) m_statusTimer = 0.0f; }
    m_walkPhase += dt;
    if (m_walkPhase > 1000.0f) m_walkPhase -= 1000.0f;

    if (m_mode == MODE_PROGRESS)
    {
        m_progressShownT += dt;
        m_progressLastUpdateT += dt;

        // ====================================================================
        // Self-driving progress.  The server pushes ~CRAFT_UI~PROG|N pulses
        // at 250/700/1300/1900/2500 ms (see arabonline.pwn), but if those
        // packets get dropped, throttled, or the server-side timer chain
        // stalls, the player would otherwise be stuck staring at "0%".  We
        // therefore animate a baseline 0→97% over 3 seconds purely on the
        // client.  The visible target is max(server pct, time-based pct),
        // so a fast server still leapfrogs ahead — but a silent server can
        // never freeze the bar.
        // ====================================================================
        float timeBasedPct = (m_progressShownT / 3.0f) * 97.0f;
        if (timeBasedPct < 0.0f)  timeBasedPct = 0.0f;
        if (timeBasedPct > 97.0f) timeBasedPct = 97.0f;
        float target = (float)m_progressPct;
        if (timeBasedPct > target) target = timeBasedPct;
        if (target > 100.0f) target = 100.0f;

        float diff = target - m_progressDisplayPct;
        if (diff > 0.05f) m_progressDisplayPct += diff * (1.0f - expf(-dt * 7.0f));
        else              m_progressDisplayPct = target;

        // Auto-transition to DONE once the bar finishes filling.  Server's
        // explicit ~CRAFT_UI~DONE will still arrive and is harmless because
        // ShowDone() is idempotent in MODE_DONE.
        if (m_progressShownT >= 3.4f || m_progressDisplayPct >= 99.5f)
        {
            ShowDone();
        }
    }
    if (m_mode == MODE_DONE)
    {
        m_doneCelebrate += dt;
        if (m_doneTimer > 0.0f)
        {
            m_doneTimer -= dt;
            if (m_doneTimer <= 0.0f)
            {
                Hide();
                return;
            }
        }
    }

    // Block GTA input while overlay is visible.
    io.WantCaptureMouse = true;

    // ====================================================================
    // CRITICAL — DO NOT re-introduce ImGui::Push*StyleVar / Begin / End
    // here.  jni/Android.mk compiles the launcher with `-fpack-struct=1`
    // which packs *every* C/C++ struct on a 1-byte boundary.  That makes
    // the float fields inside ImGui::g.Style unaligned, and ImGui's
    // PushStyleVar(int, float) does `*(float*)pvar = val;` which generates
    // a SIGBUS on ARMv7 (Redmi/lake) the very first time the overlay tries
    // to push a style.  All other overlays in the project draw through
    // GetOverlayDrawList() with NO Begin/End and don't trip this — that's
    // why only the crafting pickup crashed.  We do the same here.
    // ====================================================================
    switch (m_mode)
    {
    case MODE_LIST:     RenderList();     break;
    case MODE_TRACE:    RenderTrace();    break;
    case MODE_PROGRESS: RenderProgress(); break;
    case MODE_DONE:     RenderDone();     break;
    default: break;
    }
}

// ======================================================================
//  MODE_LIST: stylish weapon catalogue (currently RPG only).
// ======================================================================
void CWeaponCraftOverlay::RenderList()
{
    ImGuiIO& io = ImGui::GetIO();
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    float dw = io.DisplaySize.x;
    float dh = io.DisplaySize.y;
    float t  = EaseOut(m_anim);

    RenderBackdrop(dl, dw, dh, t);

    // Center panel.
    float pw = Clampf(dw * 0.74f, 600.0f, 1200.0f);
    float ph = Clampf(dh * 0.78f, 360.0f,  800.0f);
    float px = (dw - pw) * 0.5f;
    float py = (dh - ph) * 0.5f - dh * 0.02f;
    py += (1.0f - t) * 30.0f;

    // Outer drop shadow.
    dl->AddRectFilled(ImVec2(px - 6, py - 6), ImVec2(px + pw + 6, py + ph + 6),
                      IM_COL32(0, 0, 0, (int)(170 * t)), 22.0f);
    dl->AddRectFilled(ImVec2(px, py), ImVec2(px + pw, py + ph),
                      IM_COL32(18, 21, 30, (int)(248 * t)), 18.0f);
    dl->AddRect(ImVec2(px, py), ImVec2(px + pw, py + ph),
                IM_COL32(255, 195, 76, (int)(220 * t)), 18.0f, 0, 2.4f);

    // Header strip.
    float hh = 64.0f;
    dl->AddRectFilledMultiColor(
        ImVec2(px + 1, py + 1), ImVec2(px + pw - 1, py + hh),
        IM_COL32(46, 32, 14, (int)(230 * t)), IM_COL32(70, 48, 20, (int)(230 * t)),
        IM_COL32(70, 48, 20, (int)(230 * t)), IM_COL32(46, 32, 14, (int)(230 * t)));
    dl->AddRectFilled(ImVec2(px + 1, py + hh - 2), ImVec2(px + pw - 1, py + hh),
                      IM_COL32(255, 195, 76, (int)(255 * t)));

    // Title.
    ImFont* font = pGUI ? pGUI->GetFont() : ImGui::GetFont();
    if (!font) font = ImGui::GetFont();
    float fs = pGUI ? (pGUI->GetFontSize() * 1.25f) : 22.0f;
    {
        std::string title = Shape("طاولة تصنيع الأسلحة");
        ImVec2 ts = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, title.c_str());
        dl->AddText(font, fs,
                    ImVec2(px + (pw - ts.x) * 0.5f, py + (hh - ts.y) * 0.5f),
                    IM_COL32(255, 255, 255, (int)(255 * t)),
                    title.c_str());
    }

    // Materials strip just under the header.
    float msY = py + hh + 12.0f;
    float msH = 64.0f;
    dl->AddRectFilled(ImVec2(px + 16, msY), ImVec2(px + pw - 16, msY + msH),
                      IM_COL32(11, 13, 20, (int)(220 * t)), 12.0f);
    dl->AddRect(ImVec2(px + 16, msY), ImVec2(px + pw - 16, msY + msH),
                IM_COL32(255, 195, 76, (int)(120 * t)), 12.0f, 0, 1.2f);

    struct Mat { const char* label; int have; int need; };
    Mat mats[] = {
        { "زنبرك", m_spring,    5 },
        { "حديد",  m_iron,      7 },
        { "خردة",  m_scrap,     3 },
        { "بارود", m_gunpowder, 6 },
        { "خشب",   m_wood,     10 },
    };
    int nm = (int)(sizeof(mats) / sizeof(mats[0]));
    float mw = (pw - 32.0f) / (float)nm;
    float mfs = pGUI ? pGUI->GetFontSize() : 16.0f;
    for (int i = 0; i < nm; ++i)
    {
        float mx = px + 16.0f + mw * i;
        float my = msY;
        bool ok = mats[i].have >= mats[i].need;
        ImU32 col = ok ? kColGreen : kColRed;
        char buf[64];
        snprintf(buf, sizeof(buf), "%d / %d", mats[i].have, mats[i].need);
        std::string lbl = Shape(mats[i].label);
        ImVec2 ls = font->CalcTextSizeA(mfs * 0.95f, FLT_MAX, 0.0f, lbl.c_str());
        ImVec2 vs = font->CalcTextSizeA(mfs * 1.05f, FLT_MAX, 0.0f, buf);

        dl->AddText(font, mfs * 0.95f,
                    ImVec2(mx + (mw - ls.x) * 0.5f, my + 8.0f),
                    kColTextDim, lbl.c_str());
        dl->AddText(font, mfs * 1.05f,
                    ImVec2(mx + (mw - vs.x) * 0.5f, my + msH - vs.y - 8.0f),
                    col, buf);
    }

    // Weapon list rows.
    struct Wpn { int id; const char* name; const char* desc; };
    Wpn weapons[] = {
        { 1, "RPG", "صاروخ موجه — قاذف مضاد للمركبات" },
    };
    int nw = (int)(sizeof(weapons) / sizeof(weapons[0]));

    float listY = msY + msH + 18.0f;
    float listH = (py + ph) - listY - 80.0f;
    float rowH  = 86.0f;
    float rowGap = 10.0f;

    for (int i = 0; i < nw; ++i)
    {
        float ry = listY + i * (rowH + rowGap);
        if (ry + rowH > listY + listH) break;
        float rx = px + 22.0f;
        float rw = pw - 44.0f;

        // Row background.
        dl->AddRectFilledMultiColor(
            ImVec2(rx, ry), ImVec2(rx + rw, ry + rowH),
            IM_COL32(28, 24, 16, (int)(240 * t)), IM_COL32(40, 32, 18, (int)(240 * t)),
            IM_COL32(40, 32, 18, (int)(240 * t)), IM_COL32(28, 24, 16, (int)(240 * t)));
        dl->AddRect(ImVec2(rx, ry), ImVec2(rx + rw, ry + rowH),
                    IM_COL32(255, 195, 76, (int)(180 * t)), 10.0f, 0, 1.6f);

        // Icon panel on the left.
        float ipW = 96.0f;
        // Soft shadow under the icon panel.
        dl->AddRectFilled(ImVec2(rx + 10, ry + 12), ImVec2(rx + 10 + ipW, ry + rowH - 6),
                          IM_COL32(0, 0, 0, (int)(140 * t)), 10.0f);
        dl->AddRectFilled(ImVec2(rx + 8, ry + 8), ImVec2(rx + 8 + ipW, ry + rowH - 8),
                          IM_COL32(11, 13, 20, (int)(255 * t)), 10.0f);
        dl->AddRect(ImVec2(rx + 8, ry + 8), ImVec2(rx + 8 + ipW, ry + rowH - 8),
                    IM_COL32(255, 195, 76, (int)(180 * t)), 10.0f, 0, 1.4f);

        // Subtle inner glow on the icon panel.
        dl->AddRectFilledMultiColor(ImVec2(rx + 10, ry + 10), ImVec2(rx + 8 + ipW - 2, ry + rowH - 10),
            IM_COL32(255, 195, 76, (int)(36 * t)), IM_COL32(255, 195, 76, (int)(8 * t)),
            IM_COL32(255, 195, 76, (int)(8 * t)), IM_COL32(255, 195, 76, (int)(36 * t)));

        // RPG icon — embedded rpg.png; falls back to vector glyph if the
        // texture failed to upload.
        float iconCx = rx + 8 + ipW * 0.5f;
        float iconCy = ry + rowH * 0.5f;
        void* icon_tex = nullptr;
        int   icon_tw = 0, icon_th = 0;
        float icon_tu = 1.0f, icon_tv = 1.0f;
        bool haveIcon = WeaponCraftTex::GetWeaponIcon(&icon_tex, &icon_tw, &icon_th, &icon_tu, &icon_tv) && icon_tex;
        if (haveIcon && icon_tw > 0 && icon_th > 0)
        {
            float boxW = ipW - 18.0f;
            float boxH = rowH - 22.0f;
            float ar = (float)icon_tw / (float)icon_th;
            float fitW = boxW;
            float fitH = boxW / ar;
            if (fitH > boxH) { fitH = boxH; fitW = boxH * ar; }
            float ix = iconCx - fitW * 0.5f;
            float iy = iconCy - fitH * 0.5f;
            dl->AddImage((ImTextureID)icon_tex,
                         ImVec2(ix, iy), ImVec2(ix + fitW, iy + fitH),
                         ImVec2(0.0f, 0.0f), ImVec2(icon_tu, icon_tv),
                         IM_COL32(255, 230, 160, (int)(255 * t)));
        }
        else
        {
            float iconR = 26.0f;
            dl->AddRectFilled(ImVec2(iconCx - iconR, iconCy - 6), ImVec2(iconCx + iconR * 0.55f, iconCy + 6),
                              IM_COL32(255, 195, 76, (int)(255 * t)), 3.0f);
            ImVec2 tri[3] = {
                ImVec2(iconCx + iconR * 0.55f, iconCy - 12),
                ImVec2(iconCx + iconR * 0.55f, iconCy + 12),
                ImVec2(iconCx + iconR * 0.95f, iconCy)
            };
            dl->AddTriangleFilled(tri[0], tri[1], tri[2], IM_COL32(255, 173, 54, (int)(255 * t)));
            dl->AddRectFilled(ImVec2(iconCx - 2, iconCy + 6), ImVec2(iconCx + 6, iconCy + 18),
                              IM_COL32(190, 145, 60, (int)(255 * t)), 2.0f);
        }

        // Title + description (right-aligned in RTL fashion).
        std::string nameStr = Shape(weapons[i].name);
        std::string descStr = Shape(weapons[i].desc);
        float nfs = pGUI ? pGUI->GetFontSize() * 1.18f : 20.0f;
        float dfs = pGUI ? pGUI->GetFontSize() * 0.92f : 14.0f;
        ImVec2 ns = font->CalcTextSizeA(nfs, FLT_MAX, 0.0f, nameStr.c_str());
        ImVec2 ds = font->CalcTextSizeA(dfs, FLT_MAX, 0.0f, descStr.c_str());

        float tx = rx + 8 + ipW + 18.0f;
        dl->AddText(font, nfs, ImVec2(tx, ry + 12.0f), kColText, nameStr.c_str());
        dl->AddText(font, dfs, ImVec2(tx, ry + 12.0f + ns.y + 6.0f), kColTextDim, descStr.c_str());
        (void)ds;

        // Craft button on the right.
        float bw = 150.0f;
        float bh = rowH - 24.0f;
        float bx = rx + rw - bw - 12.0f;
        float by = ry + 12.0f;

        bool hover = io.MousePos.x >= bx && io.MousePos.x <= bx + bw &&
                     io.MousePos.y >= by && io.MousePos.y <= by + bh;
        bool down  = hover && io.MouseDown[0];
        bool clicked = hover && m_lastDown && !io.MouseDown[0];

        ImU32 btnTop = down ? IM_COL32(255, 173, 54, (int)(255 * t))
                            : (hover ? IM_COL32(255, 200,  90, (int)(255 * t))
                                     : IM_COL32(255, 173, 54, (int)(235 * t)));
        ImU32 btnBot = down ? IM_COL32(195, 130, 38, (int)(255 * t))
                            : (hover ? IM_COL32(228, 158, 50, (int)(255 * t))
                                     : IM_COL32(195, 130, 38, (int)(235 * t)));
        dl->AddRectFilledMultiColor(ImVec2(bx, by), ImVec2(bx + bw, by + bh),
            btnTop, btnTop, btnBot, btnBot);
        dl->AddRect(ImVec2(bx, by), ImVec2(bx + bw, by + bh),
                    IM_COL32(255, 230, 155, (int)(255 * t)), 8.0f, 0, 1.4f);

        std::string btnTxt = Shape("صنّع");
        float btnFs = pGUI ? pGUI->GetFontSize() * 1.15f : 18.0f;
        ImVec2 bts = font->CalcTextSizeA(btnFs, FLT_MAX, 0.0f, btnTxt.c_str());
        dl->AddText(font, btnFs,
                    ImVec2(bx + (bw - bts.x) * 0.5f, by + (bh - bts.y) * 0.5f),
                    IM_COL32(20, 14, 6, (int)(255 * t)), btnTxt.c_str());

        if (clicked)
        {
            char cmd[64];
            snprintf(cmd, sizeof(cmd), "/craft_pick %d", weapons[i].id);
            SendCommand(cmd);
            // Server validates materials; if OK we will receive ~CRAFT_UI~OPEN
            // again with same data and proceed locally to the trace minigame.
            // To avoid waiting for the server roundtrip when the materials are
            // already known, we start the minigame locally if we can.
            bool haveAll = m_spring >= 5 && m_iron >= 7 && m_scrap >= 3 &&
                           m_gunpowder >= 6 && m_wood >= 10;
            if (haveAll)
            {
                StartTrace(weapons[i].id);
            }
            else
            {
                snprintf(m_statusText, sizeof(m_statusText),
                         "%s",
                         "ما معك موارد كافية لتصنيع السلاح!");
                m_statusTimer = 3.0f;
            }
        }
    }

    // Bottom: status banner + close button.
    float bbY = py + ph - 64.0f;
    if (m_statusTimer > 0.0f && m_statusText[0])
    {
        std::string st = Shape(m_statusText);
        float sfs = pGUI ? pGUI->GetFontSize() * 1.05f : 16.0f;
        ImVec2 sts = font->CalcTextSizeA(sfs, FLT_MAX, 0.0f, st.c_str());
        float tile_w = sts.x + 36.0f;
        float tile_h = sts.y + 18.0f;
        float tile_x = px + (pw - tile_w) * 0.5f;
        float tile_y = bbY - tile_h - 6.0f;
        float fade = m_statusTimer > 0.4f ? 1.0f : (m_statusTimer / 0.4f);
        dl->AddRectFilled(ImVec2(tile_x, tile_y), ImVec2(tile_x + tile_w, tile_y + tile_h),
                          IM_COL32(35, 12, 14, (int)(245 * fade)), 10.0f);
        dl->AddRect(ImVec2(tile_x, tile_y), ImVec2(tile_x + tile_w, tile_y + tile_h),
                    IM_COL32(232, 72, 85, (int)(255 * fade)), 10.0f, 0, 1.6f);
        dl->AddText(font, sfs,
                    ImVec2(tile_x + (tile_w - sts.x) * 0.5f, tile_y + (tile_h - sts.y) * 0.5f),
                    IM_COL32(255, 240, 240, (int)(255 * fade)), st.c_str());
    }

    {
        // Close button.
        float cw = 160.0f, ch = 42.0f;
        float cx = px + (pw - cw) * 0.5f;
        float cy = py + ph - ch - 14.0f;
        bool hover = io.MousePos.x >= cx && io.MousePos.x <= cx + cw &&
                     io.MousePos.y >= cy && io.MousePos.y <= cy + ch;
        bool down  = hover && io.MouseDown[0];
        bool clicked = hover && m_lastDown && !io.MouseDown[0];
        dl->AddRectFilled(ImVec2(cx, cy), ImVec2(cx + cw, cy + ch),
            down ? IM_COL32(45, 18, 22, 255) : IM_COL32(60, 24, 30, 255), 10.0f);
        dl->AddRect(ImVec2(cx, cy), ImVec2(cx + cw, cy + ch),
                    IM_COL32(232, 72, 85, hover ? 255 : 200), 10.0f, 0, 1.4f);
        std::string cstr = Shape("إغلاق");
        float cfs = pGUI ? pGUI->GetFontSize() * 1.08f : 17.0f;
        ImVec2 cts = font->CalcTextSizeA(cfs, FLT_MAX, 0.0f, cstr.c_str());
        dl->AddText(font, cfs,
                    ImVec2(cx + (cw - cts.x) * 0.5f, cy + (ch - cts.y) * 0.5f),
                    kColText, cstr.c_str());
        if (clicked)
        {
            SendCommand("/craft_close");
            Hide();
        }
    }

    m_lastDown = io.MouseDown[0];
}

// ======================================================================
//  MODE_TRACE: full-screen image + border-trace minigame.
// ======================================================================
void CWeaponCraftOverlay::RenderTrace()
{
    ImGuiIO& io = ImGui::GetIO();
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    float dw = io.DisplaySize.x;
    float dh = io.DisplaySize.y;
    float t  = EaseOut(m_anim);

    // Solid black backdrop (the image is the focus).
    dl->AddRectFilled(ImVec2(0, 0), ImVec2(dw, dh), IM_COL32(0, 0, 0, 255));

    // Compute trace area: full screen with a small margin so the HUD has
    // breathing room.  We then fit the minigame image inside the area while
    // preserving aspect ratio (letterboxed).
    float marginX = 0.0f;
    float marginYTop = 64.0f;     // reserves space for the top HUD strip
    float marginYBot = 72.0f;     // reserves space for the bottom HUD strip
    float ax = marginX;
    float ay = marginYTop;
    float aw = dw - 2.0f * marginX;
    float ah = dh - marginYTop - marginYBot;
    if (aw < 100.0f) aw = 100.0f;
    if (ah < 100.0f) ah = 100.0f;

    // Try to draw the embedded minigame image, scaled to fill the area.
    void* tex = nullptr;
    int   tw = 0, th = 0;
    float tu = 1.0f, tv = 1.0f;
    bool haveTex = WeaponCraftTex::GetMinigameImage(&tex, &tw, &th, &tu, &tv) && tex;

    float imgX = ax, imgY = ay, imgW = aw, imgH = ah;
    if (haveTex && tw > 0 && th > 0)
    {
        float ar = (float)tw / (float)th;
        float fitW = aw;
        float fitH = aw / ar;
        if (fitH > ah) { fitH = ah; fitW = ah * ar; }
        imgX = ax + (aw - fitW) * 0.5f;
        imgY = ay + (ah - fitH) * 0.5f;
        imgW = fitW;
        imgH = fitH;

        dl->AddImage((ImTextureID)tex,
                     ImVec2(imgX, imgY), ImVec2(imgX + imgW, imgY + imgH),
                     ImVec2(0.0f, 0.0f), ImVec2(tu, tv),
                     IM_COL32(255, 255, 255, (int)(255 * t)));
    }
    else
    {
        // Fallback gradient if the texture failed to decode.
        dl->AddRectFilledMultiColor(ImVec2(imgX, imgY), ImVec2(imgX + imgW, imgY + imgH),
            IM_COL32(20, 20, 28, 255), IM_COL32(34, 34, 44, 255),
            IM_COL32(34, 34, 44, 255), IM_COL32(20, 20, 28, 255));
    }

    // -----------------------------------------------------------------
    //  Border-trace logic.  All coordinates are computed in absolute
    //  screen space (imgX..imgX+imgW, imgY..imgY+imgH).
    // -----------------------------------------------------------------
    auto NormToScreen = [&](float nx, float ny, float* outX, float* outY) {
        *outX = imgX + nx * imgW;
        *outY = imgY + ny * imgH;
    };

    // Draw all path segments.  Already-traced segments are bright yellow,
    // upcoming ones are dim, the active segment glows.
    float strokeW = imgW * 0.018f;
    if (strokeW < 8.0f) strokeW = 8.0f;
    if (strokeW > 22.0f) strokeW = 22.0f;

    for (int s = 0; s < kSegmentCount; ++s)
    {
        float ax0, ay0, bx0, by0;
        NormToScreen(kPath[s].x,     kPath[s].y,     &ax0, &ay0);
        NormToScreen(kPath[s + 1].x, kPath[s + 1].y, &bx0, &by0);

        if (s < m_currentSeg)
        {
            // Already done - bright yellow with a subtle glow.
            dl->AddLine(ImVec2(ax0, ay0), ImVec2(bx0, by0),
                        IM_COL32(255, 230, 110, (int)(255 * t)), strokeW);
            dl->AddLine(ImVec2(ax0, ay0), ImVec2(bx0, by0),
                        IM_COL32(255, 255, 200, (int)(180 * t)), strokeW * 0.45f);
        }
        else if (s == m_currentSeg)
        {
            // Active segment - very bright yellow, partial fill from progress.
            float dxs = bx0 - ax0, dys = by0 - ay0;
            float pcx = ax0 + dxs * m_progress;
            float pcy = ay0 + dys * m_progress;
            // Faint guide for the entire segment.
            dl->AddLine(ImVec2(ax0, ay0), ImVec2(bx0, by0),
                        IM_COL32(255, 218, 68, (int)(180 * t)), strokeW);
            // Bright filled portion up to current progress.
            dl->AddLine(ImVec2(ax0, ay0), ImVec2(pcx, pcy),
                        IM_COL32(255, 255, 130, (int)(255 * t)), strokeW * 1.05f);
            // Glow halo on the active segment.
            float pulse = 0.5f + 0.5f * sinf(m_walkPhase * 7.0f);
            dl->AddLine(ImVec2(ax0, ay0), ImVec2(bx0, by0),
                        IM_COL32(255, 218, 68, (int)(70 * pulse * t)), strokeW * 2.4f);
        }
        else
        {
            // Not yet reached.
            dl->AddLine(ImVec2(ax0, ay0), ImVec2(bx0, by0),
                        IM_COL32(255, 218, 68, (int)(105 * t)), strokeW * 0.9f);
        }
    }

    // Draw waypoints as numbered circles.
    for (int i = 0; i < kPathCount; ++i)
    {
        float ax0, ay0;
        NormToScreen(kPath[i].x, kPath[i].y, &ax0, &ay0);
        bool active = (i == m_currentSeg + 1);
        bool done   = (i <= m_currentSeg);
        float r = active ? strokeW * 1.2f : strokeW * 0.85f;
        ImU32 ringCol  = done ? IM_COL32(255, 255, 130, (int)(255 * t))
                              : IM_COL32(255, 218,  68, (int)(220 * t));
        ImU32 fillCol  = done ? IM_COL32( 36,  28,  10, (int)(255 * t))
                              : IM_COL32( 18,  16,  10, (int)(240 * t));
        dl->AddCircleFilled(ImVec2(ax0, ay0), r, fillCol, 22);
        dl->AddCircle(ImVec2(ax0, ay0), r, ringCol, 22, 2.4f);
        if (active)
        {
            float pulse = 0.4f + 0.6f * PulseWave(m_walkPhase * 1.6f);
            dl->AddCircle(ImVec2(ax0, ay0), r + 6.0f + pulse * 8.0f,
                          IM_COL32(255, 218, 68, (int)(220 * pulse * t)), 28, 2.0f);
        }
    }

    // -----------------------------------------------------------------
    //  Touch handling: project finger onto current segment.
    // -----------------------------------------------------------------
    bool down = io.MouseDown[0];
    float fx = io.MousePos.x;
    float fy = io.MousePos.y;
    bool fingerInArea = fx >= imgX && fx <= imgX + imgW &&
                        fy >= imgY && fy <= imgY + imgH;
    bool justPressed = down && !m_lastDown;

    if (m_currentSeg < kSegmentCount && down && fingerInArea)
    {
        float ax0, ay0, bx0, by0;
        NormToScreen(kPath[m_currentSeg].x,     kPath[m_currentSeg].y,     &ax0, &ay0);
        NormToScreen(kPath[m_currentSeg + 1].x, kPath[m_currentSeg + 1].y, &bx0, &by0);

        float t01 = 0.0f;
        float dist = 0.0f;
        ProjectOnSegment(ax0, ay0, bx0, by0, fx, fy, &t01, &dist);

        // Tolerance scales with stroke width.
        float tol = strokeW * 1.85f;

        if (justPressed && t01 < 0.05f && dist <= tol)
        {
            // Player started the segment near its start - good.
            m_progress = 0.0f;
        }

        if (dist > tol)
        {
            RegisterMistake();
        }
        else
        {
            // Only allow forward progress (no rewinding).
            if (t01 > m_progress) m_progress = t01;
            // Snap to completion when very close to the next waypoint.
            if (m_progress >= 0.96f)
            {
                m_currentSeg++;
                m_progress = 0.0f;
                if (m_currentSeg >= kSegmentCount)
                {
                    OnTraceCompleted();
                    m_lastDown = down;
                    return;
                }
            }
        }
    }

    if (!down && m_lastDown && m_currentSeg < kSegmentCount && m_progress < 0.94f)
    {
        // Lifted finger mid-segment: rewind a bit so the player has to redo
        // the last leg, but don't penalize with mistake.
        m_progress = m_progress * 0.5f;
    }

    m_lastFingerX = fx;
    m_lastFingerY = fy;

    // -----------------------------------------------------------------
    //  Walking-trace head: pulsing yellow ball that sits at the player's
    //  current progress along the active segment.
    // -----------------------------------------------------------------
    if (m_currentSeg < kSegmentCount)
    {
        float ax0, ay0, bx0, by0;
        NormToScreen(kPath[m_currentSeg].x,     kPath[m_currentSeg].y,     &ax0, &ay0);
        NormToScreen(kPath[m_currentSeg + 1].x, kPath[m_currentSeg + 1].y, &bx0, &by0);
        float hx = ax0 + (bx0 - ax0) * m_progress;
        float hy = ay0 + (by0 - ay0) * m_progress;
        float pulse = 0.5f + 0.5f * sinf(m_walkPhase * 6.0f);
        dl->AddCircleFilled(ImVec2(hx, hy), strokeW * 1.05f,
                            IM_COL32(255, 255, 220, (int)(255 * t)), 22);
        dl->AddCircle(ImVec2(hx, hy), strokeW * (1.6f + pulse * 0.6f),
                      IM_COL32(255, 230, 130, (int)(180 * t)), 24, 2.4f);
        // Walking footprint trail behind the head.
        for (int k = 1; k <= 3; ++k)
        {
            float kt = (float)k * 0.18f;
            float bxk = hx - (bx0 - ax0) * kt * 0.05f;
            float byk = hy - (by0 - ay0) * kt * 0.05f;
            dl->AddCircleFilled(ImVec2(bxk, byk), strokeW * 0.55f * (1.0f - kt),
                                IM_COL32(255, 218, 68, (int)(120 * (1.0f - kt) * t)), 18);
        }
    }

    // -----------------------------------------------------------------
    //  Top HUD strip: title + mistake counter + close button.
    // -----------------------------------------------------------------
    ImFont* font = pGUI ? pGUI->GetFont() : ImGui::GetFont();
    if (!font) font = ImGui::GetFont();
    float fs   = pGUI ? pGUI->GetFontSize() * 1.05f : 17.0f;
    float bigF = pGUI ? pGUI->GetFontSize() * 1.30f : 22.0f;

    // Top strip background.
    dl->AddRectFilled(ImVec2(0, 0), ImVec2(dw, marginYTop),
                      IM_COL32(8, 10, 14, (int)(220 * t)));
    dl->AddRectFilled(ImVec2(0, marginYTop - 2), ImVec2(dw, marginYTop),
                      IM_COL32(255, 195, 76, (int)(220 * t)));

    {
        std::string title = Shape("ارسم الحدود الصفراء — التصنيع");
        ImVec2 ts = font->CalcTextSizeA(bigF, FLT_MAX, 0.0f, title.c_str());
        dl->AddText(font, bigF,
                    ImVec2((dw - ts.x) * 0.5f, (marginYTop - ts.y) * 0.5f),
                    IM_COL32(255, 255, 255, (int)(255 * t)), title.c_str());
    }

    // Mistake counter on the right (red squares).
    {
        float chipR = 14.0f;
        float chipGap = 10.0f;
        float chipsW = m_maxMistakes * (chipR * 2.0f) + (m_maxMistakes - 1) * chipGap;
        float startX = dw - 24.0f - chipsW;
        float cy = marginYTop * 0.5f;
        std::string mlbl = Shape("الأخطاء");
        ImVec2 mls = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, mlbl.c_str());
        dl->AddText(font, fs,
                    ImVec2(startX - mls.x - 14.0f, cy - mls.y * 0.5f),
                    kColTextDim, mlbl.c_str());
        for (int i = 0; i < m_maxMistakes; ++i)
        {
            float cx = startX + i * (chipR * 2.0f + chipGap) + chipR;
            bool used = i < m_mistakes;
            ImU32 fill = used ? kColRed : IM_COL32(40, 28, 32, (int)(220 * t));
            ImU32 ring = used ? IM_COL32(255, 130, 140, 255) : kColRedDim;
            dl->AddCircleFilled(ImVec2(cx, cy), chipR, fill, 22);
            dl->AddCircle(ImVec2(cx, cy), chipR, ring, 22, 1.6f);
            // X mark inside used chips.
            if (used)
            {
                float r = chipR * 0.45f;
                dl->AddLine(ImVec2(cx - r, cy - r), ImVec2(cx + r, cy + r),
                            IM_COL32(255, 240, 240, 255), 2.2f);
                dl->AddLine(ImVec2(cx - r, cy + r), ImVec2(cx + r, cy - r),
                            IM_COL32(255, 240, 240, 255), 2.2f);
            }
        }

        // Mistake flash overlay.
        if (m_mistakeFlash > 0.0f)
        {
            ImU32 flash = IM_COL32(232, 72, 85, (int)(180 * m_mistakeFlash));
            dl->AddRect(ImVec2(0, 0), ImVec2(dw, dh), flash, 0.0f, 0, 16.0f);
        }
    }

    // Close button (top-left).
    {
        float cw = 110.0f, ch = marginYTop - 14.0f;
        float cx = 14.0f;
        float cy = 7.0f;
        bool hover = io.MousePos.x >= cx && io.MousePos.x <= cx + cw &&
                     io.MousePos.y >= cy && io.MousePos.y <= cy + ch;
        bool clicked = hover && m_lastDown && !io.MouseDown[0];
        dl->AddRectFilled(ImVec2(cx, cy), ImVec2(cx + cw, cy + ch),
            hover ? IM_COL32(70, 28, 34, 255) : IM_COL32(48, 22, 28, 255), 8.0f);
        dl->AddRect(ImVec2(cx, cy), ImVec2(cx + cw, cy + ch),
                    IM_COL32(232, 72, 85, hover ? 255 : 200), 8.0f, 0, 1.4f);
        std::string cstr = Shape("خروج");
        ImVec2 cts = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, cstr.c_str());
        dl->AddText(font, fs,
                    ImVec2(cx + (cw - cts.x) * 0.5f, cy + (ch - cts.y) * 0.5f),
                    kColText, cstr.c_str());
        if (clicked)
        {
            SendCommand("/craft_close");
            Hide();
            return;
        }
    }

    // -----------------------------------------------------------------
    //  Bottom HUD strip: progress bar showing how far around the path.
    // -----------------------------------------------------------------
    dl->AddRectFilled(ImVec2(0, dh - marginYBot), ImVec2(dw, dh),
                      IM_COL32(8, 10, 14, (int)(220 * t)));
    dl->AddRectFilled(ImVec2(0, dh - marginYBot), ImVec2(dw, dh - marginYBot + 2),
                      IM_COL32(255, 195, 76, (int)(220 * t)));

    float overall = ((float)m_currentSeg + m_progress) / (float)kSegmentCount;
    if (overall < 0.0f) overall = 0.0f;
    if (overall > 1.0f) overall = 1.0f;

    float bx = 28.0f;
    float by = dh - marginYBot + 26.0f;
    float bw = dw - 56.0f;
    float bh = 18.0f;
    dl->AddRectFilled(ImVec2(bx, by), ImVec2(bx + bw, by + bh),
                      IM_COL32(20, 22, 30, (int)(255 * t)), bh * 0.5f);
    dl->AddRectFilled(ImVec2(bx, by), ImVec2(bx + bw * overall, by + bh),
                      IM_COL32(255, 218, 68, (int)(255 * t)), bh * 0.5f);
    dl->AddRect(ImVec2(bx, by), ImVec2(bx + bw, by + bh),
                IM_COL32(255, 235, 150, (int)(165 * t)), bh * 0.5f, 0, 1.5f);

    {
        char buf[64]; snprintf(buf, sizeof(buf), "%d%%", (int)(overall * 100.0f));
        ImVec2 ts = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, buf);
        dl->AddText(font, fs,
                    ImVec2(bx + bw * 0.5f - ts.x * 0.5f, by - ts.y - 4.0f),
                    kColText, buf);
    }

    m_lastDown = io.MouseDown[0];
}

// ======================================================================
//  MODE_PROGRESS: 0..100% manufacturing animation.
// ======================================================================
void CWeaponCraftOverlay::RenderProgress()
{
    ImGuiIO& io = ImGui::GetIO();
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    float dw = io.DisplaySize.x;
    float dh = io.DisplaySize.y;
    float t  = EaseOut(m_anim);

    RenderBackdrop(dl, dw, dh, t);

    float pw = Clampf(dw * 0.62f, 540.0f, 980.0f);
    float ph = 240.0f;
    float px = (dw - pw) * 0.5f;
    float py = (dh - ph) * 0.5f - dh * 0.04f;
    py += (1.0f - t) * 30.0f;

    dl->AddRectFilled(ImVec2(px - 6, py - 6), ImVec2(px + pw + 6, py + ph + 6),
                      IM_COL32(0, 0, 0, (int)(170 * t)), 22.0f);
    dl->AddRectFilled(ImVec2(px, py), ImVec2(px + pw, py + ph),
                      IM_COL32(18, 21, 30, (int)(248 * t)), 18.0f);
    dl->AddRect(ImVec2(px, py), ImVec2(px + pw, py + ph),
                IM_COL32(255, 195, 76, (int)(220 * t)), 18.0f, 0, 2.0f);

    ImFont* font = pGUI ? pGUI->GetFont() : ImGui::GetFont();
    if (!font) font = ImGui::GetFont();
    float fs   = pGUI ? pGUI->GetFontSize() * 1.10f : 18.0f;
    float bigF = pGUI ? pGUI->GetFontSize() * 1.45f : 24.0f;

    // Title.
    {
        std::string title = Shape("جاري تصنيع السلاح...");
        ImVec2 ts = font->CalcTextSizeA(bigF, FLT_MAX, 0.0f, title.c_str());
        dl->AddText(font, bigF,
                    ImVec2(px + (pw - ts.x) * 0.5f, py + 28.0f),
                    IM_COL32(255, 255, 255, (int)(255 * t)), title.c_str());
    }

    // Spinning cog: simple radial sweep.
    {
        float cx = px + 60.0f;
        float cy = py + ph * 0.5f + 12.0f;
        float r  = 26.0f;
        float angle = m_walkPhase * 2.0f;
        for (int i = 0; i < 8; ++i)
        {
            float a = angle + i * 0.7853981633f;
            float x1 = cx + cosf(a) * r * 0.45f;
            float y1 = cy + sinf(a) * r * 0.45f;
            float x2 = cx + cosf(a) * r;
            float y2 = cy + sinf(a) * r;
            dl->AddLine(ImVec2(x1, y1), ImVec2(x2, y2),
                        IM_COL32(255, 195, 76, (int)(255 * t)), 4.0f);
        }
        dl->AddCircleFilled(ImVec2(cx, cy), r * 0.45f,
                            IM_COL32(255, 218, 68, (int)(255 * t)), 22);
    }

    // Progress bar (uses smoothed display pct so the bar glides).
    float bx = px + 110.0f;
    float by = py + ph * 0.5f - 12.0f;
    float bw = pw - 140.0f;
    float bh = 30.0f;
    float displayPct = m_progressDisplayPct;
    if (displayPct < 0.0f) displayPct = 0.0f;
    if (displayPct > 100.0f) displayPct = 100.0f;
    dl->AddRectFilled(ImVec2(bx, by), ImVec2(bx + bw, by + bh),
                      IM_COL32(11, 13, 20, (int)(255 * t)), bh * 0.5f);
    float fill = bw * (displayPct / 100.0f);
    if (fill > 2.0f)
    {
        dl->AddRectFilledMultiColor(ImVec2(bx, by), ImVec2(bx + fill, by + bh),
            IM_COL32(255, 173, 54, (int)(255 * t)), IM_COL32(255, 230, 110, (int)(255 * t)),
            IM_COL32(255, 230, 110, (int)(255 * t)), IM_COL32(255, 173, 54, (int)(255 * t)));
        // Indeterminate "sheen" highlight that wipes through the filled area.
        float wipePhase = m_walkPhase * 0.6f;
        wipePhase -= floorf(wipePhase);
        float wx = bx + fill * wipePhase;
        float ww = fill * 0.18f;
        if (ww > 4.0f)
        {
            dl->AddRectFilledMultiColor(ImVec2(wx, by), ImVec2(wx + ww, by + bh),
                IM_COL32(255, 255, 220, (int)(0 * t)), IM_COL32(255, 255, 220, (int)(120 * t)),
                IM_COL32(255, 255, 220, (int)(120 * t)), IM_COL32(255, 255, 220, (int)(0 * t)));
        }
    }
    dl->AddRect(ImVec2(bx, by), ImVec2(bx + bw, by + bh),
                IM_COL32(255, 235, 150, (int)(180 * t)), bh * 0.5f, 0, 1.6f);

    {
        char buf[64]; snprintf(buf, sizeof(buf), "%d%%", (int)displayPct);
        ImVec2 ts = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, buf);
        dl->AddText(font, fs,
                    ImVec2(bx + (bw - ts.x) * 0.5f, by + (bh - ts.y) * 0.5f),
                    IM_COL32(20, 14, 6, (int)(255 * t)), buf);
    }

    // Bottom subtitle.
    {
        std::string sub = Shape("لا تخرج من الطاولة حتى يكتمل التصنيع");
        ImVec2 ts = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, sub.c_str());
        dl->AddText(font, fs,
                    ImVec2(px + (pw - ts.x) * 0.5f, py + ph - ts.y - 20.0f),
                    kColTextDim, sub.c_str());
    }

    m_lastDown = io.MouseDown[0];
}

// ======================================================================
//  MODE_DONE: brief celebratory frame then auto-hide via server.
// ======================================================================
void CWeaponCraftOverlay::RenderDone()
{
    ImGuiIO& io = ImGui::GetIO();
    ImDrawList* dl = ImGui::GetOverlayDrawList();
    float dw = io.DisplaySize.x;
    float dh = io.DisplaySize.y;
    float t  = EaseOut(m_anim);

    RenderBackdrop(dl, dw, dh, t);

    float pw = Clampf(dw * 0.55f, 480.0f, 880.0f);
    float ph = 220.0f;
    float px = (dw - pw) * 0.5f;
    float py = (dh - ph) * 0.5f - dh * 0.04f;

    dl->AddRectFilled(ImVec2(px - 6, py - 6), ImVec2(px + pw + 6, py + ph + 6),
                      IM_COL32(0, 0, 0, (int)(170 * t)), 22.0f);
    dl->AddRectFilled(ImVec2(px, py), ImVec2(px + pw, py + ph),
                      IM_COL32(18, 32, 22, (int)(248 * t)), 18.0f);
    dl->AddRect(ImVec2(px, py), ImVec2(px + pw, py + ph),
                IM_COL32(72, 222, 128, (int)(220 * t)), 18.0f, 0, 2.0f);

    ImFont* font = pGUI ? pGUI->GetFont() : ImGui::GetFont();
    if (!font) font = ImGui::GetFont();
    float fs   = pGUI ? pGUI->GetFontSize() * 1.10f : 18.0f;
    float bigF = pGUI ? pGUI->GetFontSize() * 1.55f : 26.0f;

    {
        std::string title = Shape("تم تصنيع السلاح بنجاح!");
        ImVec2 ts = font->CalcTextSizeA(bigF, FLT_MAX, 0.0f, title.c_str());
        dl->AddText(font, bigF,
                    ImVec2(px + (pw - ts.x) * 0.5f, py + 36.0f),
                    IM_COL32(255, 255, 255, (int)(255 * t)), title.c_str());
    }
    {
        std::string sub = Shape("استلم سلاحك وارجع إلى المهمة");
        ImVec2 ts = font->CalcTextSizeA(fs, FLT_MAX, 0.0f, sub.c_str());
        dl->AddText(font, fs,
                    ImVec2(px + (pw - ts.x) * 0.5f, py + ph - ts.y - 28.0f),
                    kColTextDim, sub.c_str());
    }

    // Big animated check mark with celebratory ring + radial sparks.
    {
        float cx = px + pw * 0.5f;
        float cy = py + ph * 0.5f - 4.0f;
        float ce = m_doneCelebrate;
        if (ce < 0.0f) ce = 0.0f;
        float pop = (ce < 0.35f) ? (ce / 0.35f) : 1.0f;
        pop = 1.0f - (1.0f - pop) * (1.0f - pop);     // ease-out
        float baseR = 38.0f;
        float r = baseR * (0.6f + 0.4f * pop);

        // Soft halo behind the disk.
        float halo = r + 22.0f + 6.0f * sinf(ce * 6.0f);
        dl->AddCircleFilled(ImVec2(cx, cy), halo,
                            IM_COL32(72, 222, 128, (int)(45 * t)), 36);

        // Filled disk.
        dl->AddCircleFilled(ImVec2(cx, cy), r,
                            IM_COL32(72, 222, 128, (int)(255 * t)), 32);
        dl->AddCircle(ImVec2(cx, cy), r,
                      IM_COL32(255, 255, 255, (int)(220 * t)), 32, 2.0f);

        // Tick mark animates from 0..1 over the first 0.5s.
        float tickT = ce / 0.55f;
        if (tickT < 0.0f) tickT = 0.0f;
        if (tickT > 1.0f) tickT = 1.0f;
        float a1x = cx - 14.0f, a1y = cy + 2.0f;
        float a2x = cx -  4.0f, a2y = cy + 12.0f;
        float a3x = cx + 16.0f, a3y = cy - 10.0f;
        float thick = 4.5f * pop;
        if (tickT < 0.5f)
        {
            float kt = tickT / 0.5f;
            float lx = a1x + (a2x - a1x) * kt;
            float ly = a1y + (a2y - a1y) * kt;
            dl->AddLine(ImVec2(a1x, a1y), ImVec2(lx, ly),
                        IM_COL32(255, 255, 255, (int)(255 * t)), thick);
        }
        else
        {
            dl->AddLine(ImVec2(a1x, a1y), ImVec2(a2x, a2y),
                        IM_COL32(255, 255, 255, (int)(255 * t)), thick);
            float kt = (tickT - 0.5f) / 0.5f;
            float lx = a2x + (a3x - a2x) * kt;
            float ly = a2y + (a3y - a2y) * kt;
            dl->AddLine(ImVec2(a2x, a2y), ImVec2(lx, ly),
                        IM_COL32(255, 255, 255, (int)(255 * t)), thick);
        }

        // Radial spark burst (12 short lines that fade out after the pop).
        if (ce < 0.9f)
        {
            float sparkT = ce / 0.9f;
            float sparkA = 1.0f - sparkT;
            float sparkR0 = r + 4.0f + sparkT * 22.0f;
            float sparkR1 = sparkR0 + 14.0f;
            for (int k = 0; k < 12; ++k)
            {
                float a = (k / 12.0f) * 6.2831853f + ce * 0.6f;
                float ca = cosf(a), sa = sinf(a);
                dl->AddLine(ImVec2(cx + ca * sparkR0, cy + sa * sparkR0),
                            ImVec2(cx + ca * sparkR1, cy + sa * sparkR1),
                            IM_COL32(255, 240, 200, (int)(220 * sparkA * t)), 2.4f);
            }
        }
    }

    m_lastDown = io.MouseDown[0];
}
