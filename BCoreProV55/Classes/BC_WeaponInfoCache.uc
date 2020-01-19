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
     Weapons(0)=(ClassName="BallisticProV55.XK2SubMachinegun",ItemName="XK2 SubMachinegun",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_XK2',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=3,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_XK2',bIsBW=True)
     Weapons(1)=(ClassName="BallisticProV55.D49Revolver",ItemName="D49 Revolver",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_D49',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_D49',bIsBW=True)
     Weapons(2)=(ClassName="BallisticProV55.RS8Pistol",ItemName="RS8 10mm Pistol",SmallIconMaterial=Texture'BWAddPack-RS-Skins.RS8.SmallIcon_RS8',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_RS8',bIsBW=True)
     Weapons(3)=(ClassName="BallisticProV55.XRS10SubMachinegun",ItemName="XRS-10 Machine-Pistol",SmallIconMaterial=Texture'BWAddPack-RS-Skins.XRS10.SmallIcon_XRS10',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=3,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_XRS10',bIsBW=True)
     Weapons(4)=(ClassName="BallisticProV55.Fifty9MachinePistol",ItemName="Fifty-9 Machine-Pistol",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_Fifty9',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=3,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_Fifty9',bIsBW=True)
     Weapons(5)=(ClassName="BallisticProV55.M50AssaultRifle",ItemName="M50 Assault Rifle",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_M50',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_M50',bIsBW=True)
     Weapons(6)=(ClassName="BallisticProV55.M763Shotgun",ItemName="M763 Shotgun",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_M763',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=7,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_M763',bIsBW=True)
     Weapons(7)=(ClassName="BallisticProV55.M353Machinegun",ItemName="M353 Machinegun",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_M353',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=6,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_M353',bIsBW=True)
     Weapons(8)=(ClassName="BallisticProV55.M925Machinegun",ItemName="M925 Machinegun",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_M925',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=6,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_M925',bIsBW=True)
     Weapons(9)=(ClassName="BallisticProV55.G5Bazooka",ItemName="G5 RPG Launcher",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_G5',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=8,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_G5',bIsBW=True)
     Weapons(10)=(ClassName="BallisticProV55.R78Rifle",ItemName="R78A1 Sniper Rifle",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_R78',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=9,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_R78',bIsBW=True)
     Weapons(11)=(ClassName="BallisticProV55.MRS138Shotgun",ItemName="MRS138 Tactical Shotgun",SmallIconMaterial=Texture'BWAddPack-RS-Skins.MRS138.SmallIcon_MRS138',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=7,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_MRS138',bIsBW=True)
     Weapons(12)=(ClassName="BallisticProV55.NRP57Grenade",ItemName="NRP57 Pineapple",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_NRP57',SmallIconCoords=(X2=127,Y2=31),BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_NRP57',bIsBW=True)
     Weapons(13)=(ClassName="BallisticProV55.SARAssaultRifle",ItemName="Sub-Assault Rifle 12",SmallIconMaterial=Texture'BallisticTextures3.ui.SmallIcon_SAR12',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticTextures3.ui.BigIcon_SAR12',InventorySize=7,bIsBW=True)
     Weapons(14)=(ClassName="BallisticProV55.GRS9Pistol",ItemName="GRS-9 Pistol",SmallIconMaterial=Texture'BWBP4-Tex.Glock.SmallIcon_Glock',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BWBP4-Tex.Glock.BigIcon_Glock',InventorySize=3,bIsBW=True)
     Weapons(15)=(ClassName="BallisticProV55.MD24Pistol",ItemName="MD24 Pistol",SmallIconMaterial=Texture'BallisticTextures_25.MD24.SmallIcon_MD24',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticTextures_25.MD24.BigIcon_MD24',InventorySize=3,bIsBW=True)
     Weapons(16)=(ClassName="BallisticProV55.MarlinRifle",ItemName="Redwood 6000 'DeerMaster'",SmallIconMaterial=Texture'BWBP4-Tex.Marlin.SmallIcon_Marlin',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=9,BigIconMaterial=Texture'BWBP4-Tex.Marlin.BigIcon_Marlin',InventorySize=7,bIsBW=True)
     Weapons(17)=(ClassName="BallisticProV55.X4Knife",ItemName="X4 Knife",SmallIconMaterial=Texture'BallisticTextures_25.X4.SmallIcon_X4',SmallIconCoords=(X2=128,Y2=32),InventoryGroup=1,BigIconMaterial=Texture'BallisticTextures_25.X4.BigIcon_X4',InventorySize=2,bIsBW=True)
     Weapons(18)=(ClassName="BallisticProV55.XMK5SubMachinegun",ItemName="XMk5 Submachine Gun",SmallIconMaterial=Texture'BallisticTextures_25.OA-SMG.SmallIcon_OASMG',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=3,BigIconMaterial=Texture'BallisticTextures_25.OA-SMG.BigIcon_OASMG',InventorySize=7,bIsBW=True)
     Weapons(19)=(ClassName="BWBPOtherPackPro.PD97Bloodhound",ItemName="PD-97 'Bloodhound'",SmallIconMaterial=Texture'BWBPOtherPackTex.Bloodhound.Icon_PD97',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BWBPOtherPackTex.Bloodhound.BigIcon_PD97',InventorySize=3,bIsBW=True)
     Weapons(20)=(ClassName="BWBPRecolorsPro.AH208Pistol",ItemName="AH208 Golden Pistol",SmallIconMaterial=Texture'BallisticRecolors4TexPro.Eagle.SmallIcon_Eagle',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticRecolors4TexPro.Eagle.BigIcon_Eagle',InventorySize=8,bIsBW=True)
     Weapons(21)=(ClassName="BWBPRecolorsPro.AK47AssaultRifle",ItemName="AK-490 Battle Rifle",SmallIconMaterial=Texture'BallisticRecolors3TexPro.AK490.SmallIcon_AK490',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticRecolors3TexPro.AK490.BigIcon_AK490',InventorySize=7,bIsBW=True)
     Weapons(22)=(ClassName="BWBPRecolorsPro.F2000AssaultRifle",ItemName="MARS-3 'Snowstorm' XII",SmallIconMaterial=Texture'BallisticRecolors4TexPro.MARS.SmallIcon_F2000Alt',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticRecolors4TexPro.MARS.BigIcon_F2000Alt',InventorySize=7,bIsBW=True)
     Weapons(23)=(ClassName="BWBPRecolorsPro.LK05Carbine",ItemName="LK-05 Advanced Carbine",SmallIconMaterial=Texture'BallisticRecolors4TexPro.LK05.SmallIcon_LK05',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticRecolors4TexPro.LK05.BigIcon_LK05',InventorySize=7,bIsBW=True)
     Weapons(24)=(ClassName="BWBPRecolorsPro.MGLauncher",ItemName="Conqueror MGL",SmallIconMaterial=Texture'BallisticRecolors4TexPro.MGL.SmallIcon_MGL',SmallIconCoords=(X2=127,Y2=35),InventoryGroup=8,BigIconMaterial=Texture'BallisticRecolors4TexPro.MGL.BigIcon_MGL',InventorySize=7,bIsBW=True)
     Weapons(25)=(ClassName="BWBPRecolorsPro.SKASShotgun",ItemName="SKAS-21 Automatic Shotgun",SmallIconMaterial=Texture'BallisticRecolors3TexPro.SKAS.SmallIcon_SKAS',SmallIconCoords=(X2=127,Y2=30),InventoryGroup=7,BigIconMaterial=Texture'BallisticRecolors3TexPro.SKAS.BigIcon_SKAS',InventorySize=7,bIsBW=True)
     Weapons(26)=(ClassName="BWBPRecolorsPro.X82Rifle",ItemName="X83 Sniper Rifle",SmallIconMaterial=Texture'BallisticRecolors3TexPro.X82.SmallIcon_X82',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=9,BigIconMaterial=Texture'BallisticRecolors3TexPro.X82.BigIcon_X82',InventorySize=7,bIsBW=True)
     Weapons(27)=(ClassName="BallisticProV55.M46AssaultRifleQS",ItemName="M46 Red Dot Sight",SmallIconMaterial=Texture'BallisticTextures_25.OA-AR.SmallIcon_OAAR',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticTextures_25.OA-AR.BigIcon_OAAR',InventorySize=7,bIsBW=True)
     Weapons(28)=(ClassName="BWBPRecolorsPro.SK410Shotgun",ItemName="SK-410 Assault Shotgun",SmallIconMaterial=Texture'BallisticRecolors3TexPro.SK410.SmallIcon_SK410',SmallIconCoords=(X2=127,Y2=35),InventoryGroup=7,BigIconMaterial=Texture'BallisticRecolors3TexPro.SK410.BigIcon_SK410',InventorySize=7,bIsBW=True)
     Weapons(29)=(ClassName="BallisticProV55.R9RangerRifle",ItemName="R9 Ranger Rifle",SmallIconMaterial=Texture'BallisticTextures3.ui.SmallIcon_R9',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=9,BigIconMaterial=Texture'BallisticTextures3.ui.BigIcon_R9',InventorySize=7,bIsBW=True)
}
