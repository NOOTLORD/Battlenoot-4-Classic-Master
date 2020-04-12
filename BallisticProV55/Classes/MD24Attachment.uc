//=============================================================================
// 3rd person weapon class for MD24 Pistol
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class MD24Attachment extends HandgunAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashMode=MU_Primary  
     FlashScale=0.200000
     LightMode=MU_Primary
     FlashBone="Muzzle"
     AltFlashBone="Muzzle"	 
     ImpactManager=Class'BallisticProV55.IM_Bullet'	 
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassMode=MU_Primary
     InstantMode=MU_Primary
     TrackAnimMode=MU_None
     TracerClass=Class'BallisticProV55.TraceEmitter_Pistol'
     TracerMode=MU_Primary
     TracerChance=1.000000	 
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Primary	 
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     FlyByMode=MU_Primary 
     ReloadAnim="Reload_Pistol"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.400000
     CockAnimRate=0.800000
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticAnims1.MD24_TP'
     DrawScale=0.250000
}

