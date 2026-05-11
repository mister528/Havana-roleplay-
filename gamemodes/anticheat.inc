// =============================================================================
//  anticheat.inc - HavanaRp local wrapper around the nex-AC anticheat-one
//  bundle.  The gamemode (#include "anticheat") expects to find this file
//  next to the .pwn; we just forward to the real implementation shipped in
//  the project's pawncc include directory.
// =============================================================================
#if defined _havana_anticheat_wrapper_included
    #endinput
#endif
#define _havana_anticheat_wrapper_included

#include <anticheat-one>
