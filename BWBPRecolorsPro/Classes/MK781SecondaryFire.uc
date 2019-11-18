//=============================================================================
// Mk781SecondaryFire.
//=============================================================================
class Mk781SecondaryFire extends BallisticProShotgunFire;

var   bool		bLoaded; 		//Do we even have grenades?
var   bool		bIsCharging; 	//Are we charging?
var   float RailPower;
var   float ChargeRate;
var   float PowerLevel;
var   float MaxCharge;

var() Vector			SpawnOffset;		// Projectile spawned at this offset
var	  Projectile		Proj;				// The projectile actor

var() sound		PulseFireSound;
var() sound		ShotFireSound;


var       float		HUDRefreshTime;		// Used to keep the damn thing pretty


// Check if there is ammo in mag if we use it or is there some in inventory if we don't
simulated function bool AllowFire()
{
	if (BW.BCRepClass.default.bSightFireOnly && !BW.bScopeView)
	{
		if (PlayerController(Instigator.Controller) != None)
			PlayerController(Instigator.Controller).ClientMessage("You can only fire from sights.");
		return false;
	}
	if (!CheckReloading())
		return false;		// Is weapon busy reloading
	if (!CheckWeaponMode())
		return false;		// Will weapon mode allow further firing
	if (Mk781Shotgun(BW).Grenades == 0 && !Mk781Shotgun(BW).bReady)
	{
		if (!bPlayedDryFire && DryFireSound.Sound != None)
		{
			Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
			bPlayedDryFire=true;
		}
		if (bDryUncock)
			BW.bNeedCock=true;
		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, 0);

		Mk781Shotgun(BW).EmptyAltFire(ThisModeNum);
		return false;		// Is there ammo in weapon's mag
	}
    return true;
}

simulated event ModeDoFire()
{
	if (!AllowFire())
		return;

	if (!Mk781Shotgun(Weapon).bReady)
	{
		Mk781Shotgun(Weapon).PrepAltFire();
		return;
	}
	else
	{
		super.ModeDoFire();
		Mk781Shotgun(Weapon).bReady = false;
		Mk781Shotgun(Weapon).PrepPriFire();
	}
}

simulated function SwitchSilencerMode(bool bSilenced)
{
	if (bSilenced == true)
	{
		XInaccuracy=0;
		YInaccuracy=0;
		Mk781Attachment(Weapon.ThirdPersonActor).bSilenced=true;
		ProjectileClass=Class'Mk781PulseProjectile';
		BallisticFireSound.Sound=PulseFireSound;
		bLeadTarget=true;
		bInstantHit=false;
		GotoState('ElektroSlug');
		bSplashDamage=True;
		bRecommendSplashDamage=True;
		WarnTargetPct=0.10000;
	}
	
	else
	{
		XInaccuracy=default.XInaccuracy;
		YInaccuracy=default.YInaccuracy;
		Mk781Attachment(Weapon.ThirdPersonActor).bSilenced=false;
		ProjectileClass=None;
		BallisticFireSound.Sound=ShotFireSound;
		bLeadTarget=false;
		bInstantHit=true;
		GotoState('ElektroShot');
		bSplashDamage=false;
		bRecommendSplashDamage=false;
		WarnTargetPct=0.010000;
	}
}

simulated state ElektroSlug
{
	// Became complicated when acceleration came into the picture
	// Override for even weirder situations
	function float MaxRange()
	{
		if (ProjectileClass.default.MaxSpeed > ProjectileClass.default.Speed)
		{
			// We know BW projectiles have AccelSpeed
			if (class<BallisticProjectile>(ProjectileClass) != None && class<BallisticProjectile>(ProjectileClass).default.AccelSpeed > 0)
			{
				if (ProjectileClass.default.LifeSpan <= 0)
					return FMin(ProjectileClass.default.MaxSpeed, (ProjectileClass.default.Speed + class<BallisticProjectile>(ProjectileClass).default.AccelSpeed * 2) * 2);
				else
					return FMin(ProjectileClass.default.MaxSpeed, (ProjectileClass.default.Speed + class<BallisticProjectile>(ProjectileClass).default.AccelSpeed * ProjectileClass.default.LifeSpan) * ProjectileClass.default.LifeSpan);
			}
			// For the rest, just use the max speed
			else
			{
				if (ProjectileClass.default.LifeSpan <= 0)
					return ProjectileClass.default.MaxSpeed * 2;
				else
					return ProjectileClass.default.MaxSpeed * ProjectileClass.default.LifeSpan*0.75;
			}
		}
		else // Hopefully this proj doesn't change speed.
		{
			if (ProjectileClass.default.LifeSpan <= 0)
				return ProjectileClass.default.Speed * 2;
			else
				return ProjectileClass.default.Speed * ProjectileClass.default.LifeSpan;
		}
	}

	// Get aim then spawn projectile
	function DoFireEffect()
	{
		local Vector StartTrace, X, Y, Z, Start, End, HitLocation, HitNormal;
		local Rotator Aim;
		local actor Other;

	    Weapon.GetViewAxes(X,Y,Z);
    	// the to-hit trace always starts right in front of the eye
	    Start = Instigator.Location + Instigator.EyePosition();

	    StartTrace = Start + X*SpawnOffset.X + Z*SpawnOffset.Z;
    	if ( !Weapon.WeaponCentered() )
		    StartTrace = StartTrace + Weapon.Hand * Y*SpawnOffset.Y;

		Aim = GetFireAim(StartTrace);
		Aim = Rotator(GetFireSpread() >> Aim);

		End = Start + (Vector(Aim)*MaxRange());
		Other = Trace (HitLocation, HitNormal, End, Start, true);

		if (Other != None)
			Aim = Rotator(HitLocation-StartTrace);
	    SpawnProjectile(StartTrace, Aim);

		SendFireEffect(none, vect(0,0,0), StartTrace, 0);
		// Skip the instant fire version which would cause instant trace damage.
		Super(BallisticFire).DoFireEffect();
	}

	function SpawnProjectile (Vector Start, Rotator Dir)
	{
		Proj = Spawn (ProjectileClass,,, Start, Dir);
		Proj.Instigator = Instigator;
	}
}

simulated state ElektroShot
{
// Get aim then run several individual traces using different spread for each one
function DoFireEffect()
{
    local Vector StartTrace;
    local Rotator R, Aim;
	local int i;

	Aim = GetFireAim(StartTrace);
	for (i=0;i<TraceCount;i++)
	{
		R = Rotator(GetFireSpread() >> Aim);
		DoTrace(StartTrace, R);
	}
	// Tell the attachment the aim. It will calculate the rest for the clients
	SendFireEffect(none, Vector(Aim)*TraceRange.Max, StartTrace, 0);

	Super(BallisticFire).DoFireEffect();
}

// Even if we hit nothing, this is already taken care of in DoFireEffects()...
function NoHitEffect (Vector Dir, optional vector Start, optional vector HitLocation, optional vector WaterHitLoc)
{
	local Vector V;

	V = Instigator.Location + Instigator.EyePosition() + Dir * TraceRange.Min;
	if (TracerClass != None && Level.DetailMode > DM_Low && class'BallisticMod'.default.EffectsDetailMode > 0 && VSize(V - BallisticAttachment(Weapon.ThirdPersonActor).GetTipLocation()) > 200 && FRand() < TracerChance)
		Spawn(TracerClass, instigator, , BallisticAttachment(Weapon.ThirdPersonActor).GetTipLocation(), Rotator(V - BallisticAttachment(Weapon.ThirdPersonActor).GetTipLocation()));
	if (ImpactManager != None && WaterHitLoc != vect(0,0,0) && Weapon.EffectIsRelevant(WaterHitLoc,false) && bDoWaterSplash)
		ImpactManager.static.StartSpawn(WaterHitLoc, Normal((Instigator.Location + Instigator.EyePosition()) - WaterHitLoc), 9, Instigator);
}

// Spawn the impact effects here for StandAlone and ListenServers cause the attachment won't do it
simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
	local int Surf;

	if (ImpactManager != None && WaterHitLoc != vect(0,0,0) && Weapon.EffectIsRelevant(WaterHitLoc,false) && bDoWaterSplash)
		ImpactManager.static.StartSpawn(WaterHitLoc, Normal((Instigator.Location + Instigator.EyePosition()) - WaterHitLoc), 9, Instigator);

	if (!Other.bWorldGeometry && Mover(Other) == None)
		return false;

	if (!bAISilent)
		Instigator.MakeNoise(1.0);
	if (ImpactManager != None && Weapon.EffectIsRelevant(HitLocation,false))
	{
		if (Vehicle(Other) != None)
			Surf = 3;
		else if (HitMat == None)
			Surf = int(Other.SurfaceType);
		else
			Surf = int(HitMat.SurfaceType);
		ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, instigator);
		if (TracerClass != None && Level.DetailMode > DM_Low && class'BallisticMod'.default.EffectsDetailMode > 0 && VSize(HitLocation - BallisticAttachment(Weapon.ThirdPersonActor).GetTipLocation()) > 200 && FRand() < TracerChance)
			Spawn(TracerClass, instigator, , BallisticAttachment(Weapon.ThirdPersonActor).GetTipLocation(), Rotator(HitLocation - BallisticAttachment(Weapon.ThirdPersonActor).GetTipLocation()));
	}
	return true;
}

}

defaultproperties
{
     SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
     PulseFireSound=Sound'PackageSounds4ProExp.Autolaser.AutoLaser-Fire'
     ShotFireSound=Sound'PackageSounds4ProExp.HyperBeamCannon.343Primary-Hit'
     CutOffDistance=1.000000
     CutOffStartRange=1.000000
     TraceCount=7
     TracerClass=Class'BWBPRecolorsPro.TraceEmitter_Supercharge'
     ImpactManager=Class'BWBPRecolorsPro.IM_Supercharge'
     TraceRange=(Min=2000.000000,Max=4000.000000)
     Damage=10.000000
     DamageHead=10.000000
     DamageLimb=10.000000
     DamageType=Class'BWBPRecolorsPro.DT_Mk781Electro'
     DamageTypeHead=Class'BWBPRecolorsPro.DT_Mk781Electro'
     DamageTypeArm=Class'BWBPRecolorsPro.DT_Mk781Electro'
     KickForce=8000
     PenetrateForce=100
     bPenetrate=True
     bUseWeaponMag=False
     MuzzleFlashClass=Class'BWBPRecolorsPro.PlasmaFlashEmitter'
     FlashScaleFactor=2.000000
     BrassClass=Class'BWBPRecolorsPro.Brass_ShotgunZap'
     BrassOffset=(X=-1.000000,Z=-1.000000)
     RecoilPerShot=768.000000
     VelocityRecoil=180.000000
     XInaccuracy=150.000000
     YInaccuracy=150.000000
     BallisticFireSound=(Sound=Sound'PackageSounds4ProExp.HyperBeamCannon.343Primary-Hit',Volume=1.600000)
     FireEndAnim=
     FireRate=0.800000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_10GaugeZap'
     AmmoPerFire=0
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BWBPRecolorsPro.MK781PulseProjectile'
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
     aimerror=400.000000
}
