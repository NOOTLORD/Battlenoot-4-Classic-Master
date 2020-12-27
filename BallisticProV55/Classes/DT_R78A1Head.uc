//=============================================================================
// Damage type class for R78A1 Sniper Rifle headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_R78A1Head extends DT_BWBulletHead;

defaultproperties
{
     bSnipingDamage=True
     DamageIdent="Sniper"
     bDisplaceAim=False
     WeaponClass=Class'BallisticProV55.R78A1Rifle'
     KDamageImpulse=2000.000000
     VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000
}
