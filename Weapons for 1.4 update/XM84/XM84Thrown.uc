//=============================================================================
// XM84 Thrown projectile class
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class XM84Thrown extends BallisticPineapple;

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

simulated event KVelDropBelow()
{
	super.KVelDropBelow();

	if (PATrail != None)
		PATrail.Kill();
}

simulated event KImpact(actor other, vector pos, vector impactVel, vector impactNorm)
{
	super.KImpact(other, pos, impactVel, impactNorm);
	if (PATrail!= None && VSize(impactVel) > 200)
		PATrail.Kill();
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	if (ShakeRadius > 0)
		ShakeView(HitLocation);
	BlowUp(HitLocation);
    	if (ImpactManager != None)
	{
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Level.GetLocalPlayerController()/*.Pawn*/);
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Instigator);
	}
	if (Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer)
	{
		bTearOff = true;
		GotoState('NetTrapped');
	}
	else
		Destroy();
}

// Useful if you want to spare a directly hit enemy from the radius damage
function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
{
	local Pawn Victims;
	local float damageScale, dist;
	local vector dir;
	local XM84ActorCorrupt PF;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach VisibleCollidingActors( class 'Pawn', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if(Victims != Victim)
		{
			if (Vector(Victims.Rotation) Dot Normal(Location - Victims.Location) < 0.2)
				continue;
			dir = Victims.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				damageScale * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(damageScale * Momentum * dir),
				DamageType
			);

			PF = Spawn(class'XM84ActorCorrupt',self, ,Victims.Location);
			PF.Instigator = Instigator;

			if ( Role == ROLE_Authority && Instigator != None && Instigator.Controller != None )
				PF.InstigatorController = Instigator.Controller;
			PF.Initialize(Victims);
		}
	}
	bHurtEntry = false;
}

defaultproperties
{
     DetonateDelay=2.000000
     ImpactDamage=15
     ImpactDamageType=Class'BWBPRecolorsPro.DT_XM84Hit'
     ImpactManager=Class'BWBPRecolorsPro.IM_XM84Grenade'
     TrailClass=Class'BWBPRecolorsPro.XM84Trail'
     TrailOffset=(X=1.600000,Z=6.400000)
     MyRadiusDamageType=Class'BWBPRecolorsPro.DT_XM84GrenadeRadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=0.000000
     MotionBlurRadius=1000.000000
     ShakeRotMag=(X=0.000000,Y=0.000000)
     ShakeRotRate=(X=0.000000,Z=0.000000)
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     Damage=45.000000
     DamageRadius=768.000000
     MyDamageType=Class'BWBPRecolorsPro.DT_XM84GrenadeRadius'
     ImpactSound=SoundGroup'BallisticSounds2.NRP57.NRP57-Concrete'
     StaticMesh=StaticMesh'BallisticRecolorsStatic.XM84.XM84Projectile'
     DrawScale=1.000000
}
