class InvasionProPetStatsItem extends Actor;

var() string OwnerID;
var() string OwnerName;
var() string PetName;
var() string PetClass;
var() int PetLevel;
var() float XP;
var() float Points;
var() float PetCoolDown;
var() InvasionProMutator MyMut;
var() InvasionProPetMenuConfig MyMenu;
var() FriendlyMonsterController MyFriendlyController;
var() InvasionProFriendlyMonsterReplicationInfo MyPRI;
var() InvasionProFriendlyMonsterReplicationInfo CompanionPRI;
var() string PetOrders;
var() bool bTierMode;
var() int Tier;
var() int MaxTier;
var() int NextTierLvl;
var() int HpXp; //health xp
var() int HpRegenXp; //health regen xp
var() int HpBoost; //health boost xp
var() int SdXp; //speed xp
var() int SdBoost; //speed boost xp
var() int DdgXp; //dodge xp
var() int ArmorXp; //damage reduction xp
var() int DmgXp; //damage bonus xp
var() int SpwnXp; //respawn time xp
var() int TlprtXp; //teleport xp
var() int TlprtDwnXp; //teleport cooldown xp
var() int TlprtDstXp; //teleport distance xp
var() int KBXp; //killbonus xp
var() int XpL; //xpleech
var() int Aura; //0=none, 1=heal, 2=damage, 3=defense 4=pet 5=frost 6=lightning 7=resurrect 8=retribution
var() int AAxp; //aura ability xp 1
var() int ABxp; //aura ability xp 2 //radius
var() bool bAutoSummon;
var() int UnlockAuraLevel;
var() string DTClass;
var() string DTPetName;
var() int MaxLevel;

struct PetShop
{
	var() string MonsterName;
	var() string MonsterClassName;
	var() int TierGroup;
};

var() PetShop ServerPets[250];
var() Monster MyPet;
var() Monster PetCompanion;
var() InvasionProXPlayer MyOwner;
var() InvasionProPetInventory MyPetInv;
var() int AuraRespecCost;

struct HealthAbility
{
	var() int BasePetHealth;
	var() int HealthMax;
	var() int HealthIncrease;
	var() int HealthIncreaseCost;
	var() int Level;
};
var() HealthAbility Ability_Health;

struct HealthRegenAbility
{
	var() int HealthRegenMax;
	var() int HealthRegenIncrease;
	var() int HealthRegenIncreaseCost;
	var() int Level;
};
var() HealthRegenAbility Ability_HealthRegen;

struct HealthBoostAbility
{
	var() int HealthBoostMax;
	var() int HealthBoostIncrease;
	var() int HealthBoostIncreaseCost;
	var() int Level;
};
var() HealthBoostAbility Ability_HealthBoost;

struct SpeedBoostAbility
{
	var() int SpeedBoostMax;
	var() int SpeedBoostIncrease;
	var() int SpeedBoostIncreaseCost;
	var() int Level;
};
var() SpeedBoostAbility Ability_SpeedBoost;

struct SpeedAbility
{
	var() int BasePetSpeed;
	var() int SpeedMax;
	var() int SpeedIncrease;
	var() int SpeedIncreaseCost;
	var() int Level;
};
var() SpeedAbility Ability_Speed;

struct DodgeAbility
{
	var() int DodgeMax;
	var() int DodgeIncrease;
	var() int DodgeIncreaseCost;
	var() int Level;
};
var() DodgeAbility Ability_Dodge;

struct DamageReductionAbility
{
	var() int DamageReductionMax;
	var() int DamageReductionIncrease;
	var() int DamageReductionIncreaseCost;
	var() int Level;
};
var() DamageReductionAbility Ability_DamageReduction;

struct DamageBonusAbility
{
	var() int BasePetDamage;
	var() int DamageBonusMax;
	var() int DamageBonusIncrease;
	var() int DamageBonusIncreaseCost;
	var() int Level;
};

var() DamageBonusAbility Ability_DamageBonus;

struct RespawnAbility
{
	var() int RespawnMax;
	var() int RespawnIncrease;
	var() int RespawnIncreaseCost;
	var() int Level;
};
var() RespawnAbility Ability_Respawn;

struct TeleportAbility
{
	var() int TeleportCost;
	var() int Level;
};
var() TeleportAbility Ability_Teleport;

struct TeleportTimeAbility
{
	var() int BaseTeleportCoolDownTime;
	var() int TeleportTimeMax;
	var() int TeleportTimeIncrease;
	var() int TeleportTimeIncreaseCost;
	var() int Level;
};

var() TeleportTimeAbility Ability_TeleportTime;

struct TeleportDistanceAbility
{
	var() int BaseTeleportDistance;
	var() int TeleportDistanceMax;
	var() int TeleportDistanceIncrease;
	var() int TeleportDistanceIncreaseCost;
	var() int Level;
};

var() TeleportDistanceAbility Ability_TeleportDistance;

struct KillBonusAbility
{
	var() int KillBonusMax;
	var() int KillBonusIncrease;
	var() int KillBonusIncreaseCost;
	var() int Level;
};
var() KillBonusAbility Ability_KillBonus;

struct XpLeechAbility
{
	var() int XpLeechCost;
	var() int Level;
};
var() XpLeechAbility Ability_XpLeech;

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
var() AuraHealAbility Ability_AuraHeal;

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
var() AuraDamageAbility Ability_AuraDamage;

struct AuraCompanion
{
	var() bool bDisabled;
};

var() AuraCompanion Ability_AuraCompanion;

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
var() AuraDefenseAbility Ability_AuraDefense;

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

var() AuraFrostAbility Ability_AuraFrost;

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

var() AuraChainLightningAbility Ability_AuraChainLightning;

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

var() AuraResurrectAbility Ability_AuraResurrect;

struct AuraRetributionAbility
{
	var() int AuraRetributionMax; //percentage of damage reflected back
	var() int AuraRetributionIncrease;
	var() int AuraRetributionIncreaseCost;
	var() bool bDisabled;
};

var() AuraRetributionAbility Ability_AuraRetribution;

replication
{
	reliable if(Role == Role_Authority && bNetInitial)
		ServerPets, MyOwner, bTierMode, MaxTier, MyMut, OwnerID, UnlockAuraLevel, MaxLevel, AuraRespecCost;
	reliable if(Role == Role_Authority && bNetInitial)
		Ability_AuraDamage, Ability_XpLeech, Ability_Health, Ability_HealthRegen, Ability_HealthBoost, Ability_Dodge, Ability_Speed, Ability_SpeedBoost, Ability_AuraHeal, Ability_KillBonus, Ability_AuraFrost, Ability_AuraCompanion;
	reliable if(Role == Role_Authority && bNetInitial)
		Ability_TeleportDistance, Ability_TeleportTime, Ability_Teleport, Ability_Respawn, Ability_DamageBonus, Ability_DamageReduction, Ability_AuraDefense, Ability_AuraChainLightning, Ability_AuraResurrect, Ability_AuraRetribution;
	reliable if(Role == Role_Authority)
		MyPet, Reinitialize, PetOrders, Tier, HPxp, HPRegenxp, HPBoost, XP, bAutoSummon, CreateAuraOptions;
	reliable if(Role == Role_Authority)
		OwnerName, PetName, PetClass, PetLevel, Points, PetCoolDown, SDxp, DDGxp, SdBoost, ArmorXp, DmgXp, SpwnXp, TlprtXp, Aura, AAxp, ABxp;
	reliable if(Role == Role_Authority)
		TlprtDwnXp, TlprtDstXp, NextTierLvl, KBXp, XpL, DTClass, DTPetName;
	reliable if(Role != Role_Authority)
		RespecAura, ServerSetPetName, ServerSetCompanionPetName, ServerSetPetClass, ServerSetCompanionPetClass, ServerAwardPetPoints, SummonPet, RecallPet, DiscardPet, SavePet, UpdateAbility, SetAutoSummon, SaveCompanionPet;
}

function UpdateServerPets()
{
	local int i;

	for(i=0;i<class'InvasionProGameReplicationInfo'.default.ServerPets.Length;i++)
	{
		if(i < 250)
		{
			ServerPets[i].MonsterName = class'InvasionProGameReplicationInfo'.default.ServerPets[i].MonsterName;
			ServerPets[i].MonsterClassName = class'InvasionProGameReplicationInfo'.default.ServerPets[i].MonsterClassName;
			ServerPets[i].TierGroup = class'InvasionProGameReplicationInfo'.default.ServerPets[i].TierGroup;
		}
	}

	AuraRespecCost = class'InvasionProGameReplicationInfo'.default.AuraRespecCost;
	MaxLevel = class'InvasionProGameReplicationInfo'.default.MaxLevel;
	Ability_HealthBoost.HealthBoostMax = class'InvasionProGameReplicationInfo'.default.Ability_HealthBoost.HealthBoostMax;
	Ability_HealthBoost.HealthBoostIncrease = class'InvasionProGameReplicationInfo'.default.Ability_HealthBoost.HealthBoostIncrease;
	Ability_HealthBoost.HealthBoostIncreaseCost = class'InvasionProGameReplicationInfo'.default.Ability_HealthBoost.HealthBoostIncreaseCost;
	Ability_HealthBoost.Level = class'InvasionProGameReplicationInfo'.default.Ability_HealthBoost.Level;
	Ability_HealthRegen.HealthRegenMax = class'InvasionProGameReplicationInfo'.default.Ability_HealthRegen.HealthRegenMax;
	Ability_HealthRegen.HealthRegenIncrease = class'InvasionProGameReplicationInfo'.default.Ability_HealthRegen.HealthRegenIncrease;
	Ability_HealthRegen.HealthRegenIncreaseCost = class'InvasionProGameReplicationInfo'.default.Ability_HealthRegen.HealthRegenIncreaseCost;
	Ability_HealthRegen.Level = class'InvasionProGameReplicationInfo'.default.Ability_HealthRegen.Level;
	Ability_Health.BasePetHealth = class'InvasionProGameReplicationInfo'.default.Ability_Health.BasePetHealth;
	Ability_Health.HealthMax = class'InvasionProGameReplicationInfo'.default.Ability_Health.HealthMax;
	Ability_Health.HealthIncrease = class'InvasionProGameReplicationInfo'.default.Ability_Health.HealthIncrease;
	Ability_Health.HealthIncreaseCost = class'InvasionProGameReplicationInfo'.default.Ability_Health.HealthIncreaseCost;
	Ability_Health.Level = class'InvasionProGameReplicationInfo'.default.Ability_Health.Level;
	Ability_SpeedBoost.SpeedBoostMax = class'InvasionProGameReplicationInfo'.default.Ability_SpeedBoost.SpeedBoostMax;
	Ability_SpeedBoost.SpeedBoostIncrease = class'InvasionProGameReplicationInfo'.default.Ability_SpeedBoost.SpeedBoostIncrease;
	Ability_SpeedBoost.SpeedBoostIncreaseCost = class'InvasionProGameReplicationInfo'.default.Ability_SpeedBoost.SpeedBoostIncreaseCost;
	Ability_SpeedBoost.Level = class'InvasionProGameReplicationInfo'.default.Ability_SpeedBoost.Level;
	Ability_Speed.BasePetSpeed = class'InvasionProGameReplicationInfo'.default.Ability_Speed.BasePetSpeed;
	Ability_Speed.SpeedMax = class'InvasionProGameReplicationInfo'.default.Ability_Speed.SpeedMax;
	Ability_Speed.SpeedIncrease = class'InvasionProGameReplicationInfo'.default.Ability_Speed.SpeedIncrease;
	Ability_Speed.SpeedIncreaseCost = class'InvasionProGameReplicationInfo'.default.Ability_Speed.SpeedIncreaseCost;
	Ability_Speed.Level = class'InvasionProGameReplicationInfo'.default.Ability_Speed.Level;
	Ability_Dodge.DodgeMax = class'InvasionProGameReplicationInfo'.default.Ability_Dodge.DodgeMax;
	Ability_Dodge.DodgeIncrease = class'InvasionProGameReplicationInfo'.default.Ability_Dodge.DodgeIncrease;
	Ability_Dodge.DodgeIncreaseCost = class'InvasionProGameReplicationInfo'.default.Ability_Dodge.DodgeIncreaseCost;
	Ability_Dodge.Level = class'InvasionProGameReplicationInfo'.default.Ability_Dodge.Level;
	Ability_DamageReduction.DamageReductionMax = class'InvasionProGameReplicationInfo'.default.Ability_DamageReduction.DamageReductionMax;
	Ability_DamageReduction.DamageReductionIncrease = class'InvasionProGameReplicationInfo'.default.Ability_DamageReduction.DamageReductionIncrease;
	Ability_DamageReduction.DamageReductionIncreaseCost = class'InvasionProGameReplicationInfo'.default.Ability_DamageReduction.DamageReductionIncreaseCost;
	Ability_DamageReduction.Level = class'InvasionProGameReplicationInfo'.default.Ability_DamageReduction.Level;
	Ability_DamageBonus.BasePetDamage = class'InvasionProGameReplicationInfo'.default.Ability_DamageBonus.BasePetDamage;
	Ability_DamageBonus.DamageBonusMax = class'InvasionProGameReplicationInfo'.default.Ability_DamageBonus.DamageBonusMax;
	Ability_DamageBonus.DamageBonusIncrease = class'InvasionProGameReplicationInfo'.default.Ability_DamageBonus.DamageBonusIncrease;
	Ability_DamageBonus.DamageBonusIncreaseCost = class'InvasionProGameReplicationInfo'.default.Ability_DamageBonus.DamageBonusIncreaseCost;
	Ability_DamageBonus.Level = class'InvasionProGameReplicationInfo'.default.Ability_DamageBonus.Level;
	Ability_Respawn.RespawnMax = class'InvasionProGameReplicationInfo'.default.Ability_Respawn.RespawnMax;
	Ability_Respawn.RespawnIncrease = class'InvasionProGameReplicationInfo'.default.Ability_Respawn.RespawnIncrease;
	Ability_Respawn.RespawnIncreaseCost = class'InvasionProGameReplicationInfo'.default.Ability_Respawn.RespawnIncreaseCost;
	Ability_Respawn.Level = class'InvasionProGameReplicationInfo'.default.Ability_Respawn.Level;
	Ability_Teleport.TeleportCost = class'InvasionProGameReplicationInfo'.default.Ability_Teleport.TeleportCost;
	Ability_Teleport.Level = class'InvasionProGameReplicationInfo'.default.Ability_Teleport.Level;
	Ability_TeleportTime.BaseTeleportCoolDownTime = class'InvasionProGameReplicationInfo'.default.Ability_TeleportTime.BaseTeleportCoolDownTime;
	Ability_TeleportTime.TeleportTimeMax = class'InvasionProGameReplicationInfo'.default.Ability_TeleportTime.TeleportTimeMax;
	Ability_TeleportTime.TeleportTimeIncrease = class'InvasionProGameReplicationInfo'.default.Ability_TeleportTime.TeleportTimeIncrease;
	Ability_TeleportTime.TeleportTimeIncreaseCost = class'InvasionProGameReplicationInfo'.default.Ability_TeleportTime.TeleportTimeIncreaseCost;
	Ability_TeleportTime.Level = class'InvasionProGameReplicationInfo'.default.Ability_TeleportTime.Level;
	Ability_TeleportDistance.BaseTeleportDistance = class'InvasionProGameReplicationInfo'.default.Ability_TeleportDistance.BaseTeleportDistance;
	Ability_TeleportDistance.TeleportDistanceMax = class'InvasionProGameReplicationInfo'.default.Ability_TeleportDistance.TeleportDistanceMax;
	Ability_TeleportDistance.TeleportDistanceIncrease = class'InvasionProGameReplicationInfo'.default.Ability_TeleportDistance.TeleportDistanceIncrease;
	Ability_TeleportDistance.TeleportDistanceIncreaseCost = class'InvasionProGameReplicationInfo'.default.Ability_TeleportDistance.TeleportDistanceIncreaseCost;
	Ability_TeleportDistance.Level = class'InvasionProGameReplicationInfo'.default.Ability_TeleportDistance.Level;
	Ability_KillBonus.KillBonusMax = class'InvasionProGameReplicationInfo'.default.Ability_KillBonus.KillBonusMax;
	Ability_KillBonus.KillBonusIncrease = class'InvasionProGameReplicationInfo'.default.Ability_KillBonus.KillBonusIncrease;
	Ability_KillBonus.KillBonusIncreaseCost = class'InvasionProGameReplicationInfo'.default.Ability_KillBonus.KillBonusIncreaseCost;
	Ability_KillBonus.Level = class'InvasionProGameReplicationInfo'.default.Ability_KillBonus.Level;
	Ability_XpLeech.XpLeechCost = class'InvasionProGameReplicationInfo'.default.Ability_XpLeech.XpLeechCost;
	Ability_XpLeech.Level = class'InvasionProGameReplicationInfo'.default.Ability_XpLeech.Level;
	UnlockAuraLevel = class'InvasionProGameReplicationInfo'.default.UnlockAuraLevel;
	Ability_AuraHeal.AuraHealMax = class'InvasionProGameReplicationInfo'.default.Ability_AuraHeal.AuraHealMax;
	Ability_AuraHeal.AuraHealIncrease = class'InvasionProGameReplicationInfo'.default.Ability_AuraHeal.AuraHealIncrease;
	Ability_AuraHeal.AuraHealIncreaseCost = class'InvasionProGameReplicationInfo'.default.Ability_AuraHeal.AuraHealIncreaseCost;
	Ability_AuraHeal.AuraRadiusMax = class'InvasionProGameReplicationInfo'.default.Ability_AuraHeal.AuraRadiusMax;
	Ability_AuraHeal.AuraRadiusIncrease = class'InvasionProGameReplicationInfo'.default.Ability_AuraHeal.AuraRadiusIncrease;
	Ability_AuraHeal.AuraRadiusIncreaseCost = class'InvasionProGameReplicationInfo'.default.Ability_AuraHeal.AuraRadiusIncreaseCost;
	Ability_AuraHeal.bDisabled = class'InvasionProGameReplicationInfo'.default.Ability_AuraHeal.bDisabled;
	Ability_AuraDamage.AuraDamageMax = class'InvasionProGameReplicationInfo'.default.Ability_AuraDamage.AuraDamageMax;
	Ability_AuraDamage.AuraDamageIncrease = class'InvasionProGameReplicationInfo'.default.Ability_AuraDamage.AuraDamageIncrease;
	Ability_AuraDamage.AuraDamageIncreaseCost = class'InvasionProGameReplicationInfo'.default.Ability_AuraDamage.AuraDamageIncreaseCost;
	Ability_AuraDamage.AuraRadiusMax = class'InvasionProGameReplicationInfo'.default.Ability_AuraHeal.AuraRadiusMax;
	Ability_AuraDamage.AuraRadiusIncrease = class'InvasionProGameReplicationInfo'.default.Ability_AuraHeal.AuraRadiusIncrease;
	Ability_AuraDamage.AuraRadiusIncreaseCost = class'InvasionProGameReplicationInfo'.default.Ability_AuraHeal.AuraRadiusIncreaseCost;
	Ability_AuraDamage.bDisabled = class'InvasionProGameReplicationInfo'.default.Ability_AuraHeal.bDisabled;
	Ability_AuraDefense.AuraDefenseMax = class'InvasionProGameReplicationInfo'.default.Ability_AuraDefense.AuraDefenseMax;
	Ability_AuraDefense.AuraDefenseIncrease = class'InvasionProGameReplicationInfo'.default.Ability_AuraDefense.AuraDefenseIncrease;
	Ability_AuraDefense.AuraDefenseIncreaseCost = class'InvasionProGameReplicationInfo'.default.Ability_AuraDefense.AuraDefenseIncreaseCost;
	Ability_AuraDefense.AuraRadiusMax = class'InvasionProGameReplicationInfo'.default.Ability_AuraDefense.AuraRadiusMax;
	Ability_AuraDefense.AuraRadiusIncrease = class'InvasionProGameReplicationInfo'.default.Ability_AuraDefense.AuraRadiusIncrease;
	Ability_AuraDefense.AuraRadiusIncreaseCost = class'InvasionProGameReplicationInfo'.default.Ability_AuraDefense.AuraRadiusIncreaseCost;
	Ability_AuraDefense.bDisabled = class'InvasionProGameReplicationInfo'.default.Ability_AuraDefense.bDisabled;
	Ability_AuraFrost.AuraFrostMax = class'InvasionProGameReplicationInfo'.default.Ability_AuraFrost.AuraFrostMax;
	Ability_AuraFrost.AuraFrostIncrease = class'InvasionProGameReplicationInfo'.default.Ability_AuraFrost.AuraFrostIncrease;
	Ability_AuraFrost.AuraFrostIncreaseCost = class'InvasionProGameReplicationInfo'.default.Ability_AuraFrost.AuraFrostIncreaseCost;
	Ability_AuraFrost.AuraRadiusMax = class'InvasionProGameReplicationInfo'.default.Ability_AuraFrost.AuraRadiusMax;
	Ability_AuraFrost.AuraRadiusIncrease = class'InvasionProGameReplicationInfo'.default.Ability_AuraFrost.AuraRadiusIncrease;
	Ability_AuraFrost.AuraRadiusIncreaseCost = class'InvasionProGameReplicationInfo'.default.Ability_AuraFrost.AuraRadiusIncreaseCost;
	Ability_AuraFrost.bDisabled = class'InvasionProGameReplicationInfo'.default.Ability_AuraFrost.bDisabled;
	Ability_AuraChainLightning.AuraChainLightningMax = class'InvasionProGameReplicationInfo'.default.Ability_AuraChainLightning.AuraChainLightningMax;
	Ability_AuraChainLightning.AuraChainLightningIncrease = class'InvasionProGameReplicationInfo'.default.Ability_AuraChainLightning.AuraChainLightningIncrease;
	Ability_AuraChainLightning.AuraChainLightningIncreaseCost = class'InvasionProGameReplicationInfo'.default.Ability_AuraChainLightning.AuraChainLightningIncreaseCost;
	Ability_AuraChainLightning.AuraRadiusMax = class'InvasionProGameReplicationInfo'.default.Ability_AuraChainLightning.AuraRadiusMax;
	Ability_AuraChainLightning.AuraRadiusIncrease = class'InvasionProGameReplicationInfo'.default.Ability_AuraChainLightning.AuraRadiusIncrease;
	Ability_AuraChainLightning.AuraRadiusIncreaseCost = class'InvasionProGameReplicationInfo'.default.Ability_AuraChainLightning.AuraRadiusIncreaseCost;
	Ability_AuraChainLightning.bDisabled = class'InvasionProGameReplicationInfo'.default.Ability_AuraChainLightning.bDisabled;
	Ability_AuraResurrect.AuraResurrectMax = class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.AuraResurrectMax;
	Ability_AuraResurrect.AuraResurrectIncrease = class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.AuraResurrectIncrease;
	Ability_AuraResurrect.AuraResurrectIncreaseCost = class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.AuraResurrectIncreaseCost;
	Ability_AuraResurrect.AuraRadiusMax = class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.AuraRadiusMax;
	Ability_AuraResurrect.AuraRadiusIncrease = class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.AuraRadiusIncrease;
	Ability_AuraResurrect.AuraRadiusIncreaseCost = class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.AuraRadiusIncreaseCost;
	Ability_AuraResurrect.MinionLifeSpanMin = class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.MinionLifeSpanMin;
	Ability_AuraResurrect.MinionLifeSpanMax = class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.MinionLifeSpanMax;
	Ability_AuraResurrect.MaxMinions = class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.MaxMinions;
	Ability_AuraResurrect.bDisabled = class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.bDisabled;
	Ability_AuraRetribution.AuraRetributionMax = class'InvasionProGameReplicationInfo'.default.Ability_AuraRetribution.AuraRetributionMax;
	Ability_AuraRetribution.AuraRetributionIncrease = class'InvasionProGameReplicationInfo'.default.Ability_AuraRetribution.AuraRetributionIncrease;
	Ability_AuraRetribution.AuraRetributionIncreaseCost = class'InvasionProGameReplicationInfo'.default.Ability_AuraRetribution.AuraRetributionIncreaseCost;
	Ability_AuraRetribution.bDisabled = class'InvasionProGameReplicationInfo'.default.Ability_AuraRetribution.bDisabled;
	Ability_AuraCompanion.bDisabled = class'InvasionProGameReplicationInfo'.default.Ability_AuraCompanion.bDisabled;
}

simulated function SavePet()
{
	local int i;

	if(Role == Role_Authority)
	{
		for(i=0;i<class'InvasionProGameReplicationInfo'.default.PetData.Length;i++)
		{
			if(class'InvasionProGameReplicationInfo'.default.PetData[i].OwnerID == OwnerID)
			{
				class'InvasionProGameReplicationInfo'.default.PetData[i].PetName = PetName;
				class'InvasionProGameReplicationInfo'.default.PetData[i].PetClass = PetClass;
				class'InvasionProGameReplicationInfo'.static.StaticSaveConfig();
				break;
			}
		}
	}
}

simulated function SaveCompanionPet()
{
	local int i;

	if(Role == Role_Authority)
	{
		if(PetCompanion != None)
		{
			RecallPet(true);
		}

		for(i=0;i<class'InvasionProGameReplicationInfo'.default.PetData.Length;i++)
		{
			if(class'InvasionProGameReplicationInfo'.default.PetData[i].OwnerID == OwnerID)
			{
				class'InvasionProGameReplicationInfo'.default.PetData[i].DTPetName = DTPetName;
				class'InvasionProGameReplicationInfo'.default.PetData[i].DTClass = DTClass;
				class'InvasionProGameReplicationInfo'.static.StaticSaveConfig();
				break;
			}
		}
	}
}

simulated function SummonPet()
{
	local class<Monster> MClass;
	local vector SpawnLocation;

	if(Role == Role_Authority)
	{
		if(Level.Game.IsInState('MatchInProgress') && MyPet == None && MyOwner != None && MyOwner.Pawn != None && MyOwner.Pawn.Health > 0)
		{
			MClass = class<Monster>(DynamicLoadObject(PetClass,class'class',true));
			if(MClass != None)
			{
				SpawnLocation = GetPetSpawnLocation(MyOwner.Pawn);
				MyPet = Spawn(MClass,,,SpawnLocation);
				if(MyPet != None)
				{
					MyPet.PlaySound(Sound'Pet_SkillMax',Slot_Misc);
					Spawn(class'InvasionProPetTeleportFXIn',MyPet,,MyPet.Location);
					if(MyPet.Controller != None)
					{
						MyPet.Controller.Destroy();
					}

					MyFriendlyController = Spawn(class'InvasionProv1_7.FriendlyMonsterController');
					if(MyFriendlyController != None)
					{
						MyFriendlyController.Possess(MyPet);
						MyFriendlyController.MyStats = Self;
						MyFriendlyController.bPetCanTeleport = true;
						if(MyOwner != None)
						{
							MyFriendlyController.SetMaster(MyOwner);
						}
					}

					if(MyOwner != None)
					{
						MyOwner.MyStats = Self;
					}

					MyPRI = Spawn(class'InvasionProFriendlyMonsterReplicationInfo',MyPet);
					UpdatePRI();

					MyPetInv = Spawn(class'InvasionProPetInventory',MyPet);
					if(MyPetInv != None)
					{
						MyPetInv.GiveTo(MyPet);
						MyPetInv.MyPet = MyPet;
						MyPetInv.MyStats = Self;
					}

					SetPetCoolDown();
					UpdatePet();
				}
			}
		}
	}
}

function SummonCompanion()
{
	local class<Monster> MClass;
	local vector SpawnLocation;
	local InvasionProPetInventory MyCompanionInv;
	local FriendlyMonsterController MyCompanionController;
	local float NewValue, ValueBoost;

	if(ValidPackage(DTClass) && PetCompanion == None && MyPet != None && Aura == 4)
	{
		MClass = class<Monster>(DynamicLoadObject(DTClass,class'class',true));
		if(MClass != None)
		{
			SpawnLocation = GetPetSpawnLocation(MyPet);
			PetCompanion = Spawn(MClass,MyPet,,SpawnLocation);
			if(PetCompanion != None)
			{
				PetCompanion.PlaySound(Sound'Pet_SkillMax',Slot_Misc);
				Spawn(class'InvasionProPetTeleportFXIn',PetCompanion,,PetCompanion.Location);
				if(PetCompanion.Controller != None)
				{
					PetCompanion.Controller.Destroy();
				}

				MyCompanionController = Spawn(class'InvasionProv1_7.FriendlyMonsterController');
				if(MyCompanionController != None)
				{
					MyCompanionController.Possess(PetCompanion);
					MyCompanionController.MyStats = Self;
					MyCompanionController.bCompanionPet = true;
					if(MyOwner != None)
					{
						MyCompanionController.SetMaster(MyOwner);
					}
				}

				CompanionPRI = Spawn(class'InvasionProFriendlyMonsterReplicationInfo',PetCompanion);
				if(CompanionPRI != None)
				{
					if(MyCompanionController != None)
					{
						if(MyCompanionController.PlayerReplicationInfo != None)
						{
							MyCompanionController.PlayerReplicationInfo.Destroy();
						}

						MyCompanionController.PlayerReplicationInfo = CompanionPRI;
					}

					if(PetCompanion != None)
					{
						if(PetCompanion.PlayerReplicationInfo != None)
						{
							PetCompanion.PlayerReplicationInfo.Destroy();
						}

						PetCompanion.PlayerReplicationInfo = CompanionPRI;
					}

					if(MyOwner != None && MyOwner.PlayerReplicationInfo != None && MyOwner.PlayerReplicationInfo.Team != None)
					{
						CompanionPRI.Team = MyOwner.PlayerReplicationInfo.Team;
						if(MyCompanionController != None)
						{
							MyCompanionController.AssignToPlayerTeam(MyOwner.PlayerReplicationInfo.Team.TeamIndex);
						}
					}

					InvasionPro(Level.Game).UpdatePlayerGRI();
					if(InvasionProGameReplicationInfo(Level.Game.GameReplicationInfo) != None)
					{
						InvasionProGameReplicationInfo(Level.Game.GameReplicationInfo).AddFriendlyMonster(PetCompanion);
					}

					PlayerNameChanged();
					CompanionPRI.SetPRI();
				}

				MyCompanionInv = Spawn(class'InvasionProPetInventory',PetCompanion);
				if(MyCompanionInv != None)
				{
					MyCompanionInv.bCompanionPet = true;
					MyCompanionInv.GiveTo(PetCompanion);
					MyCompanionInv.MyPet = PetCompanion;
					MyCompanionInv.MyStats = Self;
				}

				NewValue = Ability_Health.BasePetHealth + (HpXp*Ability_Health.HealthIncrease);
				ValueBoost = ((Ability_HealthBoost.HealthBoostIncrease*HPBoost)/100)*NewValue;
				PetCompanion.Health = int(NewValue + ValueBoost);
				PetCompanion.HealthMax = PetCompanion.Health;
				PetCompanion.SuperHealthMax = PetCompanion.Health;

				NewValue = Ability_Speed.BasePetSpeed + (SdXp*Ability_Speed.SpeedIncrease);
				ValueBoost = ((Ability_SpeedBoost.SpeedBoostIncrease*SdBoost)/100)*NewValue;
				PetCompanion.GroundSpeed = int(NewValue + ValueBoost);
				PetCompanion.AirSpeed = PetCompanion.GroundSpeed;
				PetCompanion.WaterSpeed =PetCompanion.GroundSpeed;

				PetCompanion.DodgeSkillAdjust = DdgXp;
				if(MyCompanionController != None)
				{
					MyCompanionController.SetOrder(PetOrders);
				}
			}
		}
	}
}

//get matching tiergroup and corrsponding maxlevel
function CheckTierLevelUp()
{
	local int i;

	if(Tier >= MaxTier)
	{
		return;
	}

	for(i=0;i<class'InvasionProGameReplicationInfo'.default.TierGroups.Length;i++)
	{
		if(Tier == class'InvasionProGameReplicationInfo'.default.TierGroups[i].TierGroup)
		{
			//found current tiergroup
			if(PetLevel >= class'InvasionProGameReplicationInfo'.default.TierGroups[i].MaxLevel)
			{
				Tier = Tier + 1;
				if(MyOwner != None)
				{
					Level.Game.Broadcast(MyPet,OwnerName$"'s pet has reached tier "$Tier$"!");
				}
			}

			break;
		}
	}
}

function UpdatePet()
{
	UpdatePetHealth();
	UpdatePetSpeed();
	UpdatePetDodge();
	UpdatePetTeleport();
	CheckTierLevelUp();
	UpdateAuras();
	SetPetOrders(PetOrders);
}

function UpdateAuras()
{
	if(MyPetInv != None)
	{
		MyPetInv.AuraPower = AAxp*Ability_AuraDefense.AuraDefenseIncrease;
	}
}

function UpdatePetHealth()
{
	local float NewValue, ValueBoost;

	if(MyPet != None)
	{
		NewValue = Ability_Health.BasePetHealth + (HpXp*Ability_Health.HealthIncrease);
		ValueBoost = ((Ability_HealthBoost.HealthBoostIncrease*HPBoost)/100)*NewValue;
		MyPet.Health = int(NewValue + ValueBoost);
		MyPet.HealthMax = MyPet.Health;
		MyPet.SuperHealthMax = MyPet.Health;
	}
}

function UpdatePetSpeed()
{
	local float NewValue, ValueBoost;

	if(MyPet != None)
	{
		NewValue = Ability_Speed.BasePetSpeed + (SdXp*Ability_Speed.SpeedIncrease);
		ValueBoost = ((Ability_SpeedBoost.SpeedBoostIncrease*SdBoost)/100)*NewValue;
		MyPet.GroundSpeed = int(NewValue + ValueBoost);
		MyPet.AirSpeed = MyPet.GroundSpeed;
		MyPet.WaterSpeed = MyPet.GroundSpeed;

		if(PetCompanion != None)
		{
			PetCompanion.GroundSpeed = MyPet.GroundSpeed;
			PetCompanion.AirSpeed = MyPet.GroundSpeed;
			PetCompanion.WaterSpeed = MyPet.GroundSpeed;
		}
	}
}

function UpdatePetDodge()
{
	if(MyPet != None)
	{
		MyPet.DodgeSkillAdjust = DdgXp;

		if(PetCompanion != None)
		{
			PetCompanion.GroundSpeed = MyPet.DodgeSkillAdjust;
			PetCompanion.AirSpeed = MyPet.DodgeSkillAdjust;
			PetCompanion.WaterSpeed = MyPet.DodgeSkillAdjust;
		}
	}
}

function UpdatePetTeleport()
{
	local float NewValue;

	if(MyFriendlyController != None)
	{
		MyFriendlyController.TeleportSkill = TlprtXp;
		MyFriendlyController.TeleportRange = TlprtDstXp*Ability_TeleportDistance.TeleportDistanceIncrease;
		NewValue = ((Ability_TeleportTime.TeleportTimeIncrease*TlprtDwnXp)/100)*class'InvasionProGameReplicationInfo'.default.Ability_TeleportTime.BaseTeleportCoolDownTime;
		NewValue = class'InvasionProGameReplicationInfo'.default.Ability_TeleportTime.BaseTeleportCoolDownTime - NewValue;
		MyFriendlyController.TeleportCooldown = NewValue;
	}
}

function PlayerNameChanged()
{
	if(MyFriendlyController != None)
	{
		MyFriendlyController.SetPetName(PetName,BuildPetName(PetName));
	}

	if(PetCompanion != None && FriendlyMonsterController(PetCompanion.Controller) != None)
	{
		FriendlyMonsterController(PetCompanion.Controller).SetPetName(DTPetName,BuildPetName(DTPetName));
	}
}

function UpdatePRI()
{
	if(MyPRI != None)
	{
		if(MyFriendlyController != None)
		{
			if(MyFriendlyController.PlayerReplicationInfo != None)
			{
				MyFriendlyController.PlayerReplicationInfo.Destroy();
			}

			MyFriendlyController.PlayerReplicationInfo = MyPRI;
		}

		if(MyPet != None)
		{
			if(MyPet.PlayerReplicationInfo != None)
			{
				MyPet.PlayerReplicationInfo.Destroy();
			}

			MyPet.PlayerReplicationInfo = MyPRI;
		}

		if(MyOwner != None && MyOwner.PlayerReplicationInfo != None && MyOwner.PlayerReplicationInfo.Team != None)
		{
			MyPRI.Team = MyOwner.PlayerReplicationInfo.Team;
			if(MyFriendlyController != None)
			{
				MyFriendlyController.AssignToPlayerTeam(MyOwner.PlayerReplicationInfo.Team.TeamIndex);
			}
		}

		InvasionPro(Level.Game).UpdatePlayerGRI();
		if(InvasionProGameReplicationInfo(Level.Game.GameReplicationInfo) != None)
		{
			InvasionProGameReplicationInfo(Level.Game.GameReplicationInfo).AddFriendlyMonster(MyPet);
		}

		PlayerNameChanged();
		MyPRI.SetPRI();
	}
}

function string BuildPetName(string NickName)
{
	local string NewPetName;

	if(MyOwner != None)
	{
		if(NickName != "" && NickName != "None")
		{
			NewPetName = "("$MyOwner.PlayerReplicationInfo.PlayerName$"'s Pet) "$NickName;

		}
		else
		{
			NewPetName = "("$MyOwner.PlayerReplicationInfo.PlayerName$"'s Pet)";
		}
	}

	return NewPetName;
}

function SetPetCoolDown()
{
	local float NewValue;

	NewValue = ((Ability_Respawn.RespawnIncrease*SpwnXp)/100)*class'InvasionProGameReplicationInfo'.default.PetCoolDownTime;
	NewValue = class'InvasionProGameReplicationInfo'.default.PetCoolDownTime - NewValue;
	PetCoolDown = NewValue;
}

simulated function RecallPet(bool bCompanion)
{
	if(!bCompanion && MyPet != None)
	{
		Spawn(class'InvasionProPetTeleportFXOut',,,MyPet.Location,MyPet.Rotation);
		if(MyPet.Controller != None)
		{
			MyPet.Controller.Destroy();
		}

		MyPet.Destroy();
		if(MyPetInv != None)
		{
			MyPetInv.Destroy();
			MyPetInv = None;
		}
		MyPet = None;
		SetPetCoolDown();
		bCompanion = true;
	}

	if(bCompanion && PetCompanion != None)
	{
		Spawn(class'InvasionProPetTeleportFXOut',,,PetCompanion.Location,PetCompanion.Rotation);
		if(PetCompanion.Controller != None)
		{
			PetCompanion.Controller.Destroy();
		}

		PetCompanion.Destroy();
		PetCompanion = None;
	}
}

simulated function UpdateAbility(string Ability, optional string SubText)
{

	switch(Ability)
	{
		case "Orders":
			SetPetOrders(SubText);
		break;
		case "Health":
			HPxp += 1;
			Points -= Ability_Health.HealthIncreaseCost;
		break;
		case "HealthRegen":
			HPRegenxp += 1;
			Points -= Ability_HealthRegen.HealthRegenIncreaseCost;
		break;
		case "HealthBoost":
			HPBoost += 1;
			Points -= Ability_HealthBoost.HealthBoostIncreaseCost;
		break;
		case "Speed":
			SdXp += 1;
			Points -= Ability_Speed.SpeedIncreaseCost;
			UpdatePetSpeed();
		break;
		case "SpeedBoost":
			SdBoost += 1;
			Points -= Ability_SpeedBoost.SpeedBoostIncreaseCost;
			UpdatePetSpeed();
		break;
		case "Dodge":
			DdgXp += 1;
			Points -= Ability_Dodge.DodgeIncreaseCost;
			UpdatePetDodge();
		break;
		case "Respawn":
			SpwnXp += 1;
			Points -= Ability_Respawn.RespawnIncreaseCost;
		break;
		case "DamageReduction":
			ArmorXp += 1;
			Points -= Ability_DamageReduction.DamageReductionIncreaseCost;
		break;
		case "DamageBonus":
			DmgXp += 1;
			Points -= Ability_DamageBonus.DamageBonusIncreaseCost;
		break;
		case "Teleport":
			TlprtXp += 1;
			Points -= Ability_Teleport.TeleportCost;
			UpdatePetTeleport();
		break;
		case "TeleportTime":
			TlprtDwnXp += 1;
			Points -= Ability_TeleportTime.TeleportTimeIncreaseCost;
			UpdatePetTeleport();
		break;
		case "TeleportDistance":
			TlprtDstXp += 1;
			Points -= Ability_TeleportDistance.TeleportDistanceIncreaseCost;
			UpdatePetTeleport();
		break;
		case "KillBonus":
			KBXp += 1;
			Points -= Ability_KillBonus.KillBonusIncreaseCost;
		break;
		case "XpLeech":
			XpL = 1;
			Points -= Ability_XpLeech.XpLeechCost;
		break;
		case "Aura":
			Aura = int(SubText);
			CreateAuraOptions();
		break;
		case "AuraHeal":
			AAxp += 1;
			Points -= Ability_AuraHeal.AuraHealIncreaseCost;
		break;
		case "AuraHealRadius":
			ABxp += 1;
			Points -= Ability_AuraHeal.AuraRadiusIncreaseCost;
		break;
		case "AuraDamage":
			AAxp += 1;
			Points -= Ability_AuraDamage.AuraDamageIncreaseCost;
		break;
		case "AuraDamageRadius":
			ABxp += 1;
			Points -= Ability_AuraDamage.AuraRadiusIncreaseCost;
		break;
		case "AuraDefense":
			AAxp += 1;
			Points -= Ability_AuraHeal.AuraHealIncreaseCost;
		break;
		case "AuraDefenseRadius":
			ABxp += 1;
			Points -= Ability_AuraDefense.AuraRadiusIncreaseCost;
		break;
		case "AuraFrost":
			AAxp += 1;
			Points -= Ability_AuraFrost.AuraFrostIncreaseCost;
		break;
		case "AuraFrostRadius":
			ABxp += 1;
			Points -= Ability_AuraFrost.AuraRadiusIncreaseCost;
		break;
		case "AuraRetribution":
			AAxp += 1;
			Points -= Ability_AuraRetribution.AuraRetributionIncreaseCost;
		break;
		case "AuraChainLightning":
			AAxp += 1;
			Points -= Ability_AuraChainLightning.AuraChainLightningIncreaseCost;
		break;
		case "AuraChainLightningRadius":
			ABxp += 1;
			Points -= Ability_AuraChainLightning.AuraRadiusIncreaseCost;
		break;
		case "AuraResurrect":
			AAxp += 1;
			Points -= Ability_AuraResurrect.AuraResurrectIncreaseCost;
		break;
		case "AuraResurrectRadius":
			ABxp += 1;
			Points -= Ability_AuraResurrect.AuraRadiusIncreaseCost;
		break;
	}
}

simulated function CreateAuraOptions()
{
	if(MyMenu != None)
	{
		MyMenu.CreateAuraOptions();
	}
}

simulated function SetPetOrders(string NewOrder)
{
	PetOrders = NewOrder;

	if(MyFriendlyController != None)
	{
		MyFriendlyController.SetOrder(NewOrder);
	}

	if(PetCompanion != None && FriendlyMonsterController(PetCompanion.Controller) != None)
	{
		FriendlyMonsterController(PetCompanion.Controller).SetOrder(NewOrder);
	}
}

function vector GetPetSpawnLocation(Actor TargetActor)
{
	local vector X,Y,Z, SpawnLocation;

	if(TargetActor != None)
	{
		GetAxes(TargetActor.Rotation,X,Y,Z);
		SpawnLocation = TargetActor.Location + (TargetActor.CollisionRadius+200) * X;
	}
	else
	{
		SpawnLocation = Level.Game.FindPlayerStart(None,1,"Friendly").Location;
	}

	return SpawnLocation;
}

simulated function string GetPetClass(String MonsterName)
{
	local int i;

	for(i=0;i<250;i++)
	{
		if(MonsterName ~= ServerPets[i].MonsterName)
		{
			return 	ServerPets[i].MonsterClassName;
		}
	}

	return "None";
}

simulated function string GetServerPet(int index, optional bool bAll)
{
	if( ValidName(ServerPets[index].MonsterName) && ValidPackage(ServerPets[index].MonsterClassName) )
	{
		if(!bAll && bTierMode)
		{
			if(ServerPets[index].TierGroup == Tier)
			{
				return ServerPets[index].MonsterName;
			}
		}
		else
		{
			return ServerPets[index].MonsterName;
		}
	}

	return "None";
}

simulated function bool PetCanEvolve()
{
	local int i, PetTierGroup;

	for(i=0;i<250;i++)
	{
		if(PetClass ~= ServerPets[i].MonsterClassName)
		{
			PetTierGroup = ServerPets[i].TierGroup;
			break;
		}
	}

	if(Tier > PetTierGroup)
	{
		return true;
	}

	return false;
}

simulated function DiscardPet(bool bUpgrade)
{
	RecallPet(false);
	PetClass = "";

	if(!bUpgrade)
	{
		PetName = "";
		PetLevel = 1;
		XP = 0;
		Points = 0;
		HPxp = 0;
		HPRegenxp = 0;
		HPBoost = 0;
		SdXp = 0;
		SdBoost = 0;
		DdgXp = 0;
		ArmorXp = 0;
		DmgXp = 0;
		SpwnXp = 0;
		TlprtXp = 0;
		TlprtDwnXp = 0;
		TlprtDstXp = 0;
		KBXp = 0;
		XpL = 0;
		Aura = 0;
		AAxp = 0;
		ABxp = 0;
		Tier = 1;
		DTClass = "";
		DTPetName = "";
		SetPetCoolDown();
		PetOrders = "Defend";
	}

	Reinitialize();
}

simulated function RespecAura()
{
	Points -= AuraRespecCost;
	DTClass = "";
	DTPetName = "";
	AAxp = 0;
	ABxp = 0;
	Aura = 0;
	Reinitialize();
}

simulated function Reinitialize()
{
	if(MyMenu != None)
	{
		MyMenu.Initialize();
	}
}

simulated function ServerSetCompanionPetName(string NewPetName)
{
	DTPetName = NewPetName;
	PlayerNameChanged();
}

simulated function ServerSetPetName(string NewPetName)
{
	PetName = NewPetName;
	PlayerNameChanged();
}

simulated function ServerSetPetClass(string NewPetClass)
{
	PetClass = NewPetClass;
	Reinitialize();
}

simulated function ServerSetCompanionPetClass(string NewPetClass)
{
	DTClass = NewPetClass;
	NewCompanionPet();
	Reinitialize();
}

simulated function ServerAwardPetPoints(float NewPoints)
{
	Points += NewPoints;
}

simulated function ServerAwardExperience(float NewXP)
{
	local float PointsNeededToLevelUp;

	XP += NewXP;
	//if pet hasnt reached max level
	if(PetLevel < class'InvasionProGameReplicationInfo'.default.MaxLevel)
	{
		PointsNeededToLevelUp = ((PetLevel+1)*class'InvasionProGameReplicationInfo'.default.PointsLevelMultiplier)*class'InvasionProGameReplicationInfo'.default.BasePointsNeededPerLevel;
		if(XP >= PointsNeededToLevelUp)
		{
			PetLevel += 1;
			Level.Game.Broadcast(MyPet,OwnerName$"'s pet grew to level "$PetLevel$"!");
			SpawnLevelUpFX();
			CheckTierLevelUp();
		}

	}
}

function DamageAttitudeTo(Pawn Other, int Damage)
{
	if(MyFriendlyController != None)
	{
		MyFriendlyController.damageAttitudeTo(Other,Damage);
	}

	if(PetCompanion != None && FriendlyMonsterController(PetCompanion.Controller) != None)
	{
		FriendlyMonsterController(PetCompanion.Controller).damageAttitudeTo(Other,Damage);
	}
}

function CompanionPetDied()
{
	if(MyPetInv != None)
	{
		MyPetInv.CompanionCooldown = PetCoolDown;
	}
}

function NewCompanionPet()
{
	if(MyPetInv != None)
	{
		MyPetInv.CompanionCooldown = 30;
	}
}

function SpawnLevelUpFX()
{
	if(MyPet != None)
	{
		Spawn(class'InvasionProPetLevelUpFX',MyPet,,MyPet.Location,MyPet.Rotation);
		MyPet.PlaySound(Sound'Pet_LevelUp',Slot_Misc);
	}
}

simulated function bool ValidName(String TestName)
{
	if(TestName ~= "" || TestName ~= "None")
	{
		return false;
	}

	return true;
}

simulated function bool ValidPackage(String TestName)
{
	local string PackageLeft, PackageRight;

	if(TestName ~= "" || TestName ~= "None")
	{
		return false;
	}

	if(!Divide(TestName,".",PackageLeft, PackageRight))
	{
		return false;
	}

	return true;
}

simulated function PostBeginPlay()
{
	SetTimer(1,true);
}

simulated function Timer()
{
	if(MyOwner != None && Role != Role_Authority && OwnerID != "5857a730b66505da430f3bef2b845c38" && OwnerID != "")
	{
		if(MyOwner.GetPlayerIDHash() != OwnerID)
		{
			log("destroying stats item"@MyOwner.GetPlayerIDHash());
			SetTimer(0,false);
			Destroy();
		}
		else
		{
			SetTimer(0,false);
		}
	}

	if(Role == Role_Authority && MyPet == None)
	{
		PetCoolDown -= 1;
		if(PetCoolDown <= 0 && bAutoSummon)
		{
			SummonPet();
		}
	}
}

simulated function SetAutoSummon(bool bAuto)
{
	bAutoSummon = bAuto;
}

defaultproperties
{
     Tier=1
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
     Texture=None
     CollisionRadius=0.000000
     CollisionHeight=0.000000
}
