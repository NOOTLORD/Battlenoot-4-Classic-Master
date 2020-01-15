//=============================================================================
// GRS9PrimaryFire.
//
// Low power, low range, low recoil pistol fire
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
     CutOffDistance=1536.000000
     CutOffStartRange=256.000000
     TraceRange=(Min=4000.000000,Max=4000.000000)
     WaterRangeFactor=0.600000
     MaxWallSize=24.000000
     MaxWalls=1
     Damage=22.000000
     DamageHead=44.000000
     DamageLimb=22.000000
     RangeAtten=0.200000
     WaterRangeAtten=0.500000
     DamageType=Class'BallisticProV55.DTGRS9Pistol'
     DamageTypeHead=Class'BallisticProV55.DTGRS9PistolHead'
     DamageTypeArm=Class'BallisticProV55.DTGRS9Pistol'
     DryFireSound=(Sound=Sound'BallisticSounds3.Misc.DryPistol',Volume=1.500000)
     PenetrateForce=0
     bPenetrate=False					
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashScaleFactor=0.525000
     BrassClass=Class'BallisticProV55.Brass_GRSNine'
     BrassBone="tip"
     BrassOffset=(X=-42.500000,Y=7.000000,Z=2.500000)
     RecoilPerShot=256.000000
     FireChaos=0.140000
     XInaccuracy=96.000000
     YInaccuracy=96.000000
     BallisticFireSound=(Sound=Sound'BWBP4-Sounds.Glock.Glk-Fire',Volume=2.000000)
     FireEndAnim=
     FireAnimRate=1.500000
     FireRate=0.180000
     AmmoClass=Class'BallisticProV55.Ammo_GRS9Clip'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=0.000000						  
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=0.000000							 
	 BotRefireRate=0.99
     WarnTargetPct=0.2
     aimerror=750.000000
}
