//=============================================================================
// DTD49Revolver.
//
// Damage type for the D49 Revolver
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DTD49Revolver extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k dropped %o with %kh six shooter."
     DeathStrings(1)="%o was put down by a shot from %k's D49."
     DeathStrings(2)="%k drew %kh revolver and blew a hole in %o."
     DeathStrings(3)="%k shot %o like a dog."
     DeathStrings(4)="%k blasted %o to death with his monster magnum."
     DeathStrings(5)="%o was shot to the dirt by %k's magnum."
     DamageIdent="Pistol"
     AimDisplacementDamageThreshold=0.000000
     AimDisplacementDuration=0.000000
     bUseMotionBlur=False	 
     WeaponClass=Class'BallisticProV55.D49Revolver'
     DeathString="%k dropped %o with %kh six shooter."
     FemaleSuicide="%o shot herself in the foot."
     MaleSuicide="%o shot himself in the foot."
     VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000
}
