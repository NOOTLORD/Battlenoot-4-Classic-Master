//=============================================================================
// M4PrimaryFire.
//
// 3-Round burst. Shots are powerful and easy to follow up.
// Not very accurate at range, and hindered by burst fire up close.
// Excels at mid range combat.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M4A1PrimaryFire extends BallisticRangeAttenFire;

defaultproperties
{
	 TraceRange=(Min=10000.000000,Max=13000.000000)
     WaterRangeFactor=0.800000
     MaxWallSize=24.000000
     MaxWalls=1
     Damage=25.000000
     DamageHead=50.000000
     DamageLimb=25.000000
     RangeAtten=0.900000
     WaterRangeAtten=0.700000
     DamageType=Class'BWBPRecolorsPro.DT_M4A1Assault'
     DamageTypeHead=Class'BWBPRecolorsPro.DT_M4A1AssaultHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DT_M4A1Assault'
     KickForce=0
     PenetrateForce=0
     bPenetrate=False
     DryFireSound=(Sound=Sound'BallisticSounds2.D49.D49-DryFire',Volume=0.700000)
     MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
     FlashScaleFactor=0.750000	 
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassOffset=(X=-20.000000,Y=1.000000)
     RecoilPerShot=128.000000
     XInaccuracy=48.000000
     YInaccuracy=48.000000
	 FireChaos=0.100000
     BallisticFireSound=(Sound=Sound'BallisticRecolorsSounds.MJ51.MJ51Carbine-Fire',Volume=0.975000)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.095000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_M4A1_Rifle'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     WarnTargetPct=0.200000
     aimerror=750.000000
}
