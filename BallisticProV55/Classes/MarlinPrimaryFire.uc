//=============================================================================
// MarlinPrimaryFire.
//
// Accurate rifle fire for Deermaster
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class MarlinPrimaryFire extends BallisticRangeAttenFire;

//// server propagation of firing ////
function ServerPlayFiring()
{
	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();

	if (AimedFireAnim != '')
	{
		if (!BW.bScopeView)
			BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
		else
			BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, , "AIMEDFIRE");
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
		if (!BW.bScopeView)
			BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
		else
			BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, , "AIMEDFIRE");
	}

	else
	{
		if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
			BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
		else BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	}
	
    ClientPlayForceFeedback(FireForce);  // jdf											   
    FireCount++;
	
	// End code from normal PlayFiring()

	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();
}

defaultproperties
{
	 CutOffStartRange=3072
	 CutOffDistance=6144
	 RangeAtten=0.5
     TraceRange=(Min=30000.000000,Max=30000.000000)
     WaterRangeFactor=0.800000
     MaxWallSize=24.000000
     MaxWalls=1
     Damage=60.000000
     DamageHead=120.000000
     DamageLimb=60.000000
     WaterRangeAtten=0.800000
     DamageType=Class'BallisticProV55.DTMarlinRifle'
     DamageTypeHead=Class'BallisticProV55.DTMarlinRifleHead'
     DamageTypeArm=Class'BallisticProV55.DTMarlinRifle'
     DryFireSound=(Volume=0.700000)
	 KickForce=0
     PenetrateForce=0
     bPenetrate=False
     bCockAfterFire=True
     MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
     FlashScaleFactor=0.900000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     bBrassOnCock=True
     BrassOffset=(X=-100.000000,Y=-20.000000,Z=15.000000)
     AimedFireAnim="SightFireCock"
     RecoilPerShot=1536.000000
     FireChaos=0.800000
     BallisticFireSound=(Sound=Sound'BWBP4-Sounds.Marlin.Mar-Fire',Volume=2.000000)
     FireEndAnim=
     FireAnimRate=1.250000
     FireRate=0.900000
     AmmoClass=Class'BallisticProV55.Ammo_MarlinBullet'
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
