//=============================================================================
// A49 Skrith Blaster.
//
// Skrith SMG equivalent. Puts out immense damage in a projectile stream.
// Altfire is implemented here as a conical fire which blasts enemies to hell.
//
// uses code written by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A49SkrithBlaster extends BallisticWeapon;

var float		HeatLevel;			// Current Heat level, duh...
var bool		bIsVenting;			// Busy venting
var() Sound		OverHeatSound;		// Sound to play when it overheats
var() Sound		DamageSound;		// Sound to play when it first breaks
var() Sound		BrokenSound;		// Sound to play when its very damaged
var() class<DamageType>	BlastDamageType;

var actor VentSteam;
var actor VentSteam2;
var actor GlowFX;
var actor GlowFXDamaged;


simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);
	SoundPitch = 56;

	GunLength = default.GunLength;
}

simulated event Timer()
{
	if (Clientstate == WS_PutDown)
		class'BUtil'.static.KillEmitterEffect(GlowFX);
	super.Timer();
}

static function class<Pickup> RecommendAmmoPickup(int Mode)
{
	return class'AP_A49Clip';
}

simulated event Destroyed()
{
	if (GlowFX != None)
		GlowFX.Destroy();

	super.Destroyed();
}

simulated function CommonCockGun(optional byte Type)
{
	local int m;
	if (bNonCocking)
		return;
	if (Role == ROLE_Authority)
		bServerReloading=true;
	ReloadState = RS_Cocking;
	PlayCocking(Type);
	for (m=0; m < NUM_FIRE_MODES; m++)
		if (BFireMode[m] != None)
			BFireMode[m].CockingGun(Type);
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Dist;
	local Vector Dir;
	local Vehicle V;

	B = Bot(Instigator.Controller);
	if ( B == None  || B.Enemy == None)
		return Rand(2);

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);

	if (AmmoAmount(0) < 40)
		return 0;

	if (B.Squad!=None)
	{
		if ( ( (DestroyableObjective(B.Squad.SquadObjective) != None && B.Squad.SquadObjective.TeamLink(B.GetTeamNum()))
			|| (B.Squad.SquadObjective == None && DestroyableObjective(B.Target) != None && B.Target.TeamLink(B.GetTeamNum())) )
	    	 && (B.Enemy == None || !B.EnemyVisible()) )
			return 0;
		if ( FocusOnLeader(B.Focus == B.Squad.SquadLeader.Pawn) )
			return 0;

		V = B.Squad.GetLinkVehicle(B);
		if ( V == None )
			V = Vehicle(B.MoveTarget);
		if ( V == B.Target )
			return 0;
		if ( (V != None) && (V.Health < V.HealthMax) && (V.LinkHealMult > 0) && B.LineOfSightTo(V) )
			return 0;
	}

	if (Dist < (FireMode[1].MaxRange()-100) && FRand() > 0.3)
		return 1;
	if (vector(B.Enemy.Rotation) dot Normal(Dir) < 0.0 && (VSize(B.Enemy.Velocity) < 100 || Normal(B.Enemy.Velocity) dot Normal(B.Velocity) < 0.5))
		return 1;
	return 0;
}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;
	local vector Dir;
	local DestroyableObjective O;
	local Vehicle V;

	B = Bot(Instigator.Controller);
	if ( B == None )
		return AIRating;

	if (HasMagAmmo(0) || Ammo[0].AmmoAmount > 0)
	{
		V = B.Squad.GetLinkVehicle(B);
		if ( (V != None)
			&& (VSize(Instigator.Location - V.Location) < 1.5 * FireMode[0].MaxRange())
			&& (V.Health < V.HealthMax) && (V.LinkHealMult > 0) )
			return 1.2;

		if ( Vehicle(B.RouteGoal) != None && B.Enemy == None && VSize(Instigator.Location - B.RouteGoal.Location) < 1.5 * FireMode[0].MaxRange()
		     && Vehicle(B.RouteGoal).TeamLink(B.GetTeamNum()) )
			return 1.2;

		O = DestroyableObjective(B.Squad.SquadObjective);
		if ( O != None && B.Enemy == None && O.TeamLink(B.GetTeamNum()) && O.Health < O.DamageCapacity
	    	 && VSize(Instigator.Location - O.Location) < 1.1 * FireMode[0].MaxRange() && B.LineOfSightTo(O) )
			return 1.2;
	}

	if (B.Enemy == None)
		return Super.GetAIRating();

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	Result = Super.GetAIRating();

	if (Dist > 1500)
		Result -= (Dist-1500) / 1500;
	else if (Dist < 500)
		Result -= 0.1;
	else if (Dist > 1000 && AmmoAmount(0) < 50)
		return Result -= 0.1;;

	return Result;
}

function bool FocusOnLeader(bool bLeaderFiring)
{
	local Bot B;
	local Pawn LeaderPawn;
	local Actor Other;
	local vector HitLocation, HitNormal, StartTrace;
	local Vehicle V;

	B = Bot(Instigator.Controller);
	if ( B == None )
		return false;
	if ( PlayerController(B.Squad.SquadLeader) != None )
		LeaderPawn = B.Squad.SquadLeader.Pawn;
	else
	{
		V = B.Squad.GetLinkVehicle(B);
		if ( V != None )
		{
			LeaderPawn = V;
			bLeaderFiring = (LeaderPawn.Health < LeaderPawn.HealthMax) && (V.LinkHealMult > 0)
							&& ((B.Enemy == None) || V.bKeyVehicle);
		}
	}
	if ( LeaderPawn == None )
	{
		LeaderPawn = B.Squad.SquadLeader.Pawn;
		if ( LeaderPawn == None )
			return false;
	}
	if (!bLeaderFiring)
		return false;
	if ( (Vehicle(LeaderPawn) != None) )
	{
		StartTrace = Instigator.Location + Instigator.EyePosition();
		if ( VSize(LeaderPawn.Location - StartTrace) < FireMode[0].MaxRange() )
		{
			Other = Trace(HitLocation, HitNormal, LeaderPawn.Location, StartTrace, true);
			if ( Other == LeaderPawn )
			{
				B.Focus = Other;
				return true;
			}
		}
	}
	return false;
}

function ConicalBlast(float DamageAmount, float DamageRadius, vector Aim)
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach CollidingActors( class 'Actor', Victims, DamageRadius, Location )
	{
		if( (Victims != Instigator) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) )
		{
			if ( Aim dot Normal (Victims.Location - Location) < 0.5)
				continue;
				
			if (Pawn(Victims) != None && Pawn(Victims).Controller != None && Pawn(Victims).Controller.SameTeamAs(Instigator.Controller))
				continue;
			
			if (!FastTrace(Victims.Location, Location))
				continue;
				
			dir = Victims.Location - Location;
			dist = FMax(1,VSize(dir));


			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				damageScale * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				75000 * dir,
				BlastDamageType
			);
			
				
			if (BallisticPineapple(Victims) != None)
				BallisticPineapple(Victims).KickPineapple(Normal(Victims.Location - Location) * 20000);
						
			if (Instigator != None && Vehicle(Victims) != None && Vehicle(Victims).Health > 0)
				Vehicle(Victims).DriverRadiusDamage(DamageAmount, DamageRadius, Instigator.Controller, BlastDamageType, 0.0f, Location);
		}
	}
	bHurtEntry = false;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.3;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.4;	}

function bool CanHeal(Actor Other)
{
	if (DestroyableObjective(Other) != None && DestroyableObjective(Other).LinkHealMult > 0)
		return true;
	if (Vehicle(Other) != None && Vehicle(Other).LinkHealMult > 0)
		return true;

	return false;
}
// End AI Stuff =====

defaultproperties
{
     BlastDamageType=Class'BWBPRecolorsPro.DTA49Shockwave'
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     UsedAmbientSound=Sound'BallisticSounds2.A73.A73Hum1'
     BigIconMaterial=Texture'BallisticRecolors3TexPro.A6.BigIcon_A49'
     BigIconCoords=(Y1=24)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_RapidProj=True
     bWT_Energy=True
     SpecialInfo(0)=(Info="0.0;-15.0;-999.0;-1.0;-999.0;-999.0;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.A42.A42-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.A42.A42-Putaway')
     MagAmmo=32
     CockAnim="Overheat"
     ClipOutSound=(Sound=Sound'BallisticSounds2.A73.A73-ClipOut',Volume=1.300000)
     ClipInSound=(Sound=Sound'BallisticSounds2.A73.A73-ClipHit',Volume=1.300000)
     WeaponModes(0)=(bUnavailable=True)
     SightPivot=(Pitch=2000,Roll=-768)
     SightOffset=(X=-12.000000,Y=33.000000,Z=65.000000)
     SightDisplayFOV=40.000000
     SightingTime=0.200000
     GunLength=0.100000
     AimAdjustTime=0.350000
     AimSpread=16
     ChaosDeclineTime=0.800000
     ChaosSpeedThreshold=7500.000000
     ChaosAimSpread=2048
     RecoilXCurve=(Points=(,(InVal=0.100000),(InVal=0.200000,OutVal=-0.100000),(InVal=0.400000,OutVal=0.050000),(InVal=0.600000,OutVal=-0.100000),(InVal=0.700000),(InVal=1.000000,OutVal=0.100000)))
     RecoilYCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.300000),(InVal=0.600000,OutVal=-0.200000),(InVal=0.700000,OutVal=0.200000),(InVal=1.000000,OutVal=0.300000)))
     RecoilXFactor=0.250000
     RecoilYFactor=0.400000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.170000
     FireModeClass(0)=Class'BWBPRecolorsPro.A49PrimaryFire'
     FireModeClass(1)=Class'BWBPRecolorsPro.A49SecondaryFire'
     PutDownAnimRate=2.300000
     BringUpTime=0.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.400000
     CurrentRating=0.400000
     Description="A49 Skrith Blaster"
     Priority=34
     HudColor=(B=255,G=175,R=100)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=2
     GroupOffset=4
     PickupClass=Class'BWBPRecolorsPro.A49Pickup'
     PlayerViewOffset=(Y=10.000000,Z=-25.000000)
     BobDamping=1.600000
     AttachmentClass=Class'BWBPRecolorsPro.A49Attachment'
     IconMaterial=Texture'BallisticRecolors3TexPro.A6.SmallIcon_A49'
     IconCoords=(X2=127,Y2=31)
     ItemName="A49 Skrith Blaster"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=180
     LightSaturation=100
     LightBrightness=192.000000
     LightRadius=12.000000
     Mesh=SkeletalMesh'BallisticRecolors4AnimPro.SkrithBlaster'
     SoundPitch=56
     SoundRadius=32.000000
}
