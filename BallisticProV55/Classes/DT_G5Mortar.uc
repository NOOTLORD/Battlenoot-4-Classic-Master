//=============================================================================
// Damage type class for G5 Bazooka mortar rockets
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_G5Mortar extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o caught %k's G5 mortar."
     DeathStrings(1)="%k's G5 mortar took %o to heaven."
     DeathStrings(2)="%o took an express trip to hell thanks to %k's G5 mortar."
     SimpleKillString="G5 Bazooka Mortar"
     DamageIdent="Ordnance"
     bDisplaceAim=False
     bUseMotionBlur=False	 
     WeaponClass=Class'BallisticProV55.G5Bazooka'
     DeathString="%o caught %k's G5 mortar."
     FemaleSuicide="%o caught one of her own G5 mortars."
     MaleSuicide="%o caught one of his own G5 mortars."
     bDelayedDamage=True
     GibPerterbation=0.800000
     VehicleDamageScaling=1.500000
     InvasionDamageScaling=1.000000
}