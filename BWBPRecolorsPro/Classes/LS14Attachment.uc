//=============================================================================
// LS14Attachment.
//
// Third person actor for the LS-14 Laser Carbine.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class LS14Attachment extends BallisticAttachment;
var Vector		SpawnOffset;
var byte 		LasPower;
var bool			bDouble, FireIndex;

replication
{
	reliable if (bNetDirty && Role==Role_Authority)
		LasPower, bDouble;
}

simulated function SpawnTracer(byte Mode, Vector V)
{
	local TraceEmitter_LS14C TER;
	local TraceEmitter_LS14B TEL;
	local TraceEmitter_LS14B TEA;
	local float Dist;

	if (VSize(V) < 2)
		V = Instigator.Location + Instigator.EyePosition() + V * 10000;
	Dist = VSize(V-GetTipLocation());

	// Spawn Trace Emitter Effect
	if (bDouble)
	{
		TER = Spawn(class'TraceEmitter_LS14C', self, , GetTipLocation(), Rotator(V - GetTipLocation()));
		TEL = Spawn(class'TraceEmitter_LS14B', self, , GetTipLocationStyleTwo(), Rotator(V - GetTipLocation()));
		TEL.Initialize(Dist, LasPower);
		TER.Initialize(Dist, LasPower);
	}	
	else if (FireIndex)
	{
		TEA = Spawn(class'TraceEmitter_LS14B', self, , GetTipLocation(), Rotator(V - GetTipLocation()));
		TEA.Initialize(Dist, LasPower);
	}
	else
	{
		TER = Spawn(class'TraceEmitter_LS14C', self, , GetTipLocationStyleTwo(), Rotator(V - GetTipLocation()));
		TER.Initialize(Dist, LasPower);
	}
	
	FireIndex = !FireIndex;
}

simulated function Vector GetTipLocation()
{
    local Vector X, Y, Z, Loc;

	if (Instigator.IsFirstPerson())
	{

		if (LS14Carbine(Instigator.Weapon).bScopeView)
		{
			Instigator.Weapon.GetViewAxes(X,Y,Z);
				Loc = Instigator.Location + Instigator.EyePosition() + X*20 + Z*-10;
		}
		else
		{
			Loc = Instigator.Weapon.GetBoneCoords('tip').Origin + class'BUtil'.static.AlignedOffset(Instigator.GetViewRotation(), SpawnOffset);
		}
	}
	else
		Loc = GetBoneCoords('tip').Origin;
	if (VSize(Loc - Instigator.Location) > 200)
		return Instigator.Location;
    return Loc;
}

simulated function Vector GetTipLocationStyleTwo()
{
    local Vector X, Y, Z, Loc;

	if (Instigator.IsFirstPerson())
	{

		if (LS14Carbine(Instigator.Weapon).bScopeView)
		{
			Instigator.Weapon.GetViewAxes(X,Y,Z);
			Loc = Instigator.Location + Instigator.EyePosition() + X*20 + Z*-10;
		}
		else
			Loc = Instigator.Weapon.GetBoneCoords('tip2').Origin + class'BUtil'.static.AlignedOffset(Instigator.GetViewRotation(), SpawnOffset);
	}
	else
		Loc = GetBoneCoords('tip2').Origin + Y*200;
	if (VSize(Loc - Instigator.Location) > 200)
		return Instigator.Location;
    return Loc;
}

simulated function EjectBrass(byte Mode);

defaultproperties
{
     SpawnOffset=(X=-30.000000)
     MuzzleFlashClass=Class'BWBPRecolorsPro.GRSXXLaserFlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
     ImpactManager=Class'BWBPRecolorsPro.IM_LS14Impacted'
     AltFlashBone="tip3"
     BrassClass=Class'BallisticProV55.Brass_Railgun'
     FlashMode=MU_Both
     LightMode=MU_Both
     TracerClass=Class'BWBPRecolorsPro.TraceEmitter_LS14C'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=Sound'PackageSounds4Pro.LS14.Gauss-FlyBy',Volume=0.700000)
     FlyByBulletSpeed=-1.000000
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticRecolors4AnimPro.3RD-LS14'
     RelativeLocation=(X=-3.000000,Z=2.000000)
     RelativeRotation=(Pitch=32768)
     DrawScale=0.200000
}
