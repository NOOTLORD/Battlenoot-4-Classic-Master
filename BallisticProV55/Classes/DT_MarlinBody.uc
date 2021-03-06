//=============================================================================
// Damage type class for the Marlin Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_MarlinBody extends DT_BWBullet;

defaultproperties
{
     bSnipingDamage=True
     DamageIdent="Sniper"
     bDisplaceAim=False
     WeaponClass=Class'BallisticProV55.MarlinRifle'
     VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000
}
