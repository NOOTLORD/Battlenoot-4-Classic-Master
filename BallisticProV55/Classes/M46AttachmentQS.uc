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

var() vector		ScopedTracerOffset;

simulated function PlayPawnFiring(byte Mode)
{
	if ( xPawn(Instigator) == None )
		return;
	if (TrackAnimMode == MU_Both || (TrackAnimMode == MU_Primary && Mode == 0) || (TrackAnimMode == MU_Secondary && Mode != 0))
		PlayPawnTrackAnim(Mode);
	else
	{
		if (FiringMode == 0)
		{
			if (bIsAimed)
				xPawn(Instigator).StartFiring(False, bRapidFire);
			else
				xPawn(Instigator).StartFiring(True, bRapidFire);
		}
		else 
		{
			if (bIsAimed)
				xPawn(Instigator).StartFiring(False, bAltRapidFire);
			else
				xPawn(Instigator).StartFiring(True, bAltRapidFire);
		}
			SetTimer(WeaponLightTime, false);
	}
}

// Return the location of the muzzle.
simulated function Vector GetTipLocation()
{
    local Coords C;

	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		C = Instigator.Weapon.GetBoneCoords('tip');
	else
		C = GetBoneCoords('tip');
	if (Instigator != None && level.NetMode != NM_StandAlone && level.NetMode != NM_ListenServer && VSize(C.Origin - Instigator.Location) > 300)
		return Instigator.Location;
    return C.Origin;
}

defaultproperties
{
     ScopedTracerOffset=(Y=-14.000000,Z=-2.000000)
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
     TracerChance=0.500000	 
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
}
