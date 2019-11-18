//=============================================================================
// DTM50AssaultLimb.
//
// DamageType for the M50 assault rifle primary fire
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTM50AssaultLimb extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o was gunned down by %k with the M50."
     DeathStrings(1)="%o's foot was shot to ribbons by %k's M50."
     DeathStrings(2)="%k shot %o's kneecaps off with the M50."
     DeathStrings(3)="%k reduced %o's arms to nothing with the M50."
     DamageIdent="Assault"
     AimDisplacementDuration=0.000000
     MinMotionBlurDamage=10.000000
     MotionBlurDamageRange=80.000000
     MotionBlurFactor=4.000000
     MotionBlurTime=3.000000
     WeaponClass=Class'BallisticProV55.M50AssaultRifle'
     DeathString="%o was gunned down by %k with the M50."
     FemaleSuicide="%o nailed herself with the M50."
     MaleSuicide="%o nailed himself with the M50."
     bFastInstantHit=True
     FlashScale=0.300000
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.000000
}
