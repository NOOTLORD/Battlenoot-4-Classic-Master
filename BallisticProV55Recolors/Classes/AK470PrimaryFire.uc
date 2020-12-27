//=============================================================================
// Primaryfire class for the AK-470 Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class AK470PrimaryFire extends BallisticRangeAttenFire;

defaultproperties
{
     CutOffDistance=3072.000000
     CutOffStartRange=1536.000000
     TraceRange=(Min=12000.000000,Max=13000.000000) 
     MaxWaterTraceRange=128	 
     RangeAtten=0.40000
     WaterRangeAtten=0.800000
     PDamageFactor=0.700000
     WallPDamageFactor=0.950000
     WallPenetrationForce=24.000000	 
     KickForce=0
     PenetrateForce=0
     bPenetrate=False	 
     Damage=28.000000
     DamageHead=56.000000
     DamageLimb=28.000000 
     DamageType=Class'BallisticProV55Recolors.DT_AK470Body'
     DamageTypeHead=Class'BallisticProV55Recolors.DT_AK470Head'
     DamageTypeArm=Class'BallisticProV55Recolors.DT_AK470Body'
     DryFireSound=(Sound=Sound'BallisticProSounds.Effects.DryRifle',Volume=1.000000,Radius=32.000000,Pitch=1.000000)	 	 
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashScaleFactor=0.250000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassOffset=(X=-40.000000,Y=0.500000,Z=-1.000000)
     RecoilPerShot=220.000000
     VelocityRecoil=0.000000 	 
     FireChaos=0.045000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     XInaccuracy=48.000000
     YInaccuracy=48.000000
     BallisticFireSound=(Sound=SoundGroup'BallisticProRecolorsSounds.AK470.AK470-Fire',Volume=1.150000,Slot=SLOT_Interact,bNoOverride=False)
     FireRate=0.115000
     bPawnRapidFireAnim=True	 
     AmmoClass=Class'BallisticProV55Recolors.Ammo_AK470Rifle'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     WarnTargetPct=0.200000	 
     aimerror=750.000000
}
