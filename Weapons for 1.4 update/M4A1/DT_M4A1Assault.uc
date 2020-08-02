//=============================================================================
// Damage type class for the M4A1 Carbine
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_M4A1Assault extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k shot through %o with the M4A1."
     DeathStrings(1)="%o was fatally preforated by %k's M4A1."
     DeathStrings(2)="%k removed %o's spine with M4A1 rounds."
     DamageIdent="Assault"
     bDisplaceAim=False
     bUseMotionBlur=False
     WeaponClass=Class'BWBPRecolorsPro.M4A1Carbine'
     DeathString="%k's M4A1 confirmed a kill on %o."
     FemaleSuicide="%o took the easy way out with an M4A1."
     MaleSuicide="%o took the easy way out with an M4A1."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000	 
}
