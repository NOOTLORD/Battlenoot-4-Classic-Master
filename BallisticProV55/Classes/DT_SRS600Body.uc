//=============================================================================
// Damage type class for the SRS-600 Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_SRS600Body extends DT_BWBullet;

defaultproperties
{
     DamageIdent="Assault"
     bDisplaceAim=False
     WeaponClass=Class'BallisticProV55.SRS600Rifle'
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000	 
}
