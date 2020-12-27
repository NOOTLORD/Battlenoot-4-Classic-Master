//=============================================================================
// Damage type class for G5 Bazooka mortar rockets
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_G5Mortar extends DT_BWExplode;

defaultproperties
{
     DamageIdent="Ordnance"
     bDisplaceAim=False	 
     WeaponClass=Class'BallisticProV55.G5Bazooka'
     bDelayedDamage=True
     GibPerterbation=0.800000
     VehicleDamageScaling=1.500000
     InvasionDamageScaling=1.000000
}
