//=============================================================================
// 3rd person weapon class for the R9 Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class R9Attachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.R9FlashEmitter'	
     FlashScale=1.000000
     ImpactManager=Class'BallisticProV55.IM_Bullet'	 
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'	 
     ReloadAnim="Reload_AR"
     CockingAnim="Cock_RearPull"
     Mesh=SkeletalMesh'BallisticProAnims.R9_TP'
     DrawScale=0.140000 
	 Skins(0)=Texture'BallisticProTex.R9.R9-Main'
}
