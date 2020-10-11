//=============================================================================
// Primaryfire class for the R9 Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class R9PrimaryFire extends BallisticRangeAttenFire;

defaultproperties
{
     CutOffStartRange=4096
	 CutOffDistance=8192
	 RangeAtten=0.5
     TraceRange=(Min=30000.000000,Max=30000.000000)
     WallPenetrationForce=64.000000
     Damage=45.000000
     DamageHead=90.000000
     DamageLimb=45.000000
     WaterRangeAtten=0.800000
     DamageType=Class'BallisticProV55.DT_R9Rifle'
     DamageTypeHead=Class'BallisticProV55.DT_R9RifleHead'
     DamageTypeArm=Class'BallisticProV55.DT_R9Rifle'
     DryFireSound=(Sound=Sound'BallisticSounds2.Misc.DryRifle',Volume=1.000000)	 
     KickForce=0
     PenetrateForce=0
     bPenetrate=False
     ClipFinishSound=(Sound=Sound'BallisticSounds2.Misc.ClipEnd-1',Volume=1.000000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.R9FlashEmitter'
     FlashScaleFactor=0.750000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassOffset=(X=-50.500000,Y=-2.000000,Z=4.000000)
     AimedFireAnim="AimedFire"
     RecoilPerShot=384.000000
     FireChaos=0.450000
     BallisticFireSound=(Sound=Sound'BallisticSounds2.R9.R9-Fire',Volume=0.800000)
     FireRate=0.300000
     AmmoClass=Class'BallisticProV55.Ammo_R9_Rifle'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
	 BotRefireRate=0.700000
	 WarnTargetPct=0.400000
     aimerror=800.000000
}
