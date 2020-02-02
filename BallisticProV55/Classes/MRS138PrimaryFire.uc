//=============================================================================
// Primaryfire class for MRS138 Shotgun
//
// Stronger than the M763, but has a shorter range, wider spread and slower fire rate.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class MRS138PrimaryFire extends BallisticProShotgunFire;

simulated function DestroyEffects()
{
    if (MuzzleFlash != None)
		MuzzleFlash.Destroy();
	Super.DestroyEffects();
}

function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		AimedFireAnim = 'AimedFire';
		FireAnim = 'Fire';
	}
	else
	{
		AimedFireAnim='SightFireCombined';
		FireAnim = 'FireCombined';
	}
	super.PlayFiring();
}

function ServerPlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		AimedFireAnim = 'AimedFire';
		FireAnim = 'Fire';
	}
	else
	{
		AimedFireAnim='SightFireCombined';
		FireAnim = 'FireCombined';
	}
	super.ServerPlayFiring();
}

defaultproperties
{
     CutOffDistance=2048.000000
     CutOffStartRange=1024.000000
     TraceCount=10
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     TracerChance=1.000000
     ImpactManager=Class'BallisticProV55.IM_Shell'
     TraceRange=(Min=7000.000000,Max=7000.000000)
     MaxWallSize=24.000000	 
     MaxWalls=1
     Damage=11.000000
     DamageHead=16.000000
     DamageLimb=11.000000
     RangeAtten=0.200000
     DamageType=Class'BallisticProV55.DTMRS138Shotgun'
     DamageTypeHead=Class'BallisticProV55.DTMRS138ShotgunHead'
     DamageTypeArm=Class'BallisticProV55.DTMRS138Shotgun'
     DryFireSound=(Sound=Sound'BallisticSounds3.Misc.DryRifle',Volume=0.700000)	 
     KickForce=0
     PenetrateForce=0
     bPenetrate=False 					
     MuzzleFlashClass=Class'BallisticProV55.MRS138FlashEmitter'
     FlashScaleFactor=0.400000
     BrassClass=Class'BallisticProV55.Brass_MRS138_Shotgun'
     BrassOffset=(X=34.000000,Y=-7.500000,Z=13.000000)
     RecoilPerShot=1280.000000
     FireChaos=0.400000
     XInaccuracy=250.000000
     YInaccuracy=250.000000
     BallisticFireSound=(Sound=Sound'BWAddPack-RS-Sounds.MRS38.RSS-Fire',Volume=1.500000)
     FireAnim="FireCombined"
     FireEndAnim=
     FireRate=0.430000
     AmmoClass=Class'BallisticProV55.Ammo_MRS138_Shotgun'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
	 BotRefireRate=0.7
     WarnTargetPct=0.5
     aimerror=750.000000
}
