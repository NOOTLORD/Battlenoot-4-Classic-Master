//=============================================================================
// DTM4Assault.
//
// DamageType for the MJ51 assault rifle primary fire
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_M4Assault extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k shot through %o with the M4."
     DeathStrings(1)="%o was fatally preforated by %k's M4."
     DeathStrings(2)="%k removed %o's spine with M4 rounds."
     DamageIdent="Assault"
     bDisplaceAim=False
     bUseMotionBlur=False
     WeaponClass=Class'BWBPRecolorsPro.M4Carbine'
     DeathString="%k's M4 confirmed a kill on %o."
     FemaleSuicide="%o took the easy way out with an M4."
     MaleSuicide="%o took the easy way out with an M4."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
	 VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000	 
}
