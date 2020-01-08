//=============================================================================
// R9PrimaryFire.
//
// Accurate medium-high power rifle fire.
// Unwieldy from the hip.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class R9PrimaryFire extends BallisticRangeAttenFire;

#exec OBJ LOAD File="BallisticProSounds.uax"

//// server propagation of firing ////
function ServerPlayFiring()
{
	if (BallisticFireSound.Sound != None)
	{
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	}
	
	CheckClipFinished();

	if (AimedFireAnim != '')
	{
		BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
		if (BW.BlendFire())		
			BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, 1, "AIMEDFIRE");
	}

	else
	{
		if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
			BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
		else BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	}
}

//Do the spread on the client side
function PlayFiring()
{
	if (ScopeDownOn == SDO_Fire)
		BW.TemporaryScopeDown(0.5, 0.9);
		
	if (AimedFireAnim != '')
	{
		BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
		if (BW.BlendFire())		
			BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, 1, "AIMEDFIRE");
	}

	else
	{
		if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
			BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
		else BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	}
	
    FireCount++;
	
	// End code from normal PlayFiring()

	if (BallisticFireSound.Sound != None)
	{
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	}
	
	CheckClipFinished();
}

defaultproperties
{
     CutOffStartRange=4096
	 CutOffDistance=8192
	 RangeAtten=0.5
     TraceRange=(Min=30000.000000,Max=30000.000000)
     WaterRangeFactor=0.800000
     MaxWallSize=64.000000
     MaxWalls=1  
     Damage=65.000000
     DamageHead=130.000000
     DamageLimb=65.000000
     WaterRangeAtten=0.800000
     DamageType=Class'BallisticProV55.DTR9Rifle'
     DamageTypeHead=Class'BallisticProV55.DTR9RifleHead'
     DamageTypeArm=Class'BallisticProV55.DTR9Rifle'
     KickForce=0
     PenetrateForce=0
     bPenetrate=False										  					
     ClipFinishSound=(Sound=Sound'BallisticSounds3.NRP57.NRP57-ClipOut',Volume=0.700000,Radius=48.000000,Pitch=1.250000,bAtten=True)
     DryFireSound=(Sound=Sound'BallisticSounds3.Misc.DryRifle',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.R9FlashEmitter'
     FlashScaleFactor=0.900000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassOffset=(X=-50.000000,Y=-2.000000,Z=4.000000)
     AimedFireAnim="AimedFire"
     RecoilPerShot=384.000000
     FireChaos=0.450000
     BallisticFireSound=(Sound=Sound'BallisticSounds3.USSR.USSR-Fire',Volume=2.000000)
     FireEndAnim=
     FireRate=0.300000
     AmmoClass=Class'BallisticProV55.Ammo_R9Clip'
     ShakeRotMag=(X=400.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=0.000000						  
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=0.000000							 
     BotRefireRate=0.150000
     WarnTargetPct=0.050000
     aimerror=600.000000
}
