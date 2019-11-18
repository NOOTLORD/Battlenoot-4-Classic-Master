//=============================================================================
// Mk781PrimaryFire.
//
// Moderately weak shotgun with excellent accuracy and good RoF.
// Is about half as strong as the other shotguns - usually requires more shots.
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Mk781PrimaryFire extends BallisticProShotgunFire;

var() Actor						SMuzzleFlash;		// Silenced Muzzle flash stuff
var() class<Actor>			SMuzzleFlashClass;
var() Name						SFlashBone;
var() float						SFlashScaleFactor;

simulated function bool AllowFire()
{
	if (Mk781Shotgun(Weapon).bReady)
		return false;
	return super.AllowFire();
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

//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
    if (!Mk781Shotgun(Weapon).bSilenced && MuzzleFlash != None)
        MuzzleFlash.Trigger(Weapon, Instigator);
    else if (Mk781Shotgun(Weapon).bSilenced && SMuzzleFlash != None)
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

function ServerPlayFiring()
{
	if (Mk781Shotgun(Weapon) != None && Mk781Shotgun(Weapon).bSilenced && SilencedFireSound.Sound != None)
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

simulated function SwitchSilencerMode(bool bSilenced)
{
	if (bSilenced)
	{
		XInaccuracy	=	32;
		YInaccuracy	=	32;
		RecoilPerShot *= 0.65;
		Damage *= 0.8;
		RangeAtten *= 1.5;
	}
	
	else
	{
		XInaccuracy=default.XInaccuracy;
		YInaccuracy=default.YInaccuracy;
		RecoilPerShot=default.RecoilPerShot;
		Damage = default.Damage;
		RangeAtten = default.RangeAtten;
	}
}

//Do the spread on the client side
function PlayFiring()
{
	Mk781Shotgun(Weapon).UpdateBones();

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

	if (Mk781Shotgun(Weapon) != None && Mk781Shotgun(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,,SilencedFireSound.Radius,,true);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);

	CheckClipFinished();
}

defaultproperties
{
     SMuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
     SFlashBone="tip2"
     SFlashScaleFactor=1.000000
     HipSpreadFactor=8.000000
     CutOffDistance=4096.000000
     CutOffStartRange=1280.000000
     TraceCount=6
     TracerClass=Class'BWBPRecolorsPro.TraceEmitter_Flechette'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     TraceRange=(Min=7500.000000,Max=7500.000000)
     MaxWalls=1
     Damage=15.000000
     DamageHead=22.000000
     DamageLimb=15.000000
     RangeAtten=0.650000
     DamageType=Class'BWBPRecolorsPro.DTM781Shotgun'
     DamageTypeHead=Class'BWBPRecolorsPro.DTM781ShotgunHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DTM781Shotgun'
     MuzzleFlashClass=Class'BWBPRecolorsPro.MK781FlashEmitter'
     FlashScaleFactor=2.500000
     BrassClass=Class'BWBPRecolorsPro.Brass_ShotgunFlechette'
     BrassOffset=(X=-1.000000,Z=-1.000000)
     AimedFireAnim="SightFire"
     RecoilPerShot=512.000000
     VelocityRecoil=180.000000
     FireChaos=0.250000
     XInaccuracy=96.000000
     YInaccuracy=96.000000
     SilencedFireSound=(Sound=Sound'PackageSounds4ProExp.Mk781.Mk781-FireSil',Volume=2.300000,Radius=256.000000)
     BallisticFireSound=(Sound=Sound'PackageSounds4ProExp.Mk781.MK781-Fire',Volume=2.000000)
     FireEndAnim=
     FireAnimRate=1.150000
     FireRate=0.325000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_10GaugeDart'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
     aimerror=0.000000
}
