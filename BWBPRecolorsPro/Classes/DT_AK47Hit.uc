//=============================================================================
// DT_AK47Hit.
//
// Damagetype for AK47 Melee attack
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_AK47Hit extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k RAGED LIKE BEAR and beat %o's face in with an AK!"
     DeathStrings(1)="%k beat %o with %kh Wooden Stock of Killing."
     DeathStrings(2)="%o was killed by a raving %k's AK-490 stock."
     DamageIdent="Melee"
     AimDisplacementDamageThreshold=0
     AimDisplacementDuration=0.000000
     WeaponClass=Class'BWBPRecolorsPro.AK47AssaultRifle'
     DeathString="%k RAGED LIKE BEAR and beat %o's face in with an AK!"
     FemaleSuicide="%o beat herself to death with the AK47."
     MaleSuicide="%o beat himself to death with the AK47."
}
