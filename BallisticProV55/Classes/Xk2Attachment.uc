//=============================================================================
// 3rd person weapon class for XK2 SubMachinegun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class XK2Attachment extends BallisticAttachment;

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	SetBoneScale (0, 0.0, 'Silencer');
}

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashMode=MU_Primary
     FlashScale=0.600000	 
     LightMode=MU_Primary	 
     FlashBone="Muzzle"
     ImpactManager=Class'BallisticProV55.IM_Bullet'	 
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassMode=MU_Primary
     InstantMode=MU_Primary
     TrackAnimMode=MU_None
     TracerClass=Class'BallisticProV55.TraceEmitter_Pistol'
     TracerMode=MU_Primary	 
     TracerChance=1.000000
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Primary
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     FlyByMode=MU_Primary
     ReloadAnim="Reload_AR"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.250000
     CockAnimRate=0.900000
     bRapidFire=True
     bAltRapidFire=True
     Mesh=SkeletalMesh'BallisticAnims2.Xk2_TP'
     DrawScale=0.125000
	 Skins(0)=Texture'BallisticWeapons2.XK2.XK2Skin'
	 Skins(1)=Texture'BallisticWeapons2.XK2.XK2Skin'
	 Skins(2)=Texture'BallisticWeapons2.XK2.XK2Skin'
}
