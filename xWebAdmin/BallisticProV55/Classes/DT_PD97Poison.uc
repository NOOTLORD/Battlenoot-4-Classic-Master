//=============================================================================
// Damage type class for PD97 dart poisoning
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_PD97Poison extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k's PD97 dart poisoned %o to an agonizing death."
     DeathStrings(1)="%o suffered boils and poisoning from %k's stun dart."
     DeathStrings(2)="%k's dart poison eventually overcame %o's fragile constitution."
     SimpleKillString="PD97 Poison"
     DamageIdent="Sidearm"
     bDisplaceAim=False
     bUseMotionBlur=False	 
     DamageDescription=",Poison,GearSafe,NonSniper,"
     WeaponClass=Class'BallisticProV55.PD97Bloodhound'
     DeathString="%k's PD97 dart poisoned %o to an agonizing death."
     FemaleSuicide="%o pricked herself with a PD97 dart."
     MaleSuicide="%o pricked himself with a PD97 dart."
     bArmorStops=False
     bLocationalHit=False
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000
}
