//=============================================================================
// 3rd person weapon class for F2000 Assault Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class F2000Attachment extends BallisticAttachment;

var	  BallisticWeapon		myWeap;
var Vector		SpawnOffset;

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	SetBoneScale (0, 0.0, 'SilencerBone');
}

simulated function Vector GetTipLocation()
{
    local Vector X, Y, Z, Loc;

	if (Instigator.IsFirstPerson())
	{
		if (F2000AssaultRifle(Instigator.Weapon).bScopeView)
		{
			Instigator.Weapon.GetViewAxes(X,Y,Z);
			Loc = Instigator.Location + Instigator.EyePosition() + X*20 + Z*-10;
		}
		else
			Loc = Instigator.Weapon.GetBoneCoords('tip').Origin + class'BUtil'.static.AlignedOffset(Instigator.GetViewRotation(), SpawnOffset);
	}
	else
		Loc = GetBoneCoords('tip').Origin;
	if (VSize(Loc - Instigator.Location) > 200)
		return Instigator.Location;
    return Loc;
}


function InitFor(Inventory I)
{
	Super.InitFor(I);

	if (BallisticWeapon(I) != None)
		myWeap = BallisticWeapon(I);
}

defaultproperties
{
     MuzzleFlashClass=Class'BWBPRecolorsPro.MARSFlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
     FlashMode=MU_Both	 
     FlashBone="tip2"
     AltFlashBone="tip2"
     FlashScale=0.150000
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
     ReloadAnimRate=0.900000
	 CockingAnim="Cock_RearPull"							 
     bRapidFire=True
     bAltRapidFire=True
     Mesh=SkeletalMesh'BallisticRecolorsAnims.F2000_TP'
     DrawScale=0.825000
}
