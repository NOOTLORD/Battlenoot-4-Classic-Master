//=============================================================================
// Damage type class for XRS-10 SMG headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_XRS10Head extends DT_BWBulletHead;

defaultproperties
{
     DamageIdent="SMG"
     bDisplaceAim=False 
     WeaponClass=Class'BallisticProV55.XRS10SMG'
     bFastInstantHit=True
     VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000
}
