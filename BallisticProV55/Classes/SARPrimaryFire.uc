//=============================================================================
// Primaryfire class for Sub Assault Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class SARPrimaryFire extends BallisticRangeAttenFire;

function PlayFiring()
{
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

	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();
}

//Spawn shell casing for first person
function EjectBrass()
{
	local vector Start, X, Y, Z;
	local Coords C;
	local actor BrassActor;

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
	BrassActor = Spawn(BrassClass, weapon,, Start, Rotator(C.XAxis));
	if (BrassActor != None)
	{
		BrassActor.bHidden=true;
		SARAssaultRifle(Weapon).UziBrassList.length = SARAssaultRifle(Weapon).UziBrassList.length + 1;
		SARAssaultRifle(Weapon).UziBrassList[SARAssaultRifle(Weapon).UziBrassList.length-1].Actor = BrassActor;
		SARAssaultRifle(Weapon).UziBrassList[SARAssaultRifle(Weapon).UziBrassList.length-1].KillTime = level.TimeSeconds + 0.2;
	}
}

defaultproperties
{
     CutOffDistance=2560.000000
     CutOffStartRange=1280.000000
     TraceRange=(Min=9000.000000,Max=9000.000000)
     WaterRangeFactor=0.800000
     MaxWallSize=24.000000
     MaxWalls=1
     Damage=25.000000
     DamageHead=50.000000
     DamageLimb=25.000000
     RangeAtten=0.350000
     WaterRangeAtten=0.800000
     DamageType=Class'BallisticProV55.DT_SARRifle'
     DamageTypeHead=Class'BallisticProV55.DT_SARRifleHead'
     DamageTypeArm=Class'BallisticProV55.DT_SARRifle'
     DryFireSound=(Sound=Sound'BallisticSounds2.Misc.DryRifle',Volume=1.100000)	  
     KickForce=0
     PenetrateForce=0
     bPenetrate=False
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashScaleFactor=0.500000
     BrassClass=Class'BallisticProV55.Brass_SAR_Rifle'
     BrassBone="tip"
     BrassOffset=(X=-99.000000,Y=-5.500000,Z=-3.500000)
     AimedFireAnim="AimedFire"
     RecoilPerShot=256.000000
     FireChaos=0.022000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     XInaccuracy=48.000000
     YInaccuracy=48.000000
     BallisticFireSound=(Sound=Sound'BallisticSounds2.SAR.SAR-Fire',Volume=1.650000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     bModeExclusive=False
     FireEndAnim=
     FireRate=0.100000
     AmmoClass=Class'BallisticProV55.Ammo_SAR_Rifle'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     WarnTargetPct=0.200000
     aimerror=750.000000
}
