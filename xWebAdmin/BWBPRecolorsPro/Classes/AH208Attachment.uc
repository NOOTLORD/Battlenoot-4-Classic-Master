//=============================================================================
// 3rd person weapon class for AH-208 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class AH208Attachment extends HandgunAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
	 FlashMode=MU_Primary
     FlashBone="Muzzle"
     FlashScale=0.200000
     LightMode=MU_Primary 
     ImpactManager=Class'BallisticProV55.IM_Bullet'	 
     BrassClass=Class'BallisticProV55.Brass_Pistol'
	 BrassMode=MU_Primary
     BrassBone="Scope"
	 InstantMode=MU_Primary
	 TrackAnimMode=MU_None
     TracerClass=Class'BallisticProV55.TraceEmitter_Pistol'
	 TracerMode=MU_Primary
     TracerChance=1.000000	 
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
	 WaterTracerMode=MU_Primary
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
	 FlyByMode=MU_Primary
     ReloadAnim="Reload_Pistol"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=0.850000
     CockAnimRate=0.900000
     Mesh=SkeletalMesh'BallisticRecolorsAnims.Eagle_TP'
     RelativeLocation=(Z=6.000000)
     DrawScale=0.175000
}
