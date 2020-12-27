//=============================================================================
// 3rd person weapon class for the FN2000 Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class FN2000Attachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55Recolors.FN2000FlashEmitter' 
     FlashScale=0.125000	 
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     BrassClass=Class'BallisticProV55.Brass_Rifle'	 
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     ReloadAnim="Reload_AR"
     ReloadAnimRate=0.900000
	 CockingAnim="Cock_RearPull"							 
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticProRecolorsAnims.FN2000_TP'
     DrawScale=0.825000
	 Skins(0)=Texture'BallisticProRecolorsTex.FN2000.FN2000-Main'
	 Skins(1)=Texture'BallisticProRecolorsTex.FN2000.FN2000-Misc'
	 Skins(2)=Texture'BallisticProRecolorsTex.FN2000.FN2000-EOTech'
}
