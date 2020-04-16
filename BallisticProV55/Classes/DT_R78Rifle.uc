//=============================================================================
// Damage type class for R78 Sniper Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_R78Rifle extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o was silenced by %k's R78."
     DeathStrings(1)="%k picked off %o with %kh sniper rifle."
     DeathStrings(2)="%k's R78 hunted down %o."
     DeathStrings(3)="%k's Raven tucked into some delicious %o."
     DeathStrings(4)="%k's Raven strike ended %o's farcical existence."
     DeathStrings(5)="%o never even saw %k's R78 bullet coming."
     bSnipingDamage=True
     DamageIdent="Sniper"
     bDisplaceAim=False
     bUseMotionBlur=False
     WeaponClass=Class'BallisticProV55.R78Rifle'
     DeathString="%o was silenced by %k's R78."
     FemaleSuicide="%o held her R78 the wrong way around."
     MaleSuicide="%o held his R78 the wrong way around."
     VehicleDamageScaling=0.150000
     InvasionDamageScaling=1.000000	 
}