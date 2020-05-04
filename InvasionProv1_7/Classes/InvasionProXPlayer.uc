class InvasionProXPlayer extends BallisticPlayer;

var() Sound KillSound;
var() bool bUpdatedPickups;
var() bool bMeshesLoaded;
var() bool bLoadMeshes;
var() Sound RadarPulseSound;
var() float CrosshairMaxDistance;
var() float CrosshairSizeScale;
var() float CrosshairMinSize;
var() float CrosshairMaxSize;
var() bool bSpecMonsters;
var() bool bLoadingStarted;
var() bool bPetMode;
var() InvasionProPetStatsItem MyStats; //only required for monster targets whilst following

replication
{
    reliable if( Role == ROLE_Authority )
        ClientHideHealthPacks, ClientHideWeaponBases, ClientHideSuperBases, ClientHideWeaponLockers, ClientPlayKillSound, bPetMode;
    reliable if(Role < Role_Authority)
    	bSpecMonsters, bMeshesLoaded, SetSpecMonsters, UpdatePlayerHealth;
}

simulated function SetSpecMonsters(bool bSpec)
{
	bSpecMonsters = bSpec;
}

function ClientRestart(Pawn NewPawn)
{
	Super.ClientRestart(NewPawn);

	if(InvasionProHud(myHUD) != None && InvasionProHud(myHUD).bStartThirdPerson && AllowBehindView())
	{
		bBehindView = true;
		BehindView(bBehindView);

		if(InvasionProHud(myHUD).RadarSound != "" && InvasionProHud(myHUD).RadarSound != "None")
		{
			RadarPulseSound = Sound(DynamicLoadObject(InvasionProHud(myHUD).RadarSound, class'Sound',true));
			InvasionProHud(myHUD).PulseSound = RadarPulseSound;
		}
	}
}

function bool AllowBehindView()
{
	if(InvasionProHud(myHUD) != None && InvasionProHud(myHUD).bMeshesLoaded)
	{
		return true;
	}

	return false;
}

function Possess(Pawn aPawn)
{
	if ( PlayerReplicationInfo.bOnlySpectator )
	{
		return;
	}

	Super.Possess(aPawn);

	if(!bLoadingStarted && !bMeshesLoaded && bLoadMeshes && Pawn != None)
	{
		bLoadingStarted = true;
		LoadMonsterMeshes();
	}
}

simulated function LoadMonsterMeshes()
{
	Spawn(class'InvasionProMeshActor',Self);
}

function SpawnFakeCrosshair()
{
	if(Level.GetLocalPlayerController() != self)
	{
		return;
	}
}

function rotator AdjustAim(FireProperties FiredAmmunition, vector projStart, int aimerror)
{
    local vector FireDir, AimSpot, HitNormal, HitLocation, OldAim, AimOffset;
    local actor BestTarget;
    local float bestAim, bestDist, projspeed;
    local actor HitActor;
    local bool bNoZAdjust, bLeading;
    local rotator AimRot;

	if(InvasionProGameReplicationInfo(GameReplicationInfo).bAerialView && Vehicle(Pawn) == None)
	{
		FireDir = vector(Rotation);
		if ( FiredAmmunition.bInstantHit )
		{
			HitActor = Trace(HitLocation, HitNormal, projStart + 10000 * FireDir, projStart, true);
		}
		else
		{
			HitActor = Trace(HitLocation, HitNormal, projStart + 4000 * FireDir, projStart, true);
		}

		if ( (HitActor != None) && HitActor.bProjTarget )
		{
			BestTarget = HitActor;
			bNoZAdjust = true;
			OldAim = HitLocation;
			BestDist = VSize(BestTarget.Location - Pawn.Location);
		}
		else
		{
			bestAim = 0.90;
			if ( (Level.NetMode == NM_Standalone) && bAimingHelp )
			{
				bestAim = 0.93;
				if ( FiredAmmunition.bInstantHit )
				{
					bestAim = 0.97;
				}
				if ( FOVAngle < DefaultFOV - 8 )
				{
					bestAim = 0.99;
				}
			}
			else if ( FiredAmmunition.bInstantHit )
			{
				bestAim = 1.0;
			}

			BestTarget = PickTarget(bestAim, bestDist, FireDir, projStart, FiredAmmunition.MaxRange);
			if ( BestTarget == None )
			{
				return Rotation;
			}
			OldAim = projStart + FireDir * bestDist;
		}
		InstantWarnTarget(BestTarget,FiredAmmunition,FireDir);
		ShotTarget = Pawn(BestTarget);
		if ( !bAimingHelp || (Level.NetMode != NM_Standalone) )
		{
			return Rotation;
		}

		if ( !FiredAmmunition.bInstantHit )
		{
			projspeed = FiredAmmunition.ProjectileClass.default.speed;
			BestDist = vsize(BestTarget.Location + BestTarget.Velocity * FMin(1, 0.02 + BestDist/projSpeed) - projStart);
			bLeading = true;
			FireDir = BestTarget.Location + BestTarget.Velocity * FMin(1, 0.02 + BestDist/projSpeed) - projStart;
			AimSpot = projStart + bestDist * Normal(FireDir);
			if ( FiredAmmunition.bTrySplash
				&& ((BestTarget.Velocity != vect(0,0,0)) || (BestDist > 1500)) )
			{
				HitActor = Trace(HitLocation, HitNormal, AimSpot - BestTarget.CollisionHeight * vect(0,0,2), AimSpot, false);
				if ( (HitActor != None) && FastTrace(HitLocation + vect(0,0,4),projstart) )
				{
					return rotator(HitLocation + vect(0,0,6) - projStart);
				}
			}
		}
		else
		{
			FireDir = BestTarget.Location - projStart;
			AimSpot = projStart + bestDist * Normal(FireDir);
		}
		AimOffset = AimSpot - OldAim;

		if ( bNoZAdjust || (bLeading && (Abs(AimOffset.Z) < BestTarget.CollisionHeight)) )
		{
			AimSpot.Z = OldAim.Z;
		}
		else if ( AimOffset.Z < 0 )
		{
			AimSpot.Z = BestTarget.Location.Z + 0.4 * BestTarget.CollisionHeight;
		}
		else
		{
			AimSpot.Z = BestTarget.Location.Z - 0.7 * BestTarget.CollisionHeight;
		}
		if ( !bLeading )
		{
			if ( !bNoZAdjust )
			{
				AimRot = rotator(AimSpot - projStart);
				if ( FOVAngle < DefaultFOV - 8 )
				{
					AimRot.Yaw = AimRot.Yaw + 200 - Rand(400);
				}
				else
				{
					AimRot.Yaw = AimRot.Yaw + 375 - Rand(750);
				}

				return AimRot;
			}
		}
		else if ( !FastTrace(projStart + 0.9 * bestDist * Normal(FireDir), projStart) )
		{
			FireDir = BestTarget.Location - projStart;
			AimSpot = projStart + bestDist * Normal(FireDir);
		}
		return rotator(AimSpot - projStart);
	}
	else
	{
		return Super.AdjustAim(FiredAmmunition, projStart, aimerror);
	}
}

event PlayerCalcView(out actor ViewActor, out vector CameraLocation, out rotator CameraRotation)
{
	local vector HitLocation, Hitnormal, EndTrace, StartTrace;
	local float Distance, CrosshairSizeDistance, CrosshairSize;

	Super.PlayerCalcView(ViewActor, CameraLocation, CameraRotation);

	if( (InvasionProGameReplicationInfo(GameReplicationInfo) != None && !InvasionProGameReplicationInfo(GameReplicationInfo).bAerialView) || (Vehicle(Pawn) != None) )
	{
		return;
	}

	if(bBehindView && Pawn != None && myHUD != None)
	{
		if(Trace(HitLocation, HitNormal, CameraLocation + (vect(0, 0, 65) >> CameraRotation), CameraLocation, false, vect(10, 10, 10)) != None)
		{
			CameraLocation += (HitLocation - CameraLocation) - (10 * normal(HitLocation - CameraLocation));
		}
		else
		{
			CameraLocation += vect(0,0,64) >> CameraRotation;
		}

		CalcBehindView(CameraLocation, CameraRotation, 0);
	//}

		StartTrace = Pawn.Location;
		StartTrace.Z += Pawn.BaseEyeHeight;
		EndTrace = StartTrace + vector(CameraRotation)*16384;

		if(Trace(HitLocation, HitNormal, EndTrace, StartTrace, true) == None)
		{
			HitLocation = EndTrace;
		}

		Distance = VSize(HitLocation - StartTrace);
		CrosshairSizeDistance = FMin(Distance, 10000);
		CrosshairSize = FMax(CrosshairSizeDistance/CrosshairSizeScale, CrosshairMinSize);
		CrosshairSize = FClamp(CrosshairSize, CrosshairMinSize, CrosshairMaxSize);
		InvasionProHud(myHUD).BehindViewCrosshairLocation = HitLocation - vector(CameraRotation)*FMax(CrosshairSizeDistance/CrosshairMaxDistance, CrosshairMaxDistance);
	}
}

simulated function ClientHideHealthPacks()
{
	local HealthCharger HC;

	foreach AllActors(class'HealthCharger', HC)
	{
		if(HC != None && HC.DrawType != DT_None)
		{
			HC.SetDrawType(DT_None);
		}
	}
}

simulated function ClientHideWeaponBases()
{
	local xWeaponBase xWB;

	foreach AllActors(class'xWeaponBase', xWB)
	{
		if(xWB != None && xWB.DrawType != DT_None)
		{
			xWB.SetDrawType(DT_None);
			xWB.SpiralEmitter = None;
			if(xWB.MyEmitter != None)
			{
				xWB.MyEmitter.Destroy();
			}
		}
	}
}

simulated function ClientHideSuperBases()
{
	local xPickUpBase xPB;

	foreach AllActors(class'xPickUpBase', xPB)
	{
		if(xPB != None && xPB.DrawType != DT_None)
		{
			if( !xPB.IsA('HealthCharger') && !xPB.IsA('xWeaponBase') )
			{
				xPB.SetDrawType(DT_None);

				xPB.SpiralEmitter = None;
				if(xPB.MyEmitter != None)
				{
					xPB.MyEmitter.Destroy();
				}
			}
		}
	}
}

simulated function ClientHideWeaponLockers()
{
	local WeaponLocker WL;

	foreach AllActors(class'WeaponLocker', WL)
	{
		if(WL != None && WL.DrawType != DT_None)
		{
			WL.SetDrawType(DT_None);
			WL.GotoState('Disabled');
			if(WL.Effect != None)
			{
				WL.Effect.Destroy();
			}
		}
	}
}

simulated function ClientPlayKillSound()
{
	if(InvasionProHUD(myHUD) != None && InvasionProHUD(myHUD).CurrentKillSound != "None" && InvasionProHUD(myHUD).CurrentKillSound != "")
	{
		KillSound = Sound(DynamicLoadObject(InvasionProHUD(myHUD).CurrentKillSound,class'Sound',false));
		if(KillSound != None)
		{
			ClientReliablePlaySound(KillSound);
		}
	}
}

function DoCombo( class<Combo> ComboClass )
{
	if(InvasionProGameReplicationInfo(GameReplicationInfo) != None)
	{
		if( InvasionProGameReplicationInfo(GameReplicationInfo).bDisableSpeed && ComboClass == class'ComboSpeed' )
		{
			return;
		}
		else if( InvasionProGameReplicationInfo(GameReplicationInfo).bDisableBerserk && ComboClass == class'ComboBerserk' )
		{
			return;
		}
		else if( InvasionProGameReplicationInfo(GameReplicationInfo).bDisableInvis && ComboClass == class'ComboInvis' )
		{
			return;
		}
		else if( InvasionProGameReplicationInfo(GameReplicationInfo).bDisableDefensive && ComboClass == class'ComboDefensive' )
		{
			return;
		}
		else if (Adrenaline >= ComboClass.default.AdrenalineCost && !Pawn.InCurrentCombo() )
		{
			ServerDoCombo( ComboClass );
		}
	}
}

function UpdatePlayerHealth(int Health, int HealthMax)
{
	if(Role == Role_Authority && InvasionProPlayerReplicationInfo(PlayerReplicationInfo) != None)
	{
		InvasionProPlayerReplicationInfo(PlayerReplicationInfo).PlayerHealth = Health;
		InvasionProPlayerReplicationInfo(PlayerReplicationInfo).PlayerHealthMax = HealthMax;
	}
}

event PlayerTick( float DeltaTime )
{
	if(!bUpdatedPickups)
	{
		if(InvasionProGameReplicationInfo(GameReplicationInfo) != None)
		{
			if(InvasionProGameReplicationInfo(GameReplicationInfo).bDisableHealthPacks)
			{
				ClientHideHealthPacks();
			}

			if(InvasionProGameReplicationInfo(GameReplicationInfo).bDisableWeapons)
			{
				ClientHideWeaponBases();
			}

			if(InvasionProGameReplicationInfo(GameReplicationInfo).bDisableSuperPickups)
			{
				ClientHideSuperBases();
			}

			if(InvasionProGameReplicationInfo(GameReplicationInfo).bDisableWeaponLockers)
			{
				ClientHideWeaponLockers();
			}

			bUpdatedPickups = true;
		}
	}

	if(InvasionProxPawn(Pawn) != None && InvasionProPlayerReplicationInfo(PlayerReplicationInfo) != None)
	{
		UpdatePlayerHealth(Pawn.Health, Pawn.SuperHealthMax);
	}
	else if(InvasionProPlayerReplicationInfo(PlayerReplicationInfo) != None)
	{
		UpdatePlayerHealth(0, 199);
	}

    Super.PlayerTick(DeltaTime);
}

function ClientVoiceMessage(PlayerReplicationInfo Sender, PlayerReplicationInfo Recipient, name messagetype, byte messageID)
{
    local VoicePack V;

    if ( (Sender == None) || (Sender.voicetype == None) || (Player == None) || (Player.Console == None) )
        return;

    V = Spawn(Sender.voicetype, self);
    if ( V != None )
        V.ClientInitialize(Sender, Recipient, messagetype, messageID);
}

//cancel hud/scoreboard changing unless extends invasionpro versions
//for custom huds/scoreboards try an overlay or extend Invasionprohud/invasionproscoreboard or ask ini for a possible update me@shaungoeppinger.com
simulated function ClientSetHUD(class<HUD> newHUDClass, class<Scoreboard> newScoringClass )
{
	local HUD NewHUD;

	if(newHUDClass != None)
	{
		if(ClassIsChildOf(newHUDClass, class'InvasionProHud'))
		{
			NewHUD = Spawn(newHUDClass, self);
			if (NewHUD == None)
			{
				log ("InvasionProXPlayer::ClientSetHUD(): Could not spawn a HUD of class "$newHUDClass, 'InvasionPro');
			}
			else
			{
				if ( myHUD != None )
				{
					myHUD.Destroy();
				}

				myHUD = NewHUD;
			}
		}
		/*else
		{
			if(Role == Role_Authority)
			{
				log("Custom HUD"@newHUDClass@"is not compatible with InvasionPro, the HUD must extend InvasionProHud. Email ini for help if needed: me@shaungoeppinger.com" );
			}
		}*/
	}

	if(newScoringClass != None)
	{
		if(ClassIsChildOf(newScoringClass, class'InvasionProScoreboard'))
		{
			if ( myHUD != None )
			{
				myHUD.SetScoreBoardClass( newScoringClass );
			}
		}
		/*else
		{
			if(Role == Role_Authority)
			{
				log("Custom Score Board"@newScoringClass@"is not compatible with InvasionPro, the Score board must extend InvasionProScoreboard. Email ini for help if needed: me@shaungoeppinger.com" );
			}
		}*/
	}

    if( Level.Song != "" && Level.Song != "None" )
    {
        ClientSetInitialMusic( Level.Song, MTRAN_Fade );
	}
}

function ServerViewNextPlayer()
{
    local Controller C, Pick;
    local bool bFound, bRealSpec, bWasSpec;
	local TeamInfo RealTeam;

    bRealSpec = PlayerReplicationInfo.bOnlySpectator;
    bWasSpec = !bBehindView && (ViewTarget != Pawn) && (ViewTarget != self);
    PlayerReplicationInfo.bOnlySpectator = true;
    RealTeam = PlayerReplicationInfo.Team;

    // view next player
    for ( C=Level.ControllerList; C!=None; C=C.NextController )
    {
		if(MonsterController(C) == None || (MonsterController(C) != None && bSpecMonsters))
		{
			if ( bRealSpec && (C.PlayerReplicationInfo != None) ) // hack fix for invasion spectating
			{
				PlayerReplicationInfo.Team = C.PlayerReplicationInfo.Team;
			}

			if ( Level.Game.CanSpectate(self,bRealSpec,C) )
			{
				if ( Pick == None )
				{
					Pick = C;
				}
				if ( bFound )
				{
					Pick = C;
					break;
				}
				else
				{
					bFound = ( (RealViewTarget == C) || (ViewTarget == C) );
				}
			}
		}
    }
    PlayerReplicationInfo.Team = RealTeam;
    SetViewTarget(Pick);
    ClientSetViewTarget(Pick);
    if ( (ViewTarget == self) || bWasSpec )
    {
        bBehindView = false;
	}
    else
    {
        bBehindView = true; //bChaseCam;
	}
    ClientSetBehindView(bBehindView);
    PlayerReplicationInfo.bOnlySpectator = bRealSpec;
}

function BecomeSpectator()
{
    if (Role < ROLE_Authority)
        return;

    if ( !Level.Game.BecomeSpectator(self) )
        return;

    if ( Pawn != None )
        Pawn.Died(self, class'DamageType', Pawn.Location);

    if ( PlayerReplicationInfo.Team != None )
        PlayerReplicationInfo.Team.RemoveFromTeam(self);
    PlayerReplicationInfo.Team = None;
    PlayerReplicationInfo.Score = 0;
    PlayerReplicationInfo.Deaths = 0;
    PlayerReplicationInfo.GoalsScored = 0;
    PlayerReplicationInfo.Kills = 0;
    PlayerReplicationInfo.NumLives = 0;
    ServerSpectate();
    BroadcastLocalizedMessage(Level.Game.GameMessageClass, 14, PlayerReplicationInfo);
    ClientBecameSpectator();
}

function ServerSpectate()
{
	Super.ServerSpectate();
	InvasionPro(Level.Game).UpdatePlayerGRI();
}

function damageAttitudeTo(pawn Other, float Damage)
{
	if(Monster(Other) != None && MyStats != None)
	{
		MyStats.DamageAttitudeTo(Other,Damage);
	}

	Super.damageAttitudeTo(Other, Damage);
}

defaultproperties
{
     CrosshairMaxDistance=16.000000
     CrosshairSizeScale=30.000000
     CrosshairMinSize=30.000000
     CrosshairMaxSize=335.000000
     bSpecMonsters=True
     PlayerReplicationInfoClass=Class'InvasionProv1_7.InvasionProPlayerReplicationInfo'
     PawnClass=Class'InvasionProv1_7.InvasionProxPawn'
}
