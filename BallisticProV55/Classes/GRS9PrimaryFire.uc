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
     CutOffStartRange=768.000000
     TraceRange=(Min=4000.000000,Max=4000.000000)
     MaxWaterTraceRange=128	 	 
     RangeAtten=0.200000
     WaterRangeAtten=0.500000
     PDamageFactor=0.700000
     WallPDamageFactor=0.950000 	 
     WallPenetrationForce=8.000000
     KickForce=0
     PenetrateForce=0
     bPenetrate=False	 
     Damage=20.000000
     DamageHead=25.000000
     DamageLimb=20.000000
     DamageType=Class'BallisticProV55.DT_GRS9Body'
     DamageTypeHead=Class'BallisticProV55.DT_GRS9Head'
     DamageTypeArm=Class'BallisticProV55.DT_GRS9Body'
     DryFireSound=(Sound=Sound'BallisticProSounds.Effects.DryPistol',Volume=1.000000,Radius=32.000000,Pitch=1.000000)					
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashScaleFactor=0.525000
     BrassClass=Class'BallisticProV55.Brass_GRS9Pistol'
     BrassOffset=(X=-36.000000,Y=1.500000,Z=2.500000)	 
     RecoilPerShot=256.000000
     VelocityRecoil=0.000000 	 
     FireChaos=0.140000
     FireChaosCurve=(Points=((InVal=0.000000,OutVal=1.000000),(InVal=1.000000,OutVal=1.000000)))	 	 
     XInaccuracy=96.000000
     YInaccuracy=96.000000
     BallisticFireSound=(Sound=Sound'BallisticProSounds.GRS-9.GRS-9-Fire',Volume=1.400000,Radius=32.000000,Pitch=1.000000)
     FireAnimRate=1.500000
     FireRate=0.12500
     AmmoClass=Class'BallisticProV55.Ammo_GRS9Pistol'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000						 
	 BotRefireRate=0.990000
     WarnTargetPct=0.200000	 
     aimerror=750.000000
}
