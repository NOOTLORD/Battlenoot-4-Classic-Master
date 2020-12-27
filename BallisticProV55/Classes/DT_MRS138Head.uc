//=============================================================================
// Damage type class for MRS-138 Shotgun headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_MRS138Head extends DT_BWBulletHead;

defaultproperties
{
     DamageIdent="Shotgun"
     bDisplaceAim=False	
     WeaponClass=Class'BallisticProV55.MRS138Shotgun'
     bExtraMomentumZ=True
     GibPerterbation=0.400000
     KDamageImpulse=10000.000000
     VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000	 
}
