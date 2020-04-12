//=============================================================================
// Damage type class for M50 Assault Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_M50Assault extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k eliminated %o with the M50."
     DeathStrings(1)="%o was drilled by %k's M50."
     DeathStrings(2)="%k purified %o with M50 rounds."
     DamageIdent="Assault"
     bDisplaceAim=False
     bUseMotionBlur=False
     WeaponClass=Class'BallisticProV55.M50AssaultRifle'
     DeathString="%k eliminated %o with the M50."
     FemaleSuicide="%o nailed herself with the M50."
     MaleSuicide="%o nailed himself with the M50."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000	 
}
