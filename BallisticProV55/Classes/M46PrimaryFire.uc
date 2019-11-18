//=============================================================================
// M46PrimaryFire.
//
// Very automatic, bullet style instant hit. Shots are long ranged, powerful
// and accurate when used carefully. The dissadvantages are severely screwed up
// accuracy after firing a shot or two and the rapid rate of fire means ammo
// dissapeares quick.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class M46PrimaryFire extends BallisticRangeAttenFire;

defaultproperties
{
     CutOffDistance=6144.000000
     CutOffStartRange=3072.000000
     TraceRange=(Min=12000.000000,Max=15000.000000)
     WaterRangeFactor=0.800000
     MaxWallSize=64.000000
     MaxWalls=2
     Damage=30.000000
     DamageHead=60.000000
     DamageLimb=30.000000
     RangeAtten=0.400000
     WaterRangeAtten=0.800000
     DamageType=Class'BallisticProV55.DTM46Assault'
     DamageTypeHead=Class'BallisticProV55.DTM46AssaultHead'
     DamageTypeArm=Class'BallisticProV55.DTM46Assault'
     PenetrateForce=150
     bPenetrate=True
     DryFireSound=(Sound=Sound'BallisticSounds2.D49.D49-DryFire',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.M46FlashEmitter'
     FlashScaleFactor=0.800000
     BrassClass=Class'BallisticProV55.Brass_M46AR'
     BrassOffset=(Y=10.000000)
     RecoilPerShot=180.000000
     FireChaos=0.045000
     FireChaosCurve=(Points=(,(InVal=0.160000),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     XInaccuracy=32.000000
     YInaccuracy=32.000000
     BallisticFireSound=(Sound=Sound'BallisticSounds_25.OA-AR.OA-AR_Fire1',Volume=1.750000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.135000
     AmmoClass=Class'BallisticProV55.Ammo_M46Clip'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     WarnTargetPct=0.200000
     aimerror=700.000000
}
