//=============================================================================
// Damage type class for the XMK-5 SMG
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_XMK5Body extends DT_BWBullet;

defaultproperties
{
     DamageIdent="SMG"
     bDisplaceAim=False
     WeaponClass=Class'BallisticProV55.XMK5SMG'
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000
}
