//=============================================================================
// Damage type class for the held NRP57
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_NRP57Held extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o got a share of %k's suicide."
     DeathStrings(1)="%o came too close to pinapple crazy %k."
     DeathStrings(2)="%k killed %o with a self propelled grenade."
     FemaleSuicides(0)="%o forgot to let go of her NRP-57."
     FemaleSuicides(1)="%o couldn't part with her NRP-57 so it parted her."
     MaleSuicides(0)="%o forgot to let go of his NRP-57."
     MaleSuicides(1)="%o couldn't part with his NRP-57 so it parted him."
     DamageIdent="Grenade"
     bDisplaceAim=False
     bUseMotionBlur=False	 
     bNoSeverStumps=True
     WeaponClass=Class'BallisticProV55.NRP57Grenade'
     DeathString="%o got a share of %k's suicide."
     FemaleSuicide="%o forgot to let go of her NRP-57."
     MaleSuicide="%o forgot to let go of his NRP-57."
     bSkeletize=True
     GibModifier=0.500000
     GibPerterbation=0.900000
     VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000
}
