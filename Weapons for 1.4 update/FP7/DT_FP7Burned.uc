//=============================================================================
// Damage type for players caught by FP7 fires.
// 
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_FP7Burned extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%o went out in a blaze of %k's glory."
     DeathStrings(1)="%k cauterized %o's head off with the FP7."
     DeathStrings(2)="%o stopped, dropped and rolled around in %k's inferno."
     DeathStrings(3)="%o was roasted to a cinder by %k's FP7."
     bIgnoredOnLifts=True
     DamageIdent="Grenade"
	 bDisplaceAim=False
     bUseMotionBlur=False
     WeaponClass=Class'BallisticProV55.FP7Grenade'
     DeathString="%o went out in a blaze of %k's glory."
     FemaleSuicide="%o went out in a blaze of her own glory."
     MaleSuicide="%o went out in a blaze of his own glory."
     bDelayedDamage=True
     PawnDamageSounds(0)=Sound'BallisticSounds1.FP7.FP7BurnFlesh'
     KDamageImpulse=20000.000000
     VehicleDamageScaling=1.500000
     InvasionDamageScaling=1.000000	 	 
}
