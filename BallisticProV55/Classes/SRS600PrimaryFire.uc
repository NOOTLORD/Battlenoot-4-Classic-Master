//=============================================================================
// Primaryfire class for SRS-600-Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class SRS600PrimaryFire extends BallisticRangeAttenFire;

var() Actor						SMuzzleFlash;		// Silenced Muzzle flash stuff
var() class<Actor>				SMuzzleFlashClass;
var() Name						SFlashBone;
var() float						SFlashScaleFactor;

function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
    if ((MuzzleFlashClass != None) && ((MuzzleFlash == None) || MuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
    if ((SMuzzleFlashClass != None) && ((SMuzzleFlash == None) || SMuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (SMuzzleFlash, SMuzzleFlashClass, Weapon.DrawScale*SFlashScaleFactor, weapon, SFlashBone);
}

//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
    if (!SRS600Rifle(Weapon).bSilenced && MuzzleFlash != None)
        MuzzleFlash.Trigger(Weapon, Instigator);
    else if (SRS600Rifle(Weapon).bSilenced && SMuzzleFlash != None)
        SMuzzleFlash.Trigger(Weapon, Instigator);

	if (!bBrassOnCock)
		EjectBrass();
}

// Remove effects
simulated function DestroyEffects()
{
	Super.DestroyEffects();
	class'BUtil'.static.KillEmitterEffect (SMuzzleFlash);
}
// End effect functions ----------------------------------------------------


simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, SRS600Rifle(Weapon).bSilenced, WaterHitLoc);
}

function ServerPlayFiring()
{
	if (SRS600Rifle(Weapon) != None && SRS600Rifle(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,SilencedFireSound.bNoOverride,SilencedFireSound.Radius,SilencedFireSound.Pitch,SilencedFireSound.bAtten);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

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

	CheckClipFinished();
}

//Do the spread on the client side
function PlayFiring()
{
	if (SRS600Rifle(Weapon).bSilenced)
	{
		Weapon.SetBoneScale (0, 1.0, SRS600Rifle(Weapon).SilencerBone);
	}
	else
	{
		Weapon.SetBoneScale (0, 0.0, SRS600Rifle(Weapon).SilencerBone);
	}

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

    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;

	if (SRS600Rifle(Weapon) != None && SRS600Rifle(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,,SilencedFireSound.Radius,,true);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);

	CheckClipFinished();
}

function SetSilenced(bool bSilenced)
{
	bAISilent = bSilenced;
	if (bSilenced)
	{
		Damage *= 0.65;
		RecoilPerShot *= 0.5;
		BW.RecoilXFactor *= 0.5;
		BW.RecoilYFactor *= 0.5;
		RangeAtten *= 1.55;
		XInaccuracy *= 0.2;
		YInaccuracy *= 0.2;
	}
	else
	{
     	RecoilPerShot = default.RecoilPerShot;
		Damage = default.Damage;
		BW.RecoilXFactor = BW.default.RecoilXFactor;
		BW.RecoilYFactor = BW.default.RecoilYFactor;
		RangeAtten = default.RangeAtten;
		XInaccuracy = default.XInaccuracy;
		YInaccuracy = default.YInaccuracy;
	}
}

defaultproperties
{
     SMuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
     SFlashBone="tip2"
     SFlashScaleFactor=0.500000
     CutOffDistance=6144.000000
     CutOffStartRange=3072.000000
     TraceRange=(Min=30000.000000,Max=30000.000000)
     WaterRangeFactor=0.800000
     MaxWallSize=24.000000
     MaxWalls=1
     Damage=40.000000
     DamageHead=80.000000
     DamageLimb=40.000000
     RangeAtten=0.450000
     WaterRangeAtten=0.800000
     DamageType=Class'BallisticProV55.DT_SRS600Rifle'
     DamageTypeHead=Class'BallisticProV55.DT_SRS600RifleHead'
     DamageTypeArm=Class'BallisticProV55.DT_SRS600Rifle'
     DryFireSound=(Sound=Sound'BallisticSounds2.Misc.DryRifle',Volume=1.000000)
     KickForce=0
     PenetrateForce=0
     bPenetrate=False
     ClipFinishSound=(Sound=Sound'BallisticSounds2.Misc.ClipEnd-1',Volume=1.000000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
     FlashScaleFactor=0.400000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassOffset=(X=-15.000000,Y=1.000000,Z=-1.00000)
     AimedFireAnim="AimedFire"
     RecoilPerShot=240.000000
     FireChaos=0.065000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     XInaccuracy=32.000000
     YInaccuracy=32.000000
     SilencedFireSound=(Sound=Sound'BallisticSounds1.SRS600.SRS-SilenceFire',Volume=0.700000,Radius=128.000000,bAtten=True)
     BallisticFireSound=(Sound=Sound'BallisticSounds1.SRS600.SRS-Fire',Volume=1.600000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.170000
     AmmoClass=Class'BallisticProV55.Ammo_SRS600_Rifle'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     aimerror=750.000000
}
