//=============================================================================
// Primaryfire class for the SAR-12 Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class SAR12PrimaryFire extends BallisticRangeAttenFire;

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
		SAR12Rifle(Weapon).UziBrassList.length = SAR12Rifle(Weapon).UziBrassList.length + 1;
		SAR12Rifle(Weapon).UziBrassList[SAR12Rifle(Weapon).UziBrassList.length-1].Actor = BrassActor;
		SAR12Rifle(Weapon).UziBrassList[SAR12Rifle(Weapon).UziBrassList.length-1].KillTime = level.TimeSeconds + 0.2;
	}
}

defaultproperties
{
     CutOffDistance=2560.000000
     CutOffStartRange=1280.000000
     TraceRange=(Min=9000.000000,Max=9000.000000)
     MaxWaterTraceRange=128	 	 
     RangeAtten=0.350000
     WaterRangeAtten=0.800000	 
     PDamageFactor=0.700000
     WallPDamageFactor=0.950000 	 
     WallPenetrationForce=16.000000
     KickForce=0
     PenetrateForce=0
     bPenetrate=False	 
     Damage=20.000000
     DamageHead=40.000000
     DamageLimb=20.000000
     DamageType=Class'BallisticProV55.DT_SAR12Body'
     DamageTypeHead=Class'BallisticProV55.DT_SAR12Head'
     DamageTypeArm=Class'BallisticProV55.DT_SAR12Body'
     DryFireSound=(Sound=Sound'BallisticProSounds.Effects.DryRifle',Volume=1.100000,Radius=32.000000,Pitch=1.000000)
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashScaleFactor=0.500000
     BrassClass=Class'BallisticProV55.Brass_SAR12Rifle'
     BrassOffset=(X=-53.500000,Y=1.000000,Z=-3.500000)
     AimedFireAnim="SightFire"
     RecoilPerShot=180.000000
     VelocityRecoil=0.000000 	 
     FireChaos=0.022000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     XInaccuracy=48.000000
     YInaccuracy=48.000000
     BallisticFireSound=(Sound=Sound'BallisticProSounds.SAR-12.SAR-12-Fire',Volume=0.90000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireRate=0.100000
     AmmoClass=Class'BallisticProV55.Ammo_SAR12Rifle'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     WarnTargetPct=0.200000	 
     aimerror=750.000000
}
