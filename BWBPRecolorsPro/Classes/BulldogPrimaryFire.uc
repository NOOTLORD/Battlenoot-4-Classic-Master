//  =============================================================================
//	Bulldog primary fire.
//
//  Powerful ranged attack which deals radius damage.
//  Originally written by Sergeant_Kelly based on code by DarkCarnivour.
//  Modified by Azarael.
//  =============================================================================
class BulldogPrimaryFire extends BallisticProInstantFire;

var() class<actor>			AltBrassClass1;			//Alternate Fire's brass
var() class<actor>			AltBrassClass2;			//Alternate Fire's brass (whole FRAG-12)

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
	
	if (!bUseWeaponMag || BW.bNoMag)
	{
		if(!Super.AllowFire())
		{
			if (DryFireSound.Sound != None)
				Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
			return false;	// Does not use ammo from weapon mag. Is there ammo in inventory
		}
	}
	else if (BW.MagAmmo < AmmoPerFire)
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
	else if (BW.bNeedCock || !BulldogAssaultCannon(BW).bAltNeedCock)
		return false;		// Alt's loaded or needs cocking
    return true;
}


//Spawn shell casing for first person
function EjectFRAGBrass()
{
	local vector Start, X, Y, Z;
	local Coords C;

	if (Level.NetMode == NM_DedicatedServer)
		return;
	if (!class'BallisticMod'.default.bEjectBrass || Level.DetailMode < DM_High)
		return;
	if (BrassClass == None)
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
	if (AIController(Instigator.Controller) != None)
		return;
	C = Weapon.GetBoneCoords(BrassBone);
//	Start = C.Origin + C.XAxis * BrassOffset.X + C.YAxis * BrassOffset.Y + C.ZAxis * BrassOffset.Z;
    Weapon.GetViewAxes(X,Y,Z);
	Start = C.Origin + X * BrassOffset.X + Y * BrassOffset.Y + Z * BrassOffset.Z;
	Spawn(AltBrassClass2, weapon,, Start, Rotator(C.XAxis));
}

defaultproperties
{
     AltBrassClass1=Class'BWBPRecolorsPro.Brass_FRAGSpent'
     AltBrassClass2=Class'BWBPRecolorsPro.Brass_FRAG'
     TraceRange=(Min=30000.000000,Max=30000.000000)
     WaterRangeFactor=0.300000
     MaxWallSize=120.000000
     MaxWalls=1
     Damage=100.000000
     DamageHead=150.000000
     DamageLimb=100.000000
     WaterRangeAtten=0.800000
     DamageType=Class'BWBPRecolorsPro.DTBulldog'
     DamageTypeHead=Class'BWBPRecolorsPro.DTBulldogHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DTBulldog'
     KickForce=25000
     PenetrateForce=250
     bPenetrate=True
     DryFireSound=(Sound=Sound'BallisticSounds2.D49.D49-DryFire',Volume=0.700000)
     bDryUncock=True
     MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
     FlashScaleFactor=1.100000
     BrassClass=Class'BWBPRecolorsPro.Brass_BOLT'
     BrassOffset=(X=-30.000000,Y=1.000000)
     RecoilPerShot=1536.000000
     VelocityRecoil=256.000000
     FireChaos=1.000000
     BallisticFireSound=(Sound=SoundGroup'PackageSounds4Pro.Bulldog.Bulldog-Fire',Volume=7.500000)
     FireEndAnim=
     FireAnimRate=1.800000
     FireRate=0.750000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_75BOLT'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
}
