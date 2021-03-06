//=============================================================================
// Primaryfire class for the M46 Rifle
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class M46PrimaryFire extends BallisticRangeAttenFire;

defaultproperties
{
     CutOffDistance=3072.000000
     CutOffStartRange=1536.000000
     TraceRange=(Min=12000.000000,Max=15000.000000)
     MaxWaterTraceRange=128	 
     RangeAtten=0.50000
     WaterRangeAtten=0.800000
     PDamageFactor=0.700000
     WallPDamageFactor=0.950000 	 
     WallPenetrationForce=24.000000
     KickForce=0
     PenetrateForce=0
     bPenetrate=False	 
     Damage=30.000000
     DamageHead=60.000000
     DamageLimb=30.000000
     DamageType=Class'BallisticProV55.DT_M46Body'
     DamageTypeHead=Class'BallisticProV55.DT_M46Head'
     DamageTypeArm=Class'BallisticProV55.DT_M46Body'
     DryFireSound=(Sound=Sound'BallisticProSounds.Effects.DryRifle',Volume=1.120000,Radius=32.000000,Pitch=1.000000)	   				
     MuzzleFlashClass=Class'BallisticProV55.M46FlashEmitter'
     FlashScaleFactor=0.400000
     BrassClass=Class'BallisticProV55.Brass_M46Rifle'
     BrassOffset=(X=-17.000000,Y=1.000000,Z=-3.000000)
     AimedFireAnim="SightFire"
     RecoilPerShot=180.000000
     VelocityRecoil=0.000000 	 
     FireChaos=0.045000
	 FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     XInaccuracy=32.000000
     YInaccuracy=32.000000
     BallisticFireSound=(Sound=Sound'BallisticProSounds.M46.M46-Fire',Volume=1.650000,Slot=SLOT_Interact,bNoOverride=False)
     FireRate=0.135000
     bPawnRapidFireAnim=True	 
     AmmoClass=Class'BallisticProV55.Ammo_M46Rifle'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000		
	 BotRefireRate=0.990000
     WarnTargetPct=0.200000	 
     aimerror=750.000000
}
