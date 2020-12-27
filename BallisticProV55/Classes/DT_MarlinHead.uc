//=============================================================================
// Damage type class for Marlin Rifle headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_MarlinHead extends DT_BWBulletHead;

defaultproperties
{
     bSnipingDamage=True
     DamageIdent="Sniper"
     bDisplaceAim=False
     WeaponClass=Class'BallisticProV55.MarlinRifle'
     KDamageImpulse=2000.000000
     VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000
}
