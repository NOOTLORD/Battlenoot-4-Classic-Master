//=============================================================================
// CYLOSecondaryFire.
//
// A semi-auto shotgun that uses its own magazine.
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class CYLOSecondaryFire extends BallisticProShotgunFire;

simulated function bool AllowFire()
{
	if (!CheckReloading())
		return false;		// Is weapon busy reloading
	if (!CheckWeaponMode())
		return false;		// Will weapon mode allow further firing
	if (CYLOUAW(Weapon).SGShells < 1)
	{
		if (!bPlayedDryFire && DryFireSound.Sound != None)
		{
			Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
			bPlayedDryFire=true;
		}
		if (bDryUncock)
			CYLOUAW(BW).bAltNeedCock=true;
		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, 0);

		BW.EmptyFire(ThisModeNum);
		return false;		// Is there ammo in weapon's mag
	}
	else if (CYLOUAW(BW).bAltNeedCock)
		return false;
    return true;
}

simulated event ModeDoFire()
{
	if (!AllowFire())
		return;

	Super.ModeDoFire();
    CYLOUAW(Weapon).SGShells--;
	if (Weapon.Role == ROLE_Authority && CYLOUAW(Weapon).SGShells == 0)
		CYLOUAW(BW).bAltNeedCock = true;
}

defaultproperties
{
     CutOffDistance=1536.000000
     CutOffStartRange=1024.000000
     TraceCount=9
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     TraceRange=(Min=5000.000000,Max=5000.000000)
     Damage=10.000000
     DamageHead=15.000000
     DamageLimb=10.000000
     RangeAtten=0.750000
     DamageType=Class'BWBPRecolorsPro.DTCYLOShotgun'
     DamageTypeHead=Class'BWBPRecolorsPro.DTCYLOShotgunHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DTCYLOShotgun'
     KickForce=10000
     PenetrateForce=100
     bPenetrate=True
     bUseWeaponMag=False
     MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
     FlashBone="Muzzle2"
     BrassClass=Class'BallisticProV55.Brass_Shotgun'
     bBrassOnCock=True
     BrassOffset=(X=-30.000000,Y=-5.000000,Z=5.000000)
     RecoilPerShot=512.000000
     VelocityRecoil=200.000000
     FireChaos=0.500000
     XInaccuracy=350.000000
     YInaccuracy=350.000000
     JamSound=(Sound=Sound'BallisticSounds3.Misc.ClipEnd-1',Volume=0.900000)
     BallisticFireSound=(Sound=Sound'PackageSounds4Pro.CYLO.CYLO-FireSG',Volume=1.300000,Radius=256.000000)
     bWaitForRelease=True
     FireAnim="FireSG"
     FireEndAnim=
     FireRate=0.700000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_CYLOSG'
     AmmoPerFire=0
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
}
