//=============================================================================
// leMatSecondaryFire.
//
// A one shot 16 gauge shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class leMatSecondaryFire extends BallisticProShotgunFire;

simulated function bool CheckShotgun()
{
	local int channel;
	local name seq;
	local float frame, rate;

	if (!leMatRevolver(Weapon).bSecLoaded)
	{
		weapon.GetAnimParams(channel, seq, frame, rate);
		if (seq == leMatRevolver(Weapon).SGLoadAnim)
			return false;

		if (!bPlayedDryFire && DryFireSound.Sound != None)
		{
			Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
			bPlayedDryFire=true;
		}
		BW.EmptyFire(ThisModeNum);

		bIsFiring=false;
		return false;
	}
	return true;
}

simulated event ModeDoFire()
{
	if (!AllowFire())
		return;
	if (!CheckShotgun())
		return;
	Super.ModeDoFire();
	leMatRevolver(Weapon).ShotgunFired();
}

defaultproperties
{
     CutOffDistance=1536.000000
     CutOffStartRange=768.000000
     TraceCount=10
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     TraceRange=(Min=2500.000000,Max=2500.000000)
     Damage=10.000000
     DamageHead=15.000000
     DamageLimb=10.000000
     RangeAtten=0.500000
     DamageType=Class'BallisticProV55.DTleMatShotgun'
     DamageTypeHead=Class'BallisticProV55.DTleMatShotgunHead'
     DamageTypeArm=Class'BallisticProV55.DTleMatShotgun'
     KickForce=10000
     PenetrateForce=100
     bPenetrate=True
     DryFireSound=(Sound=Sound'BallisticSounds2.D49.D49-DryFire',Volume=0.600000)
     bUseWeaponMag=False
     MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
     FlashBone="tip2"
     FlashScaleFactor=2.000000
     BrassOffset=(X=-1.000000,Z=-1.000000)
     RecoilPerShot=512.000000
     FireChaos=0.300000
     XInaccuracy=350.000000
     YInaccuracy=350.000000
     BallisticFireSound=(Sound=Sound'BWBP4-Sounds.leMat.LM-SecFire',Volume=1.300000)
     FireAnim="Fire2"
     FireEndAnim=
     AmmoClass=Class'BallisticProV55.Ammo_16GaugeleMat'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
}
