//=============================================================================
// Primaryfire class for D49 Revolver
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
	switch(D49Revolver(Weapon).GetBarrelMode())
	{
		case BM_Neither:
			D49Revolver(Weapon).RevolverFired(BM_Neither);
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
		D49Revolver(Weapon).RevolverFired(BM_Primary);
}

defaultproperties
{
     CutOffDistance=2048.000000
     CutOffStartRange=768.000000
     TraceRange=(Min=8000.000000,Max=9000.000000)
     WaterRangeFactor=0.800000
     MaxWallSize=24.000000
     MaxWalls=1
     Damage=45.000000
     DamageHead=90.000000
     DamageLimb=45.000000
     RangeAtten=0.3500000
     WaterRangeAtten=0.200000
     DamageType=Class'BallisticProV55.DT_D49Revolver'
     DamageTypeHead=Class'BallisticProV55.DT_D49RevolverHead'
     DamageTypeArm=Class'BallisticProV55.DT_D49Revolver'
     DryFireSound=(Sound=Sound'BallisticSounds2.D49.D49-DryFire',Volume=0.750000)	 
     KickForce=0
     PenetrateForce=0
     bPenetrate=False
     MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
     FlashScaleFactor=0.600000
     RecoilPerShot=1024.000000
     FireChaos=0.400000
     XInaccuracy=128.000000
     YInaccuracy=128.000000
     BallisticFireSound=(Sound=Sound'BallisticSounds2.D49.D49-FireSingle',Volume=1.850000)
     FireAnim="FireSingle"
     FireEndAnim=
     FireRate=0.400000
     AmmoClass=Class'BallisticProV55.Ammo_D49_Revolver'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
	 BotRefireRate=0.700000
     aimerror=750.000000
}
