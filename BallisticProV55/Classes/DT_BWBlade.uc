//=============================================================================
// DT_BWBlade.
//
// Base damage type that will play some pawn impact sounds for blades
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_BWBlade extends BallisticDamageType;

static function DoBloodEffects( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
	if (BallisticPawn(Victim) == None)
		super.DoBloodEffects( HitLocation, Damage, Momentum, Victim, bLowDetail );
}

defaultproperties
{
     BloodManagerName="BallisticProV55.BloodMan_Slash"
     bCanBeBlocked=True
     ShieldDamage=50
     bIgnoredOnLifts=True
     bMetallic=True
     AimDisplacementDamageThreshold=0.000000
     AimDisplacementDuration=0.000000
     bUseMotionBlur=False
     DamageDescription=",Slash,"
     bInstantHit=True
     PawnDamageSounds(0)=SoundGroup'BallisticSounds2.Knife.KnifeFlesh'
     TransientSoundVolume=0.700000
     VehicleDamageScaling=0.000000	 
     InvasionDamageScaling=1.000000	 
}
