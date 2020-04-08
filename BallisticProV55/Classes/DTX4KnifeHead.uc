//=============================================================================
// Damage type class for X4 Knife headshots
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DTX4KnifeHead extends DTX4Knife;

defaultproperties
{
     DeathStrings(0)="%k's X4 separated %o from %vh head."
     DeathStrings(1)="%o lost %vh ears and eyes to %k's X4 blade."
     DeathStrings(2)="%k jammed %kh X4 in %o's skull and wriggled it around a bit."
     DamageIdent="Melee"	 
     bHeaddie=True
     bDisplaceAim=False
     bUseMotionBlur=False 
     DeathString="%k's X4 separated %o from %vh head."
     FemaleSuicide="%o attempted brain surgery on herself with an X4."
     MaleSuicide="%o attempted brain surgery on himself with an X4."
     bAlwaysSevers=True
     bSpecial=True
     VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000	 
}
