//=============================================================================
// Primaryfire class for M4 Carbine
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class M4PrimaryFire extends BallisticRangeAttenFire;

defaultproperties
{
     CutOffDistance=3072.000000
     CutOffStartRange=1792.000000
     TraceRange=(Min=9000.000000,Max=11000.000000)
     WaterRangeFactor=0.800000
     MaxWallSize=24.000000
     MaxWalls=1
     Damage=20.000000
     DamageHead=40.000000
     DamageLimb=20.000000
     RangeAtten=0.500000
     WaterRangeAtten=0.700000
     DamageType=Class'BWBPRecolorsPro.DT_M4Assault'
     DamageTypeHead=Class'BWBPRecolorsPro.DT_M4AssaultHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DT_M4Assault'
     DryFireSound=(Sound=Sound'BallisticSounds2.D49.D49-DryFire',Volume=0.700000)	 
     KickForce=0
     PenetrateForce=0
     bPenetrate=False
     MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
     FlashScaleFactor=0.750000	 
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassOffset=(X=-20.000000,Y=1.000000)
     RecoilPerShot=128.000000
     FireChaos=0.035000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))	 
     XInaccuracy=40.000000
     YInaccuracy=40.000000
     BallisticFireSound=(Sound=Sound'BallisticRecolorsSounds.M4A1.M4A1-Fire',Volume=0.975000)
     bPawnRapidFireAnim=True
     FireEndAnim=
     AmmoClass=Class'BWBPRecolorsPro.Ammo_M4_Rifle'	 
     FireRate=0.130000
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     WarnTargetPct=0.200000
     aimerror=750.000000
}
