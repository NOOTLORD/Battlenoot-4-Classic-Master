//=============================================================================
// Damage type for the XM84 Grenade radius
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_XM84GrenadeRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o's fragile brain was fried by %k's XM84."
     DeathStrings(1)="%k's XM84 hemorrhaged %o's fragile brain."
     DeathStrings(2)="%o succumbed to %k's XM84 psionic blast."
     FlashThreshold=0
     FlashV=(X=128.000000,Y=128.000000,Z=128.000000)
     FlashF=-1.000000
     DamageIdent="Grenade"
     AimDisplacementDamageThreshold=0.000000
     AimDisplacementDuration=0.000000
	 bDisplaceAim=False
     bUseMotionBlur=False
     WeaponClass=Class'BWBPRecolorsPro.XM84Flashbang'
     DeathString="%o was fatally corrupted by %k's tech grenade."
     FemaleSuicide="%o had a tactical error with her tactical grenade."
     MaleSuicide="%o had a tactical error with his tactical grenade."
     bArmorStops=False
     bCauseConvulsions=False
     bDelayedDamage=True
     VehicleMomentumScaling=0.500000
	 VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000
}
