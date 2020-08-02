//=============================================================================
// 3rd person weapon class for the XMK5 SubMachinegun
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class XMK5Attachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashMode=MU_Primary 
     FlashScale=0.200000 
     FlashBone="tip"	 
	 LightMode=MU_Primary
     ImpactManager=Class'BallisticProV55.IM_Bullet'	 
     BrassClass=Class'BallisticProV55.Brass_XMK5_SMG'
     BrassMode=MU_Primary	
     InstantMode=MU_Primary
     TrackAnimMode=MU_None	 
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     TracerMode=MU_Primary	 
     TracerChance=1.000000
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Primary	 
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     FlyByMode=MU_Primary
     ReloadAnim="Reload_AR"
     ReloadAnimRate=1.250000
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticAnims1.XMK5_TP'
     DrawScale=0.275000
	 Skins(0)=Texture'BallisticWeapons1.OA-SMG.OA-SMG_Shield'
	 Skins(1)=Texture'BallisticWeapons1.OA-SMG.OA-SMG_Main'
	 Skins(2)=Texture'BallisticWeapons1.OA-SMG.OA-SMG_Clip'
	 Skins(3)=FinalBlend'BallisticWeapons1.OA-SMG.OA-SMG_SightFB'
}
