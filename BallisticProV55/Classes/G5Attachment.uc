//=============================================================================
// 3rd person weapon class for the G5 bazooka
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class G5Attachment extends BallisticAttachment;

var   bool			bLaserOn;		//Is laser currently active
var   bool			bOldLaserOn;	//Old bLaserOn
var   LaserActor	Laser;			//The laser actor
var   vector		LaserEndLoc;
var   Emitter		LaserDot;

replication
{
	reliable if ( Role==ROLE_Authority )
		bLaserOn;
	unreliable if ( Role==ROLE_Authority && !bNetOwner )
		LaserEndLoc;
}

simulated function KillLaserDot()
{
	if (LaserDot != None)
	{
		LaserDot.Kill();
		LaserDot = None;
	}
}
simulated function SpawnLaserDot(optional vector Loc)
{
	if (LaserDot == None)
		LaserDot = Spawn(class'G5LaserDot',,,Loc);
	laserDot.bHidden=false;
}

simulated function Tick(float DT)
{
	local Vector Scale3D, Loc;

	Super.Tick(DT);

	if (Level.NetMode == NM_DedicatedServer)
		return;

	if (Laser == None)
		Laser = Spawn(class'LaserActor_G5Painter',,,Location);

	if (bLaserOn != bOldLaserOn)
		bOldLaserOn = bLaserOn;

	if (!bLaserOn || Instigator == None || Instigator.IsFirstPerson() || Instigator.DrivenVehicle != None)
	{
		if (!Laser.bHidden)
			Laser.bHidden = true;
		KillLaserDot();
		return;
	}
	else
	{
		if (Laser.bHidden)
			Laser.bHidden = false;
		SpawnLaserDot();
	}

	if (LaserDot != None)
		LaserDot.SetLocation(LaserEndLoc);

	Loc = GetTipLocation();

	Laser.SetLocation(Loc);
	Laser.SetRotation(Rotator(LaserEndLoc - Loc));
//	Laser.SetRelativeRotation(Rotator(HitLocation - Loc) - GetBoneRotation('tip'));
	Scale3D.X = VSize(LaserEndLoc-Laser.Location)/128;
	Scale3D.Y = 1.5;
	Scale3D.Z = 1.5;
	Laser.SetDrawScale3D(Scale3D);
}

simulated function Destroyed()
{
	if (LaserDot != None)
		LaserDot.Destroy();
	if (Laser != None)
		Laser.Destroy();
	Super.Destroyed();
}

// This assumes flash actors are triggered to make them work
// Override this in subclassed for better control
simulated function FlashMuzzleFlash(byte Mode)
{
	if (Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;

	if (AltMuzzleFlashClass != None)
	{
		if (AltMuzzleFlash == None)
		{	// Spawn, Attach, Scale, Initialize emitter flashes
			AltMuzzleFlash = Spawn(AltMuzzleFlashClass, self);
			if (Emitter(AltMuzzleFlash) != None)
				class'BallisticEmitter'.static.ScaleEmitter(Emitter(AltMuzzleFlash), DrawScale*FlashScale);
			AltMuzzleFlash.SetDrawScale(DrawScale*FlashScale);
			if (DGVEmitter(AltMuzzleFlash) != None)
				DGVEmitter(AltMuzzleFlash).InitDGV();
			AttachToBone(AltMuzzleFlash, 'tip2');
		}
		AltMuzzleFlash.Trigger(self, Instigator);
	}
	if (MuzzleFlashClass != None)
	{	// Spawn, Attach, Scale, Initialize emitter flashes
		if (MuzzleFlash == None)
		{
			MuzzleFlash = Spawn(MuzzleFlashClass, self);
			if (Emitter(MuzzleFlash) != None)
				class'BallisticEmitter'.static.ScaleEmitter(Emitter(MuzzleFlash), DrawScale*FlashScale);
			MuzzleFlash.SetDrawScale(DrawScale*FlashScale);
			if (DGVEmitter(MuzzleFlash) != None)
				DGVEmitter(MuzzleFlash).InitDGV();
			AttachToBone(MuzzleFlash, 'tip');
		}
		MuzzleFlash.Trigger(self, Instigator);
	}
}

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.G5BackFlashEmitter'
     FlashScale=1.000000		 	
     AltFlashBone="tip2"	 
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     BrassMode=MU_None
     InstantMode=MU_None 
	 ReloadAnim="Reload_MG"
	 ReloadAnimRate=1.500000						 
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticProAnims.G5_TP'
     DrawScale=0.230000
	 Skins(0)=Texture'BallisticProTex.G5.G5-Main'
	 Skins(1)=Texture'BallisticProTex.G5.G5-Main'
	 Skins(2)=Texture'BallisticProTex.G5.G5-Main'
	 Skins(3)=Texture'BallisticProTex.G5.G5-Rocket'
	 Skins(4)=Texture'BallisticProTex.G5.G5-Misc'
	 Skins(5)=Texture'BallisticProTex.G5.G5-Scope'
	 Skins(6)=Texture'BallisticProTex.G5.G5-Scope'
}
