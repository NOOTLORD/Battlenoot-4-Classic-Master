//=============================================================================
// Damage type class for M763 Shotgun headshot
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_M763Shotgun extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%k blasted a pound of lead into %o with the M763 Avenger."
     DeathStrings(1)="%k's Avenger punctured %o with pellets."
     DeathStrings(2)="%o was blown across the map by %k's M763."
     DeathStrings(3)="%k's 12-gauge M763 flurry cast %o to the wind."
     DamageIdent="Shotgun"
     bDisplaceAim=False
     bUseMotionBlur=False	 
     WeaponClass=Class'BallisticProV55.M763Shotgun'
     DeathString="%k blasted a pound of lead into %o with the M763."
     FemaleSuicide="%o nailed herself with the M763."
     MaleSuicide="%o nailed himself with the M763."
     bExtraMomentumZ=True
     GibPerterbation=0.400000
     KDamageImpulse=25000.000000
     VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000
}
