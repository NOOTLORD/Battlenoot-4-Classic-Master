//=============================================================================
// RS8Attachment.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class RS8Attachment extends HandgunAttachment;

simulated event ThirdPersonEffects()
{
    if ( Level.NetMode != NM_DedicatedServer && Instigator != None)
	{
		if (FiringMode == 1)
			SetBoneScale (0, 1.0, 'Silencer');
		else
			SetBoneScale (0, 0.0, 'Silencer');
    }
	super.ThirdPersonEffects();
}

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
     FlashMode=MU_Both 
     FlashScale=0.500000	 
     LightMode=MU_Primary	 
     FlashBone="tip"
     AltFlashBone="tip2"
	 ImpactManager=Class'BallisticProV55.IM_Bullet'
     BrassClass=Class'BallisticProV55.Brass_Pistol'
	 BrassMode=MU_Both
     InstantMode=MU_Both
     TrackAnimMode=MU_None
     TracerMode=MU_Primary
     TracerClass=Class'BallisticProV55.TraceEmitter_Pistol'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     FlyByMode=MU_Primary	 
     ReloadAnim="Reload_Pistol"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.400000
     bRapidFire=True
     bAltRapidFire=True
     Mesh=SkeletalMesh'BWBP1-Anims.RS8-3rd'
     DrawScale=0.150000
}
