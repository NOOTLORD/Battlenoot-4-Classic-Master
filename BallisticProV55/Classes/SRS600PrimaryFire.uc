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
     WallPenetrationForce=24.000000
     Damage=40.000000
     DamageHead=80.000000
     DamageLimb=40.000000
     RangeAtten=0.450000
     WaterRangeAtten=0.800000
     DamageType=Class'BallisticProV55.DT_SRS600Rifle'
     DamageTypeHead=Class'BallisticProV55.DT_SRS600RifleHead'
     DamageTypeArm=Class'BallisticProV55.DT_SRS600Rifle'
     DryFireSound=(Sound=Sound'BallisticSounds2.Misc.DryRifle',Volume=1.000000)
     KickForce=0
     PenetrateForce=0
     bPenetrate=False
     ClipFinishSound=(Sound=Sound'BallisticSounds2.Misc.ClipEnd-1',Volume=1.000000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
     FlashScaleFactor=0.350000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassOffset=(X=-15.000000,Y=1.000000,Z=0.000000)
     AimedFireAnim="AimedFire"
     RecoilPerShot=240.000000
     FireChaos=0.065000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     XInaccuracy=32.000000
     YInaccuracy=32.000000
     SilencedFireSound=(Sound=Sound'BallisticSounds1.SRS600.SRS-SilenceFire',Volume=0.700000,Radius=128.000000,bAtten=True)
     BallisticFireSound=(Sound=Sound'BallisticSounds1.SRS600.SRS-Fire',Volume=1.600000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireRate=0.170000
     AmmoClass=Class'BallisticProV55.Ammo_SRS600_Rifle'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     WarnTargetPct=0.200000	 
     aimerror=750.000000
}
