//=============================================================================
// DTM46Assault.
//
// DamageType for the M46 assault rifle primary fire
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyrightę 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DTM46AssaultQS extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o was brutally gunned down by %k's M46 battle rifle."
     DeathStrings(1)="%o was savaged by %k's Jackal."
     DeathStrings(2)="%o got shredded by %k's M46 Jackal."
     DeathStrings(3)="%k pumped lead into %o with %kh M46."
     DamageIdent="Assault"
     AimDisplacementDamageThreshold=0.000000
     AimDisplacementDuration=0.000000
     bUseMotionBlur=False
     WeaponClass=Class'BallisticProV55.M46AssaultRifleQS'
     DeathString="%o was brutally gunned down by %k's rabid M46 assault rifle."
     FemaleSuicide="%o's Jackal tore her to shreds."
     MaleSuicide="%o's Jackal tore him to shreds."
     bFastInstantHit=True
     FlashScale=0.300000
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000
	 
}
