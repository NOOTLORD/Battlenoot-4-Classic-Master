//=============================================================================
// Primaryfire class for the FN2000 Assault Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class FN2000PrimaryFire extends BallisticRangeAttenFire;

defaultproperties
{
     CutOffDistance=5120.000000
     CutOffStartRange=2048.000000
     TraceRange=(Min=15000.000000,Max=15000.000000)
     MaxWaterTraceRange=128	 	 
     RangeAtten=0.350000
     WaterRangeAtten=0.800000	
     PDamageFactor=0.700000
     WallPDamageFactor=0.950000 	 
     WallPenetrationForce=16.000000 	 
     KickForce=0
     PenetrateForce=0
     bPenetrate=False	 
     Damage=20.000000
     DamageHead=35.000000
     DamageLimb=20.000000
     DamageType=Class'BallisticProV55Recolors.DT_FN2000Body'
     DamageTypeHead=Class'BallisticProV55Recolors.DT_FN2000Head'
     DamageTypeArm=Class'BallisticProV55Recolors.DT_FN2000Body'
     DryFireSound=(Sound=Sound'BallisticProSounds.Effects.DryRifle',Volume=0.750000,Radius=32.000000,Pitch=1.000000)
     MuzzleFlashClass=Class'BallisticProV55Recolors.FN2000FlashEmitter'
     FlashScaleFactor=0.400000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassOffset=(X=-40.000000,Y=1.500000,Z=-2.500000)
     AimedFireAnim="SightFire"
     RecoilPerShot=150.000000
     VelocityRecoil=0.000000 	 
     FireChaos=0.032000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     XInaccuracy=48.000000
     YInaccuracy=48.000000
     BallisticFireSound=(Sound=Sound'BallisticProRecolorsSounds.FN2000.FN2000-Fire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
     FireRate=0.095000
     bPawnRapidFireAnim=True	 
     AmmoClass=Class'BallisticProV55Recolors.Ammo_FN2000Rifle'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
	 WarnTargetPct=0.200000 
     aimerror=750.000000
}
