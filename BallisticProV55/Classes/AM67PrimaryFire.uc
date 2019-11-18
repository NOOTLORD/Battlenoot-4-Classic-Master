//=============================================================================
// AM67PrimaryFire.
//
// Powerful, close range bullet attack.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AM67PrimaryFire extends BallisticRangeAttenFire;

defaultproperties
{
     CutOffDistance=2048.000000
     CutOffStartRange=1250.000000
     WaterRangeFactor=0.500000
     MaxWallSize=64.000000
     MaxWalls=2
     Damage=60.000000
     DamageHead=120.000000
     DamageLimb=60.000000
     RangeAtten=0.500000
     WaterRangeAtten=0.300000
     DamageType=Class'BallisticProV55.DTAM67Pistol'
     DamageTypeHead=Class'BallisticProV55.DTAM67PistolHead'
     DamageTypeArm=Class'BallisticProV55.DTAM67Pistol'
     KickForce=1500
     PenetrateForce=200
     bPenetrate=True
     DryFireSound=(Sound=Sound'BallisticSounds2.D49.D49-DryFire',Volume=0.700000)
     bDryUncock=True
     MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
     FlashScaleFactor=0.900000
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassBone="tip"
     BrassOffset=(X=-30.000000,Y=1.000000)
     AimedFireAnim="SightFire"
     RecoilPerShot=2048.000000
     FireChaos=0.400000
     XInaccuracy=128.000000
     YInaccuracy=128.000000
     BallisticFireSound=(Sound=Sound'BallisticSounds3.AM67.AM67-Fire',Volume=1.100000)
     FireEndAnim=
     FireRate=0.300000
     AmmoClass=Class'BallisticProV55.Ammo_50HV'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
}
