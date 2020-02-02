//=============================================================================
// Damage type class for PD97 dart 
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DTPD97Dart extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o was nailed by %k's PD97 stun dart."
     DeathStrings(1)="%o was drilled by %k's PD97 dart."
     DeathStrings(2)="%o was implanted with %k's PD97 dart."
     SimpleKillString="PD97 Dart"
     DamageIdent="Sidearm"
     AimDisplacementDamageThreshold=0.000000
     AimDisplacementDuration=0.000000
     bUseMotionBlur=False	 
     WeaponClass=Class'BWBPOtherPackPro.PD97Bloodhound'
     DeathString="%o was nailed by %k's PD97 stun dart."
     FemaleSuicide="%o became her own PD97 dartboard."
     MaleSuicide="%o became his own PD97 dartboard."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
	 VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000
}
