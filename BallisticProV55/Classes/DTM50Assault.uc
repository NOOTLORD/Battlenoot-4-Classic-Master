//=============================================================================
// DTM50Assault.
//
// DamageType for the M50 assault rifle primary fire
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DTM50Assault extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k eliminated %o with the M50."
     DeathStrings(1)="%o was drilled by %k's M50."
     DeathStrings(2)="%k purified %o with M50 rounds."
     DamageIdent="Assault"
     AimDisplacementDamageThreshold=0.000000
     AimDisplacementDuration=0.000000
     bUseMotionBlur=False
     WeaponClass=Class'BallisticProV55.M50AssaultRifle'
     DeathString="%k eliminated %o with the M50."
     FemaleSuicide="%o nailed herself with the M50."
     MaleSuicide="%o nailed himself with the M50."
     bFastInstantHit=True
     FlashScale=0.300000
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000	 
}
