//=============================================================================
// R78PrimaryFire.
//
// Very accurate, long ranged and powerful bullet fire. Headshots are
// especially dangerous.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class R78PrimaryFire extends BallisticProInstantFire;

// This is called to DoDamage to an actor found by this fire.
// Adjusts damage based on Range, Penetrates, WallPenetrates, relative velocities and runs Hurt() to do the deed...
function DoDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount, optional vector WaterHitLocation)
{
	Super.DoDamage(Other, HitLocation, TraceStart, Dir, PenetrateCount, WallCount, WaterHitLocation);
	
	if (Other.bProjTarget)
		BW.TargetedHurtRadius(Damage, 420, class'DTR78Explosion', 200, HitLocation, Pawn(Other));
}

// Do the trace to find out where bullet really goes
function DoTrace (Vector InitialStart, Rotator Dir)
{
	local int						PenCount, WallCount;
	local Vector					End, X, HitLocation, HitNormal, Start, WaterHitLoc, LastHitLoc, ExitNormal;
	local Material					HitMaterial, ExitMaterial;
	local float						Dist;
	local Actor						Other, LastOther;
	local bool						bHitWall;

	// Work out the range
	Dist = TraceRange.Min + FRand() * (TraceRange.Max - TraceRange.Min);

	Start = InitialStart;
	X = Normal(Vector(Dir));
	End = Start + X * Dist;
	LastHitLoc = End;
	Weapon.bTraceWater=true;

	while (Dist > 0)		// Loop traces in case we need to go through stuff
	{
		// Do the trace
		Other = Trace (HitLocation, HitNormal, End, Start, true, , HitMaterial);
		Weapon.bTraceWater=false;
		Dist -= VSize(HitLocation - Start);
		if (Level.NetMode == NM_Client && (Other.Role != Role_Authority || Other.bWorldGeometry))
			break;
		if (Other != None)
		{
			// Water
			if ( (FluidSurfaceInfo(Other) != None) || ((PhysicsVolume(Other) != None) && PhysicsVolume(Other).bWaterVolume) )
			{
				if (VSize(HitLocation - Start) > 1)
					WaterHitLoc=HitLocation;
				Start = HitLocation;
				Dist *= WaterRangeFactor;
				End = Start + X * Dist;
				Weapon.bTraceWater=false;
				continue;
			}

			LastHitLoc = HitLocation;
				
			// Got something interesting
			if (!Other.bWorldGeometry && Other != LastOther)
			{				
				DoDamage(Other, HitLocation, InitialStart, X, PenCount, WallCount, WaterHitLoc);
			
				LastOther = Other;

				if (CanPenetrate(Other, HitLocation, X, PenCount))
				{
					PenCount++;
					Start = HitLocation + (X * Other.CollisionRadius * 2);
					End = Start + X * Dist;
					Weapon.bTraceWater=true;
					if (Vehicle(Other) != None)
						HitVehicleEffect (HitLocation, HitNormal, Other);
					continue;
				}
				else if (Pawn(Other) != None)
				{
					bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other, WaterHitLoc);
					break;
				}
				else if (Mover(Other) == None)
					break;
			}
			// Do impact effect
			if (Other.bWorldGeometry || Mover(Other) != None)
			{
				WallCount++;
				if (WallCount <= MaxWalls && MaxWallSize > 0 && GoThroughWall(Other, HitLocation, HitNormal, MaxWallSize * ScaleBySurface(Other, HitMaterial), X, Start, ExitNormal, ExitMaterial))
				{
					WallPenetrateEffect(Other, HitLocation, HitNormal, HitMaterial);
					WallPenetrateEffect(Other, Start, ExitNormal, ExitMaterial, true);
					Weapon.bTraceWater=true;
					continue;
				}
				bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other, WaterHitLoc);
				break;
			}
			// Still in the same guy
			if (Other == Instigator || Other == LastOther)
			{
				Start = HitLocation + (X * FMax(32, Other.CollisionRadius * 2));
				End = Start + X * Dist;
				Weapon.bTraceWater=true;
				continue;
			}
			break;
		}
		
		//
		else
		{
			LastHitLoc = End;
			break;
		}
	}
	
	// Never hit a wall, so just tell the attachment to spawn muzzle flashes and play anims, etc
	if (!bHitWall)
		NoHitEffect(X, InitialStart, LastHitLoc, WaterHitLoc);
}

// Does something to make the effects appear
simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
	local int Surf;

	if (!Other.bWorldGeometry && Mover(Other) == None && Pawn(Other) == None || level.NetMode == NM_Client)
		return false;

	if (Vehicle(Other) != None)
		Surf = 3;
	else if (HitMat == None)
		Surf = int(Other.SurfaceType);
	else
		Surf = int(HitMat.SurfaceType);

	// Tell the attachment to spawn effects and so on
	SendFireEffect(Other, HitLocation, HitNormal, Surf, WaterHitLoc);
	if (!bAISilent)
		Instigator.MakeNoise(1.0);
	return true;
}

defaultproperties
{
	TraceRange=(Min=30000.000000,Max=30000.000000)
	WaterRangeFactor=0.800000
	MaxWallSize=96.000000
	MaxWalls=2
	Damage=100.000000
	DamageHead=145.000000
	DamageLimb=100.000000
	WaterRangeAtten=0.800000
	DamageType=Class'BallisticProV55.DTR78Rifle'
	DamageTypeHead=Class'BallisticProV55.DTR78RifleHead'
	DamageTypeArm=Class'BallisticProV55.DTR78Rifle'
	KickForce=6000
	PenetrateForce=150
	bPenetrate=True
	PDamageFactor=0.800000
	bCockAfterFire=True
	MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
	BrassClass=Class'BallisticProV55.Brass_Rifle'
	bBrassOnCock=True
	BrassOffset=(X=-10.000000,Y=1.000000,Z=-1.000000)
	RecoilPerShot=1536.000000
	FireChaos=0.500000
	BallisticFireSound=(Sound=Sound'BallisticSounds3.R78.R78-Fire',Volume=2.000000,Radius=1024.000000)
	FireEndAnim=
	FireRate=1.000000
	AmmoClass=Class'BallisticProV55.Ammo_42Rifle'
	ShakeRotMag=(X=400.000000,Y=32.000000)
	ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-5.000000)
	ShakeOffsetRate=(X=-1000.000000)
	ShakeOffsetTime=2.000000
	
	// AI
	bInstantHit=True
	bLeadTarget=False
	bTossed=False
	bSplashDamage=False
	bRecommendSplashDamage=False
	BotRefireRate=0.4
	WarnTargetPct=0.5
	
	aimerror=800.000000
}
