//=============================================================================
// 3rd person weapon class for AK-470 Assault Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class AK47Attachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashMode=MU_Primary	 
     FlashScale=0.250000	
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
     ReloadAnimRate=0.800000
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticRecolorsAnims.AK490_TP'
     RelativeRotation=(Pitch=32768)
     DrawScale=0.265000
	 Skins(0)=Texture'BallisticRecolorsTex.AK490.AK490-Misc'
	 Skins(1)=Texture'BallisticRecolorsTex.AK490.AK490-Main'
}
