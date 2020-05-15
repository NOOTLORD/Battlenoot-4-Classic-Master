//=============================================================================
// Primaryfire class for SK-410 Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class SK410PrimaryFire extends BallisticProShotgunFire;

defaultproperties
{
     HipSpreadFactor=2.000000
     CutOffDistance=1536.000000
     CutOffStartRange=378.000000
     MaxSpreadFactor=6
     TraceCount=6
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     TraceRange=(Min=4000.000000,Max=6000.000000)
     MaxWalls=1
     MaxWallSize=24.000000 
     Damage=14.000000
     DamageHead=14.000000
     DamageLimb=14.000000
     RangeAtten=0.400000
     DamageType=Class'BWBPRecolorsPro.DT_SK410Shotgun'
     DamageTypeHead=Class'BWBPRecolorsPro.DT_SK410ShotgunHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DT_SK410Shotgun'
     DryFireSound=(Sound=Sound'BallisticSounds2.Misc.DryRifle',Volume=0.650000)
     KickForce=0
     PenetrateForce=0
     bPenetrate=False
     MuzzleFlashClass=Class'BWBPRecolorsPro.SK410HeatEmitter'
     FlashScaleFactor=0.750000
     BrassClass=Class'BWBPRecolorsPro.Brass_SK410_Shotgun'
     BrassOffset=(X=-48.000000,Y=2.500000,Z=-3.500000)
     AimedFireAnim="SightFire"
     RecoilPerShot=400.000000
     FireChaos=0.150000
     XInaccuracy=200.000000
     YInaccuracy=200.000000
     BallisticFireSound=(Sound=Sound'BallisticRecolorsSounds.SK410.SK410-Fire',Volume=1.600000)
     FireEndAnim=
     FireAnimRate=2.250000
     FireRate=0.220000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_SK410_Shotgun'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     BotRefireRate=0.900000
     aimerror=750.000000
}
