//=============================================================================
// 3rd person weapon class for the F2000 Assault Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class F2000Attachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BWBPRecolorsPro.MARSFlashEmitter'
     FlashMode=MU_Primary	 
     FlashBone="tip"
     FlashScale=0.125000
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
     ReloadAnimRate=0.900000
	 CockingAnim="Cock_RearPull"							 
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticRecolorsAnims.F2000_TP'
     DrawScale=0.825000
	 Skins(0)=Texture'BallisticRecolorsTex.MARS.F2000-IronArctic'
	 Skins(1)=Texture'BallisticRecolorsTex.MARS.F2000-MiscIce'
	 Skins(2)=Texture'BallisticRecolorsTex.MARS.LK05-EOTech-Ice'
}
