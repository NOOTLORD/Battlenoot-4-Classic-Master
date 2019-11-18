//=============================================================================
// Mk781Attachment.
//
// 3rd person weapon attachment for M781 Shotgun.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MK781Attachment extends BallisticShotgunAttachment;

var() class<BallisticShotgunFire>	FireClassAlt;
var() class<BCImpactManager>ImpactManagerAlt;		//Impact Manager to use for iATLATmpact effects
var() class<BCTraceEmitter>	TracerClassAlt;		//Type of tracer to use for alt fire effects
var bool		bSilenced;
var bool		bOldSilenced;

replication
{
	// Things the server should send to the client.
	reliable if(Role==ROLE_Authority)
		bSilenced;
}


simulated event PostNetReceive()
{
	if (bSilenced != bOldSilenced)
	{
		bOldSilenced = bSilenced;
		if (bSilenced)
			SetBoneScale (0, 1.0, 'Muzzle2');
		else
			SetBoneScale (0, 0.0, 'Muzzle2');
	}
	Super.PostNetReceive();
}

function SetSilenced(bool bIsSilenced)
{
	bSilenced = bIsSilenced;
	if (bSilenced)
		SetBoneScale (0, 1.0, 'Muzzle2');
	else
		SetBoneScale (0, 0.0, 'Muzzle2');
}

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	SetBoneScale (0, 0.0, 'Muzzle2');
}

// Do trace to find impact info and then spawn the effect
// This should be called from sub-classes
simulated function InstantFireEffects(byte Mode)
{
	local Vector HitLocation, Start, End;
	local Rotator R;
	local Material HitMat;
	local int i;
	local float XS, YS, RMin, RMax, Range, fX;

	if (Level.NetMode == NM_Client && FireClass != None && Mode == 0)
	{
		if (!bSilenced)
		{
			XS = FireClass.default.XInaccuracy; YS = Fireclass.default.YInaccuracy;
		}
		else
		{
			XS = 96; YS = 96;
		}
		if (!bScoped)
		{
			XS *= 5;
			YS *= 5;
		}
		RMin = FireClass.default.TraceRange.Min; RMax = FireClass.default.TraceRange.Max;
		Start = Instigator.Location + Instigator.EyePosition();
		for (i=0;i<FireClass.default.TraceCount;i++)
		{
			mHitActor = None;
			Range = Lerp(FRand(), RMin, RMax);
			R = Rotator(mHitLocation);
			switch (FireClass.default.FireSpreadMode)
			{
				case FSM_Scatter:
					fX = frand();
					R.Yaw +=   XS * (frand()*2-1) * sin(fX*1.5707963267948966);
					R.Pitch += YS * (frand()*2-1) * cos(fX*1.5707963267948966);
					break;
				case FSM_Circle:
					fX = frand();
					R.Yaw +=   XS * sin ((frand()*2-1) * 1.5707963267948966) * sin(fX*1.5707963267948966);
					R.Pitch += YS * sin ((frand()*2-1) * 1.5707963267948966) * cos(fX*1.5707963267948966);
					break;
				default:
					R.Yaw += ((FRand()*XS*2)-XS);
					R.Pitch += ((FRand()*YS*2)-YS);
					break;
			}
			End = Start + Vector(R) * Range;
			mHitActor = Trace (HitLocation, mHitNormal, End, Start, false,, HitMat);
			if (mHitActor == None)
			{
				DoWaterTrace(Start, End);
				SpawnTracer(Mode, End);
			}
			else
			{
				DoWaterTrace(Start, HitLocation);
				SpawnTracer(Mode, HitLocation);
			}

			if (mHitActor == None || (!mHitActor.bWorldGeometry && Mover(mHitActor) == None))
				continue;

			if (HitMat == None)
				mHitSurf = int(mHitActor.SurfaceType);
			else
				mHitSurf = int(HitMat.SurfaceType);

			if (ImpactManager != None)
				ImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, self);
		}
	}
	
	if (Level.NetMode == NM_Client && FireClassAlt != None && Mode == 1 && !bSilenced)
	{
		XS = FireClassAlt.default.XInaccuracy; YS = FireclassAlt.default.YInaccuracy;
		if (!bScoped)
		{
			XS *= 5;
			YS *= 5;
		}
		RMin = FireClassAlt.default.TraceRange.Min; RMax = FireClassAlt.default.TraceRange.Max;
		Start = Instigator.Location + Instigator.EyePosition();
		for (i=0;i<FireClassAlt.default.TraceCount;i++)
		{
			mHitActor = None;
			Range = Lerp(FRand(), RMin, RMax);
			R = Rotator(mHitLocation);
			switch (FireClassAlt.default.FireSpreadMode)
			{
				case FSM_Scatter:
					fX = frand();
					R.Yaw +=   XS * (frand()*2-1) * sin(fX*1.5707963267948966);
					R.Pitch += YS * (frand()*2-1) * cos(fX*1.5707963267948966);
					break;
				case FSM_Circle:
					fX = frand();
					R.Yaw +=   XS * sin ((frand()*2-1) * 1.5707963267948966) * sin(fX*1.5707963267948966);
					R.Pitch += YS * sin ((frand()*2-1) * 1.5707963267948966) * cos(fX*1.5707963267948966);
					break;
				default:
					R.Yaw += ((FRand()*XS*2)-XS);
					R.Pitch += ((FRand()*YS*2)-YS);
					break;
			}
			End = Start + Vector(R) * Range;
			mHitActor = Trace (HitLocation, mHitNormal, End, Start, false,, HitMat);
			if (mHitActor == None)
			{
				DoWaterTrace(Start, End);
				SpawnTracer(Mode, End);
			}
			else
			{
				DoWaterTrace(Start, HitLocation);
				SpawnTracer(Mode, HitLocation);
			}

			if (mHitActor == None || (!mHitActor.bWorldGeometry && Mover(mHitActor) == None))
				continue;

			if (HitMat == None)
				mHitSurf = int(mHitActor.SurfaceType);
			else
				mHitSurf = int(HitMat.SurfaceType);

			if (ImpactManagerAlt != None)
				ImpactManagerAlt.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, self);
		}
	}
	
}

// Spawn a tracer and water tracer
simulated function SpawnTracer(byte Mode, Vector V)
{
	local BCTraceEmitter Tracer;
	local Vector TipLoc, WLoc, WNorm;
	local float Dist;
	local bool bThisShot;

	if (Level.DetailMode < DM_High || class'BallisticMod'.default.EffectsDetailMode == 0)
		return;

	TipLoc = GetTipLocation();
	Dist = VSize(V - TipLoc);

	// Count shots to determine if it's time to spawn a tracer
	if (TracerMix == 0)
		bThisShot=true;
	else
	{
		TracerCounter++;
		if (TracerMix < 0)
		{
			if (TracerCounter >= -TracerMix)	{
				TracerCounter = 0;
				bThisShot=false;			}
			else
				bThisShot=true;
		}
		else if (TracerCounter >= TracerMix)	{
			TracerCounter = 0;
			bThisShot=true;					}
	}
	// Spawn a tracer
	if (TracerClass != None && TracerMode != MU_None && (TracerMode == MU_Both && Mode == 0) &&
		bThisShot && (TracerChance >= 1 || FRand() < TracerChance) && !bSilenced)
	{
		if (Dist > 200)
			Tracer = Spawn(TracerClass, self, , TipLoc, Rotator(V - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(Dist);
	}
	// Spawn an alt tracer
	if (TracerClassAlt != None && !bSilenced && TracerMode != MU_None && (TracerMode == MU_Both && Mode != 0) && (TracerChance >= 1 || FRand() < TracerChance))
	{
		if (Dist > 200)
			Tracer = Spawn(TracerClassAlt, self, , TipLoc, Rotator(V - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(Dist);
	}
	// Spawn under water bullet effect
	if ( Instigator != None && Instigator.PhysicsVolume.bWaterVolume && level.DetailMode == DM_SuperHigh && WaterTracerClass != None &&
		 WaterTracerMode != MU_None && (WaterTracerMode == MU_Both || (WaterTracerMode == MU_Secondary && Mode != 0) || (WaterTracerMode == MU_Primary && Mode == 0)))
	{
		if (!Instigator.PhysicsVolume.TraceThisActor(WLoc, WNorm, TipLoc, V))
			Tracer = Spawn(WaterTracerClass, self, , TipLoc, Rotator(WLoc - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(VSize(WLoc - TipLoc));
	}
}


simulated function FlashMuzzleFlash(byte Mode)
{
	if (FlashMode == MU_None || (FlashMode == MU_Secondary && Mode == 0) || (FlashMode == MU_Primary && Mode != 0))
		return;
	if (Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;

	if (Mode != 0 && AltMuzzleFlashClass != None)
	{
		if (AltMuzzleFlash == None)
			class'BUtil'.static.InitMuzzleFlash (AltMuzzleFlash, AltMuzzleFlashClass, DrawScale*0.6, self, AltFlashBone);
		AltMuzzleFlash.Trigger(self, Instigator);
	}
	else if (Mode == 0 && MuzzleFlashClass != None)
	{
		if (MuzzleFlash == None)
			class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, DrawScale*FlashScale, self, FlashBone);
		MuzzleFlash.Trigger(self, Instigator);
	}
}

// Return the location of the muzzle.
simulated function Vector GetTipLocation()
{
    local Coords C;
	
	if (!bSilenced)
		return Super.GetTipLocation();

	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		C = Instigator.Weapon.GetBoneCoords('tip2');
	else
		C = GetBoneCoords('tip2');
	if (Instigator != None && level.NetMode != NM_StandAlone && level.NetMode != NM_ListenServer && VSize(C.Origin - Instigator.Location) > 300)
		return Instigator.Location;
    return C.Origin;
}

defaultproperties
{
     FireClassAlt=Class'BWBPRecolorsPro.MK781SecondaryFire'
     ImpactManagerAlt=Class'BWBPRecolorsPro.IM_Supercharge'
     TracerClassAlt=Class'BWBPRecolorsPro.TraceEmitter_Supercharge'
     FireClass=Class'BWBPRecolorsPro.MK781PrimaryFire'
     MuzzleFlashClass=Class'BWBPRecolorsPro.MK781FlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     BrassClass=Class'BallisticProV55.Brass_Shotgun'
     BrassMode=MU_Both
     TracerMode=MU_Both
     InstantMode=MU_Both
     FlashMode=MU_Both
     LightMode=MU_Both
     TracerClass=Class'BWBPRecolorsPro.TraceEmitter_Flechette'
     Mesh=SkeletalMesh'BallisticRecolors4AnimProExp.TP_M1014'
     RelativeRotation=(Pitch=32768)
     DrawScale=0.500000
     PrePivot=(Z=-5.000000)
     Skins(0)=Texture'BallisticRecolors4TexPro.M1014.M1014-Misc'
     bSelected=True
}
