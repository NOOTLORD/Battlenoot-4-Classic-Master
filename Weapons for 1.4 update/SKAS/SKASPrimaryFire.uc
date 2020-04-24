//=============================================================================
// Primaryfire class for SKAS-21 Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class SKASPrimaryFire extends BallisticProShotgunFire;

defaultproperties
{
     CutOffDistance=1536.000000
     CutOffStartRange=378.000000
     TraceCount=6
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     TraceRange=(Min=4000.000000,Max=6000.000000)
     MaxWalls=1
     MaxWallSize=24.000000	 
     Damage=10.000000
     DamageHead=20.000000
     DamageLimb=10.000000
     RangeAtten=0.400000
     DamageType=Class'BWBPRecolorsPro.DT_SKASShotgun'
     DamageTypeHead=Class'BWBPRecolorsPro.DT_SKASShotgunHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DT_SKASShotgun'
     DryFireSound=(Sound=Sound'BallisticSounds2.Misc.DryRifle',Volume=0.650000) 
     KickForce=0
     PenetrateForce=0
     bPenetrate=False
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
     FlashScaleFactor=1.150000
     BrassClass=Class'BallisticProV55.Brass_MRS138_Shotgun'
     BrassOffset=(X=-21.000000,Y=-2.000000,Z=-1.000000)
     RecoilPerShot=225.000000
     VelocityRecoil=0.000000
     FireChaos=0.150000
     XInaccuracy=200.000000
     YInaccuracy=200.000000
     BallisticFireSound=(Sound=Sound'BallisticRecolorsSounds.SKAS.SKAS-Fire',Volume=1.600000)
     FireAnim="FireRot"
     FireEndAnim=
     FireAnimRate=1.500000
     FireRate=0.300000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_SKAS_Shotgun'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     BotRefireRate=0.800000
     WarnTargetPct=0.400000
     aimerror=750.000000
}
