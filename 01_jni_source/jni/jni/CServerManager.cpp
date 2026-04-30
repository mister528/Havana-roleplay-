#include "CServerManager.h"

#include <stdint.h>

const char* g_szServerNames[MAX_SERVERS] = {
	"Luxury",
	"Luxury"

};

const CServerInstance::CServerInstanceEncrypted g_sEncryptedAddresses[MAX_SERVERS] = {
	CServerInstance::create("94.23.168.153", 438, 13, 2826, false), // 1 - HavanaRP
	CServerInstance::create("94.23.168.153", 438, 13, 2826, false) // 2 - HavanaRP
};