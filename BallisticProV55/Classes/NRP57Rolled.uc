//=============================================================================
// NRP57 Rolled projectile class
//
// Is no longer Karma-based due to desynch issues.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class NRP57Rolled extends NRP57Thrown;

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
     MyRadiusDamageType=Class'BallisticProV55.DTNRP57RolledRadius'
}
