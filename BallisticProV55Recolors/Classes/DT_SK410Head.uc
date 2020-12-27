//=============================================================================
// Damage type class for SK410 Shotgun headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_SK410Head extends DT_BWShellHead;

defaultproperties
{
     DamageIdent="Shotgun"
     bDisplaceAim=False
     WeaponClass=Class'BallisticProV55Recolors.SK410Shotgun'
     bFastInstantHit=True
     bExtraMomentumZ=True
     GibPerterbation=1.600000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000
}
