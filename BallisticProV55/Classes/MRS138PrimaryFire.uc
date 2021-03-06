//=============================================================================
// Primaryfire class for the MRS138 Shotgun
//
// Stronger than the M763, but has a shorter range, wider spread and slower fire rate.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class MRS138PrimaryFire extends BallisticProShotgunFire;

defaultproperties
{
     HipSpreadFactor=2.500000
     CutOffDistance=1536.000000
     CutOffStartRange=256.000000
     TraceCount=8
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     TraceRange=(Min=4000.000000,Max=6000.000000)
     MaxWaterTraceRange=128	 	 
	 RangeAtten=0.200000
	 WaterRangeAtten=0.800000	
     PDamageFactor=0.700000
     WallPDamageFactor=0.950000	 
     WallPenetrationForce=20.000000
     KickForce=0
     PenetrateForce=0
     bPenetrate=False	 
     Damage=13.000000
     DamageHead=20.000000
     DamageLimb=13.000000
     DamageType=Class'BallisticProV55.DT_MRS138Body'
     DamageTypeHead=Class'BallisticProV55.DT_MRS138Head'
     DamageTypeArm=Class'BallisticProV55.DT_MRS138Body'
     DryFireSound=(Sound=Sound'BallisticProSounds.Effects.DryRifle',Volume=0.700000,Radius=32.000000,Pitch=1.000000) 					
     MuzzleFlashClass=Class'BallisticProV55.MRS138FlashEmitter'
     FlashScaleFactor=0.400000
     BrassClass=Class'BallisticProV55.Brass_MRS138Shotgun'
     BrassOffset=(X=18.000000,Y=-7.500000,Z=16.000000)
     AimedFireAnim="SightFireCombined"	 
     RecoilPerShot=512.000000
     VelocityRecoil=0.000000 	 
     FireChaos=0.400000
     FireChaosCurve=(Points=((InVal=0.000000,OutVal=1.000000),(InVal=1.000000,OutVal=1.000000)))	 	 
     XInaccuracy=256.000000
     YInaccuracy=256.000000
     BallisticFireSound=(Sound=Sound'BallisticProSounds.MRS138.MRS138-Fire',Volume=1.500000,Radius=32.000000,Pitch=1.000000)
     FireAnim="FireCombined"
     FireRate=0.500000
     AmmoClass=Class'BallisticProV55.Ammo_MRS138Shotgun'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
	 BotRefireRate=0.700000
     WarnTargetPct=0.500000 
     aimerror=750.000000
}
