//=============================================================================
// AK47Attachment.
//
// 3rd person weapon attachment for AK47 Battle Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Edited by (NL)NOOTLORD
//=============================================================================
class AK47Attachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashMode=MU_Primary	 
     FlashScale=0.250000
     ImpactManager=Class'BallisticProV55.IM_Bullet'	 
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassMode=MU_Primary
     InstantMode=MU_Primary
     LightMode=MU_Primary
	 TrackAnimMode=MU_None
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
	 TracerMode=MU_Primary
	 TracerChance=0.500000
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Primary
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
	 FlyByMode=MU_Primary
     ReloadAnim="Reload_AR"
     ReloadAnimRate=0.800000
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticRecolors4AnimPro.TP_AK490'
     RelativeRotation=(Pitch=32768)
     DrawScale=0.350000
}
