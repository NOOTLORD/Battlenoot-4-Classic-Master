//=============================================================================
// Damage type class for XK2 SMG headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_XK2Head extends DT_BWBulletHead;

defaultproperties
{
     DamageIdent="SMG"
     bDisplaceAim=False
     WeaponClass=Class'BallisticProV55.XK2SMG'
     bFastInstantHit=True
     VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000
}