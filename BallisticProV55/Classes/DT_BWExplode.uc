//=============================================================================
// Damage type class for guns that use explosions to damage the player
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_BWExplode extends BallisticDamageType;

static function DoBloodEffects( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
	if (BallisticPawn(Victim) == None && Victim.Health < 1 && (!Victim.PhysicsVolume.bWaterVolume) && !default.bCantLoadBlood && GetBloodManager() != None)
		GetBloodManager().static.StartSpawnBlood(Victim.Location, Momentum, Victim);
}

defaultproperties
{
     EffectChance=1.000000
     BloodManagerName="BallisticProV55.BloodMan_Exploded"
     bIgniteFires=True
     DamageDescription=",Explode,Hazard,NonSniper,"
     bLocationalHit=False
     bThrowRagdoll=True
     GibModifier=1.000000
     bDisplaceAim=False
     bUseMotionBlur=False
     FlashScale=0.000000	 
     PawnDamageSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.BulletFlesh'
     GibPerterbation=0.500000
     KDamageImpulse=20000.000000
     VehicleDamageScaling=1.500000
     InvasionDamageScaling=1.000000
}
