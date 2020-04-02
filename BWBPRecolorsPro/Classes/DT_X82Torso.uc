//=============================================================================
// Damage type class for X82 Sniper Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_X82Torso extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k tore up %o with a .50 BMG sniper round."
     DeathStrings(1)="%o lost %vh life to %k's X-83 A1."
     DeathStrings(2)="%o was shattered by %k's .50 Cal sniper."
     bSnipingDamage=True
     DamageIdent="Sniper"
     AimDisplacementDamageThreshold=0.000000
     AimDisplacementDuration=0.000000
     bUseMotionBlur=False	
     WeaponClass=Class'BWBPRecolorsPro.X82Rifle'
     DeathString="%k ripped up %o with a .50 BMG sniper round."
     FemaleSuicide="%o shot herself in the foot."
     MaleSuicide="%o shot himself in the foot."
     bFastInstantHit=True
     bExtraMomentumZ=True
     GibPerterbation=0.100000
     KDamageImpulse=30000.000000
     VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000
}
