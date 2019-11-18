//=============================================================================
// DTRX22AImmolation.
//
// Damage type for players caught alight by the RX22A Flamer
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_CX61Immolation extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%o was immolated by %k."
     DeathStrings(1)="%k's incineration finally overcame %o."
     DeathStrings(2)="%o ran around sizzling and popping as %k set %vm alight."
     DeathStrings(3)="%k coated %o with flaming gas."
     SimpleKillString="CX61 Flamethrower"
     DamageIdent="Assault"
     WeaponClass=Class'BWBPOtherPackPro.CX61AssaultRifle'
     DeathString="%o was immolated %k."
     FemaleSuicide="%o immolated herself."
     MaleSuicide="%o immolated himself."
     bSkeletize=True
     bDelayedDamage=True
     GibPerterbation=0.100000
     KDamageImpulse=200.000000
     VehicleDamageScaling=0.500000
}
