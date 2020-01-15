//=============================================================================
// DTNRP57GrenadeRadius.
//
// Damage type for the NRP57 Grenade radius damage
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DTNRP57GrenadeRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o discovered one of %k's lurking pineapples."
     DeathStrings(1)="%k's pineapple crawled it's way into %o's path."
     DeathStrings(2)="%o couldn't get enough of %k's pineapple delight."
     DamageIdent="Grenade"
     AimDisplacementDamageThreshold=0.000000
     AimDisplacementDuration=0.000000
     bUseMotionBlur=False	 
     WeaponClass=Class'BallisticProV55.NRP57Grenade'
     DeathString="%o discovered one of %k's lurking pineapples."
     FemaleSuicide="%o blew herself apart with a pineapple."
     MaleSuicide="%o blew himself apart with a pineapple."
     bDelayedDamage=True
     VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000
}
