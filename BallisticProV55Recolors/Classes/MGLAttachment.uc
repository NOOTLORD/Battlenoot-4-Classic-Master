//=============================================================================
// 3rd person weapon class for the MGL Launcher
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class MGLAttachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
     FlashScale=0.400000	 	 
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     TracerClass=Class'BallisticProV55.TraceEmitter_Default' 
     TracerMix=-3
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet' 
     ReloadAnim="Reload_AR"
     ReloadAnimRate=0.500000
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticProRecolorsAnims.MGL_TP'
     RelativeRotation=(Pitch=32768)
     DrawScale=0.250000
	 Skins(0)=Texture'BallisticProRecolorsTex.MGL.MGL-Main'
	 Skins(1)=Texture'BallisticProRecolorsTex.MGL.MGL-ScreenBase'
}
