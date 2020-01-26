//=============================================================================
// Main Primaryfire class for X82 Sniper Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class X82PrimaryFire extends BallisticProInstantFire;

defaultproperties
{
     TraceRange=(Min=30000.000000,Max=30000.000000)
     WaterRangeFactor=0.800000
     MaxWallSize=24.000000
     MaxWalls=1
     Damage=45.000000
     DamageHead=150.000000
     DamageLimb=40.000000
     WaterRangeAtten=0.800000
     DamageType=Class'BWBPRecolorsPro.DT_X82Torso'
     DamageTypeHead=Class'BWBPRecolorsPro.DT_X82Head'
     DamageTypeArm=Class'BWBPRecolorsPro.DT_X82Torso'
     DryFireSound=(Sound=Sound'BallisticSounds3.Misc.DryRifle',Volume=1.000000)	 
     KickForce=0
     PenetrateForce=0
     bPenetrate=False
     MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
     FlashScaleFactor=0.400000
     BrassClass=Class'BWBPRecolorsPro.Brass_X82rifle'
     BrassBone="breach"
     BrassOffset=(X=-50.000000,Y=1.500000,Z=1.500000)
     RecoilPerShot=1024.000000
     VelocityRecoil=255.000000
     FireChaos=0.700000
     BallisticFireSound=(Sound=Sound'PackageSounds4Pro.X82.X82-Fire',Volume=1.400000)
     FireEndAnim=
     FireRate=0.900000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_X82Clip'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     BotRefireRate=0.300000
     WarnTargetPct=0.700000
     aimerror=750.000000
}
