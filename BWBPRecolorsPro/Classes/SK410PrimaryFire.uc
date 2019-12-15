//=============================================================================
// SK410PrimaryFire.
//
// Moderately strong shotgun blast with decent spread and fair range for a shotgun.
// Can do more damage than the M763, but requires more shots normally.
//
// Can fire its shells HE mode, however it's nowhere near as strong as a FRAG.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SK410PrimaryFire extends BallisticProShotgunFire;

// Even if we hit nothing, this is already taken care of in DoFireEffects()...
function NoHitEffect (Vector Dir, optional vector Start, optional vector HitLocation, optional vector WaterHitLoc)
{
	local Vector V;

	V = Instigator.Location + Instigator.EyePosition() + Dir * TraceRange.Min;
	if (TracerClass != None && Level.DetailMode > DM_Low && class'BallisticMod'.default.EffectsDetailMode > 0 && VSize(V - BallisticAttachment(Instigator.Weapon.ThirdPersonActor).GetTipLocation()) > 200 && FRand() < TracerChance)
		Spawn(TracerClass, instigator, , BallisticAttachment(Instigator.Weapon.ThirdPersonActor).GetTipLocation(), Rotator(V - BallisticAttachment(Instigator.Weapon.ThirdPersonActor).GetTipLocation()));
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
	Weapon.HurtRadius(1, 128, DamageType, 1, HitLocation);
	return true;
}


simulated function DestroyEffects()
{
    if (MuzzleFlash != None)
		MuzzleFlash.Destroy();
	Super.DestroyEffects();
}

defaultproperties
{
     HipSpreadFactor=2.000000
     CutOffDistance=1280.000000
     CutOffStartRange=512.000000
     MaxSpreadFactor=6
     TraceCount=3
     TracerClass=Class'BWBPRecolorsPro.TraceEmitter_ShotgunHE'
     ImpactManager=Class'BWBPRecolorsPro.IM_ShellHE'
     TraceRange=(Min=4000.000000,Max=6000.000000)
     MaxWalls=1
     Damage=25.000000
     DamageHead=50.000000
     DamageLimb=25.000000
     RangeAtten=0.700000
     DamageType=Class'BWBPRecolorsPro.DT_SK410Shotgun'
     DamageTypeHead=Class'BWBPRecolorsPro.DT_SK410ShotgunHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DT_SK410Shotgun'
     MuzzleFlashClass=Class'BWBPRecolorsPro.SK410HeatEmitter'
     FlashScaleFactor=0.750000
     BrassClass=Class'BWBPRecolorsPro.Brass_ShotgunHE'
     BrassOffset=(X=-50.000000,Y=5.000000,Z=-6.500000)
     AimedFireAnim="SightFire"
     RecoilPerShot=240.000000
     VelocityRecoil=180.000000
     FireChaos=0.040000
     XInaccuracy=200.000000
     YInaccuracy=200.000000
     BallisticFireSound=(Sound=Sound'PackageSounds4Pro.M781.M781-Blast',Volume=2.000000)
     FireEndAnim=
     FireAnimRate=2.250000
     FireRate=0.220000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_8GaugeHE'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=0.000000						  
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=0.000000							 
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
     aimerror=600.000000
}
