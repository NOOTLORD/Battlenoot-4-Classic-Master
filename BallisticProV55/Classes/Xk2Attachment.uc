//=============================================================================
// 3rd person weapon class for XK2 SubMachinegun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class XK2Attachment extends BallisticAttachment;

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
     FlashScale=0.600000	 
     LightMode=MU_Primary	 
     FlashBone="Muzzle"
     AltFlashBone="Muzzle2" 
     ImpactManager=Class'BallisticProV55.IM_Bullet'	 
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassMode=MU_Both
     InstantMode=MU_Both
     TrackAnimMode=MU_None
     TracerClass=Class'BallisticProV55.TraceEmitter_Pistol'
     TracerMode=MU_Primary	 
     TracerChance=0.500000
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     FlyByMode=MU_Primary
     ReloadAnim="Reload_AR"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.250000
     CockAnimRate=0.900000
     bRapidFire=True
     bAltRapidFire=True
     Mesh=SkeletalMesh'BallisticAnims2.Xk2-3rd'
     DrawScale=0.125000
}
