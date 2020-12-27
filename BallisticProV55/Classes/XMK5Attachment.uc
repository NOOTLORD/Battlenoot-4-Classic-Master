//=============================================================================
// 3rd person weapon class for the XMK-5 SMG
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class XMK5Attachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashScale=0.200000
     ImpactManager=Class'BallisticProV55.IM_Bullet'		 
     BrassClass=Class'BallisticProV55.Brass_XMK5SMG'
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     ReloadAnim="Reload_AR"
     ReloadAnimRate=1.250000
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticProAnims.XMK-5_TP'
     DrawScale=0.275000
	 Skins(0)=Texture'BallisticProTex.XMK-5.XMK-5-Misc'
	 Skins(1)=Texture'BallisticProTex.XMK-5.XMK-5-Main'
	 Skins(2)=Texture'BallisticProTex.XMK-5.XMK-5-Clip'
	 Skins(3)=FinalBlend'BallisticProTex.XMK-5.XMK-5-SightFB'
}
