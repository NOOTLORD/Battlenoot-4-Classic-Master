//=============================================================================
// DTRX22ACloudBomb.
//
// Damage type for RX22A gas cloud explosion
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTRX22ACloudBomb extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%k bombed %o with fire."
     DeathStrings(1)="%o got caught up in %k's firestorm."
     DeathStrings(2)="%k's firebomb charred %o into ash."
     DamageIdent="Streak"
     WeaponClass=Class'BallisticProV55.RX22AFlamer'
     DeathString="%k bombed %o with fire."
     FemaleSuicide="%o bombed herself."
     MaleSuicide="%o bombed himself."
     bDelayedDamage=True
     KDamageImpulse=2000.000000
     VehicleDamageScaling=0.800000
}
