//=============================================================================
// LonghornClusterGrenadeAlt.
//
// Small cluster bomb used by alt fire. Moves very fast but otherwise behaves
// very much like LonghornClusterGrenadeFlak.
//
// by Casey "Xavious" Johnson.
// Copyright(c) 2012 Casey Johnson. All Rights Reserved.
//=============================================================================

class LonghornClusterGrenadeAlt extends BallisticGrenade;

var	float					ZBonus;
var	int						ImpactCount; // Will automatically explode after this many impacts.
var	Emitter				Flare;
var	class<Emitter> 	FlareClass;
var	bool					bFlareKilled;

var protected const float		ArmingDelay;

simulated function PostNetBeginPlay()
{
	local PlayerController PC;
	
    Acceleration = Normal(Velocity) * AccelSpeed;
	
	if (Level.NetMode == NM_DedicatedServer)
		return;
		
	InitEffects();
	
	if ( Level.bDropDetail || Level.DetailMode == DM_Low )
	{
		bDynamicLight = false;
		LightType = LT_None;
	}
	else
	{
		PC = Level.GetLocalPlayerController();
		if ( (PC == None) || (Instigator == None) || (PC != Instigator.Controller) )
		{
			bDynamicLight = false;
			LightType = LT_None;
		}
	}
}

simulated function InitProjectile ()
{
	if (RandomSpin != 0 && !bNoInitialSpin)
		RandSpin(RandomSpin);
}

simulated function InitEffects ()
{
	local Vector X,Y,Z;

	bDynamicLight=default.bDynamicLight; // Set up some effects, team colored
	if (Level.NetMode != NM_DedicatedServer && TrailClass != None && Trail == None)
	{
		GetAxes(Rotation,X,Y,Z);
		Trail = Spawn(TrailClass, self,, Location + X*TrailOffset.X + Y*TrailOffset.Y + Z*TrailOffset.Z, Rotation);
		Flare = Spawn(FlareClass, self,, Location + X*TrailOffset.X + Y*TrailOffset.Y + Z*TrailOffset.Z, Rotation);
		if(Instigator != None && LonghornGrenadeTrailAlt(Trail) != None)
			LonghornGrenadeTrailAlt(Trail).SetupColor(Instigator.GetTeamNum());
		if (Trail != None)
		{
			if (Emitter(Trail) != None)
				class'BallisticEmitter'.static.ScaleEmitter(Emitter(Trail), DrawScale);
			Trail.SetBase (self);
		}
		if (Flare != None)
		{
			class'BallisticEmitter'.static.ScaleEmitter(Flare, DrawScale);
			Flare.SetBase (self);
		}
	}
}

simulated event HitWall(vector HitNormal, actor Wall)
{
    local Vector VNorm;

	//Longhorn alt detonates if it's close to full speed and it hits objects close to dead on
	if (VSize(Velocity) > default.Speed * 0.9 && -HitNormal Dot Normal(Velocity) > 0.9)
	{
		Explode(Location, HitNormal);
		return;
	}
	if (Pawn(Wall) != None)
	{
		DampenFactor *= 0.5;
		DampenFactorParallel *= 0.5;
	}

	bCanHitOwner=true;
	bHasImpacted=true;

    VNorm = (Velocity dot HitNormal) * HitNormal;
    Velocity = -VNorm * DampenFactor + (Velocity - VNorm) * DampenFactorParallel;

	if (RandomSpin != 0)
		RandSpin(100000);
	Speed = VSize(Velocity);

	if (Speed < 10)
	{
		bBounce = False;
		SetPhysics(PHYS_None);
		DestroyEffects();
		Destroy();
	}
	else if (Pawn(Wall) == None && (Level.NetMode != NM_DedicatedServer) && (Speed > 100) && (!Level.bDropDetail) && (Level.DetailMode != DM_Low) && EffectIsRelevant(Location,false))
	{
		if (ImpactSound != None)
			PlaySound(ImpactSound, SLOT_Misc );
		if (ImpactManager != None)
			ImpactManager.static.StartSpawn(Location, HitNormal, Wall.SurfaceType, Owner);
    }
}

// Hit something interesting
simulated function ProcessTouch (Actor Other, vector HitLocation)
{
	if (Other == None || (!bCanHitOwner && (Other == Instigator || Other == Owner)))
		return;
		
	if(Pawn(Other) != None)
        Velocity *= 0.8; // Clusters don't bounce as far off of players

	// Do damage for direct hits
	if (Role == ROLE_Authority && HitActor == None)		
	{
		HitActor = Other;
		if (default.LifeSpan - LifeSpan > ArmingDelay)
		{
			class'BallisticDamageType'.static.GenericHurt (Other, Damage, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), MyDamageType);
			Explode(HitLocation, vect(0,0,1));
		}
		else 
		{
			class'BallisticDamageType'.static.GenericHurt (Other, ImpactDamage, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), ImpactDamageType);
			Destroy();
		}
	}
}

// Destroy effects
simulated function DestroyEffects()
{
	if (Flare != None)
	{
		Flare.Kill();
		bFlareKilled=True;
	}
	if (Emitter(Trail) != None)
		Emitter(Trail).Kill();
}

simulated function Destroyed()
{
	if (Flare != None && !bFlareKilled)
		Flare.Destroy();
	if (Emitter(Trail) != None)
		Emitter(Trail).Kill();
	Super.Destroyed();
}

defaultproperties
{
     FlareClass=Class'BWBPRecolorsPro.LonghornClusterFlare'
     ArmingDelay=0.200000
     DetonateOn=DT_ImpactTimed
     PlayerImpactType=PIT_Detonate
     DampenFactor=0.120000
     DampenFactorParallel=0.250000
     bAlignToVelocity=True
     DetonateDelay=1.250000
     ImpactDamage=23
     ImpactDamageType=Class'BWBPRecolorsPro.DT_LonghornShotDirect'
     ImpactManager=Class'BWBPRecolorsPro.IM_LonghornCluster'
     TrailClass=Class'BWBPRecolorsPro.LonghornGrenadeTrailAlt'
     MyRadiusDamageType=Class'BWBPRecolorsPro.DT_LonghornShotRadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=512.000000
     MotionBlurRadius=384.000000
     MotionBlurFactor=3.000000
     MotionBlurTime=1.000000
     Speed=6500.000000
     MaxSpeed=6500.000000
     Damage=30.000000
     DamageRadius=256.000000
     MomentumTransfer=25000.000000
     MyDamageType=Class'BWBPRecolorsPro.DT_LonghornShotRadius'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=25
     LightSaturation=192
     LightBrightness=32.000000
     LightRadius=4.000000
     StaticMesh=StaticMesh'BallisticRecolors4StaticProExp.Longhorn.ClusterProj'
     bDynamicLight=True
     LifeSpan=20.000000
     DrawScale=0.500000
     RotationRate=(Roll=32768)
}
