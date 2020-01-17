//=============================================================================
// Main Primaryfire class for MGL Grenade Launcher
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
     MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
     AimedFireAnim="SightFire"
     RecoilPerShot=768.000000
     FireChaos=0.650000
     BallisticFireSound=(Sound=Sound'PackageSounds4ProExp.MGL.MGL-Fire',Volume=9.200000)
     bSplashDamage=True
     bRecommendSplashDamage=True
     bTossed=True
     bModeExclusive=False
     FireForce="AssaultRifleAltFire"
     FireRate=0.850000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_MGLDrum'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     ProjectileClass=Class'BWBPRecolorsPro.MGLGrenadeTimed'
	 BotRefireRate=0.5
     WarnTargetPct=0.75
}
