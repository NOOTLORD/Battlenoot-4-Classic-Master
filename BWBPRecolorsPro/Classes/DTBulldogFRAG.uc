//=============================================================================
// DTBulldogFrag.
//
// DamageType for the FRAG-12 direct hits
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTBulldogFRAG extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k launched a FRAG-12 at hapless %o ."
     DeathStrings(1)="%o was the lucky recipient of %k's FRAG-12."
     DeathStrings(2)="%k's FRAG-12 whizzed right into %o's face."
     SimpleKillString="Bulldog FRAG-12"
     InvasionDamageScaling=1.500000
     DamageIdent="Ordnance"
     bDisplaceAim=True
     AimDisplacementDuration=0.400000
     WeaponClass=Class'BWBPRecolorsPro.BulldogAssaultCannon'
     DeathString="%o was the lucky recipient of %k's FRAG-12."
     FemaleSuicide="%o launched a FRAG-12 and ran screaming after it."
     MaleSuicide="%o ran screaming into the path of his own FRAG-12."
     bDelayedDamage=True
     bSelected=False
}
