//=============================================================================
// 3rd person weapon class for the M46 Rifle
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class M46Attachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.M46FlashEmitter'
     FlashScale=0.750000
     ImpactManager=Class'BallisticProV55.IM_Bullet'	 	 
     BrassClass=Class'BallisticProV55.Brass_M46Rifle'
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'	 
     ReloadAnim="Reload_AR"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.400000
     CockAnimRate=1.050000
     bRapidFire=True
	 bHeavy=True
     Mesh=SkeletalMesh'BallisticProAnims.M46_TP'
     DrawScale=0.225000
	 Skins(0)=Texture'BallisticProTex.M46.M46-Main'
	 Skins(1)=Texture'BallisticProTex.M46.M46-GrenadeLauncher'
	 Skins(2)=Texture'BallisticProTex.M46.M46-Clip'
	 Skins(3)=FinalBlend'BallisticProTex.M46.RDS-FB'
}
