//=============================================================================
// A500AltProjectile.
//
// Blob fired by A500.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class A500AltProjectile extends BallisticGrenade;

var int AcidLoad;

const ACIDMAX = 4.0f;

simulated event ProcessTouch( actor Other, vector HitLocation )
{
	if (Other == Instigator && (!bCanHitOwner))
		return;
	if (Other == HitActor)
		return;
	if (Base != None)
		return;
		
	if ( Instigator == None || Instigator.Controller == None )
		Other.SetDelayedDamageInstigatorController( InstigatorController );

	class'BallisticDamageType'.static.GenericHurt (Other, ImpactDamage * (AcidLoad / ACIDMAX) * (1 + 0.35 * FMin(default.LifeSpan - LifeSpan, 0.5)), Instigator, HitLocation, MomentumTransfer * Normal(Velocity), ImpactDamageType);
	ReduceHP(Other);
	HitActor = Other;
	Explode(HitLocation, Normal(HitLocation-Other.Location));
}

function ReduceHP (Actor Other)
{
	local A500HPReducer hpReducer;
	
	if (Pawn(other) != None && Pawn(Other).Health > 0 && Vehicle(Other) == None)
	{
		hpReducer= A500HPReducer(Pawn(Other).FindInventoryType(class'A500HPReducer'));
	
		if (hpReducer == None)
		{
			Pawn(Other).CreateInventory("BallisticProV55.A500HPReducer");
			hpReducer = A500HPReducer(Pawn(Other).FindInventoryType(class'A500HPReducer'));
		}
	
		hpReducer.AddStack(12 * (AcidLoad / ACIDMAX));
	}
}
simulated function BlowUp(vector HitLocation)
{
	local vector Start;

	Start = Location/* + 10 * HitNormal*/;
	TargetedHurtRadius(Damage * (AcidLoad/ACIDMAX), DamageRadius, MyRadiusDamageType, MomentumTransfer, HitLocation, HitActor);
	if ( Role == ROLE_Authority )
		MakeNoise(1.0);
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local A500AcidControl F;
	local Teleporter TB;

	Super.Explode(HitLocation,HitNormal);

	if(Role == ROLE_Authority)
	{
		//No teleporter camping, die die die
		foreach RadiusActors(class'Teleporter', TB, 256)
		{
			if (Instigator != None)
				Level.Game.Broadcast(self, "A500 Acid Bomb fired by"@Instigator.PlayerReplicationInfo.PlayerName@"too close to a teleporter!");
			return;
		}
		F = Spawn(class'A500AcidControl',self,,HitLocation+HitNormal*4, rot(0,0,0));
		if (F!=None)
		{
			F.Instigator = Instigator;
			F.Initialize(HitNormal, AcidLoad);
		}
	}

	Destroy();
}

function AdjustSpeed()
{
	Velocity = Vector(Rotation) * ((default.Speed * 0.25) + (default.Speed * 0.75 * (float(AcidLoad) / ACIDMAX)));
}

defaultproperties
{
     DetonateOn=DT_Impact
     PlayerImpactType=PIT_Detonate
     bNoInitialSpin=True
     bAlignToVelocity=True
     DetonateDelay=1.000000
     ImpactDamage=135
     ImpactDamageType=Class'BallisticProV55.DTA500Impact'
     ImpactManager=Class'BallisticProV55.IM_A500AcidExplode'
     TrailClass=Class'BallisticProV55.A500AltProjectileTrail'
     TrailOffset=(X=-8.000000)
     MyRadiusDamageType=Class'BallisticProV55.DTA500Splash'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=0.000000
     MotionBlurRadius=384.000000
     MotionBlurFactor=3.000000
     MotionBlurTime=4.000000
     Speed=6000.000000
     MaxSpeed=6000.000000
     Damage=75.000000
     DamageRadius=256.000000
     MomentumTransfer=7500.000000
     MyDamageType=Class'BallisticProV55.DTA500Splash'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=54
     LightSaturation=100
     LightBrightness=150.000000
     LightRadius=8.000000
     bDynamicLight=True
     DrawScale=1.000000
}
