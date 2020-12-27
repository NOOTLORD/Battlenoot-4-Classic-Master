//=============================================================================
// Damage type class for M763 Shotgun headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_M763Head extends DT_BWShellHead;

defaultproperties
{
     DamageIdent="Shotgun"
     bDisplaceAim=False	 
     WeaponClass=Class'BallisticProV55.M763Shotgun'
     bExtraMomentumZ=True
     GibPerterbation=0.400000
     KDamageImpulse=10000.000000
     VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000	 
}
