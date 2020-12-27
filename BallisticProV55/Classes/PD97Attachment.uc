//=============================================================================
// 3rd person weapon class for the PD-97 Pistol
//
// by Azarael
// adapting code by Nolan "Dark Carnivour" Richert
// Aspects of which are copyright (c) 2006 RuneStorm. All rights reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class PD97Attachment extends HandgunAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
	 FlashScale=0.350000
     ImpactManager=Class'BallisticProV55.IM_Bullet'		 
     BrassMode=MU_None	 
     TracerClass=Class'BallisticProV55.TraceEmitter_Dart'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'	 
     ReloadAnim="Reload_BreakOpen"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.70000
     Mesh=SkeletalMesh'BallisticProAnims.PD97_TP'
     RelativeLocation=(Z=11.000000)
     DrawScale=0.150000	
	 Skins(0)=Texture'BallisticProTex.PD97.PD97-Main'
	 Skins(1)=Texture'BallisticProTex.PD97.PD97-Clip'
	 Skins(2)=Texture'BallisticProTex.PD97.PD97-Misc'
	 Skins(3)=Shader'BallisticProTex.General.RedDotSightShader'
}
