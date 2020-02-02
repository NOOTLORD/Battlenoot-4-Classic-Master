//=============================================================================
// Damage type class for MD24 Pistol
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyrightę 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DTMD24Pistol extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o was stuffed like a turkey by %k's MD24."
     DeathStrings(1)="%k passed a few MD24 rounds into %o's stomach."
     DeathStrings(2)="%o got %vs greased by %k's MD24 pistol."
     DamageIdent="Pistol"
     bDisplaceAim=False
     bUseMotionBlur=False
     WeaponClass=Class'BallisticProV55.MD24Pistol'
     DeathString="%o was stuffed like a turkey by %k's MD24."
     FemaleSuicide="%o blasted herself with an MD24."
     MaleSuicide="%o blasted himself with an MD24."
     FlashScale=0.300000
     VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000
}
