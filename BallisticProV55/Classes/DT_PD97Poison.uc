//=============================================================================
// Damage type class for PD97 dart poisoning
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_PD97Poison extends DT_BWMiscDamage;

defaultproperties
{
     SimpleKillString="PD97 Poison"
     DamageIdent="Sidearm"
     bDisplaceAim=False	 
     DamageDescription=",Poison,GearSafe,NonSniper,"
     WeaponClass=Class'BallisticProV55.PD97Pistol'
     bArmorStops=False
     bLocationalHit=False
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000
}
