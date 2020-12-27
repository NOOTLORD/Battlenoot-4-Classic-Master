//=============================================================================
// 3rd person weapon class for the AH-208 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class AH208Attachment extends HandgunAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
     FlashBone="Muzzle"
     FlashScale=0.200000
     ImpactManager=Class'BallisticProV55.IM_Bullet'	 
     BrassClass=Class'BallisticProV55Recolors.Brass_AH208pistol'
     BrassBone="Scope"
     TracerClass=Class'BallisticProV55.TraceEmitter_Pistol'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'	 
     ReloadAnim="Reload_Pistol"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=0.850000
     CockAnimRate=0.900000
     Mesh=SkeletalMesh'BallisticProRecolorsAnims.AH208_TP'
     RelativeLocation=(Z=6.000000)
     DrawScale=0.175000
	 Skins(0)=Texture'BallisticProRecolorsTex.AH208.AH208-Main'
	 Skins(1)=Texture'BallisticProRecolorsTex.AH208.AH208-Misc'
}
