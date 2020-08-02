//=============================================================================
// Damage type for fire from a held FP7
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_FP7Held extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%k lurched onto %o in a ball of flames."
     DeathStrings(1)="%k killed %o with a self propelled inferno."
     FemaleSuicides(0)="%o successfully seared off her hands."
     FemaleSuicides(1)="%o erupted in a shower of flames."
     MaleSuicides(0)="%o successfully seared off his hands."
     MaleSuicides(1)="%o erupted in a shower of flames."
     DamageIdent="Grenade"
	 bDisplaceAim=False
     bUseMotionBlur=False
     WeaponClass=Class'BallisticProV55.FP7Grenade'
     DeathString="%k lurched onto %o in a ball of flames."
     FemaleSuicide="%o successfully seared off her hands."
     MaleSuicide="%o successfully seared off his hands."
     bSkeletize=True
     GibPerterbation=0.100000
     KDamageImpulse=200.000000 
     VehicleDamageScaling=1.500000
     InvasionDamageScaling=1.000000	 	 
}
