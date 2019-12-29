//=============================================================================
// DTSKASShotgun.
//
// Damage type for SKAS Automatic Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Edited by (NL)NOOTLORD 
//=============================================================================
class DTSKASShotgun extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%k tore apart %o with a 10-gauge SKAS hailstorm."
     DeathStrings(1)="%k's SKAS-21 turned %o into a hunk of leaky meat."
     DeathStrings(2)="%o was reduced to bloody ribbons by %k's SKAS-21."
     DeathStrings(3)="%o was swept off the floor by %k's SKAS-21."
     DeathStrings(4)="%k's SKAS-21 removed bones, organs, and more from %o."
     DamageIdent="Shotgun"
     AimDisplacementDamageThreshold=0.000000
     AimDisplacementDuration=0.000000
     bUseMotionBlur=False		 
     WeaponClass=Class'BWBPRecolorsPro.SKASShotgun'
     DeathString="%k tore apart %o with a 10-gauge SKAS hailstorm."
     FemaleSuicide="%o got her SKAS bullets reflected by an admin."
     MaleSuicide="%o got his SKAS bullets reflected. Friendly fire?"
     GibPerterbation=0.400000
     KDamageImpulse=15000.000000
	 VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000	 
}
