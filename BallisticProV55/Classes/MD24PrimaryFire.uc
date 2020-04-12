//=============================================================================
// Primaryfire class for MD24 Pistol
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class MD24PrimaryFire extends BallisticRangeAttenFire;

//Do the spread on the client side
function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		BW.IdleAnim = 'OpenIdle';
		BW.ReloadAnim = 'OpenReload';
		AimedFireAnim = 'SightOpenFire';
		FireAnim = 'OpenFire';
	}
	else
	{
		BW.IdleAnim = 'Idle';
		BW.ReloadAnim = 'Reload';
		AimedFireAnim = 'SightFire';
		FireAnim = 'Fire';
	}
	super.PlayFiring();
}

defaultproperties
{
     CutOffDistance=1536.000000
     CutOffStartRange=512.000000
     TraceRange=(Min=4000.000000,Max=4000.000000)
     WaterRangeFactor=0.600000
     MaxWallSize=24.000000
     MaxWalls=1
     Damage=22.000000
     DamageHead=44.000000
     DamageLimb=22.000000
     RangeAtten=0.200000
     WaterRangeAtten=0.500000
     DamageType=Class'BallisticProV55.DT_MD24Pistol'
     DamageTypeHead=Class'BallisticProV55.DT_MD24PistolHead'
     DamageTypeArm=Class'BallisticProV55.DT_MD24Pistol'
     DryFireSound=(Sound=Sound'BallisticSounds2.Misc.DryPistol',Volume=1.125000)
     KickForce=0
     PenetrateForce=0
     bPenetrate=False
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashScaleFactor=0.150000
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassOffset=(X=-16.500000,Y=3.500000,Z=-1.000000)
     AimedFireAnim="SightFire"
     RecoilPerShot=512.000000
     FireChaos=0.200000
     XInaccuracy=96.000000
     YInaccuracy=96.000000
     BallisticFireSound=(Sound=Sound'BallisticSounds1.MD24_Fire',Volume=1.750000)
     FireEndAnim=
     FireAnimRate=1.600000
     FireRate=0.220000
     AmmoClass=Class'BallisticProV55.Ammo_MD24_Pistol'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.300000
     aimerror=750.000000
}
