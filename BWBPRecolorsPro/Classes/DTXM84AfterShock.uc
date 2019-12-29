//=============================================================================
// DTMRS138Tazer.
//
//?/ a/sf/ a/s/ Headache grenades!
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Edited by (NL)NOOTLORD 
//=============================================================================
class DTXM84AfterShock extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o's brain was reduced to goo by %k's XM84."
     DeathStrings(1)="%k's XM84 slowly liquidized %o's fragile brain."
     DeathStrings(2)="%o painfully succumbed to %k's XM84 aftershock."
     FlashThreshold=0
     FlashV=(X=128.000000,Y=128.000000,Z=128.000000)
     bDetonatesBombs=False
     DamageIdent="Grenade"
     AimDisplacementDamageThreshold=0.000000
     AimDisplacementDuration=0.000000
     bUseMotionBlur=False	 
     DamageDescription=",Gas,GearSafe,Hazard,"
     WeaponClass=Class'BWBPRecolorsPro.XM84Flashbang'
     DeathString="%o's brain was reduced to goo by %k's XM84."
     FemaleSuicide="%o succumbed to her own tech grenade."
     MaleSuicide="%o succumbed to his own tech grenade."
     bInstantHit=True
     bCausesBlood=False
     bDelayedDamage=True
     bNeverSevers=True
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.900000
     GibPerterbation=0.001000
     KDamageImpulse=90000.000000
	 VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000	
}
