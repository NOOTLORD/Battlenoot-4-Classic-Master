//=============================================================================
// Grenade class for MGL Grenade Launcher.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class MGLGrenadeTimed extends BallisticGrenade;


simulated event HitWall(vector HitNormal, actor Wall)
{
    local Vector VNorm;

	if (DetonateOn == DT_Impact)
	{
		Explode(Location, HitNormal);
		return;
	}
	else if (DetonateOn == DT_ImpactTimed && !bHasImpacted)
	{
		SetTimer(DetonateDelay, false);
	}
	if (Pawn(Wall) != None)
	{
		DampenFactor *= 0.2;
		DampenFactorParallel *= 0.2;
	}

	bCanHitOwner=true;
	bHasImpacted=true;

    VNorm = (Velocity dot HitNormal) * HitNormal;
    Velocity = -VNorm * DampenFactor + (Velocity - VNorm) * DampenFactorParallel;

	if (RandomSpin != 0)
		RandSpin(100000);
	
	Speed = VSize(Velocity/2);

	if (Speed < 20)
	{
		bBounce = False;
		SetPhysics(PHYS_None);
		if (Trail != None && !TrailWhenStill)
		{
			DestroyEffects();
		}
	}
	else if (Pawn(Wall) == None && (Level.NetMode != NM_DedicatedServer) && (Speed > 100) && (!Level.bDropDetail) && (Level.DetailMode != DM_Low) && EffectIsRelevant(Location,false))
	{
		if (ImpactSound != None)
			PlaySound(ImpactSound, SLOT_Misc, 1.5);
		if (ImpactManager != None)
			ImpactManager.static.StartSpawn(Location, HitNormal, Wall.SurfaceType, Owner);
    	}
}

defaultproperties
{
     PlayerImpactType=PIT_Detonate
     bNoInitialSpin=True
     bAlignToVelocity=True
     DetonateDelay=2.500000
     ImpactDamage=80
     ImpactDamageType=Class'BWBPRecolorsPro.DT_MGLGrenade'
     ImpactManager=Class'BWBPRecolorsPro.IM_MGLGrenade'
     TrailClass=Class'BWBPRecolorsPro.MGLNadeTrail'
     MyRadiusDamageType=Class'BWBPRecolorsPro.DT_MGLGrenadeRadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=512.000000
     MotionBlurRadius=400.000000
     MotionBlurFactor=0.000000
     MotionBlurTime=0.000000
     ShakeRotTime=0.000000
     ShakeOffsetTime=0.000000
     bCoverPenetrator=False	 
     Speed=1750.000000
     Damage=145.000000
     DamageRadius=300.000000
     MyDamageType=Class'BWBPRecolorsPro.DT_MGLGrenadeRadius'
     ImpactSound=Sound'BallisticRecolorsSounds.MGL.FLAK-GrenadeBounce'
     StaticMesh=StaticMesh'BallisticHardware2.M900.M900Grenade'
}
