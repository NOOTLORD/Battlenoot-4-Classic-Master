//=============================================================================
// Damage type class for the M763 clouds
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_M763Gas extends DT_BWMiscDamage;

defaultproperties
{
     bIgnoredOnLifts=True
     DamageIdent="Grenade"
     DamageDescription=",Gas,GearSafe,Hazard,"
     bDisplaceAim=False
     WeaponClass=Class'BallisticProV55.M763Shotgun'
     bArmorStops=False
     bLocationalHit=False
     bCausesBlood=False
     bDelayedDamage=True
     bNeverSevers=True
     GibPerterbation=0.500000
     KDamageImpulse=20000.000000
     VehicleDamageScaling=0.000000
}
