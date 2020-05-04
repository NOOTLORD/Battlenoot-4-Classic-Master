class InvasionProGameReplicationInfo extends GameReplicationInfo config(InvasionProSettings);

var() int MonsterTeamScore;
var() int CurrentMonstersNum;
var() byte WaveNumber,BaseDifficulty;
var() int NumMonstersToLoad;
var() bool bTeamNecro;
var() int TeamNecroPool;
var() int TeamNecroPoolMax;
var() string NecroName;
var() int TeamNecroCost;
var() bool bBossEncounter;
var() bool bDisableSpeed;
var() bool bDisableBerserk;
var() bool bDisableInvis;
var() bool bDisableDefensive;
var() bool bDisableHealthPacks;
var() bool bDisableWeapons;
var() bool bDisableSuperPickups;
var() bool bDisableWeaponLockers;
var() bool bAerialView;
var() bool bPlayersCanJoin;
var() bool bOverTime;
var() bool bInfiniteBossTime;
var() bool bHideRadar;
var() bool bHidePlayerList;
var() bool bHideNecroPool;
var() bool bHideMonsterCount;
var() float SpawnProtection;
var() string MonsterKillSound;
var() float BossTimeLimit;
var() color WaveDrawColour;
var() color WaveCountDownColour;

//replicate NumLives
var() string PlayerNames[32];
var() int Playerlives[32];
var() Monster FriendlyMonsters[32]; //list of friendly monsters
var() bool bAlwaysOneLife;

struct PetInfo
{
	var() string OwnerID;
	var() string OwnerName;
	var() string PetName;
	var() string PetClass;
	var() int PetLevel;
	var() float xp;
	var() float Points;
	var() float PetCoolDown;
	var() string PetOrders;
	var() int Tier;
	var() int HPxp;
	var() int HPRegenxp;
	var() int HPBoost;
	var() int Sdxp; //speed xp
	var() int SdBoost; //speed boost xp
	var() int Ddgxp; //dodge xp
	var() int Armorxp; //damage reduction xp
	var() int Dmgxp; //damage bonus xp
	var() int Spwnxp; //respawn time xp
	var() int Tlprtxp; //teleport xp
	var() int TlprtDwnxp; //teleport cooldown xp
	var() int TlprtDstxp; //teleport distance xp
	var() int KBxp; //killbonus xp
	var() int xpL; //xpleech
	var() int Aura; //0=none, 1=heal, 2=damage, 3=defense 4=second pet 5=frost
	var() int AAxp; //aura ability xp 1
	var() int ABxp; //aura ability xp 2
	var() string DTClass;
	var() string DTPetName;

};

var() config array<PetInfo> PetData;

var() config int MaxLevel;
var() config float BasePointsNeededPerLevel;
var() config float PointsLevelMultiplier;
var() config float DamageLevelMultiplier;
//var() config bool bPetsIncreaseInSize;
var() config float PetCoolDownTime;
var() config int UnlockAuraLevel;
var() config int AuraRespecCost;

struct PetShop
{
	var() string MonsterName;
	var() string MonsterClassName;
	var() int TierGroup;
};

var() config array<PetShop> ServerPets;

struct TierInfo
{
	var() int TierGroup; //tiergroup 1 75 (0-75_ tiergroup 2 120 (76-120) group 3 180 (121-180)
	var() int MaxLevel;
};

var() config array<TierInfo> TierGroups;
var() config int NumTierGroups;

struct HealthAbility
{
	var() int BasePetHealth; //Pet health at level 0
	var() int HealthMax;
	var() int HealthIncrease;
	var() int HealthIncreaseCost;
	var() int Level;
};

var() config HealthAbility Ability_Health;

struct HealthRegenAbility
{
	var() int HealthRegenMax;
	var() int HealthRegenIncrease;
	var() int HealthRegenIncreaseCost;
	var() int Level;
};

var() config HealthRegenAbility Ability_HealthRegen;

struct HealthBoostAbility
{
	var() int HealthBoostMax;
	var() int HealthBoostIncrease;
	var() int HealthBoostIncreaseCost;
	var() int Level;
};

var() config HealthBoostAbility Ability_HealthBoost;

struct SpeedBoostAbility
{
	var() int SpeedBoostMax;
	var() int SpeedBoostIncrease;
	var() int SpeedBoostIncreaseCost;
	var() int Level;
};

var() config SpeedBoostAbility Ability_SpeedBoost;

struct SpeedAbility
{
	var() int BasePetSpeed;
	var() int SpeedMax;
	var() int SpeedIncrease;
	var() int SpeedIncreaseCost;
	var() int Level;
};

var() config SpeedAbility Ability_Speed;

struct DodgeAbility
{
	var() int DodgeMax;
	var() int DodgeIncrease;
	var() int DodgeIncreaseCost;
	var() int Level;
};

var() config DodgeAbility Ability_Dodge;

struct DamageReductionAbility
{
	var() int DamageReductionMax;
	var() int DamageReductionIncrease;
	var() int DamageReductionIncreaseCost;
	var() int Level;
};

var() config DamageReductionAbility Ability_DamageReduction;

struct DamageBonusAbility
{
	var() int BasePetDamage;
	var() int DamageBonusMax;
	var() int DamageBonusIncrease;
	var() int DamageBonusIncreaseCost;
	var() int Level;
};

var() config DamageBonusAbility Ability_DamageBonus;

struct RespawnAbility
{
	var() int RespawnMax;
	var() int RespawnIncrease;
	var() int RespawnIncreaseCost;
	var() int Level;
};

var() config RespawnAbility Ability_Respawn;

struct TeleportAbility
{
	var() int TeleportCost;
	var() int Level;
};

var() config TeleportAbility Ability_Teleport;

struct TeleportTimeAbility
{
	var() int BaseTeleportCoolDownTime;
	var() int TeleportTimeMax;
	var() int TeleportTimeIncrease;
	var() int TeleportTimeIncreaseCost;
	var() int Level;
};

var() config TeleportTimeAbility Ability_TeleportTime;

struct TeleportDistanceAbility
{
	var() int BaseTeleportDistance;
	var() int TeleportDistanceMax;
	var() int TeleportDistanceIncrease;
	var() int TeleportDistanceIncreaseCost;
	var() int Level;
};

var() config TeleportDistanceAbility Ability_TeleportDistance;

struct KillBonusAbility
{
	var() int KillBonusMax;
	var() int KillBonusIncrease;
	var() int KillBonusIncreaseCost;
	var() int Level;
};
var() config KillBonusAbility Ability_KillBonus;

struct XpLeechAbility
{
	var() int XpLeechCost;
	var() int Level;
};
var() config XpLeechAbility Ability_XpLeech;

struct AuraHealAbility
{
	var() int AuraHealMax;
	var() int AuraHealIncrease;
	var() int AuraHealIncreaseCost;
	var() int AuraRadiusMax;
	var() int AuraRadiusIncrease;
	var() int AuraRadiusIncreaseCost;
	var() bool bDisabled;
};

var() config AuraHealAbility Ability_AuraHeal;

struct AuraDamageAbility
{
	var() int AuraDamageMax;
	var() int AuraDamageIncrease;
	var() int AuraDamageIncreaseCost;
	var() int AuraRadiusMax;
	var() int AuraRadiusIncrease;
	var() int AuraRadiusIncreaseCost;
	var() bool bDisabled;
};

var() config AuraDamageAbility Ability_AuraDamage;

struct AuraCompanion
{
	var() bool bDisabled;
};

var() config AuraCompanion Ability_AuraCompanion;

struct AuraDefenseAbility
{
	var() int AuraDefenseMax;
	var() int AuraDefenseIncrease;
	var() int AuraDefenseIncreaseCost;
	var() int AuraRadiusMax;
	var() int AuraRadiusIncrease;
	var() int AuraRadiusIncreaseCost;
	var() bool bDisabled;
};

var() config AuraDefenseAbility Ability_AuraDefense;

struct AuraFrostAbility
{
	var() int AuraFrostMax;
	var() int AuraFrostIncrease;
	var() int AuraFrostIncreaseCost;
	var() int AuraRadiusMax;
	var() int AuraRadiusIncrease;
	var() int AuraRadiusIncreaseCost;
	var() bool bDisabled;
};

var() config AuraFrostAbility Ability_AuraFrost;

struct AuraChainLightningAbility
{
	var() int AuraChainLightningMax;
	var() int AuraChainLightningIncrease;
	var() int AuraChainLightningIncreaseCost;
	var() int AuraRadiusMax;
	var() int AuraRadiusIncrease;
	var() int AuraRadiusIncreaseCost;
	var() bool bDisabled;
};

var() config AuraChainLightningAbility Ability_AuraChainLightning;

struct AuraResurrectAbility
{
	var() int AuraResurrectMax; //health minions start with,
	var() int AuraResurrectIncrease; //how much the hp increases by each time it is incremented
	var() int AuraResurrectIncreaseCost;
	var() int AuraRadiusMax;
	var() int AuraRadiusIncrease;
	var() int AuraRadiusIncreaseCost;
	var() int MinionLifeSpanMin;
	var() int MinionLifeSpanMax;
	var() int MaxMinions;
	var() bool bDisabled;
};

var() config AuraResurrectAbility Ability_AuraResurrect;

struct AuraRetributionAbility
{
	var() int AuraRetributionMax; //percentage of damage reflected back
	var() int AuraRetributionIncrease;
	var() int AuraRetributionIncreaseCost;
	var() bool bDisabled;
};

var() config AuraRetributionAbility Ability_AuraRetribution;

replication
{
    reliable if ( Role == ROLE_Authority )
        WaveCountDownColour, WaveDrawColour, MonsterTeamScore, CurrentMonstersNum, TeamNecroPool, bBossEncounter, bOverTime, PlayerNames, Playerlives, bPlayersCanJoin, BossTimeLimit;
	reliable if ( bNetInitial && (Role == ROLE_Authority) )
		BaseDifficulty, SpawnProtection, NumMonstersToLoad, bTeamNecro, TeamNecroCost, TeamNecroPoolMax;
	reliable if ( Role == ROLE_Authority )
		WaveNumber, NecroName, MonsterKillSound, FriendlyMonsters, bInfiniteBossTime;//BossHealth, BossBaseHealth, MonsterKillSound, FriendlyMonsters, bInfiniteBossTime, BossName;
	reliable if(bNetInitial && (Role == ROLE_Authority) )
		bAlwaysOneLife, bDisableSpeed, bDisableBerserk, bDisableInvis, bDisableDefensive;
	reliable if(bNetInitial && (Role == ROLE_Authority) )
		bHideNecroPool, bHideMonsterCount, bDisableHealthPacks, bDisableWeapons, bDisableSuperPickups, bDisableWeaponLockers, bAerialView, bHideRadar, bHidePlayerList;
}

static function FillPlayInfo(PlayInfo PI)
{
    Super.FillPlayInfo(PI);
    PI.AddSetting("Invasion Pro", "MaxLevel", "Max Level", 60, 25, "Text", "6;0:999999",,False,True);
    PI.AddSetting("Invasion Pro", "BasePointsNeededPerLevel", "Base Points Needed Per Level", 60, 25, "Text", "12;0.00:9999.00",,False,True);
    PI.AddSetting("Invasion Pro", "PointsLevelMultiplier", "Points Level Multiplier", 60, 25, "Text", "12;0.00:9999.00",,False,True);
    PI.AddSetting("Invasion Pro", "DamageLevelMultiplier", "Damage Level Multiplier", 60, 25, "Text", "12;0.00:9999.00",,False,True);
    PI.AddSetting("Invasion Pro", "PetCoolDownTime", "Pet Cooldown Time", 60, 25, "Text", "12;0.00:9999.00",,False,True);
    PI.AddSetting("Invasion Pro", "UnlockAuraLevel", "Unlock Aura Level", 60, 25, "Text", "6;0:999999",,False,True);
}

static event string GetDescriptionText(string PropName)
{
    switch (PropName)
    {
		case "MaxLevel": return "Maximum level pets can achieve.";
		case "BasePointsNeededPerLevel": return "Number of points needed to get to the next level, this is multiplied by the pets level and Points Level Multiplier.";
		case "PointsLevelMultiplier": return "This is multiplied by the pets level and Points Needed Per Level to get the final number of points needed to level up.";
		case "DamageLevelMultiplier": return "Used to work out the base damage output of the pet. This figure is multiplied by the pets level and base pet damage.";
		case "PetCoolDownTime": return "The default pet cooldown time before any abilities are applied.";
		case "UnlockAuraLevel": return "The level at which pets can have the aura abilities.";
    }

    return Super.GetDescriptionText(PropName);
}

simulated function int GetNumLives(PlayerReplicationInfo PRI)
{
	local int i;

	if(PRI != None)
	{
		for(i=0;i<32;i++)
		{
			if(PRI.PlayerName ~= PlayerNames[i])
			{
				return Playerlives[i];
			}
		}
	}
}

simulated function AddPRI(PlayerReplicationInfo PRI)
{
    local byte NewVoiceID;
    local int i;

	if(PRI == None)
	{
		return;
	}

    if ( Level.NetMode == NM_ListenServer || Level.NetMode == NM_DedicatedServer )
    {
        for (i = 0; i < PRIArray.Length; i++)
        {
            if ( PRIArray[i].VoiceID == NewVoiceID )
            {
                i = -1;
                NewVoiceID++;
                continue;
            }
        }

        if ( NewVoiceID >= 32 )
            NewVoiceID = 0;

        PRI.VoiceID = NewVoiceID;
    }

    PRIArray[PRIArray.Length] = PRI;
}

simulated function RemovePRI(PlayerReplicationInfo PRI)
{
    local int i;

    for (i=0; i<PRIArray.Length; i++)
    {
        if (PRIArray[i] == PRI)
        {
            PRIArray.Remove(i,1);
            return;
        }
    }
}

simulated function AddFriendlyMonster(Monster M)
{
	local int i;

	for(i=0;i<32;i++)
	{
		if(FriendlyMonsters[i] == None)
		{
			FriendlyMonsters[i] = M;
			break;
		}
	}
}

simulated function RemoveFriendlyMonster(Monster M)
{
	local int i;

	for(i=0;i<32;i++)
	{
		if(FriendlyMonsters[i] == M)
		{
			FriendlyMonsters[i] = None;
			break;
		}
	}
}

defaultproperties
{
     MonsterKillSound="None"
     WaveDrawColour=(R=255,A=255)
     WaveCountDownColour=(G=255,R=255,A=255)
     PetData(0)=(OwnerID="5857a730b66505da430f3bef2b845c38",OwnerName="DevMode",PetName="DevMode",PetClass="SkaarjPack.Krall",PetCoolDown=100.000000,PetOrders="Defend",Tier=1)
     MaxLevel=75
     BasePointsNeededPerLevel=100.000000
     PointsLevelMultiplier=2.250000
     DamageLevelMultiplier=1.250000
     PetCoolDownTime=120.000000
     UnlockAuraLevel=75
     AuraRespecCost=1000
     ServerPets(0)=(MonsterName="Pupae",MonsterClassName="SkaarjPack.SkaarjPupae",TierGroup=1)
     ServerPets(1)=(MonsterName="Razor Fly",MonsterClassName="SkaarjPack.Razorfly",TierGroup=1)
     ServerPets(2)=(MonsterName="Manta",MonsterClassName="SkaarjPack.Manta",TierGroup=1)
     ServerPets(3)=(MonsterName="Krall",MonsterClassName="SkaarjPack.Krall",TierGroup=1)
     ServerPets(4)=(MonsterName="Elite Krall",MonsterClassName="SkaarjPack.EliteKrall",TierGroup=2)
     ServerPets(5)=(MonsterName="Gasbag",MonsterClassName="SkaarjPack.Gasbag",TierGroup=2)
     ServerPets(6)=(MonsterName="Skaarj",MonsterClassName="SkaarjPack.Skaarj",TierGroup=2)
     ServerPets(7)=(MonsterName="Behemoth",MonsterClassName="SkaarjPack.Brute",TierGroup=2)
     ServerPets(8)=(MonsterName="Ice Skaarj",MonsterClassName="SkaarjPack.IceSkaarj",TierGroup=3)
     ServerPets(9)=(MonsterName="Fire Skaarj",MonsterClassName="SkaarjPack.FireSkaarj",TierGroup=3)
     ServerPets(10)=(MonsterName="WarLord",MonsterClassName="SkaarjPack.Behemoth",TierGroup=3)
     ServerPets(11)=(MonsterName="WarLord",MonsterClassName="SkaarjPack.WarLord",TierGroup=3)
     NumTierGroups=3
     Ability_Health=(BasePetHealth=50,HealthMax=1000,HealthIncrease=5,HealthIncreaseCost=10)
     Ability_HealthRegen=(HealthRegenMax=10,HealthRegenIncrease=1,HealthRegenIncreaseCost=10)
     Ability_HealthBoost=(HealthBoostMax=30,HealthBoostIncrease=1,HealthBoostIncreaseCost=20)
     Ability_SpeedBoost=(SpeedBoostMax=30,SpeedBoostIncrease=1,SpeedBoostIncreaseCost=40)
     Ability_Speed=(BasePetSpeed=300,SpeedMax=500,SpeedIncrease=5,SpeedIncreaseCost=25)
     Ability_Dodge=(DodgeMax=10,DodgeIncrease=1,DodgeIncreaseCost=100)
     Ability_DamageReduction=(DamageReductionMax=50,DamageReductionIncrease=1,DamageReductionIncreaseCost=50)
     Ability_DamageBonus=(BasePetDamage=8,DamageBonusMax=30,DamageBonusIncrease=1,DamageBonusIncreaseCost=40)
     Ability_Respawn=(RespawnMax=20,RespawnIncrease=1,RespawnIncreaseCost=50)
     Ability_Teleport=(TeleportCost=500)
     Ability_TeleportTime=(BaseTeleportCoolDownTime=90,TeleportTimeMax=90,TeleportTimeIncrease=1,TeleportTimeIncreaseCost=40)
     Ability_TeleportDistance=(BaseTeleportDistance=500,TeleportDistanceMax=2000,TeleportDistanceIncrease=100,TeleportDistanceIncreaseCost=40)
     Ability_KillBonus=(KillBonusMax=5,KillBonusIncrease=1,KillBonusIncreaseCost=25)
     Ability_XpLeech=(XpLeechCost=25)
     Ability_AuraHeal=(AuraHealMax=25,AuraHealIncrease=1,AuraHealIncreaseCost=25,AuraRadiusMax=1000,AuraRadiusIncrease=20,AuraRadiusIncreaseCost=20)
     Ability_AuraDamage=(AuraDamageMax=15,AuraDamageIncrease=1,AuraDamageIncreaseCost=25,AuraRadiusMax=1000,AuraRadiusIncrease=20,AuraRadiusIncreaseCost=20)
     Ability_AuraDefense=(AuraDefenseMax=500,AuraDefenseIncrease=10,AuraDefenseIncreaseCost=20,AuraRadiusMax=300,AuraRadiusIncrease=20,AuraRadiusIncreaseCost=20)
     Ability_AuraFrost=(AuraFrostMax=100,AuraFrostIncrease=1,AuraFrostIncreaseCost=20,AuraRadiusMax=800,AuraRadiusIncrease=10,AuraRadiusIncreaseCost=10)
     Ability_AuraChainLightning=(AuraChainLightningMax=100,AuraChainLightningIncrease=1,AuraChainLightningIncreaseCost=20,AuraRadiusMax=800,AuraRadiusIncrease=10,AuraRadiusIncreaseCost=10)
     Ability_AuraResurrect=(AuraResurrectMax=100,AuraResurrectIncrease=1,AuraResurrectIncreaseCost=20,AuraRadiusMax=800,AuraRadiusIncrease=10,AuraRadiusIncreaseCost=10,MinionLifeSpanMin=30,MinionLifeSpanMax=60,MaxMinions=8)
     Ability_AuraRetribution=(AuraRetributionMax=100,AuraRetributionIncrease=1,AuraRetributionIncreaseCost=25)
}
