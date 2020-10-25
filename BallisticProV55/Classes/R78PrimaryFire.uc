//=============================================================================
// Primaryfire class for the R78 Sniper Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class R78PrimaryFire extends BallisticRangeAttenFire;

defaultproperties
{
     CutOffStartRange=4096.000000
	 CutOffDistance=8192.000000
     TraceRange=(Min=30000.000000,Max=30000.000000)
     MaxWaterTraceRange=128		 
	 RangeAtten=0.500000	 
     WaterRangeAtten=0.800000
     PDamageFactor=0.700000
     WallPDamageFactor=0.950000 	 
	 WallPenetrationForce=0	 
     KickForce=0
     PenetrateForce=0
     bPenetrate=False	 
     Damage=80.000000
     DamageHead=160.000000
     DamageLimb=80.000000 
     DamageType=Class'BallisticProV55.DT_R78Rifle'
     DamageTypeHead=Class'BallisticProV55.DT_R78RifleHead'
     DamageTypeArm=Class'BallisticProV55.DT_R78Rifle'
     DryFireSound=(Sound=Sound'BallisticSounds2.Misc.DryRifle',Volume=0.900000,Radius=32.000000,Pitch=1.000000)
     bCockAfterFire=True
     MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
     FlashScaleFactor=0.800000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     bBrassOnCock=True
     BrassOffset=(X=-48.000000,Y=-6.000000,Z=6.500000)
     RecoilPerShot=1536.000000
     VelocityRecoil=0.000000 	 
     FireChaos=0.500000
     FireChaosCurve=(Points=((InVal=0.000000,OutVal=1.000000),(InVal=1.000000,OutVal=1.000000)))	 	 
     XInaccuracy=32.000000
     YInaccuracy=32.000000	 
     BallisticFireSound=(Sound=Sound'BallisticSounds2.R78.R78-Fire',Volume=1.650000,Radius=32.000000,Pitch=1.000000)			 
     FireRate=1.000000
     AmmoClass=Class'BallisticProV55.Ammo_R78_Sniper'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
	 BotRefireRate=0.400000
	 WarnTargetPct=0.500000 
     aimerror=750.000000
}
