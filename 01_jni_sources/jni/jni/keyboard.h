#pragma once
#include "keyboardhistory.h"
#include "vendor/raknet/SingleProducerConsumer.h"
#include <jni.h>
/*
	зачем я это высрал?
*/

#define LAYOUT_ENG			0
#define LAYOUT_RUS			1	
#define LAYOUT_NUM			2
#define LAYOUT_ARA			3

#define LOWER_CASE			0
#define UPPER_CASE			1

#define KEY_DEFAULT			0
#define KEY_SHIFT			1
#define KEY_BACKSPACE		2
#define KEY_SWITCH			3
#define KEY_SPACE 			4
#define KEY_SEND			5
#define KEY_HISTORY 		6

#define MAX_INPUT_LEN		0xBF

struct kbKey
{
	ImVec2 pos;
	ImVec2 symPos;
	float width;
	char code[2];
	char name[2][8];
	// Optional multi-byte UTF-8 sequence pushed when the key is tapped.
	// When non-empty, this overrides `code[m_iCase]`. Used by the Arabic
	// layout where each letter is 2 UTF-8 bytes.
	char utf8push[2][8];
	int type;
	int id;
};

typedef void keyboard_callback(const char* result);

class CKeyBoard
{
	friend class CGUI;
public:
	CKeyBoard();
	~CKeyBoard();

	void Open(keyboard_callback* handler, bool bHiden = false);
	void Close();

	bool IsOpen() { return m_bEnable; }
	bool IsHidden() { return m_bInputFlag; }
	void AddCharToInput(char sym);
	// Rebuild m_utf8Input from m_sInput. If m_sInput contains valid UTF-8
	// multibyte sequences for Arabic codepoints we copy them verbatim;
	// otherwise we treat m_sInput as CP1251 and transcode to UTF-8.
	// `offsetDelta` is added to m_iInputOffset (used by DeleteCharFromInput
	// which needs to peek one char back).
	void RebuildInputEcho(int offsetDelta = 0);
	void Flush();

	void EnableNewKeyboard();
	void EnableOldKeyboard();

	bool IsNewKeyboard();

	void ProcessInputCommands();
	void OnNewKeyboardInput(JNIEnv* pEnv, jobject thiz, jbyteArray str);
private:
	void Render();
	bool OnTouchEvent(int type, bool multi, int x, int y);

	void InitENG();
	void InitRU();
	void InitNUM();
	void InitARA();
	kbKey* GetKeyFromPos(int x, int y);

	void HandleInput(kbKey &key);
	void DeleteCharFromInput();
	void Send();
	
	bool m_bEnable;
	bool m_bInited;
	bool m_bInputFlag;
	ImVec2 m_Size;
	ImVec2 m_Pos;
	float m_fKeySizeY;
	float m_fFontSize;

	int m_iLayout;
	int m_iCase;
	int m_iPushedKey;

	std::vector<kbKey> m_Rows[4][4]; // eng, rus, num, ara

	std::string m_sInput;
	char m_utf8Input[MAX_INPUT_LEN*3 + 0xF];
	int m_iInputOffset;
	CKeyBoardHistory* m_pkHistory;
	keyboard_callback *m_pHandler;

	bool m_bNewKeyboard;
	DataStructures::SingleProducerConsumer<std::string> bufferedStrings;
};