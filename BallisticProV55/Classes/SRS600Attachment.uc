//=============================================================================
// 3rd person weapon class for the SRS-600-Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class SRS600Attachment extends BallisticAttachment;

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	SetBoneScale (0, 0.0, 'Silencer');
}

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'  
	 FlashScale=0.550000
     ImpactManager=Class'BallisticProV55.IM_Bullet'		 
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'	 
     ReloadAnim="Reload_AR"
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticProAnims.SRS-600_TP'
     DrawScale=0.240000
     Skins(0)=Texture'BallisticProTex.SRS-600.SRS-600-Main'
     Skins(1)=Texture'BallisticProTex.SRS-600.SRS-600-Clip'
}
