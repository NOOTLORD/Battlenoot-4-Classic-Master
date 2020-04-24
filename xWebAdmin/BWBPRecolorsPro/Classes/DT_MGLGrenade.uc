//=============================================================================
// Damage type class for MGL Grenade Launcher grenade 
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_MGLGrenade extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o took %k's MGL grenade in the gut."
     DeathStrings(1)="%o played with %k's live MGL grenade."
     SimpleKillString="Conqueror Grenade"
     DamageIdent="Ordnance"
     bDisplaceAim=False
     bUseMotionBlur=False	
     WeaponClass=Class'BWBPRecolorsPro.MGLauncher'
     DeathString="%o was tagged by %k's M900 grenade."
     FemaleSuicide="%o tagged herself with her own grenade."
     MaleSuicide="%o tagged himself with his own grenade."
     bDelayedDamage=True
     VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000	 	 
}
