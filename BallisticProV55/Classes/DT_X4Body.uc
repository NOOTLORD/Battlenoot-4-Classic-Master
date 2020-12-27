//=============================================================================
// Damage type class for the X4 Knife
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_X4Body extends DT_BWBlade;

defaultproperties
{
     DamageIdent="Melee"
     bDisplaceAim=False
     DamageDescription=",Slash,Stab,"
     WeaponClass=Class'BallisticProV55.X4Knife'
     DeathString="%k cut up %o like a paper-shredder with %kh X4 knife."
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000	 	 
}
