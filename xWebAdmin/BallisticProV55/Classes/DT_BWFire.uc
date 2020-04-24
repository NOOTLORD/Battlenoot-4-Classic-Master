//=============================================================================
// Damage type class for guns that use fire to damage the player
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_BWFire extends BallisticDamageType;

static function DoBloodEffects( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
	if (BallisticPawn(Victim) == None)
		super.DoBloodEffects( HitLocation, Damage, Momentum, Victim, bLowDetail );
}

defaultproperties
{
     bIgniteFires=True
     DamageDescription=",Flame,Hazard,NonSniper,"
     bLocationalHit=False
     bCausesBlood=False
     bNeverSevers=True
     bDisplaceAim=False
     bUseMotionBlur=False	
     FlashScale=0.000000	 
     GibPerterbation=0.500000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=1.500000
     InvasionDamageScaling=1.000000
}
