//=============================================================================
// Damage type class for XMK-5 SMG headshots
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_XMK5Head extends DT_BWBulletHead;

defaultproperties
{
     DamageIdent="SMG"
     bDisplaceAim=False
     WeaponClass=Class'BallisticProV55.XMK5SMG'
     bFastInstantHit=True
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000
}
