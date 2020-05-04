//=======================================================
//InvasionPro Copyright © Shaun Goeppinger 2009 - 2012
//=======================================================
class InvasionPro extends Invasion config(InvasionProSettings);

var() config string BossConfigMenu; //the ingame boss config menu
var() config string MonsterStatsConfigMenu; //the ingame monster stats menu
var() config string MonsterConfigMenu; //the ingame monster config menu
var() config string InvasionProConfigMenu; //main menu
var() const localized string InvasionProGroup; //new in game menu group
var() config bool bDisableHealthPacks;
var() config bool bDisableHealthVials;
var() config bool bDisableAdrenalinePickups;
var() config bool bDisableAmmoPickups;
var() config bool bDisableWeaponLockers;
var() config bool bDisableWeapons;
var() config bool bDisableSuperPickups;
var() config bool bSpawnAtBases;
var() config bool bPermitVehicles;
var() config bool bHideRadar;
var() config bool bHidePlayerList;
var() config bool bHideNecroPool;
var() config bool bHideMonsterCount;
//The Regeneration mutator does not bother to check for monsters. both players and monsters regenerate reguardless
//I have built in a regeneration option that can be set for monsters or players
//MutRegen should not be used with this game type.
var() config bool bRegenMonsters; //are monsters allowed to regenerate health
var() config bool bRegenPlayers; //are players allowed to regenerate health
var() config bool bFavorHumans; //resurrect will always favor humans over bots if this is true
var() config int RegenAmount; //players regen amount
var() config int MonsterRegenAmount; //monster regen amount

var() config Object MonsterStats; //config holder for monster stats, setting this does nothing
var() config Object Monsters; //config holder for monster configs, setting this does nothing
var() config Object Bosses; //boss information which is updated via the wave config menu, this is just a holder
var() config Object InvasionProSettings;

var() config int TotalSpawned;  //the sum of all monsters ever spawned of all types
var() config int TotalDamage; //the sum of all damage every monster ever caused
var() config int TotalKills; //the sum of all kills every monster ever caused
var() config int TotalGames; //the number of games played
var() config string BestMonster; //the monster type that has the highest combined damage + kills
var() config string WorstMonster; //the monster type that has the lowest combined damage + kills
var() config string CommonMonster; //the monster that has spawned the most
var() config string RareMonster; //the least spawned monster
//var() int InitialWave; //not used in InvasionPro, use StartWave instead to avoid invasion clamping
//var() int FinalWave; //not used in InvasionPro, use LastWave instead to avoid invasion clamping
var() config int LastWave; //the new FinalWave variable
var() config int StartWave; //the new InitialWave variable
var() config bool bBalanceMonsters; //should the MaxMonsters scale with number of players/bots
var() config int NumMonstersPerPlayer;
var() config bool bShareBossPoints;
var() config int SpawnProtection;
var() config bool bDisableBerserk; //combo management
var() config bool bDisableSpeed;
var() config bool bDisableInvis;
var() config bool bDisableDefensive;
var() config bool bPreloadMonsters;
var() config bool bAerialView;
var() config bool bTeamNecro;
var() config int TeamNecroPercentage;
var() config int TeamNecroPoolMax;
var() config int TeamNecroCost;
var() config int TeamSpawnGameRadius;
var() config String MonsterStartTag;
var() config String PlayerStartTag;
var() config int WaveNameDuration;
var() config int MonsterSpawnDistance;
var() config color WaveCountDownColour;
var() array<NavigationPoint> PlayerStartNavList;  //list of start locations for players
var() array<NavigationPoint> MonsterStartNavList; //list of start locations for monsters
var() NavigationPoint OldNode;
var() config string CustomGameTypePrefix;
var() int TeamNecroPool; //current amount stored
var() float LastBossSpawnTime;

var() int MonsterTeamScore; //just a score for fun that is displayed if you spectate a monster
var() bool bBossWave; //is this a boss wave that is in progress
var() bool bBossActive; //true when boss has spawned
var() bool bFallback;	//attempting to spawn fallback boss
var() float FallBackTimer;
var() bool bIgnoreFallback; //if one boss has spawned, dont fallback if others fail
var() bool bInfiniteBossTime;
//var() int MaxMonsters; //max monsters allowed at any one time (inherited variable)
var() int WaveMaxMonsters;
var() int NumKilledMonsters; //how many monsters have died on the wave so far
//var() int WaveNum; //current wave in progress
//var() int WaveNumClasses; //number of available monsters in WaveMonsterClass array
//var() int WaveMonsters; //how many monsters have been spawned on the wave so far
//var() int SecondBot; //used when spawning bots
//var() int WaveCountDown; //set to 15 at the same time bWaveInProgress is set to false
//var() bool bWaveInProgress; //this is false inbetween waves, whilst the announcer is counting down
//var() class<Monster> LastKilledMonsterClass; //the last monster to meet its doom
var() int LastKilledMonsterScore ;

var() int ResurrectTimer;
var() Controller Resurrectee; //person being resurrected
var() InvasionProWaveHandler WaveNames;
var() PlayerReplicationInfo FriendlyMonsterInfo;
var() Actor CollisionTestActor;
var() color VehicleLockedMessageColour;
var() string CurrentMapPrefix;

var() config bool bIncludeSummons;
var() config bool bWaveTimeLimit;
var() config bool bWaveMonsterLimit;

var() config bool bPetMode; //will start creating pet records for players and allow pets to be spawned
var() config bool bPetTierMode; //pets can be swapped for better pets at different levels, if false player stuck with chosen pet?

var() float LastPetSaveTime;
var() config int PetDataSaveInterval;

var() array<string> WaveBossID;
var() float BossTimeLimit;
var() int OverTimeDamage;
var() bool bUseMonsterStartTag;
var() bool bUsePlayerStartTag;

event InitGame( string Options, out string Error )
{
	if(CustomGameTypePrefix != "" && CustomGameTypePrefix != "None")
	{
		MapPrefix = "DM,BR,CTF,AS,DOM,ONS,VCTF,"$CustomGameTypePrefix;
	}

	TotalGames++;
    Super(xTeamGame).InitGame(Options, Error);
	bForceRespawn = true;
}

function UpdateMonsterStats()
{
	BestMonster = CalculateBestMonster();
	WorstMonster = CalculateWorstMonster();
	CommonMonster = CalculateCommonMonster();
	RareMonster = CalculateRareMonster();
	SaveConfig();
}

function string CalculateBestMonster()
{
	local int i;
	local string CurrentBestMonster;
	local int TotalScore;
	local int CurrentBestScore;

	TotalScore = 0;
	CurrentBestScore = 0;

	for(i=0;i<class'InvasionProMonsterTable'.default.MonsterTable.Length;i++)
	{
		TotalScore = class'InvasionProMonsterTable'.default.MonsterTable[i].NumDamage + class'InvasionProMonsterTable'.default.MonsterTable[i].NumKills;

		if(TotalScore > CurrentBestScore)
		{
			CurrentBestScore = TotalScore;
			CurrentBestMonster = class'InvasionProMonsterTable'.default.MonsterTable[i].MonsterClassName;
		}
	}

	return CurrentBestMonster;
}

function string CalculateWorstMonster()
{
	local int i;
	local string CurrentWorstMonster;
	local int TotalScore;
	local int CurrentWorstScore;

	TotalScore = 0;
	CurrentWorstScore = 0;

	for(i=0;i<class'InvasionProMonsterTable'.default.MonsterTable.Length;i++)
	{
		TotalScore = class'InvasionProMonsterTable'.default.MonsterTable[i].NumDamage + class'InvasionProMonsterTable'.default.MonsterTable[i].NumKills;

		if(TotalScore <= CurrentWorstScore)
		{
			CurrentWorstScore = TotalScore;
			CurrentWorstMonster = class'InvasionProMonsterTable'.default.MonsterTable[i].MonsterClassName;
		}
	}

	return CurrentWorstMonster;
}

function string CalculateCommonMonster()
{
	local int i;
	local string CurrentCommonMonster;
	local int BestSpawn;

	BestSpawn = 0;

	for(i=0;i<class'InvasionProMonsterTable'.default.MonsterTable.Length;i++)
	{
		if(BestSpawn < class'InvasionProMonsterTable'.default.MonsterTable[i].NumSpawns)
		{
			BestSpawn = class'InvasionProMonsterTable'.default.MonsterTable[i].NumSpawns;
			CurrentCommonMonster = class'InvasionProMonsterTable'.default.MonsterTable[i].MonsterClassName;
		}
	}

	return CurrentCommonMonster;
}

function string CalculateRareMonster()
{
	local int i;
	local string CurrentRareMonster;
	local int RareSpawn;

	RareSpawn = 100000;

	for(i=0;i<class'InvasionProMonsterTable'.default.MonsterTable.Length;i++)
	{
		if(RareSpawn >= class'InvasionProMonsterTable'.default.MonsterTable[i].NumSpawns)
		{
			RareSpawn = class'InvasionProMonsterTable'.default.MonsterTable[i].NumSpawns;
			CurrentRareMonster = class'InvasionProMonsterTable'.default.MonsterTable[i].MonsterClassName;
		}
	}

	return CurrentRareMonster;
}

function Reset()
{
	UpdateMaxLives();
    Super(xTeamGame).Reset();
}

event PreBeginPlay()
{
	local InvasionProMonsterReplicationInfo IGI;
	local int i;
	local class<Monster> M;
	local string BossNameLeft, BossNameRight;

    Super(xTeamGame).PreBeginPlay();

	if(bPermitVehicles)
	{
		bAllowVehicles = true;
	}

	SetTeamSpawnPoints();
    UpdateMaxLives();
	InitialWave = (StartWave-1); //update invasions initial wave incase any other mutators need it
    UpdateMonsterStats(); //update monster stats
    WaveNum = (StartWave-1); //set WaveNum, this is very important, this controls which wave info is returned
    InvasionProGameReplicationInfo(GameReplicationInfo).WaveNumber = WaveNum;
    InvasionProGameReplicationInfo(GameReplicationInfo).BaseDifficulty = int(GameDifficulty);
    GameReplicationInfo.bNoTeamSkins = true;
    GameReplicationInfo.bForceNoPlayerLights = true;
    GameReplicationInfo.bNoTeamChanges = true;
    //update monsters to load so loading bar on the hud is correct
    InvasionProGameReplicationInfo(GameReplicationInfo).NumMonstersToLoad = class'InvasionProMonsterTable'.default.MonsterTable.Length;
	InvasionProGameReplicationInfo(GameReplicationInfo).bTeamNecro = bTeamNecro;
	InvasionProGameReplicationInfo(GameReplicationInfo).TeamNecroPool = TeamNecroPool;
	InvasionProGameReplicationInfo(GameReplicationInfo).TeamNecroPoolMax = TeamNecroPoolMax;
	InvasionProGameReplicationInfo(GameReplicationInfo).NecroName = "None";
	InvasionProGameReplicationInfo(GameReplicationInfo).TeamNecroCost = TeamNecroCost;
	InvasionProGameReplicationInfo(GameReplicationInfo).bDisableSpeed = bDisableSpeed;
	InvasionProGameReplicationInfo(GameReplicationInfo).bDisableBerserk = bDisableBerserk;
	InvasionProGameReplicationInfo(GameReplicationInfo).bDisableInvis = bDisableInvis;
	InvasionProGameReplicationInfo(GameReplicationInfo).bDisableDefensive = bDisableDefensive;
	InvasionProGameReplicationInfo(GameReplicationInfo).bDisableHealthPacks = bDisableHealthPacks;
	InvasionProGameReplicationInfo(GameReplicationInfo).bDisableWeapons = bDisableWeapons;
	InvasionProGameReplicationInfo(GameReplicationInfo).bDisableSuperPickups = bDisableSuperPickups;
	InvasionProGameReplicationInfo(GameReplicationInfo).bDisableWeaponLockers = bDisableWeaponLockers;
	InvasionProGameReplicationInfo(GameReplicationInfo).bAerialView = bAerialView;
	InvasionProGameReplicationInfo(GameReplicationInfo).SpawnProtection = SpawnProtection;
	InvasionProGameReplicationInfo(GameReplicationInfo).bHideRadar = bHideRadar;
	InvasionProGameReplicationInfo(GameReplicationInfo).bHidePlayerList = bHidePlayerList;
	InvasionProGameReplicationInfo(GameReplicationInfo).bHideNecroPool = bHideNecroPool;
	InvasionProGameReplicationInfo(GameReplicationInfo).bHideMonsterCount = bHideMonsterCount;
	InvasionProGameReplicationInfo(GameReplicationInfo).WaveCountDownColour = WaveCountDownColour;

	for(i=0;i<class'InvasionProConfigs'.default.Waves.length;i++)
	{
		if(class'InvasionProConfigs'.default.Waves[i].MaxLives > 1)
		{
			InvasionProGameReplicationInfo(GameReplicationInfo).bAlwaysOneLife = false;
			break;
		}
	}

	//spawn and update monster gibsize/gibcount data
	IGI = Spawn(class'InvasionProMonsterReplicationInfo');
	for(i=0;i<class'InvasionProMonsterTable'.default.MonsterTable.Length;i++)
	{
		IGI.AddMonsterInfo(i, class'InvasionProMonsterTable'.default.MonsterTable[i].MonsterName, class'InvasionProMonsterTable'.default.MonsterTable[i].MonsterClassName, class'InvasionProMonsterTable'.default.MonsterTable[i].NewGibSizeMultiplier, class'InvasionProMonsterTable'.default.MonsterTable[i].NewGibMultiplier);
		//intialize any broken monsters
		if(!class'InvasionProMonsterTable'.default.MonsterTable[i].bSetup)
		{
			M = class<Monster>(DynamicLoadObject(class'InvasionProMonsterTable'.default.MonsterTable[i].MonsterClassName, class'Class',true));
			if(M != None)
			{
				class'InvasionProMonsterTable'.default.MonsterTable[i].NewHealth = M.default.Health;
				class'InvasionProMonsterTable'.default.MonsterTable[i].NewMaxHealth = M.default.HealthMax;
				class'InvasionProMonsterTable'.default.MonsterTable[i].NewGroundSpeed = M.default.GroundSpeed;
				class'InvasionProMonsterTable'.default.MonsterTable[i].NewAirSpeed = M.default.AirSpeed;
				class'InvasionProMonsterTable'.default.MonsterTable[i].NewWaterSpeed= M.default.WaterSpeed;
				class'InvasionProMonsterTable'.default.MonsterTable[i].NewJumpZ = M.default.JumpZ;
				class'InvasionProMonsterTable'.default.MonsterTable[i].NewScoreAward = M.default.ScoringValue;
				class'InvasionProMonsterTable'.default.MonsterTable[i].NewGibMultiplier = 1;
				class'InvasionProMonsterTable'.default.MonsterTable[i].NewGibSizeMultiplier = 1;
				class'InvasionProMonsterTable'.default.MonsterTable[i].DamageMultiplier = 1;
				class'InvasionProMonsterTable'.default.MonsterTable[i].bRandomHealth = false;
				class'InvasionProMonsterTable'.default.MonsterTable[i].bRandomSpeed = false;
				class'InvasionProMonsterTable'.default.MonsterTable[i].bRandomSize = false;
				class'InvasionProMonsterTable'.default.MonsterTable[i].NewDrawScale = M.default.DrawScale;
				class'InvasionProMonsterTable'.default.MonsterTable[i].NewCollisionHeight = M.default.CollisionHeight;
				class'InvasionProMonsterTable'.default.MonsterTable[i].NewCollisionRadius = M.default.CollisionRadius;
				class'InvasionProMonsterTable'.default.MonsterTable[i].NewPrePivot.X = M.default.PrePivot.X;
				class'InvasionProMonsterTable'.default.MonsterTable[i].NewPrePivot.Y = M.default.PrePivot.Y;
				class'InvasionProMonsterTable'.default.MonsterTable[i].NewPrePivot.Z = M.default.PrePivot.Z;
				class'InvasionProMonsterTable'.default.MonsterTable[i].bSetup = true;
			}
		}
	}

	////intialize any broken bosses and update replication info for gibs
	for(i=0;i<class'InvasionProConfigs'.default.Bosses.Length;i++)
	{
		IGI.AddBossInfo(i, class'InvasionProConfigs'.default.Bosses[i].BossMonsterName, class'InvasionProConfigs'.default.Bosses[i].BossGibSizeMultiplier, class'InvasionProConfigs'.default.Bosses[i].BossGibMultiplier);
		if(!class'InvasionProConfigs'.default.Bosses[i].bSetup)
		{
			M = class<Monster>(DynamicLoadObject(class'InvasionProConfigs'.default.Bosses[i].BossMonsterName, class'Class',true));
			if(M != None)
			{
				Divide(String(M.Class),".",BossNameLeft,BossNameRight);
				class'InvasionProConfigs'.default.Bosses[i].BossHealth = M.default.Health;
				class'InvasionProConfigs'.default.Bosses[i].BossID = 0;
				class'InvasionProConfigs'.default.Bosses[i].BossName = "Boss ("$BossNameRight$")";
				class'InvasionProConfigs'.default.Bosses[i].BossScoreAward = M.default.ScoringValue;
				class'InvasionProConfigs'.default.Bosses[i].BossDamageMultiplier = 1;
				class'InvasionProConfigs'.default.Bosses[i].BossGibSizeMultiplier = 1;
				class'InvasionProConfigs'.default.Bosses[i].BossGibMultiplier = 1;
				class'InvasionProConfigs'.default.Bosses[i].BossGroundSpeed = M.default.GroundSpeed;
				class'InvasionProConfigs'.default.Bosses[i].BossAirSpeed = M.default.AirSpeed;
				class'InvasionProConfigs'.default.Bosses[i].BossWaterSpeed = M.default.WaterSpeed;
				class'InvasionProConfigs'.default.Bosses[i].BossAirSpeed = M.default.AirSpeed;
				class'InvasionProConfigs'.default.Bosses[i].BossJumpZ = M.default.JumpZ;
				class'InvasionProConfigs'.default.Bosses[i].NewDrawScale = M.default.DrawScale;
				class'InvasionProConfigs'.default.Bosses[i].NewCollisionHeight = M.default.CollisionHeight;
				class'InvasionProConfigs'.default.Bosses[i].NewCollisionRadius = M.default.CollisionRadius;
				class'InvasionProConfigs'.default.Bosses[i].NewPrePivot = M.default.PrePivot;
				class'InvasionProConfigs'.default.Bosses[i].WarningSound = "None";
				class'InvasionProConfigs'.default.Bosses[i].bSetup = true;
			}
		}
	}

	class'InvasionProMonsterTable'.static.StaticSaveConfig();
	CollisionTestActor = Spawn(class'InvasionProCollisionTestActor');
}

//trying to make assault maps as open and playable as possible as invasion maps
//I know this wont fully work for all custom assault maps but the stock ones are now playable :)
//most of this is for the Convoy map
function DisableAssaultActors()
{
	local int i;
	local Actor A;

	foreach DynamicActors(class'Actor',A)
	{
		if(Trigger_ASRoundEnd(A) != None)
		{
			Trigger_ASRoundEnd(A).Tag = 'SomeCoolTag_Ini';
		}
		else if(Trigger_ASMessageTrigger(A) != None || LookTarget(A) != None)
		{
			A.Destroy();
		}
		else if(PhysicsVolume(A) != None)
		{
			if(A.Tag == 'DropshipExp3New')
			{
				A.Tag = 'None';
			}
		}
		else if(ScriptedTrigger(A) != None)
		{
			for ( i=0; i<ScriptedTrigger(A).Actions.Length; i++ )
			{
				if( ACTION_TriggerEvent(ScriptedTrigger(A).Actions[i]) != None)
				{
					if(A.Tag == 'DropshipScript')
					{
						ACTION_TriggerEvent(ScriptedTrigger(A).Actions[i]).Event = 'SomeCoolEvent_Ini';
					}
				}
			}
		}
		else if( DestroyableObjective_SM(A) != None )
		{
			if(DestroyableObjective_SM(A).Event == 'BlowUpCore')
			{
				DestroyableObjective_SM(A).Event = 'SomeCoolEvent_Ini';
			}

			DestroyableObjective_SM(A).DisableObjective(None);
			TriggerEvent(A.Event, A, None);
		}
		else if( ASVehicleFactory(A) != None)
		{
			ASVehicleFactory(A).bEnabled = false;
			ASVehicleFactory(A).bRespawnWhenDestroyed = false;
			ASVehicleFactory(A).MaxVehicleCount = 0;
			ASVehicleFactory(A).VehicleClass = None;
			ASVehicleFactory(A).ShutDown();
		}
		else if( SVehicleTrigger(A) != None )
		{
			SVehicleTrigger(A).bEnabled = false;
		}
		else if( PlayerSpawnManager(A) != None)
		{
			PlayerSpawnManager(A).bAllowTeleporting = false;
			PlayerSpawnManager(A).SetEnabled(false);
		}
		else if( HoldObjective(A) != None)
		{
			HoldObjective(A).DisableObjective(None);
			if(HoldObjective(A).MoverTag == 'None')
			{
				HoldObjective(A).MoverTag = 'SomeCoolTag_Ini';
			}
		}
		else if ( Mover(A) != None && Mover(A).InitialState != 'StandOpenTimed' && A.Tag != 'C4advanceMovers' && A.Tag != 'CollapsePipes')
		{
			if(A.Tag == 'Collapse' || (A.Tag == 'DefenseUpperGrate1' && Mover(A).EncroachDamage != 999) )
			{
				Mover(A).InitialState = 'None';
				A.Tag = 'None';
				Mover(A).Trigger(Self, None);
			}
			else
			{
				Mover(A).bTriggerOnceOnly = true;
				Mover(A).InitialState = 'TriggerControl';
				Mover(A).Trigger(Self, None);
			}
		}
	}
}

function ScoreObjective(PlayerReplicationInfo Scorer, float Score)
{
    if ( Scorer != None )
    {
        Scorer.Score += Score;
        ScoreEvent(Scorer,Score,"ObjectiveScore");
    }

    if ( GameRulesModifiers != None )
    {
        GameRulesModifiers.ScoreObjective(Scorer,Score);
	}

	if(Scorer != None)
	{
		CheckScore(Scorer);
	}
}

function PlayStartupMessage()
{
	if(CurrentMapPrefix ~= "AS")
	{
		DisableAssaultActors();
	}

	Super.PlayStartupMessage();
}

function UpdateMaxLives()
{
	local int i;

	for(i=0;i<class'InvasionProConfigs'.default.Waves.length;i++)
	{
		if(WaveNum == i)
		{
			MaxLives = class'InvasionProConfigs'.default.Waves[i].MaxLives;
			break;
		}
	}

	GameReplicationInfo.MaxLives = MaxLives;
}

function PostBeginPlay()
{
	local int i;

	WaveNames = Spawn(class'InvasionProWaveHandler');
	for(i=0;i<class'InvasionProConfigs'.default.Waves.length;i++)
	{
		WaveNames.WaveName[i] = class'InvasionProConfigs'.default.Waves[i].WaveName;
	}

	Super(xTeamGame).PostBeginPlay();

	if(CurrentMapPrefix ~= "AS")
	{
		DisableAssaultActors();
	}
}

function SetTeamSpawnPoints()
{
    local int PlayerNavCounter, MonsterNavCounter;
    local NavigationPoint N;
    local GameObjective GO;
    local bool bBlueSpawnEstablished, bRedSpawnEstablished; //so more than 1 GO isnt set

	PlayerNavCounter = 0;
	MonsterNavCounter = 0;
	bBlueSpawnEstablished = false;
	bRedSpawnEstablished = false;

	//first check for matching start tags and use them if found
	//if(MonsterStartTag != ""
	for ( N=Level.NavigationPointList; N!=None; N=N.NextNavigationPoint )
	{
		if(String(N.Tag) ~= MonsterStartTag )
		{
			MonsterStartNavList.Insert(MonsterNavCounter,1);
			MonsterStartNavList[MonsterNavCounter] = N;
			MonsterNavCounter++;
			bUseMonsterStartTag = true;
		}
		else if(String(N.Tag) ~= PlayerStartTag )
		{
			PlayerStartNavList.Insert(PlayerNavCounter,1);
			PlayerStartNavList[PlayerNavCounter] = N;
			PlayerNavCounter++;
			bUsePlayerStartTag = true;
		}
	}

	//if no start tag found for monsters and this is a team map and bSpawnAtBases them assemble spawn points based on gameobjectives
	//need to check both seperately incase someone just placed specific nodes for monsters or vice versa and not both
	if(MonsterStartNavList.Length <= 0 && bSpawnAtBases && LevelIsTeamMap())
	{
		//assemble team start points as some gametypes do not need to have TeamNumber set correctly
		foreach DynamicActors(class'GameObjective',GO)
		{
			//checking for all types of navigation points as some maps done have playerstarts anywhere near objectives and some dont even have team numbers set! And further still some have red and blue in the same location!
			if(GameObjectiveTeam(GO) == 0 && !bBlueSpawnEstablished)
			{
				for ( N=Level.NavigationPointList; N!=None; N=N.NextNavigationPoint )
				{
					if(Door(N) == None && Teleporter(N) == None && N.Region.Zone.LocationName != "In space" && FlyingPathNode(N) == None && VSize(N.Location - GO.Location) < TeamSpawnGameRadius)
					{
						MonsterStartNavList.Insert(MonsterNavCounter,1);
						MonsterStartNavList[MonsterNavCounter] = N;
						MonsterNavCounter++;
						bBlueSpawnEstablished = true;
					}
				}
			}
		}
	}

	//same for players as for monsters with team differences
	if(PlayerStartNavList.Length <= 0 && bSpawnAtBases && LevelIsTeamMap())
	{
		foreach DynamicActors(class'GameObjective',GO)
		{
			if(GameObjectiveTeam(GO) == 1 && !bRedSpawnEstablished)
			{
				//checking for all types of navigation points as some maps done have playerstarts anywhere near objectives and some dont even have team numbers set! And further still some have red and blue in the same location!
				for ( N=Level.NavigationPointList; N!=None; N=N.NextNavigationPoint )
				{
					if(Door(N) == None && Teleporter(N) == None && N.Region.Zone.LocationName != "In space" && FlyingPathNode(N) == None && VSize(N.Location - GO.Location) < TeamSpawnGameRadius)
					{
						PlayerStartNavList.Insert(PlayerNavCounter,1);
						PlayerStartNavList[PlayerNavCounter] = N;
						PlayerNavCounter++;
						bRedSpawnEstablished = true;
					}
				}
			}
		}
	}

	//if no game objectives fall back to playerstarts
	if(MonsterStartNavList.Length <= 0)
	{
		for ( N=Level.NavigationPointList; N!=None; N=N.NextNavigationPoint )
		{
			if(PlayerStart(N) != None && N.Region.Zone.LocationName != "In space" && PlayerStart(N).TeamNumber == 0)
			{
				MonsterStartNavList.Insert(MonsterNavCounter,1);
				MonsterStartNavList[MonsterNavCounter] = N;
				MonsterNavCounter++;
			}
		}
	}

	if(PlayerStartNavList.Length <= 0)
	{
		for ( N=Level.NavigationPointList; N!=None; N=N.NextNavigationPoint )
		{
			if(PlayerStart(N) != None && N.Region.Zone.LocationName != "In space" && PlayerStart(N).TeamNumber == 1)
			{
				PlayerStartNavList.Insert(PlayerNavCounter,1);
				PlayerStartNavList[PlayerNavCounter] = N;
				PlayerNavCounter++;
			}
		}
	}

	//dm maps, maps with no playerstart team numbers set
	if(PlayerStartNavList.Length <= 0)
	{
		for ( N=Level.NavigationPointList; N!=None; N=N.NextNavigationPoint )
		{
			if(PlayerStart(N) != None)
			{
				PlayerStartNavList.Insert(PlayerNavCounter,1);
				PlayerStartNavList[PlayerNavCounter] = N;
				PlayerNavCounter++;
			}
		}
	}
}

function byte GameObjectiveTeam(GameObjective GO)
{
	//red
	if( (xBombDelivery(GO) != None && xBombDelivery(GO).Team == 0) || //br
		(ONSPowerCoreRed(GO) != None) || //ons
		(xDomPoint(GO) != None && xDomPoint(GO).PointName ~= "A") || //dom
		(xRedFlagBase(Go) != None) ) //ctf
	{
		return 1;
	}

	if( (xBombDelivery(GO) != None && xBombDelivery(GO).Team == 1) ||
		(ONSPowerCoreBlue(GO) != None) ||
		(xDomPoint(GO) != None && xDomPoint(GO).PointName ~= "B") ||
		(xBlueFlagBase(Go) != None) )
	{
		return 0;
	}
	//blue

	return 255;
}

function bool CanSpectate( PlayerController Viewer, bool bOnlySpectator, actor ViewTarget )
{
	//make any monsters / bots / players spectatable. I thought it might be fun to spectate monsters
	//why the heck not! Might even be helpful in debugging stuck monsters
    if ( Controller(ViewTarget) != None && Controller(ViewTarget).Pawn != None)
	{
		return true;
	}

	return false;
}

function OverrideInitialBots()
{
	//why overrride bots?
}

function UpdatePlayerGRI()
{
	local Controller C;
	local int i, PlayerCounter;

	PlayerCounter = 0;

	for(i=0;i<32;i++)
	{
		InvasionProGameReplicationInfo(GameReplicationInfo).PlayerNames[i] = "";
		InvasionProGameReplicationInfo(GameReplicationInfo).PlayerLives[i] = 0;
	}

	for ( C = Level.ControllerList; C!=None; C=C.NextController )
	{
		if ( C.PlayerReplicationInfo != None )
		{
			InvasionProGameReplicationInfo(GameReplicationInfo).PlayerNames[PlayerCounter] = C.PlayerReplicationInfo.PlayerName;
			InvasionProGameReplicationInfo(GameReplicationInfo).PlayerLives[PlayerCounter] = C.PlayerReplicationInfo.NumLives;
			PlayerCounter++;
		}
	}
}

function bool CompareControllers(Controller B, Controller C)
{
	if(B.class == C.class)
	{
		return true;
	}

	if( (!B.IsA('FriendlyMonsterController') && B.IsA('MonsterController') && C.IsA('SMPNaliFighterController')) || (B.IsA('SMPNaliFighterController') && !C.IsA('FriendlyMonsterController') && C.IsA('MonsterController')) )
	{
		return true;
	}

	if( B.IsA('PetController') || C.IsA('PetController') )
	{
		return true;
	}

	if( (B.IsA('FriendlyMonsterController') && C.IsA('PlayerController')) || (B.IsA('PlayerController') && C.IsA('FriendlyMonsterController')))
	{
		return true;
	}

	return false;
}

function CalculateMonsterEarnings(Monster Earner, Controller Other)
{
	local int Earnings;

	Earnings = 1;

	if(Other != None && Other.PlayerReplicationInfo != None)
	{
		Earnings = Other.PlayerReplicationInfo.Score / Earner.ScoringValue;
	}

	if(Earnings < 10)
	{
		Earnings = 10;
		//monsters deserve at least 10 points per kill :)
	}

	MonsterTeamScore += Earnings;
}

function UpdatePlayerLives()
{
	local Controller C;

	for ( C = Level.ControllerList; C!=None; C=C.NextController )
	{
		//don't give friendly monsters more lifes
		if ( C.PlayerReplicationInfo != None && MonsterController(C) == None )
		{
			C.PlayerReplicationInfo.NumLives = Maxlives;
		}
	}

	UpdatePlayerGRI();
}

function ScoreKill(Controller Killer, Controller Other)
{
	local Inventory Inv;
	local PlayerReplicationInfo OtherPRI;
	local Controller C;
	local float KillScore, KillBonus;
	local bool bTeamEffort;

	bTeamEffort = false;
	//give game rules a chance to add anything;
	if ( GameRulesModifiers != None && Killer != None)
	{
		GameRulesModifiers.ScoreKill(Killer, Other);
	}

	if(Other != None)
	{
		OtherPRI = Other.PlayerReplicationInfo;

		if(Other.Pawn != None)
		{
			if(MonsterIsBoss(Other.Pawn))
			{
				bTeamEffort = true;
			}
		}

		//players lose points for being killed, if killed wasnt a monster (must be player/bot?)
		if( MonsterController(Other) == None)
		{
			//if killer was a player or monster
			Other.PlayerReplicationInfo.Score -= 10;
			Other.PlayerReplicationInfo.NetUpdateTime = Level.TimeSeconds - 1;
			Other.PlayerReplicationInfo.Team.Score -= 10;
			Other.PlayerReplicationInfo.Team.NetUpdateTime = Level.TimeSeconds - 1;
			ScoreEvent(Other.PlayerReplicationInfo, -10, "team_frag");
		}
	}

	if(Killer != None)
	{
		//if killer was a hostile monster
		if(MonsterController(Killer) != None && !Killer.IsA('FriendlyMonsterController'))
		{
			if(Monster(Killer.Pawn) != None && Other != None)
			{
				CalculateMonsterEarnings(Monster(Killer.Pawn), Other);
			}
		}

		if( InvasionProXPlayer(Killer) != None && Other != Killer)
		{
			InvasionProXPlayer(Killer).ClientPlayKillSound();
		}

		if ( LastKilledMonsterClass == None )
		{
			KillScore = 1;
		}
		else
		{
			KillScore = LastKilledMonsterScore;
		}

		if(bTeamEffort && bShareBossPoints)
		{
			if(Killer.PlayerReplicationInfo != None)
			{
				Killer.PlayerReplicationInfo.Team.Score += KillScore;
				Killer.PlayerReplicationInfo.Team.NetUpdateTime = Level.TimeSeconds - 1;
				Killer.PlayerReplicationInfo.Kills++;
			}

			KillScore = LastKilledMonsterScore / GetNumPlayers();
			KillScore = UpdateTeamNecroScore(KillScore);
			bTeamEffort = false;

			for ( C = Level.ControllerList; C!=None; C=C.nextController )
			{
				if ( C.PlayerReplicationInfo != None )//bots and players
				{
					C.PlayerReplicationInfo.Score += KillScore;
					C.AwardAdrenaline(KillScore);
					C.PlayerReplicationInfo.NetUpdateTime = Level.TimeSeconds - 1;
				}
			}
		}
		else if(MonsterController(Other) != None && !Other.IsA('FriendlyMonsterController'))
		{
			if(Killer.PlayerReplicationInfo != None)
			{
				Killer.PlayerReplicationInfo.Kills++;
				Killer.PlayerReplicationInfo.Score += KillScore;
				Killer.PlayerReplicationInfo.Team.Score += KillScore;
				Killer.PlayerReplicationInfo.Team.NetUpdateTime = Level.TimeSeconds - 1;
				Killer.PlayerReplicationInfo.NetUpdateTime = Level.TimeSeconds - 1;

				if(Killer.Pawn != None)
				{
					Inv = Killer.Pawn.FindInventoryType(class'InvasionProPetInventory');
					if(InvasionProPetInventory(Inv) != None && !InvasionProPetInventory(Inv).bCompanionPet)
					{
						if(InvasionProPetInventory(Inv).MyStats != None)
						{
							KillBonus = InvasionProPetInventory(Inv).MyStats.KBxP*InvasionProPetInventory(Inv).MyStats.Ability_KillBonus.KillBonusIncrease;
							InvasionProPetInventory(Inv).MyStats.ServerAwardPetPoints(KillBonus);
						}
					}
				}
			}

			Killer.AwardAdrenaline(KillScore);
		}
	}

	//update necro stuff
	if(MonsterController(Other) != None && !Other.isA('FriendlyMonsterController'))
	{
		if(Killer != None && (Killer.isA('FriendlyMonsterController')  || MonsterController(Killer) == None))
		{
			KillScore = UpdateTeamNecroScore(KillScore);
		}
	}

	if(Killer != None && Killer.PlayerReplicationInfo != None && Killer.PlayerReplicationInfo.Team != None)
	{
		TeamScoreEvent(Killer.PlayerReplicationInfo.Team.TeamIndex, 1, "tdm_frag");
	}
	else
	{
		TeamScoreEvent(0, 1, "tdm_frag");
	}

	CheckScore(None);
}

function int UpdateTeamNecroScore(int Score)
{
	local int TeamNecroAward;

	if(bTeamNecro)
	{
		TeamNecroAward = ( TeamNecroPercentage * Score ) / 100;
		if(TeamNecroAward < 1)
		{
			TeamNecroAward = 1;
		}

		Score = ( Score - TeamNecroAward );

		if(Score < 1)
		{
			Score = 1;
		}

		TeamNecroPool = Min(TeamNecroPool + TeamNecroAward,TeamNecroPoolMax);
		InvasionProGameReplicationInfo(GameReplicationInfo).TeamNecroPool = TeamNecroPool;
	}

	return Score;
}

function bool CanEnterVehicle(Vehicle V, Pawn P)
{
	return BaseMutator.CanEnterVehicle(V, P);
}

//removed instigator skill for monsters to scale damage better
function int ReduceDamage( int Damage, pawn injured, pawn instigatedBy, vector HitLocation, out vector Momentum, class<DamageType> DamageType )
{
    local int i, OriginalDamage, ScaleDamage;
    local float KillScore, PetScore, PetBonusXp, BonusDamage, DamageReduction, RetributionDamage;
    local Armor FirstArmor, NextArmor;
	local Inventory Inv, LightningInv;
	local InvasionProPetStatsItem StatsItem;

	OriginalDamage = Damage;
    //spawn protection
    if ( (InvasionProxPawn(injured) != None) && (Level.TimeSeconds - InvasionProxPawn(injured).SpawnTime < SpawnProtection || injured.InGodMode()) )
    {
		Damage = 0;
	}

	//if no one instigated it
    //if ( instigatedBy == None || injured == None)
    //{
		//if ( GameRulesModifiers != None )
		//{
			//return GameRulesModifiers.NetDamage( OriginalDamage, Damage,injured,instigatedBy,HitLocation,Momentum,DamageType );
		//}

       // return 0;
	//}

	if(instigatedby != None && instigatedBy.Controller != None)
	{
		if(injured != None && injured.Controller != None)
		{
			//monster on monster action + other on monster action
			if ( Monster(Injured) != None && Monster(instigatedBy) != None && CompareControllers(Injured.Controller, instigatedBy.Controller))
			{
				Damage = 0;
			}
		}

		//players and nalis
		if( Monster(Injured) == None && MonsterController(instigatedBy.Controller) == None && !InstigatedBy.Controller.IsA('SMPNaliFighterController') )
		{
			if(ClassIsChildOf(DamageType, class'DamTypeRoadkill'))
			{
				Damage = 0;
			}
		}
	}
    //boss and vehicles
    //denying "gibbed" damage type for bosses in attempt to stop sentinels telefragging them
    if( Monster(Injured) != None && MonsterIsBoss(Monster(Injured)) && (ClassIsChildOf(DamageType, class'DamTypeRoadkill') || ClassIsChildOf(DamageType, class'Gibbed')))
    {
		Damage = 0;
	}

	//damage against players by hostile monsters
	//so if the damge was done by a hostile monster
    if ( instigatedby != None && MonsterController(InstigatedBy.Controller) != None )
    {
		//friendly monster check also
		if(!InstigatedBy.Controller.isA('FriendlyMonsterController'))
		{
			//boss alterations
			if(Monster(InstigatedBy).bBoss)
			{
				Damage = Damage * GetBossDamage(Monster(InstigatedBy));
			}
			else
			{
				//else apply normal monster damage scale
				for(i=0;i<class'InvasionProMonsterTable'.default.MonsterTable.Length;i++)
				{
					if( class'InvasionProMonsterTable'.default.MonsterTable[i].MonsterClassName == string(Monster(InstigatedBy).Class) )
					{
						Damage = Damage * class'InvasionProMonsterTable'.default.MonsterTable[i].DamageMultiplier;
						ScaleDamage = (WaveNum/100) * Damage;
						Damage += ScaleDamage;
					}
				}
			}

			MonsterTeamScore += (Damage/2);
			TotalDamage = TotalDamage + Damage;
			UpdateMonsterTypeStats(InstigatedBy.Class, 0, Damage, 0);

			//check for defense aura && damage reduction && retribution aura
			//shield should apply first then damage reduction
			if(injured != None && Injured.Controller != None && Injured.Controller.PlayerReplicationInfo != None)
			{
				Inv = injured.FindInventoryType(class'InvasionProPetInventory');
				if(InvasionProPetInventory(Inv) != None && InvasionProPetInventory(Inv).MyStats != None)
				{
					if(!InvasionProPetInventory(Inv).bCompanionPet)
					{
						if(InvasionProPetInventory(Inv).MyStats.Aura == 3)
						{
							if(InvasionProPetInventory(Inv).AuraPower > Damage)
							{
								Spawn(class'InvasionProPetShieldFX',injured,,injured.Location);
								InvasionProPetInventory(Inv).AuraPower -= Damage;
								Damage = 0;
							}
							else
							{
								Damage -= InvasionProPetInventory(Inv).AuraPower;
								InvasionProPetInventory(Inv).AuraPower = 0;
							}
						}
						else if(InstigatedBy != None && InvasionProPetInventory(Inv).MyStats.Aura == 8)
						{
							RetributionDamage = ((InvasionProPetInventory(Inv).MyStats.Ability_AuraRetribution.AuraRetributionIncrease*InvasionProPetInventory(Inv).MyStats.AAXp)/100)*Damage;
							InstigatedBy.TakeDamage(RetributionDamage, Injured, InstigatedBy.Location, vect(0,0,0), class'DamType_PetAuraDamage');
						}
					}

					//damage reduction
					DamageReduction = ((InvasionProPetInventory(Inv).MyStats.Ability_DamageReduction.DamageReductionIncrease*InvasionProPetInventory(Inv).MyStats.ArmorXp)/100)*Damage;
					Damage = Damage - DamageReduction;
				}
			}
		}
		else if(InstigatedBy != None && Injured != None && InstigatedBy.Controller != None && InstigatedBy.Controller.PlayerReplicationInfo != None)
		{
			//give friendly monsters some score for damage
			//monster get 10% of damage done as points or killed health, whichever is lower
			//increase damage first then apply xp
			KillScore = FMin(Damage, injured.Health);
			KillScore = (KillScore/10);
			KillScore = FMax(KillScore,1);

			Inv = InstigatedBy.FindInventoryType(class'InvasionProPetInventory');
			if(InvasionProPetInventory(Inv) != None && InvasionProPetInventory(Inv).MyStats != None)
			{
				if(InvasionProPetInventory(Inv).MyStats.Aura == 6) //if pet has lightning aura
				{
					LightningInv = InstigatedBy.FindInventoryType(class'InvasionProPetLightningInventory');
					if(InvasionProPetLightningInventory(LightningInv) == None)
					{
						InvasionProPetInventory(Inv).DamagedPawn(Injured);
					}
				}
				//pet damage bonus check and pet xp awarded for damage
				//base damage calculations first
				//if damage wasnt done by the damage aura then apply damage increases
				if(!ClassIsChildOf(DamageType, class'DamType_PetAuraDamage'))
				{
					Damage = (InvasionProPetInventory(Inv).MyStats.PetLevel * class'InvasionProGameReplicationInfo'.default.DamageLevelMultiplier)+class'InvasionProGameReplicationInfo'.default.Ability_DamageBonus.BasePetDamage;
					BonusDamage = ((InvasionProPetInventory(Inv).MyStats.Ability_DamageBonus.DamageBonusIncrease*InvasionProPetInventory(Inv).MyStats.DmgXp)/100)*Damage;
					Damage = Damage + BonusDamage;
				}

				KillScore = FMin(Damage, injured.Health);
				KillScore = (KillScore/10);
				PetScore = KillScore;
				KillScore = FMax(KillScore,1);
				if(!InvasionProPetInventory(Inv).bCompanionPet)
				{
					InvasionProPetInventory(Inv).MyStats.ServerAwardPetPoints(PetScore);
					InvasionProPetInventory(Inv).MyStats.ServerAwardExperience(PetScore);
				}
			}

			InstigatedBy.Controller.PlayerReplicationInfo.Score += KillScore;
		}
    }
    else
    {
		if(instigatedby != None && injured != None && PlayerController(InstigatedBy.Controller) != None && Injured.PlayerReplicationInfo == None && Vehicle(Injured) == None)
		{
			StatsItem = GetPetStatsItem(PlayerController(InstigatedBy.Controller));
			if(StatsItem != None && StatsItem.MyPet != None && StatsItem.XpL > 0)
			{
				PetBonusXp = FMin(Damage, injured.Health);
				PetBonusXp = (PetBonusXp/100);
				StatsItem.ServerAwardExperience(PetBonusXp);
				StatsItem.ServerAwardPetPoints(PetBonusXp);
			}
		}

		if(Vehicle(Injured) != None)
		{
			Damage = 0;
		}
	}

    //bot damages now
    if ( Injured != None && InvasionBot(injured.Controller) != None )
    {
        if ( !InvasionBot(injured.controller).bDamagedMessage && (injured.Health - Damage < 50) )
        {
            InvasionBot(injured.controller).bDamagedMessage = true;
            if ( FRand() < 0.5 )
            {
                injured.Controller.SendMessage(None, 'OTHER', 4, 12, 'TEAM');
			}
            else
            {
                injured.Controller.SendMessage(None, 'OTHER', 13, 12, 'TEAM');
			}
        }

        if ( instigatedby != None && GameDifficulty <= 3 )
        {
            if ( injured.IsPlayerPawn() && (injured == instigatedby) && (Level.NetMode == NM_Standalone) )
            {
                Damage *= 0.5;
			}
        }
    }
	//same team
    if ( Injured != None && instigatedBy != None && instigatedBy != injured)
    {
        if ( (Injured.GetTeamNum() != 255) && (instigatedBy.GetTeamNum() != 255) )
        {
            if ( Injured.GetTeamNum() == instigatedBy.GetTeamNum() )
            {
                if ( class<WeaponDamageType>(DamageType) != None || class<VehicleDamageType>(DamageType) != None )
                    Momentum *= TeammateBoost;
                if ( (Bot(injured.Controller) != None) && (instigatedBy != None) )
                    Bot(Injured.Controller).YellAt(instigatedBy);
                else if ( (PlayerController(Injured.Controller) != None)
                        && Injured.Controller.AutoTaunt() )
                    Injured.Controller.SendMessage(instigatedBy.Controller.PlayerReplicationInfo, 'FRIENDLYFIRE', Rand(3), 5, 'TEAM');

                if ( FriendlyFireScale==0.0 || (Vehicle(injured) != None && Vehicle(injured).bNoFriendlyFire) )
                {
                        Damage = 0;
                }

                Damage *= FriendlyFireScale;
            }
            else if ( !injured.IsHumanControlled() && (injured.Controller != None)
                    && (injured.PlayerReplicationInfo != None) && (injured.PlayerReplicationInfo.HasFlag != None) )
                injured.Controller.SendMessage(None, 'OTHER', injured.Controller.GetMessageIndex('INJURED'), 15, 'TEAM');
        }
    }
	//then check if carrying armor
    if ( Injured != None && injured.Inventory != None && Damage > 0 )
    {
        FirstArmor = injured.inventory.PrioritizeArmor(Damage, DamageType, HitLocation);
        while( (FirstArmor != None) && (Damage > 0) )
        {
            NextArmor = FirstArmor.nextArmor;
            Damage = FirstArmor.ArmorAbsorbDamage(Damage, DamageType, HitLocation);
            FirstArmor = NextArmor;
        }
    }

	if ( GameRulesModifiers != None )
	{
		Damage = GameRulesModifiers.NetDamage( OriginalDamage, Damage,injured,instigatedBy,HitLocation,Momentum,DamageType );
	}

    return Damage;
}

function bool MonsterIsBoss(Pawn P)
{
	local Inventory Inv;

	if(P != None)
	{
		Inv = P.FindInventoryType(class'InvasionProMonsterIDInv');
		if(InvasionProMonsterIDInv(Inv) != None && InvasionProMonsterIDInv(Inv).bBoss)
		{
			return true;
		}
	}

	return false;
}

function float GetBossDamage(Monster M)
{
	local int i;
	local float DamageScale;
	local string MonsterName;

	MonsterName = "None";
	DamageScale = 1;

	for(i=0;i<class'InvasionProMonsterTable'.default.MonsterTable.Length;i++ )
	{
		if( class'InvasionProMonsterTable'.default.MonsterTable[i].MonsterClassName == string(M.Class) )
		{
			MonsterName = class'InvasionProMonsterTable'.default.MonsterTable[i].MonsterName;
			break;
		}
	}

	if(MonsterName != "None")
	{
		for(i=0;i<class'InvasionProConfigs'.default.Bosses.Length;i++ )
		{
			if( class'InvasionProConfigs'.default.Bosses[i].BossMonsterName == MonsterName )
			{
				DamageScale = class'InvasionProConfigs'.default.Bosses[i].BossDamageMultiplier;
				break;
			}
		}
	}

	return DamageScale;
}

function bool PreventDeath(Pawn Killed, Controller Killer, class<DamageType> damageType, vector HitLocation)
{
	local PlayerReplicationInfo PRI;

    if ( GameRulesModifiers != None && GameRulesModifiers.PreventDeath(Killed,Killer, damageType,HitLocation))
    {
		return true;
	}

	if(Monster(Killed) != None)
	{
		if(MonsterIsBoss(Monster(Killed)))
		{
			PRI = GetBossReplicationInfo(Monster(Killed));
			if(PRI != None)
			{
				Level.Game.BroadcastLocalizedMessage(class'InvasionProBossMessage', 1,PRI,,Killed);
			}
		}

		if(Killed.PlayerReplicationInfo != None)
		{
			if(InvasionProFriendlyMonsterReplicationInfo(Killed.PlayerReplicationInfo) != None)
			{
				if(!InvasionProFriendlyMonsterReplicationInfo(Killed.PlayerReplicationInfo).bMinion)
				{
					Level.Game.BroadcastLocalizedMessage(class'InvasionProMessage', 1,InvasionProFriendlyMonsterReplicationInfo(Killed.PlayerReplicationInfo).PRI,,Killed);
				}
			}
			else
			{
				Level.Game.BroadcastLocalizedMessage(class'InvasionProMessage', 1,Monster(Killed).PlayerReplicationInfo,,Killed);
			}
		}

	}

    return false;
}

function Killed( Controller Killer, Controller Killed, Pawn KilledPawn, class<DamageType> damageType )
{
    local TeamPlayerReplicationInfo TPRI;
    local PlayerReplicationInfo KilledPRI;

	if( Killed != None && MonsterController(Killed) == None)
	{
		KilledPRI=Killed.PlayerReplicationInfo;

		if(KilledPRI != None )
		{
			KilledPRI.NumLives--;
			KilledPRI.Score -= 10;
			KilledPRI.Team.Score -= 10;
			KilledPRI.Team.NetUpdateTime = Level.TimeSeconds - 1;

			if (KilledPRI.NumLives <= 0 )
			{
				KilledPRI.bOutOfLives = true;
				BroadcastLocalizedMessage(class'InvasionProMessage', 1, KilledPRI);
			}

			UpdatePlayerGRI();
		}
	}

    if(Killed != None)
    {
		if(Killed.bGodMode && Level.Netmode != NM_Standalone)
		{
			Killed.bGodMode = false;
		}
	}

	if(MonsterController(Killed) != None)
	{
		HostileMonsterKilled(Killer, Killed, KilledPawn);

		if(Killer != None && Killer.bIsPlayer)
		{
			TPRI = TeamPlayerReplicationInfo(Killer.PlayerReplicationInfo);
			if ( TPRI != None )
			{
				TPRI.AddWeaponKill(DamageType);
			}
		}
	}

	if( MonsterController(Killer) != None )
	{
		TotalKills++;
		UpdateMonsterTypeStats(Killer.Pawn.Class, 0, 0, 1);
	}

    Super(DeathMatch).Killed(Killer,Killed,KilledPawn,DamageType);
    CheckScore(None);
}

function DiscardInventory( Pawn Other )
{
    Other.Weapon = None;
    Other.SelectedItem = None;
    while ( Other.Inventory != None )
        Other.Inventory.Destroy();
}

function HostileMonsterKilled(Controller Killer, Controller Killed, Pawn KilledPawn)
{
	NumHostileMonsters();
	if(InvasionProGameReplicationInfo(GameReplicationInfo) != None)
	{
		InvasionProGameReplicationInfo(GameReplicationInfo).RemoveFriendlyMonster(Monster(KilledPawn));
	}

	if(!bBossWave && Monster(KilledPawn).bBoss)
	{
		return;
	}

	LastKilledMonsterClass = class<Monster>(KilledPawn.class);
	LastKilledMonsterScore = Monster(KilledPawn).ScoringValue;

	if(!bIncludeSummons && WasMonsterSummoned(KilledPawn))
	{
		return;
	}

	NumKilledMonsters++;
}

function bool WasMonsterSummoned(Pawn P)
{
	local Inventory Inv;

	Inv = P.FindInventoryType(class'InvasionProMonsterIDInv');

	if(InvasionProMonsterIDInv(Inv) != None)
	{
		return InvasionProMonsterIDInv(Inv).bSummoned;
		//return false;
	}

	return false;
}

function BossKilled()
{
	bBossActive = false;
	NumKilledMonsters++;
	CheckEndBossWave();
}

function CheckEndBossWave()
{
	local Monster M;
	local bool bFoundBoss;

	bFoundBoss = false;

	if(WaveBossID.Length <= 0) //all bosses have spawned
	{
		foreach DynamicActors(class'Monster', M)
		{
			if(M != None && M.Health > 0)
			{
				if(MonsterIsBoss(M))
				{
					//a boss is still in play
					 bFoundBoss = true;
					 bBossActive = true;
				}
			}
		}
	}
	else
	{
		//boss waiting to spawn
		bFoundBoss = true;
	}

	if(!bFoundBoss)
	{
		bBossActive = false;
		InvasionProGameReplicationInfo(GameReplicationInfo).bBossEncounter = false;
		bWaveInProgress = false;
		bBossWave = false;
		bInfiniteBossTime = false;
		WaveCountDown = 15;
		WaveNum++;
	}
}

function NotifyKilled(Controller Killer, Controller Killed, Pawn KilledPawn)
{}

function ForceNextWave()
{
	local Monster M;

	foreach DynamicActors(class'Monster', M)
	{
		if(M != None && M.Health > 0 && M.Controller != None)
		{
			if(!M.Controller.IsA('PetController') && !M.Controller.IsA('FriendlyMonsterController') )
			{
				M.KilledBy( M );
			}
		}
	}

	NewWave();
	bWaveInProgress = false;
	WaveCountDown = 15;
	WaveNum++;
}

function NewWave()
{
	//update new wave info, moved to here so invasioncommands etc.. also reset this info from SetupWave
	bBossWave = false;
	bBossActive = false;
	bInfiniteBossTime = false;
	InvasionProGameReplicationInfo(GameReplicationInfo).bBossEncounter = false;
}

function UnrealTeamInfo GetBotTeam(optional int TeamBots)
{
    return Teams[0];
}

function byte PickTeam(byte num, Controller C)
{
	if(MonsterController(C) != None)
	{
    	return 1;
	}
	else
	{
		return 0;
	}
}

function PlayEndOfMatchMessage()
{
    local controller C;
    local name EndSound;

    if ( WaveNum >= LastWave )
    {
        EndSound = EndGameSoundName[0];
	}
    else if ( WaveNum - (StartWave-1) == 0 )
    {
        EndSound = AltEndGameSoundName[1];
	}
    else
    {
        EndSound = InvasionEnd[Rand(6)];
	}

    for ( C = Level.ControllerList; C != None; C = C.NextController )
    {
        if ( C.IsA('PlayerController') )
        {
            PlayerController(C).PlayRewardAnnouncement(EndSound,1,true);
		}
	}
}

function float RatePlayerStart(NavigationPoint N, byte Team, Controller Player)
{
    local float Score, NextDist;
    local Controller OtherPlayer;

    if ( (Team == 0) || ((Player !=None) && Player.bIsPlayer) )
        return Super(xTeamGame).RatePlayerStart(N,Team,Player);

    if ( N.PhysicsVolume.bWaterVolume )
        return -10000000;

    //assess candidate
    if ( (SmallNavigationPoint(N) != None) && (PlayerStart(N) == None) )
        return -1;

    Score = 10000000;

    Score += 3000 * FRand(); //randomize

    for ( OtherPlayer=Level.ControllerList; OtherPlayer!=None; OtherPlayer=OtherPlayer.NextController)
        if ( (PlayerController(OtherPlayer) != None) && (OtherPlayer.Pawn != None) )
        {
            NextDist = VSize(OtherPlayer.Pawn.Location - N.Location);
            if ( NextDist < OtherPlayer.Pawn.CollisionRadius + OtherPlayer.Pawn.CollisionHeight )
                Score -= 1000000.0;
            else if ( NextDist > 5000 )
                Score -= 20000;
            else if ( NextDist < 3000 )
            {
                if ( (NextDist > 1200) && (Vector(OtherPlayer.Rotation) Dot (N.Location - OtherPlayer.Pawn.Location)) <= 0 )
                    Score = Score + 5000 - NextDist;
                else if ( FastTrace(N.Location, OtherPlayer.Pawn.Location) )
                    Score -= (10000.0 - NextDist);
                if ( (Location.Z > OtherPlayer.Pawn.Location.Z) && (NextDist > 1000) )
                    Score += 1000;
            }
        }
    return FMax(Score, 5);
}

function ReplenishWeapons(Pawn P)
{
    local Inventory Inv;

    for (Inv = P.Inventory; Inv != None; Inv = Inv.Inventory)
    {
        if (Weapon(Inv) != None && !Inv.IsA('Painter') && !Inv.IsA('Redeemer'))
        {
            Weapon(Inv).FillToInitialAmmo();
            Inv.NetUpdateTime = Level.TimeSeconds - 1;
        }
	}
}

function int GetNumPlayers()
{
	return NumPlayers + NumBots;
}

//get actual number of hostile monsters
function int NumHostileMonsters()
{
	local Monster M;
	local int i;

	foreach DynamicActors(class'Monster', M)
	{
		if(M != None && M.Health > 0 && M.Controller != None && !M.Controller.isA('FriendlyMonsterController') && !M.Controller.isA('PetController'))
		{
			i++;
		}
	}

	NumMonsters = i;
	return i;
}

function Actor GetMonsterTarget()
{
	local Controller C;

	for ( C = Level.ControllerList; C!=None; C=C.nextController )
	{
        if ( C.IsA('PlayerController') && (C.Pawn != None) )
        {
			return C.Pawn;
		}
	}
}
//current target is the Actor in question, C is the controller of the monster that should attack or not
function bool ShouldMonsterAttack(Actor CurrentTarget, Controller C)
{
	if(CurrentTarget != None && C != None)
	{
		if( Pawn(CurrentTarget) != None && Pawn(CurrentTarget).Controller != None )
		{
			if( Pawn(CurrentTarget).Controller.IsA('PetController') || Pawn(CurrentTarget).Controller.IsA('AnimalController'))
			{
				return false;
			}
			else if( C.IsA('MonsterController') )
			{
				if( Pawn(CurrentTarget).Controller.IsA('PlayerController') || Pawn(CurrentTarget).Controller.IsA('FriendlyMonsterController'))
				{
					return true;
				}
				else
				{
					return false;
				}
			}
			else if(  C.IsA('FriendlyMonsterController') )
			{
				if( Pawn(CurrentTarget).Controller.IsA('PlayerController') || Pawn(CurrentTarget).Controller.IsA('FriendlyMonsterController'))
				{
					return false;
				}
				else
				{
					return true;
				}
			}
		}
	}

	return false;
}

function UpdateMonsterTypeStats(class<Pawn> MClass, int AddSpawn, int AddDamage, int AddKills)
{
	local int i;
	local string MonsterTypeClass;

	MonsterTypeClass = String(MClass);
	for(i=0;i<class'InvasionProMonsterTable'.default.MonsterTable.Length;i++)
	{
		if(MonsterTypeClass ~= class'InvasionProMonsterTable'.default.MonsterTable[i].MonsterClassName)
		{
			class'InvasionProMonsterTable'.default.MonsterTable[i].NumSpawns += AddSpawn;
			class'InvasionProMonsterTable'.default.MonsterTable[i].NumDamage += AddDamage;
			class'InvasionProMonsterTable'.default.MonsterTable[i].NumKills += AddKills;
		}
	}
}

function UpdateGRI()
{
	 InvasionProGameReplicationInfo(GameReplicationInfo).CurrentMonstersNum = NumHostileMonsters();
	 InvasionProGameReplicationInfo(GameReplicationInfo).MonsterTeamScore = MonsterTeamScore;
	 InvasionProGameReplicationInfo(GameReplicationInfo).WaveNumber = WaveNum;
	 InvasionProGameReplicationInfo(GameReplicationInfo).TeamNecroPool = TeamNecroPool;
}

function Controller TeamResurrect()
{
	local Controller C, Lucky;
	local float Luck, MostLuck;

	if( !bTeamNecro || (TeamNecroPool < TeamNecroCost) )
	{
		return None;
	}

	Luck = 0;
	MostLuck = 0;
	Lucky = None;

	for ( C = Level.ControllerList; C != None; C = C.NextController )
	{
		if ( (C.PlayerReplicationInfo != None) && (C.IsA('PlayerController') || C.PlayerReplicationInfo.bBot) )
		{
			//NumLives check for bots spawned during game
			if ((C.PlayerReplicationInfo.bOutOfLives || C.PlayerReplicationInfo.NumLives <= 0) && !C.PlayerReplicationInfo.bOnlySpectator && C.Pawn == None)
			{
				Luck = rand(1000);
				//more luck for humands, +1000 should always favour humans equally over bots
				if(bFavorHumans && C.IsA('PlayerController'))
				{
					Luck += 1000;
				}

				if (Luck > MostLuck)
				{
					MostLuck= Luck;
					Lucky = C;
				}
			}
		}
	}

	return Lucky;
}

function NotifyResurrecteeTime(Controller C, int Message)
{
	if ( PlayerController(C) != None )
	{
		PlayerController(C).ReceiveLocalizedMessage(class'InvasionProNecroTimerMessages', Message);
	}
}

function NotifyResurrectee(Controller C)
{
	if ( PlayerController(C) != None )
	{
		PlayerController(C).ReceiveLocalizedMessage(class'InvasionProNecroMessages', 0);
	}
}

function bool PlayerCanRestart( PlayerController aPlayer )
{
    return true;
}

function float SpawnWait(AIController B)
{
    if ( B.PlayerReplicationInfo.bOutOfLives )
    {
        return 999;
	}

    if ( Level.NetMode == NM_Standalone )
    {
        if ( NumBots < 4 )
        {
            return 0;
		}

        return ( 0.5 * FMax(2,NumBots-4) * FRand() );
    }

    if ( bPlayersVsBots )
    {
        return 0;
	}

    return FRand();
}

function RestartPlayer( Controller aPlayer )
{
    local NavigationPoint startSpot;
    local int TeamNum;
    local class<Pawn> DefaultPlayerClass;
	local Vehicle V, Best;
	local vector ViewDir;
	local float BestDist, Dist;

    if ( aPlayer.PlayerReplicationInfo.bOutOfLives)
    {
        return;
	}

    if( bRestartLevel && Level.NetMode!=NM_DedicatedServer && Level.NetMode!=NM_ListenServer )
    {
        return;
	}

    if ( (aPlayer.PlayerReplicationInfo == None) || (aPlayer.PlayerReplicationInfo.Team == None) )
    {
        TeamNum = 255;
	}
    else
    {
		TeamNum = aPlayer.PlayerReplicationInfo.Team.TeamIndex;
	}

	if(MonsterController(aPlayer) != None)
	{
		TeamNum = 0;
	}
	else
	{
		TeamNum = 1;
	}

    startSpot = FindPlayerStart(aPlayer, TeamNum);
    if( startSpot == None )
    {
        log("Player start not found!",'InvasionPro');
        return;
    }

    if(aPlayer.PlayerReplicationInfo != None)
    {
    	aPlayer.PlayerReplicationInfo.NumLives = Max(1,aPlayer.PlayerReplicationInfo.NumLives);
		aPlayer.PlayerReplicationInfo.bOutOfLives = false;
	}

    if (aPlayer.PreviousPawnClass!=None && aPlayer.PawnClass != aPlayer.PreviousPawnClass)
    {
        BaseMutator.PlayerChangedClass(aPlayer);
	}

    if ( aPlayer.PawnClass != None )
    {
        aPlayer.Pawn = Spawn(aPlayer.PawnClass,,,StartSpot.Location,StartSpot.Rotation);
	}

    if( aPlayer.Pawn==None )
    {
        DefaultPlayerClass = GetDefaultPlayerClass(aPlayer);
        aPlayer.Pawn = Spawn(DefaultPlayerClass,,,StartSpot.Location,StartSpot.Rotation);
    }

    if ( aPlayer.Pawn == None )
    {
        log("Player waiting to spawn at "$StartSpot$". Spawn point obstructed.",'InvasionPro');
        aPlayer.GotoState('Dead');
        if ( PlayerController(aPlayer) != None )
        {
			PlayerController(aPlayer).ClientGotoState('Dead','Begin');
		}

        return;
    }
    if ( PlayerController(aPlayer) != None )
    {
		PlayerController(aPlayer).TimeMargin = -0.1;
	}
    aPlayer.Pawn.Anchor = startSpot;
	aPlayer.Pawn.LastStartSpot = PlayerStart(startSpot);
	aPlayer.Pawn.LastStartTime = Level.TimeSeconds;
    aPlayer.PreviousPawnClass = aPlayer.Pawn.Class;

    aPlayer.Possess(aPlayer.Pawn);
    aPlayer.PawnClass = aPlayer.Pawn.Class;

    aPlayer.Pawn.PlayTeleportEffect(true, true);
    aPlayer.ClientSetRotation(aPlayer.Pawn.Rotation);
    AddDefaultInventory(aPlayer.Pawn);
    TriggerEvent( StartSpot.Event, StartSpot, aPlayer.Pawn);

    if ( bAllowVehicles && (Level.NetMode == NM_Standalone) && (PlayerController(aPlayer) != None) )
    {
		// tell bots not to get into nearby vehicles for a little while
		BestDist = 2000;
		ViewDir = vector(aPlayer.Pawn.Rotation);
		for ( V=VehicleList; V!=None; V=V.NextVehicle )
			if ( V.bTeamLocked && (aPlayer.GetTeamNum() == V.Team) )
			{
				Dist = VSize(V.Location - aPlayer.Pawn.Location);
				if ( (ViewDir Dot (V.Location - aPlayer.Pawn.Location)) < 0 )
					Dist *= 2;
				if ( Dist < BestDist )
				{
					Best = V;
					BestDist = Dist;
				}
			}

		if ( Best != None )
			Best.PlayerStartTime = Level.TimeSeconds + 8;
	}

	UpdatePlayerGRI();
}

function bool BecomeSpectator(PlayerController P)
{
    if ( !Super.BecomeSpectator(P) )
    {
        return false;
	}

    if ( !bKillBots )
    {
        RemainingBots++;
	}

    if ( !NeedPlayers() || AddBot() )
    {
        RemainingBots--;
	}

    return true;
}

function bool AllowBecomeActivePlayer(PlayerController P)
{
	if(P != None)
	{
		if ( Level.NetMode == NM_Standalone || (WaveCountDown < 14 && WaveCountDown > 1) )
		{
			if(NumBots > InitialBots)
			{
				RemainingBots--;
			}

			bPlayerBecameActive = true;
			return true;
		}

		if(bWaveInProgress || P.IsInState('GameEnded'))
		{
			P.ReceiveLocalizedMessage(GameMessageClass, 13);
       		return false;
		}
	}

	return false;
}

function BalanceMonsters()
{
	if(bBalanceMonsters)
	{
		MaxMonsters = Max(1,GetNumPlayers() * NumMonstersPerPlayer);
	}
}

function bool ShouldStillResurrect()
{
	if(Resurrectee != None && Resurrectee.Pawn == None && !Resurrectee.PlayerReplicationInfo.bOnlySpectator)
	{
		return true;
	}

	return false;
}

function FreeResurrectee()
{
	InvasionProGameReplicationInfo(GameReplicationInfo).NecroName = "None";
	ResurrectTimer = 0;
	Resurrectee = None;
}

function OverTime()
{
	local Controller C;

	if(OverTimeDamage <= 0)
	{
		return;
	}

	for ( C = Level.ControllerList; C != None; C = C.NextController )
	{
		if(C != None && C.Pawn != None && C.Pawn.Health > 0 && (FriendlyMonsterController(C) != None || PlayerController(C) != None))
		{
			if(C.bGodMode && Level.Netmode != NM_Standalone)
			{
				C.bGodMode = false;
			}

			C.Pawn.TakeDamage(OverTimeDamage, C.Pawn, C.Pawn.Location, Vect(0,0,0), class'InvasionProBossDamType');
		}
	}
}

function UpdateMonsterTimer()
{
	if ( NumHostileMonsters() < (1.5 * GetNumPlayers() ) )
	{
		NextMonsterTime = Level.TimeSeconds + 0.2;
	}
	else
	{
		NextMonsterTime = Level.TimeSeconds + 2;
	}
}

function bool ShouldEndBossWave()
{
	return false;
}

function bool ShouldAdvanceWave()
{
	if(bBossWave)
	{
		return ShouldEndBossWave();
	}

	if(bWaveTimeLimit && Level.TimeSeconds > WaveEndTime)
	{
		return true;
	}

	if(bWaveMonsterLimit && WaveMonsters >= WaveMaxMonsters && NumHostileMonsters() <= 0)
	{
		return true;
	}

	return false;
}

function bool ShouldSpawnAnotherMonster()
{
	if(bWaveTimeLimit && Level.TimeSeconds > WaveEndTime)
	{
		return false;
	}

	if(bWaveMonsterLimit && WaveMonsters >= WaveMaxMonsters)
	{
		return false;
	}

	if(NumHostileMonsters() < MaxMonsters)
	{
		return true;
	}

	return false;
}

State MatchInProgress
{
    function Timer()
    {
		local Controller C;

		Super(xTeamGame).Timer();

		UpdatePets();
		BalanceMonsters();
		UpdateGRI();
		Regenerate();
		UpdatePlayerGRI();
		/*if(!bWaitingToStartMatch && GameReplicationInfo.bMatchHasBegun && Level.TimeSeconds > 5)//;/ && !NeedPlayers())
		{
			CheckScore(None);
		}*/

		if(bBossActive)
		{
			if(!bInfiniteBossTime)
			{
				if(BossTimeLimit <= 0)
				{
					InvasionProGameReplicationInfo(GameReplicationInfo).bOverTime = true;
					OverTime();
				}
				else
				{
					BossTimeLimit -= 1;
					InvasionProGameReplicationInfo(GameReplicationInfo).BossTimeLimit = BossTimeLimit;
					InvasionProGameReplicationInfo(GameReplicationInfo).bOverTime = false;
				}
			}
		}

        if ( bWaveInProgress )
        {
			if( Resurrectee != None && ShouldStillResurrect())
			{
				ResurrectTimer++;
				if( ResurrectTimer == 1 )
				{
					NotifyResurrectee(Resurrectee);
					InvasionProGameReplicationInfo(GameReplicationInfo).NecroName = Resurrectee.PlayerReplicationInfo.PlayerName;
				}
				else if( ResurrectTimer == 2 )
				{
					NotifyResurrecteeTime(Resurrectee, 3);
				}
				else if( ResurrectTimer == 4 )
				{
					NotifyResurrecteeTime(Resurrectee, 2);
				}
				else if( ResurrectTimer == 6 )
				{
					NotifyResurrecteeTime(Resurrectee, 1);
				}
				else if(ResurrectTimer == 8 )
				{
					Resurrectee.PlayerReplicationInfo.bOutOfLives = false;
					Resurrectee.PlayerReplicationInfo.NumLives = 1;
					if ( PlayerController(Resurrectee) != None )
					{
						PlayerController(Resurrectee).GotoState('PlayerWaiting');
					}
					else
					{
						//else ress bot?
						Resurrectee.ServerReStartPlayer();
					}

					TeamNecroPool -= TeamNecroCost;
					BroadcastLocalizedMessage(class'InvasionProNecroMessages', 1, Resurrectee.PlayerReplicationInfo);
					Resurrectee = None;
					ResurrectTimer = 0;
					InvasionProGameReplicationInfo(GameReplicationInfo).NecroName = "None";
				}
			}
			else
			{
				FreeResurrectee();
				Resurrectee = TeamResurrect();
			}

			if(!bBossWave)
			{
				if(!ShouldAdvanceWave())
				{
					if(ShouldSpawnAnotherMonster() && Level.TimeSeconds > NextMonsterTime)
					{
						AddMonster();
						UpdateMonsterTimer();
					}
				}
				else //else no more spawns via invasion, start culling monsters that are not in sight
				{
				 	CullMonsters(true, true, false);
					if(NumHostileMonsters() <= 0)
                	{
                   		bWaveInProgress = false;
                    	WaveCountDown = 15;
                    	WaveNum++;
                	}
				}
			}
			else
			{
				if(!bBossActive)
				{
					FallbackTimer += 1.0;
					if(!bIgnoreFallback && FallBackTimer > 10.0)
					{
						bFallback = true;
					}

					if(FallBackTimer > 20.0)
					{
						//fallback failed also, skip wave
						ForceNextWave();
						FallBackTimer = 0.0;
						return;
					}
				}
				else
				{
					FallBackTimer = 0.0;
				}

				AddMonster();
			}
		}
		else if ( NumHostileMonsters() <= 0 ) //else countdown new wave
		{
			if ( WaveNum == LastWave )
			{
				//CheckScore(None);
				EndGame(None,"Success");
				return;
			}

			FreeResurrectee();
			WaveCountDown--;
			if ( WaveCountDown == 14 )
			{
				InvasionProGameReplicationInfo(GameReplicationInfo).WaveDrawColour = class'InvasionProConfigs'.default.Waves[WaveNum].WaveDrawColour;
				InvasionProGameReplicationInfo(GameReplicationInfo).bPlayersCanJoin = true;
				//take this fairly good chance to update stats
				UpdateMonsterStats();
				class'InvasionProMonsterTable'.static.StaticSaveConfig();
				for ( C = Level.ControllerList; C != None; C = C.NextController )
				{
					if ( C.PlayerReplicationInfo != None )
					{
						C.PlayerReplicationInfo.bOutOfLives = false;
						UpdatePlayerLives();
						if ( C.Pawn != None )
						{
							ReplenishWeapons(C.Pawn);
						}
						else if ( !C.PlayerReplicationInfo.bOnlySpectator && (PlayerController(C) != None) )
						{
							C.GotoState('PlayerWaiting');
						}
					}
				}
			}
			if ( WaveCountDown == 13 )
			{
				for ( C = Level.ControllerList; C != None; C = C.NextController )
				{
					if ( PlayerController(C) != None )
					{
						PlayerController(C).PlayStatusAnnouncement('Next_wave_in',1,true);
						if ( (C.Pawn == None) && !C.PlayerReplicationInfo.bOnlySpectator )
						{
							PlayerController(C).SetViewTarget(C);
						}
					}
					if ( C.PlayerReplicationInfo != None )
					{
						C.PlayerReplicationInfo.bOutOfLives = false;
						UpdatePlayerLives();
						if ( (C.Pawn == None) && !C.PlayerReplicationInfo.bOnlySpectator )
						{
							C.ServerReStartPlayer();
						}
					}
				}
			}
			else if ( (WaveCountDown > 1) && (WaveCountDown < 12) )
			{
				BroadcastLocalizedMessage(class'InvasionProWaveCountDownMessage', WaveCountDown-1);
			}
			else if ( WaveCountDown <= 1 ) //new wave start
			{
				InvasionProGameReplicationInfo(GameReplicationInfo).bPlayersCanJoin = false;
				bWaveInProgress = true;
				SetUpWave(); //set new wave settings
				for ( C = Level.ControllerList; C != None; C = C.NextController )
				{
					if ( PlayerController(C) != None )
					{
						PlayerController(C).LastPlaySpeech = 0;
					}
				}

				CoordinateBots();
				WaveNotification();
			}
		}
    }

    function BeginState()
    {
        Super(xTeamGame).BeginState();
        WaveNum = (StartWave-1);
        InvasionProGameReplicationInfo(GameReplicationInfo).WaveNumber = WaveNum;
    }
}

function CoordinateBots()
{
	local Bot B;
	local Controller C;
	local bool bOneMessage;

	for ( C = Level.ControllerList; C != None; C = C.NextController )
	{
		if ( Bot(C) != None )
		{
			B = Bot(C);

			InvasionBot(B).bDamagedMessage = false;
			B.bInitLifeMessage = false;
			if ( !bOneMessage && (FRand() < 0.65) )
			{
				bOneMessage = true;
				if ( (B.Squad.SquadLeader != None) && B.Squad.CloseToLeader(C.Pawn) )
				{
					B.SendMessage(B.Squad.SquadLeader.PlayerReplicationInfo, 'OTHER', B.GetMessageIndex('INPOSITION'), 20, 'TEAM');
					B.bInitLifeMessage = false;
				}
			}
		}
	}
}

function bool AddBot(optional string botName)
{
    local Bot NewBot;

    NewBot = SpawnBot(botName);
    if ( NewBot == None )
    {
        warn("Failed to spawn bot.");
        return false;
    }
    // broadcast a welcome message.
    BroadcastLocalizedMessage(GameMessageClass, 1, NewBot.PlayerReplicationInfo);

    NewBot.PlayerReplicationInfo.PlayerID = CurrentID++;
    NumBots++;
    if ( Level.NetMode == NM_Standalone )
    {
        RestartPlayer(NewBot);
	}
    else
    {
		NewBot.GotoState('Dead','MPStart');
		NewBot.PlayerReplicationInfo.bOutOfLives = true;
		NewBot.PlayerReplicationInfo.NumLives = 0;
	}

	UpdatePlayerGRI();
    return true;
}

function Bot SpawnBot(optional string botName)
{
    local Bot NewBot;
    local RosterEntry Chosen;
    local UnrealTeamInfo BotTeam;
    local array<xUtil.PlayerRecord> PlayerRecords;
    local xUtil.PlayerRecord PR;

    BotTeam = GetBotTeam();
    if ( bCustomBots && (class'DMRosterConfigured'.Default.Characters.Length > NumBots)  )
    {
        class'xUtil'.static.GetPlayerList(PlayerRecords);
        PR = class'xUtil'.static.FindPlayerRecord(class'DMRosterConfigured'.Default.Characters[NumBots]);
        Chosen = class'xRosterEntry'.Static.CreateRosterEntry(PR.RecordIndex);
    }

    if ( Chosen == None )
    {
        if ( SecondBot > 0 )
        {
            BotName = InvasionBotNames[SecondBot + 1];
            SecondBot++;
            if ( SecondBot > 6 )
                SecondBot = 0;
        }
        else
        {
            SecondBot = 1 + 2 * Rand(4);
            BotName = InvasionBotNames[SecondBot];
        }
        Chosen = class'xRosterEntry'.static.CreateRosterEntryCharacter(botName);
    }
    if (Chosen.PawnClass == None)
        Chosen.Init();
    NewBot = Spawn(class'InvasionProBot');

    if ( NewBot != None )
    {
        AdjustedDifficulty = AdjustedDifficulty + 2;
        InitializeBot(NewBot,BotTeam,Chosen);
        AdjustedDifficulty = AdjustedDifficulty - 2;
        NewBot.bInitLifeMessage = true;
    }
    return NewBot;
}

function CullMonsters(bool bSightCheck, bool bHostile, bool bFriend)
{
	local Controller C;

	//force all hostile monsters to suicide
	for ( C = Level.ControllerList; C != None; C = C.NextController )
	{
		if(C.Pawn != None && C.Pawn.Health > 0)
		{
			if(bHostile && MonsterController(C) != None && C.PlayerReplicationInfo == None)
			{
				if(bSightCheck)
				{
					if(Level.TimeSeconds - MonsterController(C).LastSeenTime > 30 && !MonsterController(C).Pawn.PlayerCanSeeMe() )
					{
						C.Pawn.Health = 0;
						C.Pawn.Died(None, class'Suicided', C.Pawn.Location );
						//MonsterController(C).Pawn.KilledBy( MonsterController(C).Pawn );
					}
				}
				else
				{
					//MonsterController(C).Pawn.KilledBy( MonsterController(C).Pawn );
					C.Pawn.Health = 0;
					C.Pawn.Died(None, class'Suicided', C.Pawn.Location );
				}
			}
			else if(bFriend && (C.PlayerReplicationInfo != None || C.IsA('PetController')) )
			{
				if(bSightCheck)
				{
					if(!C.Pawn.PlayerCanSeeMe() )
					{
						C.Pawn.Health = 0;
						C.Pawn.Died(None, class'Suicided', C.Pawn.Location );
						//C.Pawn.KilledBy( C.Pawn );
					}
				}
				else
				{
					C.Pawn.Health = 0;
					C.Pawn.Died(None, class'Suicided', C.Pawn.Location );
					//C.Pawn.KilledBy( C.Pawn );
				}
			}

			return;
		}
	}
}

function AddMonster()
{
    local NavigationPoint StartSpot; //spawn location
    local Monster NewMonster; //the newly spawned monster
    local class<Monster> NewMonsterClass; //current monster to spawn
    local int i;
    local Inventory Inv;

	if(!bBossWave)
	{
		NewMonsterClass = WaveMonsterClass[Rand(WaveNumClasses)];
		if(NewMonsterClass != None)
		{
		    StartSpot = FindPlayerStart(None,0, string(NewMonsterClass));
			//if can't find a playerstart then stop.
			if ( StartSpot == None )
			{
				log("Cannot find valid Navigation Point to spawn Monster",'InvasionPro');
				return;
			}

			NewMonster = Spawn(NewMonsterClass,,,StartSpot.Location+(NewMonsterClass.Default.CollisionHeight - StartSpot.CollisionHeight) * vect(0,0,1),StartSpot.Rotation);
		}

		if ( NewMonster ==  None )
		{
			StartSpot = FindPlayerStart(None,0, string(FallBackMonster));
			//else spawn the fall back using an average monsters size specifications
			NewMonster = Spawn(FallBackMonster,,,StartSpot.Location+(FallBackMonster.Default.CollisionHeight - StartSpot.CollisionHeight) * vect(0,0,1),StartSpot.Rotation);
		}

		if ( NewMonster != None )
		{
			TotalSpawned++;
			WaveMonsters++;
			UpdateMonsterTypeStats(NewMonster.Class, 1, 0, 0);
			//InvasionProMutator(BaseMutator).ModifyMonster(NewMonster,false,false);
			Inv = NewMonster.FindInventoryType(class'InvasionProMonsterIDInv');
			if(InvasionProMonsterIDInv(Inv) != None)
			{
				InvasionProMonsterIDInv(Inv).bSummoned = false;
				InvasionProMonsterIDInv(Inv).bBoss = false;
				InvasionProMonsterIDInv(Inv).bFriendly = false;
			}
		}
	}
	else
	{
		if(class'InvasionProConfigs'.default.Waves[WaveNum].bBossesSpawnTogether)
		{
			for(i=0;i<WaveBossID.Length;i++)
			{
				SpawnBoss(int(WaveBossID[i]));
			}

			if(WaveBossID.Length <= 0)
			{
				if(!bIgnoreFallback)
				{
					FallbackTimer = 0;
					bFallback = true;
					SpawnBoss(0);
				}
				else
				{
					CheckEndBossWave();
				}
			}
		}
		else if(ShouldSummonBoss())
		{
			//else if no boss active then time to summon another (if any left)
			if(WaveBossID.Length > 0)
			{
				SpawnBoss(int(WaveBossID[0]));
			}
			else
			{

				if(!bIgnoreFallback)
				{
					FallbackTimer = 0;
					bFallback = true;
					SpawnBoss(0);
				}
				else
				{
					CheckEndBossWave();
				}
			}
		}
	}

	NumHostileMonsters();
}

function bool ShouldSummonBoss()
{
	local Monster M;

	foreach DynamicActors(class'Monster', M)
	{
		if(M != None && M.Health > 0)
		{
			if(MonsterIsBoss(M))
			{
				return false;
			}
		}
	}

	return true;
}

function ResetBosses()
{

}

function SetUpWave()
{
	local int i; //to cycle through various monster lists
	local int h; //to cycle through sub lists such as monsterlist
	local string FallBackMonsterName; //short hand fallbackmonster, will be made into a full class in order to load
	local class<Monster> CurrentMonsterClass; //current monster class being loaded

	NewWave(); //update custom info incase wave was skipped
	UpdateMaxLives(); //update wave max lives
	UpdatePlayerLives();//update player lives and deaths

	bIgnoreFallback = false;
	WaveMonsters = 0; //the number of monsters spawned so far, this should be 0 at this stage
	MaxMonsters = class'InvasionProConfigs'.default.Waves[WaveNum].MaxMonsters; //update new max monsters allowed (over ridden if bBalanceMonsters)
	WaveMaxMonsters = class'InvasionProConfigs'.default.Waves[WaveNum].WaveMaxMonsters; //update new wave max monsters (total monsters to spawn)

	if(!bWaveTimeLimit && !bWaveMonsterLimit)
	{
		//default to wave time limit
		bWaveTimeLimit = True;
		class'InvasionProConfigs'.default.Waves[WaveNum].WaveDuration = 90;
	}

	WaveEndTime = Level.TimeSeconds + class'InvasionProConfigs'.default.Waves[WaveNum].WaveDuration; //update the new waves wave duration
	AdjustedDifficulty = GameDifficulty + class'InvasionProConfigs'.default.Waves[WaveNum].WaveDifficulty; //game difficulty setting, changes AI
	WaveNumClasses = 0; //set number of available monster classes to 0
	NumKilledMonsters = 0;
	bFallback = false;
	ResetBosses();

	//set up monster list
	for(i=0;i<30;i++)
	{
		//set to None each time, so we don't add the same monster when we shouldn't
		CurrentMonsterClass = None;

		for(h=0;h<class'InvasionProMonsterTable'.default.MonsterTable.Length;h++)
		{
			//search for matching monster classes
			if(class'InvasionProConfigs'.default.Waves[WaveNum].Monsters[i] != "None" && class'InvasionProConfigs'.default.Waves[WaveNum].Monsters[i] ~= class'InvasionProMonsterTable'.default.MonsterTable[h].MonsterName)
			{
				CurrentMonsterClass = class<Monster>(DynamicLoadObject(class'InvasionProMonsterTable'.default.MonsterTable[h].MonsterClassName, class'Class',true));
			}
		}

		if(CurrentMonsterClass != None)
		{
			WaveMonsterClass[WaveNumClasses] = CurrentMonsterClass;
			WaveNumClasses++;
		}
	}
	//set up fallback monster
	FallBackMonsterName = class'InvasionProConfigs'.default.Waves[WaveNum].WaveFallbackMonster; //get fall back monster name
	if(FallBackMonsterName != "None")
	{
		for(i=0;i<class'InvasionProMonsterTable'.default.MonsterTable.Length;i++)
		{
			//search for matching fall back monster class
			if(FallBackMonsterName ~= class'InvasionProMonsterTable'.default.MonsterTable[i].MonsterName)
			{
				FallBackMonster = class<Monster>(DynamicLoadObject(class'InvasionProMonsterTable'.default.MonsterTable[i].MonsterClassName, class'Class',true));
			}
		}
	}
	else
	{
		FallBackMonster = default.FallBackMonster;
	}

	//set up current boss information
	if(class'InvasionProConfigs'.default.Waves[WaveNum].bBossWave)//is this a boss wave
	{
		BossTimeLimit = class'InvasionProConfigs'.default.Waves[WaveNum].BossTimeLimit;
		bInfiniteBossTime = (BossTimeLimit <= 0);
		InvasionProGameReplicationInfo(GameReplicationInfo).bInfiniteBossTime = bInfiniteBossTime;
		OverTimeDamage = class'InvasionProConfigs'.default.Waves[WaveNum].BossOverTimeDamage;
		bBossWave = true;
		SetUpBosses();
	}
}

function SetUpBosses()
{
	WaveBossID.Remove(0,WaveBossID.Length);
	if(class'InvasionProConfigs'.default.Waves[WaveNum].BossID != "")
	{
		if(InStr(class'InvasionProConfigs'.default.Waves[WaveNum].BossID, ",") != -1)
		{
			Split(class'InvasionProConfigs'.default.Waves[WaveNum].BossID, ",", WaveBossID);
		}
		else
		{
			WaveBossID.Insert(0,1);
			WaveBossID[0] = class'InvasionProConfigs'.default.Waves[WaveNum].BossID;
		}
	}
}

function SpawnBoss(int TempBossID)
{
	local class <Monster> BossClass;
	local int FallbackBossID;
	local int BossNum;
	local int i;
	local NavigationPoint StartSpot; //spawn location
	local Monster NewMonster; //the newly spawned monster
    local Controller C;
    local Sound WarnSound;
    local Inventory Inv;
    local InvasionProBossReplicationInfo BRI;
    local string BossNameLeft, BossNameRight, BossName;

	//get the bosses Id
	FallbackBossID = class'InvasionProConfigs'.default.Waves[WaveNum].FallbackBossID;

	if(!bFallback)
	{
		BossClass = GetBossClass(TempBossID, BossNum);
	}
	else
	{
		BossClass = GetBossClass(FallbackBossID, BossNum);
	}

	//spawn boss
	if(BossClass != None)
	{
	    StartSpot = FindPlayerStart(None,0, string(BossClass));
		//if can't find a playerstart then stop.
		if ( StartSpot == None )
		{
			log("Cannot find valid Navigation Point to spawn Boss",'InvasionPro');
			return;
		}

		NewMonster = Spawn(BossClass,,,StartSpot.Location+(BossClass.Default.CollisionHeight - StartSpot.CollisionHeight) * vect(0,0,1),StartSpot.Rotation);
		if ( NewMonster != None )
		{
			//a boss has spawned, whether fallback or not, so no need to fallback again
			bIgnoreFallback = true;
			//boss spawned remove from wave boss ids
			if(bFallback)
			{
				for(i=0;i<WaveBossID.Length;i++)
				{
					WaveBossID.Remove(i, 1);
				}
			}
			else
			{
				for(i=0;i<WaveBossID.Length;i++)
				{
					if(String(TempBossID) ~= WaveBossID[i])
					{
						WaveBossID.Remove(i, 1);
						break;
					}
				}
			}

			BRI = Spawn(class'InvasionProBossReplicationInfo',NewMonster);
			if(BRI != None)
			{
				BRI.MyMonster = NewMonster;
				BRI.PlayerName = class'InvasionProConfigs'.default.Bosses[BossNum].BossName;
			}

			if(class'InvasionProConfigs'.default.Bosses[BossNum].WarningSound != "" && class'InvasionProConfigs'.default.Bosses[BossNum].WarningSound != "None")
			{
				for(C=Level.ControllerList; C!=None; C=C.NextController )
				{
					if ((C != None && C.PlayerReplicationInfo != None) && (C.IsA('PlayerController') || !C.PlayerReplicationInfo.bBot))
					{
						WarnSound = Sound(DynamicLoadObject(class'InvasionProConfigs'.default.Bosses[BossNum].WarningSound,class'Sound',True));
						if(WarnSound != None)
						{
							PlayerController(C).ClientReliablePlaySound(WarnSound);
						}
					}
				}
			}

			LastBossSpawnTime = Level.TimeSeconds;
			//InvasionProMutator(BaseMutator).ModifyMonster(NewMonster,false,true);
			bBossActive = true;
			if(class'InvasionProConfigs'.default.Bosses[BossNum].BossHealth <= 0)
			{
				NewMonster.Health = NewMonster.default.Health;
			}
			else
			{
				NewMonster.Health = class'InvasionProConfigs'.default.Bosses[BossNum].BossHealth;
			}

			InvasionProGameReplicationInfo(GameReplicationInfo).bBossEncounter = true;
			NewMonster.GroundSpeed = class'InvasionProConfigs'.default.Bosses[BossNum].BossGroundSpeed;
			NewMonster.AirSpeed = class'InvasionProConfigs'.default.Bosses[BossNum].BossAirSpeed;
			NewMonster.WaterSpeed = class'InvasionProConfigs'.default.Bosses[BossNum].BossWaterSpeed;
			NewMonster.JumpZ =  class'InvasionProConfigs'.default.Bosses[BossNum].BossJumpZ;
			NewMonster.HealthMax = NewMonster.Health;
			NewMonster.GibCountCalf *= class'InvasionProConfigs'.default.Bosses[BossNum].BossGibMultiplier;
			NewMonster.GibCountForearm *= class'InvasionProConfigs'.default.Bosses[BossNum].BossGibMultiplier;
			NewMonster.GibCountHead *= class'InvasionProConfigs'.default.Bosses[BossNum].BossGibMultiplier;
			NewMonster.GibCountTorso *= class'InvasionProConfigs'.default.Bosses[BossNum].BossGibMultiplier;
			NewMonster.GibCountUpperArm *= class'InvasionProConfigs'.default.Bosses[BossNum].BossGibMultiplier;
			NewMonster.ScoringValue = class'InvasionProConfigs'.default.Bosses[BossNum].BossScoreAward;
			NewMonster.SetLocation( NewMonster.Location + vect(0,0,1) * ( NewMonster.CollisionHeight * class'InvasionProConfigs'.default.Bosses[BossNum].NewDrawScale) );

			if(class'InvasionProConfigs'.default.Bosses[BossNum].NewDrawScale <= 0)
			{
				NewMonster.SetDrawScale(NewMonster.default.DrawScale);
			}
			else
			{
				NewMonster.SetDrawScale(class'InvasionProConfigs'.default.Bosses[BossNum].NewDrawScale);
			}

			if(class'InvasionProConfigs'.default.Bosses[BossNum].NewCollisionRadius <= 0 || class'InvasionProConfigs'.default.Bosses[BossNum].NewCollisionHeight <= 0)
			{
				NewMonster.SetCollisionSize(NewMonster.default.CollisionRadius,NewMonster.default.CollisionHeight);
			}
			else
			{
				NewMonster.SetCollisionSize(class'InvasionProConfigs'.default.Bosses[BossNum].NewCollisionRadius,class'InvasionProConfigs'.default.Bosses[BossNum].NewCollisionHeight);
			}

			NewMonster.Prepivot = class'InvasionProConfigs'.default.Bosses[BossNum].NewPrepivot;
			UpdateMonsterTypeStats(NewMonster.Class, 1, 0, 0);
			Inv = NewMonster.FindInventoryType(class'InvasionProMonsterIDInv');
			if(InvasionProMonsterIDInv(Inv) != None)
			{
				BossName = class'InvasionProConfigs'.default.Bosses[BossNum].BossName;
				if(BossName ~= "")
				{
					Divide(String(NewMonster.Class),".",BossNameLeft,BossNameRight);
					BossName = "Boss ("$BossNameRight$")";
				}

				InvasionProMonsterIDInv(Inv).MonsterName = BossName;
				InvasionProMonsterIDInv(Inv).bSummoned = false;
				InvasionProMonsterIDInv(Inv).bBoss = true;
				InvasionProMonsterIDInv(Inv).bFriendly = false;
			}
		}
		else
		{
			if(!bFallback)
			{
				log("Wave "@WaveNum+1@"Boss failed to spawn: maybe too large."@" Boss ID "@TempBossID,'InvasionPro');
			}
			else
			{
				log("Wave "@WaveNum+1@" Fallback boss failed to spawn, check the monsters name and id settings are correct and match the wave boss ids.",'InvasionPro');
			}
		}
	}
	else
	{
		log("Wave Num "@WaveNum+1@" No boss found with ID"@TempBossID$", maybe the BossMonsterName or BossID is wrong?",'InvasionPro');
		//remove from wave boss ids
		for(i=0;i<WaveBossID.Length;i++)
		{
			if(String(TempBossID) ~= WaveBossID[i])
			{
				WaveBossID.Remove(i, 1);
			}
		}
	}
}

function class<Monster> GetBossClass(int ID, out int BossNum)
{
	local int i;
	local string TempBossName; //short boss name that will be made into a full class name in order to load
	local class <Monster> BossClass;

	BossClass = None;
	TempBossName = "None"; //set name to none incase config was none
	//match the id by searching the list of bosses
	for(i=0;i<class'InvasionProConfigs'.default.Bosses.Length;i++)
	{
		//if the bossid matches any of the ones in the list
		if(ID == class'InvasionProConfigs'.default.Bosses[i].BossID)// && !class'InvasionProConfigs'.default.Bosses[i].bSpawned)
		{
			//get the temp boss name
			TempBossName = class'InvasionProConfigs'.default.Bosses[i].BossMonsterName;
			BossNum = i;
			break;
		}
	}

	//if a boss was found
	if(TempBossName != "None")
	{
		//search monster list for matching monster
		for(i=0;i<class'InvasionProMonsterTable'.default.MonsterTable.Length;i++)
		{
			//if boss name matchess
			if(TempBossName ~= class'InvasionProMonsterTable'.default.MonsterTable[i].MonsterName)
			{
				//set the boss class!
				BossClass = class<Monster>(DynamicLoadObject(class'InvasionProMonsterTable'.default.MonsterTable[i].MonsterClassName, class'Class',true));
				break;
			}
		}
	}

	return BossClass;
}

function DestroyBossReplicationInfo()
{
	local InvasionProBossReplicationInfo BRI;

	foreach DynamicActors(class'InvasionProBossReplicationInfo',BRI)
	{
		BRI.Destroy();
	}
}

function InvasionProBossReplicationInfo GetBossReplicationInfo(Monster M)
{
	local InvasionProBossReplicationInfo BRI;

	foreach DynamicActors(class'InvasionProBossReplicationInfo',BRI)
	{
		if(BRI.MyMonster == M)
		{
			return BRI;
		}
	}

	return None;
}

function WaveNotification()
{
	BroadcastLocalizedMessage(class'InvasionProWaveMessage', WaveNum,,,WaveNames);
}

function Regenerate()
{
	local Controller C;

	if(bRegenPlayers)
	{
		for ( C = Level.ControllerList; C!=None; C=C.NextController )
		{
			if ( C.Pawn != None && Vehicle(C.Pawn) == None && ( C.IsA('PlayerController') || (C.bIsPlayer && !C.IsA('PlayerController'))) )
			{
				C.Pawn.GiveHealth( RegenAmount, C.Pawn.HealthMax );
			}
		}
	}

	if(bRegenMonsters) //not friendly monsters
	{
		for ( C = Level.ControllerList; C!=None; C=C.nextController )
		{
        	if ( !C.bIsPlayer && C.IsA('MonsterController') && C.PlayerReplicationInfo == None)
        	{
				C.Pawn.Health = Min( C.Pawn.Health + RegenAmount, C.Pawn.HealthMax );
			}
		}
	}
}

static function FillPlayInfo(PlayInfo PI)
{
	local UT2K4Tab_MainSP Menu;

    Super(xTeamGame).FillPlayInfo(PI);

    PI.AddSetting(default.InvasionProGroup, "Waves", GetDisplayText("Waves"), 60, 1, "Custom", ";;"$default.WaveConfigMenu,,,);
    PI.AddSetting(default.InvasionProGroup, "Monsters", GetDisplayText("Monsters"), 60, 2, "Custom", ";;"$default.MonsterConfigMenu,,,);
    PI.AddSetting(default.InvasionProGroup, "Bosses", GetDisplayText("Bosses"), 60, 3, "Custom", ";;"$default.BossConfigMenu,,,);
    PI.AddSetting(default.InvasionProGroup, "MonsterStats", GetDisplayText("MonsterStats"), 60, 4, "Custom", ";;"$default.MonsterStatsConfigMenu,,,);
    PI.AddSetting(default.InvasionProGroup, "InvasionProSettings", GetDisplayText("InvasionProSettings"), 60, 0, "Custom", ";;"$default.InvasionProConfigMenu,,,);
	PI.AddSetting(default.InvasionProGroup ,"LastWave","Final Wave", 0, 7, "Text","6;"$default.StartWave+1$":999999",,False,True);
	PI.AddSetting(default.InvasionProGroup ,"StartWave","Initial Wave", 0, 6, "Text","6;0:"$default.LastWave-1,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bRegenPlayers","Players Regenerate", 0, 8, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"RegenAmount","Player Regen Amount", 0, 9, "Text","6;0:999999",,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bRegenMonsters","Monsters Regenerate", 0, 10, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"MonsterRegenAmount","Monster Regen Amount", 0, 11, "Text","6;0:999999",,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bBalanceMonsters","Balance Monsters", 60, 12, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bShareBossPoints","Share Boss Points", 0, 13, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bDisableBerserk","Disable Berserk", 0, 35, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bDisableSpeed","Disable Speed", 0, 36, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bDisableInvis","Disable Invis", 0, 37, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bDisableDefensive","Disable Defensive", 0, 38, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bDisableHealthPacks","Disable Health Packs", 0, 39, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bDisableHealthVials","Disable Health Vials", 0, 40, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bDisableAdrenalinePickups","Disable Adrenaline Pickups", 0, 45, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bDisableAmmoPickups","Disable Ammo Pickups", 0, 41, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bDisableWeaponLockers","Diable Weapon Lockers", 0, 42, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bDisableWeapons","Disable Weapon Pickups", 0, 43, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bDisableSuperPickups","Disable Super Pickups", 0, 44, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bPermitVehicles","Allow Vehicles", 0, 16, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bPreloadMonsters","Preload Monsters", 0, 15, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bSpawnAtBases","Spawn at Bases", 0, 14, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bFavorHumans","Necro Favors Humans", 0, 27, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bHideRadar","Hide Radar", 0, 34, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bHidePlayerList","Hide Player List", 0, 33, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bHideNecroPool","Hide Necro Pool", 0, 31, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bHideMonsterCount","Hide Monster Count", 0, 32, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bIncludeSummons","Include Summoned Monsters", 0, 22, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bWaveTimeLimit","Time Limit Ends Waves", 0, 17, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bWaveMonsterLimit","Monster Limit Ends Waves", 0, 18, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bPetMode","Pet Mode", 0, 23, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bPetTierMode","Pet Tier Mode", 0, 24, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bAerialView","3rd Person Aiming", 0, 5, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"bTeamNecro","Team Necromancy", 0, 26, "Check",,,False,True);
	PI.AddSetting(default.InvasionProGroup ,"TeamSpawnGameRadius","Team Spawn Radius", 60, 14, "Text","6;0:999999",,False,True);
	PI.AddSetting(default.InvasionProGroup ,"WaveNameDuration","Wave Name Duration", 0, 18, "Text","6;0:999999",,False,True);
	PI.AddSetting(default.InvasionProGroup ,"NumMonstersPerPlayer","Monster Per Player", 60, 20, "Text","6;1:100",,False,True);
	PI.AddSetting(default.InvasionProGroup ,"MonsterSpawnDistance","Monster Spawn Distance", 60, 19, "Text","6;100:999999",,False,True);
	PI.AddSetting(default.InvasionProGroup ,"PetDataSaveInterval","Pet Save Interval", 60, 25, "Text","6;5:999999",,False,True);
	PI.AddSetting(default.InvasionProGroup ,"TeamNecroPercentage","Necromancy Percentage", 0, 28, "Text","3;0:100",,False,True);
	PI.AddSetting(default.InvasionProGroup ,"TeamNecroPoolMax","Necromancy Pool Max", 0, 29, "Text","6;0:999999",,False,True);
	PI.AddSetting(default.InvasionProGroup ,"TeamNecroCost","Necromancy Cost", 0, 30, "Text","6;0:999999",,False,True);
	PI.AddSetting(default.InvasionProGroup ,"SpawnProtection","Spawn Protection Time", 60, 21, "Text","6;0:999999",,False,True);

   	PI.PopClass();
	//destroy old maplistmanager and spawn new one
	foreach default.Class.AllObjects(class'UT2K4Tab_MainSP', Menu)
	{
		Menu.MapHandler.Destroy();
		Menu.MapHandler = Menu.PlayerOwner().Spawn(class'InvasionProMapListManager');
		Menu.InitMaps();
	}
}

static function string AssembleWebAdminFallbackMonster()
{
	local int i;
	local string MonsterList;

	MonsterList = "";

	for(i=0;i<class'InvasionProMonsterTable'.default.MonsterTable.Length;i++)
	{
		if(class'InvasionProMonsterTable'.default.MonsterTable[i].MonsterName != "None")
		{
			MonsterList = MonsterList$class'InvasionProMonsterTable'.default.MonsterTable[i].MonsterClassName$";"$class'InvasionProMonsterTable'.default.MonsterTable[i].MonsterName$";";
		}
	}

	return MonsterList;
}

static event string GetDescriptionText(string PropName)
{
    switch (PropName)
    {
		case "Waves":           return default.InvasionDescText[0];
		case "Monsters":        return default.InvasionDescText[1];
		case "Bosses":  return default.InvasionDescText[2];
		case "MonsterStats":  return default.InvasionDescText[3];
		case "InvasionProSettings": return default.InvasionDescText[4];
		case "LastWave": return "The invasion ends after this wave.";
		case "StartWave": return "The invasion begins on this wave.";
		case "Ability_TeleportTime.BaseTeleportCoolDownTime": return "The default teleport cooldown time for pets.";
		case "bRegenPlayers": return "Check to enable player regeneration.";
		case "RegenAmount": return "How much health players regenerate per second.";
		case "bRegenMonsters": return "Check to enable monster regeneration.";
		case "MonsterRegenAmount": return "How much health monsters regenerate per second.";
		case "bBalanceMonsters": return "Check to scale monsters with players.";
		case "bShareBossPoints": return "Check to share boss points with the team.";
		case "bDisableBerserk": return "Check to disable the berserk combo.";
		case "bDisableSpeed": return "Check to disable the speed combo.";
		case "bDisableInvis": return "Check to disable the invisiblity combo.";
		case "bDisableDefensive": return "Check to disable the defensive (booster) combo.";
		case "bDisableHealthPacks": return "Check to disable health packs.";
		case "bDisableHealthVials": return "Check to disable health vials.";
		case "bDisableAdrenalinePickups": return "Check to disable adrenaline pickups.";
		case "bDisableAmmoPickups": return "Check to disable ammo pickups.";
		case "bDisableWeaponLockers": return "Check to disable weapon lockers.";
		case "bDisableWeapons": return "Check to disable weapon pickups.";
		case "bDisableSuperPickups": return "Check to disable super pickups.";
		case "bPermitVehicles": return "Check to allow vehicles.";
		case "bPreloadMonsters": return "Check to enable monster preloading.";
		case "bSpawnAtBases": return "Check to make players and monsters spawn at opposite bases in team based maps.";
		case "bFavorHumans": return "Check to make necromancy always resurrect players over bots.";
		case "bHideRadar": return "Check to hide the radar from all player HUDs.";
		case "bHidePlayerList": return "Check to hide the player list from all player HUDs.";
		case "bHideNecroPool": return "Check to hide the necro pool from all player HUDs.";
		case "bHideMonsterCount": return "Check to hide the monster count from all player HUDs.";
		case "bIncludeSummons": return "Check to include monsters that are summoned by other monsters towards the monster limit.";
		case "bWaveTimeLimit": return "If checked, the wave duration ends the wave.";
		case "bWaveMonsterLimit": return "If checked the monster limit ends the wave.";
		case "bPetMode": return "Check to enable pet mode.";
		case "bPetTierMode": return "Check to enable pet tier mode.";
		case "bAerialView": return "Check to enable third person aiming.";
		case "bTeamNecro": return "Check to enable the team necromancy feature.";
		case "TeamSpawnGameRadius": return "If base spawning is active this is the maximum spawn radius from the game team area.";
		case "WaveNameDuration": return "How long the wave title stays on the screen.";
		case "NumMonstersPerPlayer": return "If balance monsters is enabled this is the number of monsters per player.";
		case "MonsterSpawnDistance": return "The maximum distance monsters spawn from players.";
		case "PetDataSaveInterval": return "How often to save the pet data.";
		case "TeamNecroPercentage": return "The percentage of score award players give to the team necromancy pool.";
		case "TeamNecroPoolMax": return "The maximum amount of necromancy pool available.";
		case "TeamNecroCost": return "How much it costs to resurrect someone.";
		case "SpawnProtection": return "How long spawn protection lasts.";
		//case "FallbackMonsterClass": return "Change fallback monster for the current wave";
    }

    return Super(xTeamGame).GetDescriptionText(PropName);
}

static event string GetDisplayText( string PropName )
{
    switch (PropName)
    {
		case "Waves": return default.InvasionPropText[0];
		case "Monsters": return default.InvasionPropText[1];
		case "Bosses": return default.InvasionPropText[2];
		case "MonsterStats": return default.InvasionPropText[3];
		case "InvasionProSettings": return default.InvasionPropText[4];
    }

    return Super(xTeamGame).GetDisplayText( PropName );
}

static event bool AcceptPlayInfoProperty(string PropName)
{
	if ( (PropName == "bBalanceTeams") || (PropName == "bPlayersBalanceTeams") || (PropName == "GoalScore") || (PropName == "TimeLimit") || (PropName == "SpawnProtectionTime") ||(PropName == "EndTimeDelay") )
	{
		return false;
	}

    return Super(xTeamGame).AcceptPlayInfoProperty(PropName);
}

//deny incompatible mutators :(
static function bool AllowMutator( string MutatorClassName )
{
	local string MutPackage, MutClass;

    if ( MutatorClassName ~= "XGame.MutRegen" )
        return false;

	if ( MutatorClassName ~= "SatoreMonsterPackv120.mutsatoreMonsterPack" )
        return false;

    if ( MutatorClassName ~= "SatoreMonsterPackv120.mutSMPMonsterConfig" )
        return false;

    if ( MutatorClassName == "MonsterManager_1_8.MutMonsterManager" )
        return false;

    if ( MutatorClassName == "MonsterDamageConfig.MutMonsterDamage" )
        return false;

    if ( MutatorClassName == "MonsterDamageConfigv2.MutMonsterDamage" )
        return false;

    if ( MutatorClassName == "DruidsMonsterMover102.MutMonsterMover" )
    	return false;

    Divide(MutatorClassName, ".", MutPackage, MutClass);
    if(MutClass ~= "MutAerialView")
    {
    	return false;
	}
	else if(MutClass ~= "MutBossWaves")
	{
		return false;
	}

    return Super(xTeamGame).AllowMutator(MutatorClassName);
}

function ChangeName(Controller Other, string S, bool bNameChange)
{
    local Controller APlayer,C, P;
	local InvasionProPetStatsItem DataItem;

    if ( S == "" )
        return;

    S = StripColor(s);  // Stip out color codes

    if (Other.PlayerReplicationInfo.playername~=S)
        return;

    S = Left(S,20);
    ReplaceText(S, " ", "_");
    ReplaceText(S, "|", "I");

    if ( bEpicNames && (Bot(Other) != None) )
    {
        if ( TotalEpic < 21 )
        {
            S = EpicNames[EpicOffset % 21];
            EpicOffset++;
            TotalEpic++;
        }
        else
        {
            S = NamePrefixes[NameNumber%10]$"CliffyB"$NameSuffixes[NameNumber%10];
            NameNumber++;
        }
    }

    for( APlayer=Level.ControllerList; APlayer!=None; APlayer=APlayer.nextController )
        if ( APlayer.bIsPlayer && (APlayer.PlayerReplicationInfo.playername~=S) )
        {
            if ( Other.IsA('PlayerController') )
            {
                PlayerController(Other).ReceiveLocalizedMessage( GameMessageClass, 8 );
                return;
            }
            else
            {
                if ( Other.PlayerReplicationInfo.bIsFemale )
                {
                    S = FemaleBackupNames[FemaleBackupNameOffset%32];
                    FemaleBackupNameOffset++;
                }
                else
                {
                    S = MaleBackupNames[MaleBackupNameOffset%32];
                    MaleBackupNameOffset++;
                }
                for( P=Level.ControllerList; P!=None; P=P.nextController )
                    if ( P.bIsPlayer && (P.PlayerReplicationInfo.playername~=S) )
                    {
                        S = NamePrefixes[NameNumber%10]$S$NameSuffixes[NameNumber%10];
                        NameNumber++;
                        break;
                    }
                break;
            }
            S = NamePrefixes[NameNumber%10]$S$NameSuffixes[NameNumber%10];
            NameNumber++;
            break;
        }

    if( bNameChange )
        GameEvent("NameChange",s,Other.PlayerReplicationInfo);

    if ( S ~= "CliffyB" )
        bEpicNames = true;
    Other.PlayerReplicationInfo.SetPlayerName(S);
    // notify local players
    if  ( bNameChange )
        for ( C=Level.ControllerList; C!=None; C=C.NextController )
            if ( (PlayerController(C) != None) && (Viewport(PlayerController(C).Player) != None) )
                PlayerController(C).ReceiveLocalizedMessage( class'GameMessage', 2, Other.PlayerReplicationInfo );

	if(PlayerController(Other) != None)
	{
		UpdatePetOwnerName(PlayerController(Other));
		DataItem = GetPetStatsItem(PlayerController(Other));
		if(DataItem != None)
		{
			DataItem.PlayerNameChanged();
		}
	}

   UpdatePlayerGRI();
}

function UpdatePets()
{
	if(bPetMode && Level.TimeSeconds - LastPetSaveTime > PetDataSaveInterval)
	{
		SavePetData();
		LastPetSaveTime = Level.TimeSeconds;
	}
}

function SavePetData()
{
	local int i;
	local InvasionProPetStatsItem DataItem;

	foreach DynamicActors(class'InvasionProPetStatsItem',DataItem)
	{
		for(i=0;i<class'InvasionProGameReplicationInfo'.default.PetData.Length;i++)
		{
			if(class'InvasionProGameReplicationInfo'.default.PetData[i].OwnerID == DataItem.OwnerID)
			{
				class'InvasionProGameReplicationInfo'.default.PetData[i].PetName = DataItem.PetName;
				class'InvasionProGameReplicationInfo'.default.PetData[i].PetClass = DataItem.PetClass;
				class'InvasionProGameReplicationInfo'.default.PetData[i].PetLevel = DataItem.PetLevel;
				class'InvasionProGameReplicationInfo'.default.PetData[i].XP = DataItem.XP;
				class'InvasionProGameReplicationInfo'.default.PetData[i].Points = DataItem.Points;
				class'InvasionProGameReplicationInfo'.default.PetData[i].PetCoolDown = DataItem.PetCoolDown;
				class'InvasionProGameReplicationInfo'.default.PetData[i].PetOrders = DataItem.PetOrders;
				class'InvasionProGameReplicationInfo'.default.PetData[i].Tier = DataItem.Tier;
				class'InvasionProGameReplicationInfo'.default.PetData[i].HPxp = DataItem.HPxp;
				class'InvasionProGameReplicationInfo'.default.PetData[i].HPRegenxp = DataItem.HPRegenxp;
				class'InvasionProGameReplicationInfo'.default.PetData[i].HPBoost = DataItem.HPBoost;
				class'InvasionProGameReplicationInfo'.default.PetData[i].SdXp = DataItem.SdXp;
				class'InvasionProGameReplicationInfo'.default.PetData[i].SdBoost = DataItem.SdBoost;
				class'InvasionProGameReplicationInfo'.default.PetData[i].DdgXp = DataItem.DdgXp;
				class'InvasionProGameReplicationInfo'.default.PetData[i].ArmorXp = DataItem.ArmorXp;
				class'InvasionProGameReplicationInfo'.default.PetData[i].DmgXp = DataItem.DmgXp;
				class'InvasionProGameReplicationInfo'.default.PetData[i].SpwnXp = DataItem.SpwnXp;
				class'InvasionProGameReplicationInfo'.default.PetData[i].TlprtXp = DataItem.TlprtXp;
				class'InvasionProGameReplicationInfo'.default.PetData[i].TlprtDwnXp = DataItem.TlprtDwnXp;
				class'InvasionProGameReplicationInfo'.default.PetData[i].TlprtDstXp = DataItem.TlprtDstXp;
				class'InvasionProGameReplicationInfo'.default.PetData[i].KBXp = DataItem.KBXp;
				class'InvasionProGameReplicationInfo'.default.PetData[i].XpL = DataItem.XpL;
				class'InvasionProGameReplicationInfo'.default.PetData[i].Aura = DataItem.Aura;
				class'InvasionProGameReplicationInfo'.default.PetData[i].AAxp = DataItem.AAxp;
				class'InvasionProGameReplicationInfo'.default.PetData[i].ABxp = DataItem.ABxp;
				class'InvasionProGameReplicationInfo'.default.PetData[i].DTClass = DataItem.DTClass;
				class'InvasionProGameReplicationInfo'.default.PetData[i].DTPetName = DataItem.DTPetName;
			}
		}
	}

	class'InvasionProGameReplicationInfo'.static.StaticSaveConfig();
}

event PostLogin( PlayerController NewPlayer )
{
 	//local Controller C;

	Super.PostLogin(NewPlayer);

	if(InvasionProXPlayer(NewPlayer) != None)
	{
		UpdatePlayerGRI();
		InvasionProXPlayer(NewPlayer).bLoadMeshes = bPreloadMonsters;
		SetPlayerPetData(NewPlayer);
	}
}
/*event PlayerController Login(string Portal,string Options,out string Error)
{
    local PlayerController NewPlayer;
    local Controller C;

    NewPlayer = Super.Login(Portal,Options,Error);

    for ( C=Level.ControllerList; C!=None; C=C.NextController )
    {
        if ( (C.PlayerReplicationInfo != None) && C.PlayerReplicationInfo.bOutOfLives && !C.PlayerReplicationInfo.bOnlySpectator )
        {
            NewPlayer.PlayerReplicationInfo.bOutOfLives = true;
            NewPlayer.PlayerReplicationInfo.NumLives = 1;
            NewPlayer.GotoState('Spectating');
        }
	}

	UpdatePlayerGRI();

	if(InvasionProXPlayer(NewPlayer) != None)
	{
		InvasionProXPlayer(NewPlayer).bLoadMeshes = bPreloadMonsters;
	}

	SetPlayerPetData(NewPlayer);
    return NewPlayer;
}*/

function CreatePetDataItem(PlayerController ThePlayer, int PlayerPetIndex)
{
	local InvasionProPetStatsItem DataItem;

	DataItem = Spawn(class'InvasionProPetStatsItem',ThePlayer);

	if(DataItem != None)
	{
		DataItem.OwnerID = class'InvasionProGameReplicationInfo'.default.PetData[PlayerPetIndex].OwnerID;
		DataItem.OwnerName = class'InvasionProGameReplicationInfo'.default.PetData[PlayerPetIndex].OwnerName;
		DataItem.PetName = class'InvasionProGameReplicationInfo'.default.PetData[PlayerPetIndex].PetName;
		DataItem.PetClass = class'InvasionProGameReplicationInfo'.default.PetData[PlayerPetIndex].PetClass;
		DataItem.PetLevel = class'InvasionProGameReplicationInfo'.default.PetData[PlayerPetIndex].PetLevel;
		DataItem.XP = class'InvasionProGameReplicationInfo'.default.PetData[PlayerPetIndex].XP;
		DataItem.Points = class'InvasionProGameReplicationInfo'.default.PetData[PlayerPetIndex].Points;
		DataItem.PetCoolDown = class'InvasionProGameReplicationInfo'.default.PetData[PlayerPetIndex].PetCoolDown;
		DataItem.PetOrders = class'InvasionProGameReplicationInfo'.default.PetData[PlayerPetIndex].PetOrders;
		DataItem.Tier = class'InvasionProGameReplicationInfo'.default.PetData[PlayerPetIndex].Tier;
		DataItem.MaxTier = class'InvasionProGameReplicationInfo'.default.NumTierGroups;
		DataItem.HPxp = class'InvasionProGameReplicationInfo'.default.PetData[PlayerPetIndex].HPxp;
		DataItem.HPRegenxp = class'InvasionProGameReplicationInfo'.default.PetData[PlayerPetIndex].HPRegenxp;
		DataItem.HPBoost = class'InvasionProGameReplicationInfo'.default.PetData[PlayerPetIndex].HPBoost;
		DataItem.SdXp = class'InvasionProGameReplicationInfo'.default.PetData[PlayerPetIndex].SdXp;
		DataItem.SdBoost = class'InvasionProGameReplicationInfo'.default.PetData[PlayerPetIndex].SdBoost;
		DataItem.DdgXp = class'InvasionProGameReplicationInfo'.default.PetData[PlayerPetIndex].DdgXp;
		DataItem.ArmorXp = class'InvasionProGameReplicationInfo'.default.PetData[PlayerPetIndex].ArmorXp;
		DataItem.DmgXp = class'InvasionProGameReplicationInfo'.default.PetData[PlayerPetIndex].DmgXp;
		DataItem.SpwnXp = class'InvasionProGameReplicationInfo'.default.PetData[PlayerPetIndex].SpwnXp;
		DataItem.TlprtXp = class'InvasionProGameReplicationInfo'.default.PetData[PlayerPetIndex].TlprtXp;
		DataItem.TlprtDwnXp = class'InvasionProGameReplicationInfo'.default.PetData[PlayerPetIndex].TlprtDwnXp;
		DataItem.TlprtDstXp = class'InvasionProGameReplicationInfo'.default.PetData[PlayerPetIndex].TlprtDstXp;
		DataItem.KBXp = class'InvasionProGameReplicationInfo'.default.PetData[PlayerPetIndex].KBXp;
		DataItem.XpL = class'InvasionProGameReplicationInfo'.default.PetData[PlayerPetIndex].XpL;
		DataItem.Aura = class'InvasionProGameReplicationInfo'.default.PetData[PlayerPetIndex].Aura;
		DataItem.AAxp = class'InvasionProGameReplicationInfo'.default.PetData[PlayerPetIndex].AAxp;
		DataItem.ABxp = class'InvasionProGameReplicationInfo'.default.PetData[PlayerPetIndex].ABxp;
		DataItem.DTClass = class'InvasionProGameReplicationInfo'.default.PetData[PlayerPetIndex].DTClass;
		DataItem.DTPetName = class'InvasionProGameReplicationInfo'.default.PetData[PlayerPetIndex].DTPetName;
		DataItem.bTierMode = bPetTierMode;
		DataItem.MyOwner = InvasionProXPlayer(ThePlayer);
		DataItem.MyMut = InvasionProMutator(BaseMutator);
		DataItem.NextTierLvl = GetTierMaxLevel(DataItem.Tier);
		DataItem.UpdateServerPets();
	}
}

function int GetTierMaxLevel(int CurrentTier)
{
	local int i;

	for(i=0;i<class'InvasionProGameReplicationInfo'.default.TierGroups.Length;i++)
	{
		if(class'InvasionProGameReplicationInfo'.default.TierGroups[i].TierGroup == CurrentTier)
		{
			return class'InvasionProGameReplicationInfo'.default.TierGroups[i].MaxLevel;
		}
	}

	return 999999;
}

function SetPlayerPetData(PlayerController ThePlayer)
{
	local int i, PlayerIndex;

	if(!bPetMode)
	{
		return;
	}

	if(ThePlayer != None)
	{
		if(InvasionProXPlayer(ThePlayer) != None)
		{
			InvasionProXPlayer(ThePlayer).bPetMode = bPetMode;
		}

		for(i=0;i<class'InvasionProGameReplicationInfo'.default.PetData.Length;i++)
		{
			if(class'InvasionProGameReplicationInfo'.default.PetData[i].OwnerID == ThePlayer.GetPlayerIDHash())
			{
				UpdatePetOwnerName(ThePlayer);
				CreatePetDataItem(ThePlayer,i);
				return;
			}
		}

		log("Creating new data for: "@ThePlayer.PlayerReplicationInfo.PlayerName@ThePlayer.GetPlayerIDHash(),'InvasionPro');
		class'InvasionProGameReplicationInfo'.default.PetData.Insert(class'InvasionProGameReplicationInfo'.default.PetData.Length, 1);
		PlayerIndex = class'InvasionProGameReplicationInfo'.default.PetData.Length-1;
		class'InvasionProGameReplicationInfo'.default.PetData[PlayerIndex].OwnerID = ThePlayer.GetPlayerIDHash();
		class'InvasionProGameReplicationInfo'.default.PetData[PlayerIndex].PetLevel = 1;
		class'InvasionProGameReplicationInfo'.default.PetData[PlayerIndex].XP = 0;
		class'InvasionProGameReplicationInfo'.default.PetData[PlayerIndex].Points = 0;
		class'InvasionProGameReplicationInfo'.default.PetData[PlayerIndex].PetCoolDown = class'InvasionProGameReplicationInfo'.default.PetCoolDownTime;
		class'InvasionProGameReplicationInfo'.default.PetData[PlayerIndex].PetOrders = "Defend";
		class'InvasionProGameReplicationInfo'.default.PetData[PlayerIndex].Tier = 1;
		class'InvasionProGameReplicationInfo'.default.PetData[PlayerIndex].HPxp = 0;
		class'InvasionProGameReplicationInfo'.default.PetData[PlayerIndex].HPRegenxp = 0;
		class'InvasionProGameReplicationInfo'.default.PetData[PlayerIndex].HPBoost = 0;
		class'InvasionProGameReplicationInfo'.default.PetData[PlayerIndex].SdXp = 0;
		class'InvasionProGameReplicationInfo'.default.PetData[PlayerIndex].SdBoost = 0;
		class'InvasionProGameReplicationInfo'.default.PetData[PlayerIndex].DdgXp = 0;
		class'InvasionProGameReplicationInfo'.default.PetData[PlayerIndex].ArmorXp = 0;
		class'InvasionProGameReplicationInfo'.default.PetData[PlayerIndex].DmgXp = 0;
		class'InvasionProGameReplicationInfo'.default.PetData[PlayerIndex].SpwnXp = 0;
		class'InvasionProGameReplicationInfo'.default.PetData[PlayerIndex].TlprtXp = 0;
		class'InvasionProGameReplicationInfo'.default.PetData[PlayerIndex].TlprtDwnXp = 0;
		class'InvasionProGameReplicationInfo'.default.PetData[PlayerIndex].TlprtDstXp = 0;
		class'InvasionProGameReplicationInfo'.default.PetData[PlayerIndex].KBXp = 0;
		class'InvasionProGameReplicationInfo'.default.PetData[PlayerIndex].XpL = 0;
		class'InvasionProGameReplicationInfo'.default.PetData[PlayerIndex].Aura = 0;
		class'InvasionProGameReplicationInfo'.default.PetData[PlayerIndex].AAxp = 0;
		class'InvasionProGameReplicationInfo'.default.PetData[PlayerIndex].ABxp = 0;
		class'InvasionProGameReplicationInfo'.default.PetData[PlayerIndex].DTClass = "";
		class'InvasionProGameReplicationInfo'.default.PetData[PlayerIndex].DTPetName = "";
		UpdatePetOwnerName(ThePlayer);
		CreatePetDataItem(ThePlayer,class'InvasionProGameReplicationInfo'.default.PetData.Length-1);
	}
	else
	{
		log("Error: Player Pet Data could not be verified/created",'InvasionPro');
	}
}

function UpdatePetOwnerName(PlayerController ThePlayer)
{
	local int i;

	if(ThePlayer != None && ThePlayer.PlayerReplicationInfo != None)
	{
		for(i=0;i<class'InvasionProGameReplicationInfo'.default.PetData.Length;i++)
		{
			if(class'InvasionProGameReplicationInfo'.default.PetData[i].OwnerID == ThePlayer.GetPlayerIDHash())
			{
				class'InvasionProGameReplicationInfo'.default.PetData[i].OwnerName = ThePlayer.PlayerReplicationInfo.PlayerName;
				break;
			}
		}

		class'InvasionProGameReplicationInfo'.static.StaticSaveConfig();
	}
}

function InvasionProPetStatsItem GetPetStatsItem(PlayerController ThePlayer)
{
	local InvasionProPetStatsItem StatsItem;

	if(ThePlayer != None)
	{
		foreach DynamicActors(class'InvasionProPetStatsItem',StatsItem)
		{
			if(StatsItem.OwnerID == ThePlayer.GetPlayerIDHash())
			{
				return StatsItem;
			}
		}
	}

	return None;
}

// check if all other players are out, true if players alive
function bool CheckMaxLives(PlayerReplicationInfo Scorer)
{
    local Controller C;
    local bool bPlayerAlive;

	bPlayerAlive = false;
	for ( C=Level.ControllerList; C!=None; C=C.NextController )
	{
		if ( C.PlayerReplicationInfo != None && InvasionProFriendlyMonsterReplicationInfo(C.PlayerReplicationInfo) == None && C.PlayerReplicationInfo.NumLives >= 1  && !C.PlayerReplicationInfo.bOutOfLives && !C.PlayerReplicationInfo.bOnlySpectator && !C.IsA('PetController'))
		{
			bPlayerAlive = true;
			break;
		}
	}

	if(bTeamNecro)
	{
		if( Resurrectee != None || (TeamNecroPool >= TeamNecroCost && GetNumPlayers() >= 1) )// && TeamResurrect() != None) )
		{
			bPlayerAlive = true;
		}
	}

    return bPlayerAlive;
}

function bool CheckEndGame(PlayerReplicationInfo Winner, string Reason)
{
    local Controller C;
    local PlayerController Player;

    EndTime = Level.TimeSeconds + EndTimeDelay;

    if ( WaveNum >= LastWave )
    {
        GameReplicationInfo.Winner = Teams[0];
	}

    for ( C=Level.ControllerList; C!=None; C=C.NextController )
    {
		if(!C.IsA('FriendlyMonsterController') && !C.IsA('PetController') )
		{
			Player = PlayerController(C);
			if ( Player != None )
			{
				if ( !Player.PlayerReplicationInfo.bOnlySpectator )
				{
					PlayWinMessage(Player, (Player.PlayerReplicationInfo.Team == GameReplicationInfo.Winner));
				}
				Player.ClientSetBehindView(true);
				Player.ClientGameEnded();
			}

			C.GameHasEnded();
		}
    }

    if ( CurrentGameProfile != None )
    {
        CurrentGameProfile.bWonMatch = false;
	}

    return true;
}

function EndGame( PlayerReplicationInfo Winner, string Reason )
{
	if(bWaitingToStartMatch || !GameReplicationInfo.bMatchHasBegun)
	{
		return;
	}

	if(Reason ~= "Success")
	{
		Reason = "Success";
	}
	else if(CheckMaxLives(Winner))
	{
		return;
	}
	else
	{
		Reason = "TimeLimit";
	}

	//check if game rules wants to end the game
	if ( (GameRulesModifiers != None) && !GameRulesModifiers.CheckEndGame(Winner, Reason) )
	{
		return;
	}

	SetEndGame( Winner, Reason);
}

function SetEndGame( PlayerReplicationInfo Winner, string Reason )
{
	SavePetData();
	CheckEndGame(Winner, Reason);
	bGameEnded = true;
	TriggerEvent('EndGame', self, None);
	EndLogging(Reason);
	GotoState('MatchOver');
	FreeResurrectee();
}

function CheckScore(PlayerReplicationInfo Scorer)
{
    if ( (GameRulesModifiers != None) && GameRulesModifiers.CheckScore(Scorer) )
		return;

	EndGame(Scorer,"TimeLimit");
}

static function PrecacheGameTextures(LevelInfo myLevel)
{
	local class<Monster> p_M;
	local int i, n;

    class'xTeamGame'.static.PrecacheGameTextures(myLevel);
    myLevel.AddPrecacheMaterial(Material'SkaarjPackSkins.jBrute2');
    myLevel.AddPrecacheMaterial(Material'SkaarjPackSkins.jBrute1');
    myLevel.AddPrecacheMaterial(Material'SkaarjPackSkins.eKrall');
    myLevel.AddPrecacheMaterial(Material'SkaarjPackSkins.Skaarjw3');
    myLevel.AddPrecacheMaterial(Material'SkaarjPackSkins.Gasbag1');
    myLevel.AddPrecacheMaterial(Material'SkaarjPackSkins.Gasbag2');
    myLevel.AddPrecacheMaterial(Material'SkaarjPackSkins.Skaarjw2');
    myLevel.AddPrecacheMaterial(Material'SkaarjPackSkins.JManta1');
    myLevel.AddPrecacheMaterial(Material'SkaarjPackSkins.JFly1');
    myLevel.AddPrecacheMaterial(Material'SkaarjPackSkins.Skaarjw1');
    myLevel.AddPrecacheMaterial(Material'SkaarjPackSkins.JPupae1');
    myLevel.AddPrecacheMaterial(Material'SkaarjPackSkins.JWarlord1');
    myLevel.AddPrecacheMaterial(Material'SkaarjPackSkins.jkrall');
    myLevel.AddPrecacheMaterial(Material'InterfaceContent.HUD.SkinA');
    myLevel.AddPrecacheMaterial(Material'AS_FX_TX.AssaultRadar');

    if(default.bPreloadMonsters)
    {
		for(i=0;i<class'InvasionProMonsterTable'.default.MonsterTable.Length;i++)
		{
			if(class'InvasionProMonsterTable'.default.MonsterTable[i].MonsterClassName != "" && class'InvasionProMonsterTable'.default.MonsterTable[i].MonsterClassName != "None")
			{
				p_M = class<Monster>(DynamicLoadObject(class'InvasionProMonsterTable'.default.MonsterTable[i].MonsterClassName, class'class',true));
				if(p_M != None)
				{
					for(n=0;n<p_M.default.Skins.Length;n++)
					{
						myLevel.AddPrecacheMaterial(p_M.default.Skins[n]);
					}
				}
			}
		}
	}
}
//make gametype appear under the invasion tab
function GetServerInfo (out ServerResponseLine ServerState)
{
	Super(xTeamGame).GetServerInfo(ServerState);
	ServerState.GameType = "Invasion";
}

function GetServerDetails( out ServerResponseLine ServerState )
{
    Super(xTeamGame).GetServerDetails(ServerState);
    AddServerDetail( ServerState, "InitialWave", StartWave );
    AddServerDetail( ServerState, "FinalWave", LastWave );
    AddServerDetail( ServerState, "Pet Mode", bPetMode );
    AddServerDetail( ServerState, "Team Necro", bTeamNecro );
    AddServerDetail( ServerState, "Vehicles", bPermitVehicles );
    AddServerDetail( ServerState, "Monster Regenerate", bRegenMonsters );
    AddServerDetail( ServerState, "Players Regenerate", bRegenPlayers );
    AddServerDetail( ServerState, "Third Person Aiming", bAerialView );
    AddServerDetail( ServerState, "Preload Monsters", bPreloadMonsters );
}


function bool LevelIsTeamMap()
{
	local array<string> CurrentLevelPrefix;

	CurrentLevelPrefix.Remove(0, CurrentLevelPrefix.Length);
	Split(string(Level), "-", CurrentLevelPrefix);
	if(CurrentLevelPrefix[0] != "" && CurrentLevelPrefix[0] != "None")
	{
		CurrentMapPrefix = CurrentLevelPrefix[0];
		if( CurrentMapPrefix ~= "ONS" || CurrentMapPrefix ~= "CTF" || CurrentMapPrefix ~= "DOM" || CurrentMapPrefix ~= "BR" || CurrentMapPrefix ~= "VCTF" || CurrentMapPrefix ~= CustomGameTypePrefix)
		{
			return true;
		}
	}

	return false;
}

function bool PlayerCanReallySeeMe(Actor A)
{
	local Controller C;
	local bool Result;

	Result = false;

	for ( C = Level.ControllerList; C!=None; C=C.NextController )
	{
		if(MonsterController(C) == None && C.Pawn != None && FastTrace( A.Location, C.Pawn.Location ))
		{
			Result = true;
		}
	}

	return Result;
}


//for monsters only so far/blue team
function NavigationPoint GetCollisionPlayerStart(Controller Player, byte inTeam, string IncomingName, int Switch)
{
	local array<NavigationPoint> MonsterSpawnLocs;
	local NavigationPoint BestStart;
	local int i, Counter;
	local class<Actor> A;
	local NavigationPoint N;
	local float BestRating, NodeRating;

	BestStart = None;
	MonsterSpawnLocs.Remove(0, MonsterSpawnLocs.Length);
	if(InTeam == 0 && CollisionTestActor != None && IncomingName != "" && IncomingName != "None")
	{
		A = Class<Actor>(DynamicLoadObject(IncomingName,class'class',true));
		if(A != None)
		{
			Counter = 0;
			CollisionTestActor.SetCollisionSize(A.default.CollisionRadius,A.default.CollisionHeight);
			CollisionTestActor.SetCollision(true,true,true);
			if(Switch == 0)
			{
				for ( N=Level.NavigationPointList; N != None; N=N.NextNavigationPoint )
				{
					if(Door(N) == None && FlyingPathNode(N) == None && N.Region.Zone.LocationName != "In space")
					{
						if(CollisionTestActor.SetLocation(N.Location+(A.default.CollisionHeight - N.CollisionHeight) * vect(0,0,1)) )
						{
							MonsterSpawnLocs.Insert(Counter,1);
							MonsterSpawnLocs[Counter] = N;
							Counter++;
						}
					}
				}
			}
			else if(Switch == 1)
			{
				for(i=0;i<MonsterStartNavList.Length;i++)
				{
					if(MonsterStartNavList[i] != None && CollisionTestActor.SetLocation(MonsterStartNavList[i].Location+(A.default.CollisionHeight - MonsterStartNavList[i].CollisionHeight) * vect(0,0,1)) )
					{
						MonsterSpawnLocs.Insert(Counter,1);
						MonsterSpawnLocs[Counter] = MonsterStartNavList[i];
						Counter++;
					}
				}
			}
			else if(Switch == 2)
			{
				for ( N=Level.NavigationPointList; N != None; N=N.NextNavigationPoint )
				{
					if(Door(N) == None && FlyingPathNode(N) == None && N.Region.Zone.LocationName != "In space" && PlayerCanReallySeeMe(N))
					{
						if(CollisionTestActor.SetLocation(N.Location+(A.default.CollisionHeight - N.CollisionHeight) * vect(0,0,1)) )
						{
							MonsterSpawnLocs.Insert(Counter,1);
							MonsterSpawnLocs[Counter] = N;
							Counter++;
						}
					}
				}
			}
		}
	}

	CollisionTestActor.SetCollision(false,false,false);

	if(MonsterSpawnLocs.Length > 0)
	{
		BestRating = 0;
		for(i=0;i<MonsterSpawnLocs.Length;i++)
		{
			NodeRating = GetMonsterStartRating(MonsterSpawnLocs[i]);
			if(NodeRating > BestRating)
			{
				BestRating = NodeRating;
				BestStart = MonsterSpawnLocs[i];
			}
		}
	}

	OldNode = BestStart;
	return BestStart;
}

function float GetMonsterStartRating(NavigationPoint NP)
{
	local float NodeRating;
	local Controller C;
	local float Dist, BestDist;

	NodeRating = 0;

	if(OldNode != None)
	{
		if(NP == OldNode)
		{
			return 0;
		}

		NodeRating = VSize(OldNode.Location - NP.Location);
	}
	else
	{
		NodeRating = 1000;
	}

	BestDist = 999999;
	Dist = 0;

	for ( C = Level.ControllerList; C!=None; C=C.NextController )
	{
		if ( C.Pawn != None && C.PlayerReplicationInfo != None)
		{
			if(!FastTrace(C.Pawn.Location + C.Pawn.BaseEyeHeight*Vect(0,0,0.5),NP.Location))
			{
				Dist = VSize(C.Pawn.Location - NP.Location);
				if(Dist < BestDist && Dist < MonsterSpawnDistance)
				{
					BestDist = Dist;
				}
			}
			else
			{
				NodeRating = 0;
				break;
			}
		}
	}

	//if closest player is further than spawn distance decline this node
	if(!bSpawnAtBases && BestDist > MonsterSpawnDistance)
	{
		NodeRating = 0;
	}

	return NodeRating;
}

//over writing all inTeam and settings 1 for players and 0 for monsters
function NavigationPoint FindPlayerStart( Controller Player, optional byte InTeam, optional string IncomingName )
{
    local NavigationPoint N, BestStart;
    local float BestRating, NewRating;

      // always pick StartSpot at start of match
    if ( (Player != None) && (Player.StartSpot != None) && (Level.NetMode == NM_Standalone)
        && (bWaitingToStartMatch || ((Player.PlayerReplicationInfo != None) && Player.PlayerReplicationInfo.bWaitingPlayer))  )
    {
        return Player.StartSpot;
    }

    //first assign correct team
	if( (Player != None && Player.PlayerReplicationInfo != None) || bWaitingToStartMatch || IncomingName ~= "Friendly") //should catch most players and possible friendly monsters
	{
		//players
		InTeam = 1;
	}
	else //monsters
	{
		InTeam = 0;
	}

	//just let game rules overwrite if they wish
    if ( GameRulesModifiers != None )
    {
        BestStart = GameRulesModifiers.FindPlayerStart(Player,InTeam,IncomingName);
        if(BestStart != None)
        {
			return BestStart;
		}
    }

	//best place to teleport stuck monsters to
    if(IncomingName ~= "Stuck")
    {
		if(Player != None && Player.Pawn != None)
		{
			IncomingName = string(Player.Pawn.Class);
		}

		BestStart = GetCollisionPlayerStart(Player,inTeam, IncomingName,2);
	}

	 // start for monsters
	if( BestStart == None && InTeam == 0 && MonsterStartNavList.Length > 0)
	{
		if(Player != None && Player.Pawn != None && (IncomingName ~= "" || IncomingName ~= "None") )
		{
			IncomingName = string(Player.Pawn.Class);
		}

		//if start tags found use them, else if spawn at bases and base is found use it
		if( bUseMonsterStartTag || bSpawnAtBases && LevelIsTeamMap())
		{
			BestStart = GetCollisionPlayerStart(Player,inTeam, IncomingName,1);
		}
	}

	//start for players
	if( BestStart == None && InTeam == 1 && PlayerStartNavList.Length > 0)
	{
		BestStart = GetPlayerStart(Player, InTeam, IncomingName);
	}

	if(BestStart == None)
	{
		//fallback to default spawning
		BestStart = Super.FindPlayerStart(Player,InTeam,IncomingName);
	}
	//no team spawn point found
    if ( BestStart == None)
    {
        BestRating = -100000000;
        foreach AllActors( class 'NavigationPoint', N )
        {
			if(Door(N) == None && Teleporter(N) == None && N.Region.Zone.LocationName != "In space")
			{
				NewRating = RatePlayerStart(N,0,Player);
				if ( InventorySpot(N) != None )
					NewRating -= 50;
				NewRating += 20 * FRand();
				if ( NewRating > BestRating )
				{
					BestRating = NewRating;
					BestStart = N;
				}
			}
        }
    }

    return BestStart;
}

function NavigationPoint GetPlayerStart(Controller Player, optional byte InTeam, optional string IncomingName, optional int Switch)
{
	local int i, TempNodeCounter;
	local array<NavigationPoint> TempNodes;
	local Actor A;
	local float BestDist, Dist;
	local Monster M;
	local NavigationPoint BestStart;

	TempNodeCounter = 0;
	BestDist = 0;
	TempNodes.Remove(0, TempNodes.Length);

	for(i=0;i<PlayerStartNavList.Length;i++)
	{
		PlayerStartNavList[i].Taken = false;

		foreach VisibleCollidingActors( class'Actor', A, 100, PlayerStartNavList[i].Location, false)
		{
			PlayerStartNavList[i].Taken = true;
		}
	}

	for(i=0;i<PlayerStartNavList.Length;i++)
	{
		if(!PlayerStartNavList[i].Taken)
		{
			TempNodes.Insert(TempNodeCounter,1);
			TempNodes[TempNodeCounter] = PlayerStartNavList[i];
			TempNodeCounter++;

			foreach DynamicActors(class'Monster',M)
			{
				if( M != None && M.Health > 0 )
				{
					Dist = VSize ( PlayerStartNavList[i].Location - M.Location );
					if(Dist > BestDist)
					{
						BestDist = Dist;
						BestStart = PlayerStartNavList[i];
					}
				}
			}
		}
	}

	if(BestStart == None)
	{
		BestStart = TempNodes[Rand(TempNodes.Length)];
	}

	return BestStart;
}

defaultproperties
{
     BossConfigMenu="InvasionProv1_7.InvasionProBossConfig"
     MonsterStatsConfigMenu="InvasionProv1_7.InvasionProMonsterStatsConfig"
     MonsterConfigMenu="InvasionProv1_7.InvasionProMonsterConfig"
     InvasionProConfigMenu="InvasionProv1_7.InvasionProMainMenu"
     InvasionProGroup="Invasion Pro"
     bPermitVehicles=True
     bFavorHumans=True
     RegenAmount=5
     MonsterRegenAmount=5
     TotalSpawned=442
     TotalDamage=568
     TotalKills=36
     TotalGames=102
     LastWave=16
     StartWave=1
     NumMonstersPerPlayer=4
     bShareBossPoints=True
     SpawnProtection=15
     bDisableInvis=True
     bPreloadMonsters=True
     bAerialView=True
     bTeamNecro=True
     TeamNecroPercentage=10
     TeamNecroPoolMax=1000
     TeamNecroCost=10
     TeamSpawnGameRadius=2000
     WaveNameDuration=3
     MonsterSpawnDistance=10000
     WaveCountDownColour=(G=255,R=255,A=255)
     VehicleLockedMessageColour=(B=255,G=150,R=100)
     bWaveTimeLimit=True
     bWaveMonsterLimit=True
     bPetMode=True
     PetDataSaveInterval=5
     FallbackMonster=Class'SkaarjPack.SkaarjPupae'
     WaveConfigMenu="InvasionProv1_7.InvasionProWaveConfig"
     FinalWave=0
     InvasionPropText(0)="Wave Configuration"
     InvasionPropText(1)="Invaders"
     InvasionPropText(2)="Boss Configuration"
     InvasionPropText(3)="Monster Stats"
     InvasionPropText(4)="Additional Settings"
     InvasionPropText(5)=""
     InvasionDescText(0)="Configure the properties for each wave."
     InvasionDescText(1)="Configure the monsters properties"
     InvasionDescText(2)="Configure the properties of any bosses."
     InvasionDescText(3)="View the stats of your monsters."
     InvasionDescText(4)="Configure more advanced settings of InvasionPro."
     InvasionDescText(5)=""
     bForceRespawn=True
     bAllowPlayerLights=True
     DefaultMaxLives=0
     LoginMenuClass="InvasionProv1_7.InvasionProLoginMenu"
     bEnableStatLogging=False
     DefaultPlayerClassName="InvasionProv1_7.InvasionProxPawn"
     ScoreBoardType="InvasionProv1_7.InvasionProScoreboard"
     HUDType="InvasionProv1_7.InvasionProHud"
     MapPrefix="INV"
     BeaconName="INVPRO"
     GoalScore=0
     TimeLimit=0
     MutatorClass="InvasionProv1_7.InvasionProMutator"
     PlayerControllerClassName="InvasionProv1_7.InvasionProXPlayer"
     GameReplicationInfoClass=Class'InvasionProv1_7.InvasionProGameReplicationInfo'
     GameName="InvasionPro"
     Description="Invasion Pro v1.7. Invasion Pro takes Invasion to a whole new level with a multitude of configurations allowing to build a totally customized invasion experience."
     Acronym="INVPRO"
}
