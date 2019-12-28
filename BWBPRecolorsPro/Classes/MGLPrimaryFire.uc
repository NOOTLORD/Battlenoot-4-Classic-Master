//=============================================================================
// M50SecondaryFire.
//
// A grenade that bonces off walls and detonates a certain time after impact
// Good for scaring enemies out of dark corners and not much else
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.

// Edited by (NL)NOOTLORD
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
     AmmoClass=Class'BWBPRecolorsPro.Ammo_MGL'
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=0.000000
     ProjectileClass=Class'BWBPRecolorsPro.MGLGrenadeTimed'
     BotRefireRate=0.300000
     WarnTargetPct=0.300000
}
