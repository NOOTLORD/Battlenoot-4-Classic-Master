//=============================================================================
// Damage type class for MGL Launcher grenade radius
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_MGLGrenadeRadius extends DT_BWExplode;

defaultproperties
{
     DamageIdent="Ordnance"
	 SimpleKillString="MGL"
     bDisplaceAim=False
     bUseMotionBlur=False	
     WeaponClass=Class'BallisticProV55Recolors.MGLLauncher'
     bDelayedDamage=True
     VehicleDamageScaling=1.500000
     InvasionDamageScaling=1.000000
}
