//=============================================================================
// Fifty9Attachment.
//
// 3rd person weapon attachment for the Fifty 9
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class Fifty9Attachment extends HandgunAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.Fifty9FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     FlashBone="Muzzle"
     AltFlashBone="Muzzle"
     FlashScale=0.800000
     BrassClass=Class'BallisticProV55.Brass_Uzi'
     TrackAnimMode=MU_Secondary
     TracerClass=Class'BallisticProV55.TraceEmitter_FiftyNine'
     TracerChance=0.500000
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_AR"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.400000
     CockAnimRate=1.250000
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticAnims2.Fifty9-3rd'
     DrawScale=0.190000
}
