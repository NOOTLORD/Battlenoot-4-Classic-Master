//=============================================================================
// SK410Attachment.
//
// 3rd person weapon attachment for SK410 Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Edited by (NL)NOOTLORD
//=============================================================================
class SK410Attachment extends BallisticShotgunAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BWBPRecolorsPro.SK410HeatEmitter'
     FlashMode=MU_Primary 	 
     FlashScale=1.200000
     ImpactManager=Class'BallisticProV55.IM_Shell'	 
     BrassClass=Class'BWBPRecolorsPro.Brass_ShotgunHE'
     BrassMode=MU_Primary 
     InstantMode=MU_Primary
     LightMode=MU_Primary
     TrackAnimMode=MU_None	 
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     TracerMode=MU_Primary	 
     TracerChance=0.500000
     ReloadAnim="Reload_AR"
     ReloadAnimRate=0.900000
     Mesh=SkeletalMesh'BallisticRecolors4AnimPro.SK410Third'
     RelativeRotation=(Pitch=32768)
     DrawScale=0.200000
     PrePivot=(X=1.000000,Z=-5.000000)
}
