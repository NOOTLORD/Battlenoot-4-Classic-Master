//=============================================================================
// 3rd person weapon class for the LK-05 Carbine
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class LK05Attachment extends BallisticAttachment;

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	SetBoneScale (0, 0.0, 'SantasFrozenSphinctre');
}

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
     FlashScale=1.750000	 
     ImpactManager=Class'BallisticProV55.IM_Bullet'	 
     BrassClass=Class'BallisticProV55.Brass_Rifle' 
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'	 
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet' 
     ReloadAnim="Reload_AR"
     ReloadAnimRate=1.200000
     Mesh=SkeletalMesh'BallisticProRecolorsAnims.LK-05_TP'
     RelativeRotation=(Pitch=32768)
     PrePivot=(X=1.000000,Z=-3.000000)
     DrawScale=0.080000	
	 Skins(0)=Texture'BallisticProRecolorsTex.LK-05.LK-05-Bullets'
	 Skins(1)=Shader'BallisticProRecolorsTex.LK-05.LK-05-EOTechShader'
	 Skins(2)=Texture'BallisticProRecolorsTex.LK-05.LK-05-Receiver'
	 Skins(3)=Texture'BallisticProRecolorsTex.LK-05.LK-05-Grip'
	 Skins(4)=Texture'BallisticProRecolorsTex.LK-05.LK-05-Grip'
	 Skins(5)=Texture'BallisticProRecolorsTex.LK-05.LK-05-Stock'
	 Skins(6)=Texture'BallisticProRecolorsTex.LK-05.LK-05-EOTech'
	 Skins(7)=Texture'BallisticProRecolorsTex.LK-05.LK-05-Mag'
}
