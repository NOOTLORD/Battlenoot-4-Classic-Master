//=============================================================================
// Damage type class for the held NRP57
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_NRP57Held extends DT_BWExplode;

defaultproperties
{
     DamageIdent="Grenade"
     bDisplaceAim=False	 
     bNoSeverStumps=True
     WeaponClass=Class'BallisticProV55.NRP57Grenade'
     GibModifier=0.500000
     GibPerterbation=0.900000
     VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000
}
