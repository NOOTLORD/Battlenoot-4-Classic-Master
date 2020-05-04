//=============================================================================
// 3rd person weapon class for M46 Assault Rifle
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class M46AttachmentQS extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.M46FlashEmitter'
     FlashMode=MU_Primary 
     FlashScale=0.750000	 
     LightMode=MU_Primary	 
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     BrassClass=Class'BallisticProV55.Brass_M46_Rifle'
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
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.400000
     CockAnimRate=1.050000
     bRapidFire=True
	 bHeavy=True
     Mesh=SkeletalMesh'BallisticAnims1.M46_TP'
     DrawScale=0.225000
	 Skins(0)=Texture'BallisticWeapons1.OA-AR.OA-AR_Main'
	 Skins(1)=Texture'BallisticWeapons1.OA-AR.OA-AR_GrenadeLauncher'
	 Skins(2)=Texture'BallisticWeapons1.OA-AR.OA-AR_Clip'
	 Skins(3)=FinalBlend'BallisticWeapons1.OA-AR.RDS_FB'
}
