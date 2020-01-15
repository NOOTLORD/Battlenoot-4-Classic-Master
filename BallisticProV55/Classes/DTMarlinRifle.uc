//=============================================================================
// DTMarlinRifle.
//
// Damage type for the Deermaster Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DTMarlinRifle extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o was hounded by %k's Redwood 6000."
     DeathStrings(1)="%k hunted %o down like a dog."
     DeathStrings(2)="%o got caught in %k's DeerMaster sights."
     DeathStrings(3)="%k's DeerMaster rifle drove %o to extinction."
     DeathStrings(4)="%o got busted like a beaver by %k's Redwood 6000."
     DeathStrings(5)="%k drilled %o like a moose."
     DeathStrings(6)="%k shot %o like a little deer."
     bSnipingDamage=True
     DamageIdent="Sniper"
     AimDisplacementDamageThreshold=0.000000
     AimDisplacementDuration=0.000000
     bUseMotionBlur=False
     WeaponClass=Class'BallisticProV55.MarlinRifle'
     DeathString="%o was hounded by %k's Marlin Rifle."
     FemaleSuicide="%o hunted herself to extinction."
     MaleSuicide="%o hunted himself to extinction."
     FlashScale=0.300000
     VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000
}
