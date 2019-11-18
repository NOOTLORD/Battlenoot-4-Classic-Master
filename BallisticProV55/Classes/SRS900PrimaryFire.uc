//=============================================================================
// SRS900PrimaryFire.
//
// Automatic rifle fire. More damage, penetrating power and recoil than M50.
// Silencer support.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class SRS900PrimaryFire extends BallisticRangeAttenFire;

var() Actor						SMuzzleFlash;		// Silenced Muzzle flash stuff
var() class<Actor>				SMuzzleFlashClass;
var() Name						SFlashBone;
var() float						SFlashScaleFactor;

simulated function FireRecoil ()
{
	if (!BW.bReaiming)
		BW.Reaim(level.TimeSeconds-Weapon.LastRenderTime, , FireChaos,,,0.15);
	BW.AddRecoil(RecoilPerShot, ThisModeNum);
	if (VelocityRecoil != 0)
	{
		if (Instigator.Physics == PHYS_Falling)
			Instigator.Velocity -= Vector(Instigator.GetViewRotation()) * VelocityRecoil * 0.25;
		else
			Instigator.Velocity -= Vector(Instigator.GetViewRotation()) * VelocityRecoil;
	}
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
    if (!SRS900Rifle(Weapon).bSilenced && MuzzleFlash != None)
        MuzzleFlash.Trigger(Weapon, Instigator);
    else if (SRS900Rifle(Weapon).bSilenced && SMuzzleFlash != None)
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

/*
// End effect functions ----------------------------------------------------
function float GetDamage (Actor Other, vector HitLocation, vector Dir, out Actor Victim, optional out class<DamageType> DT)
{
	if (SRS900Rifle(Weapon).bSilenced)
		return Super.GetDamage (Other, HitLocation, Dir, Victim, DT) * 0.8;
	else
		return Super.GetDamage (Other, HitLocation, Dir, Victim, DT);
}*/

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, SRS900Rifle(Weapon).bSilenced, WaterHitLoc);
}

function ServerPlayFiring()
{
	if (SRS900Rifle(Weapon) != None && SRS900Rifle(Weapon).bSilenced && SilencedFireSound.Sound != None)
		Weapon.PlayOwnedSound(SilencedFireSound.Sound,SilencedFireSound.Slot,SilencedFireSound.Volume,SilencedFireSound.bNoOverride,SilencedFireSound.Radius,SilencedFireSound.Pitch,SilencedFireSound.bAtten);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");

	CheckClipFinished();
}

//Do the spread on the client side
function PlayFiring()
{
	FireAnim = 'Fire';

	if (SRS900Rifle(Weapon).bSilenced)
	{
		SRS900Rifle(Weapon).StealthImpulse(0.05);
		Weapon.SetBoneScale (0, 1.0, SRS900Rifle(Weapon).SilencerBone);
	}
	else
	{
		SRS900Rifle(Weapon).StealthImpulse(0.3);
		Weapon.SetBoneScale (0, 0.0, SRS900Rifle(Weapon).SilencerBone);
	}

	BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");

    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;

	if (SRS900Rifle(Weapon) != None && SRS900Rifle(Weapon).bSilenced && SilencedFireSound.Sound != None)
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
     MaxWallSize=64.000000
     MaxWalls=1
     Damage=40.000000
     DamageHead=40.000000
     DamageLimb=40.000000
     RangeAtten=0.450000
     WaterRangeAtten=0.800000
     DamageType=Class'BallisticProV55.DTSRS900Rifle'
     DamageTypeHead=Class'BallisticProV55.DTSRS900RifleHead'
     DamageTypeArm=Class'BallisticProV55.DTSRS900Rifle'
     KickForce=0
     PenetrateForce=0
     bPenetrate=False
     ClipFinishSound=(Sound=Sound'BallisticSounds3.Misc.ClipEnd-1',Volume=0.800000,Radius=48.000000,bAtten=True)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
     FlashScaleFactor=0.450000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassOffset=(X=-25.000000,Y=1.000000)
     RecoilPerShot=240.000000
     FireChaos=0.070000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     SilencedFireSound=(Sound=Sound'BWBP3-Sounds.SRS900.SRS-SilenceFire',Volume=1.500000,Radius=256.000000,bAtten=True)
     BallisticFireSound=(Sound=Sound'BWBP3-Sounds.SRS-Fire',Volume=1.250000,Radius=1024.000000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.170000
     AmmoClass=Class'BallisticProV55.Ammo_RS762mm'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
	 ShakeRotTime=0.000000					  
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
	 ShakeOffsetTime=0.000000						 
     WarnTargetPct=0.200000
     aimerror=600.000000
}