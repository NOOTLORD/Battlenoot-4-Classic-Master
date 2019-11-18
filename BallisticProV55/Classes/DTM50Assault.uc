//=============================================================================
// DTM50Assault.
//
// DamageType for the M50 assault rifle primary fire
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTM50Assault extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k eliminated %o with the M50."
     DeathStrings(1)="%o was drilled by %k's M50."
     DeathStrings(2)="%k purified %o with M50 rounds."
     DamageIdent="Assault"
     AimDisplacementDuration=0.000000
     MinMotionBlurDamage=10.000000
     MotionBlurDamageRange=80.000000
     MotionBlurFactor=4.000000
     MotionBlurTime=3.000000
     WeaponClass=Class'BallisticProV55.M50AssaultRifle'
     DeathString="%k eliminated %o with the M50."
     FemaleSuicide="%o nailed herself with the M50."
     MaleSuicide="%o nailed himself with the M50."
     bFastInstantHit=True
     FlashScale=0.300000
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
}
