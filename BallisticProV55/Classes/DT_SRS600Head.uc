//=============================================================================
// Damage type class for SRS-600 Rifle headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_SRS600Head extends DT_BWBulletHead;

defaultproperties
{
     DamageIdent="Assault"
     bDisplaceAim=False
     WeaponClass=Class'BallisticProV55.SRS600Rifle'
     bFastInstantHit=True
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000	 
}
