//=============================================================================
// Damage type class for RS8 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_RS8Pistol extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o was suppressed by %k's 10mm RS8."
     DeathStrings(1)="%o got clipped by %k's RS8 rounds."
     DeathStrings(2)="%k snapped a few RS8 rounds into %o."
     EffectChance=0.500000
     DamageIdent="Pistol"
     bDisplaceAim=False
     bUseMotionBlur=False
     WeaponClass=Class'BallisticProV55.RS8Pistol'
     DeathString="%o was suppressed by %k's 10mm RS8."
     FemaleSuicide="%o silenced herself."
     MaleSuicide="%o silenced himself."
     bFastInstantHit=True
     VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000
}
