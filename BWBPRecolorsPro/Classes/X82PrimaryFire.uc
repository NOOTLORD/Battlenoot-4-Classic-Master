//=============================================================================
// X82PrimaryFire.
//
// Very accurate, long ranged and powerful bullet fire. Headshots are
// especially dangerous.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class X82PrimaryFire extends BallisticProInstantFire;

defaultproperties
{
     TraceRange=(Min=30000.000000,Max=30000.000000)
     WaterRangeFactor=0.800000
     MaxWallSize=72.000000
     MaxWalls=4
     Damage=120.000000
     DamageHead=175.000000
     DamageLimb=120.000000
     WaterRangeAtten=0.800000
     DamageType=Class'BWBPRecolorsPro.DT_X82Torso'
     DamageTypeHead=Class'BWBPRecolorsPro.DT_X82Head'
     DamageTypeArm=Class'BWBPRecolorsPro.DT_X82Torso'
     KickForce=25000
     PenetrateForce=450
     bPenetrate=True
     MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
     BrassClass=Class'BWBPRecolorsPro.Brass_BMG'
     BrassBone="breach"
     BrassOffset=(X=-10.000000,Y=1.000000,Z=-1.000000)
     RecoilPerShot=1024.000000
     VelocityRecoil=255.000000
     FireChaos=0.700000
     BallisticFireSound=(Sound=Sound'PackageSounds4Pro.X82.X82-Fire',Volume=10.000000,Radius=1024.000000)
     FireEndAnim=
     FireRate=0.750000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_50BMG'
     ShakeRotMag=(X=450.000000,Y=64.000000)
     ShakeRotRate=(X=12400.000000,Y=12400.000000,Z=12400.000000)
     ShakeRotTime=2.500000
     ShakeOffsetMag=(X=-5.500000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.250000
     BotRefireRate=0.300000
     WarnTargetPct=0.700000
     aimerror=950.000000
}
