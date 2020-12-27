//=============================================================================
// 3rd person weapon class for the GRS9 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class GRS9Attachment extends HandgunAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashScale=0.650000
     ImpactManager=Class'BallisticProV55.IM_Bullet'		 
     BrassClass=Class'BallisticProV55.Brass_GRS9Pistol'
     TracerClass=Class'BallisticProV55.TraceEmitter_Pistol'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'	 
     ReloadAnim="Reload_Pistol"
     CockingAnim="Cock_RearPull"
     CockAnimRate=0.800000
     Mesh=SkeletalMesh'BallisticProAnims.GRS9_TP'
     DrawScale=0.070000
	 Skins(0)=Texture'BallisticProTex.GRS-9.GRS-9-Main'
}
