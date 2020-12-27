//=============================================================================
// 3rd person weapon class for the SK410 Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class SK410Attachment extends BallisticShotgunAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55Recolors.SK410MuzzleFlash'	 
     FlashScale=1.200000	 
     ImpactManager=Class'BallisticProV55.IM_Shell'
     BrassClass=Class'BallisticProV55Recolors.Brass_SK410Shotgun' 
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'	 
     ReloadAnim="Reload_AR"
     ReloadAnimRate=0.900000
	 CockingAnim="Cock_RearPull"	 
     Mesh=SkeletalMesh'BallisticProRecolorsAnims.SK410_TP'
     RelativeRotation=(Pitch=32768)
     PrePivot=(X=1.000000,Z=-5.000000)
     DrawScale=0.200000	 
	 Skins(0)=Texture'BallisticProRecolorsTex.SK410.SK410-Lights'
	 Skins(1)=Texture'BallisticProRecolorsTex.SK410.SK410-Misc'
	 Skins(2)=Texture'BallisticProRecolorsTex.SK410.SK410-Main'
}
