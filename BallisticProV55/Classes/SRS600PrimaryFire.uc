//=============================================================================
// Primaryfire class for the SRS-600-Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class SRS600PrimaryFire extends BallisticRangeAttenFire;

defaultproperties
{
     CutOffDistance=6144.000000
     CutOffStartRange=3072.000000
     TraceRange=(Min=30000.000000,Max=30000.000000)
     MaxWaterTraceRange=128	
     RangeAtten=0.450000
     WaterRangeAtten=0.800000 	 
     WallPenetrationForce=24.000000
     KickForce=0
     PenetrateForce=0
     bPenetrate=False	 
     Damage=40.000000
     DamageHead=80.000000
     DamageLimb=40.000000
     DamageType=Class'BallisticProV55.DT_SRS600Body'
     DamageTypeHead=Class'BallisticProV55.DT_SRS600Head'
     DamageTypeArm=Class'BallisticProV55.DT_SRS600Body'
     DryFireSound=(Sound=Sound'BallisticProSounds.Effects.DryRifle',Volume=1.000000,Radius=32.000000,Pitch=1.000000)
     ClipFinishSound=(Sound=Sound'BallisticProSounds.Effects.ClipEnd1',Volume=1.000000,Radius=32.000000,Pitch=1.000000)
     MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
     FlashScaleFactor=0.350000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassOffset=(X=-15.000000,Y=1.000000,Z=0.000000)
     AimedFireAnim="SightFire"
     RecoilPerShot=240.000000
     VelocityRecoil=0.000000 	 
     FireChaos=0.065000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     XInaccuracy=32.000000
     YInaccuracy=32.000000
     BallisticFireSound=(Sound=Sound'BallisticProSounds.SRS-600.SRS-600-Fire',Volume=1.600000,Slot=SLOT_Interact,bNoOverride=False)
     FireRate=0.170000
     AmmoClass=Class'BallisticProV55.Ammo_SRS600Rifle'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     WarnTargetPct=0.200000	 
     aimerror=750.000000
}
