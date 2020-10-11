//=============================================================================
// 3rd person weapon class for the M925 Machinegun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class M925Attachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
     FlashMode=MU_Primary
     FlashScale=0.650000 
     LightMode=MU_Primary
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     BrassClass=Class'BallisticProV55.Brass_BigMG'
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
     ReloadAnim="Reload_MG"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.550000
     CockAnimRate=1.400000
     bHeavy=True
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticAnims2.M925_TP'
     DrawScale=0.110000
	 Skins(0)=Texture'BallisticWeapons2.M925.M925Main'
	 Skins(1)=Texture'BallisticWeapons2.M925.M925Small'
	 Skins(2)=Texture'BallisticWeapons2.M925.M925HeatShield'
	 Skins(3)=Texture'BallisticWeapons2.M925.M925AmmoBox'
	 Skins(4)=Texture'BallisticWeapons2.M925.M925Main'
	 Skins(5)=Texture'BallisticWeapons2.M925.M925Main'
	 Skins(6)=Texture'BallisticWeapons2.M925.M925Small'
}
