//=============================================================================
// Primaryfire class for the M50 Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class M50PrimaryFire extends BallisticRangeAttenFire;

defaultproperties
{
     CutOffDistance=3072.000000
     CutOffStartRange=1536.000000
     TraceRange=(Min=12000.000000,Max=15000.000000)
     MaxWaterTraceRange=128	 	 
     RangeAtten=0.350000
     WaterRangeAtten=0.800000
     PDamageFactor=0.700000
     WallPDamageFactor=0.950000	 
     WallPenetrationForce=16.000000
     KickForce=0
     PenetrateForce=0
     bPenetrate=False	 
     Damage=20.000000
     DamageHead=40.000000
     DamageLimb=20.000000	 
     DamageType=Class'BallisticProV55.DT_M50Body'
     DamageTypeHead=Class'BallisticProV55.DT_M50Head'				        
	 DamageTypeArm=Class'BallisticProV55.DT_M50Body'	
     DryFireSound=(Sound=Sound'BallisticProSounds.Effects.DryRifle',Volume=1.000000,Radius=32.000000,Pitch=1.000000) 	 
     MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
     FlashScaleFactor=0.550000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassOffset=(X=-10.000000,Y=0.000000,Z=-4.000000)
     AimedFireAnim="SightFire"
     RecoilPerShot=145.000000
     VelocityRecoil=0.000000	 
     FireChaos=0.040000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     XInaccuracy=48.000000
     YInaccuracy=48.000000
     BallisticFireSound=(Sound=Sound'BallisticProSounds.M50.M50-Fire',Volume=0.900000,Slot=SLOT_Interact,bNoOverride=False)
     FireRate=0.110000
     bPawnRapidFireAnim=True	 
     AmmoClass=Class'BallisticProV55.Ammo_M50Rifle'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     WarnTargetPct=0.200000	 
     aimerror=750.000000
}
