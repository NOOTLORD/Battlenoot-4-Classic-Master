//=============================================================================
// 3rd person weapon class for the SAR-12 Rifle
//
// 3rd person weapon attachment for SAR Assault
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class SAR12Attachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashScale=0.750000	
     ImpactManager=Class'BallisticProV55.IM_Bullet'	 
     BrassClass=Class'BallisticProV55.Brass_SAR12Rifle'
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'	 
     ReloadAnim="Reload_AR"
     ReloadAnimRate=1.100000
     bHeavy=True
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticProAnims.SAR-12_TP'
     DrawScale=0.085000
	 Skins(0)=Texture'BallisticProTex.SAR-12.SAR-12-Main'
}
