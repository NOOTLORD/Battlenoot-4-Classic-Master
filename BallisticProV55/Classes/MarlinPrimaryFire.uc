//=============================================================================
// Primaryfire class for the Marlin Rifle
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
	 CutOffStartRange=3072.000000
	 CutOffDistance=6144.000000
     TraceRange=(Min=30000.000000,Max=30000.000000)
     MaxWaterTraceRange=128	 	
	 RangeAtten=0.500000
     WaterRangeAtten=0.800000
     PDamageFactor=0.700000
     WallPDamageFactor=0.950000 	 
     WallPenetrationForce=24.000000
	 KickForce=0
     PenetrateForce=0
     bPenetrate=False 
     Damage=60.000000
     DamageHead=120.000000
     DamageLimb=60.000000
     DamageType=Class'BallisticProV55.DT_MarlinRifle'
     DamageTypeHead=Class'BallisticProV55.DT_MarlinRifleHead'
     DamageTypeArm=Class'BallisticProV55.DT_MarlinRifle'
     DryFireSound=(Sound=Sound'BallisticSounds2.Misc.DryRifle',Volume=1.000000,Radius=32.000000,Pitch=1.000000)	 
     bCockAfterFire=True
     MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
     FlashScaleFactor=0.900000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassOffset=(X=-108.000000,Y=-18.500000,Z=14.500000)
     bBrassOnCock=True	 
     AimedFireAnim="SightFireCock"
     RecoilPerShot=1536.000000
     VelocityRecoil=0.000000 	 
     FireChaos=0.800000
     FireChaosCurve=(Points=((InVal=0.000000,OutVal=1.000000),(InVal=1.000000,OutVal=1.000000)))	 	 
     XInaccuracy=32.000000
     YInaccuracy=32.000000
     BallisticFireSound=(Sound=Sound'BallisticSounds1.Marlin.Marlin-Fire',Volume=1.000000,Radius=32.000000,Pitch=1.000000)
     FireAnimRate=1.250000
     FireRate=0.900000
     AmmoClass=Class'BallisticProV55.Ammo_Marlin_Rifle'
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
