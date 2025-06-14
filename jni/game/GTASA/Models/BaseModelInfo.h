//
// Created by plaka on 21.02.2023.
//

#ifndef LIVERUSSIA_BASEMODELINFO_H
#define LIVERUSSIA_BASEMODELINFO_H


#include <cstdint>
#include <cassert>

class CClumpModelInfo;
class CVehicleModelInfo;

enum ModelInfoType : uint8_t {
    MODEL_INFO_ATOMIC = 1,
    MODEL_INFO_TIME = 3,
    MODEL_INFO_WEAPON = 4,
    MODEL_INFO_CLUMP = 5,
    MODEL_INFO_VEHICLE = 6,
    MODEL_INFO_PED = 7,
    MODEL_INFO_LOD = 8
};

enum eModelInfoSpecialType : uint8_t {
    TREE = 1,
    PALM = 2,
    GLASS_TYPE_1 = 4,
    GLASS_TYPE_2 = 5,
    TAG = 6,
    GARAGE_DOOR = 7,
    CRANE = 9,
    UNKNOWN = 10,
    BREAKABLE_STATUE = 11,
};

struct CBaseModelInfo {
    uintptr_t 	vtable;
    uint32_t m_nKey;
    char m_modelName[21];
    char skip_1;
    uint16_t m_nRefCount;
    int16_t m_nTxdIndex;
    uint8_t m_nAlpha;
    uint8_t m_n2dfxCount;
    int16_t m_n2dEffectIndex;
    int16_t m_nObjectInfoIndex;
    union {
        unsigned short m_nFlags;
        struct {
            unsigned char m_nFlagsUpperByte;
            unsigned char m_nFlagsLowerByte;
        };
        struct {
            /* https://github.com/multitheftauto/mtasa-blue/blob/master/Client/game_sa/CModelInfoSA.h */
            unsigned char bHasBeenPreRendered: 1; // we use this because we need to apply changes only once
            unsigned char bDrawLast: 1;
            unsigned char bAdditiveRender: 1;
            unsigned char bDontWriteZBuffer: 1;
            unsigned char bDontCastShadowsOn: 1;
            unsigned char bDoWeOwnTheColModel: 1;
            unsigned char bIsBackfaceCulled: 1;
            unsigned char bIsLod: 1;

            union {
                struct { // Atomic flags
                    unsigned char bIsRoad: 1;
                    unsigned char : 1;
                    unsigned char bDontCollideWithFlyer: 1;
                    unsigned char nSpecialType: 4;
                    unsigned char bWetRoadReflection: 1;
                };
                struct { // Vehicle flags
                    unsigned char bUsesVehDummy: 1;
                    unsigned char : 1;
                    unsigned char nCarmodId: 5;
                    unsigned char bUseCommonVehicleDictionary: 1;
                };
                struct { // Clump flags
                    unsigned char bHasAnimBlend: 1;
                    unsigned char bHasComplexHierarchy: 1;
                    unsigned char bAnimSomething: 1;
                    unsigned char bOwnsCollisionModel: 1;
                    unsigned char : 3;
                    unsigned char bTagDisabled: 1;
                };
            };
        };
    };
    uint8_t ski_2[2];
    //CColModel *m_pColModel;      // 20
    float m_fDrawDistance;  // 24
    union {
        //struct RwObject *m_pRwObject;
        //struct RpClump *m_pRwClump;
        //struct RpAtomic *m_pRwAtomic;
    };

    // Those further ones are completely inlined in final version, not present at all in android version;
    CVehicleModelInfo* AsVehicleModelInfoPtr() { return reinterpret_cast<CVehicleModelInfo*>(this); }
    /*CPedModelInfo*     AsPedModelInfoPtr()     { return reinterpret_cast<CPedModelInfo*>(this); }
    CWeaponModelInfo*  AsWeaponModelInfoPtr()  { return reinterpret_cast<CWeaponModelInfo*>(this); }*/

    /*[[nodiscard]] CColModel* GetColModel() const { return m_pColModel; }
    [[nodiscard]] bool GetIsDrawLast() const { return bDrawLast; }
    [[nodiscard]] bool HasBeenPreRendered() const { return bHasBeenPreRendered; }
    [[nodiscard]] bool HasComplexHierarchy() const { return bHasComplexHierarchy; }
    [[nodiscard]] bool IsBackfaceCulled() const { return bIsBackfaceCulled; }
    [[nodiscard]] bool IsLod() const { return bIsLod; }
    [[nodiscard]] bool IsRoad() const { return bIsRoad; }
    void SetHasBeenPreRendered(int32_t bPreRendered) { bHasBeenPreRendered = bPreRendered; }
    void SetIsLod(bool bLod) { bIsLod = bLod; }
    void SetOwnsColModel(bool bOwns) { bDoWeOwnTheColModel = bOwns; }
    void IncreaseAlpha() {
        if (m_nAlpha >= 239)
            m_nAlpha = 255;
        else
            m_nAlpha += 16;
    };
    [[nodiscard]] auto GetModelName() const noexcept { return m_nKey; }
    void SetModelName(const char* modelName) { m_nKey = CKeyGen::GetUppercaseKey(modelName); }

    [[nodiscard]] bool IsSwayInWind1()         const { return nSpecialType == eModelInfoSpecialType::TREE; }               // 0x0800
    [[nodiscard]] bool IsSwayInWind2()         const { return nSpecialType == eModelInfoSpecialType::PALM; }               // 0x1000
    [[nodiscard]] bool SwaysInWind()           const { return IsSwayInWind1() || IsSwayInWind2(); }
    [[nodiscard]] bool IsGlassType1()          const { return nSpecialType == eModelInfoSpecialType::GLASS_TYPE_1; }       // 0x2000
    [[nodiscard]] bool IsGlassType2()          const { return nSpecialType == eModelInfoSpecialType::GLASS_TYPE_2; }       // 0x2800
    [[nodiscard]] bool IsGlass()               const { return IsGlassType1() || IsGlassType2(); }
    [[nodiscard]] bool IsTagModel()            const { return nSpecialType == eModelInfoSpecialType::TAG; }                // 0x3000
    [[nodiscard]] bool IsGarageDoor()          const { return nSpecialType == eModelInfoSpecialType::GARAGE_DOOR; }        // 0x3800
    [[nodiscard]] bool IsBreakableStatuePart() const { return nSpecialType == eModelInfoSpecialType::BREAKABLE_STATUE; }
    [[nodiscard]] bool IsCrane()               const { return nSpecialType == eModelInfoSpecialType::CRANE; }              // 0x4800*/
};
//static_assert(sizeof(CBaseModelInfo) == 0x38, "Invalid");
// sizeof=0x38


#endif //LIVERUSSIA_BASEMODELINFO_H
