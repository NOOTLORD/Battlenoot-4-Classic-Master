//=============================================================================
// Primaryfire class for the RS8 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class RS8PrimaryFire extends BallisticRangeAttenFire;

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
	 TraceRange=(Min=4000.000000,Max=4000.000000)
     CutOffDistance=2048.000000
     CutOffStartRange=512.000000
     Damage=27.000000
     DamageHead=40.000000
     DamageLimb=27.000000
     RangeAtten=0.250000
     WaterRangeAtten=0.400000
     DamageType=Class'BallisticProV55.DT_RS8Pistol'
     DamageTypeHead=Class'BallisticProV55.DT_RS8PistolHead'
     DamageTypeArm=Class'BallisticProV55.DT_RS8Pistol'
     DryFireSound=(Sound=Sound'BallisticSounds2.Misc.DryPistol',Volume=1.000000)	 
     KickForce=0
     PenetrateForce=0
     bPenetrate=False
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashBone="Muzzle"
     FlashScaleFactor=0.350000
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassOffset=(X=-34.000000,Y=4.500000,Z=2.500000)
     AimedFireAnim="SightFire"	 
     RecoilPerShot=768.000000
     FireChaos=0.250000
     XInaccuracy=96.000000
     YInaccuracy=96.000000
     BallisticFireSound=(Sound=Sound'BallisticSounds1.Pistol.RSP-Fire',Volume=1.750000)
     bPawnRapidFireAnim=True
	 FireEndAnim=
     FireAnimRate=1.500000
     FireRate=0.225000
     AmmoClass=Class'BallisticProV55.Ammo_RS8_Pistol'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     BotRefireRate=0.750000
     aimerror=750.000000
}
