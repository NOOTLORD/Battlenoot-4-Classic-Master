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
     FireClass=Class'BWBPRecolorsPro.SK410PrimaryFire'
     MuzzleFlashClass=Class'BWBPRecolorsPro.SK410HeatEmitter'
     ImpactManager=Class'BWBPRecolorsPro.IM_ShellHE'
     MeleeImpactManager=Class'BallisticProV55.IM_GunHit'
     FlashScale=1.250000
     BrassClass=Class'BWBPRecolorsPro.Brass_ShotgunHE'
     TracerMode=MU_None
     TracerClass=Class'BWBPRecolorsPro.TraceEmitter_ShotgunHE'
     TracerChance=0.500000
     ReloadAnim="Reload_AR"
     ReloadAnimRate=0.900000
     Mesh=SkeletalMesh'BallisticRecolors4AnimPro.SK410Third'
     RelativeRotation=(Pitch=32768)
     DrawScale=0.200000
     PrePivot=(X=1.000000,Z=-5.000000)
}
