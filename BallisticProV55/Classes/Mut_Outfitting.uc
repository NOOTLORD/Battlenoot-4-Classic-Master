//=============================================================================
// Mut_Outfitting.
//
// This mutator implements all normal ballistic features, but instead of
// picking up weapons placed in the map, players choose several to start with.
// They can choose one in each of several catagories (melee, sidearm, primary,
// secondary, grenade). Weapon pickups are replaced with ammo packs and ammo
// pickups are removed. Players can still pickup weapons dropped by enemies.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class Mut_Outfitting extends Mut_Ballistic
	config(BallisticProV55);

var() globalconfig string 			LoadOut[5];			// Loadout info saved seperately on each client
var() globalconfig bool				bDebugMode;

var   Array<ClientOutfittingInterface>	COIPond;	// Jump right in, they won't bite - probably...
var   PlayerController			PCPendingCOI;		// The PlayerController that is about to get its COI

const NUM_GROUPS = 5;

var() globalconfig array<string>	LoadoutGroup0;	// Weapons available in Melee Box
var() globalconfig array<string>	LoadoutGroup1;	// Weapons available in Sidearm Box
var() globalconfig array<string>	LoadoutGroup2;	// Weapons available in Primary Box
var() globalconfig array<string>	LoadoutGroup3;	// Weapons available in Secondayr Box
var() globalconfig array<string>	LoadoutGroup4;	// Weapons available in Grenade Box

struct dummypos
{
	var array<byte> Positions;
};

var()  array<dummypos>	DummyGroups[5];

var   class<weapon>				NetLoadout0;
var   class<weapon>				NetLoadout1;
var   class<weapon>				NetLoadout2;
var   class<weapon>				NetLoadout3;
var   class<weapon>				NetLoadout4;

var   class<Weapon>				NetLoadoutWeapons[255];
var   byte						NetLoadoutGroups;

//Find and save the position of any dummy weapons (for random weapon)

simulated function PreBeginPlay()
{
	local byte i, j;
	
	Super.PreBeginPlay();
	
	if (Role == ROLE_Authority)
		for (i=0; i < NUM_GROUPS; i++)
			for (j=0; j < GetGroup(i).Length; j++)
				if (Right(GetGroup(i)[j], 5) ~= "Dummy")
					DummyGroups[i].Positions[DummyGroups[i].Positions.Length] = j;
}
	
simulated function string GetGroupItem(byte GroupNum, int ItemNum)
{
	switch (GroupNum)
	{
		case	0:	return LoadoutGroup0[ItemNum];
		case	1:	return LoadoutGroup1[ItemNum];
		case	2:	return LoadoutGroup2[ItemNum];
		case	3:	return LoadoutGroup3[ItemNum];
		case	4:	return LoadoutGroup4[ItemNum];
	}
}

simulated function array<string> GetGroup(byte GroupNum)
{
	switch (GroupNum)
	{
		case	0:	return LoadoutGroup0;
		case	1:	return LoadoutGroup1;
		case	2:	return LoadoutGroup2;
		case	3:	return LoadoutGroup3;
		case	4:	return LoadoutGroup4;
	}
}

static function array<string> SGetGroup (byte GroupNum)
{
	switch (GroupNum)
	{
		case	0:	return default.LoadoutGroup0;
		case	1:	return default.LoadoutGroup1;
		case	2:	return default.LoadoutGroup2;
		case	3:	return default.LoadoutGroup3;
		case	4:	return default.LoadoutGroup4;
	}
}

// Give the players their weapons
function ModifyPlayer(Pawn Other)
{
	local int i;
	local class<weapon> W;
	local string Stuff[NUM_GROUPS];

	Super.ModifyPlayer(Other);
	
	if (Other.LastStartTime > Level.TimeSeconds + 2)
		return;

	//Bots get their weapons here.
	if (Other.Controller != None && Bot(Other.Controller) != None)
	{
		for (i=0; i < NUM_GROUPS; i++)
			Stuff[i] = GetGroup(i)[Rand(GetGroup(i).length)];
		ChangeLoadout(Other, Stuff);		
		for (i=2;i<NUM_GROUPS;i+=0)
		{
			if (Stuff[i] == "")		
			{
				if (i == 0)
					i = 4;
				else if (i == 3)
					break;
				else
					i--;
				continue;
			}
			if (Right(Stuff[i], 5) ~= "Dummy")
				Stuff[i] = GetGroup(i)[0];
			W = class<weapon>(DynamicLoadObject(Stuff[i],class'Class'));
			if (W == None)
			{
				if (i == 0)
					i = 4;
				else if (i == 3)
					break;
				else
					i--;
				continue;
			}
			SpawnWeapon(W, Other);
			if (i == 0)
				i = 4;
			else if (i == 3)
				break;
			else
				i--;
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
	local int i, count;
	local array<String> split_string;

	if (MutateString ~= "Loadout" && Sender != None)
	{
		for (i=0;i<COIPond.length;i++)
		{
			if (COIPond[i].PC == Sender)
			{
				COIPond[i].ClientOpenLoadoutMenu();
				return;
			}
		}
		COIPond[i] = Spawn(class'ClientOutfittingInterface',Sender);
		COIPond[i].Initialize(self, Sender);
	}
	
	else
	{
		count = Split(MutateString, " ", split_string);

		if (split_string[0] ~= "AddWeapon")
			AddWeapon(Sender, split_string);
		else if (split_string[0] ~= "RemoveWeapon")
			RemoveWeapon(Sender, split_string);
	}
	
	super.Mutate(MutateString, Sender);
}

function AddWeapon(PlayerController Sender, array<String> split_string)
{	
	local int i, loadout_group;
	local array<String> weapons;
	
	local BC_WeaponInfoCache.WeaponInfo WI;
	
	if (Level.NetMode != NM_Standalone && !Sender.PlayerReplicationInfo.bAdmin)
	{
		Sender.ClientMessage("Mutate AddWeapon: Administrator permissions required");
		return;
	}
	
	if (split_string.Length != 3)
	{
		Sender.ClientMessage("Mutate AddWeapon: Usage: mutate addweapon <loadout_group_index> <weapon_class_name>");
		return;
	}	
	
	WI = class'BC_WeaponInfoCache'.static.AutoWeaponInfo(split_string[2]);
	
	if (!(WI.ClassName ~= split_string[2]))
	{
		Sender.ClientMessage("Mutate AddWeapon: Weapon not found:"@split_string[2]);
		return;
	}

	loadout_group = int(split_string[1]);
	
	if (loadout_group >= NUM_GROUPS)
	{
		Sender.ClientMessage("Mutate AddWeapon: Invalid loadout group"@loadout_group);
		return;
	}
	
	weapons = SGetGroup(loadout_group);
	
	for (i = 0; i < weapons.Length; ++i)
	{
		if (weapons[i] ~= WI.ClassName)
		{
			Sender.ClientMessage("Mutate AddWeapon: Loadout group"@loadout_group@"already contains"@WI.ClassName); 
			return;	
		}
	}

	weapons[weapons.Length] = split_string[2];
	
	switch(loadout_group)
	{
	case 0:
		class'Mut_Outfitting'.default.LoadoutGroup0 = weapons;
		break;
	case 1:
		class'Mut_Outfitting'.default.LoadoutGroup1 = weapons;
		break;
	case 2:
		class'Mut_Outfitting'.default.LoadoutGroup2 = weapons;
		break;
	case 3:
		class'Mut_Outfitting'.default.LoadoutGroup3 = weapons;
		break;
	case 4:
		class'Mut_Outfitting'.default.LoadoutGroup4 = weapons;
		break;
	}	
	
	Sender.ClientMessage("Mutate AddWeapon: Success - added"@WI.ClassName@"to loadout group"@loadout_group); 
	
	class'Mut_Outfitting'.static.StaticSaveConfig();
}

function RemoveWeapon(PlayerController Sender, array<String> split_string)
{	
	local bool success;
	local int i, loadout_group;
	local array<String> weapons;

	success = false;
	
	if (Level.NetMode != NM_Standalone && !Sender.PlayerReplicationInfo.bAdmin)
	{
		Sender.ClientMessage("Mutate RemoveWeapon: Administrator permissions required");
		return;
	}
	
	if (split_string.Length != 3)
	{
		Sender.ClientMessage("Mutate RemoveWeapon: Usage: mutate removeweapon <loadout_group_index> <weapon_class_name>");
		return;
	}	
	
	loadout_group = int(split_string[1]);
	
	if (loadout_group >= NUM_GROUPS)
	{
		Sender.ClientMessage("Mutate RemoveWeapon: Invalid loadout group"@loadout_group);
		return;
	}
	
	weapons = SGetGroup(loadout_group);
	
	for (i = 0; i < weapons.Length; ++i)
	{
		if (weapons[i] ~= split_string[2])
		{
			weapons.Remove(i, 1);
			--i;
			success = true;
		}
	}
	
	if (success)
	{
		switch(loadout_group)
		{
		case 0:
			class'Mut_Outfitting'.default.LoadoutGroup0 = weapons;
			break;
		case 1:
			class'Mut_Outfitting'.default.LoadoutGroup1 = weapons;
			break;
		case 2:
			class'Mut_Outfitting'.default.LoadoutGroup2 = weapons;
			break;
		case 3:
			class'Mut_Outfitting'.default.LoadoutGroup3 = weapons;
			break;
		case 4:
			class'Mut_Outfitting'.default.LoadoutGroup4 = weapons;
			break;
		}	
		
		class'Mut_Outfitting'.static.StaticSaveConfig();
		
		Sender.ClientMessage("Mutate RemoveWeapon: Success - removed"@split_string[2]@"from loadout group"@loadout_group); 
	}
	
	else 
	{
		Sender.ClientMessage("Mutate RemoveWeapon:"@split_string[2]@"not found in loadout group"@loadout_group); 
	}
}

// Goes through inventory and gets rid of stuff that ain't in the loadout
function ChangeLoadout (Pawn P, out string Stuff[NUM_GROUPS], optional string OldStuff[NUM_GROUPS])
{
	local Inventory Inv;
	local int Count, i, j;
	local Array<Inventory> BadInv;

	for (Inv=P.Inventory; Inv!=None && Count < 1000; Inv=Inv.Inventory)
	{
		if (Weapon(Inv) != None && Translauncher(Inv)==None)
		{
			for (i=0;i<NUM_GROUPS;i++)
				if (OldStuff[i] ~= string(Inv.class))
				{
					for (j=0;j<NUM_GROUPS;j++)
						if (Stuff[j] ~= string(Inv.class))
						{
							Stuff[j] = "";
							break;
						}
					if (j>=NUM_GROUPS)
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
function OutfitPlayer(Pawn Other, string Stuff[NUM_GROUPS], optional string OldStuff[NUM_GROUPS])
{
	local byte i, j, k, m, DummyFlags;
	local bool bMatch;
	local class<weapon> W;
	
	if (Vehicle(Other) != None && Vehicle(Other).Driver != None)
		Other = Vehicle(Other).Driver;

	// Make sure everything is legit
	for (i=0;i<NUM_GROUPS;i++)
	{
		// Random weapon handling
		// Tries ten times to pick a weapon which isn't a dummy
		// (i.e. itself) and doesn't match any previous weapon
		// if it fails to do so, returns the first weapon in the group
		if (GetItemName(Stuff[i]) ~= "RandomWeaponDummy")
		{
			for(j=0; j < 10; j++)
			{
				k = Rand(GetGroup(i).length - DummyGroups[i].Positions.length);
				
				for (m = 0; m < DummyGroups[i].Positions.Length; m++)
					if (k == DummyGroups[i].Positions[m])
						k++;
			
				Stuff[i] = GetGroup(i)[k];
					
				bMatch = False;
					
				for (m=0; m<i; m++)
				{
					if (Stuff[i] ~= Stuff[m])
					{
						bMatch = True;
						break;
					}
				}

				if (!bMatch)
					break;

				else if (j == 9)
					Stuff[i] = GetGroup(i)[0];
			}
		}
		
		else if (Right(GetItemName(Stuff[i]), 5) == "Dummy")
			DummyFlags = DummyFlags | (1 << i);
		
		for (j=0;j<GetGroup(i).length;j++)
			if (GetGroup(i)[j] ~= Stuff[i])
				break;
		if (j >= GetGroup(i).length)
			Stuff[i] = GetGroup(i)[Rand(GetGroup(i).length)];
	}
	// Clean out other weapons...
	ChangeLoadout(Other, Stuff, OldStuff);
	// Now spawn it all
	if (xPawn(Other) != None)
	{
		xPawn(Other).RequiredEquipment[0] = Stuff[1];
		xPawn(Other).RequiredEquipment[1] = Stuff[0];
	}
	
	for (i=2;i<NUM_GROUPS;i+=0)
	{
		if (!bool(DummyFlags & (1 << i)))
		{
			if (Stuff[i] != "")
			{
				W = class<weapon>(DynamicLoadObject(Stuff[i],class'Class'));
				if (W == None)
					log("Could not load outfitted weapon "$Stuff[i]);
				else
					SpawnWeapon(W, Other);
			}
		}
		if (i == 0)
			i = 4;
		else if (i == 3)
			break;
		else
			i--;
	}
	
	if (DummyFlags != 0)
	{
		j = 0;
		for (i=1; i < 32; i = i << 1)
		{
			if (bool(DummyFlags & i))
			{
				W = class<Weapon>(DynamicLoadObject(Stuff[j], class'Class'));
				if (class<DummyWeapon>(W) != None)
					class<DummyWeapon>(W).static.ApplyEffect(Other, 0, true);
			}
			j++;
		}
	}
}

static function Weapon SpawnWeapon(class<weapon> newClass, Pawn P)
{
	local Weapon newWeapon;
	//local BallisticPlayerReplicationInfo BPRI;
	//local Inventory Inv;

    if( (newClass!=None) && P != None)
    {
		newWeapon = Weapon(P.FindInventoryType(newClass));
		if (newWeapon == None || BallisticHandgun(newWeapon) != None)
		{
			newWeapon = P.Spawn(newClass,,,P.Location);
			if( newWeapon != None )
			{
				newWeapon.GiveTo(P);
			}
			if (BallisticHandgun(newWeapon) != None && BallisticHandgun(newWeapon).default.bShouldDualInLoadout)
			{
				newWeapon = P.Spawn(newClass,,,P.Location);
				if( newWeapon != None )
					newWeapon.GiveTo(P);
			}
			//Hack for bots - stops them complaining
			if (Bot(P.Controller) != None && P.Weapon == None && P.PendingWeapon == None)
			{
				P.PendingWeapon = newWeapon;
				P.ChangedWeapon();
			}
			
			return newWeapon;
		}
		else
		{
			newWeapon.AddAmmo(newClass.default.AmmoClass[0].default.InitialAmount, 0);
		    newWeapon.AddAmmo(newClass.default.AmmoClass[1].default.InitialAmount, 1);	
			if (BallisticWeapon(newWeapon) != None)
			{
				BallisticWeapon(newWeapon).MagAmmo = BallisticWeapon(newWeapon).default.MagAmmo;
				BallisticWeapon(newWeapon).bNeedReload = False;
				if (!P.IsLocallyControlled())
					BallisticWeapon(newWeapon).ClientWeaponReloaded();
			}
		}
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

simulated event Timer()
{
	super.Timer();
	if (PCPendingCOI == None)
		return;
	COIPond[COIPond.length] = Spawn(class'ClientOutfittinginterface',PCPendingCOI);
	COIPond[COIPond.length-1].Initialize(self, PCPendingCOI);
	PCPendingCOI = None;
}

function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	local int i, j;
	
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
		for (i=0;i<7;i++)
			for (j=0;j<GetGroup(i).length;j++)
				if (GetGroup(i)[j] ~= string(Other.class))
					return true;
		return false;
	}
	// No ammo pickups
	else if (Ammo(Other) != None && IP_AmmoPack(Other) == None)
	{
		Pickup(Other).myMarker.bBlocked = True;
		return false;
	}
	// Lockers replaced with ammo packs
	else if (WeaponLocker(Other) != None)
	{
		if (!SpawnNewItem(-1, Other, class'IP_AmmoPack'))
		{
			WeaponLocker(Other).myMarker.bBlocked = True;
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
		if (xPickupBase(Other).myMarker != None)
			xPickupBase(Other).myMarker.bBlocked = True;
		if (xPickupBase(Other).myEmitter != None)
			xPickupBase(Other).myEmitter.Destroy();
	}
	// Do terrible, evil, horrendous ballistic deeds unto the other stuff
	return super.CheckReplacement(Other, bSuperRelevant);
}

defaultproperties
{
     LoadOut(0)="BallisticProV55.X4Knife"
     LoadOut(1)="BallisticProV55.MD24Pistol"
     LoadOut(2)=""
     LoadOut(3)="BallisticProV55.M50Rifle"
     LoadOut(4)="BallisticProV55.NRP57Grenade"
     bHideLockers=True
     FriendlyName="BallisticPro: Loadout"
     Description="Play Ballistic Weapons, but instead of picking up weapons, you can choose four to start with, Melee, Sidearm, Primary, Secondary and Grenade. Ammo Packs replace weapon pickups and extra weapons can be taken from your enemies.||http://www.runestorm.com"
}
