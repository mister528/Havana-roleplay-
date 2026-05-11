#include "../main.h"
#include "game.h"
#include "../net/netgame.h"
#include <cmath>

extern CGame *pGame;
extern CNetGame *pNetGame;

CObject::CObject(int iModel, float fPosX, float fPosY, float fPosZ, VECTOR vecRot, float fDrawDistance)
{
	uint32_t dwRetID 	= 0;
	m_pEntity 			= 0;
	m_dwGTAId 			= 0;

	// [FIX] Ensure the model is valid and loaded before create_object.
	// Without this, the SCM create_object opcode (0x0107) silently fails for
	// models that GTA:SA has not streamed yet and the server-streamed map,
	// houses and Objects never render on the client.
	int iOrigModel = iModel;
	if (iModel > 0 && iModel < 20000)
	{
		uintptr_t* dwModelArray = (uintptr_t*)(g_libGTASA + 0x87BF48);
		if (dwModelArray[iModel] == 0)
			iModel = 18631;
	}
	else
	{
		iModel = 18631;
	}

	int iWait = 0;
	if (!ScriptCommand(&is_model_available, iModel))
	{
		ScriptCommand(&request_model, iModel);
		ScriptCommand(&load_requested_models);
		while (!ScriptCommand(&is_model_available, iModel) && iWait++ < 5000)
			usleep(1000);
	}

	ScriptCommand(&create_object, iModel, fPosX, fPosY, fPosZ, &dwRetID);
	Log("CObject(origM=%d useM=%d pos=%.1f,%.1f,%.1f wait=%d -> id=%u entPtr=%p)",
		iOrigModel, iModel, fPosX, fPosY, fPosZ, iWait, dwRetID, (void*)GamePool_Object_GetAt(dwRetID));
	if (dwRetID == 0)
	{
		// create_object failed even after loading the model; keep the
		// CObject in a safe state so the pool slot is still usable and
		// the destructor will not corrupt the GTA object pool.
		m_byteMoving = 0;
		m_fMoveSpeed = 0.0f;
		m_bIsPlayerSurfing = false;
		m_bMaterials = false;
		m_bAttachedType = 0;
		m_usAttachedVehicle = 0xFFFF;
		for (int i = 0; i < MAX_MATERIALS; i++)
		{
			m_pMaterials[i].m_bCreated = 0;
			m_pMaterials[i].pTex = nullptr;
		}
		return;
	}
	ScriptCommand(&put_object_at, dwRetID, fPosX, fPosY, fPosZ);

	m_pEntity = GamePool_Object_GetAt(dwRetID);
	m_dwGTAId = dwRetID;
	m_byteMoving = 0;
	m_fMoveSpeed = 0.0;

	m_bIsPlayerSurfing = false;

	m_bMaterials = false;

	m_bAttachedType = 0;
	m_usAttachedVehicle = 0xFFFF;

	for (int i = 0; i < MAX_MATERIALS; i++)
	{
		m_pMaterials[i].m_bCreated = 0;
		m_pMaterials[i].pTex = nullptr;
	}

	InstantRotate(vecRot.X, vecRot.Y, vecRot.Z);
}
// todo
CObject::~CObject()
{
	m_bMaterials = false;
	for (int i = 0; i < MAX_MATERIALS; i++)
	{
		if (m_pMaterials[i].m_bCreated && m_pMaterials[i].pTex)
		{
			m_pMaterials[i].m_bCreated = 0;
			RwTextureDestroy(m_pMaterials[i].pTex);
			m_pMaterials[i].pTex = nullptr;
		}
	}
	m_pEntity = GamePool_Object_GetAt(m_dwGTAId);
	if(m_pEntity)
		ScriptCommand(&destroy_object, m_dwGTAId);
}

void CObject::Process(float fElapsedTime)
{
	if (m_bAttachedType == 1)
	{
		CVehicle* pVehicle = pNetGame->GetVehiclePool()->GetAt(m_usAttachedVehicle);
		if (pVehicle)
		{
			if (pVehicle->IsAdded())
			{
				ProcessAttachToVehicle(pVehicle);
			}
		}
	}
	// допилить
}

float CObject::DistanceRemaining(MATRIX4X4 *matPos)
{

	float	fSX,fSY,fSZ;
	fSX = (matPos->pos.X - m_matTarget.pos.X) * (matPos->pos.X - m_matTarget.pos.X);
	fSY = (matPos->pos.Y - m_matTarget.pos.Y) * (matPos->pos.Y - m_matTarget.pos.Y);
	fSZ = (matPos->pos.Z - m_matTarget.pos.Z) * (matPos->pos.Z - m_matTarget.pos.Z);
	return (float)sqrt(fSX + fSY + fSZ);
}

void CObject::SetPos(float x, float y, float z)
{
	if (GamePool_Object_GetAt(m_dwGTAId))
	{
		ScriptCommand(&put_object_at, m_dwGTAId, x, y, z);
	}
}

void CObject::MoveTo(float X, float Y, float Z, float speed)
{
	m_matTarget.pos.X = X;
	m_matTarget.pos.Y = Y;
	m_matTarget.pos.Z = Z;
	m_fMoveSpeed = speed;
	m_byteMoving |= 1;
}

void CObject::AttachToVehicle(uint16_t usVehID, VECTOR* pVecOffset, VECTOR* pVecRot)
{
	m_bAttachedType = 1;
	m_usAttachedVehicle = usVehID;
	m_vecAttachedOffset.X = pVecOffset->X;
	m_vecAttachedOffset.Y = pVecOffset->Y;
	m_vecAttachedOffset.Z = pVecOffset->Z;

	m_vecAttachedRotation.X = pVecRot->X;
	m_vecAttachedRotation.Y = pVecRot->Y;
	m_vecAttachedRotation.Z = pVecRot->Z;
}

void CObject::ProcessAttachToVehicle(CVehicle* pVehicle)
{
	if (GamePool_Object_GetAt(m_dwGTAId))
	{
		if (!ScriptCommand(&is_object_attached, m_dwGTAId))
		{
			ScriptCommand(&attach_object_to_car, m_dwGTAId, pVehicle->m_dwGTAId, m_vecAttachedOffset.X,
				m_vecAttachedOffset.Y, m_vecAttachedOffset.Z, m_vecAttachedRotation.X, m_vecAttachedRotation.Y, m_vecAttachedRotation.Z);
		}
	}
}

void CObject::InstantRotate(float x, float y, float z)
{
	if (GamePool_Object_GetAt(m_dwGTAId))
	{
		ScriptCommand(&set_object_rotation, m_dwGTAId, x, y, z);
	}
}