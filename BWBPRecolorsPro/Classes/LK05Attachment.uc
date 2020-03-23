//=============================================================================
// 3rd person weapon class for LK-05 Carbine
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class LK05Attachment extends BallisticAttachment;

var	  BallisticWeapon		myWeap;
var() Material	InvisTex;

var bool		bSilenced;
var bool		bOldSilenced;

replication
{
	reliable if ( Role==ROLE_Authority )
		bSilenced;
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

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	SetBoneScale (0, 0.0, 'SantasFrozenSphinctre');
}

function InitFor(Inventory I)
{
	Super.InitFor(I);

	if (BallisticWeapon(I) != None)
		myWeap = BallisticWeapon(I);
}


defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
     AltMuzzleFlashClass=Class'BWBPRecolorsPro.LK05SilencedFlash'
     FlashMode=MU_Both 
     AltFlashBone="tip2"
     FlashScale=0.300000
     LightMode=MU_Primary	 
     ImpactManager=Class'BallisticProV55.IM_Bullet'	 
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassMode=MU_Both	 
     InstantMode=MU_Both
     TrackAnimMode=MU_None
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     TracerMode=MU_Primary	 
     TracerChance=0.500000
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     FlyByMode=MU_Both	 
     ReloadAnim="Reload_AR"
     ReloadAnimRate=1.200000
     Mesh=SkeletalMesh'BallisticRecolorsAnims.TP_LK05'
     RelativeRotation=(Pitch=32768)
     PrePivot=(X=1.000000,Z=-3.000000)
     DrawScale=0.325000	 
}
