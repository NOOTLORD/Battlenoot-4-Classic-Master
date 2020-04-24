//=============================================================================
// Damage type for the held XM84 Grenade
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_XM84Held extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k blew off %kh hand and parts of %o."
     DeathStrings(1)="%o joined %k in %kh tactical suicide."
     DeathStrings(2)="%k decided to share his XM84 with %o."
     FemaleSuicides(0)="%o didn't realize her XM84 was on."
     FemaleSuicides(1)="%o threw the pin and not the grenade."
     MaleSuicides(0)="%o didn't realize his XM84 was on."
     MaleSuicides(1)="%o threw the pin and not the grenade."
     FlashThreshold=0
     FlashV=(X=2500.000000,Y=2500.000000,Z=2500.000000)
     FlashF=-0.600000
     DamageIdent="Grenade"
     AimDisplacementDamageThreshold=0.000000
     AimDisplacementDuration=0.000000
	 bDisplaceAim=False
     bUseMotionBlur=False	
     WeaponClass=Class'BWBPRecolorsPro.XM84Flashbang'
     DeathString="%k blew off %kh hand and parts of %o."
     FemaleSuicide="%o held her XM84 to the bitter end."
     MaleSuicide="%o refused to drop his XM84."
     bArmorStops=False
     bCauseConvulsions=False
     bNeverSevers=True
     GibModifier=0.500000
     GibPerterbation=0.900000
	 VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000
}
