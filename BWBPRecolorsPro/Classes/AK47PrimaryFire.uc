//=============================================================================
// Main Primaryfire class for AK-470 Assault Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class AK47PrimaryFire extends BallisticRangeAttenFire;

defaultproperties
{
     CutOffDistance=3072.000000
     CutOffStartRange=1536.000000
     TraceRange=(Min=12000.000000,Max=13000.000000)
     WaterRangeFactor=0.800000
     MaxWallSize=24.000000
     MaxWalls=1
     Damage=30.000000
     DamageHead=60.000000
     DamageLimb=30.000000
     RangeAtten=0.40000
     WaterRangeAtten=0.800000
     DamageType=Class'BWBPRecolorsPro.DT_AK47Assault'
     DamageTypeHead=Class'BWBPRecolorsPro.DT_AK47AssaultHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DT_AK47Assault'
     PenetrateForce=0
     bPenetrate=False
     DryFireSound=(Sound=Sound'BallisticSounds2.D49.D49-DryFire',Volume=0.700000)
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashScaleFactor=0.300000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassBone="tip"
     BrassOffset=(X=-60.000000,Y=0.500000)
     RecoilPerShot=220.000000
     FireChaos=0.045000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     XInaccuracy=48.000000
     YInaccuracy=48.000000
     BallisticFireSound=(Sound=SoundGroup'PackageSounds4Pro.AK47.AK47-Fire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.115000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_AK470Clip'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=0.000000
     WarnTargetPct=0.200000
     aimerror=750.000000
}
