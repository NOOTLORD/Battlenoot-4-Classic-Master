//=============================================================================
// Primaryfire class for the GRS9 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class GRS9PrimaryFire extends BallisticRangeAttenFire;

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
     CutOffStartRange=256.000000
     TraceRange=(Min=4000.000000,Max=4000.000000)
     Damage=20.000000
     DamageHead=25.000000
     DamageLimb=20.000000
     RangeAtten=0.200000
     WaterRangeAtten=0.500000
     DamageType=Class'BallisticProV55.DT_GRS9Pistol'
     DamageTypeHead=Class'BallisticProV55.DT_GRS9PistolHead'
     DamageTypeArm=Class'BallisticProV55.DT_GRS9Pistol'
     DryFireSound=(Sound=Sound'BallisticSounds2.Misc.DryPistol',Volume=1.000000)
     KickForce=0
     PenetrateForce=0
     bPenetrate=False					
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashScaleFactor=0.525000
     BrassClass=Class'BallisticProV55.Brass_GRS9_Pistol'
     BrassBone="tip"
     BrassOffset=(X=-49.000000,Y=4.250000,Z=2.500000)
     AimedFireAnim="SightFire"	 
     RecoilPerShot=256.000000
     FireChaos=0.140000
     XInaccuracy=96.000000
     YInaccuracy=96.000000
     BallisticFireSound=(Sound=Sound'BallisticSounds1.Glock.Glk-Fire',Volume=1.400000)
     FireEndAnim=
     FireAnimRate=1.500000
     FireRate=0.12500
     AmmoClass=Class'BallisticProV55.Ammo_GRS9_Pistol'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000						 
	 BotRefireRate=0.990000
     aimerror=750.000000
}
