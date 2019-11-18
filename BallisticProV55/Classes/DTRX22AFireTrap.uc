//=============================================================================
// DTRX22AFireTrap.
//
// Damage type for RX22A surface fires
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTRX22AFireTrap extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%o swam in %k's fire."
     DeathStrings(1)="%k's lurking fire found a victim in %o."
     DeathStrings(2)="%o foolishly stumbled into %k's raging inferno."
     DeathStrings(3)="%k left a fiery surprise for %o to find."
     BloodManagerName="BallisticProV55.BloodMan_FireExploded"
     bIgnoredOnLifts=True
     DamageIdent="Streak"
     bOnlySeverLimbs=True
     WeaponClass=Class'BallisticProV55.RX22AFlamer'
     DeathString="%o swam in %k's fire."
     FemaleSuicide="%o ran into a fire."
     MaleSuicide="%o ran into a fire."
     bDelayedDamage=True
     KDamageImpulse=2000.000000
}
