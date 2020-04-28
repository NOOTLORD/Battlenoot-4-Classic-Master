//=============================================================================
// 3rd person weapon class for SK-410 Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class SK410Attachment extends BallisticShotgunAttachment;

defaultproperties
{
     FireClass=Class'BWBPRecolorsPro.SK410PrimaryFire'
     MuzzleFlashClass=Class'BWBPRecolorsPro.SK410HeatEmitter'
     FlashMode=MU_Primary 	 
     FlashScale=1.200000
     LightMode=MU_Primary		 
     ImpactManager=Class'BallisticProV55.IM_Shell'
     BrassClass=Class'BWBPRecolorsPro.Brass_SK410_Shotgun'
     BrassMode=MU_Primary 
     InstantMode=MU_Primary
     TrackAnimMode=MU_None	 
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     TracerMode=MU_Primary	 
     TracerChance=1.000000
     ReloadAnim="Reload_AR"
     ReloadAnimRate=0.900000
	 CockingAnim="Cock_RearPull"	 
     Mesh=SkeletalMesh'BallisticRecolorsAnims.SK410_TP'
     RelativeRotation=(Pitch=32768)
     DrawScale=0.200000
     PrePivot=(X=1.000000,Z=-5.000000)
}
