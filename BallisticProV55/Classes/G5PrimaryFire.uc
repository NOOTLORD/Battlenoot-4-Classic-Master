//=============================================================================
// Primaryfire class for the G5 Bazooka
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class G5PrimaryFire extends BallisticProProjectileFire;

var() class<Actor>	HatchSmokeClass;
var   Actor			HatchSmoke;
var() Sound			SteamSound;

var int MinMortarRange;

simulated event ModeDoFire()
{
    if (!AllowFire())
        return;

	if (class'BallisticReplicationInfo'.default.bNoReloading && BW.AmmoAmount(0) > 1)
		Weapon.SetBoneScale (0, 1.0, 'Rocket');
	else if (BW.MagAmmo < 2)
		Weapon.SetBoneScale (0, 0.0, 'Rocket');
	Super.ModeDoFire();
}

function DoFireEffect()
{	
    local Vector Start, End, X;
    local Rotator Aim;

	Aim = GetFireAim(Start);
	Aim = Rotator(GetFireSpread() >> Aim);
	X = Normal(Vector(Aim));
	End = Start + X * MinMortarRange;
	
	if (G5Bazooka(Weapon).CurrentWeaponMode == 1)
	{
		if (Weapon.FastTrace(End, Start))
			ProjectileClass = class'G5Mortar';
		else ProjectileClass = class'G5Rocket';
	}
	else if (G5Bazooka(Weapon).bLaserOn && !G5Bazooka(Weapon).bScopeView)
		ProjectileClass = class'G5SeekerRocket';
	else	ProjectileClass = class'G5Rocket';
	Super.DoFireEffect();
}

function SpawnProjectile (Vector Start, Rotator Dir)
{
	Proj = Spawn (ProjectileClass,,, Start, Dir);
	if (Proj == None)
		return;
	Proj.Instigator = Instigator;
	G5Bazooka(Weapon).SetCurrentRocket(Proj);
	if (G5Mortar(Proj) != None)
	{
 		if (G5Bazooka(Weapon).Target != None && G5Bazooka(Weapon).TargetTime >= G5Bazooka(Weapon).LockOnTime)
 		{
 			G5Mortar(Proj).SetMortarTarget(G5Bazooka(Weapon).Target);
 			if (PlayerController(G5Bazooka(Weapon).Target.Controller) != None)
 			PlayerController(G5Bazooka(Weapon).Target.Controller).ReceiveLocalizedMessage(class'G5LockOnMessage', 0); 			
 		}

 		else
 			G5Mortar(Proj).SetMortarTarget(None);
	}
}

simulated function InitEffects()
{
    if ((HatchSmokeClass != None) && ((HatchSmoke == None) || HatchSmoke.bDeleteMe) )
	{
		HatchSmoke = Spawn(HatchSmokeClass, Weapon);

		if ( HatchSmoke != None )
			Weapon.AttachToBone(HatchSmoke, 'tip');

		if (Emitter(HatchSmoke) != None)
			class'BallisticEmitter'.static.ScaleEmitter(Emitter(HatchSmoke), Weapon.DrawScale*FlashScaleFactor);
		else
			HatchSmoke.SetDrawScale(HatchSmoke.DrawScale*Weapon.DrawScale*FlashScaleFactor);

		if (DGVEmitter(HatchSmoke) != None)
			DGVEmitter(HatchSmoke).InitDGV();
	}
	Super.InitEffects();
}

simulated function FlashHatchSmoke()
{
	if (Level.DetailMode < DM_High)
		return;
    if (HatchSmoke != None && Level.TimeSeconds < NextFireTime + 3.0)
	{
		Weapon.PlaySound(SteamSound, SLOT_Misc, 0.3);
		Emitter(HatchSmoke).Emitters[0].SpawnOnTriggerRange.Min = Lerp(((NextFireTime+3.0) - Level.TimeSeconds) / 3.8, 10, 70);
		Emitter(HatchSmoke).Emitters[0].SpawnOnTriggerRange.Max = Emitter(HatchSmoke).Emitters[0].SpawnOnTriggerRange.Min;
        HatchSmoke.Trigger(Weapon, Instigator);
	}
}

simulated function DestroyEffects()
{
	Super.DestroyEffects();

    if (HatchSmoke != None)
	{
		if (Emitter(HatchSmoke) != None)
			Emitter(HatchSmoke).Kill();
		else
			HatchSmoke.Destroy();
	}
}

defaultproperties
{
     HatchSmokeClass=Class'BallisticProV55.G5HatchEmitter'
     SteamSound=Sound'BallisticProSounds.G5.G5-Steam'
     MinMortarRange=1024
     SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
     bCockAfterFire=True
     DryFireSound=(Sound=Sound'BallisticProSounds.Effects.DryRifle',Volume=1.000000,Radius=32.000000,Pitch=1.000000)	 
     MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
     FlashScaleFactor=0.600000
     RecoilPerShot=64.000000
     VelocityRecoil=0.000000	 
     FireChaos=0.500000
     FireChaosCurve=(Points=((InVal=0.000000,OutVal=1.000000),(InVal=1.000000,OutVal=1.000000)))	 	 
     XInaccuracy=4.000000
     YInaccuracy=4.000000
     BallisticFireSound=(Sound=Sound'BallisticProSounds.G5.G5-Fire',Volume=1.100000,Radius=32.000000,Pitch=1.000000)
     FireRate=0.800000
     AmmoClass=Class'BallisticProV55.Ammo_G5Bazooka'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     ProjectileClass=Class'BallisticProV55.G5Rocket'
	 bLeadTarget=True
	 bSplashDamage=True
	 bRecommendSplashDamage=True	 
	 BotRefireRate=0.500000
     WarnTargetPct=0.800000	 
     aimerror=750.000000
}
