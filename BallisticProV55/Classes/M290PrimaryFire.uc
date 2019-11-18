//=============================================================================
// M290PrimaryFire.
//
// Double barreled fire for M290. Tons of damage, high spread, low range.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M290PrimaryFire extends BallisticProShotgunFire;

simulated function bool AllowFire()
{
	local bool bResult;

	AmmoPerFire=1;
	bResult=super.AllowFire();
	AmmoPerFire=2;

	return bResult;
}

event ModeDoFire()
{
	if (!M290Shotgun(Weapon).bLeftLoaded && M290Shotgun(Weapon).bRightLoaded)
		BW.BFireMode[1].ModeDoFire();
	else
		super.ModeDoFire();
}

function EjectBrass()
{
	BrassBone='EjectorL';
	BrassClass=Class'Brass_M290Left';
	super.EjectBrass();
	BrassBone='EjectorR';
	BrassClass=Class'Brass_M290Right';
	super.EjectBrass();
}

function InitEffects()
{
}

function FlashMuzzleFlash()
{
	local Coords C;
	local Actor MuzzleSmoke;
	local vector Start, X, Y, Z;

    if ((Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;

	BW.BFireMode[1].MuzzleFlash.Trigger(Weapon, Instigator);
	M290SecondaryFire(BW.BFireMode[1]).MuzzleFlash2.Trigger(Weapon, Instigator);

	if (!class'BallisticMod'.default.bMuzzleSmoke)
	    return;

	C = Weapon.GetBoneCoords('tip2');
    Weapon.GetViewAxes(X,Y,Z);

//	Start = C.Origin + C.XAxis * -80 + C.YAxis * 3 + C.ZAxis * 0;
	Start = C.Origin + X * -180 + Y * 3;
	MuzzleSmoke = Spawn(class'MRT6Smoke', weapon,, Start, Rotator(X));
	C = Weapon.GetBoneCoords('tip');
//	Start = C.Origin + C.XAxis * -80 + C.YAxis * 3 + C.ZAxis * 0;
	Start = C.Origin + X * -180 + Y * 3;
	MuzzleSmoke = Spawn(class'MRT6Smoke', weapon,, Start, Rotator(X));

	if (!bBrassOnCock)
		EjectBrass();
}

defaultproperties
{
     CutOffDistance=3072.000000
     CutOffStartRange=1024.000000
     TraceCount=24
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     TraceRange=(Min=4000.000000,Max=5000.000000)
     Damage=13.000000
     DamageHead=17.000000
     DamageLimb=13.000000
     RangeAtten=0.400000
     DamageType=Class'BallisticProV55.DTM290Shotgun'
     DamageTypeHead=Class'BallisticProV55.DTM290ShotgunHead'
     DamageTypeArm=Class'BallisticProV55.DTM290Shotgun'
     KickForce=6000
     PenetrateForce=100
     bPenetrate=True
     bCockAfterFire=True
     MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
     FlashScaleFactor=1.200000
     BrassClass=Class'BallisticProV55.Brass_Shotgun'
     BrassBone="EjectorR"
     bBrassOnCock=True
     BrassOffset=(X=-30.000000,Y=-5.000000,Z=5.000000)
     RecoilPerShot=1500.000000
     VelocityRecoil=1000.000000
     FireChaos=0.500000
     XInaccuracy=190.000000
     YInaccuracy=270.000000
     BallisticFireSound=(Sound=Sound'BallisticSounds3.M290.M290Fire',Volume=1.500000)
     FireRate=1.200000
     AmmoClass=Class'BallisticProV55.Ammo_Super12Gauge'
     AmmoPerFire=2
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
}
