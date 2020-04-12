//=============================================================================
// DTFP7Grenade.
//
// Damage type for the FP7 Grenade hit
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_FP7Grenade extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k bounced an FP7 off %o's head."
     BloodManagerName="BallisticProV55.BloodMan_BluntSmall"
     bDetonatesBombs=False
     bIgnoredOnLifts=True
     DamageIdent="Grenade"
	 bDisplaceAim=False
     bUseMotionBlur=False
     DamageDescription=",Blunt,Hazard,"
     WeaponClass=Class'BallisticProV55.FP7Grenade'
     DeathString="%k bounce an FP7 off %o's head."
     FemaleSuicide="%o tripped on her own FP7."
     MaleSuicide="%o tripped on his own FP7."
     bDelayedDamage=True
     GibPerterbation=0.500000
     KDamageImpulse=20000.000000
	 VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000	 	 
}
