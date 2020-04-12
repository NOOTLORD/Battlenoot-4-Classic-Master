//=============================================================================
// Damage type class for XMK5 Submachine Gun
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_XMK5SMG extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k sprayed %o with XMk5 rounds."
     DeathStrings(1)="%o was gunned down as %ve tried to cower away from %k's XMk5 SMG."
     DeathStrings(2)="%k shovelled XMk5 rounds into %o."
     DeathStrings(3)="%k's XMk5 turned %o into a leaky piece of meat."
     DamageIdent="SMG"
     bDisplaceAim=False
     bUseMotionBlur=False
     WeaponClass=Class'BallisticProV55.XMK5SubMachinegun'
     DeathString="%k sprayed %o with XMk5 rounds."
     FemaleSuicide="%o ripped herself to shreds with an XMk5."
     MaleSuicide="%o ripped himself to shreds with an XMk5."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000
}
