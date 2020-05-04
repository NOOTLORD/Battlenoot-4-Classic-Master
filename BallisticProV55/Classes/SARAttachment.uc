//=============================================================================
// 3rd person weapon class for Sub Assault Rifle
//
// 3rd person weapon attachment for SAR Assault
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class SARAttachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashMode=MU_Primary
     FlashScale=0.750000	 
     LightMode=MU_Primary	 
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     BrassClass=Class'BallisticProV55.Brass_SAR_Rifle'
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
     ReloadAnimRate=1.100000
     bHeavy=True
     bRapidFire=True
     bAltRapidFire=True
     Mesh=SkeletalMesh'BallisticAnims2.SAR_TP'
     DrawScale=0.085000
	 Skins(0)=Texture'BallisticWeapons2.SAR.SARSkin'
}
