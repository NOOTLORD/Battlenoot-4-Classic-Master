//=============================================================================
// 3rd person weapon class for the XK2 SMG
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class XK2Attachment extends BallisticAttachment;

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	SetBoneScale (0, 0.0, 'Silencer');
}

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashScale=0.600000	  
     FlashBone="Muzzle"
     ImpactManager=Class'BallisticProV55.IM_Bullet'	
     BrassClass=Class'BallisticProV55.Brass_Pistol'	 
     TracerClass=Class'BallisticProV55.TraceEmitter_Pistol'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'	 
     ReloadAnim="Reload_AR"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.250000
     CockAnimRate=0.900000
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticProAnims.Xk2_TP'
     DrawScale=0.125000
	 Skins(0)=Texture'BallisticProTex.XK2.XK2-Main'
	 Skins(1)=Texture'BallisticProTex.XK2.XK2-Main'
	 Skins(2)=Texture'BallisticProTex.XK2.XK2-Main'
}
