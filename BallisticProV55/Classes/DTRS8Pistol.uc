//=============================================================================
// DTRS8Pistol.
//
// Damage type for the RS8 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTRS8Pistol extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o was suppressed by %k's 10mm RS8."
     DeathStrings(1)="%o got clipped by %k's RS8 rounds."
     DeathStrings(2)="%k snapped a few RS8 rounds into %o."
     EffectChance=0.500000
     DamageIdent="Pistol"
     AimDisplacementDuration=0.000000
     MinMotionBlurDamage=10.000000
     MotionBlurDamageRange=80.000000
     MotionBlurFactor=4.000000
     MotionBlurTime=3.000000
     WeaponClass=Class'BallisticProV55.RS8Pistol'
     DeathString="%o was suppressed by %k's 10mm RS8."
     FemaleSuicide="%o silenced herself."
     MaleSuicide="%o silenced himself."
     bFastInstantHit=True
     FlashScale=0.300000
     VehicleDamageScaling=0.100000
}
