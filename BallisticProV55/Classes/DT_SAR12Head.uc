//=============================================================================
// Damage type class for SAR-12 Rifle headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_SAR12Head extends DT_BWBulletHead;

defaultproperties
{
     DamageIdent="Assault"
     bDisplaceAim=False
     WeaponClass=Class'BallisticProV55.SAR12Rifle'
     bFastInstantHit=True
     VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000	 
}
