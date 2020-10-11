//=============================================================================
// Primaryfire class for the XRS10 SubMachinegun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved. 
//
// Modified by (NL)NOOTLORD 						   
//=============================================================================
class XRS10PrimaryFire extends BallisticRangeAttenFire;

defaultproperties
{
     CutOffDistance=1536.000000
     CutOffStartRange=768.000000
     WallPenetrationForce=8.000000
     Damage=25.000000
     DamageHead=25.000000
     DamageLimb=25.000000
     RangeAtten=0.250000
     WaterRangeAtten=0.400000
     DamageType=Class'BallisticProV55.DT_XRS10SMG'
     DamageTypeHead=Class'BallisticProV55.DT_XRS10SMGHead'
     DamageTypeArm=Class'BallisticProV55.DT_XRS10SMG'
     DryFireSound=(Sound=Sound'BallisticSounds2.Misc.DryRifle',Volume=0.750000)	 
     KickForce=0
     PenetrateForce=0
     bPenetrate=False
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashScaleFactor=0.400000
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassOffset=(X=-39.000000,Y=1.500000,Z=0.500000)
     AimedFireAnim="SightFire"
     RecoilPerShot=190.000000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.320000,OutVal=1),(InVal=0.500000,OutVal=1.500000),(InVal=1.000000,OutVal=2.250000)))
     XInaccuracy=64.000000
     YInaccuracy=64.000000
     BallisticFireSound=(Sound=Sound'BallisticSounds1.TEC.TEC-Fire',Volume=1.700000)
     bPawnRapidFireAnim=True
     FireRate=0.090000
     AmmoClass=Class'BallisticProV55.Ammo_XRS10_SMG'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     aimerror=750.000000
}
