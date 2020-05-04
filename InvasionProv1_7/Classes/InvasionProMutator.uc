class InvasionProMutator extends DMMutator HideDropDown CacheExempt;

var() int WaveNameDuration;

replication
{
	reliable if(bNetInitial && Role==Role_Authority)
		WaveNameDuration;
}

simulated function PostBeginPlay()
{
	local WeaponLocker L;

	if(Role == Role_Authority)
	{
		if(InvasionPro(Level.Game).bDisableWeaponLockers)
		{
			foreach AllActors(class'WeaponLocker', L)
			{
				L.GotoState('Disabled');
			}
		}

		WaveNameDuration = InvasionPro(Level.Game).WaveNameDuration;
	}

	SetTimer(0.5,true);
    Super.PostBeginPlay();
}

simulated function Timer()
{
	local InvasionProMonsterReplicationInfo MI;
	local int i;
	local Class<Monster> MonsterClass;
	local string MonsterName;

	foreach DynamicActors(class'InvasionProMonsterReplicationInfo', MI)
	{
		for(i=0;i<MI.GetLength();i++)
		{
			MonsterName = MI.GetMonsterClassName(i);
			if(MonsterName != "None")
			{
				MonsterClass = class<Monster>(DynamicLoadObject(MonsterName,class'class',true));
				if(MonsterClass != None)
				{
					if(MonsterClass.default.Mesh == vertmesh'SkaarjPack_rc.GasbagM')
					{
						MonsterClass.default.WalkAnims[0] = 'Float';
						MonsterClass.default.WalkAnims[1] = 'Float';
						MonsterClass.default.WalkAnims[2] = 'Float';
						MonsterClass.default.WalkAnims[3] = 'Float';
					}
					else if(MonsterClass.default.Mesh == vertmesh'SkaarjPack_rc.Skaarjw')
					{
						MonsterClass.default.DodgeAnims[1] = 'DodgeF';
					}

					if(MonsterClass.default.GibGroupClass == class'XEffects.xPawnGibGroup')
					{
						MonsterClass.default.GibGroupClass = Class'InvasionProv1_7.InvasionProGibGroupClass';
					}
					else if(MonsterClass.default.GibGroupClass == class'XEffects.xBotGibGroup')
					{
						MonsterClass.default.GibGroupClass = Class'InvasionProv1_7.InvasionProMetalGibGroupClass';
					}
					else if(MonsterClass.default.GibGroupClass == class'XEffects.xAlienGibGroup')
					{
						MonsterClass.default.GibGroupClass = Class'InvasionProv1_7.InvasionProAlienGibGroupClass';
					}
					//custom gib groups not accounted for yet, such as AlienMonsterPack
					//not many of those custom groups around anyway
				}
			}
		}

		class'InvasionProWaveMessage'.default.LifeTime = WaveNameDuration;
		SetTimer(0.0,false);
	}
}

function UpdateMonster(Monster M, int ID)
{
	local int RandValue;
	local int fRandValue;
	local Inventory Inv;
	local class<Inventory> InvClass;

	if(M.IsA('SMPNaliCow') )
	{
		InvClass = class<Inventory>(DynamicLoadObject("InvasionProv1_7.InvasionProNaliCowInv",class'class',true));
		Inv = spawn(InvClass, M,,,);
		Inv.GiveTo(M);
	}

	if( class'InvasionProMonsterTable'.default.MonsterTable[ID].bRandomHealth )
	{
		RandValue = Max(100,Rand(1000));

		M.Health = RandValue;
		M.HealthMax = RandValue;
	}
	else
	{
		M.Health = class'InvasionProMonsterTable'.default.MonsterTable[ID].NewHealth;
		M.HealthMax = class'InvasionProMonsterTable'.default.MonsterTable[ID].NewMaxHealth;
	}

	if( class'InvasionProMonsterTable'.default.MonsterTable[ID].bRandomSpeed )
	{
		RandValue = Max(200,Rand(1000));

		M.GroundSpeed = RandValue;
		M.AirSpeed = RandValue;
		M.WaterSpeed = RandValue;
		M.JumpZ = RandValue;
	}
	else
	{
		M.GroundSpeed = class'InvasionProMonsterTable'.default.MonsterTable[ID].NewGroundSpeed;
		M.AirSpeed = class'InvasionProMonsterTable'.default.MonsterTable[ID].NewAirSpeed;
		M.WaterSpeed = class'InvasionProMonsterTable'.default.MonsterTable[ID].NewWaterSpeed;
		M.JumpZ =class'InvasionProMonsterTable'.default.MonsterTable[ID].NewJumpZ;
	}

	if( class'InvasionProMonsterTable'.default.MonsterTable[ID].bRandomSize )
	{
		fRandValue = Rand( (5.0 * 1000) - (0.2 * 1000) ) ;
		fRandValue /= 1000;
		fRandValue += 0.2;

		if(fRandValue < 1)
		{
			fRandValue = 1;
		}
		M.SetLocation( M.Location + vect(0,0,1) * ( M.CollisionHeight * fRandValue) );
		M.SetDrawScale(M.Drawscale * fRandValue);
     	M.SetCollisionSize( M.CollisionRadius * fRandValue, M.CollisionHeight * fRandValue );
     	M.Prepivot.X = M.Prepivot.X * fRandValue;
     	M.Prepivot.Y = M.Prepivot.Y * fRandValue;
     	M.Prepivot.Z = M.Prepivot.Z * fRandValue;
	}
	else
	{
		M.SetLocation( M.Location + vect(0,0,1) * ( M.CollisionHeight * class'InvasionProMonsterTable'.default.MonsterTable[ID].NewDrawScale) );
		M.SetDrawScale(class'InvasionProMonsterTable'.default.MonsterTable[ID].NewDrawScale);
		M.SetCollisionSize(class'InvasionProMonsterTable'.default.MonsterTable[ID].NewCollisionRadius,class'InvasionProMonsterTable'.default.MonsterTable[ID].NewCollisionHeight);
		M.Prepivot = class'InvasionProMonsterTable'.default.MonsterTable[ID].NewPrepivot;
	}

	/*
	M.GibCountCalf *= class'InvasionProMonsterTable'.default.MonsterTable[ID].NewGibMultiplier;
	M.GibCountForearm *= class'InvasionProMonsterTable'.default.MonsterTable[ID].NewGibMultiplier;
	M.GibCountHead *= class'InvasionProMonsterTable'.default.MonsterTable[ID].NewGibMultiplier;
	M.GibCountTorso *= class'InvasionProMonsterTable'.default.MonsterTable[ID].NewGibMultiplier;
	M.GibCountUpperArm *= class'InvasionProMonsterTable'.default.MonsterTable[ID].NewGibMultiplier;
	*/

	M.ScoringValue = class'InvasionProMonsterTable'.default.MonsterTable[ID].NewScoreAward;
}

function float GetGibSize(Monster M)
{
	local int i;
	local string MonsterName;
	local float GibSize;

	GibSize = 1.0;
	MonsterName = "None";

	for(i=0;i<class'InvasionProMonsterTable'.default.MonsterTable.Length;i++ )
	{
		if( class'InvasionProMonsterTable'.default.MonsterTable[i].MonsterClassName ~= string(M.Class) )
		{
			MonsterName = class'InvasionProMonsterTable'.default.MonsterTable[i].MonsterName;
			break;
		}
	}

	if(MonsterName != "None")
	{
		for(i=0;i<class'InvasionProConfigs'.default.Bosses.Length;i++ )
		{
			if( class'InvasionProConfigs'.default.Bosses[i].BossMonsterName ~= MonsterName )
			{
				GibSize = class'InvasionProConfigs'.default.Bosses[i].BossGibSizeMultiplier;
				break;
			}
		}
	}

	return GibSize;
}

function ModifyMonster(Pawn P, bool bFriendly, bool bBoss)
{
	local class<InvasionProMonsterIDInv> MInv;
	local InvasionProMonsterIDInv NewInv;
	local Inventory Inv;

	if(P != None)
	{
		Inv = P.FindInventoryType(class'InvasionProMonsterIDInv');
		if(Inv != None)
		{
			return;
		}

		MInv = class<InvasionProMonsterIDInv>(DynamicLoadObject("InvasionProv1_7.InvasionProMonsterIDInv",class'class',true));

		if(MInv != None)
		{
			NewInv = Spawn(MInv, P,,,);
			if(NewInv != None)
			{
				NewInv.GiveTo(P);
				NewInv.bBoss = bBoss;
				NewInv.bFriendly = bFriendly;
				NewInv.bSummoned = true;
			}
		}
	}
}

function bool CheckReplacement( Actor Other, out byte bSuperRelevant )
{
	local int i;
	local xPickUpBase xP;
	local FriendlyMonsterController FMC;

    bSuperRelevant = 0;

    if(Controller(Other) != None && Other.iSA('ProxyController'))
    {
		Controller(Other).PlayerReplicationInfo = None;
		Controller(Other).PlayerReplicationInfo = Spawn(Class'InvasionProProxyReplicationInfo',Other,,vect(0.00,0.00,0.00),rot(0,0,0));
	}

    if(Monster(Other) != None)
    {
		ModifyMonster(Monster(Other),false,false);
		//log(Other@Other.Instigator);
		for( i=0;i<class'InvasionProMonsterTable'.default.MonsterTable.Length;i++ )
		{
			if( class'InvasionProMonsterTable'.default.MonsterTable[i].MonsterClassName ~= string(Other.Class) )
			{
				UpdateMonster(Monster(Other), i);
				break;
			}
		}

		if(GasBag(Other) != None)
		{
			GasBag(Other).AddVelocity(vect(0,0,50));
		}

		if(Other.Instigator != None && Monster(Other.Instigator) != None)
		{
			if(FriendlyMonsterController(Monster(Other.Instigator).Controller) != None && FriendlyMonsterController(Monster(Other.Instigator).Controller).Master != None)
			{
				//friendly monster summoned another monster? give it a friendly controller
				if(Monster(Other).Controller != None)
				{
					Monster(Other).Controller.Destroy();
				}

				FMC = Spawn(class'InvasionProv1_7.FriendlyMonsterController');
				if(FMC  != None)
				{
					FMC.Possess(Monster(Other));
					FMC.SetMaster(FriendlyMonsterController(Monster(Other.Instigator).Controller));
					FMC.CreateFriendlyMonsterReplicationInfo();
				}
			}
		}
	}

    if ( Pawn(Other) != None )
    {
        Pawn(Other).bAutoActivate = true;
    }
    else if ( GameObjective(Other) != None )
    {
        Other.bHidden = true;
        GameObjective(Other).bDisabled = true;
        Other.SetCollision(false,false,false);
    }
	else if(Other.Instigator == None && MiniHealthPack(Other) != None && InvasionPro(Level.Game).bDisableHealthVials)
	{
		return false;
	}
	else if(Other.Instigator == None && HealthPack(Other) != None && InvasionPro(Level.Game).bDisableHealthPacks)
	{
		return false;
	}
	else if(HealthCharger(Other) != None && InvasionPro(Level.Game).bDisableHealthPacks)
	{
		HealthCharger(Other).PowerUp = None;
		Other.bHidden = true;
		HealthCharger(Other).SpiralEmitter=none;
		Other.SetDrawType(DT_None);
		if(HealthCharger(Other).MyEmitter!=None)
		{
			HealthCharger(Other).MyEmitter.Destroy();
		}

		return false;
	}
	else if(Other.Instigator == None && AdrenalinePickup(Other) != None && InvasionPro(Level.Game).bDisableAdrenalinePickups)
	{
		return false;
	}
	else if(Other.Instigator == None && UTAmmoPickup(Other) != None && InvasionPro(Level.Game).bDisableAmmoPickups)
	{
		return false;
	}
	else if(WeaponLocker(Other) != None && InvasionPro(Level.Game).bDisableWeaponLockers)
	{
		return false;
	}
	else if(xWeaponBase(Other) != None && InvasionPro(Level.Game).bDisableWeapons)
	{
		xWeaponBase(Other).WeaponType = None;
		xWeaponBase(Other).PowerUp = None;
		Other.bHidden = true;
		xWeaponBase(Other).SpiralEmitter = None;
		Other.SetDrawType(DT_None);
		if(xWeaponBase(Other).MyEmitter != None)
		{
			xWeaponBase(Other).MyEmitter.Destroy();
		}

		return false;
	}
	else if (GameObject(Other) != None)
	{
		if(CTFFlag(Other) != None)
		{
			Other.bHidden = true;
			Other.SetCollision(false,false,false);
			CTFFlag(Other).bDisabled = true;
		}
		else
		{
			return false;
		}
	}
	else if(xBombDeliveryHole(Other) != None)//it's this that kills players who jump in bombing run holes
	{
		return false;
	}
	else if(InvasionPro(Level.Game).bDisableSuperPickups)
	{
		if(Other.Instigator == None && UDamagePack(Other) != None || ShieldPickup(Other) != None || SuperHealthPack(Other) != None )
		{
			return false;
		}
		else if(Other.Instigator == None && ShieldCharger(Other) != None || SuperHealthCharger(Other) != None || SuperShieldCharger(Other) != None || UDamageCharger(Other) != None || WildcardBase(Other) != None)
		{
			xP = xPickUpBase(Other);
			xP.PowerUp = None;
			Other.bHidden = true;
			xP.SpiralEmitter = None;
			Other.SetDrawType(DT_None);
			if(xP.MyEmitter != None)
			{
				xP.MyEmitter.Destroy();
			}
			return false;
		}
	}

    return true;
}

//might not work with petcontroller just yet
function Tick(float DeltaTime)
{
	local Actor A;
	local InvasionProFriendlyMonsterReplicationInfo PRI;
	local Inventory Inv;

	foreach DynamicActors(class'Actor',A)
	{
		if(Vehicle(A) != None)
		{
			Vehicle(A).bTeamLocked = false;
			Vehicle(A).bNoFriendlyFire = true;
			Vehicle(A).Team = 0;
		}
		else if(Monster(A) != None && Monster(A).Controller != None && Monster(A).PlayerReplicationInfo != None && InvasionProFriendlyMonsterReplicationInfo(Monster(A).PlayerReplicationInfo) == None)
		{
			PRI = Spawn(class'InvasionProFriendlyMonsterReplicationInfo');
			if(PRI != None)
			{
				PRI.PlayerName = Monster(A).PlayerReplicationInfo.PlayerName;
				PRI.Team = Monster(A).PlayerReplicationInfo.Team;
				PRI.SetPRI();
				Monster(A).PlayerReplicationInfo.Destroy();
				Monster(A).PlayerReplicationInfo = PRI;
				Monster(A).Controller.PlayerReplicationInfo = PRI;
				InvasionPro(Level.Game).UpdatePlayerGRI();
				if(InvasionProGameReplicationInfo(Level.Game.GameReplicationInfo) != None)
				{
					InvasionProGameReplicationInfo(Level.Game.GameReplicationInfo).AddFriendlyMonster(Monster(A));
				}
			}

			Inv = Monster(A).FindInventoryType(class'InvasionProMonsterIDInv');

			if(InvasionProMonsterIDInv(Inv) != None)
			{
				InvasionProMonsterIDInv(Inv).bFriendly = true;
			}
		}
	}
}

simulated function Mutate(string MutateString, PlayerController Sender)
{
	if (MutateString ~= "nextwave" && (Level.Netmode == NM_Standalone || Sender.PlayerReplicationInfo.bAdmin))
	{
		InvasionPro(Level.Game).ForceNextWave();
		Broadcast("Admin Forcing Next Wave");
	}

	Super.Mutate(MutateString, Sender);
}

function Broadcast(string Message)
{
	local Pawn P;

	foreach DynamicActors(class'Pawn', P)
	{
		if (Monster(P) == None)
		{
			P.ClientMessage(Message);
		}
	}
}

defaultproperties
{
     WaveNameDuration=3
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
}
