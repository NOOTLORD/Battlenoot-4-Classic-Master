//=============================================================================
// PD97Dart.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================

class PD97Dart extends BallisticProjectile;

var Actor StuckActor;
var bool bPlaced;

var PD97Bloodhound Master;

simulated event ProcessTouch(Actor Other, vector HitLocation )
{
	if (Other == Instigator && (!bCanHitOwner))
		return;
	if (Base != None)
		return;

	if(Pawn(Other) != None)
	{
		StuckActor = Other;
		HitActor = Other;
		Explode(HitLocation, Normal(HitLocation-Other.Location));
		class'BallisticDamageType'.static.GenericHurt(Other, Damage, Instigator, HitLocation, Velocity, MyDamageType);
	}
	else
		Super.ProcessTouch(Other,HitLocation);
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local PD97DartControl DC;
	
	if(bPlaced)
		return;

	bPlaced = true;
    if (ImpactManager != None)
	{
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Level.GetLocalPlayerController());
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Instigator);
	}

	if(Role < ROLE_Authority || Pawn(StuckActor) == None || Master == None)
	{
		Destroy();
		Return;
	}
		
	//Check for an existing dart control
	foreach StuckActor.BasedActors(class'PD97DartControl', DC)
	{
		if (DC.Instigator == Instigator && !DC.bTearOff)
		{
			DC.AddDart();
			Destroy();
			return;
		}
	}
	
	if (Level.TimeSeconds - Pawn(StuckActor).SpawnTime < DeathMatch(Level.Game).SpawnProtectionTime)
	    return;

	if (Pawn(StuckActor).Controller != None && Instigator.Controller != None && Pawn(StuckActor).Controller.SameTeamAs(Instigator.Controller))
		DC = Spawn (class'PD97HealControl',StuckActor,, StuckActor.Location,StuckActor.Rotation);
	else DC = Spawn (class'PD97DartControl',StuckActor,, StuckActor.Location,StuckActor.Rotation);
	DC.Initialize(Pawn(StuckActor), Master);
	if (Instigator.Controller != None)
		DC.InstigatorController = Instigator.Controller;
	Master.AddControl(DC);

	Destroy();
}

defaultproperties
{
     ImpactManager=Class'BallisticProV55.IM_XMK5Dart'
     TrailClass=Class'BallisticProV55.PineappleTrail'
     MyRadiusDamageType=Class'BWBPOtherPackPro.DTPD97Dart'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=0.000000
     MotionBlurRadius=0.000000
     MotionBlurFactor=0.000000
     MotionBlurTime=0.000000
     ShakeRotTime=0.000000
     ShakeOffsetTime=0.000000
     Speed=15000.000000
     Damage=3.000000
     MyDamageType=Class'BWBPOtherPackPro.DTPD97Dart'
     StaticMesh=StaticMesh'BallisticHardware_25.OA-SMG.OA-SMG_Dart'
     LifeSpan=2.500000
     bIgnoreTerminalVelocity=True
}
