//=============================================================================
// Damage type class for the MP40 MachinePistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_MP40 extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k embraced Schadenfreude as %kh MP40 destroyed %o."
     DeathStrings(1)="%o lost the war to %k's MP40."
     DeathStrings(2)="%k enacted blitzkrieg on %o with %kh MP40."
     DeathStrings(3)="%o was removed from the gene pool by %k's MP40."
     DeathStrings(4)="%k's MP40 executed the untermensch %o."
     DamageIdent="SMG"	
     bDisplaceAim=False
     bUseMotionBlur=False	 
     WeaponClass=Class'BWBPRecolorsPro.MP40MachinePistol'
     DeathString="%k embraced Schadenfreude as %kh MP40 destroyed %o."
     FemaleSuicide="%o did her fuhrer impression."
     MaleSuicide="%o did his fuhrer impression."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
	 VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000
}
