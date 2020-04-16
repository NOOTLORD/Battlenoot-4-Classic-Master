//=============================================================================
// 3rd person weapon class for SKAS-21 Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class SKASAttachment extends BallisticShotgunAttachment;

defaultproperties
{
     FireClass=Class'BWBPRecolorsPro.SKASPrimaryFire'													 
     MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
     FlashMode=MU_Primary 	 
     FlashScale=2.500000
     LightMode=MU_Primary		 
     ImpactManager=Class'BallisticProV55.IM_Shell'
     BrassClass=Class'BallisticProV55.Brass_MRS138_Shotgun'
     BrassMode=MU_Primary
     InstantMode=MU_Primary
     TrackAnimMode=MU_None
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     TracerMode=MU_Primary	 
     TracerChance=0.500000
     ReloadAnim="Reload_AR"
     ReloadAnimRate=0.950000
     Mesh=SkeletalMesh'BallisticRecolorsAnims.SKAS_TP'
     RelativeLocation=(X=-2.000000,Z=7.000000)
     RelativeRotation=(Pitch=32768)
     DrawScale=0.115000
}
