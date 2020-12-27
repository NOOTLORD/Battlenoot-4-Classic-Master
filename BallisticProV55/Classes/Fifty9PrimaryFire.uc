//=============================================================================
// Primaryfire class for the Fifty-9 SMG
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class Fifty9PrimaryFire extends BallisticRangeAttenFire;

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
		Fifty9SMG(Weapon).UziBrassList.length = Fifty9SMG(Weapon).UziBrassList.length + 1;
		Fifty9SMG(Weapon).UziBrassList[Fifty9SMG(Weapon).UziBrassList.length-1].Actor = BrassActor;
		Fifty9SMG(Weapon).UziBrassList[Fifty9SMG(Weapon).UziBrassList.length-1].KillTime = level.TimeSeconds + 0.2;
	}
}

defaultproperties
{
     CutOffDistance=1536.000000
     CutOffStartRange=768.000000
     TraceRange=(Min=7500.000000,Max=7500.000000)
     MaxWaterTraceRange=128	
     RangeAtten=0.250000
     WaterRangeAtten=0.300000
     PDamageFactor=0.700000
     WallPDamageFactor=0.950000  	 
     WallPenetrationForce=8.000000
     KickForce=0
     PenetrateForce=0
     bPenetrate=False	 
     Damage=22.000000
     DamageHead=44.000000
     DamageLimb=22.000000
     DamageType=Class'BallisticProV55.DT_Fifty9Body'
     DamageTypeHead=Class'BallisticProV55.DT_Fifty9Head'
     DamageTypeArm=Class'BallisticProV55.DT_Fifty9Body'
     DryFireSound=(Sound=Sound'BallisticProSounds.Effects.DryRifle',Volume=0.900000,Radius=32.000000,Pitch=1.000000)
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashScaleFactor=0.230000
     BrassClass=Class'BallisticProV55.Brass_Fifty9SMG'
     BrassOffset=(X=-38.750000,Y=-2.500000,Z=2.00000)
     AimedFireAnim="SightFire"
     RecoilPerShot=160.000000
     VelocityRecoil=0.000000 
     FireChaos=0.350000	 
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.240000,OutVal=1),(InVal=0.350000,OutVal=1.500000),(InVal=0.660000,OutVal=2.250000),(InVal=1.000000,OutVal=3.500000)))
     XInaccuracy=64.000000
     YInaccuracy=64.000000
     BallisticFireSound=(Sound=Sound'BallisticProSounds.Fifty-9.Fifty-9-Fire',Volume=0.450000,Radius=32.000000,Pitch=1.000000)
     FireRate=0.073000
	 bPawnRapidFireAnim=True 
     AmmoClass=Class'BallisticProV55.Ammo_Fifty9SMG'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
	 BotRefireRate=0.990000
     WarnTargetPct=0.200000 
     aimerror=750.000000
}