//=============================================================================
// Damage type class for the Puma Repeater
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_PumaRepeater extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k's PUMA riddled %o with bulletholes."
     DeathStrings(1)="%o failed to clear %k's PUMA crosshairs."
     DeathStrings(2)="%k savagely lit %o up with PUMA fire."
     DeathStrings(3)="%k terminated %o with an accurate PUMA burst."
     DamageIdent="Assault"	
     bDisplaceAim=False
     bUseMotionBlur=False	
     WeaponClass=Class'BWBPRecolorsPro.PumaRepeater'
     DeathString="%k's MARS-3 riddled %o with bulletholes."
     FemaleSuicide="%o tactically missed with the planet Mars."
     MaleSuicide="%o tactically missed with a Mars bar."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
	 VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000
}
