//=============================================================================
// 3rd person weapon class for the Marlin Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class MarlinAttachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.R78A1FlashEmitter'
     FlashScale=1.600000
     ImpactManager=Class'BallisticProV55.IM_Bullet'		 
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'	
	 ReloadAnim="Reload_ShovelBottom"
     ReloadAnimRate=1.100000	 
     Mesh=SkeletalMesh'BallisticProAnims.Marlin_TP'	 
     DrawScale=0.125000
	 Skins(0)=Texture'BallisticProTex.Marlin.Marlin-Main'
}

