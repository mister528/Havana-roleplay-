#pragma once

#include <stdint.h>

class CCarJackOverlay
{
public:
    CCarJackOverlay();
    ~CCarJackOverlay();

    bool TryHandleDialog(uint16_t dialogId, uint8_t style,
                         const char* title, const char* body);
    void Hide();
    void Render();

    bool IsVisible() const { return m_bVisible; }

private:
    enum { kPins = 4, kMaxMisses = 5 };

    void Begin(uint16_t dialogId, int totalPins);
    void BeginProgress(uint16_t dialogId, int durationMs);
    void NewPin(int idx);
    void TryPick();
    void Cancel();
    void FinishSuccess();
    void RenderUnlock();
    void RenderProgress();

    bool      m_bVisible;
    bool      m_progressMode;
    uint16_t  m_dialogId;
    int       m_totalPins;
    int       m_currentPin;
    int       m_misses;
    int       m_progStartMs;
    int       m_progDurationMs;

    float     m_pinTarget[kPins];
    float     m_pinWindow[kPins];
    float     m_pinSpeed[kPins];
    float     m_pinAngle[kPins];
    bool      m_pinDone[kPins];
    float     m_pinAccuracy[kPins];

    float     m_flashHit;
    float     m_flashMiss;
    float     m_openT;
    float     m_closeT;
    bool      m_closing;
    bool      m_lastMouseDown;
};

extern CCarJackOverlay* pCarJackOverlay;
