//=============================================================================
// Damage type class for AH208 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_AH208Pistol extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k took %o out with %kh .44 handcannon."
     DeathStrings(1)="%k's AH208 blasted out %o's spine."
     DeathStrings(2)="%o got on the wrong side of %k's AH208."
     DeathStrings(3)="%o got in the way of %k's rampaging AH208."
     DamageIdent="Pistol"
     bDisplaceAim=False
     bUseMotionBlur=False
     WeaponClass=Class'BWBPRecolorsPro.AH208Pistol'
     DeathString="%k took %o out with his .44 handcannon."
     FemaleSuicide="%o pointed her AH208 backwards."
     MaleSuicide="%o pointed his AH208 backwards."
	 VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000
}
