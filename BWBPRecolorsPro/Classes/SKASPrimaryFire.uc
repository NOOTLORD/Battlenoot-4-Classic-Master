//=============================================================================
// SKASPrimaryFire
//
// Powerful shotgun blast with moderate spread and fair range for a shotgun.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SKASPrimaryFire extends BallisticProShotgunFire;

defaultproperties
{
     CutOffDistance=3072.000000
     CutOffStartRange=1280.000000
     TraceCount=7
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     TraceRange=(Min=7000.000000,Max=7000.000000)
     MaxWalls=1
     Damage=13.000000
     DamageHead=26.000000
     DamageLimb=13.000000
     RangeAtten=0.250000
     DamageType=Class'BWBPRecolorsPro.DTSKASShotgun'
     DamageTypeHead=Class'BWBPRecolorsPro.DTSKASShotgunHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DTSKASShotgun'
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
     FlashScaleFactor=1.250000
     BrassClass=Class'BallisticProV55.Brass_MRS138Shotgun'
     BrassOffset=(X=-21.000000,Y=-2.000000,Z=-1.000000)
     RecoilPerShot=450.000000
     VelocityRecoil=180.000000
     FireChaos=0.030000
     XInaccuracy=310.000000
     YInaccuracy=310.000000
     BallisticFireSound=(Sound=Sound'PackageSounds4Pro.SKAS.SKAS-Single',Volume=2.000000)
     FireAnim="FireRot"
     FireEndAnim=
     FireAnimRate=1.500000
     FireRate=0.300000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_SKASshotgun'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
	 ShakeRotTime=0.000000					  
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
	 ShakeOffsetTime=0.000000						 
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
     aimerror=600.000000
}
