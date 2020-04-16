//=============================================================================
// Damage type class for Blunt weapons
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_BWBlunt extends BallisticDamageType;

static function DoBloodEffects( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
	if (BallisticPawn(Victim) == None)
		super.DoBloodEffects( HitLocation, Damage, Momentum, Victim, bLowDetail );
}

defaultproperties
{
     BloodManagerName="BallisticProV55.BloodMan_Blunt"
     FlashThreshold=0
     bCanBeBlocked=False
     DamageDescription=",Blunt,"
     bInstantHit=True
     bNeverSevers=True
	 bDisplaceAim=False
     bUseMotionBlur=False
     FlashScale=0.000000	 
     PawnDamageSounds(0)=Sound'BallisticSounds2.M763.M763SmashFlesh'
     VehicleDamageScaling=0.000000
     VehicleMomentumScaling=0.000000
}
