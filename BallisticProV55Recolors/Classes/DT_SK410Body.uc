//=============================================================================
// Damage type class for the SK410 Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_SK410Body extends DT_BWShell;

defaultproperties
{
     DamageIdent="Shotgun"
     bDisplaceAim=False	
     WeaponClass=Class'BallisticProV55Recolors.SK410Shotgun'
     bFastInstantHit=True
     bExtraMomentumZ=True
     GibPerterbation=2.000000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000
}
