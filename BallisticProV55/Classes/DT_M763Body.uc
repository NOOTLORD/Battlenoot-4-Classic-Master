//=============================================================================
// Damage type class for the M763 Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_M763Body extends DT_BWShell;

defaultproperties
{
     DamageIdent="Shotgun"
     bDisplaceAim=False	 
     WeaponClass=Class'BallisticProV55.M763Shotgun'
     bExtraMomentumZ=True
     GibPerterbation=0.400000
     KDamageImpulse=25000.000000
     VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000
}
