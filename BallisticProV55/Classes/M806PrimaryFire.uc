//=============================================================================
// M806PrimaryFire.
//
// Decent pistol shots that are accurate if the gun is steady enough
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M806PrimaryFire extends BallisticRangeAttenFire;

//Do the spread on the client side
function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 2)
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
     CutOffDistance=1500.000000
     CutOffStartRange=2048.000000
     TraceRange=(Max=6000.000000)
     WaterRangeFactor=0.600000
     MaxWallSize=24.000000
     MaxWalls=2
     Damage=35.000000
     DamageHead=55.000000
     DamageLimb=35.000000
     RangeAtten=0.750000
     WaterRangeAtten=0.500000
     DamageType=Class'BallisticProV55.DTM806Pistol'
     DamageTypeHead=Class'BallisticProV55.DTM806PistolHead'
     DamageTypeArm=Class'BallisticProV55.DTM806Pistol'
     KickForce=6000
     PenetrateForce=150
     bPenetrate=True
     MuzzleFlashClass=Class'BallisticProV55.M806FlashEmitter'
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassBone="tip"
     BrassOffset=(X=-30.000000,Y=1.000000)
     RecoilPerShot=3072.000000
     BallisticFireSound=(Sound=Sound'BallisticSounds3.M806.M806Fire',Volume=0.700000)
     FireEndAnim=
     FireRate=0.200000
     AmmoClass=Class'BallisticProV55.Ammo_45HV'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
}
