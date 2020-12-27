//=============================================================================
// 3rd person weapon class for the M763 Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class M763Attachment extends BallisticShotgunAttachment;

defaultproperties
{																											         																 
     MuzzleFlashClass=Class'BallisticProV55.M763FlashEmitter'
     FlashScale=1.500000	 	    
	 ImpactManager=Class'BallisticProV55.IM_Shell'													  	
     BrassClass=Class'BallisticProV55.Brass_Shotgun'
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'						  
     SingleFireAnim="RifleHip_FireCock"
     SingleAimedFireAnim="RifleAimed_FireCock"
     Mesh=SkeletalMesh'BallisticProAnims.M763_TP'
     DrawScale=0.080000
	 Skins(0)=Texture'BallisticProTex.M763.M763-Shell'
	 Skins(1)=Texture'BallisticProTex.M763.M763-Main'
	 
}
