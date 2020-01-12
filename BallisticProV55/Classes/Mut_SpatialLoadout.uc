//======================================================================
// Spatial Loadout
//
// Formerly the Ballistic Conflict gear handling, reimplemented as this class. Allows loadouts
// based on space as well as items and team-based loadouts.
// Adapted from RS code by Azarael.
//======================================================================
class Mut_SpatialLoadout extends Mut_Ballistic
	config(BallisticProV55)
	DependsOn(Mut_Loadout);
	
const INVENTORY_SIZE_MAX = 35;
	
var() globalconfig byte	LoadoutOption;		 //0: normal loadout, 1: Evolution skill requirements, 2: Purchasing system (not implemented yet)
var 		  array<string> 	LoadoutOptionText;

var array<Mut_Loadout.LORequirements> FullRequirementsList;

struct ConflictWeapon
{
	var() config string ClassName;
	var() config bool	bRed;
	var() config bool	bBlue;
};
var() globalconfig array<ConflictWeapon>	ConflictWeapons;	// Big list of all available weapons and the teams for which they are selectable

//================================================
// PostBeginPlay
// Reads the evolution loadout requirements from either the 
// evo loadout mutator settings for speedup or from the weapon
// itself, then scales them according to the vars in the Evo
// config class. Adds the GameRules which track the various
// events and save them to the Elimination LRI.
//================================================
function PostBeginPlay()
{
	local int i, j;
	local GameRules G;

	Super.PostBeginPlay();
	
	if (LoadoutOption == 1)
	{
		G = spawn(class'Rules_SpLoadout');
		if ( Level.Game.GameRulesModifiers == None )
			Level.Game.GameRulesModifiers = G;
		else    
			Level.Game.GameRulesModifiers.AddGameRules(G);
	}
		
	for (i=0;i<ConflictWeapons.length;i++)
	{
		for (j=0;j<class'Mut_Loadout'.default.Items.Length;j++)
			if (class'Mut_Loadout'.default.Items[j].ItemName ~= ConflictWeapons[i].ClassName)
				FullRequirementsList[i] = class'Mut_Loadout'.default.Items[j].Requirements;
		if (j >= class'Mut_Loadout'.default.Items.Length)
		{
			FullRequirementsList.length = i+1;
			SetDefaultRequirements(ConflictWeapons[i].ClassName, i);
		}

		//Set team affiliation directly.
		if (ConflictWeapons[i].bBlue)
		{
			if(ConflictWeapons[i].bRed)
				FullRequirementsList[i].InTeam = 2;
			else FullRequirementsList[i].InTeam = 1;
		}
	}
	FullRequirementsList.length = ConflictWeapons.length;
	for (i=0;i<FullRequirementsList.length;i++)
	{
		FullRequirementsList[i].MatchTime	*= class'Mut_LoadoutConfig'.default.TimeScale;
		FullRequirementsList[i].Frags		*= class'Mut_LoadoutConfig'.default.FragScale;
		FullRequirementsList[i].Efficiency	*= class'Mut_LoadoutConfig'.default.EffyScale;
		FullRequirementsList[i].DamageRate	*= class'Mut_LoadoutConfig'.default.DmRtScale;
		FullRequirementsList[i].ShotgunEff	*= class'Mut_LoadoutConfig'.default.SgEfScale;
		FullRequirementsList[i].SniperEff	*= class'Mut_LoadoutConfig'.default.SrEfScale;
		FullRequirementsList[i].HazardEff	*= class'Mut_LoadoutConfig'.default.HzEfScale;
	}
}

//==================================================
// SetDefaultRequirements
// Read the evolution loadout requirements from the special string 
// and assign to the FullReqsList
//==================================================
function bool SetDefaultRequirements(string ClassName, int Index)
{
	local class<BallisticWeapon> BW;
	local string s;
	local array<string> RS;

	BW = class<BallisticWeapon>( DynamicLoadObject(ClassName, class'class') );
	if (BW == None)
		return false;

	s = BW.static.StaticGetSpecialInfo('EvoDefs');
	if (s == "")
		return false;
	Split(s, ";", RS);
	switch (RS.Length-1)
	{
		case 6:	FullRequirementsList[Index].HazardEff	= float(RS[6]);
		case 5:	FullRequirementsList[Index].ShotgunEff	= float(RS[5]);
		case 4:	FullRequirementsList[Index].SniperEff	= float(RS[4]);
		case 3:	FullRequirementsList[Index].DamageRate	= float(RS[3]);
		case 2:	FullRequirementsList[Index].Efficiency	= float(RS[2]);
		case 1:	FullRequirementsList[Index].Frags		= float(RS[1]);
		case 0:	FullRequirementsList[Index].MatchTime	= float(RS[0]);
	}
	return true;
}

//=================================================
// ModifyPlayer
// Outfits the player on spawn
//=================================================
function ModifyPlayer( pawn Other )
{
	local int i, Size, SpaceUsed;
	local float BonusAmmo;
	local Inventory Inv;
	local Weapon W;
//	local Inventory Inv;
	local class<Inventory> InventoryClass;
	local EliminationLRI EPRI;
	local string s;
	local class<ConflictItem> itemclass;

	Super.ModifyPlayer(Other);
	
	//ModifyPlayer isn't always called on spawn
	if (Other.LastStartTime > Level.TimeSeconds + 2)
		return;

	EPRI = EliminationLRI(GetBPRI(Other.PlayerReplicationInfo));
	if (EPRI == None)
		return;

	if (Other.PlayerReplicationInfo.bBot)
		EquipBot(Other);
	else
	{
		EPRI.Validate(EPRI.Loudout);
		if (EPRI.Loudout.length == 0)
		{
 			s = GetRandomWeapon(EPRI);
	 		if (s != "")
 				EPRI.Loudout[0] = s;
	 	}
	}

	EPRI.AppliedItems.length = 0;

	if ( xPawn(Other) != None )
	{
		for (i=0;i<Max(EPRI.Loudout.length,2);i++)
		{
			if (i >= EPRI.Loudout.length)
				xPawn(Other).RequiredEquipment[i] = "";
			else
			{
				InventoryClass = Level.Game.BaseMutator.GetInventoryClass(EPRI.Loudout[i]);
				if( (InventoryClass!=None))
				{
					Size = GetItemSize(InventoryClass);
					if (SpaceUsed + Size > INVENTORY_SIZE_MAX)
						continue;
					xPawn(Other).RequiredEquipment[i] = EPRI.Loudout[i];
					Inv = Spawn(InventoryClass);
					if( Inv != None )
					{
						Inv.GiveTo(Other);
						if (Weapon(Inv) != None && Other.PendingWeapon == None && Other.Weapon == None)
						{
							Other.PendingWeapon = Weapon(Inv);
							Other.ChangedWeapon();
						}
						if ( Inv != None )
							Inv.PickupFunction(Other);
						SpaceUsed += Size;
					}
				}
				else
				{
					xPawn(Other).RequiredEquipment[i] = "";
					itemclass = class<conflictitem>(DynamicLoadObject(EPRI.Loudout[i],class'Class'));
					if (itemclass != None)
					{
						Size = itemclass.default.Size/5;
						if (SpaceUsed + Size > INVENTORY_SIZE_MAX)
							continue;
						EPRI.AppliedItems[EPRI.AppliedItems.length] = ItemClass;
						if (ItemClass.default.bBonusAmmo)
						{
							if (ItemClass.static.AddAmmoBonus(Other, BonusAmmo));
								SpaceUsed += Size;
						}
						else if (ItemClass.static.Applyitem(Other))
							SpaceUsed += Size;
					}
				}
			}
		}
	}
    if ( UnrealPawn(Other) != None )
        UnrealPawn(Other).AddDefaultInventory();

	if (SpaceUsed < INVENTORY_SIZE_MAX)
	{
		for (Inv=Other.Inventory;Inv!=None;Inv=Inv.Inventory)
			if (Weapon(Inv) != None)
				break;
		if (Inv == None)
		{
			s = GetRandomWeapon(EPRI);

			InventoryClass = Level.Game.BaseMutator.GetInventoryClass(s);
			if( (InventoryClass!=None))
			{
				Inv = Spawn(InventoryClass);
				if( Inv != None )
				{
					Inv.GiveTo(Other);
					if (Weapon(Inv) != None && Other.PendingWeapon == None && Other.Weapon == None)
					{
						Other.PendingWeapon = Weapon(Inv);
						Other.ChangedWeapon();
					}
					if ( Inv != None )
						Inv.PickupFunction(Other);
				}
			}
		}
	}

	for (Inv=Other.Inventory;Inv!=None;Inv=Inv.Inventory)
	{
		W = Weapon(Inv);
		if (W != None && BonusAmmo > 0)
		{
			SpawnAmmo(W.default.FireModeClass[0].default.AmmoClass, Other, BonusAmmo);
			if (W.default.FireModeClass[1] != None && W.default.FireModeClass[0].default.AmmoClass != W.default.FireModeClass[1].default.AmmoClass)
				SpawnAmmo(W.default.FireModeClass[1].default.AmmoClass, Other, BonusAmmo);
		}
	}
	for (i=0;i<EPRI.AppliedItems.length;i++)
		EPRI.AppliedItems[i].static.PostApply(Other);
}

//========================================
// InventoryChanged
// Called when the player updates their inventory.
//========================================
function InventoryChanged(EliminationLRI PRI)
{
	local Pawn P;
	local array<string> NewList;
	local int i, SpaceUsed, Size;
	local float BonusAmmo;
	local Actor Inv, OldInv;
	local Weapon W;
	local class<weapon> WeapClass;
	local class<conflictitem> ItemClass;
	local class<actor> InvClass;

	if (PRI == None || Controller(PRI.Owner) == None || Controller(PRI.Owner).Pawn == None)
		return;
	//Direct support for Ballistic Conflict
	if (Game_BWConflict(Level.Game) != None)
		if(Level.Game.IsInState('PendingRound') && (!Game_BWConflict(Level.Game).IsNearStartSpot(Controller(PRI.Owner).PlayerReplicationInfo) || Game_BWConflict(Level.Game).RoundTime > 30))
			return;

	P = Controller(PRI.Owner).Pawn;
	NewList = PRI.Loudout;
	Inv = P.Inventory;
	OldInv = P;
	while (Inv != None)
	{
		if (Weapon(Inv) != None || Ammunition(Inv) != None || PowerUps(Inv) != None)
		{
			Inv.Destroy();
			Inv = OldInv;
		}
		else
			OldInv = Inv;
		Inv = Inv.Inventory;
	}

	for (i=0;i<PRI.AppliedItems.length;i++)
		PRI.AppliedItems[i].static.ResetPlayer(P);
	PRI.AppliedItems.length = 0;

	for (i=0;i<NewList.length;i++)
	{
		invclass = class<actor>(DynamicLoadObject(NewList[i],class'Class'));
		if (invClass == None)
			continue;
		WeapClass = class<weapon>(invclass);
		if (WeapClass != None)
		{
			Size = GetItemSize(WeapClass);
			if (SpaceUsed + Size > INVENTORY_SIZE_MAX)
				continue;
			W = P.Spawn(WeapClass,,,P.Location);
			if( W != None )
			{
				W.GiveTo(P);
				if (P.PendingWeapon == None && P.Weapon == None)
				{
					P.PendingWeapon = W;
					P.ChangedWeapon();
				}
				SpaceUsed += Size;
			}
		}
		else
		{
			itemclass = class<conflictitem>(invclass);
			if (itemclass != None)
			{
				Size = itemclass.default.Size/5;
				if (SpaceUsed + Size > INVENTORY_SIZE_MAX)
					continue;
				PRI.AppliedItems[PRI.AppliedItems.length] = ItemClass;
				if (ItemClass.default.bBonusAmmo)
				{
					if (ItemClass.static.AddAmmoBonus(P, BonusAmmo));
						SpaceUsed += Size;
				}
				else if (ItemClass.static.Applyitem(P))
					SpaceUsed += Size;
			}
		}
	}

	for (Inv=P.Inventory;Inv!=None;Inv=Inv.Inventory)
	{
		W = Weapon(Inv);
		if (W != None)
		{
			SpawnAmmo(W.default.FireModeClass[0].default.AmmoClass, P, 1 + BonusAmmo);
			if (W.default.FireModeClass[0].default.AmmoClass != W.default.FireModeClass[1].default.AmmoClass)
				SpawnAmmo(W.default.FireModeClass[1].default.AmmoClass, P, 1 + BonusAmmo);
		}
	}
	for (i=0;i<PRI.AppliedItems.length;i++)
		PRI.AppliedItems[i].static.PostApply(P);
}

function EquipBot(Pawn P)
{
	local int i, j, Size, SpaceUsed;
	local EliminationLRI EPRI;
	local array<string> Potentials;
	local string ClassName;
	local class<Weapon> W;
	local bool bAddedMiscs;
	local class<ConflictItem> CI;

	local array<float>	BandWidth;
	local float			BandTotal, BandRand, BandLoc;

	EPRI = EliminationLRI(GetBPRI(P.PlayerReplicationInfo));
	if (EPRI == None)
		return;

	// Make a list of potential weapons
	for (i=0;i<ConflictWeapons.length;i++)
	{
		if (P.GetTeamNum() == 0 && !ConflictWeapons[i].bRed)
			continue;
		if (P.GetTeamNum() > 0 && !ConflictWeapons[i].bBlue)
			continue;
		// Only add weapons, not items yet. Make sure bot picks at least one weapon before getting items
		if (class<Weapon>(DynamicLoadObject(ConflictWeapons[i].ClassName, class'Class')) == None)
			continue;
		if (EPRI.WeaponRequirementsOk(FullRequirementsList[i]))
		{
			Potentials[Potentials.length] = ConflictWeapons[i].ClassName;
			if (LoadoutOption == 1)
			{	// Make Weight table so newer harder to get weapons are more likely to be chosen
				BandWidth[Potentials.length-1] = 3;
				if (FullRequirementsList[i].MatchTime > 0)
					BandWidth[Potentials.length-1] += sqrt(FullRequirementsList[i].MatchTime);
				if (FullRequirementsList[i].Frags > 0)
					BandWidth[Potentials.length-1] += sqrt(FullRequirementsList[i].Frags)*3;
				BandTotal += BandWidth[Potentials.length-1];
			}
		}
	}

	// Pick us some stuff
	EPRI.Loudout.length = 0;
	for (i=0; i < INVENTORY_SIZE_MAX && SpaceUsed < INVENTORY_SIZE_MAX; i++)
	{
		if (LoadoutOption == 1)
		{	// Randomly pick something using weights
			BandRand = FRand() * BandTotal;
			BandLoc = 0;
			for (j=0;j<BandWidth.length;j++)
			{
				BandLoc+=BandWidth[j];
				if (BandRand < BandLoc)
				{
					Classname = Potentials[j];
					break;
				}
			}
		}
		else	// Randomly pick anything
			ClassName = Potentials[Rand(Potentials.length)];

		// Try adding this weapon / item
		W = class<Weapon>(DynamicLoadObject(ClassName, class'Class'));
		if (W == None)
		{
			if (bAddedMiscs)
			{	// Add this item
				CI = class<ConflictItem>(DynamicLoadObject(ClassName, class'Class'));
				if (CI == None)
					continue;
				Size = CI.default.Size/5;

				if (Size + SpaceUsed > INVENTORY_SIZE_MAX)
					continue;
				EPRI.Loudout[EPRI.Loudout.length] = ClassName;
				SpaceUsed += Size;
			}
			continue;
		}
		// We've got a weapon so add the items to the potential list
		if (!bAddedMiscs)
		{
			for (j=0;j<ConflictWeapons.length;j++)
			{
				if (class<ConflictItem>(DynamicLoadObject(ConflictWeapons[j].ClassName, class'Class')) == None)
					continue;
				Potentials[Potentials.length] = ConflictWeapons[j].ClassName;
				if (LoadoutOption == 1)
				{
					BandWidth[Potentials.length-1] = 3;
					BandTotal += BandWidth[Potentials.length-1];
				}
			}
			bAddedMiscs = true;
		}
		Size = GetItemSize(W);

		if (Size + SpaceUsed > INVENTORY_SIZE_MAX)
			continue;
		EPRI.Loudout[EPRI.Loudout.length] = ClassName;
		SpaceUsed += Size;
	}
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

function int GetItemSize(class<Inventory> Item)
{
	if (class<BallisticWeapon>(Item) != None)
		return class<BallisticWeapon>(Item).default.InventorySize;
	return 7;
}

static function SpawnAmmo(class<Ammunition> newClass, Pawn P, optional float Multiplier)
{
	local Ammunition Ammo;

	if (P==None || newClass == None)
		return;
	Ammo = Ammunition(P.FindInventoryType(newClass));
	if(Ammo == None)
    {
		Ammo = P.Spawn(newClass);
		P.AddInventory(Ammo);
    }
	if(Ammo == None)
		return;
    if (Multiplier > 0)
		Ammo.AddAmmo(Ammo.InitialAmount*Multiplier);
    else
		Ammo.AddAmmo(Ammo.InitialAmount);
	Ammo.GotoState('');
}

function string GetRandomWeapon (EliminationLRI EPRI)
{
	local int i;
	local array<string> Potentials;

	for (i=0;i<ConflictWeapons.length;i++)
		if (EPRI.WeaponRequirementsOk(FullRequirementsList[i]) )
		{
			if (class<Weapon>(DynamicLoadObject(ConflictWeapons[i].ClassName, class'class')) != None)
				Potentials[Potentials.length] = ConflictWeapons[i].ClassName;
		}

	if (Potentials.length < 1)
		return "";
	return Potentials[Rand(Potentials.length)];
}

// Check for item replacement.
function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	local int i, j;
	local float OMA, NMA;
	local class<actor> NewItem;
	local BallisticPlayerReplicationInfo BPRI;

	local LinkedReplicationInfo LPRI;
	
	bSuperRelevant = 0;
	
	if(Controller(Other) != None && InStr(Caps(Level.Game.GameName),"FREON") == -1 && InStr(Caps(Level.Game.GameName),"ARENAMASTER") == -1) //bypass this in 3SPN, handled differently
	{
		if (PlayerController(Other) != None && (Controller(Other).PawnClass == None || Controller(Other).PawnClass == class'xPawn' || bForceBallisticPawn))
			PlayerController(Other).PawnClass = class'BallisticPawn';
		else if (Bot(Other) != None && (Controller(Other).PawnClass == None || Controller(Other).PawnClass == class'xPawn' || bForceBallisticPawn))
			Bot(Other).PreviousPawnClass = class'BallisticPawn';
	}
	
	//shunt the lris down to make way for this one
	else if (PlayerReplicationInfo(Other) != None)
	{
		BPRI = Spawn(class'EliminationLRI', Other.Owner);		
		
		if(PlayerReplicationInfo(Other).CustomReplicationInfo != None)
		{
			lPRI = PlayerReplicationInfo(Other).CustomReplicationInfo;
		
			PlayerReplicationInfo(Other).CustomReplicationInfo = BPRI;
			
			//this should be impossible?
			if (BPRI.NextReplicationInfo != None)
				BPRI.NextReplicationInfo.NextReplicationInfo = lPRI;
			else
				BPRI.NextReplicationInfo = lPRI;
		}
		else
			PlayerReplicationInfo(Other).CustomReplicationInfo = BPRI;
	}
	
	else if (xPawn(Other) != None)
	{
		xPawn(Other).RequiredEquipment[0] = "";
		xPawn(Other).RequiredEquipment[1] = "";
		return true;
	}

	// No weapon pickups unless they are dropped. Dropped BWs are owned by the weapon that dropped them
	else if (WeaponPickup(Other) != None && Other.Owner == None)
		return false;
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
	
	else if (JumpSpot(Other) != None && BallisticReplicationInfo(BallisticReplicationInfo) != None && BallisticReplicationInfo(BallisticReplicationInfo).bNoDodging)
	{
		JumpSpot(Other).bDodgeUp = false;
	}
	else
	{
	//Go through replacements list and see if there is a match
	for (i=0;i<Replacements.Length;i++)
	{
		// Swap weapons
		if (Weapon(Other) != None)
		{
			if (GetInventoryFor(Replacements[i].OldItem) == Weapon(Other).Class && (!Replacements[i].bSuper || !bLeaveSuper))
				SwapWeapon(Other, GetInventoryFor(Replacements[i].NewItems[Rand(Replacements[i].NewItems.length)]));
		}
		// Replace Weapon base
		else if (xWeaponBase(Other) != None && xWeaponBase(Other).WeaponType != None && xWeaponBase(Other).WeaponType == GetInventoryFor(Replacements[i].OldItem) && (!Replacements[i].bSuper || !bLeaveSuper))
		{
			if (Replacements[i].bUseBase)
			{
				NewItem = GetNewItem(i);
				xWeaponBase(Other).WeaponType = class<weapon>(GetInventoryFor(NewItem));
				xWeaponBase(Other).PowerUp = GetPickupFor(NewItem);
			}
			else if (!SpawnNewItem(i, Other))
				return false;
		}
		// Change pickup classes for WildcardBases
		else if (WildcardBase(Other) != None)
		{
//			Other.bHidden = true;
			for(j=0;j<ArrayCount(WildcardBase(Other).PickupClasses);j++)
			{
				if (WildcardBase(Other).PickupClasses[j] != None && WildcardBase(Other).PickupClasses[j] == GetPickupFor(Replacements[i].OldItem) && (!Replacements[i].bSuper || !bLeaveSuper) && class<TournamentPickup>(GetPickupFor(GetNewItem(i))) != None)
					WildcardBase(Other).PickupClasses[j] = class<TournamentPickup>(GetPickupFor(GetNewItem(i)));
			}
		}
		// Replace Pickup base
		else if (xPickupBase(Other) != None && xPickupBase(Other).PowerUp != None && xPickupBase(Other).PowerUp == GetPickupFor(Replacements[i].OldItem) && (!Replacements[i].bSuper || !bLeaveSuper))
		{
			if (Replacements[i].bUseBase)
				xPickupBase(Other).PowerUp = GetPickupFor(GetNewItem(i));
			else if (!SpawnNewItem(i, Other))
				return false;
		}
		// Change weapons in weaponlockers
		else if (WeaponLocker(Other) != None && (!Replacements[i].bSuper || !bLeaveSuper))
		{
			for (j=0;j<WeaponLocker(Other).Weapons.Length;j++)
			{
				if (WeaponLocker(Other).Weapons[j].WeaponClass == GetInventoryFor(Replacements[i].OldItem))
				{
					NewItem = GetNewItem(i);
					OMA = WeaponLocker(Other).Weapons[j].WeaponClass.default.FireModeClass[0].default.AmmoClass.default.MaxAmmo;
					NMA = class<weapon>(GetInventoryFor(NewItem)).default.FireModeClass[0].default.AmmoClass.default.MaxAmmo;
					WeaponLocker(Other).Weapons[j].ExtraAmmo = NMA * (WeaponLocker(Other).Weapons[j].ExtraAmmo / OMA);
					WeaponLocker(Other).Weapons[j].ExtraAmmo *= 2;
					WeaponLocker(Other).Weapons[j].WeaponClass = class<weapon>(GetInventoryFor(NewItem));
				}
			}
		}
		else if (Pickup(Other) != None && Pickup(Other).Class == GetPickupFor(Replacements[i].OldItem) && (!Replacements[i].bSuper || !bLeaveSuper))
			AddPickupSwap(Pickup(Other), i);
	}
	}
	return true;
}

defaultproperties
{
     LoadoutOptionText(0)="Standard"
     LoadoutOptionText(1)="Evolution"
     LoadoutOptionText(2)="Purchasing (NOT IMPLEMENTED)"
     ConfigMenuClassName="BallisticProV55.BallisticConflictWeaponMenuPro"
     FriendlyName="BallisticPro: Conflict Loadout"
     Description="Play Ballistic Weapons with an expanded loadout system supporting Evolution configuration and inventory space."
}
