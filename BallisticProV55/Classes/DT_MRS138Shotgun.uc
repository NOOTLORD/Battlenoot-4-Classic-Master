//=============================================================================
// Damage type class for MRS-138 Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_MRS138Shotgun extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%k fired a tenner into %o with the MRS-138."
     DeathStrings(1)="%o absorbed the random shots of %k's combat shotgun."
     DeathStrings(2)="%k blasted %o down as %ve tried to scamper away in fear."
     DeathStrings(3)="%o was disassembled by %k's MRS-138 barrage."
     DamageIdent="Shotgun"
     bDisplaceAim=False
     bUseMotionBlur=False	 
     WeaponClass=Class'BallisticProV55.MRS138Shotgun'
     DeathString="%k fired a tenner into %o with the MRS-138."
     FemaleSuicide="%o fired a tenner into herself with the MRS-138."
     MaleSuicide="%o fired a tenner into himself with the MRS-138."
     bExtraMomentumZ=True
     GibPerterbation=0.400000
     KDamageImpulse=25000.000000
     VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000	 
}
