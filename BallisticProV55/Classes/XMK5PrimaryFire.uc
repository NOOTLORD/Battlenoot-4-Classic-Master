//=============================================================================
// Primaryfire class for the XMK5 SubMachinegun
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class XMK5PrimaryFire extends BallisticRangeAttenFire;

defaultproperties
{
     CutOffDistance=2560.000000
     CutOffStartRange=1024.000000
     TraceRange=(Min=4000.000000,Max=4000.000000)
     MaxWaterTraceRange=128
     RangeAtten=0.200000
     WaterRangeAtten=0.200000
     PDamageFactor=0.700000
     WallPDamageFactor=0.950000	 
     WallPenetrationForce=8.000000
     KickForce=0
     PenetrateForce=0
     bPenetrate=False	 
     Damage=22.000000
     DamageHead=36.000000
     DamageLimb=22.000000
     DamageType=Class'BallisticProV55.DT_XMK5SMG'
     DamageTypeHead=Class'BallisticProV55.DT_XMK5SMGHead'
     DamageTypeArm=Class'BallisticProV55.DT_XMK5SMG'
     DryFireSound=(Sound=Sound'BallisticSounds2.Misc.DryRifle',Volume=1.000000,Radius=32.000000,Pitch=1.000000)
     MuzzleFlashClass=Class'BallisticProV55.XMk5FlashEmitter'
     FlashScaleFactor=0.400000
     BrassClass=Class'BallisticProV55.Brass_XMK5_SMG'
     BrassOffset=(X=-22.000000,Y=0.500000,Z=-.500000)
     AimedFireAnim="AimedFire"
     RecoilPerShot=115.000000
     VelocityRecoil=0.000000	 
     FireChaos=0.070000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.240000,OutVal=1),(InVal=0.350000,OutVal=1.500000),(InVal=0.660000,OutVal=2.250000),(InVal=1.000000,OutVal=3.500000)))
     XInaccuracy=48.000000
     YInaccuracy=48.000000
     BallisticFireSound=(Sound=Sound'BallisticSounds1.OA-SMG.OA-SMG_Fire',Volume=1.250000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireRate=0.100000
     AmmoClass=Class'BallisticProV55.Ammo_XMK5_SMG'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     WarnTargetPct=0.200000	 
     aimerror=750.000000
}
