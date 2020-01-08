//=============================================================================
// DTFP7Immolation.
//
// Damage type for players caught alight by the FP7
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DTFP7Immolation extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%o was set ablaze by %k's FP7."
     DeathStrings(1)="%o ran around in a ball of %k's flames."
     DeathStrings(2)="%o was immolated by %k's FP7."
     DeathStrings(3)="%o couldn't get to a fire extinguisher before %k's fire finished %vm off."
     DeathStrings(4)="%o ran screaming for the water, but was overcome by %k's flames."
     FemaleSuicides(0)="%o ran around like a maniac in a ball of fire."
     FemaleSuicides(1)="%o did her flaming scarecrow impression."
     MaleSuicides(0)="%o ran around like a maniac in a ball of fire."
     MaleSuicides(1)="%o did his flaming scarecrow impression."
     bIgnoredOnLifts=True
     DamageIdent="Grenade"
     AimDisplacementDamageThreshold=0.000000
     AimDisplacementDuration=0.000000
     bUseMotionBlur=False	 
     WeaponClass=Class'BallisticProV55.FP7Grenade'
     DeathString="%o was set a blaze by %k's FP7."
     FemaleSuicide="%o ran around like a maniac in a ball of fire."
     MaleSuicide="%o ran around like a maniac in a ball of fire."
     bSkeletize=True
     bDelayedDamage=True
     GibPerterbation=0.100000
     KDamageImpulse=200.000000
     VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000	 
}
