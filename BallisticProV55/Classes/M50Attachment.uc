//=============================================================================
// 3rd person weapon class for the M50 Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class M50Attachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
     FlashScale=1.000000
     ImpactManager=Class'BallisticProV55.IM_Bullet'		 
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'	 
     ReloadAnim="Reload_AR"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.250000
     CockAnimRate=1.400000
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticProAnims.M50_TP'
     DrawScale=0.160000
	 Skins(0)=Texture'BallisticProTex.M50.M50-Main'
	 Skins(1)=Texture'BallisticProTex.M50.M50-Misc'
	 Skins(2)=Texture'BallisticProUITex.M50.M50LCDTex'
	 Skins(3)=Texture'BallisticProTex.M50.M50-Laser'
	 Skins(4)=Texture'BallisticProTex.M50.M50-GrenadeLauncher'
}
