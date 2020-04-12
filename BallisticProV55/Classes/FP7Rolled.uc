//=============================================================================
// FP7 Rolled projectile class
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
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
     DetonateDelay=3.000000
     ImpactDamage=15	 
     DampenFactor=0.400000
     DampenFactorParallel=1.000000
     MyRadiusDamageType=Class'BallisticProV55.DT_NRP57GrenadeRadius'
}
