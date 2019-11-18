//=============================================================================
// Launched AK-47 knife.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AK47Knife extends BallisticProjectile;

var   bool			bStuckInWall;
var   bool			bHitPlayer;

simulated function ProcessTouch (Actor Other, vector HitLocation)
{
	if (Other == None)
		return;

	else if (Other == Instigator || Other == Owner)
		return;
	if (bStuckInWall || bHitPlayer)
		return;

	if (Role == ROLE_Authority)
		DoDamage(Other, HitLocation);
	bHitPlayer = true;
	SetPhysics(PHYS_Falling);
	SetLocation(HitLocation);
	Velocity = Normal(HitLocation-Other.Location)*100;
}

simulated event Landed( vector HitNormal )
{
	HitWall( HitNormal, None );
}

simulated singular function HitWall(vector HitNormal, actor Wall)
{
	local int Surf;
	if (bStuckInWall)
		return;
	if (Wall != None && !Wall.bWorldGeometry && !Wall.bStatic)
	{
		if (Role == ROLE_Authority && !bHitPlayer)
			DoDamage(Wall, Location);
		if (Mover(Wall) == None)
		{
			bHitPlayer = true;
			Velocity = HitNormal*100;
			return;
		}
	}
	SetRotation(Rotator(Velocity)/*+rot(32768,0,0)*/);
	OnlyAffectPawns(true);
	SetCollisionSize(40, 40);
	SetPhysics(PHYS_None);
	bFixedRotationDir=false;
	bStuckInWall=true;
	bHardAttach=true;
	CheckSurface(Location, HitNormal, Surf, Wall);
	LifeSpan=20.0;
	if (Wall != None)
		SetBase(Wall);
	if (Level.NetMode != NM_DedicatedServer && ImpactManager != None && /*(!Level.bDropDetail) && (Level.DetailMode != DM_Low) && */EffectIsRelevant(Location,false))
		ImpactManager.static.StartSpawn(Location, HitNormal, Surf, self);
}

defaultproperties
{
     ImpactManager=Class'BallisticProV55.IM_KnifeThrown'
     bRandomStartRotaion=False
     bUsePositionalDamage=True
	 bIgnoreTerminalVelocity=True							  
     DamageHead=80.000000
     DamageLimb=40.000000
     DamageTypeHead=Class'BWBPRecolorsPro.DTX8KnifeRifleLaunchedHead'
     ShakeRadius=0.000000
     bWarnEnemy=False
     MotionBlurRadius=0.000000
     MotionBlurFactor=0.000000
     MotionBlurTime=0.000000
     ShakeRotTime=0.000000
     ShakeOffsetTime=0.000000
     Speed=8500.000000
     MaxSpeed=8500.000000
     Damage=90.000000
     MyDamageType=Class'BWBPRecolorsPro.DTX8KnifeRifleLaunched'
     StaticMesh=StaticMesh'BallisticRecolors4StaticPro.X8.X8Proj'
     Physics=PHYS_Falling
     LifeSpan=0.000000
     DrawScale=0.150000
     bUnlit=False
     bSelected=True
}
