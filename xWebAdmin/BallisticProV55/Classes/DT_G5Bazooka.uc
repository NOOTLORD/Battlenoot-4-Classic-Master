//=============================================================================
// Damage type class for G5 Bazooka
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_G5Bazooka extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o was blown to pieces by %k's G5."
     DeathStrings(1)="%o caught %k's G5 rocket."
     DeathStrings(2)="%k launched %kh G5 rocket into %o's face."
     DamageIdent="Ordnance"
     bDisplaceAim=False
     bUseMotionBlur=False
     WeaponClass=Class'BallisticProV55.G5Bazooka'
     DeathString="%o was blown to pieces by %k's G5."
     FemaleSuicide="%o splattered the walls with her gibs using a G5."
     MaleSuicide="%o splattered the walls with his gibs using a G5."
     bDelayedDamage=True
     VehicleDamageScaling=1.500000
     InvasionDamageScaling=1.000000
}
