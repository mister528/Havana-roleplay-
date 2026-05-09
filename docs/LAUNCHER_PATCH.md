# Launcher (libsamp.so) notes — accepting vehicle ID 8000

The HavanaRp launcher source ships in
`HavanaRp_release_v15/01_jni_sources/jni/`. Two places matter when you spawn
a vehicle with a model id outside the standard SA-MP range (400–611):

## 1) Network reception — already permissive

`jni/net/netrpc.cpp` around line 830:

```cpp
NEW_VEHICLE NewVehicle;
bsData.Read((char *)&NewVehicle, sizeof(NEW_VEHICLE));

//if (NewVehicle.iVehicleType < 400 || NewVehicle.iVehicleType > 611) return;
if (!pVehiclePool->New(&NewVehicle))
    return;
```

The range guard is **commented out**, so the launcher will hand any model id
the server sends straight to GTA SA's vehicle factory. No change needed.

## 2) Entity rendering — still range-checked, but harmless

`jni/game/entity.cpp` line 84:

```cpp
void CEntity::Render() {
    uintptr_t pRwObject = m_pEntity->m_RwObject;
    int iModel = GetModelIndex();
    if (iModel >= 400 && iModel <= 611 && pRwObject) {
        // CVisibilityPlugins::SetupVehicleVariables
    }
    // ...
    // CRenderer::RenderOneNonRoad
    ((void (*)(ENTITY_TYPE*))(g_libGTASA + 0x3B1690 + 1))(m_pEntity);
}
```

This block only runs the visibility-plugin setup for the standard range. The
actual draw call happens unconditionally below it, so a model with id 8000 is
still rendered as long as GTA SA itself loaded the dff/txd. **You do NOT
need to change this file** for the Azelow patch to work.

If you ever want custom-id-aware highlighting (e.g. lights from
`carcols.dat`), broaden the bracket like:

```cpp
if (iModel >= 400 && iModel <= 19000 && pRwObject) {
    // CVisibilityPlugins::SetupVehicleVariables
}
```

…matching the `ToID_1=19000` you set in `VehicleAudioData.ini`.

## 3) Rebuilding the .so (only if you change the source)

```bash
# one-time NDK setup
wget https://dl.google.com/android/repository/android-ndk-r17c-linux-x86_64.zip
unzip android-ndk-r17c-linux-x86_64.zip
export NDK=$PWD/android-ndk-r17c

# build
cd HavanaRp_release_v15/01_jni_sources/jni
$NDK/ndk-build -j4 NDK_DEBUG=0
# -> libs/armeabi-v7a/libsamp.so
```

Then drop the new `.so` into the APK template:

```bash
cp 01_jni_sources/jni/libs/armeabi-v7a/libsamp.so \
   03_apktool_template/apk_full/lib/armeabi-v7a/libluxury.so
bash 04_tools/build_apk.sh
```

The output `03_apktool_template/HavanaRp.apk` is signed with the same
keystore as v15, so existing players get an in-place update.
