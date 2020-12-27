//=============================================================================
// Damage type class for AK470 Assault headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved..
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_AK470Head extends DT_BWBulletHead;

defaultproperties
{
     DamageIdent="Assault"
     bDisplaceAim=False
     WeaponClass=Class'BallisticProV55Recolors.AK470Rifle'
     bFastInstantHit=True
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.500000
	 InvasionDamageScaling=1.000000
}
