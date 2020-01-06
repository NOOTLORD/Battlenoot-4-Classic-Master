//=============================================================================
// M925Attachment.
//
// 3rd person weapon attachment for M925 Machinegun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M925Attachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     BrassClass=Class'BallisticProV55.Brass_BigMG'
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_MG"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.550000
     CockAnimRate=1.400000
     bHeavy=True
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticAnims2.M925-3rd'
     DrawScale=0.120000
}
