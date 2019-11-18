//=============================================================================
// M2020GaussPrimaryFire.
//
// Gauss fire. Magnetic acceleration. Physics. Pv=nRT. A1V1=A2V2. Llammas.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M2020GaussPrimaryFire extends BallisticProInstantFire;
var() sound		SpecialFireSound;
var() sound		LowPowerFireSound;
var bool		bFlashAlt;
var() Actor						MuzzleFlash2;		// ALT: The muzzleflash actor
var() class<Actor>				MuzzleFlashClass2;	// ALT: The actor to use for this fire's muzzleflash

//Disable fire anim when scoped
function PlayFiring()
{
	if (ScopeDownOn == SDO_Fire)
		BW.TemporaryScopeDown(0.5, 0.9);
	// Slightly modified Code from original PlayFiring()
    if (!BW.bScopeView)
        if (FireCount > 0)
        {
            if (Weapon.HasAnim(FireLoopAnim))
                BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
            else
                BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
        }
        else
            BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
	// End code from normal PlayFiring()

	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();
}


// Effect related functions ------------------------------------------------
// Spawn the muzzleflash actor
function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
    if ((MuzzleFlashClass != None) && ((MuzzleFlash == None) || MuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
    if ((MuzzleFlashClass2 != None) && ((MuzzleFlash2 == None) || MuzzleFlash2.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash2, MuzzleFlashClass2, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);

}

// Remove effects
simulated function DestroyEffects()
{
	Super.DestroyEffects();

	class'BUtil'.static.KillEmitterEffect (MuzzleFlash);
	class'BUtil'.static.KillEmitterEffect (MuzzleFlash2);
}


//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
    	if (MuzzleFlash != None && !bFlashAlt)
        	MuzzleFlash.Trigger(Weapon, Instigator);
    	else if (MuzzleFlash2 != None && bFlashAlt)
        	MuzzleFlash2.Trigger(Weapon, Instigator);
	if (!bBrassOnCock)
		EjectBrass();
}

function StartBerserk()
{
	switch(BW.CurrentWeaponMode)
	{
		case 0: FireRate = default.FireRate * 0.75; break;
		case 1: FireRate = 1.2 * 0.75; break;
		default: FireRate = 0.2 * 0.75;
	}
    FireAnimRate = default.FireAnimRate/0.75;
    RecoilPerShot = default.RecoilPerShot * 0.75;
    FireChaos = default.FireChaos * 0.75;
}

function StopBerserk()
{
	switch(BW.CurrentWeaponMode)
	{
		case 0: FireRate = default.FireRate; break;
		case 1: FireRate = 1.2; break;
		default: FireRate = 0.2;
	}
    FireAnimRate = default.FireAnimRate;
    RecoilPerShot = default.RecoilPerShot;
    FireChaos = default.FireChaos;
}

simulated function SwitchWeaponMode (byte NewMode)
{
	if (NewMode == 0)
	{
		BallisticFireSound.Sound=default.BallisticFireSound.sound;
		RecoilPerShot=default.RecoilPerShot;
		VelocityRecoil=default.VelocityRecoil;
		FireAnim=default.FireAnim;
		FireChaos=0.6;
		PDamageFactor=default.PDamageFactor;
		WallPDamageFactor=default.WallPDamageFactor;
		Damage=default.Damage;
		DamageHead=default.DamageHead;
		DamageLimb=default.DamageLimb;
		FlashScaleFactor=default.FlashScaleFactor;
		bFlashAlt=false;
		KickForce = default.KickForce;
		M2020GaussAttachment(Weapon.ThirdPersonActor).bNoEffect=false;
		MaxWalls=default.MaxWalls;
		FireRate=Default.FireRate;
	}
	
	else if (NewMode == 1)
	{
		BallisticFireSound.Sound=SpecialFireSound;
		RecoilPerShot=1024.000000;
		VelocityRecoil=120.000000;
		FireAnim='FirePowered';
		FireRate=1.300000;
		FireChaos=1;
		KickForce=3000;
		PDamageFactor=0.850000;
		WallPDamageFactor=0.850000;
		Damage=110.000000;
		DamageHead=175.000000;
		DamageLimb=135.000000;
		FlashScaleFactor=1.600000;
		bFlashAlt=false;
		M2020GaussAttachment(Weapon.ThirdPersonActor).bNoEffect=false;
		MaxWalls=5;
	}
	else if (NewMode == 2 || NewMode == 3)
	{
		BallisticFireSound.Sound=LowPowerFireSound;
		RecoilPerShot=260.000000;
		VelocityRecoil=10.000000;
		FlashScaleFactor=1.000000;
		FireChaos=0.25;
		PDamageFactor=0.600000;
		WallPDamageFactor=0.400000;
		bFlashAlt=true;
		KickForce=0;
		M2020GaussAttachment(Weapon.ThirdPersonActor).bNoEffect=true;
		if (NewMode ==2)
			FireAnim='FireUnPowered';
		else
			FireAnim='FireShield';
		FireRate=0.200000;
		Damage=40.000000;
		DamageHead=80.000000;
		DamageLimb=40.000000;
		MaxWalls=3;
	}
	if (Weapon.bBerserk)
		FireRate *= 0.75;
	if ( Level.GRI.WeaponBerserk > 1.0 )
	    FireRate /= Level.GRI.WeaponBerserk;

}

defaultproperties
{
     SpecialFireSound=Sound'PackageSounds4ProExp.M2020.M2020-GaussFireSuper'
     LowPowerFireSound=Sound'PackageSounds4ProExp.M2020.M2020-GaussFireLow'
     MuzzleFlashClass2=Class'BallisticProV55.M50FlashEmitter'
     TraceRange=(Min=30000.000000,Max=30000.000000)
     WaterRangeFactor=0.900000
     MaxWallSize=64.000000
     MaxWalls=4
     Damage=60.000000
     DamageHead=120.000000
     DamageLimb=60.000000
     WaterRangeAtten=0.700000
     DamageType=Class'BWBPRecolorsPro.DT_M2020Pwr'
     DamageTypeHead=Class'BWBPRecolorsPro.DT_M2020HeadPwr'
     DamageTypeArm=Class'BWBPRecolorsPro.DT_M2020LimbPwr'
     KickForce=10000
     PenetrateForce=600
     bPenetrate=True
     PDamageFactor=0.750000
     WallPDamageFactor=0.750000
     MuzzleFlashClass=Class'BWBPRecolorsPro.M2020FlashEmitter'
     FlashScaleFactor=1.200000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassBone="tip"
     BrassOffset=(X=-30.000000,Y=1.000000)
     RecoilPerShot=384.000000
     FireChaos=0.600000
     BallisticFireSound=(Sound=Sound'PackageSounds4ProExp.M2020.M2020-GaussFire',Volume=6.700000)
     FireEndAnim=
     FireRate=0.325000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_42HVG'
     ShakeRotMag=(X=400.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
     aimerror=800.000000
}
