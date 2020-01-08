//=============================================================================
// RS8PrimaryFire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class RS8PrimaryFire extends BallisticRangeAttenFire;

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
    if (!RS8Pistol(Weapon).bSilenced && MuzzleFlash != None)
        MuzzleFlash.Trigger(Weapon, Instigator);
    else if (RS8Pistol(Weapon).bSilenced && SMuzzleFlash != None)
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

// End effect functions ----------------------------------------------------
function float GetDamage (Actor Other, vector HitLocation, vector Dir, out Actor Victim, optional out class<DamageType> DT)
{
	if (RS8Pistol(Weapon).bSilenced)
		return Super.GetDamage (Other, HitLocation, Dir, Victim, DT) * 0.85;
	else
		return Super.GetDamage (Other, HitLocation, Dir, Victim, DT);
}

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, RS8Pistol(Weapon).bSilenced, WaterHitLoc);
}

function ServerPlayFiring()
{
	if (RS8Pistol(Weapon) != None && RS8Pistol(Weapon).bSilenced && SilencedFireSound.Sound != None)
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
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		BW.IdleAnim = 'OpenIdle';
		BW.ReloadAnim = 'OpenReload';
		FireAnim = 'OpenFire';
	}
	else
	{
		BW.IdleAnim = 'Idle';
		BW.ReloadAnim = 'Reload';
		FireAnim = 'Fire';
	}

	if (RS8Pistol(Weapon).bSilenced)
		Weapon.SetBoneScale (0, 1.0, RS8Pistol(Weapon).SilencerBone);
	else
		Weapon.SetBoneScale (0, 0.0, RS8Pistol(Weapon).SilencerBone);

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

	if (RS8Pistol(Weapon) != None && RS8Pistol(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,,SilencedFireSound.Radius,,true);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);
	
	CheckClipFinished();
}

defaultproperties
{
     SMuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
     SFlashBone="Muzzle2"
     SFlashScaleFactor=0.500000
	 TraceRange=(Min=4000.000000,Max=4000.000000)
     CutOffDistance=2048.000000
     CutOffStartRange=256.000000
     WaterRangeFactor=0.450000
     MaxWallSize=24.000000
     MaxWalls=1
     Damage=27.000000
     DamageHead=40.000000
     DamageLimb=27.000000
     RangeAtten=0.250000
     WaterRangeAtten=0.400000
     DamageType=Class'BallisticProV55.DTRS8Pistol'
     DamageTypeHead=Class'BallisticProV55.DTRS8PistolHead'
     DamageTypeArm=Class'BallisticProV55.DTRS8Pistol'
     ClipFinishSound=(Volume=1.000000)
     DryFireSound=(Sound=Sound'BallisticSounds3.Misc.DryPistol',Volume=1.000000)
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashBone="Muzzle"
     FlashScaleFactor=0.350000
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassOffset=(X=-28.000000,Y=5.000000,Z=1.000000)
     RecoilPerShot=768.000000
     FireChaos=0.250000
     XInaccuracy=96.000000
     YInaccuracy=96.000000
     SilencedFireSound=(Sound=Sound'BWAddPack-RS-Sounds.Pistol.RSP-SilenceFire',Volume=1.500000,Radius=76.000000,bAtten=True)
     BallisticFireSound=(Sound=Sound'BWAddPack-RS-Sounds.Pistol.RSP-Fire',Volume=2.000000)
     bPawnRapidFireAnim=True
	 FireEndAnim=
     FireAnimRate=1.500000
     FireRate=0.225000
     AmmoClass=Class'BallisticProV55.Ammo_RS8Clip'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=0.000000						  
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=0.000000							 
     BotRefireRate=0.750000
     aimerror=600.000000
}
