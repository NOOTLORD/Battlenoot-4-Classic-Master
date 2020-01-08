//=============================================================================
// Fifty9Attachment.
//
// 3rd person weapon attachment for the Fifty 9
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class Fifty9Attachment extends HandgunAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.Fifty9FlashEmitter'
     FlashMode=MU_Primary 
     FlashScale=0.800000	 
     LightMode=MU_Primary	
     FlashBone="Muzzle"
     AltFlashBone="Muzzle"	 
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     BrassClass=Class'BallisticProV55.Brass_Uzi'
     BrassMode=MU_Primary
     InstantMode=MU_Primary
     TrackAnimMode=MU_None	 
     TracerClass=Class'BallisticProV55.TraceEmitter_FiftyNine'
     TracerMode=MU_Primary	 
     TracerChance=0.500000
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Primary	 
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     FlyByMode=MU_Primary	 
     ReloadAnim="Reload_AR"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.400000
     CockAnimRate=1.250000
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticAnims2.Fifty9-3rd'
     DrawScale=0.190000
}
