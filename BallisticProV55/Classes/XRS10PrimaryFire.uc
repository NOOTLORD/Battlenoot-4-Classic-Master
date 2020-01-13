//=============================================================================
// XRS10PrimaryFire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved. 
//
// Modified by (NL)NOOTLORD 						   
//=============================================================================
class XRS10PrimaryFire extends BallisticRangeAttenFire;

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
	if (bSilenced)
	{
     	RecoilPerShot *= 0.8;
		Damage *= 0.85;
		RangeAtten *= 1.15; //intentional to improve long range damage
		XInaccuracy *= 0.5;
		YInaccuracy *= 0.5;
	}
	else
	{
     	RecoilPerShot = default.RecoilPerShot;
		Damage = default.Damage;
		RangeAtten = default.RangeAtten;
		XInaccuracy = default.XInaccuracy;
		YInaccuracy = default.YInaccuracy;
	}
}

//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
    if (!XRS10SubMachinegun(Weapon).bSilenced && MuzzleFlash != None)
        MuzzleFlash.Trigger(Weapon, Instigator);
    else if (XRS10SubMachinegun(Weapon).bSilenced && SMuzzleFlash != None)
        SMuzzleFlash.Trigger(Weapon, Instigator);

	if (!bBrassOnCock)
		EjectBrass();
}

//// server propagation of firing ////
function ServerPlayFiring()
{
	if (XRS10SubMachinegun(Weapon) != None && XRS10SubMachinegun(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,SilencedFireSound.bNoOverride,SilencedFireSound.Radius,SilencedFireSound.Pitch,SilencedFireSound.bAtten);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

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
	
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
	// End code from normal PlayFiring()

	if (XRS10SubMachinegun(Weapon) != None && XRS10SubMachinegun(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,,SilencedFireSound.Radius,,true);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);
		
	CheckClipFinished();
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
	BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, XRS10SubMachinegun(Weapon).bSilenced, WaterHitLoc);
}

defaultproperties
{
     SMuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
     SFlashBone="Muzzle2"
     SFlashScaleFactor=1.150000
     CutOffDistance=1024.000000
     CutOffStartRange=512.000000
     WaterRangeFactor=0.500000
     MaxWallSize=24.000000
     MaxWalls=1
     Damage=28.000000
     DamageHead=28.000000
     DamageLimb=28.000000
     RangeAtten=0.250000
     WaterRangeAtten=0.400000
     DamageType=Class'BallisticProV55.DTXRS10SMG'
     DamageTypeHead=Class'BallisticProV55.DTXRS10SMGHead'
     DamageTypeArm=Class'BallisticProV55.DTXRS10SMG'
     PenetrateForce=0
     bPenetrate=False				   					
     ClipFinishSound=(Sound=Sound'BallisticSounds3.Misc.ClipEnd-2',Volume=1.000000,Radius=48.000000,bAtten=True)
     DryFireSound=(Volume=1.500000)
     bDryUncock=True
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashBone="Muzzle"
     FlashScaleFactor=0.450000
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassOffset=(X=-36.000000,Y=1.500000,Z=-0.500000)
     AimedFireAnim="SightFire"
     RecoilPerShot=190.000000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.320000,OutVal=1),(InVal=0.500000,OutVal=1.500000),(InVal=1.000000,OutVal=2.250000)))
     XInaccuracy=64.000000
     YInaccuracy=64.000000
     SilencedFireSound=(Sound=Sound'BWAddPack-RS-Sounds.TEC.RSMP-SilenceFire',Volume=2.000000,Radius=48.000000,bAtten=True)
     BallisticFireSound=(Sound=Sound'BWAddPack-RS-Sounds.TEC.RSMP-Fire',Volume=2.000000,Radius=384.000000)
     bPawnRapidFireAnim=True
     FireRate=0.090000
     AmmoClass=Class'BallisticProV55.Ammo_XRS10Clip'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=0.000000						  
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=0.000000	 
     aimerror=750.000000
}
