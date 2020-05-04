//=============================================================================
// 3rd person weapon class for LK-05 Carbine
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class LK05Attachment extends BallisticAttachment;

var() Material	InvisTex;

var bool		bSilenced;
var bool		bOldSilenced;

replication
{
	reliable if ( Role==ROLE_Authority )
		bSilenced;
}

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	SetBoneScale (0, 0.0, 'SantasFrozenSphinctre');
}

simulated event PostNetReceive()
{
	if (bSilenced != bOldSilenced)
	{
		bOldSilenced = bSilenced;
		if (bSilenced)
			SetBoneScale (0, 1.0, 'SantasFrozenSphinctre');
		else
			SetBoneScale (0, 0.0, 'SantasFrozenSphinctre');
	}
	Super.PostNetReceive();
}

function IAOverride(bool bSilenced)
{
	if (bSilenced)
		SetBoneScale (0, 1.0, 'SantasFrozenSphinctre');
	else
		SetBoneScale (0, 0.0, 'SantasFrozenSphinctre');
}

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
     AltMuzzleFlashClass=Class'BWBPRecolorsPro.LK05SilencedFlash'
     FlashMode=MU_Both 
     AltFlashBone="tip2"
     FlashScale=1.750000
     LightMode=MU_Primary	 
     ImpactManager=Class'BallisticProV55.IM_Bullet'	 
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassMode=MU_Both	 
     InstantMode=MU_Both
     TrackAnimMode=MU_None
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     TracerMode=MU_Primary	 
     TracerChance=1.000000
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     FlyByMode=MU_Both	 
     ReloadAnim="Reload_AR"
     ReloadAnimRate=1.200000
     Mesh=SkeletalMesh'BallisticRecolorsAnims.LK05_TP'
     RelativeRotation=(Pitch=32768)
     PrePivot=(X=1.000000,Z=-3.000000)
     DrawScale=0.080000	
	 Skins(0)=Texture'BallisticRecolorsTex.LK05.LK05-Silencer'
	 Skins(1)=Texture'BallisticRecolorsTex.LK05.LK05-Bullets'
	 Skins(2)=Shader'BallisticRecolorsTex.LK05.LK05-EOTechShader'
	 Skins(3)=Texture'BallisticRecolorsTex.LK05.LK05-Receiver'
	 Skins(4)=Texture'BallisticRecolorsTex.LK05.LK05-Grip'
	 Skins(5)=Texture'BallisticRecolorsTex.LK05.LK05-Grip'
	 Skins(6)=Texture'BallisticRecolorsTex.LK05.LK05-Stock'
	 Skins(7)=Texture'BallisticRecolorsTex.LK05.LK05-EOTech'
	 Skins(8)=Texture'BallisticRecolorsTex.LK05.LK05-Mag'
}
