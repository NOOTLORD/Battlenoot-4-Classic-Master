//=============================================================================
// 3rd person weapon class for the M4A1 Carbine
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class M4A1Attachment extends BallisticAttachment;

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
     TracerChance=1.000000
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     FlyByMode=MU_Both	 
     ReloadAnim="Reload_AR"
     ReloadAnimRate=1.000000
     Mesh=SkeletalMesh'BallisticRecolorsAnims.M4A1Carbine_TP'
     RelativeRotation=(Pitch=32768,Roll=-1000)
     PrePivot=(Y=-1.000000,Z=-12.500000)
     DrawScale=1.000000
	 Skins(0)=Texture'BallisticRecolorsTex.LK05.LK05-EOTech-RDS'
	 Skins(1)=Texture'BallisticRecolorsTex.M4A1.M4_Black'
	 Skins(2)=Texture'BallisticRecolorsTex.LK05.LK05-Bullets'
}
