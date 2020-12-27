//=============================================================================
// 3rd person weapon class for the MD24 Pistol
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class MD24Attachment extends HandgunAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashScale=0.200000
     FlashBone="Muzzle"	 
     ImpactManager=Class'BallisticProV55.IM_Bullet'	 
     BrassClass=Class'BallisticProV55.Brass_Pistol'	 
     TracerClass=Class'BallisticProV55.TraceEmitter_Pistol'	 
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet' 
     ReloadAnim="Reload_Pistol"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.400000
     CockAnimRate=0.800000
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticProAnims.MD24_TP'
     DrawScale=0.250000
	 Skins(0)=Texture'BallisticProTex.MD24.MD24-Main'
	 Skins(1)=Texture'BallisticProTex.MD24.MD24-Clip'
}

