//=============================================================================
// M4Attachment.
//
// 3rd person weapon attachment for M4 Carbine
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M4Attachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
     FlashMode=MU_Both 
     FlashScale=0.250000
     LightMode=MU_Primary	 
     ImpactManager=Class'BallisticProV55.IM_Bullet'	 
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassMode=MU_Both	 
     InstantMode=MU_Both
     TrackAnimMode=MU_None
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     TracerMode=MU_Primary	 
     TracerChance=0.500000
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     FlyByMode=MU_Both	 
     ReloadAnim="Reload_AR"
     ReloadAnimRate=1.000000
     Mesh=SkeletalMesh'BallisticRecolorsAnims.M4Carbine_TP'
     RelativeRotation=(Pitch=32768)
     PrePivot=(Y=-1.000000,Z=-5.000000)
     DrawScale=0.550000	
}
