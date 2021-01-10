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
class BC_WeaponInfoCache extends Object 
	config(BWCache) 
	exportstructs;			   

struct WeaponInfo
{
	var() config string		ClassName;
	var() config string		ItemName;
	var() config Material	SmallIconMaterial;
	var() config IntBox		SmallIconCoords;
	var() config int			InventoryGroup;
	var() config Material	BigIconMaterial;
	var() config byte		InventorySize;
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
     Weapons(0)=(ClassName="BallisticProV55.X4Knife",ItemName="X4",SmallIconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_X4',SmallIconCoords=(X1=0,Y1=0,X2=128,Y2=32),InventoryGroup=1,BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_X4',InventorySize=2,bIsBW=True)
     Weapons(1)=(ClassName="BallisticProV55Recolors.AH208Pistol",ItemName="AH208",SmallIconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_AH208-Pistol',SmallIconCoords=(X1=0,Y1=0,X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_AH208-Pistol',InventorySize=8,bIsBW=True)
     Weapons(2)=(ClassName="BallisticProV55.D49Pistol",ItemName="D49",SmallIconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_D49',SmallIconCoords=(X1=0,Y1=0,X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_D49',InventorySize=0,bIsBW=True)
     Weapons(3)=(ClassName="BallisticProV55.Fifty9SMG",ItemName="Fifty-9",SmallIconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_Fifty9',SmallIconCoords=(X1=0,Y1=0,X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_Fifty9',InventorySize=0,bIsBW=True) 
     Weapons(4)=(ClassName="BallisticProV55.GRS9Pistol",ItemName="GRS-9",SmallIconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_GRS-9',SmallIconCoords=(X1=0,Y1=0,X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_GRS-9',InventorySize=3,bIsBW=True)
     Weapons(5)=(ClassName="BallisticProV55.MD24Pistol",ItemName="MD24",SmallIconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_MD24',SmallIconCoords=(X1=0,Y1=0,X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_MD24',InventorySize=3,bIsBW=True)
     Weapons(6)=(ClassName="BallisticProV55.PD97Pistol",ItemName="PD-97",SmallIconMaterial=Texture'BallisticProUITex.Icons.SmallIcon-PD97',SmallIconCoords=(X1=0,Y1=0,X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_PD97',InventorySize=6,bIsBW=True)
     Weapons(7)=(ClassName="BallisticProV55.RS8Pistol",ItemName="RS8",SmallIconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_RS8',SmallIconCoords=(X1=0,Y1=0,X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_RS8',InventorySize=0,bIsBW=True)
     Weapons(8)=(ClassName="BallisticProV55.XRS10SMG",ItemName="XRS-10",SmallIconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_XRS10',SmallIconCoords=(X1=0,Y1=0,X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_XRS10',InventorySize=0,bIsBW=True)
     Weapons(9)=(ClassName="BallisticProV55.XK2SMG",ItemName="XK2",SmallIconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_XK2',SmallIconCoords=(X1=0,Y1=0,X2=127,Y2=31),InventoryGroup=3,BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_XK2',InventorySize=0,bIsBW=True)
     Weapons(10)=(ClassName="BallisticProV55.XMK5SMG",ItemName="XMK-5",SmallIconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_XMK5',SmallIconCoords=(X1=0,Y1=0,X2=127,Y2=31),InventoryGroup=3,BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_XMK5',InventorySize=7,bIsBW=True)
     Weapons(11)=(ClassName="BallisticProV55Recolors.AK470Rifle",ItemName="AK-470",SmallIconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_AK-470',SmallIconCoords=(X1=0,Y1=0,X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_AK-470',InventorySize=7,bIsBW=True)
     Weapons(12)=(ClassName="BallisticProV55Recolors.FN2000Rifle",ItemName="FN2000",SmallIconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_FN2000',SmallIconCoords=(X1=0,Y1=0,X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_FN2000',InventorySize=7,bIsBW=True)
     Weapons(13)=(ClassName="BallisticProV55Recolors.LK05Rifle",ItemName="LK-05",SmallIconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_LK-05',SmallIconCoords=(X1=0,Y1=0,X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_LK-05',InventorySize=7,bIsBW=True)
     Weapons(14)=(ClassName="BallisticProV55.M46Rifle",ItemName="M46",SmallIconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_M46',SmallIconCoords=(X1=0,Y1=0,X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_M46',InventorySize=7,bIsBW=True)
     Weapons(15)=(ClassName="BallisticProV55.M50Rifle",ItemName="M50",SmallIconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_M50',SmallIconCoords=(X1=0,Y1=0,X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_M50',InventorySize=0,bIsBW=True)
 	 Weapons(16)=(ClassName="BallisticProV55.SAR12Rifle",ItemName="SAR-12",SmallIconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_SAR-12',SmallIconCoords=(X1=0,Y1=0,X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_SAR-12',InventorySize=7,bIsBW=True)
     Weapons(17)=(ClassName="BallisticProV55Recolors.SK410Shotgun",ItemName="SK410",SmallIconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_SK410',SmallIconCoords=(X2=127,Y2=35),InventoryGroup=6,BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_SK410',InventorySize=7,bIsBW=True)
     Weapons(18)=(ClassName="BallisticProV55.M763Shotgun",ItemName="M763",SmallIconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_M763',SmallIconCoords=(X1=0,Y1=0,X2=127,Y2=31),InventoryGroup=6,BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_M763',InventorySize=0,bIsBW=True)
     Weapons(19)=(ClassName="BallisticProV55.MRS138Shotgun",ItemName="MRS138",SmallIconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_MRS138',SmallIconCoords=(X1=0,Y1=0,X2=127,Y2=31),InventoryGroup=6,BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_MRS138',InventorySize=0,bIsBW=True)
     Weapons(20)=(ClassName="BallisticProV55.MarlinRifle",ItemName="Marlin",SmallIconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_Marlin',SmallIconCoords=(X1=0,Y1=0,X2=127,Y2=31),InventoryGroup=7,BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_Marlin',InventorySize=7,bIsBW=True)
     Weapons(21)=(ClassName="BallisticProV55.R78A1Rifle",ItemName="R78A1",SmallIconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_R78',SmallIconCoords=(X1=0,Y1=0,X2=127,Y2=31),InventoryGroup=7,BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_R78',InventorySize=0,bIsBW=True)
     Weapons(22)=(ClassName="BallisticProV55.R9Rifle",ItemName="R9",SmallIconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_R9',SmallIconCoords=(X1=0,Y1=0,X2=127,Y2=31),InventoryGroup=7,BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_R9',InventorySize=7,bIsBW=True)
	 Weapons(23)=(ClassName="BallisticProV55.SRS600Rifle",ItemName="SRS-600",SmallIconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_SRS600',SmallIconCoords=(X1=0,Y1=0,X2=127,Y2=31),InventoryGroup=7,BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_SRS600',InventorySize=7,bIsBW=True)
	 Weapons(24)=(ClassName="BallisticProV55Recolors.MGLLauncher",ItemName="MGL",SmallIconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_MGL',SmallIconCoords=(X1=0,Y1=0,X2=127,Y2=35),InventoryGroup=8,BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_MGL',InventorySize=0,bIsBW=True)
     Weapons(25)=(ClassName="BallisticProV55.G5Bazooka",ItemName="Bazooka",SmallIconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_G5',SmallIconCoords=(X1=0,Y1=0,X2=127,Y2=31),InventoryGroup=8,BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_G5',InventorySize=0,bIsBW=True)
     Weapons(26)=(ClassName="BallisticProV55.NRP57Grenade",ItemName="NRP57",SmallIconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_NRP57',SmallIconCoords=(X1=0,Y1=0,X2=127,Y2=31),InventoryGroup=8,BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_NRP57',InventorySize=0,bIsBW=True)
}
