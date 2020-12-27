//=============================================================================
// Primaryfire class for the SK410 Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class SK410PrimaryFire extends BallisticProShotgunFire;

defaultproperties
{
     HipSpreadFactor=1.50000
     CutOffDistance=1536.000000
     CutOffStartRange=768.000000
     TraceCount=6
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     TraceRange=(Min=4000.000000,Max=6000.000000)
     MaxWaterTraceRange=128		 
     RangeAtten=0.350000
	 WaterRangeAtten=0.800000	
     WallPDamageFactor=0.950000 
     WallPenetrationForce=64.000000
     KickForce=0
     PenetrateForce=0
     bPenetrate=False	 
     Damage=11.000000
     DamageHead=11.000000
     DamageLimb=11.000000
     DamageType=Class'BallisticProV55Recolors.DT_SK410Body'
     DamageTypeHead=Class'BallisticProV55Recolors.DT_SK410Head'
     DamageTypeArm=Class'BallisticProV55Recolors.DT_SK410Body'
     DryFireSound=(Sound=Sound'BallisticProSounds.Effects.DryRifle',Volume=0.650000,Radius=32.000000,Pitch=1.000000)
     MuzzleFlashClass=Class'BallisticProV55Recolors.SK410MuzzleFlash'
     FlashScaleFactor=0.750000
     BrassClass=Class'BallisticProV55Recolors.Brass_SK410Shotgun'
     BrassOffset=(X=-48.000000,Y=2.500000,Z=-3.500000)
     AimedFireAnim="SightFire"
     RecoilPerShot=378.000000
     VelocityRecoil=0.000000 	 
     FireChaos=0.400000
     FireChaosCurve=(Points=((InVal=0.000000,OutVal=1.000000),(InVal=1.000000,OutVal=1.000000)))	 	 
     XInaccuracy=256.000000
     YInaccuracy=256.000000
     BallisticFireSound=(Sound=Sound'BallisticProRecolorsSounds.SK410.SK410-Fire',Volume=1.600000)
     FireAnimRate=1.750000
     FireRate=0.225000
     AmmoClass=Class'BallisticProV55Recolors.Ammo_SK410Shotgun'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.500000	 
     aimerror=750.000000
}
