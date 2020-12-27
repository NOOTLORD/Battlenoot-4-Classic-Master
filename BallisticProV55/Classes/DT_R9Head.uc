//=============================================================================
// Damage type class for R9 Rifle headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_R9Head extends DT_BWBulletHead;

defaultproperties
{
     DamageIdent="Sniper"
     bDisplaceAim=False 
     WeaponClass=Class'BallisticProV55.R9Rifle'
     bFastInstantHit=True	 
     VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000	 
}
