//=============================================================================
// Damage type class for the NRP57 Grenade
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_NRP57Grenade extends DT_BWBlunt;

defaultproperties
{
     BloodManagerName="BallisticProV55.BloodMan_BluntSmall"
     DamageIdent="Grenade"
     bDisplaceAim=False	 
     DamageDescription=",Blunt,Hazard,"
     WeaponClass=Class'BallisticProV55.NRP57Grenade'
     bDelayedDamage=True
     GibPerterbation=0.500000
     KDamageImpulse=20000.000000
     VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000	 
}
