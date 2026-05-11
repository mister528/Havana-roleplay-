// =============================================================================
//  havana_customcars.inc
// -----------------------------------------------------------------------------
//  Reconstructed catalogue stub for the HavanaRp custom-vehicle helpers
//  used by arabonline.pwn.  The 6 luxury cars (Azelow / two Mercedes /
//  BYD Destroyer 05 / Camry XSE V6 / Gentra 511 Tuning) all reside on
//  existing SA-MP model slots (439 / 602 / 415 / 445 / 516 / 560), so the
//  base-model translation is a pass-through and validity is just the
//  normal 400..611 vehicle range.
// =============================================================================

#if defined _havana_customcars_included
    #endinput
#endif
#define _havana_customcars_included

// Returns the underlying SA-MP base model for a (possibly custom) vehicle ID.
// All six luxury cars share their SA-MP slots with the stock models they
// replace, so the model ID itself is returned unchanged.
stock Custom_GetBaseModel ( modelid )
{
    return modelid ;
}

// Returns true (1) when the model ID is a valid SA-MP vehicle ID.
// 400..611 is the canonical SA-MP vehicle model range.
stock Custom_IsValidVehicleID ( modelid )
{
    if ( modelid < 400 || modelid > 611 ) return 0 ;
    return 1 ;
}

// Called from OnGameModeInit to register the default vehicle catalogue.
// The luxury cars are referenced directly by ID throughout the gamemode,
// so no additional catalogue state is needed here.
stock Custom_RegisterDefaultCatalog ( )
{
    return 1 ;
}
