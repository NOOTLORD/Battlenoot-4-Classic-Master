//=============================================================================
// XMK5PrimaryFire.
//
// Standard SubMachinegun bullets, bang bang!
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyrightę 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class XMK5PrimaryFire extends BallisticRangeAttenFire;

defaultproperties
{
     CutOffDistance=2560.000000
     CutOffStartRange=1024.000000
     TraceRange=(Min=7000.000000,Max=7000.000000)
     WaterRangeFactor=0.800000
     MaxWallSize=24.000000
     MaxWalls=1
     Damage=26.000000
     DamageHead=52.000000
     DamageLimb=26.000000
     RangeAtten=0.2500000
     WaterRangeAtten=0.300000
     DamageType=Class'BallisticProV55.DTXMK5SubMachinegun'
     DamageTypeHead=Class'BallisticProV55.DTXMK5SubMachinegunHead'
     DamageTypeArm=Class'BallisticProV55.DTXMK5SubMachinegun'
     KickForce=0
     PenetrateForce=0
     bPenetrate=False
     DryFireSound=(Sound=Sound'BallisticSounds3.Misc.DryRifle',Volume=1.000000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.XMk5FlashEmitter'
     FlashScaleFactor=0.400000
     BrassClass=Class'BallisticProV55.Brass_XMK5SMG'
     BrassOffset=(X=-19.000000,Z=-3.750000)
     AimedFireAnim="AimedFire"
     RecoilPerShot=130.000000
     FireChaos=0.070000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.240000,OutVal=1),(InVal=0.350000,OutVal=1.500000),(InVal=0.660000,OutVal=2.250000),(InVal=1.000000,OutVal=3.500000)))
     XInaccuracy=48.000000
     YInaccuracy=48.000000
     BallisticFireSound=(Sound=Sound'BallisticSounds_25.OA-SMG.OA-SMG_Fire1',Volume=1.250000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.100000
     AmmoClass=Class'BallisticProV55.Ammo_XMK5Clip'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000							 
     WarnTargetPct=0.200000
     aimerror=750.000000
}
