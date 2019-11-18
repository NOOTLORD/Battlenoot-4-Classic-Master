//=============================================================================
// DTM806Pistol.
//
// Damage type for the M806 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTM806Pistol extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o was capped by %k's M806."
     DeathStrings(1)="%k busted a cap in %o with the M806."
     DeathStrings(2)="%o found %k's missing M806 bullet."
     AimDisplacementDuration=0.000000
     MinMotionBlurDamage=10.000000
     MotionBlurDamageRange=80.000000
     MotionBlurFactor=4.000000
     MotionBlurTime=3.000000
     bUseMotionBlur=False
     WeaponClass=Class'BallisticProV55.M806Pistol'
     DeathString="%o was capped by %k's M806."
     FemaleSuicide="%o nailed herself with the M806."
     MaleSuicide="%o nailed himself with the M806."
     FlashScale=0.300000
     VehicleDamageScaling=0.000000
     bSelected=False
}
