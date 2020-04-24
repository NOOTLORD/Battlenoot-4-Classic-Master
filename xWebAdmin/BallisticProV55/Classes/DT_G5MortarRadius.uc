//=============================================================================
// Damage type class for G5 Bazooka mortar rocket radius
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_G5MortarRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o was bombarded by %k's G5."
     DeathStrings(1)="%o flung %vs into the path of %k's G5 mortar."
     FemaleSuicides(0)="%o forgot where she left one of her mortar rockets."
     DamageIdent="Ordnance"
     bDisplaceAim=False
     bUseMotionBlur=False 
     WeaponClass=Class'BallisticProV55.G5Bazooka'
     DeathString="%o was bombarded by %k's G5."
     FemaleSuicide="%o forgot where she left one of her mortar rockets."
     MaleSuicide="%o forgot where he left one of his mortar rockets."
     bDelayedDamage=True
     VehicleDamageScaling=1.500000
     InvasionDamageScaling=1.000000
}
