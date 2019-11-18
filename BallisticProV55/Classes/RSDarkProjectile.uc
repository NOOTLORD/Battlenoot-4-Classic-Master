//=============================================================================
// RSDarkProjectile.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RSDarkProjectile extends BallisticProjectile;

var bool					bScaleDone;
var float				ScaleTime;
var float 				PullForceMag;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	ScaleTime = level.TimeSeconds + 0.6;
}

// Projectile grows as it comes out the gun...
simulated function Tick(float DT)
{
	local vector DS;

	DS = default.DrawScale3D;
	DS.X = (ScaleTime - level.TimeSeconds) / 0.6;
	
	if (DS.X >= 1)
	{
		DS.X = 1;
		Disable('Tick');
	}
	SetDrawScale3D(DS);
}

simulated function Actor GetDamageVictim (Actor Other, vector HitLocation, vector Dir, out float Dmg, optional out class<DamageType> DT)
{
	Super.GetDamageVictim(Other, HitLocation, Dir, Dmg, DT);
	
	Dmg *= 1 + 1 * (FMin(default.LifeSpan - LifeSpan, 0.6)/0.6);
	DamageRadius *=  1 + 1 * (FMin(default.LifeSpan - LifeSpan, 0.6)/0.6);
	
	return Other;
}

simulated function InitEffects ()
{
	local Vector X,Y,Z;

	bDynamicLight=default.bDynamicLight;
	if (Level.NetMode != NM_DedicatedServer && TrailClass != None && Trail == None)
	{
		GetAxes(Rotation,X,Y,Z);
		Trail = Spawn(TrailClass, self,, Location + X*TrailOffset.X + Y*TrailOffset.Y + Z*TrailOffset.Z, Rotation);
		if (Emitter(Trail) != None)
			class'BallisticEmitter'.static.ScaleEmitter(Emitter(Trail), DrawScale/2);
		if (Trail != None)
			Trail.SetBase (self);
	}
}

simulated function DoDamage(Actor Other, vector HitLocation)
{
	local class<DamageType> DT;
	local float Dmg;
	local actor Victim;
	local bool bWasAlive;
	local DestroyableObjective HealObjective;
	local Vehicle HealVehicle;
	local int AdjustedDamage;
	local int i;
	local Vector ClosestLocation, temp, BoneTestLocation;
	local RSDarkPlasmaBurner PB;
	local Vector MomentumDir;

	if (Instigator != None)
	{
		AdjustedDamage = default.Damage * Instigator.DamageScaling * MyDamageType.default.VehicleDamageScaling;
		if (Instigator.HasUDamage())
			AdjustedDamage *= 2;
	}

	HealObjective = DestroyableObjective(Other);
	if ( HealObjective == None )
		HealObjective = DestroyableObjective(Other.Owner);
	if ( HealObjective != None && HealObjective.TeamLink(Instigator.GetTeamNum()) )
	{
		HealObjective.HealDamage(AdjustedDamage, InstigatorController, myDamageType);
		return;
	}
	HealVehicle = Vehicle(Other);
	if ( HealVehicle != None && HealVehicle.TeamLink(Instigator.GetTeamNum()) )
	{
		HealVehicle.HealDamage(AdjustedDamage, InstigatorController, myDamageType);
		return;
	}

	if ( Instigator == None || Instigator.Controller == None )
		Other.SetDelayedDamageInstigatorController( InstigatorController );

	if (xPawn(Other) != None)
	{
		//Find a point on the victim's Z axis at the same height as the HitLocation.
		ClosestLocation = Other.Location;
		ClosestLocation.Z += (HitLocation - Other.Location).Z;
		
		//Extend the hit along the projectile's Velocity to a point where it is closest to the victim's Z axis.
		temp = Normal(Velocity);
		temp *= VSize(ClosestLocation - HitLocation);
		BoneTestLocation = temp;
		BoneTestLocation *= normal(ClosestLocation - HitLocation) dot normal(temp);
		BoneTestLocation += HitLocation;
		
		Victim = GetDamageVictim(Other, BoneTestLocation, Normal(Velocity), Dmg, DT);;
	}

	else Victim = GetDamageVictim(Other, HitLocation, Normal(Velocity), Dmg, DT);

	if (xPawn(Victim) != None && Pawn(Victim).Health > 0)
	{
		if (Monster(Victim) == None || Pawn(Victim).default.Health > 275)
			bWasAlive = true;
	}
	else if (Vehicle(Victim) != None && Vehicle(Victim).Driver!=None && Vehicle(Victim).Driver.Health > 0)
		bWasAlive = true;
		
	if (Pawn(Other) != None)
	{
		for (i=0;i<Other.Attached.length;i++)
		{
			if (RSDarkPlasmaBurner(Other.Attached[i])!=None)
			{
				RSDarkPlasmaBurner(Other.Attached[i]).AddPower(2);
				break;
			}
		}
		if (i>=Other.Attached.length)
		{
			PB = Spawn(class'RSDarkPlasmaBurner',Other,,Other.Location);
			PB.Initialize(Other);
			PB.AddPower(8);
			if (Instigator!=None)
			{
				PB.Instigator = Instigator;
				PB.InstigatorController = Instigator.Controller;
			}
		}
	}
	
	if (VSize(Instigator.Location - Other.Location) > 1024)
		MomentumDir = vect(0,0,15000) + ((default.LifeSpan - LifeSpan) * PullForceMag * Normal(Instigator.Location - Other.Location));
	else MomentumDir = vect(0,0,1000) + (10000 * Normal(Other.Location - Instigator.Location));

	class'BallisticDamageType'.static.GenericHurt (Victim, Dmg, Instigator, HitLocation, MomentumDir, DT);

	if (bWasAlive && Pawn(Victim).Health <= 0)
		class'RSDarkSoul'.static.SpawnSoul(HitLocation, Instigator, Pawn(Other), self);
}

simulated function DoVehicleDriverRadius(Vehicle Other)
{
	local bool bWasAlive;
	local Pawn D;

	if (Other.Driver != None && Other.Driver.health > 0)
	{
		D = Other.Driver;
		bWasAlive = true;
	}

	Other.DriverRadiusDamage(Damage, DamageRadius, InstigatorController, MyDamageType, MomentumTransfer, Location);

	if (bWasAlive && (D == None || D.Health <= 0))
		class'RSDarkSoul'.static.SpawnSoul(Location, Instigator, D, self);
}

simulated singular function HitWall(vector HitNormal, actor Wall)
{
	local Vehicle HealVehicle;
	local int AdjustedDamage;

	HealVehicle = Vehicle(Wall);
	if ( HealVehicle != None && HealVehicle.TeamLink(Instigator.GetTeamNum()) )
	{
		AdjustedDamage = default.Damage * Instigator.DamageScaling * MyDamageType.default.VehicleDamageScaling;
		if (Instigator.HasUDamage())
			AdjustedDamage *= 2;
		HealVehicle.HealDamage(AdjustedDamage, Instigator.Controller, myDamageType);
	}
	
	if (Role < ROLE_Authority)
		return;
	
	if ( !Wall.bStatic && !Wall.bWorldGeometry )
	{
		if ( Instigator == None || Instigator.Controller == None )
			Wall.SetDelayedDamageInstigatorController( InstigatorController );
		DoDamage(Wall, Location);
		if (DamageRadius > 0 && Vehicle(Wall) != None && Vehicle(Wall).Health > 0)
			DoVehicleDriverRadius(Vehicle(Wall));
		HurtWall = Wall;
	}
	MakeNoise(1.0);
	
	Damage *= 0.75;
	DamageRadius *= 0.5;
	
	Explode(Location + ExploWallOut * HitNormal, HitNormal);

	HurtWall = None;
}


// Hit something interesting
simulated function ProcessTouch (Actor Other, vector HitLocation)
{
	if (Other == None || (!bCanHitOwner && (Other == Instigator || Other == Owner)) || RSDarkProjectile(Other)!=None || RSDarkFastProjectile(Other)!=None)
		return;

		
	if (Role == ROLE_Authority && Other != HitActor)		// Do damage for direct hits
		DoDamage(Other, HitLocation);
	if (Pawn(Other) != None && Pawn(Other).Health <= 0)
		PenetrateManager.static.StartSpawn(HitLocation, Other.Location-HitLocation, 2, Level.GetLocalPlayerController(), 4/*HF_NoDecals*/);
	else
		PenetrateManager.static.StartSpawn(HitLocation, Other.Location-HitLocation, 1, Level.GetLocalPlayerController(), 4/*HF_NoDecals*/);
	ImpactManager = None;
	if (Role == ROLE_Authority)
	{
		HitActor = Other;
		Explode(HitLocation, vect(0,0,1));
	}
}

event TakeDamage( int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
	Local RSDeathball DB;
    if (DamageType == class'DT_RSNovaSlow')
    {
		ImpactManager.static.StartSpawn(HitLocation, normal(Momentum), 5, Level.GetLocalPlayerController(), 4/*HF_NoDecals*/);
//		Instigator = EventInstigator;
//		SuperExplosion();
    }
    else if (DamageType == class'DT_RSNovaLightning')
    {
    	//FIXME: Network...
    	DB = Spawn(class'RSDeathBall',EventInstigator,,Location,rotator(velocity));
    	DB.Instigator = EventInstigator;
	DB.InstigatorController = EventInstigator.Controller;
    	DB.SetTarget(Instigator, false);
    	Destroy();
    }
}

simulated function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Excluded )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;
	local bool bWasAlive;
//	local RSDarkSoul Soul;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach VisibleCollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Excluded && Victims != HurtWall)
		{
			if (xPawn(Victims) != None && Pawn(Victims).Health > 0)
				bWasAlive = true;
			else if (Vehicle(Victims) != None && Vehicle(Victims).Driver!=None && Vehicle(Victims).Driver.Health > 0)
				bWasAlive = true;
			else
				bWasAlive = false;
			dir = Victims.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
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
			if (bWasAlive && Pawn(Victims).Health <= 0)
				class'RSDarkSoul'.static.SpawnSoul(HitLocation, Instigator, Pawn(Victims), self);
/*			{
				Soul = Spawn(class'RSDarkSoul',,, HitLocation);
				if (Soul!=None)
					Soul.Assailant = Instigator;
			}
*/		}
	}
	bHurtEntry = false;
}

state NetTrapped
{
	function BeginState()
	{
		HideProjectile();
		SetTimer(NetTrappedDelay, false);
		DestroyEffects();
	}
}

simulated function DestroyEffects()
{
	if (Trail != None)
	{
		if (Emitter(Trail) != None)
		{
			Emitter(Trail).Kill();
			Emitter(Trail).Emitters[0].Disabled=true;
			Emitter(Trail).Emitters[1].Disabled=true;
			Emitter(Trail).Emitters[2].Disabled=true;
			Emitter(Trail).Emitters[3].Disabled=true;
		}
		else
			Trail.Destroy();
	}
}

defaultproperties
{
     PullForceMag=800000.000000
     ImpactManager=Class'BallisticProV55.IM_RSDarkProjectile'
     PenetrateManager=Class'BallisticProV55.IM_RSDarkProjectile'
     bRandomStartRotaion=False
     AccelSpeed=50000.000000
     TrailClass=Class'BallisticProV55.RSDark1Trail'
     MyRadiusDamageType=Class'BallisticProV55.DT_RSDarkSlow'
     DamageHead=20.000000
     DamageLimb=20.000000
     DamageTypeHead=Class'BallisticProV55.DT_RSDarkSlow'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=384.000000
     ShakeRotMag=(Y=200.000000,Z=128.000000)
     ShakeRotRate=(X=3000.000000,Z=3000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(Y=15.000000,Z=15.000000)
     ShakeOffsetTime=2.000000
     Speed=3000.000000
     MaxSpeed=60000.000000
     bSwitchToZeroCollision=True
     Damage=20.000000
     DamageRadius=128.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'BallisticProV55.DT_RSDarkSlow'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightBrightness=160.000000
     LightRadius=12.000000
     StaticMesh=StaticMesh'BWBP4-Hardware.DarkStar.DarkProjBig'
     bDynamicLight=True
     bNetTemporary=False
     bSkipActorPropertyReplication=True
     bOnlyDirtyReplication=True
     AmbientSound=Sound'BWBP4-Sounds.NovaStaff.Nova-Fire1FlyBy'
     LifeSpan=4.000000
     DrawScale=2.000000
     DrawScale3D=(X=1.500000)
     SoundVolume=255
     SoundRadius=75.000000
     CollisionRadius=1.000000
     CollisionHeight=1.000000
     bProjTarget=True
     RotationRate=(Roll=16384)
}
