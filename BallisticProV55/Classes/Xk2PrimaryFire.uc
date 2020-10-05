//=============================================================================
// Primaryfire class for the XK2 SubMachinegun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class XK2PrimaryFire extends BallisticRangeAttenFire;

defaultproperties
{
     CutOffDistance=2560.000000
     CutOffStartRange=1024.000000
     Damage=20.000000
     DamageHead=40.000000
     DamageLimb=20.000000
     RangeAtten=0.250000
     WaterRangeAtten=0.600000
     DamageType=Class'BallisticProV55.DT_XK2SMG'
     DamageTypeHead=Class'BallisticProV55.DT_XK2SMGHead'
     DamageTypeArm=Class'BallisticProV55.DT_XK2SMG'
     DryFireSound=(Sound=Sound'BallisticSounds2.Misc.DryRifle',Volume=1.000000)	 
     KickForce=0
     PenetrateForce=0
     bPenetrate=False
     bDryUncock=True
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashBone="Muzzle"
     FlashScaleFactor=0.400000
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassOffset=(X=-47.500000,Y=-1.000000,Z=1.750000)
     AimedFireAnim="SightFire"
     RecoilPerShot=98.000000
     FireChaos=0.050000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.240000,OutVal=1),(InVal=0.350000,OutVal=1.500000),(InVal=0.660000,OutVal=2.250000),(InVal=1.000000,OutVal=3.500000)))
     XInaccuracy=48.000000
     YInaccuracy=48.000000
     SilencedFireSound=(Sound=Sound'BallisticSounds2.XK2.XK2-SilenceFire',Volume=0.750000,bAtten=True)
     BallisticFireSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Fire',Volume=0.600000)
     bPawnRapidFireAnim=True
     FireRate=0.090000
     AmmoClass=Class'BallisticProV55.Ammo_XK2_SMG'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     aimerror=750.000000
}
