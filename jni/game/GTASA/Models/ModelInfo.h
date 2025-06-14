//
// Created by plaka on 21.02.2023.
//

#ifndef LIVERUSSIA_MODELINFO_H
#define LIVERUSSIA_MODELINFO_H


#include "BaseModelInfo.h"
/*#include "PedModelInfo.h"
#include "AtomicModelInfo.h"*/
#include "VehicleModelInfo.h"

#include "../Core/Store.h"

class CModelInfo {

public:
    static constexpr int32_t NUM_MODEL_INFOS = 30000;
    static CBaseModelInfo* ms_modelInfoPtrs[30000];

    static void injectHooks();

    /*static constexpr int32_t NUM_PED_MODEL_INFOS = 350;
    static CStore<CPedModelInfo, NUM_PED_MODEL_INFOS> ms_pedModelInfoStore;

    static constexpr int32_t NUM_ATOMIC_MODEL_INFOS = 20000;
    static CStore<CAtomicModelInfo, NUM_ATOMIC_MODEL_INFOS> ms_atomicModelInfoStore;*/

    static constexpr int32_t NUM_VEHICLE_MODEL_INFOS = 220;
    static CStore<CVehicleModelInfo, 600> ms_vehicleModelInfoStore;

public:
    /*static CPedModelInfo *AddPedModel(int index);
    static CAtomicModelInfo *AddAtomicModel(int index);*/
    //static CVehicleModelInfo *AddVehicleModel(int index);
	
	
	
    static CVehicleModelInfo *AddVehicleModel(int index);

    static CBaseModelInfo* GetModelInfo(int index) {
		Log("sizeof %d", sizeof(ms_modelInfoPtrs));
		return ms_modelInfoPtrs[index]; }
	static CVehicleModelInfo* GetVehicleModelInfo(int32_t index) { return GetModelInfo(index)->AsVehicleModelInfoPtr(); }
    static void SetModelInfo(int index, CBaseModelInfo* pInfo) { ms_modelInfoPtrs[index] = pInfo; }


};


#endif //LIVERUSSIA_MODELINFO_H
