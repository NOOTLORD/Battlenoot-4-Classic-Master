//=============================================================================
// 3rd person weapon class for the MRS138 Shotgun
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
     FlashScale=0.800000	 
     ImpactManager=Class'BallisticProV55.IM_Shell'
     BrassClass=Class'BallisticProV55.Brass_MRS138Shotgun'
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'	 
     SingleFireAnim="RifleHip_FireCock"
     SingleAimedFireAnim="RifleAimed_FireCock"
	 ReloadAnim="Reload_ShovelBottom"
     ReloadAnimRate=1.100000	 
     Mesh=SkeletalMesh'BallisticProAnims.MRS-138_TP'
     DrawScale=0.080000
	 Skins(0)=Texture'BallisticProTex.MRS-138.MRS-138-Main'
	 Skins(1)=Texture'BallisticProTex.MRS-138.MRS-138-Misc'
}
