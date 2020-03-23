//=============================================================================
// BC_WeaponInfoCache.
//
// To solve to problem of taking rediculous amounts of time to load all the
// weapon classes just to get a few menu related properties, we can use this
// which holds a list of weapons and their properties which might be needed by
// BW menus and such.
//
// Menus can use FindWeaponInfo() to get the WeaponInfo for the desired weapon.
// If FindWeaponInfo returns false because the weapon isn't listed, the menu
// system can use AddWeaponInfo() with the weapon class to list it for use with
// FindWeaponInfo() in the future.
// EndSession() can be called after the menu has done all its AddWeaponInfo(),
// This is a very easy way make sure all new additions are saved if there were
// any changes.
//
// AutoWeaponInfo() is a very simple shortcut to get WeaponInfo and add the new
// classname to the list if needed.
//
// AddWeaponInfoName() is a shotcut to AddWeaponInfo() that requires only a
// classname and will load the class itself
//
//
// Most menus systems will be able to take advantage of the Weapon Info Cache
// with a call to AutoWeaponInfo() for each weapon classname and a single call
// to EndSession() once its finished the loop.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class BC_WeaponInfoCache extends Object config(BWCache) exportstructs;

struct WeaponInfo
{
	var() config string		ClassName;
	var() config string		ItemName;
	var() config Material	SmallIconMaterial;
	var() config IntBox		SmallIconCoords;
	var() config int			InventoryGroup;
	var() config Material	BigIconMaterial;
	var()	config byte		InventorySize;
	var() config bool			bIsBW;
};

var() config array<WeaponInfo>	Weapons;
var   bool						bChanged;

// Find a specific weapon in the list, output the WI and return success or failure to find the weapon
static function bool FindWeaponInfo(string CN, out WeaponInfo WI, optional out int Index)
{
	local int i;

	for (i=0;i<default.Weapons.length;i++)
		if (default.Weapons[i].ClassName ~= CN)
		{
			Index = i;
			WI = default.Weapons[i];
			return true;
		}
	Index = -1;
	return false;
}

// Fast shotcut to use FindWeaponInfo() and automatically AddWeaponInfoName() if needed
static function WeaponInfo AutoWeaponInfo(string WeapClassName, optional out int i)
{
	local WeaponInfo WI;

	// Tap into the BW weapon cache system to identify BallisticWeapons without loading them
	if (FindWeaponInfo(WeapClassName, WI, i))
		return WI;
	return AddWeaponInfoName(WeapClassName, i);
}

// Shorcut to AddWeaponInfo() using only classname
static function WeaponInfo AddWeaponInfoName(string WeapClassName, optional out int i)
{
	local class<Weapon> Weap;
	local WeaponInfo WI;

	Weap = class<Weapon>(DynamicLoadObject(WeapClassName, class'Class'));
	if (Weap != None)
		WI = AddWeaponInfo(Weap, i);
	else
	{
		i = -1;
		return WI;
	}
	return WI;
}

// List the right properties of the input class. Returns the new WI and index of WI in the list
static function WeaponInfo AddWeaponInfo(class<Weapon> Weap, optional out int i)
{
	local WeaponInfo WI;
	local Class<BallisticWeapon> BW;

	i=-1;
	if (Weap == None)
		return WI;

	WI.ClassName 		 = string(Weap);
	WI.ItemName			 = Weap.default.ItemName;
	WI.SmallIconMaterial = Weap.default.IconMaterial;
	WI.SmallIconCoords	 = Weap.default.IconCoords;
	WI.InventoryGroup	 = Weap.default.InventoryGroup;

	
	BW = Class<BallisticWeapon>(Weap);
	if (BW != None)
	{
		WI.BigIconMaterial	= BW.default.BigIconMaterial;
		WI.InventorySize		= BW.default.InventorySize;
		WI.bIsBW				= true;
	}

	i = default.Weapons.length;
	default.Weapons[default.Weapons.length] = WI;

	default.bChanged = true;
	return WI;
}

static function bool IsValid(coerce string S)
{
	if (InStr(s, "Recolors4") != -1 || InStr(s, "Prototypes") != -1 || InStr(s, "WeaponPack2") != -1)
		return false;
	return true;
}

static function GetBWWeps(out array<WeaponInfo> BWeps)
{
	local int i;
	
	for (i=0;i<default.Weapons.Length;i++)
	{
		if (default.Weapons[i].bIsBW)
			BWeps[BWeps.Length] = default.Weapons[i];
	}
}

// If the list was changed, save it.
static function EndSession()
{
	if (default.bChanged)
		StaticSaveConfig();
	default.bChanged = false;
}

defaultproperties
{
     Weapons(0)=(ClassName="BallisticProV55.X4Knife",ItemName="X4 Knife",SmallIconMaterial=Texture'BallisticUI.Icons.X4.SmallIcon_X4',SmallIconCoords=(X2=128,Y2=32),InventoryGroup=1,BigIconMaterial=Texture'BallisticUI.Icons.X4.BigIcon_X4',InventorySize=2,bIsBW=True)
     Weapons(1)=(ClassName="BWBPRecolorsPro.AH208Pistol",ItemName="AH208 Pistol",SmallIconMaterial=Texture'BallisticUI.Icons.SmallIcon_AH208-Pistol',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_AH208-Pistol',InventorySize=8,bIsBW=True)
     Weapons(2)=(ClassName="BallisticProV55.D49Revolver",ItemName="D49 Revolver",SmallIconMaterial=Texture'BallisticUI.Icons.SmallIcon_D49',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_D49',bIsBW=True)
     Weapons(3)=(ClassName="BallisticProV55.GRS9Pistol",ItemName="GRS-9 Pistol",SmallIconMaterial=Texture'BallisticUI.Icons.SmallIcon_GRS-9',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_GRS-9',InventorySize=3,bIsBW=True)
     Weapons(4)=(ClassName="BallisticProV55.MD24Pistol",ItemName="MD24 Pistol",SmallIconMaterial=Texture'BallisticUI.Icons.SmallIcon_MD24',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_MD24',InventorySize=3,bIsBW=True)
     Weapons(5)=(ClassName="BallisticProV55.RS8Pistol",ItemName="RS8 Pistol",SmallIconMaterial=Texture'BallisticUI.Icons.SmallIcon_RS8',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_RS8',bIsBW=True)
     Weapons(6)=(ClassName="BallisticProV55.Fifty9MachinePistol",ItemName="Fifty-9 Submachine gun",SmallIconMaterial=Texture'BallisticUI.Icons.SmallIcon_Fifty9',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=3,BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_Fifty9',bIsBW=True) 
     Weapons(7)=(ClassName="BallisticProV55.XRS10SubMachinegun",ItemName="XRS-10 Submachine gun",SmallIconMaterial=Texture'BallisticUI.Icons.SmallIcon_XRS10',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=3,BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_XRS10',bIsBW=True)
     Weapons(8)=(ClassName="BWBPOtherPackPro.PD97Bloodhound",ItemName="PD-97 Pistol",SmallIconMaterial=Texture'BallisticUI.Icons.SmallIcon-PD97',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_PD97',InventorySize=3,bIsBW=True)
     Weapons(9)=(ClassName="BallisticProV55.XK2SubMachinegun",ItemName="XK2 Submachine gun",SmallIconMaterial=Texture'BallisticUI.Icons.SmallIcon_XK2',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=3,BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_XK2',bIsBW=True)
     Weapons(10)=(ClassName="BallisticProV55.XMK5SubMachinegun",ItemName="XMk5 Submachine gun",SmallIconMaterial=Texture'BallisticUI.Icons.SmallIcon_XMK5',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=3,BigIconMaterial=Texture'BallisticUI.Icons.XMK5.BigIcon_XMK5',InventorySize=7,bIsBW=True)
     Weapons(11)=(ClassName="BWBPRecolorsPro.AK47AssaultRifle",ItemName="AK-470 Assault Rifle",SmallIconMaterial=Texture'BallisticUI.Icons.AK-470.SmallIcon_AK-470',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_AK-470',InventorySize=7,bIsBW=True)
     Weapons(12)=(ClassName="BWBPRecolorsPro.LK05Carbine",ItemName="LK-05 Carbine",SmallIconMaterial=Texture'BallisticUI.Icons.SmallIcon_LK-05',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_LK-05',InventorySize=7,bIsBW=True)
     Weapons(13)=(ClassName="BallisticProV55.M46AssaultRifleQS",ItemName="M46 Assault Rifle",SmallIconMaterial=Texture'BallisticUI.Icons.SmallIcon_M46',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_M46',InventorySize=7,bIsBW=True)
     Weapons(14)=(ClassName="BallisticProV55.M50AssaultRifle",ItemName="M50 Assault Rifle",SmallIconMaterial=Texture'BallisticUI.Icons.SmallIcon_M50',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_M50',bIsBW=True)
     Weapons(15)=(ClassName="BWBPRecolorsPro.F2000AssaultRifle",ItemName="F2000 Assault Rifle",SmallIconMaterial=Texture'BallisticUI.Icons.SmallIcon_F2000',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_F2000',InventorySize=7,bIsBW=True)
     Weapons(16)=(ClassName="BallisticProV55.SRS600Rifle",ItemName="SRS-600 Rifle",SmallIconMaterial=Texture'BallisticUI.Icons.SmallIcon_SRS600',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_SRS600',InventorySize=7,bIsBW=True)
	 Weapons(17)=(ClassName="BallisticProV55.SARAssaultRifle",ItemName="Sub-Assault Rifle",SmallIconMaterial=Texture'BallisticUI.Icons.SmallIcon_SAR',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_SAR',InventorySize=7,bIsBW=True)
     Weapons(18)=(ClassName="BallisticProV55.M353Machinegun",ItemName="M353 Machinegun",SmallIconMaterial=Texture'BallisticUI.Icons.SmallIcon_M353',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=6,BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_M353',bIsBW=True)	 
     Weapons(19)=(ClassName="BallisticProV55.M925Machinegun",ItemName="M925 Machinegun",SmallIconMaterial=Texture'BallisticUI.Icons.SmallIcon_M925',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=6,BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_M925',bIsBW=True) 
     Weapons(20)=(ClassName="BallisticProV55.M763Shotgun",ItemName="M763 Shotgun",SmallIconMaterial=Texture'BallisticUI.Icons.SmallIcon_M763',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=7,BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_M763',bIsBW=True)
     Weapons(21)=(ClassName="BallisticProV55.MRS138Shotgun",ItemName="MRS138 Shotgun",SmallIconMaterial=Texture'BallisticUI.Icons.SmallIcon_MRS138',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=7,BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_MRS138',bIsBW=True)
     Weapons(22)=(ClassName="BWBPRecolorsPro.SK410Shotgun",ItemName="SK-410 Shotgun",SmallIconMaterial=Texture'BallisticUI.Icons.SmallIcon_SK410',SmallIconCoords=(X2=127,Y2=35),InventoryGroup=7,BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_SK410',InventorySize=7,bIsBW=True)
     Weapons(23)=(ClassName="BWBPRecolorsPro.SKASShotgun",ItemName="SKAS-21 Shotgun",SmallIconMaterial=Texture'BallisticUI.Icons.SmallIcon_SKAS',SmallIconCoords=(X2=127,Y2=30),InventoryGroup=7,BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_SKAS',InventorySize=7,bIsBW=True)
     Weapons(24)=(ClassName="BallisticProV55.R78Rifle",ItemName="R78A1 Sniper Rifle",SmallIconMaterial=Texture'BallisticUI.Icons.SmallIcon_R78',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=9,BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_R78',bIsBW=True)
     Weapons(25)=(ClassName="BallisticProV55.R9RangerRifle",ItemName="R9 Rifle",SmallIconMaterial=Texture'BallisticUI.Icons.SmallIcon_R9',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=9,BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_R9',InventorySize=7,bIsBW=True)
     Weapons(26)=(ClassName="BallisticProV55.MarlinRifle",ItemName="Redwood 6000 Rifle",SmallIconMaterial=Texture'BallisticUI.Icons.SmallIcon_Marlin',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=9,BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_Marlin',InventorySize=7,bIsBW=True)
     Weapons(27)=(ClassName="BWBPRecolorsPro.X82Rifle",ItemName="X82 Sniper Rifle",SmallIconMaterial=Texture'BallisticUI.Icons.SmallIcon_X82',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=9,BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_X82',InventorySize=7,bIsBW=True)
     Weapons(28)=(ClassName="BWBPRecolorsPro.MGLauncher",ItemName="MGL Grenade Launcher",SmallIconMaterial=Texture'BallisticUI.Icons.SmallIcon_MGL',SmallIconCoords=(X2=127,Y2=35),InventoryGroup=8,BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_MGL',InventorySize=7,bIsBW=True)
     Weapons(29)=(ClassName="BallisticProV55.G5Bazooka",ItemName="G5 Bazooka",SmallIconMaterial=Texture'BallisticUI.Icons.SmallIcon_G5',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=8,BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_G5',bIsBW=True)
     Weapons(30)=(ClassName="BallisticProV55.NRP57Grenade",ItemName="NRP57 Grenade",SmallIconMaterial=Texture'BallisticUI.Icons.SmallIcon_NRP57',SmallIconCoords=(X2=127,Y2=31),BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_NRP57',bIsBW=True)
}
