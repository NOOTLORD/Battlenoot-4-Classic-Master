//=============================================================================
// Damage type class for the rolled NRP57 Grenade radius
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_NRP57RolledRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k rolled a pineapple into %o's town."
     DeathStrings(1)="%o tripped on %k's patroling pineapple."
     DamageIdent="Grenade"
     bDisplaceAim=False
     bUseMotionBlur=False		 
     WeaponClass=Class'BallisticProV55.NRP57Grenade'
     DeathString="%k rolled a pineapple into %o's town."
     FemaleSuicide="%o blew herself apart with a pineapple."
     MaleSuicide="%o blew himself apart with a pineapple."
     bDelayedDamage=True
     VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000	 
}
