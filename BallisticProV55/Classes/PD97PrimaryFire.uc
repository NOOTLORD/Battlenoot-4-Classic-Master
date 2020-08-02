//=============================================================================
// Primaryfire class for the PD-97 Bloodhound
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class PD97PrimaryFire extends BallisticProProjectileFire;

simulated function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		BW.IdleAnim = 'OpenIdle';
		BW.ReloadAnim = 'OpenReload';
		AimedFireAnim = 'OpenSightFire';
		FireAnim = 'OpenFire';
	}
	else
	{
		BW.IdleAnim = 'Idle';
		BW.ReloadAnim = 'Reload';
		AimedFireAnim = 'SightFire';
		FireAnim = 'Fire';
	}
	
	Super.PlayFiring();
	
	PD97Bloodhound(BW).ShellFired();
}

function SpawnProjectile (Vector Start, Rotator Dir)
{
	Proj = Spawn (ProjectileClass,,, Start, Dir);
	if (Proj != None)
	{
		Proj.Instigator = Instigator;
		PD97Dart(Proj).Master = PD97Bloodhound(BW);
	}
}

defaultproperties
{
     SpawnOffset=(X=15.000000,Y=29.000000,Z=-20.000000)
     DryFireSound=(Sound=Sound'BallisticSounds2.Misc.DryPistol',Volume=0.850000)	 
	 MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashScaleFactor=0.250000
     AimedFireAnim="SightFire"
     RecoilPerShot=256.000000
     FireChaos=0.150000
     BallisticFireSound=(Sound=Sound'BallisticSounds1.OA-SMG.OA-SMG_FireDart',Volume=1.750000)
     PreFireAnim=				 
     FireAnimRate=1.100000
     FireForce="AssaultRifleAltFire"
     FireRate=0.400000
     AmmoClass=Class'BallisticProV55.Ammo_PD97_Pistol'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     ProjectileClass=Class'BallisticProV55.PD97Dart'
     BotRefireRate=0.700000
}
