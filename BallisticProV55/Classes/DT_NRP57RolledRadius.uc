//=============================================================================
// Damage type class for the rolled NRP57 Grenade radius
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_NRP57RolledRadius extends DT_BWExplode;

defaultproperties
{
     DamageIdent="Grenade"
     bDisplaceAim=False	 
     WeaponClass=Class'BallisticProV55.NRP57Grenade'
     bDelayedDamage=True
     VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000	 
}
