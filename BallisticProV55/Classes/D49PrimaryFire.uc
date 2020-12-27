//=============================================================================
// Primaryfire class for the D49 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class D49PrimaryFire extends BallisticRangeAttenFire;

simulated function PlayFiring()
{
//	D49Revolver(Weapon).RevolverFired(ThisModeNum);
	super.PlayFiring();
}

simulated event ModeDoFire()
{
	if (!AllowFire())
		return;
	switch(D49Pistol(Weapon).GetBarrelMode())
	{
		case BM_Neither:
			D49Pistol(Weapon).RevolverFired(BM_Neither);
			BW.FireCount++;
	        NextFireTime += FireRate*0.5;
    	    NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
			return;
		case BM_Primary:
			break;
		default:
			break;
	}
	super.ModeDoFire();
		D49Pistol(Weapon).RevolverFired(BM_Primary);
}

defaultproperties
{
     CutOffDistance=2048.000000
     CutOffStartRange=768.000000
     TraceRange=(Min=8000.000000,Max=9000.000000)
     MaxWaterTraceRange=128
     RangeAtten=0.3500000
     WaterRangeAtten=0.200000	 
     PDamageFactor=0.700000
     WallPDamageFactor=0.950000 	 
     WallPenetrationForce=8.000000
     KickForce=0
     PenetrateForce=0
     bPenetrate=False	 
     Damage=45.000000
     DamageHead=63.000000
     DamageLimb=45.000000
     DamageType=Class'BallisticProV55.DT_D49Body'
     DamageTypeHead=Class'BallisticProV55.DT_D49Head'
     DamageTypeArm=Class'BallisticProV55.DT_D49Body'
     DryFireSound=(Sound=Sound'BallisticProSounds.D49.D49-DryFire',Volume=0.750000,Radius=32.000000,Pitch=1.000000)	 
     MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
     FlashScaleFactor=0.600000
     RecoilPerShot=768.000000
     VelocityRecoil=0.000000 	 
     FireChaos=0.400000
     FireChaosCurve=(Points=((InVal=0.000000,OutVal=1.000000),(InVal=1.000000,OutVal=1.000000)))	 	 
     XInaccuracy=64.000000
     YInaccuracy=64.000000
     BallisticFireSound=(Sound=Sound'BallisticProSounds.D49.D49-Fire',Volume=1.850000,Radius=32.000000,Pitch=1.000000)
	 FireAnimRate=1.600000
     FireRate=0.400000
     AmmoClass=Class'BallisticProV55.Ammo_D49Pistol'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
	 BotRefireRate=0.700000
     WarnTargetPct=0.400000 
     aimerror=750.000000
}
