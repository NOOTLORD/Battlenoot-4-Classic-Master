//=============================================================================
// Damage type class for FMP MachinePistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_FMPMachinePistol extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k embraced Schadenfreude as %kh FMP destroyed %o."
     DeathStrings(1)="%o lost the war to %k's FMP-2012."
     DeathStrings(2)="%k enacted blitzkrieg on %o with %kh FMP-2012."
     DeathStrings(3)="%o was removed from the gene pool by %k's FMP."
     DeathStrings(4)="%k's FMP-2012 executed the untermensch %o."
     DamageIdent="SMG"	
     bDisplaceAim=False
     bUseMotionBlur=False	 
     WeaponClass=Class'BWBPRecolorsPro.FMPMachinePistol'
     DeathString="%k embraced Schadenfreude as %kh FMP destroyed %o."
     FemaleSuicide="%o did her fuhrer impression."
     MaleSuicide="%o did his fuhrer impression."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
	 VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000
}
