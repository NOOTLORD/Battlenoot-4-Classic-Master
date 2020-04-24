//=============================================================================
// Damage type class for RS04 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_RS04Pistol extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k shot %o down in %vh prime with his RS04."
     DeathStrings(1)="%o couldn't escape %k's RS04."
     DeathStrings(2)="%k's RS04 sent %o home in a body bag."
     DamageIdent="Pistol"
     bDisplaceAim=False
     bUseMotionBlur=False	 
     WeaponClass=Class'BallisticProV55.RS04Pistol'
     DeathString="%k shot down %o in %vh prime with his RS04."
     FemaleSuicide="%o somehow shot herself."
     MaleSuicide="%o managed to shoot himself."
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
	 VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.0000000
}
