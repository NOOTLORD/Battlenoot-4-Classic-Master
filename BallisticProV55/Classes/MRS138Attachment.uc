//=============================================================================
// MRS138Attachment.
//
// Third person attachment for MRS138 Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class MRS138Attachment extends BallisticShotgunAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.MRS138FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     FlashScale=0.800000
     BrassClass=Class'BallisticProV55.Brass_MRS138Shotgun'
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
	 TracerChance=1.000000
     SingleFireAnim="RifleHip_FireCock"
     SingleAimedFireAnim="RifleAimed_FireCock"
     Mesh=SkeletalMesh'BWBP1-Anims.MRS138-3rd'
     DrawScale=0.090000
}
