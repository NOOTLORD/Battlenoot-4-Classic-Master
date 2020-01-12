//=============================================================================
// DTNRP57Grenade.
//
// Damage type for the NRP57 Grenade
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DTNRP57Grenade extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k rammed a pineapple down %o's throat."
     BloodManagerName="BallisticProV55.BloodMan_BluntSmall"
     bDetonatesBombs=False
     DamageIdent="Grenade"
     AimDisplacementDamageThreshold=0.000000
     AimDisplacementDuration=0.000000
     bUseMotionBlur=False	 
     DamageDescription=",Blunt,Hazard,"
     WeaponClass=Class'BallisticProV55.NRP57Grenade'
     DeathString="%k rammed a pineapple down %k's throat."
     FemaleSuicide="%o tripped on her own pineapple."
     MaleSuicide="%o tripped on his own pineapple."
     bDelayedDamage=True
     GibPerterbation=0.500000
     KDamageImpulse=20000.000000
     VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000	 
}
