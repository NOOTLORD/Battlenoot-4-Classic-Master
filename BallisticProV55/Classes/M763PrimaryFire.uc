//=============================================================================
// Primaryfire class for M763 Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class M763PrimaryFire extends BallisticProShotgunFire;

// Check if there is ammo in clip if we use weapon's mag or is there some in inventory if we don't
simulated function bool AllowFire()
{
	//Force noobs to scope.
	if ((BW.BCRepClass.default.bSightFireOnly || class'BallisticWeapon'.default.SightsRestrictionLevel > 0) && BW.bUseSights && BW.SightingState != SS_Active && !BW.bScopeHeld && Instigator.IsLocallyControlled() && PlayerController(Instigator.Controller) != None)
		BW.ScopeView();
	if (!BW.bScopeView && class'BallisticWeapon'.default.SightsRestrictionLevel > 0)
		return false;
	if (!CheckReloading())
		return false;		// Is weapon busy reloading
	if (!CheckWeaponMode())
		return false;		// Will weapon mode allow further firing
	
	if (BW.MagAmmo < AmmoPerFire)
	{
		if (!bPlayedDryFire && DryFireSound.Sound != None)
		{
			Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
			bPlayedDryFire=true;
		}
		if (bDryUncock)
			BW.bNeedCock=true;
		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, 0);

		BW.EmptyFire(ThisModeNum);
		return false;		// Is there ammo in weapon's mag
	}
	else if (BW.bNeedReload)
		return false;

    return true;
}

function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		AimedFireAnim = 'FireSight';
		FireAnim = 'Fire';
	}
	else
	{
		AimedFireAnim='FireCombinedSight';
		FireAnim = 'FireCombined';
	}
	super.PlayFiring();
}

function ServerPlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		AimedFireAnim = 'FireSight';
		FireAnim = 'Fire';
	}
	else
	{
		AimedFireAnim='FireCombinedSight';
		FireAnim = 'FireCombined';
	}
	super.ServerPlayFiring();
}

simulated function DestroyEffects()
{
    if (MuzzleFlash != None)
		MuzzleFlash.Destroy();
	Super.DestroyEffects();
}

defaultproperties
{
     HipSpreadFactor=6.000000
	 MaxSpreadFactor=2.000000
     CutOffDistance=1536.000000
     CutOffStartRange=378.000000
     TraceCount=7
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     TracerChance=1.000000
     ImpactManager=Class'BallisticProV55.IM_Shell'
     TraceRange=(Min=4000.000000,Max=6000.000000)
     MaxWallSize=24.000000	 
     MaxWalls=1
     Damage=15.000000
     DamageHead=15.000000
     DamageLimb=15.000000
     RangeAtten=0.40000
     DamageType=Class'BallisticProV55.DT_M763Shotgun'
     DamageTypeHead=Class'BallisticProV55.DT_M763ShotgunHead'
     DamageTypeArm=Class'BallisticProV55.DT_M763Shotgun'
     DryFireSound=(Sound=Sound'BallisticSounds2.Misc.DryRifle',Volume=0.7500000)	 
     KickForce=0
     PenetrateForce=0
     bPenetrate=False			   					 					
     MuzzleFlashClass=Class'BallisticProV55.M763FlashEmitter'
     FlashScaleFactor=0.390000
     BrassClass=Class'BallisticProV55.Brass_Shotgun'
     BrassOffset=(X=-32.000000,Y=1.000000,Z=1.000000)
     AimedFireAnim="FireCombinedSight"
     RecoilPerShot=512.000000
     FireChaos=0.450000
     XInaccuracy=150.000000
     YInaccuracy=150.000000
     BallisticFireSound=(Sound=Sound'BallisticSounds2.M763.M763Fire1',Volume=1.900000)
     FireAnim="FireCombined"
     FireEndAnim=
     FireAnimRate=1.000000
     FireRate=0.750000
     AmmoClass=Class'BallisticProV55.Ammo_M763_Shotgun'
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
