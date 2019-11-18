//=============================================================================
// DTR78Rifle.
//
// Damage type for the R78 Sniper Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTR78Rifle extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o was silenced by %k's R78."
     DeathStrings(1)="%k picked off %o with %kh sniper rifle."
     DeathStrings(2)="%k's R78 hunted down %o."
     DeathStrings(3)="%k's Raven tucked into some delicious %o."
     DeathStrings(4)="%k's Raven strike ended %o's farcical existence."
     DeathStrings(5)="%o never even saw %k's R78 bullet coming."
     AimedString="Scoped"
     bSnipingDamage=True
     DamageIdent="Sniper"
     AimDisplacementDamageThreshold=0
     AimDisplacementDuration=0.000000
     MinMotionBlurDamage=10.000000
     MotionBlurDamageRange=80.000000
     MotionBlurFactor=4.000000
     MotionBlurTime=3.000000
     WeaponClass=Class'BallisticProV55.R78Rifle'
     DeathString="%o was silenced by %k's R78."
     FemaleSuicide="%o held her R78 the wrong way around."
     MaleSuicide="%o held his R78 the wrong way around."
     FlashScale=0.300000
     VehicleDamageScaling=0.150000
     VehicleMomentumScaling=0.300000
}
