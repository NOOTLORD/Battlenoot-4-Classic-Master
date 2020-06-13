//=============================================================================
// 3rd person weapon class for SRS-600-Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class SRS600Attachment extends BallisticAttachment;

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	SetBoneScale (0, 0.0, 'Silencer');
}

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
     FlashMode=MU_Primary    
	 FlashScale=0.550000 
     LightMode=MU_Primary	 
     AltFlashBone="tip2"
     ImpactManager=Class'BallisticProV55.IM_Bullet'	 
     BrassClass=Class'BallisticProV55.Brass_Rifle'
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
     bRapidFire=True
     bAltRapidFire=True
     Mesh=SkeletalMesh'BallisticAnims1.SRS600_TP'
     DrawScale=0.240000
     Skins(0)=Texture'BallisticWeapons1.SRS600.SRS-600main'
     Skins(1)=Texture'BallisticWeapons1.SRS600.SRS600Ammo'
	 Skins(2)=FinalBlend'BallisticWeapons1.SRS600.SRS-HSight-FB'
	 Skins(3)=Shader'BallisticWeapons1.SRS600.SRS-SelfIllum'	 
}
