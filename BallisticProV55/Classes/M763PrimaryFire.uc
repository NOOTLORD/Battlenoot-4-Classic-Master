//=============================================================================
// Primaryfire class for the M763 Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class M763PrimaryFire extends BallisticProShotgunFire;


function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		AimedFireAnim = 'SightFire';
		FireAnim = 'Fire';
	}
	else
	{
		AimedFireAnim='FireCombinedSight';
		FireAnim = 'FireCombined';
	}
	super.PlayFiring();
}

function ServerPlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		AimedFireAnim = 'SightFire';
		FireAnim = 'Fire';
	}
	else
	{
		AimedFireAnim='FireCombinedSight';
		FireAnim = 'FireCombined';
	}
	super.ServerPlayFiring();
}

defaultproperties
{
     HipSpreadFactor=3.000000
     CutOffDistance=2536.000000
     CutOffStartRange=1280.000000
     TraceCount=7
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     TraceRange=(Min=7500.000000,Max=7500.000000)
     MaxWaterTraceRange=128	 
     RangeAtten=0.25000	
     WaterRangeAtten=0.800000
     PDamageFactor=0.700000
     WallPDamageFactor=0.950000 
     WallPenetrationForce=64.000000
     KickForce=0
     PenetrateForce=0
     bPenetrate=False	 
     Damage=15.000000
     DamageHead=15.000000
     DamageLimb=15.000000
     DamageType=Class'BallisticProV55.DT_M763Body'
     DamageTypeHead=Class'BallisticProV55.DT_M763Head'
     DamageTypeArm=Class'BallisticProV55.DT_M763Body'
     DryFireSound=(Sound=Sound'BallisticProSounds.Effects.DryRifle',Volume=0.7500000,Radius=32.000000,Pitch=1.000000)	 			   					 					
     MuzzleFlashClass=Class'BallisticProV55.M763FlashEmitter'
     FlashScaleFactor=0.390000
     BrassClass=Class'BallisticProV55.Brass_Shotgun'
     BrassOffset=(X=-40.000000,Y=1.000000,Z=3.000000)
     AimedFireAnim="FireCombinedSight"
     RecoilPerShot=768.000000
     VelocityRecoil=0.000000 	 
     FireChaos=0.400000
     FireChaosCurve=(Points=((InVal=0.000000,OutVal=1.000000),(InVal=1.000000,OutVal=1.000000)))	 	 
     XInaccuracy=128.000000
     YInaccuracy=128.000000
     BallisticFireSound=(Sound=Sound'BallisticProSounds.M763.M763-Fire',Volume=1.900000,Radius=32.000000,Pitch=1.000000)
     FireAnim="FireCombined"
     FireAnimRate=1.000000
     FireRate=0.750000
     AmmoClass=Class'BallisticProV55.Ammo_M763Shotgun'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     BotRefireRate=0.700000
     WarnTargetPct=0.500000	 
     aimerror=750.000000
}
