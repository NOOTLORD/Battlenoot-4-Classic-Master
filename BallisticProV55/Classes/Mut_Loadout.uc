//=============================================================================
// Mut_Loadout.
//
// Like normal loadout, but each weapon has skill requirements before it's
// available. Players will have to acheive a certain level of skill or set of
// skills to unlock more weapons.
//
// Skills / Requirements:
// -MatchTime:	Amount of time match has been going (in seconds)
// -Frags:		The number of frags the player has
// -Efficiency:	How efficient the player is with their lives. (Frags divided by deaths)
// -DamageRate:	How much the player actually contributes to ther kills. Benefit by fragging strong enemies. (Total Damage Dealt Divided by Kills)
// -SniperEff:	How efficient the player is with sniper weapons and getting headshots. +for headshots and sniper weapon use, -for deaths while using sniper
// -ShotgunEff:	Player efficiency at close combat with bullet weapons and shotgun use. +for Gun kills / range, -deaths whil using shotgun and general deaths
// -HazardEff:	Player efficiency with traps, explosivs and hazardous wepaons. +Kills with hazardous weapons, -death, hazard deaths, suicides
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class Mut_Loadout extends Mut_Ballistic
	config(BallisticProV55) exportstructs;

struct LORequirements
{
	var() config byte	InTeam;			//0 red, 1 blue, 2 both
	var() config float	MatchTime;		// How much match time must have passed
	var() config float	Frags;			// Minimum frags required
	var() config float	Efficiency;		// Frags divided by deaths
	var() config float	DamageRate;		// Damage inflicted divided by kills

	var() config float	SniperEff;		// Headshots divided by deaths and death while carrying sniper weapon
	var() config float	ShotgunEff;		// (Gun kills divided by range) accumulated divided by deaths and deaths while carrying shotgun weapons
	var() config float	HazardEff;		// Kills with traps and explosives divided by deaths, self inflicted hazard death
};
	// 1	1
	// 2	2
	// 4	3
	// 8	4
	// 16	5

struct LOItem
{
	var() config string			ItemName;
	var() config int			Groups;
	var() config LORequirements	Requirements;
};
var() config array<LOItem>		Items;



var() config string 			LoadOut[5];			// Loadout info saved seperately on each client
var   Array<ClientLoadoutinterface>	COIPond;	// Jump right in, they won't bite, probably...
var   PlayerController			PCPendingCOI;		// The PlayerController that is about to get its COI

var Rules_Loadout LoadoutRules;

function bool WeaponRequirementsOk (int ItemIndex, PlayerReplicationInfo PRI)
{
	if (ItemIndex < 0 || ItemIndex >= Items.length)
		return false;
	if (level.Game.GameReplicationInfo.ElapsedTime < Items[ItemIndex].Requirements.MatchTime)
		return false;
	if (PRI.Score < Items[ItemIndex].Requirements.Frags)
		return false;
	if (PRI.Deaths == 0)
	{
		if (PRI.Score / 0.1 < Items[ItemIndex].Requirements.Efficiency)
			return false;
		if (LoadoutRules.GetSniperEff(PRI.PlayerID) * 2 < Items[ItemIndex].Requirements.SniperEff)
			return false;
		if (LoadoutRules.GetShotgunEff(PRI.PlayerID) * 2 < Items[ItemIndex].Requirements.ShotgunEff)
			return false;
		if (LoadoutRules.GetHazardEff(PRI.PlayerID) * 2 < Items[ItemIndex].Requirements.HazardEff)
			return false;
	}
	else
	{	if (PRI.Score / PRI.Deaths < Items[ItemIndex].Requirements.Efficiency)
			return false;
		if (LoadoutRules.GetSniperEff(PRI.PlayerID)  / ((LoadoutRules.GetDeathsHoldingSniper(PRI.PlayerID)+1)/1.3  + PRI.Deaths/4.0) < Items[ItemIndex].Requirements.SniperEff)
			return false;
		if (LoadoutRules.GetShotgunEff(PRI.PlayerID) / ((LoadoutRules.GetDeathsHoldingShotgun(PRI.PlayerID)+1)/1.3 + PRI.Deaths/4.0) < Items[ItemIndex].Requirements.ShotgunEff)
			return false;
		if (LoadoutRules.GetHazardEff(PRI.PlayerID)  / ((LoadoutRules.GetDeathsHoldingHazard(PRI.PlayerID)+1)/1.3  + PRI.Deaths/4.0) < Items[ItemIndex].Requirements.HazardEff)
			return false;
	}
	if (PRI.Kills == 0)
	{
		if (0 < Items[ItemIndex].Requirements.DamageRate)
			return false;
	}
	else if (float(LoadoutRules.GetPlayerDamage(PRI.PlayerID)) / PRI.Kills < Items[ItemIndex].Requirements.DamageRate)
		return false;

	return true;
}

function bool ValidateWeapon (string WeaponName, int Group, PlayerReplicationInfo PRI)
{
	local int i, GroupIndex;
	GroupIndex = 1 << Group;

	for (i=0;i<Items.length;i++)
		if (Items[i].ItemName ~= WeaponName)
		{
			if ((Items[i].Groups & GroupIndex) > 0 &&
				WeaponRequirementsOk(i, PRI))
				return true;
			return false;
		}
	return false;
}

function string GetValidWeapon (int Group, PlayerReplicationInfo PRI)
{
	local int i, GroupIndex;
	GroupIndex = 1 << Group;

	for (i=0;i<Items.length;i++)
		if ((Items[i].Groups & GroupIndex) > 0 &&
			Items[i].ItemName != "" &&
			WeaponRequirementsOk(i, PRI))
			return Items[i].ItemName;
	return "";
}

function string GetRandomWeapon (int Group, PlayerReplicationInfo PRI)
{
	local int i, GroupIndex;
	local array<string> Potentials;
	GroupIndex = 1 << Group;

	for (i=0;i<Items.length;i++)
		if ((Items[i].Groups & GroupIndex) > 0 &&
			Items[i].ItemName != "" &&
			WeaponRequirementsOk(i, PRI))
			Potentials[Potentials.length] = Items[i].ItemName;
	if (Potentials.length < 1)
		return "";
	return Potentials[Rand(Potentials.length)];
}

// Give the players their weapons
function ModifyPlayer(Pawn Other)
{
	local int i;
	local class<weapon> W;
	local string Stuff[5];

		xPawn(Other).RequiredEquipment[0] = Stuff[1];
		xPawn(Other).RequiredEquipment[1] = Stuff[0];

	Super.ModifyPlayer(Other);
	if (Other.Controller != None && Bot(Other.Controller) != None)
	{
		for (i=0;i<5;i++)
			Stuff[i] = GetRandomWeapon(i, Other.PlayerReplicationInfo);
		ChangeLoadout(Other, Stuff);
		for (i=0;i<5;i++)
		{
			if (Stuff[i] == "")
				continue;
			W = class<weapon>(DynamicLoadObject(Stuff[i],class'Class'));
			if (W == None)
				continue;
			SpawnWeapon(W, Other);
			if (class<BallisticWeapon>(W) != None && !class<BallisticWeapon>(W).default.bNoMag)
//			if (i!= 4)
			{
				SpawnAmmo(W.default.FireModeClass[0].default.AmmoClass, Other);
				if (W.default.FireModeClass[0].default.AmmoClass != W.default.FireModeClass[1].default.AmmoClass)
					SpawnAmmo(W.default.FireModeClass[1].default.AmmoClass, Other);
			}
		}
	}
	else if (Other.Controller != None && PlayerController(Other.Controller) != None)
		for (i=0;i<COIPond.length;i++)
			if (COIPond[i].PC == Other.Controller)
			{	COIPond[i].ClientStartLoadout();	return;	}
}
// Use the console command "Mutate Loadout" to open the loadout menu
function Mutate(string MutateString, PlayerController Sender)
{
	local int i;

	if (MutateString ~= "Loadout" && Sender != None)
	{
		for (i=0;i<COIPond.length;i++)
		{
			if (COIPond[i].PC == Sender)
			{
				COIPond[i].OpenLoadoutMenu();
//				COIPond[i].ClientOpenLoadoutMenu();
				return;
			}
		}
		COIPond[i] = Spawn(class'ClientLoadoutInterface',Sender);
		COIPond[i].Initialize(self, Sender);
	}
	super.Mutate(MutateString, Sender);
}
// Goes through inventory and gets rid of stuff that ain't in the loadout
function ChangeLoadout (Pawn P, out string Stuff[5], optional string OldStuff[5])
{
	local Inventory Inv;
	local int Count, i, j;
	local Array<Inventory> BadInv;

	for (Inv=P.Inventory; Inv!=None && Count < 1000; Inv=Inv.Inventory)
	{
		if (Weapon(Inv) != None && Translauncher(Inv)==None)
		{
			for (i=0;i<5;i++)
				if (OldStuff[i] ~= string(Inv.class))
				{
					for (j=0;j<5;j++)
						if (Stuff[j] ~= string(Inv.class))
						{
							Stuff[j] = "";
							break;
						}
					if (j>=5)
						BadInv[BadInv.length] = Inv;
					OldStuff[i] = "";
					break;
				}
		}
		Count++;
	}
	while (BadInv.length > 0)
	{
		if (BadInv[0] != None)
			BadInv[0].Destroy();
		BadInv.Remove(0, 1);
	}
}
// Makes sure client loadout is allowed, then cleans stuff out the inventory and adds the new weapons
function OutfitPlayer(Pawn Other, string Stuff[5], optional string OldStuff[5])
{
	local int i;
	local class<weapon> W;

	if (Vehicle(Other) != None && Vehicle(Other).Driver != None)
		Other = Vehicle(Other).Driver;
	// Make sure everything is legit
	for (i=0;i<5;i++)
		if (!ValidateWeapon(Stuff[i], i, Other.PlayerReplicationInfo))
			Stuff[i] = GetValidWeapon(i, Other.PlayerReplicationInfo);
	// Clean out other weapons...
	ChangeLoadout(Other, Stuff, OldStuff);
	// Now spawn it all
	if (xPawn(Other) != None)
	{
		xPawn(Other).RequiredEquipment[0] = Stuff[1];
		xPawn(Other).RequiredEquipment[1] = Stuff[0];
	}
	for (i=3;i<5;i+=0)
	{
		if (Stuff[i] != "")
		{
			W = class<weapon>(DynamicLoadObject(Stuff[i],class'Class'));
			if (W == None)
			{
				log("Could not load outfitted weapon "$Stuff[i]);
			}
			else
			{
				SpawnWeapon(W, Other);
				if (class<BallisticWeapon>(W) != None && !class<BallisticWeapon>(W).default.bNoMag)
//				if (i!= 4)
				{
					SpawnAmmo(W.default.FireModeClass[0].default.AmmoClass, Other);
					if (W.default.FireModeClass[0].default.AmmoClass != W.default.FireModeClass[1].default.AmmoClass)
						SpawnAmmo(W.default.FireModeClass[1].default.AmmoClass, Other);
				}
			}
		}
		if (i==0)
			i=4;
		else if (i==4)
			break;
		else
			i--;
	}
}
static function Weapon SpawnWeapon(class<weapon> newClass, Pawn P)
{
	local Weapon newWeapon;

    if( (newClass!=None) && P != None && (P.FindInventoryType(newClass)==None || class<BallisticHandgun>(newClass) != None) )
    {
        newWeapon = P.Spawn(newClass,,,P.Location);
        if( newWeapon != None )
            newWeapon.GiveTo(P);
		return newWeapon;
    }
	
	return None;
}

// Do not spawn a default weapon yet...
function class<Weapon> MyDefaultWeapon()
{
	return None;
}

function Class<Inventory> GetInventoryClass(string InventoryClassName)
{
	return None;
}

function PostBeginPlay()
{
	local int i;
	super.PostBeginPlay();

	LoadoutRules = spawn(class'Rules_Loadout');
	if ( Level.Game.GameRulesModifiers == None )
		Level.Game.GameRulesModifiers = LoadoutRules;
	else
		Level.Game.GameRulesModifiers.AddGameRules(LoadoutRules);

	for (i=0;i<Items.length;i++)
	{
		Items[i].Requirements.MatchTime		*= class'Mut_LoadoutConfig'.default.TimeScale;
		Items[i].Requirements.Frags			*= class'Mut_LoadoutConfig'.default.FragScale;
		Items[i].Requirements.Efficiency	*= class'Mut_LoadoutConfig'.default.EffyScale;
		Items[i].Requirements.DamageRate	*= class'Mut_LoadoutConfig'.default.DmRtScale;
		Items[i].Requirements.ShotgunEff	*= class'Mut_LoadoutConfig'.default.SgEfScale;
		Items[i].Requirements.SniperEff		*= class'Mut_LoadoutConfig'.default.SrEfScale;
		Items[i].Requirements.HazardEff		*= class'Mut_LoadoutConfig'.default.HzEfScale;
	}
}

simulated event Timer()
{
	super.Timer();
	if (PCPendingCOI == None)
		return;
	COIPond[COIPond.length] = Spawn(class'ClientLoadoutinterface',PCPendingCOI);
	COIPond[COIPond.length-1].Initialize(self, PCPendingCOI);
	PCPendingCOI = None;
}
function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	local int i;
	bSuperRelevant = 0;
	// Give players their COI. Everyone needs a COI, right?
	if (PlayerController(Other) != None)
	{
		if (PCPendingCOI != None)
			Timer();
		SetTimer(0.1, false);
		PCPendingCOI = PlayerController(Other);
	}
	else if (xPawn(Other) != None)
	{
		xPawn(Other).RequiredEquipment[0] = "";
		xPawn(Other).RequiredEquipment[1] = "";
		return true;
	}
	// Only allow weapons that are in the loadout groups
	else if (Weapon(Other) != None && (!Weapon(Other).bNoInstagibReplace) && Translauncher(Other)==None)
	{
		for (i=0;i<Items.length;i++)
			if (Items[i].ItemName ~= string(Other.class))
				return true;
		return false;
	}
	// No weapon pickups unless they are dropped. Dropped BWs are owned by the weapon that dropped them
	else if (WeaponPickup(Other) != None && Other.Owner == None)
		return false;
	// No ammo pickups
	else if (Ammo(Other) != None && IP_AmmoPack(Other) == None)
		return false;
	// Lockers replaced with ammo packs
	else if (WeaponLocker(Other) != None)
	{
		if (!SpawnNewItem(-1, Other, class'IP_AmmoPack'))
		{
			Other.GotoState('Disabled');
			return false;
		}
	}
	// No bases. Weapon pickups replaced with ammo packs
	else if (xWeaponBase(Other) != None)
	{
		if (!SpawnNewItem(-1, Other, class'IP_AmmoPack'))
			return false;
	}
	else if (xPickupBase(Other) != None)
	{
		Other.bHidden=true;
		if (xPickupBase(Other).myEmitter != None)
			xPickupBase(Other).myEmitter.Destroy();
	}
	// Do terrible, evil, horrendous ballistic deeds unto the other stuff
	return super.CheckReplacement(Other, bSuperRelevant);
}

defaultproperties
{
     bHideLockers=True
     FriendlyName="BallisticPro: Evolution Loadout"
     Description="Play Ballistic Weapons like normal Loadout, but to access more weapons, you will need to reach certain levels of acheivement:|Match Time: Some weapons are only accesable when the match has played for a while|Frags: Your basic frag count|Efficency: How efficiently you use your lives (frags divided by deaths)|Damage Rage: How much you actually contribute to each of your kills (Total Damage Dealt divided by Kills)|Sniper Efficiency: Your efficiency at taking headshots and long range fighting (Headshots+RangeBonus divided by Deaths using Sniper weapons)|Shotgun Efficiency: Your efficiency at close range gun combat (Close range gun Frags divided by Deaths with Shotguns)|Hazard Efficiency: Your efficiency with hazardous weapons (Frags with hazardous weapons divided by deaths with hazardous weapons)||http://www.runestorm.com"
}
