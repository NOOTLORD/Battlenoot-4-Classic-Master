//=============================================================================
// M925PrimaryFire.
//
// Very powerful bullet at slower than normal MG fire rate. Strong recoil moves
// player back, pitches muzzle and destabalizes the weapon.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M925PrimaryFire extends BallisticRangeAttenFire;

simulated function ModeDoFire()
{
    if (!AllowFire())
        return;

	BallisticMachinegun(Weapon).SetBeltVisibility(BallisticMachinegun(Weapon).MagAmmo);
	Super.ModeDoFire();
}

simulated function vector GetFireDir(out Vector StartTrace)
{
    if (BallisticTurret(Instigator) != None)
    	StartTrace = Instigator.Location + Instigator.EyePosition() + Vector(Instigator.GetViewRotation()) * 64;
	return super.GetFireDir(StartTrace);
}

defaultproperties
{
	 CutOffStartRange=3072
	 CutOffDistance=6144
	 RangeAtten=0.6
     TraceRange=(Min=15000.000000,Max=15000.000000)
     WaterRangeFactor=0.800000
     MaxWallSize=96.000000
     MaxWalls=3
     Damage=50.000000
     DamageHead=100.000000
     DamageLimb=50.000000
     WaterRangeAtten=0.800000
     DamageType=Class'BallisticProV55.DTM925MG'
     DamageTypeHead=Class'BallisticProV55.DTM925MGHead'
     DamageTypeArm=Class'BallisticProV55.DTM925MG'
     KickForce=6000
     PenetrateForce=300
     bPenetrate=True
     DryFireSound=(Sound=Sound'BallisticSounds3.Misc.DryRifle',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
     BrassClass=Class'BallisticProV55.Brass_BigMG'
     BrassOffset=(X=6.000000,Y=10.000000)
     AimedFireAnim="AimedFire"
     RecoilPerShot=300.000000
     VelocityRecoil=128.000000
     FireChaos=0.150000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.240000,OutVal=1),(InVal=0.350000,OutVal=1.500000),(InVal=0.660000,OutVal=2.250000),(InVal=1.000000,OutVal=3.500000)))
     XInaccuracy=1.000000
     YInaccuracy=1.000000
     BallisticFireSound=(Sound=SoundGroup'BallisticSounds3.M925.M925-Fire',Volume=0.800000)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.150000
     AmmoClass=Class'BallisticProV55.Ammo_50CalBelt'
     ShakeRotMag=(X=64.000000,Y=64.000000,Z=128.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-15.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     WarnTargetPct=0.200000
     aimerror=800.000000
}
