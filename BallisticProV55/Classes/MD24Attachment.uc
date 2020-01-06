//=============================================================================
// MD24Attachment.
//
// 3rd person weapon attachment for MD24 Pistol
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class MD24Attachment extends HandgunAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     FlashBone="Muzzle"
     AltFlashBone="Muzzle"
     FlashScale=0.200000
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     InstantMode=MU_Primary
     TrackAnimMode=MU_None
     TracerClass=Class'BallisticProV55.TraceEmitter_Pistol'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_Pistol"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.400000
     CockAnimRate=0.800000
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticAnims_25.MD24_3rd'
     DrawScale=0.320000
     bSelected=True
}
