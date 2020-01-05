//=============================================================================
// GRS9Attachment.
//
// 3rd person weapon attachment for GRS9 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class GRS9Attachment extends HandgunAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     FlashScale=0.650000
     BrassClass=Class'BallisticProV55.Brass_GRSNine'
     InstantMode=MU_Both
     TracerClass=Class'BallisticProV55.TraceEmitter_Pistol'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     FlyByMode=MU_Primary
     ReloadAnim="Reload_Pistol"
     CockingAnim="Cock_RearPull"
     CockAnimRate=0.800000
     Mesh=SkeletalMesh'BWBP4-Anims.Glock-3rd'
     DrawScale=0.070000
     bSelected=True
}
