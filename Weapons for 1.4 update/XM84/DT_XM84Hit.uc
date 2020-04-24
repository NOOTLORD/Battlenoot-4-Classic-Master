//=============================================================================
// Damage type for the XM84 Grenade
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_XM84Hit extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k beaned %o with an XM84, who promptly died."
     DeathStrings(1)="%k bounced a tech grenade off %o's head! Fatality!"
     BloodManagerName="BallisticProV55.BloodMan_BluntSmall"
     bDetonatesBombs=False
     DamageIdent="Grenade"
     AimDisplacementDamageThreshold=0.000000
     AimDisplacementDuration=0.000000
	 bDisplaceAim=False
     bUseMotionBlur=False
     DamageDescription=",Blunt,Hazard,"
     WeaponClass=Class'BWBPRecolorsPro.XM84Flashbang'
     DeathString="%k beaned %o with an XM84, who promptly died."
     FemaleSuicide="%o tripped on her own XM84."
     MaleSuicide="%o tripped on his own XM84."
     bDelayedDamage=True
     GibPerterbation=0.500000
     KDamageImpulse=20000.000000
	 VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000
}
