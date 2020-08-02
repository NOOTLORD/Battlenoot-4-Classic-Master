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
     FireClass=Class'BallisticProV55.M763PrimaryFire'																	 
     MuzzleFlashClass=Class'BallisticProV55.M763FlashEmitter'
     FlashMode=MU_Primary 
     FlashScale=1.500000	 
     LightMode=MU_Primary	    
	 ImpactManager=Class'BallisticProV55.IM_Shell'													  	
     BrassClass=Class'BallisticProV55.Brass_Shotgun'
	 BrassMode=MU_Primary
     InstantMode=MU_Primary
     TrackAnimMode=MU_None
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     TracerMode=MU_Primary	 
     TracerChance=1.000000							  
     SingleFireAnim="RifleHip_FireCock"
     SingleAimedFireAnim="RifleAimed_FireCock"
     Mesh=SkeletalMesh'BallisticAnims2.M763_TP'
     DrawScale=0.080000
	 Skins(0)=Texture'BallisticWeapons2.M763.M763Small'
	 Skins(1)=Texture'BallisticWeapons2.M763.M763Shotgun'
	 
}
