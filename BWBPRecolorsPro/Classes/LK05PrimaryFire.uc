//=============================================================================
// Main Primaryfire class for LK-05 Carbine
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class LK05PrimaryFire extends BallisticRangeAttenFire;

var() sound	FireSoundLoop;
var() sound	FireSoundLoopBegin;
var() sound	FireSoundLoopEnd;

var bool bFiring;

var() Actor						SMuzzleFlash;		// Silenced Muzzle flash stuff
var() class<Actor>			    SMuzzleFlashClass;
var() Name						SFlashBone;
var() float						SFlashScaleFactor;


simulated function bool AllowFire()
{
	if (!super.AllowFire())
	{
		if (bFiring)
		{
			StopFiring();
			Instigator.AmbientSound = BW.UsedAmbientSound;
		}
		return false;
	}
	return super.AllowFire();
}

//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
    if (!LK05Carbine(Weapon).bSilenced && MuzzleFlash != None)
        MuzzleFlash.Trigger(Weapon, Instigator);
    else if (LK05Carbine(Weapon).bSilenced && SMuzzleFlash != None)
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

function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
    if ((MuzzleFlashClass != None) && ((MuzzleFlash == None) || MuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
    if ((SMuzzleFlashClass != None) && ((SMuzzleFlash == None) || SMuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (SMuzzleFlash, SMuzzleFlashClass, Weapon.DrawScale*SFlashScaleFactor, weapon, SFlashBone);
}

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, LK05Carbine(Weapon).bSilenced, WaterHitLoc);
}

function ServerPlayFiring()
{
	if (LK05Carbine(Weapon) != None && LK05Carbine(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,SilencedFireSound.bNoOverride,SilencedFireSound.Radius,SilencedFireSound.Pitch,SilencedFireSound.bAtten);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	if (LK05Carbine(Weapon).bSilenced)
		Weapon.SetBoneScale (0, 1.0, LK05Carbine(Weapon).SilencerBone);
	else
		Weapon.SetBoneScale (0, 0.0, LK05Carbine(Weapon).SilencerBone);
	
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
	if (LK05Carbine(Weapon).bSilenced)
		Weapon.SetBoneScale (0, 1.0, LK05Carbine(Weapon).SilencerBone);
	else
	{
		Instigator.AmbientSound = BW.UsedAmbientSound;
		Weapon.SetBoneScale (0, 0.0, LK05Carbine(Weapon).SilencerBone);
	}

	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		BW.IdleAnim = 'OpenIdle';
		BW.ReloadAnim = 'ReloadEmpty';
    		if (LK05Carbine(Weapon).bScopeView)
			FireAnim = 'OpenSightFire';
		else
			FireAnim = 'OpenFire';
	}
	else
	{
		BW.IdleAnim = 'Idle';
		BW.ReloadAnim = 'Reload';
    	if (LK05Carbine(Weapon).bScopeView)
			FireAnim = 'SightFire';
		else
			FireAnim = 'Fire';
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
	if (!bFiring)
		bFiring=true;
    FireCount++;

	if (LK05Carbine(Weapon) != None && LK05Carbine(Weapon).bSilenced && SilencedFireSound.Sound != None)
	{
		if (LK05Carbine(Weapon).CurrentWeaponMode == 0 || LK05Carbine(Weapon).CurrentWeaponMode == 1)
			Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,,SilencedFireSound.Radius,,true);
	}
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);

	CheckClipFinished();
}

simulated function SwitchSilencerMode (bool bNewMode)
{
	if (bNewMode)
	{
		Damage *= 0.65;
		RecoilPerShot *= 0.5;
		BW.RecoilXFactor *= 0.5;
		BW.RecoilYFactor *= 0.5;
		RangeAtten *= 1.55;
		XInaccuracy *= 0.25;
		YInaccuracy *= 0.25;
		DamageType=Class'DT_LK05SilAssault';
     	DamageTypeHead=Class'DT_LK05SilAssaultHead';
     	DamageTypeArm=Class'DT_LK05SilAssault';
	}
	
	else
	{
		Damage =default.Damage;
     	DamageType=Class'DT_LK05Assault';
     	DamageTypeHead=Class'DT_LK05AssaultHead';
     	DamageTypeArm=Class'DT_LK05Assault';
		RecoilPerShot = default.RecoilPerShot;
		RangeAtten = default.RangeAtten;
		BW.RecoilXFactor = BW.default.RecoilXFactor;
		BW.RecoilYFactor = BW.default.RecoilYFactor;
		XInaccuracy = default.XInaccuracy;
		YInaccuracy = default.YInaccuracy;
	}
}

//FIXME
simulated event ModeDoFire()
{
	if (LK05Carbine(Weapon).bSilenced)
	{
    		if (!AllowFire())
		{
			StopFiring();
       			return;
		}
	}

	Super.ModeDoFire();
}

function StopFiring()
{
	bFiring=false;
    Instigator.AmbientSound = BW.UsedAmbientSound;
	Super.StopFiring();
}

simulated function ModeTick(float DT)
{
	Super.ModeTick(DT);

	if (bIsFiring && LK05Carbine(Weapon).bSilenced && LK05Carbine(Weapon).CurrentWeaponMode != 0 && LK05Carbine(Weapon).CurrentWeaponMode != 1)
		Instigator.AmbientSound = FireSoundLoop;
	else
		Instigator.AmbientSound = BW.UsedAmbientSound;
}


function DoFireEffect()
{
	Super.DoFireEffect();
	bFiring=true;
}

defaultproperties
{
     FireSoundLoop=Sound'PackageSounds4Pro.Misc.F2000-FireLoopSil'
     FireSoundLoopBegin=Sound'PackageSounds4Pro.Misc.F2000-SilFire'
     SMuzzleFlashClass=Class'BWBPRecolorsPro.LK05SilencedFlash'
     SFlashBone="tip2"
     SFlashScaleFactor=1.000000
     CutOffDistance=3072.000000
     CutOffStartRange=1792.000000
     TraceRange=(Min=9000.000000,Max=11000.000000)
     WaterRangeFactor=0.800000
     MaxWallSize=24.000000
     MaxWalls=1
     Damage=25.000000
     DamageHead=50.000000
     DamageLimb=25.000000
     RangeAtten=0.400000
     WaterRangeAtten=0.700000
     DamageType=Class'BWBPRecolorsPro.DT_LK05Assault'
     DamageTypeHead=Class'BWBPRecolorsPro.DT_LK05AssaultHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DT_LK05Assault'
     DryFireSound=(Sound=Sound'BallisticSounds3.Misc.DryRifle',Volume=0.750000)		 
     KickForce=0
     PenetrateForce=0
     bPenetrate=False 
     MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
     FlashScaleFactor=0.400000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassBone="tip"
     BrassOffset=(X=-50.000000,Y=4.000000,Z=-3.250000)
     RecoilPerShot=160.000000
     FireChaos=0.035000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     XInaccuracy=48.000000
     YInaccuracy=48.000000
     SilencedFireSound=(Sound=Sound'PackageSounds4Pro.Misc.F2000-SilFire',Volume=0.500000,Radius=192.000000,bAtten=True)
     BallisticFireSound=(Sound=Sound'PackageSounds4Pro.LK05.LK05-RapidFire',Volume=0.975000)
     bPawnRapidFireAnim=True
     FireEndAnim=
     AmmoClass=Class'BWBPRecolorsPro.Ammo_LK05Clip'
     FireRate=0.095000
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     WarnTargetPct=0.200000
     aimerror=750.000000
}
