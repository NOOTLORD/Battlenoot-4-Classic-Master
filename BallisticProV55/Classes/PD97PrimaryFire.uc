//=============================================================================
// Primaryfire class for the PD-97 Pistol
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
	
	PD97Pistol(BW).ShellFired();
}

function SpawnProjectile (Vector Start, Rotator Dir)
{
	Proj = Spawn (ProjectileClass,,, Start, Dir);
	if (Proj != None)
	{
		Proj.Instigator = Instigator;
		PD97Dart(Proj).Master = PD97Pistol(BW);
	}
}

defaultproperties
{
     SpawnOffset=(X=15.000000,Y=29.000000,Z=-20.000000)	 
     DryFireSound=(Sound=Sound'BallisticProSounds.Effects.DryPistol',Volume=0.850000,Radius=32.000000,Pitch=1.000000)	 
	 MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashScaleFactor=0.250000
     AimedFireAnim="SightFire"
     RecoilPerShot=256.000000
     VelocityRecoil=0.000000	 
     FireChaos=0.150000	
     FireChaosCurve=(Points=((InVal=0.000000,OutVal=1.000000),(InVal=1.000000,OutVal=1.000000)))	 	 
     FireAnimRate=1.100000
     XInaccuracy=32.000000
     YInaccuracy=32.000000	 
     FireForce="AssaultRifleAltFire"
     BallisticFireSound=(Sound=Sound'BallisticProSounds.XMK-5.XMK-5-FireDart',Volume=1.750000,Radius=32.000000,Pitch=1.000000)	 
     FireRate=0.400000
     AmmoClass=Class'BallisticProV55.Ammo_PD97Pistol'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     ProjectileClass=Class'BallisticProV55.PD97Dart'
     BotRefireRate=0.700000
     WarnTargetPct=0.300000	 
}
