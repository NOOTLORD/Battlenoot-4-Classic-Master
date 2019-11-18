//=============================================================================
// FP7Rolled.
//
// Rolled underhand FP7
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FP7Rolled extends FP7Thrown;

simulated event PostBeginPlay ()
{
	local Rotator R;

	Super.PostBeginPlay();

	R = Rotation;
	R.Roll = 16384;
	SetRotation(R);
}

defaultproperties
{
     FireModeNum=1
     DampenFactor=0.400000
     DampenFactorParallel=1.000000
     MyRadiusDamageType=Class'BallisticProV55.DTNRP57GrenadeRadius'
     MotionBlurFactor=4.000000
     MotionBlurTime=5.000000
     ShakeRotTime=6.000000
     ShakeOffsetTime=6.000000
     CollisionRadius=0.000000
     CollisionHeight=0.000000
     bUseCylinderCollision=False
     bBlockKarma=False
}
