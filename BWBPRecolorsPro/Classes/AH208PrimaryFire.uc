//=============================================================================
// Main Primaryfire class for AH-208 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class AH208PrimaryFire extends BallisticRangeAttenFire;

//Do the spread on the client side
function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		BW.IdleAnim = 'OpenIdle';
		BW.ReloadAnim = 'OpenReload';
		FireAnim = 'OpenFire';
	}
	else
	{
		BW.IdleAnim = 'Idle';
		BW.ReloadAnim = 'Reload';
		FireAnim = 'Fire';
	}
	super.PlayFiring();
}

defaultproperties
{
     CutOffDistance=6144.000000
     CutOffStartRange=4096.000000
     TraceRange=(Min=15000.000000,Max=15000.000000)
     WaterRangeFactor=0.800000
     MaxWallSize=24.000000
     MaxWalls=1
     Damage=90.000000
     DamageHead=135.000000
     DamageLimb=90.000000
     RangeAtten=0.600000
     WaterRangeAtten=0.800000
     DamageType=Class'BWBPRecolorsPro.DT_AH208Pistol'
     DamageTypeHead=Class'BWBPRecolorsPro.DT_AH208PistolHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DT_AH208Pistol'
     DryFireSound=(Sound=Sound'BallisticSounds3.Misc.DryPistol',Volume=1.125000)
     KickForce=0
     PenetrateForce=0
     bPenetrate=False
     MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
     FlashScaleFactor=0.250000
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassBone="tip"
     BrassOffset=(X=-125.000000,Y=-5.000000,Z=7.500000)
     RecoilPerShot=1024.000000
     VelocityRecoil=300.000000
     FireChaos=0.350000
     XInaccuracy=1.000000
     YInaccuracy=1.000000
     BallisticFireSound=(Sound=Sound'PackageSounds4Pro.Eagle.Eagle-Fire',Volume=1.800000)
     FireEndAnim=
     FireRate=0.600000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_AH208Clip'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
     aimerror=750.000000
}
