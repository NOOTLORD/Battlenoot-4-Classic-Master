//=============================================================================
// Primaryfire class for Fifty-9 Machine Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class Fifty9PrimaryFire extends BallisticRangeAttenFire;

defaultproperties
{
     CutOffDistance=1280.000000
     CutOffStartRange=512.000000
     WaterRangeFactor=0.400000
     MaxWallSize=24.000000
     MaxWalls=1
     Damage=22.000000
     DamageHead=44.000000
     DamageLimb=22.000000
     RangeAtten=0.250000
     WaterRangeAtten=0.300000
     DamageType=Class'BallisticProV55.DT_Fifty9SMG'
     DamageTypeHead=Class'BallisticProV55.DT_Fifty9SMGHead'
     DamageTypeArm=Class'BallisticProV55.DT_Fifty9SMG'
     DryFireSound=(Sound=Sound'BallisticSounds2.Misc.DryRifle',Volume=0.900000)	 
     KickForce=0
     PenetrateForce=0
     bPenetrate=False
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashBone="Muzzle"
     FlashScaleFactor=0.230000
     BrassClass=Class'BallisticProV55.Brass_Fifty_SMG'
     BrassOffset=(X=-39.000000,Y=-2.500000,Z=3.000000)
     AimedFireAnim="SightFire"
     RecoilPerShot=140.000000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.240000,OutVal=1),(InVal=0.350000,OutVal=1.500000),(InVal=0.660000,OutVal=2.250000),(InVal=1.000000,OutVal=3.500000)))
     XInaccuracy=64.000000
     YInaccuracy=64.000000
     BallisticFireSound=(Sound=Sound'BallisticSounds2.UZI.UZI-Fire',Volume=0.450000)
     bPawnRapidFireAnim=True
     FireRate=0.073000
     AmmoClass=Class'BallisticProV55.Ammo_Fifty_SMG'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
	 BotRefireRate=0.990000
     aimerror=750.000000
}
