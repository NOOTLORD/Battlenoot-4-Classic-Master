//=============================================================================
// Primaryfire class for M50 Assault Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class M50PrimaryFire extends BallisticRangeAttenFire;

defaultproperties
{
     CutOffDistance=3072.000000
     CutOffStartRange=1536.000000
     TraceRange=(Min=12000.000000,Max=15000.000000)
     WaterRangeFactor=0.800000
     MaxWallSize=24.000000
     MaxWalls=1
     Damage=25.000000
     DamageHead=50.000000
     DamageLimb=25.000000
     RangeAtten=0.350000
     WaterRangeAtten=0.800000
     DamageType=Class'BallisticProV55.DTM50Assault'
     DamageTypeHead=Class'BallisticProV55.DTM50AssaultHead'				        
	 DamageTypeArm=Class'BallisticProV55.DTM50Assault'	
     DryFireSound=(Sound=Sound'BallisticSounds2.Misc.DryRifle',Volume=1.000000) 	 
     KickForce=0
     PenetrateForce=0
     bPenetrate=False
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
     FlashScaleFactor=0.550000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassBone="tip"
     BrassOffset=(X=-80.000000,Y=1.000000,Z=-2.000000)
     AimedFireAnim="AimedFire"
     RecoilPerShot=145.000000
     FireChaos=0.040000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     XInaccuracy=48.000000
     YInaccuracy=48.000000
     BallisticFireSound=(Sound=Sound'BallisticSounds2.M50.M50Fire',Volume=1.400000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.110000
     AmmoClass=Class'BallisticProV55.Ammo_M50_Rifle'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     WarnTargetPct=0.200000
     aimerror=750.000000
}
