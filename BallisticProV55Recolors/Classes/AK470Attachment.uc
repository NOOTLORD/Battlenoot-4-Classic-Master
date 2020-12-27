//=============================================================================
// 3rd person weapon class for the AK-470 Assault Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class AK470Attachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter' 
     FlashScale=0.250000	 
     ImpactManager=Class'BallisticProV55.IM_Bullet'	 
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     ReloadAnim="Reload_AR"
     ReloadAnimRate=0.800000
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticProRecolorsAnims.AK470_TP'
     RelativeRotation=(Pitch=32768)
     DrawScale=0.265000
	 Skins(0)=Texture'BallisticProRecolorsTex.AK470.AK470-Misc'
	 Skins(1)=Texture'BallisticProRecolorsTex.AK470.AK470-Main'
}
