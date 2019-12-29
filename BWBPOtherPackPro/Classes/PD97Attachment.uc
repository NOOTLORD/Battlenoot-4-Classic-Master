//=============================================================================
// PD97 Attachment.
//
// by Azarael
// adapting code by Nolan "Dark Carnivour" Richert
// Aspects of which are copyright (c) 2006 RuneStorm. All rights reserved.
//
// Edited by (NL)NOOTLORD 
//=============================================================================
class PD97Attachment extends HandgunAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_BigBullet'
     AltFlashBone="Tazer"
	 FlashScale=0.250000
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassMode=MU_None
     InstantMode=MU_None
     FlashMode=MU_Primary
     TracerClass=Class'BallisticProV55.TraceEmitter_Pistol'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_None
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_Pistol"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.400000
     Mesh=SkeletalMesh'BWBPOtherPackAnim.Bloodhound_TP'
     RelativeLocation=(Z=11.000000)
     DrawScale=0.200000
}
