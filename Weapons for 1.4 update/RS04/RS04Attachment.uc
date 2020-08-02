//=============================================================================
// 3rd person weapon class for the RS04 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class RS04Attachment extends HandgunAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashMode=MU_Primary 
     FlashScale=0.425000	 
     LightMode=MU_Primary	 
     FlashBone="tip"	 
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     BrassClass=Class'BallisticProV55.Brass_Pistol'
	 BrassMode=MU_Primary
     InstantMode=MU_Primary
     TrackAnimMode=MU_None
     TracerMode=MU_Primary
     TracerClass=Class'BallisticProV55.TraceEmitter_Pistol'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Primary
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     FlyByMode=MU_Primary	 
     ReloadAnim="Reload_Pistol"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.400000
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticAnims2.RS04_TP'
     RelativeRotation=(Pitch=32768)
	 PrePivot=(Z=-2.000000)
     DrawScale=0.210000
	 Skins(0)=Texture'BallisticWeapons2.RS04.RS04-Main'
}
