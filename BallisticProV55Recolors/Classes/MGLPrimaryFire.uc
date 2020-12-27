//=============================================================================
// Primaryfire class for the MGL Launcher
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class MGLPrimaryFire extends BallisticProProjectileFire;

defaultproperties
{
     SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
     DryFireSound=(Sound=Sound'BallisticProSounds.Effects.DryRifle',Volume=1.000000,Radius=32.000000,Pitch=1.000000)	 
     MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
     AimedFireAnim="SightFire"
     RecoilPerShot=768.000000
     VelocityRecoil=0.000000 	 
     FireChaos=0.650000
     FireChaosCurve=(Points=((InVal=0.000000,OutVal=1.000000),(InVal=1.000000,OutVal=1.000000)))	 
     XInaccuracy=32.000000
     YInaccuracy=32.000000	 
     BallisticFireSound=(Sound=Sound'BallisticProRecolorsSounds.MGL.MGL-Fire',Volume=0.950000)
     bModeExclusive=False
     FireForce="AssaultRifleAltFire"
     FireRate=0.850000
     AmmoClass=Class'BallisticProV55Recolors.Ammo_MGLLauncher'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     ProjectileClass=Class'BallisticProV55Recolors.MGLGrenadeTimed'  												 
	 bLeadTarget=True
	 bTossed=True
	 bSplashDamage=True
	 bRecommendSplashDamage=True
	 BotRefireRate=0.500000
     WarnTargetPct=0.750000
	 aimerror=550.000000
}
