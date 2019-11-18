//=============================================================================
// AH208PrimaryFire.
// The Pro equivalent of the Golden Gun.
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
     MaxWallSize=32.000000
     MaxWalls=1
     Damage=90.000000
     DamageHead=135.000000
     DamageLimb=90.000000
     RangeAtten=0.600000
     WaterRangeAtten=0.800000
     DamageType=Class'BWBPRecolorsPro.DTAH208Pistol'
     DamageTypeHead=Class'BWBPRecolorsPro.DTAH208PistolHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DTAH208Pistol'
     DryFireSound=(Sound=Sound'BallisticSounds3.Misc.DryPistol',Volume=1.000000)
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
     BallisticFireSound=(Sound=Sound'PackageSounds4ProExp.Eagle.Eagle-Fire4',Volume=2.000000)
     FireEndAnim=
     FireRate=0.600000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_44Gold'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=0.000000						  
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=0.000000							 
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
     aimerror=600.000000
}
