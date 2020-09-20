//=============================================================================
// 3rd person weapon class for the R9 Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class R9Attachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.R9FlashEmitter'
     FlashMode=MU_Primary 	
     FlashScale=1.000000
	 LightMode=MU_Primary
     ImpactManager=Class'BallisticProV55.IM_Bullet''
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassMode=MU_Primary
     InstantMode=MU_Primary
     TrackAnimMode=MU_None
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'	 
     TracerMode=MU_Primary
     TracerChance=1.000000	 
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Primary
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     FlyByMode=MU_Primary
     ReloadAnim="Reload_AR"
     CockingAnim="Cock_RearPull"
     Mesh=SkeletalMesh'BallisticAnims2.R9_TP'
     DrawScale=0.140000 
	 Skins(0)=Texture'BallisticWeapons2.R9.USSRSkin'
}
