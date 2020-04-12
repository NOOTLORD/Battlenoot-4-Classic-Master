//=============================================================================
// Damage type class for M763 clouds
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_M763Gas extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o choked to death in a cloud of %k's toxic gas."
     DeathStrings(1)="%k poisoned %o to death with T10 gas."
     DeathStrings(2)="%o was greened by %k's gas shell."
     DeathStrings(3)="%k's toxic gas shell turned %o's little piggy face green."
     DeathStrings(4)="%o breathed in the toxic fumes of %k's shell."
     FemaleSuicides(0)="%o gassed herself."
     FemaleSuicides(1)="%o couldn't stumble her way out of her gas cloud."
     FemaleSuicides(2)="%o was overcome by her own fumes."
     FemaleSuicides(3)="%o soiled herself to death."
     MaleSuicides(0)="%o gassed himself."
     MaleSuicides(1)="%o couldn't stumble his way out of his gas cloud."
     MaleSuicides(2)="%o was overcome by his own fumes."
     MaleSuicides(3)="%o soiled himself to death."
     SimpleKillString="M763 Gas Shell"
     bIgnoredOnLifts=True
     DamageIdent="Grenade"
     DamageDescription=",Gas,GearSafe,Hazard,"
     bDisplaceAim=False
     bUseMotionBlur=False
     WeaponClass=Class'BallisticProV55.M763Shotgun'
     DeathString="%o choked to death in a cloud of %k's toxic gas."
     FemaleSuicide="%o gassed herself."
     MaleSuicide="%o gassed himself."
     bArmorStops=False
     bLocationalHit=False
     bCausesBlood=False
     bDelayedDamage=True
     bNeverSevers=True
     GibPerterbation=0.500000
     KDamageImpulse=20000.000000
     VehicleDamageScaling=0.000000
}
