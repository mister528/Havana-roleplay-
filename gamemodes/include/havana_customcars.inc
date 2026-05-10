// ============================================================================
// havana_customcars.inc  --  PRODUCTION STUB
// ----------------------------------------------------------------------------
// The real `include/havana_customcars` lives outside the production FTP
// (Google Drive bundle JNI+APK). This stub keeps the compiler happy while
// the real include is recovered. It must NOT be uploaded to production:
// replace it with the real file before deploying the resulting .amx.
//
// Required external symbols (deduced from arabonline.pwn callsites):
//   - Custom_IsValidVehicleID(id)      : 1 when id is a recognised model
//   - Custom_GetBaseModel(id)          : underlying SA model id to spawn
//   - Custom_RegisterDefaultCatalog()  : initialise the catalog
// ============================================================================
#if defined _havana_customcars_included
    #endinput
#endif
#define _havana_customcars_included

stock Custom_IsValidVehicleID(id)
{
    // SA-MP base vehicle model range.
    return (id >= 400 && id <= 611);
}

stock Custom_GetBaseModel(id)
{
    return id;
}

stock Custom_RegisterDefaultCatalog()
{
    return 1;
}
