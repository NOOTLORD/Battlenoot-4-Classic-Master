//=============================================================================
// Damage type class for GRS-9 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DTGRS9Pistol extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k prosecuted %o with %kh GRS-9."
     DeathStrings(1)="%o was acquitted by %k's GRS-9."
     DeathStrings(2)="%o was vindicated by %k's GRS-9."
     DeathStrings(3)="%k intimidated %o to pieces with %kh GRS-9."
     DamageIdent="Pistol"
     bDisplaceAim=False
     bUseMotionBlur=False
     WeaponClass=Class'BallisticProV55.GRS9Pistol'
     DeathString="%k prosecuted %o with %kh GRS-9."
     FemaleSuicide="%o prosecuted herself with the GRS-9."
     MaleSuicide="%o prosecuted himself with the GRS-9."
     VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000
}
