//=============================================================================
// 3rd person weapon class for MRS138 Shotgun
//
// Third person attachment for MRS138 Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class MRS138Attachment extends BallisticShotgunAttachment;

defaultproperties
{
     FireClass=Class'BallisticProV55.MRS138PrimaryFire'
     MuzzleFlashClass=Class'BallisticProV55.MRS138FlashEmitter'
     FlashMode=MU_Primary
     FlashScale=0.800000	 
     LightMode=MU_Primary
     ImpactManager=Class'BallisticProV55.IM_Shell'
     BrassClass=Class'BallisticProV55.Brass_MRS138_Shotgun'
     BrassMode=MU_Primary
     InstantMode=MU_Primary
     TrackAnimMode=MU_None
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     TracerMode=MU_Primary	 	 
	 TracerChance=1.000000
     SingleFireAnim="RifleHip_FireCock"
     SingleAimedFireAnim="RifleAimed_FireCock"
     Mesh=SkeletalMesh'BWBP1-Anims.MRS138-3rd'
     DrawScale=0.080000
}
