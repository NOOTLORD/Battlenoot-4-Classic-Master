//=============================================================================
// 3rd person weapon attachment for SKAS-21 Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class SKASAttachment extends BallisticShotgunAttachment;

simulated function FlashMuzzleFlash(byte Mode)
{
	local rotator R;

	if (FlashMode == MU_None || (FlashMode == MU_Secondary && Mode == 0) || (FlashMode == MU_Primary && Mode != 0))
		return;
	if (Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;

	if (AltMuzzleFlashClass != None && AltMuzzleFlash == None)
		class'BUtil'.static.InitMuzzleFlash (AltMuzzleFlash, AltMuzzleFlashClass, DrawScale*FlashScale, self, AltFlashBone);
	if (MuzzleFlashClass != None && MuzzleFlash == None)
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, DrawScale*FlashScale, self, FlashBone);
		
	R = Instigator.Rotation;
	R.Pitch = Rotation.Pitch;
	
	if (Mode == 0 || Mode == 1)
	{
		MuzzleFlash.Trigger(self, Instigator);
	}

}

function SKASUpdateHit(Actor HitActor, vector HitLocation, vector HitNormal, int HitSurf, optional bool bIsRight)
{
	mHitNormal = HitNormal;
	mHitActor = HitActor;
	mHitLocation = HitLocation;
	if (bIsRight)
		FiringMode = 2;
	else
		FiringMode = 1;
	FireCount++;
	ThirdPersonEffects();
}

defaultproperties
{
     FireClass=Class'BWBPRecolorsPro.SKASPrimaryFire'													 
     MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'	 
     FlashMode=MU_Primary 	 
     FlashScale=2.000000
     LightMode=MU_Primary		 
     ImpactManager=Class'BallisticProV55.IM_Shell'	 
     BrassClass=Class'BallisticProV55.Brass_MRS138Shotgun'
     BrassMode=MU_Primary
     InstantMode=MU_Primary
     TrackAnimMode=MU_None
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     TracerMode=MU_Primary	 
     TracerChance=0.500000
     ReloadAnim="Reload_AR"
     ReloadAnimRate=0.950000
     Mesh=SkeletalMesh'BallisticRecolors4AnimPro.3RD-SKAS'
     RelativeLocation=(X=-2.000000,Z=7.000000)
     RelativeRotation=(Pitch=32768)
     DrawScale=0.130000
}
