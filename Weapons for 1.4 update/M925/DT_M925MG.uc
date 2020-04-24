//=============================================================================
// Damage type class for M925 Machinegun 
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_M925MG extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k made a holy man of %o with M925 rounds."
     DeathStrings(1)="%k blessed %o with M925 rounds."
     DeathStrings(2)="%k blasted %o into a corner with %kh M925."
     DeathStrings(3)="%k's M925 judged %o unworthy."
     DeathStrings(4)="%o was crucified by %k's .50 machinegun."
     DamageIdent="Machinegun"
     bDisplaceAim=False
     bUseMotionBlur=False
     WeaponClass=Class'BallisticProV55.M925Machinegun'
     DeathString="%k made a holy man of %o with M925 rounds."
     FemaleSuicide="%o caught her face in the belt feed of her M925."
     MaleSuicide="%o caught his face in the belt feed of his M925."
     bFastInstantHit=True
     VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000	 
}
