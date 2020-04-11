//=============================================================================
// Primaryfire class for M353 Machinegun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class M353PrimaryFire extends BallisticRangeAttenFire;

event ModeDoFire()
{
    if (!AllowFire())
        return;

	BallisticMachinegun(Weapon).SetBeltVisibility(BallisticMachinegun(Weapon).MagAmmo);
	Super.ModeDoFire();
}

defaultproperties
{
     CutOffDistance=4096
	 CutOffStartRange=2560
	 RangeAtten=0.35
	 TraceRange=(Min=15000.000000,Max=15000.000000)
     WaterRangeFactor=0.800000
     MaxWallSize=24.000000
     MaxWalls=1
     Damage=20.000000
     DamageHead=40.000000
     DamageLimb=20.000000
     WaterRangeAtten=0.800000
     DamageType=Class'BallisticProV55.DT_M353MG'
     DamageTypeHead=Class'BallisticProV55.DT_M353MGHead'
     DamageTypeArm=Class'BallisticProV55.DT_M353MG'
     DryFireSound=(Sound=Sound'BallisticSounds2.Misc.DryRifle',Volume=1.200000)	 	 
     KickForce=0
     PenetrateForce=0
     bPenetrate=False
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.M353FlashEmitter'
     FlashScaleFactor=0.350000
     BrassClass=Class'BallisticProV55.Brass_MG'
     BrassOffset=(X=-14.50000,Y=2.500000,Z=-2.000000)
     AimedFireAnim="SightFire"
     RecoilPerShot=120.000000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.240000,OutVal=1),(InVal=0.350000,OutVal=1.500000),(InVal=0.660000,OutVal=2.250000),(InVal=1.000000,OutVal=3.500000)))
     XInaccuracy=16.000000
     YInaccuracy=16.000000
     BallisticFireSound=(Sound=Sound'BallisticSounds2.M353.M353-Fire1',Volume=1.400000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.065000
     AmmoClass=Class'BallisticProV55.Ammo_M353_MG'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     WarnTargetPct=0.200000
     aimerror=750.000000
}
