//=============================================================================
// Primaryfire class for RS04 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class RS04PrimaryFire extends BallisticRangeAttenFire;

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
     Damage=25.000000
     DamageHead=50.000000
     DamageLimb=25.000000
     RangeAtten=0.200000
     WaterRangeAtten=0.500000
     DamageType=Class'BallisticProV55.DT_RS04Pistol'
     DamageTypeHead=Class'BallisticProV55.DT_RS04PistolHead'
     DamageTypeArm=Class'BallisticProV55.DT_RS04Pistol'
     DryFireSound=(Sound=Sound'BallisticSounds2.Misc.DryPistol',Volume=1.125000)
     KickForce=0
     PenetrateForce=0
     bPenetrate=False
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashScaleFactor=0.300000	 
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassOffset=(X=-35.500000,Z=2.500000)
     AimedFireAnim="SightFire"
     RecoilPerShot=256.000000	 
     FireChaos=0.200000
     XInaccuracy=96.000000
     YInaccuracy=96.000000	 
     BallisticFireSound=(Sound=Sound'BallisticSounds2.RS04.RS04-Fire',Volume=1.200000)
     FireEndAnim=
     FireAnimRate=1.600000
     FireRate=0.220000	 
     AmmoClass=Class'BallisticProV55.Ammo_RS04_Pistol'
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
