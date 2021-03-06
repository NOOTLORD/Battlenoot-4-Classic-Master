//=============================================================================
// NRP57 Thrown projectile class
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class NRP57Thrown extends BallisticProPineapple;

var   Emitter PATrail;

simulated function InitEffects ()
{
	super.InitEffects();

	if (Level.NetMode != NM_DedicatedServer && Speed > 400 && PATrail==None && level.DetailMode == DM_SuperHigh)
	{
		PATrail = Spawn(class'PineappleTrail', self,, Location);
		if (PATrail != None)
			class'BallisticEmitter'.static.ScaleEmitter(PATrail, DrawScale);
		if (PATrail != None)
			PATrail.SetBase (self);
	}
}

simulated function DestroyEffects()
{
	super.DestroyEffects();
	if (PATrail != None)
		PATrail.Kill();
}

function InitProPineapple(float PSpeed, float PDelay)
{
	PDelay = FMax(PDelay + (0.5 - FRand()) * 0.5, 0.1);
	
	Speed = PSpeed;

	DetonateDelay = PDelay;
	NewDetonateDelay = DetonateDelay;

	if (DetonateDelay <= StartDelay)
		StartDelay = DetonateDelay / 2;
}

defaultproperties
{
     DampenFactor=0.050000
     DampenFactorParallel=0.350000
     DetonateDelay=3.000000
     ImpactDamage=15
     ImpactDamageType=Class'BallisticProV55.DT_NRP57Grenade'
     ImpactManager=Class'BallisticProV55.IM_NRP57Grenade'
     TrailClass=Class'BallisticProV55.NRP57Trail'
     TrailOffset=(X=1.600000,Z=6.400000)
     MyRadiusDamageType=Class'BallisticProV55.DT_NRP57GrenadeRadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=0.000000
     MotionBlurRadius=0.000000
	 bCoverPenetrator=False
     MotionBlurFactor=0.000000
     MotionBlurTime=0.000000
     ShakeRotTime=0.000000
     ShakeOffsetTime=0.000000
     Speed=1400.000000
     MaxSpeed=1500.000000
     Damage=125.000000
     DamageRadius=512.000000
     MyDamageType=Class'BallisticProV55.DT_NRP57Grenade'
     ImpactSound=SoundGroup'BallisticProSounds.Effects.Grenade-Concrete'
     StaticMesh=StaticMesh'BallisticProStatic.NRP57.NRP57Proj'
     AmbientGlow=40
     bUnlit=False
     CollisionRadius=0.000000
     CollisionHeight=0.000000
     bUseCylinderCollision=True
}
