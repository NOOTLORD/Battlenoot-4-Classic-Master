//=============================================================================
// Damage type class for MGL Grenade Launcher grenade radius
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_MGLGrenadeRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o lost a few limbs to %k's MGL grenade."
     DeathStrings(1)="%k's MGL grenade turned %o into chunky red ash."
     DeathStrings(2)="%o found %k's MGL grenade."
     SimpleKillString="Conqueror Grenade"
     DamageIdent="Ordnance"
     bDisplaceAim=False
     bUseMotionBlur=False	
     WeaponClass=Class'BWBPRecolorsPro.MGLauncher'
     DeathString="%o lost a few teeth to %k's M900 grenade."
     FemaleSuicide="%o found one of her M900 grenades."
     MaleSuicide="%o found one of his M900 grenades."
     bDelayedDamage=True
     VehicleDamageScaling=1.500000
     InvasionDamageScaling=1.000000
}
