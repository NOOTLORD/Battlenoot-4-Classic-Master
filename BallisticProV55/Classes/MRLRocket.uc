//=============================================================================
// MRLRocket.
//
// A Crazy, unpredictable and not too powerful small 'drunk' rocket. They move
// fast and unpredictably, but usually come with lots of others.
//
// Drunkness:
// -Initial low accuracy
// -Duds
// -Strafing
// -Sidewinders
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class MRLRocket extends BallisticProjectile;

//var   float		FuelOutTime;

var     int			RollRange;


simulated event PostBeginPlay()
{
	RotationRate.Roll = RollRange*(FRand()*2-1.0);
	super.PostBeginPlay();
}

simulated event Landed( vector HitNormal )
{
	HitWall( HitNormal, Level );
}

// Hit something interesting
simulated function ProcessTouch (Actor Other, vector HitLocation)
{
    local Vector X;

	if (Other == None || (!bCanHitOwner && (Other == Instigator || Other == Owner)))
		return;

	if (Role == ROLE_Authority && HitActor != Other)		// Do damage for direct hits
		DoDamage(Other, HitLocation);
	if (CanPenetrate(Other) && Other != HitActor)
	{	// Projectile can go right through enemies
		HitActor = Other;
		X = Normal(Velocity);
		SetLocation(HitLocation + (X * (Other.CollisionHeight*2*X.Z + Other.CollisionRadius*2*(1-X.Z)) * 1.2));
	    if ( EffectIsRelevant(Location,false) && PenetrateManager != None)
			PenetrateManager.static.StartSpawn(HitLocation, Other.Location-HitLocation, Other.SurfaceType, Owner, 4/*HF_NoDecals*/);
	}
	else
	{	// Spawn projectile death effects and try radius damage
		HitActor = Other;
		Explode(HitLocation, vect(0,0,1));
	}
}

// Special HurtRadius function. This will hurt everyone except the chosen victim.
// Useful if you want to spare a directly hit enemy from the radius damage
function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	
	if (Pawn(Victim) == None)
	{
		DamageAmount *= 0.5;
		DamageRadius *= 0.75;
	}
	foreach CollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Victim && Victims != HurtWall)
		{
			if (!FastTrace(Victims.Location, Location))
				continue;
					
			dir = Victims.Location;
			if (Victims.Location.Z > HitLocation.Z)
				dir.Z = FMax(HitLocation.Z, dir.Z - Victims.CollisionHeight);
			else dir.Z = FMin(HitLocation.Z, dir.Z + Victims.CollisionHeight);
			dir -= HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/ DamageRadius);
			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				Square(damageScale) * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(damageScale * Momentum * dir),
				DamageType
			);
		 }
	}
	bHurtEntry = false;
}

defaultproperties
{
     RollRange=192000
     ImpactManager=Class'BallisticProV55.IM_MRLRocket'
     bRandomStartRotaion=False
     AccelSpeed=12000.000000
     TrailClass=Class'BallisticProV55.MRLTrailEmitter'
     TrailOffset=(X=-4.000000)
     MyRadiusDamageType=Class'BallisticProV55.DT_MRLRadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     Speed=1000.000000
     MaxSpeed=25000.000000
     Damage=35.000000
     DamageRadius=384.000000
     MomentumTransfer=5500.000000
     MyDamageType=Class'BallisticProV55.DT_MRL'
     StaticMesh=StaticMesh'BWBP4-Hardware.MRL.MRLRocket'
     AmbientSound=Sound'BWBP4-Sounds.MRL.MRL-RocketFly'
     DrawScale=0.350000
     SoundVolume=64
     bFixedRotationDir=True
     RotationRate=(Roll=32768)
}
