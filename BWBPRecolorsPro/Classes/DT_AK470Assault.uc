//=============================================================================
// Damage type class for theAK47 Assault Rifle 
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_AK470Assault extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o was destroyed by the Russian might of %k."
     DeathStrings(1)="%o lost his vodka and life to %k and an AK-470."
     DeathStrings(2)="%k's AK-470 turned %o into a leaky barrel of blood."
     DeathStrings(3)="%o was executed under the order of Czar %k and %kh AK."
     DeathStrings(4)="%o was liberated by Comrade %k's AK-470."
     DamageIdent="Assault"
     bDisplaceAim=False
     bUseMotionBlur=False
     WeaponClass=Class'BWBPRecolorsPro.AK470AssaultRifle'
     DeathString="%o was destroyed by the Russian might of %k."
     FemaleSuicide="%o shot herself with an Awesome Kelly-470."
     MaleSuicide="%o shot himself with an Awesome Kelly-470."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000
}
