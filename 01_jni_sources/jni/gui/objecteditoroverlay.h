#pragma once
#include <stdint.h>
#include <string>

class CObjectEditorOverlay
{
public:
    CObjectEditorOverlay();
    ~CObjectEditorOverlay();

    void Render();
    void Hide();
    bool IsVisible() const { return m_bVisible; }
    void ApplyServerCommand(const char* payload);
    bool IsModalActive() const { return m_bVisible; }
    bool HitTest(float x, float y) const;

private:
    void RenderControlPad(float sw, float sh, float base);
    void ApplyClientScale();
    void ApplySavedScales();

    bool        m_bVisible;
    int         m_iActiveSlot;
    int         m_iActiveModel;
    int         m_iObjCount;
    int         m_iAttached;
    float       m_fX, m_fY, m_fZ;
    float       m_fRX, m_fRY, m_fRZ;
    float       m_fScale;
    std::string m_sProjectName;
    std::string m_sStatus;
    float m_fPadX, m_fPadY, m_fPadW, m_fPadH;
};

extern CObjectEditorOverlay* pObjectEditorOverlay;
