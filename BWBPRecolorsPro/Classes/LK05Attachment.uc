//=============================================================================
// 3rd person weapon class for LK-05 Carbine
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class LK05Attachment extends BallisticAttachment;

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	SetBoneScale (0, 0.0, 'SantasFrozenSphinctre');
}

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
     FlashMode=MU_Primary 
     FlashScale=1.750000
     LightMode=MU_Primary	 
     ImpactManager=Class'BallisticProV55.IM_Bullet'	 
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
     ReloadAnimRate=1.200000
     Mesh=SkeletalMesh'BallisticRecolorsAnims.LK05_TP'
     RelativeRotation=(Pitch=32768)
     PrePivot=(X=1.000000,Z=-3.000000)
     DrawScale=0.080000	
	 Skins(0)=Texture'BallisticRecolorsTex.LK05.LK05-Bullets'
	 Skins(1)=Shader'BallisticRecolorsTex.LK05.LK05-EOTechShader'
	 Skins(2)=Texture'BallisticRecolorsTex.LK05.LK05-Receiver'
	 Skins(3)=Texture'BallisticRecolorsTex.LK05.LK05-Grip'
	 Skins(4)=Texture'BallisticRecolorsTex.LK05.LK05-Grip'
	 Skins(5)=Texture'BallisticRecolorsTex.LK05.LK05-Stock'
	 Skins(6)=Texture'BallisticRecolorsTex.LK05.LK05-EOTech'
	 Skins(7)=Texture'BallisticRecolorsTex.LK05.LK05-Mag'
}
