//=============================================================================
// 3rd person weapon class for the RS8 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class RS8Attachment extends HandgunAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashScale=0.425000
     ImpactManager=Class'BallisticProV55.IM_Bullet'	 
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'	 
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet' 	 
     ReloadAnim="Reload_Pistol"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.400000
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticProAnims.RS8_TP'	 
     DrawScale=0.150000
	 Skins(0)=Texture'BallisticProTex.RS8.RS8-Main'
}
