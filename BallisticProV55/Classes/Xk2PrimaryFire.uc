//=============================================================================
// Primaryfire class for XK2 SubMachinegun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class XK2PrimaryFire extends BallisticRangeAttenFire;

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

function SetSilenced(bool bSilenced)
{
	bAISilent = bSilenced;
	if (!bSilenced)
	{
		XInaccuracy *= 2;
		YInaccuracy *= 2;
		CutOffStartRange *= 1.25;
	}
	else
	{
		XInaccuracy = default.XInaccuracy;
		YInaccuracy = default.YInaccuracy;
		CutOffStartRange = default.CutOffStartRange;
	}
}

//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
    if (!XK2SubMachinegun(Weapon).bSilenced && MuzzleFlash != None)
        MuzzleFlash.Trigger(Weapon, Instigator);
    else if (XK2SubMachinegun(Weapon).bSilenced && SMuzzleFlash != None)
        SMuzzleFlash.Trigger(Weapon, Instigator);

	if (!bBrassOnCock)
		EjectBrass();
}

// Remove effects
simulated function DestroyEffects()
{
	Super.DestroyEffects();

	class'BUtil'.static.KillEmitterEffect (MuzzleFlash);
	class'BUtil'.static.KillEmitterEffect (SMuzzleFlash);
}

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, XK2SubMachinegun(Weapon).bSilenced, WaterHitLoc);
}

function ServerPlayFiring()
{
	if (XK2SubMachinegun(Weapon) != None && XK2SubMachinegun(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,SilencedFireSound.bNoOverride,SilencedFireSound.Radius,SilencedFireSound.Pitch,SilencedFireSound.bAtten);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	// Slightly modified Code from original PlayFiring()
	if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
		BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
	else if(!BW.bScopeView || !Weapon.HasAnim(AimedFireAnim))
		BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	else BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, , "FIRE");
	// End code from normal PlayFiring()

	CheckClipFinished();
}

function PlayFiring()
{
	if (XK2SubMachinegun(Weapon).bSilenced)
		Weapon.SetBoneScale (0, 1.0, XK2SubMachinegun(Weapon).SilencerBone);
	else
		Weapon.SetBoneScale (0, 0.0, XK2SubMachinegun(Weapon).SilencerBone);
		
	// Slightly modified Code from original PlayFiring()
	
	if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
		BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
	else if(!BW.bScopeView || !Weapon.HasAnim(AimedFireAnim))
		BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	else BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, , "FIRE");
	
	// End code from normal PlayFiring()
	    
        ClientPlayForceFeedback(FireForce);  // jdf											   
		FireCount++;

	if (XK2SubMachinegun(Weapon) != None && XK2SubMachinegun(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,,SilencedFireSound.Radius,,true);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);

	CheckClipFinished();
}

defaultproperties
{
     SMuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
     SFlashBone="tip2"
     SFlashScaleFactor=0.800000
     CutOffDistance=2560.000000
     CutOffStartRange=1024.000000
     WaterRangeFactor=0.500000
     MaxWallSize=24.000000
     MaxWalls=1
     Damage=20.000000
     DamageHead=40.000000
     DamageLimb=20.000000
     RangeAtten=0.250000
     WaterRangeAtten=0.600000
     DamageType=Class'BallisticProV55.DT_XK2SMG'
     DamageTypeHead=Class'BallisticProV55.DT_XK2SMGHead'
     DamageTypeArm=Class'BallisticProV55.DT_XK2SMG'
     DryFireSound=(Sound=Sound'BallisticSounds2.Misc.DryRifle',Volume=1.000000)	 
     KickForce=0
     PenetrateForce=0
     bPenetrate=False
     bDryUncock=True
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashBone="Muzzle"
     FlashScaleFactor=0.400000
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassOffset=(X=-40.000000,Z=-1.000000)
     AimedFireAnim="SightFire"
     RecoilPerShot=98.000000
     FireChaos=0.050000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.240000,OutVal=1),(InVal=0.350000,OutVal=1.500000),(InVal=0.660000,OutVal=2.250000),(InVal=1.000000,OutVal=3.500000)))
     XInaccuracy=48.000000
     YInaccuracy=48.000000
     SilencedFireSound=(Sound=Sound'BallisticSounds2.XK2.XK2-SilenceFire',Volume=0.750000,bAtten=True)
     BallisticFireSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Fire',Volume=0.600000)
     bPawnRapidFireAnim=True
     FireRate=0.090000
     AmmoClass=Class'BallisticProV55.Ammo_XK2_SMG'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     aimerror=750.000000
}
