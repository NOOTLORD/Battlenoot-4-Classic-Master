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
     Weapons(0)=(ClassName="BallisticProV55.X3Knife",ItemName="X3 Knife",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_X3',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=1,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_X3',InventorySize=2,bIsBW=True)
     Weapons(1)=(ClassName="BallisticProV55.A909SkrithBlades",ItemName="A909 Skrith Blades",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_A909',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=1,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_A909',InventorySize=2,bIsBW=True)
     Weapons(2)=(ClassName="BallisticProV55.EKS43Katana",ItemName="EKS43 Katana",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_EKS43',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=1,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_EKS43',InventorySize=2,bIsBW=True)
     Weapons(3)=(ClassName="BallisticProV55.M806Pistol",ItemName="M806A2 Pistol",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_M806',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_M806',bIsBW=True)
     Weapons(4)=(ClassName="BallisticProV55.A42SkrithPistol",ItemName="A42 Skrith Sidearm",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_A42',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_A42',bIsBW=True)
     Weapons(5)=(ClassName="BallisticProV55.MRT6Shotgun",ItemName="MRT6 Shotgun",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_MRT6',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=7,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_MRT6',bIsBW=True)
     Weapons(6)=(ClassName="BallisticProV55.XK2SubMachinegun",ItemName="XK2 SubMachinegun",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_XK2',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=3,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_XK2',bIsBW=True)
     Weapons(7)=(ClassName="BallisticProV55.D49Revolver",ItemName="D49 Revolver",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_D49',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_D49',bIsBW=True)
     Weapons(8)=(ClassName="BallisticProV55.RS8Pistol",ItemName="RS8 10mm Pistol",SmallIconMaterial=Texture'BWAddPack-RS-Skins.RS8.SmallIcon_RS8',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_RS8',bIsBW=True)
     Weapons(9)=(ClassName="BallisticProV55.XRS10SubMachinegun",ItemName="XRS-10 Machine-Pistol",SmallIconMaterial=Texture'BWAddPack-RS-Skins.XRS10.SmallIcon_XRS10',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=3,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_XRS10',bIsBW=True)
     Weapons(10)=(ClassName="BallisticProV55.Fifty9MachinePistol",ItemName="Fifty-9 Machine-Pistol",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_Fifty9',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=3,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_Fifty9',bIsBW=True)
     Weapons(11)=(ClassName="BallisticProV55.AM67Pistol",ItemName="AM67 Assault Pistol",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_AM67',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_AM67',bIsBW=True)
     Weapons(12)=(ClassName="BallisticProV55.M50AssaultRifle",ItemName="M50 Assault Rifle",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_M50',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_M50',bIsBW=True)
     Weapons(13)=(ClassName="BallisticProV55.M763Shotgun",ItemName="M763 Shotgun",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_M763',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=7,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_M763',bIsBW=True)
     Weapons(14)=(ClassName="BallisticProV55.A73SkrithRifle",ItemName="A73 Skrith Rifle",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_A73',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=5,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_A73',bIsBW=True)
     Weapons(15)=(ClassName="BallisticProV55.M353Machinegun",ItemName="M353 Machinegun",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_M353',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=6,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_M353',bIsBW=True)
     Weapons(16)=(ClassName="BallisticProV55.M925Machinegun",ItemName="M925 Machinegun",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_M925',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=6,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_M925',bIsBW=True)
     Weapons(17)=(ClassName="BallisticProV55.G5Bazooka",ItemName="G5 RPG Launcher",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_G5',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=8,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_G5',bIsBW=True)
     Weapons(18)=(ClassName="BallisticProV55.R78Rifle",ItemName="R78A1 Sniper Rifle",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_R78',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=9,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_R78',bIsBW=True)
     Weapons(19)=(ClassName="BallisticProV55.M75Railgun",ItemName="M75-TIC Railgun",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_M75',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=9,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_M75',bIsBW=True)
     Weapons(20)=(ClassName="BallisticProV55.M290Shotgun",ItemName="M290 Shotgun",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_M290',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=7,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_M290',InventorySize=18,bIsBW=True)
     Weapons(21)=(ClassName="BallisticProV55.MRS138Shotgun",ItemName="MRS138 Tactical Shotgun",SmallIconMaterial=Texture'BWAddPack-RS-Skins.MRS138.SmallIcon_MRS138',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=7,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_MRS138',bIsBW=True)
     Weapons(22)=(ClassName="BallisticProV55.SRS900Rifle",ItemName="SRS-900 Battle Rifle",SmallIconMaterial=Texture'BWBP3-Tex.SRS900.SmallIcon_SRS900',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=9,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_SRS900',bIsBW=True)
     Weapons(23)=(ClassName="BallisticProV55.HVCMk9LightningGun",ItemName="HVC-Mk9 Lightning Gun",SmallIconMaterial=Texture'BWBP2-Tex.Lighter.SmallIcon_LG',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=5,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_HVCMk9',InventorySize=18,bIsBW=True)
     Weapons(24)=(ClassName="BallisticProV55.RX22AFlamer",ItemName="RX22A Flame Thrower",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_RX22A',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=8,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_RX22A',InventorySize=10,bIsBW=True)
     Weapons(25)=(ClassName="BallisticProV55.XMV850Minigun",ItemName="XMV-850 Minigun",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_XMV850',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=6,BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_XMV850',InventorySize=8,bIsBW=True)
     Weapons(26)=(ClassName="BallisticProV55.NRP57Grenade",ItemName="NRP57 Pineapple",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_NRP57',SmallIconCoords=(X2=127,Y2=31),BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_NRP57',bIsBW=True)
     Weapons(27)=(ClassName="BallisticProV55.FP7Grenade",ItemName="FP7 Grenade",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_FP7',SmallIconCoords=(X2=127,Y2=31),BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_FP7',bIsBW=True)
     Weapons(28)=(ClassName="BallisticProV55.FP9Explosive",ItemName="FP9A5 Explosive Device",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_FP9Explosive',SmallIconCoords=(X2=127,Y2=31),BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_FP9A5',bIsBW=True)
     Weapons(29)=(ClassName="BallisticProV55.BX5Mine",ItemName="BX5-SM Land Mine",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_BX5',SmallIconCoords=(X2=127,Y2=31),BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_BX5',bIsBW=True)
     Weapons(30)=(ClassName="BallisticProV55.T10Grenade",ItemName="T10 Toxic Grenade",SmallIconMaterial=Texture'BallisticUI2.Icons.SmallIcon_T10',SmallIconCoords=(X2=127,Y2=31),BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_T10',bIsBW=True)
     Weapons(31)=(ClassName="BallisticProV55.SARAssaultRifle",ItemName="Sub-Assault Rifle 12",SmallIconMaterial=Texture'BallisticTextures3.ui.SmallIcon_SAR12',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticTextures3.ui.BigIcon_SAR12',InventorySize=7,bIsBW=True)
     Weapons(32)=(ClassName="BallisticProV55.BOGPPistol",ItemName="BORT-85 Grenade Pistol",SmallIconMaterial=Texture'BallisticTextures_25.BOGP.SmallIcon_BOGP',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticTextures_25.BOGP.BigIcon_BOGP',InventorySize=3,bIsBW=True)
     Weapons(33)=(ClassName="BallisticProV55.GRS9Pistol",ItemName="GRS-9 Pistol",SmallIconMaterial=Texture'BWBP4-Tex.Glock.SmallIcon_Glock',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BWBP4-Tex.Glock.BigIcon_Glock',InventorySize=3,bIsBW=True)
     Weapons(34)=(ClassName="BallisticProV55.M46AssaultRifle",ItemName="M46A1 Combat Rifle",SmallIconMaterial=Texture'BallisticTextures_25.OA-AR.SmallIcon_OAAR',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticTextures_25.OA-AR.BigIcon_OAAR',InventorySize=7,bIsBW=True)
     Weapons(35)=(ClassName="BallisticProV55.MD24Pistol",ItemName="MD24 Pistol",SmallIconMaterial=Texture'BallisticTextures_25.MD24.SmallIcon_MD24',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticTextures_25.MD24.BigIcon_MD24',InventorySize=3,bIsBW=True)
     Weapons(36)=(ClassName="BallisticProV55.MarlinRifle",ItemName="Redwood 6000 'DeerMaster'",SmallIconMaterial=Texture'BWBP4-Tex.Marlin.SmallIcon_Marlin',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=9,BigIconMaterial=Texture'BWBP4-Tex.Marlin.BigIcon_Marlin',InventorySize=7,bIsBW=True)
     Weapons(37)=(ClassName="BallisticProV55.X4Knife",ItemName="X4 Knife",SmallIconMaterial=Texture'BallisticTextures_25.X4.SmallIcon_X4',SmallIconCoords=(X2=128,Y2=32),InventoryGroup=1,BigIconMaterial=Texture'BallisticTextures_25.X4.BigIcon_X4',InventorySize=2,bIsBW=True)
     Weapons(38)=(ClassName="BallisticProV55.XMK5SubMachinegun",ItemName="XMk5 Submachine Gun",SmallIconMaterial=Texture'BallisticTextures_25.OA-SMG.SmallIcon_OASMG',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=3,BigIconMaterial=Texture'BallisticTextures_25.OA-SMG.BigIcon_OASMG',InventorySize=7,bIsBW=True)
     Weapons(39)=(ClassName="BWBPAirstrikesPro.X93Painter",ItemName="X-93A Orbital Weapon Designator",SmallIconMaterial=Texture'HUDContent.Generic.HUD',SmallIconCoords=(Y1=407,X2=118,Y2=442))
     Weapons(40)=(ClassName="BWBPOtherPackPro.CX61AssaultRifle",ItemName="CX61 Tactical Rifle",SmallIconMaterial=Texture'BWBPOtherPackTex.CX61.Icon_CX61',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BWBPOtherPackTex.CX61.BigIcon_CX61',InventorySize=7,bIsBW=True)
     Weapons(41)=(ClassName="BWBPOtherPackPro.DefibFists",ItemName="FMD H14 Combat Defibrillator",SmallIconMaterial=Texture'BWBPOtherPackTex.DefibFists.Icon_DefibFists',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=1,BigIconMaterial=Texture'BWBPOtherPackTex.DefibFists.BigIcon_DefibFists',InventorySize=3,bIsBW=True)
     Weapons(42)=(ClassName="BWBPOtherPackPro.PD97Bloodhound",ItemName="PD-97 'Bloodhound'",SmallIconMaterial=Texture'BWBPOtherPackTex.Bloodhound.Icon_PD97',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BWBPOtherPackTex.Bloodhound.BigIcon_PD97',InventorySize=3,bIsBW=True)
     Weapons(43)=(ClassName="BWBPOtherPackPro.ProtonStreamer",ItemName="E90-N Particle Accelerator",SmallIconMaterial=Texture'BWBPOtherPackTex2.ProtonPack.Icon_ProtonPack',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=5,BigIconMaterial=Texture'BWBPOtherPackTex2.ProtonPack.BigIcon_ProtonPack',InventorySize=7,bIsBW=True)
     Weapons(44)=(ClassName="BWBPOtherPackPro.R9A1RangerRifle",ItemName="R9A1 Ranger Rifle",SmallIconMaterial=Texture'BWBPOtherPackTex2.R9A1.SmallIcon_R9A1',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=9,BigIconMaterial=Texture'BWBPOtherPackTex2.R9A1.BigIcon_R9A1',InventorySize=7,bIsBW=True)
     Weapons(45)=(ClassName="BWBPRecolorsPro.A49SkrithBlaster",ItemName="A49 Skrith Blaster",SmallIconMaterial=Texture'BallisticRecolors3TexPro.A6.SmallIcon_A49',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticRecolors3TexPro.A6.BigIcon_A49',InventorySize=7,bIsBW=True)
     Weapons(46)=(ClassName="BWBPRecolorsPro.AH208Pistol",ItemName="AH208 Golden Pistol",SmallIconMaterial=Texture'BallisticRecolors4TexPro.Eagle.SmallIcon_Eagle',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticRecolors4TexPro.Eagle.BigIcon_Eagle',InventorySize=8,bIsBW=True)
     Weapons(47)=(ClassName="BWBPRecolorsPro.AK47AssaultRifle",ItemName="AK-490 Battle Rifle",SmallIconMaterial=Texture'BallisticRecolors3TexPro.AK490.SmallIcon_AK490',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticRecolors3TexPro.AK490.BigIcon_AK490',InventorySize=7,bIsBW=True)
     Weapons(48)=(ClassName="BWBPRecolorsPro.CYLOUAW",ItemName="CYLO Assault Weapon",SmallIconMaterial=Texture'BallisticRecolors3TexPro.CYLO.SmallIcon_CYLO',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticRecolors3TexPro.CYLO.BigIcon_CYLO',InventorySize=7,bIsBW=True)
     Weapons(49)=(ClassName="BWBPRecolorsPro.DragonsToothSword",ItemName="XM300 Dragon Nanoblade",SmallIconMaterial=Texture'BallisticRecolors3TexPro.DragonToothSword.SmallIcon_DTS',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=1,BigIconMaterial=Texture'BallisticRecolors3TexPro.DragonToothSword.BigIcon_DTS',InventorySize=2,bIsBW=True)
     Weapons(50)=(ClassName="BWBPRecolorsPro.F2000AssaultRifle",ItemName="MARS-3 'Snowstorm' XII",SmallIconMaterial=Texture'BallisticRecolors4TexPro.MARS.SmallIcon_F2000Alt',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticRecolors4TexPro.MARS.BigIcon_F2000Alt',InventorySize=7,bIsBW=True)
     Weapons(51)=(ClassName="BWBPRecolorsPro.G28Grenade",ItemName="FMD G28 Medicinal Aerosol",SmallIconMaterial=Texture'BallisticRecolors3TexPro.G28.SmallIcon_G28',SmallIconCoords=(X2=127,Y2=31),BigIconMaterial=Texture'BallisticRecolors3TexPro.G28.BigIcon_G28',InventorySize=4,bIsBW=True)
     Weapons(52)=(ClassName="BWBPRecolorsPro.ICISStimpack",ItemName="FMD ICIS-25 Stimpack",SmallIconMaterial=Texture'BallisticRecolors4TexPro.Stim.SmallIcon_Stim',SmallIconCoords=(X2=128,Y2=32),BigIconMaterial=Texture'BallisticRecolors4TexPro.Stim.BigIcon_Stim',InventorySize=2,bIsBW=True)
     Weapons(53)=(ClassName="BWBPRecolorsPro.LK05Carbine",ItemName="LK-05 Advanced Carbine",SmallIconMaterial=Texture'BallisticRecolors4TexPro.LK05.SmallIcon_LK05',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticRecolors4TexPro.LK05.BigIcon_LK05',InventorySize=7,bIsBW=True)
     Weapons(54)=(ClassName="BWBPRecolorsPro.LonghornLauncher",ItemName="Longhorn Repeater",SmallIconMaterial=Texture'BallisticRecolors4TexPro.Longhorn.SmallIcon_LHorn',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=8,BigIconMaterial=Texture'BallisticRecolors4TexPro.Longhorn.BigIcon_LHorn',InventorySize=7,bIsBW=True)
     Weapons(55)=(ClassName="BWBPRecolorsPro.MGLauncher",ItemName="Conqueror MGL",SmallIconMaterial=Texture'BallisticRecolors4TexPro.MGL.SmallIcon_MGL',SmallIconCoords=(X2=127,Y2=35),InventoryGroup=8,BigIconMaterial=Texture'BallisticRecolors4TexPro.MGL.BigIcon_MGL',InventorySize=7,bIsBW=True)
     Weapons(56)=(ClassName="BWBPRecolorsPro.MK781Shotgun",ItemName="MK781 Combat Shotgun",SmallIconMaterial=Texture'BallisticRecolors4TexPro.M1014.SmallIcon_M1014',SmallIconCoords=(X2=127,Y2=35),InventoryGroup=7,BigIconMaterial=Texture'BallisticRecolors4TexPro.M1014.BigIcon_M1014',InventorySize=7,bIsBW=True)
     Weapons(57)=(ClassName="BWBPRecolorsPro.MRDRMachinePistol",ItemName="MR-DR88 Machine Pistol",SmallIconMaterial=Texture'BallisticRecolors3TexPro.MRDR.SmallIcon_MRDR',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticRecolors3TexPro.MRDR.BigIcon_MRDR',InventorySize=3,bIsBW=True)
     Weapons(58)=(ClassName="BWBPRecolorsPro.PS9mPistol",ItemName="PS-9m Stealth Pistol",SmallIconMaterial=Texture'BallisticRecolors4TexPro.Stealth.SmallIcon_PS9M',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticRecolors4TexPro.Stealth.BigIcon_PS9M',InventorySize=3,bIsBW=True)
     Weapons(59)=(ClassName="BWBPRecolorsPro.SKASShotgun",ItemName="SKAS-21 Automatic Shotgun",SmallIconMaterial=Texture'BallisticRecolors3TexPro.SKAS.SmallIcon_SKAS',SmallIconCoords=(X2=127,Y2=30),InventoryGroup=7,BigIconMaterial=Texture'BallisticRecolors3TexPro.SKAS.BigIcon_SKAS',InventorySize=7,bIsBW=True)
     Weapons(60)=(ClassName="BWBPRecolorsPro.X82Rifle",ItemName="X83 Sniper Rifle",SmallIconMaterial=Texture'BallisticRecolors3TexPro.X82.SmallIcon_X82',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=9,BigIconMaterial=Texture'BallisticRecolors3TexPro.X82.BigIcon_X82',InventorySize=7,bIsBW=True)
     Weapons(61)=(ClassName="BWBPRecolorsPro.X8Knife",ItemName="X8 Ballistic Knife",SmallIconMaterial=Texture'BallisticRecolors3TexPro.SmallIcon_X8',SmallIconCoords=(X2=128,Y2=32),InventoryGroup=1,BigIconMaterial=Texture'BallisticRecolors3TexPro.BigIcon_X8',InventorySize=2,bIsBW=True)
     Weapons(62)=(ClassName="BWBPRecolorsPro.XM84Flashbang",ItemName="XM84 Heavy Tech Grenade",SmallIconMaterial=Texture'BallisticRecolors3TexPro.XM84.SmallIcon_XM84',SmallIconCoords=(X2=127,Y2=31),BigIconMaterial=Texture'BallisticRecolors3TexPro.XM84.BigIcon_XM84',InventorySize=3,bIsBW=True)
     Weapons(63)=(ClassName="BallisticProV55.M46AssaultRifleQS",ItemName="M46 Red Dot Sight",SmallIconMaterial=Texture'BallisticTextures_25.OA-AR.SmallIcon_OAAR',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticTextures_25.OA-AR.BigIcon_OAAR',InventorySize=7,bIsBW=True)
     Weapons(64)=(ClassName="BallisticProV55.M58Grenade",ItemName="M58 Smoke Grenade",SmallIconMaterial=Texture'BallisticProTextures.M58.SmallIcon_M58',SmallIconCoords=(X2=127,Y2=31),BigIconMaterial=Texture'BallisticProTextures.M58.BigIcon_M58',InventorySize=3,bIsBW=True)
     Weapons(65)=(ClassName="BallisticProV55.RiotShield",ItemName="Riot Shield",SmallIconMaterial=Texture'BallisticProTextures.Icons.Icon_JWRiot',SmallIconCoords=(X2=256,Y2=31),InventoryGroup=1,BigIconMaterial=Texture'BallisticProTextures.Misc.BigIcon_Shield',InventorySize=3,bIsBW=True)
     Weapons(66)=(ClassName="BWBPAirstrikesPro.TargetDesignator",ItemName="MAU-52 Target Designator",SmallIconMaterial=Texture'BWBPOtherPackTex.Designator.SmallIcon_Designator',SmallIconCoords=(X2=128,Y2=32),BigIconMaterial=Texture'BWBPOtherPackTex.Designator.BigIcon_Designator',InventorySize=7,bIsBW=True)
     Weapons(67)=(ClassName="BWBPOtherPackPro.AkeronLauncher",ItemName="AN-56 Akeron Launcher",SmallIconMaterial=Texture'BWBPOtherPackTex3.Akeron.Icon_Akeron',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=8,BigIconMaterial=Texture'BWBPOtherPackTex3.Akeron.BigIcon_Akeron',InventorySize=7,bIsBW=True)
     Weapons(68)=(ClassName="BWBPOtherPackPro.BX85Crossbow",ItemName="BX85 Stealth Crossbow",SmallIconMaterial=Texture'BWBPOtherPackTex2.XBow.Icon_Crossbow',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BWBPOtherPackTex2.XBow.BigIcon_Crossbow',InventorySize=7,bIsBW=True)
     Weapons(69)=(ClassName="BWBPOtherPackPro.CX85AssaultWeapon",ItemName="CX85 Combat Rifle",SmallIconMaterial=Texture'BWBPOtherPackTex3.CX85.SmallIcon_CX85',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=9,BigIconMaterial=Texture'BWBPOtherPackTex3.CX85.BigIcon_CX85',InventorySize=7,bIsBW=True)
     Weapons(70)=(ClassName="BWBPOtherPackPro.M575Machinegun",ItemName="M575 Light Machine Gun",SmallIconMaterial=Texture'BWBPOtherPackTex2.M575.SmallIcon_M575',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=6,BigIconMaterial=Texture'BWBPOtherPackTex2.M575.BigIcon_M575',InventorySize=7,bIsBW=True)
     Weapons(71)=(ClassName="BWBPOtherPackPro.Raygun",ItemName="E58 Raygun",SmallIconMaterial=Texture'BWBPOtherPackTex.Raygun.raygun_icon_128',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=5,BigIconMaterial=Texture'BWBPOtherPackTex.Raygun.raygun_icon_512',InventorySize=7,bIsBW=True)
     Weapons(72)=(ClassName="BWBPOtherPackPro.WrenchWarpDevice",ItemName="NFUD Combat Wrench",SmallIconMaterial=Texture'BWBPOtherPackTex.Wrench.Icon_Wrench',SmallIconCoords=(X2=128,Y2=32),InventoryGroup=1,BigIconMaterial=Texture'BWBPOtherPackTex.Wrench.BigIcon_Wrench',InventorySize=2,bIsBW=True)
     Weapons(73)=(ClassName="BWBPOtherPackPro.XOXOStaff",ItemName="Le Big XOXO",SmallIconMaterial=Texture'BWBPOtherPackTex.XOXO.SmallIcon_XOXO',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=5,BigIconMaterial=Texture'BWBPOtherPackTex.XOXO.BigIcon_XOXO',InventorySize=7,bIsBW=True)
     Weapons(74)=(ClassName="BWBPOtherPackPro.Z250Minigun",ItemName="Z-250 Minigun",SmallIconMaterial=Texture'BWBPOtherPackTex2.Z250.Icon_Z250',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=6,BigIconMaterial=Texture'BWBPOtherPackTex2.Z250.BigIcon_Z250',InventorySize=8,bIsBW=True)
     Weapons(75)=(ClassName="BWBPRecolorsPro.AH250Pistol",ItemName="AH250 Assault Pistol",SmallIconMaterial=Texture'BallisticRecolors4TexPro.Eagle.SmallIcon_EagleAlt',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BallisticRecolors4TexPro.Eagle.BigIcon_EagleAlt',InventorySize=4,bIsBW=True)
     Weapons(76)=(ClassName="BWBPRecolorsPro.AS50Rifle",ItemName="FSSG-50 Marksman Rifle",SmallIconMaterial=Texture'BallisticRecolors3TexPro.FSG50.SmallIcon_FSG50',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=9,BigIconMaterial=Texture'BallisticRecolors3TexPro.FSG50.BigIcon_FSG50',InventorySize=7,bIsBW=True)
     Weapons(77)=(ClassName="BWBPRecolorsPro.BulldogAssaultCannon",ItemName="Bulldog Autocannon",SmallIconMaterial=Texture'BallisticRecolors3TexPro.Bulldog.SmallIcon_Bulldog',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=8,BigIconMaterial=Texture'BallisticRecolors3TexPro.Bulldog.BigIcon_Bulldog',InventorySize=7,bIsBW=True)
     Weapons(78)=(ClassName="BWBPRecolorsPro.CYLOAssaultWeapon",ItemName="CYLO Firestorm V",SmallIconMaterial=Texture'BallisticRecolors3TexPro.CYLO.SmallIcon_CYLOMk2',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticRecolors3TexPro.CYLO.BigIcon_CYLOMk2',InventorySize=7,bIsBW=True)
     Weapons(79)=(ClassName="BWBPRecolorsPro.ChaffGrenadeWeapon",ItemName="MOA-C Chaff Grenade",SmallIconMaterial=Texture'BallisticRecolors3TexPro.M4A1.SmallIcon_MOAC',SmallIconCoords=(X2=127,Y2=31),BigIconMaterial=Texture'BallisticRecolors3TexPro.M4A1.BigIcon_MOAC',InventorySize=3,bIsBW=True)
     Weapons(80)=(ClassName="BWBPRecolorsPro.CoachGun",ItemName="Redwood Coach Gun",SmallIconMaterial=Texture'BallisticRecolors4TexPro.CoachGun.SmallIcon_Coach',SmallIconCoords=(X2=127,Y2=40),InventoryGroup=7,BigIconMaterial=Texture'BallisticRecolors4TexPro.CoachGun.BigIcon_Coach',InventorySize=7,bIsBW=True)
     Weapons(81)=(ClassName="BWBPRecolorsPro.FG50MachineGun",ItemName="FG50 Heavy Machinegun",SmallIconMaterial=Texture'BallisticRecolors3TexPro.FG50.SmallIcon_FG50',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=6,BigIconMaterial=Texture'BallisticRecolors3TexPro.FG50.BigIcon_FG50',InventorySize=7,bIsBW=True)
     Weapons(82)=(ClassName="BWBPRecolorsPro.FLASHLauncher",ItemName="AT40 STREAK",SmallIconMaterial=Texture'BallisticRecolors4TexPro.Flash.SmallIcon_FLASH',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=8,BigIconMaterial=Texture'BallisticRecolors4TexPro.Flash.BigIcon_FLASH',InventorySize=18,bIsBW=True)
     Weapons(83)=(ClassName="BWBPRecolorsPro.HVPCMk66PlasmaCannon",ItemName="E-V Plasma Cannon 9000",SmallIconMaterial=Texture'BallisticRecolors3TexPro.BFG.SmallIcon_BFG',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=5,BigIconMaterial=Texture'BallisticRecolors3TexPro.BFG.BigIcon_BFG',InventorySize=21,bIsBW=True)
     Weapons(84)=(ClassName="BWBPRecolorsPro.LAWLauncher",ItemName="FGM-70 'Shockwave' LAW",SmallIconMaterial=Texture'BallisticRecolors4TexPro.LAW.SmallIcon_LAW',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=8,BigIconMaterial=Texture'BallisticRecolors4TexPro.LAW.BigIcon_LAW',InventorySize=18,bIsBW=True)
     Weapons(85)=(ClassName="BWBPRecolorsPro.LS14Carbine",ItemName="LS-14 Laser Rifle",SmallIconMaterial=Texture'BallisticRecolors3TexPro.LS14.SmallIcon_LS14',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=9,BigIconMaterial=Texture'BallisticRecolors3TexPro.LS14.BigIcon_LS14',InventorySize=7,bIsBW=True)
     Weapons(86)=(ClassName="BWBPRecolorsPro.M2020GaussDMR",ItemName="M2020 Gauss Rifle",SmallIconMaterial=Texture'BallisticRecolors4TexPro.M2020.SmallIcon_M2020',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=9,BigIconMaterial=Texture'BallisticRecolors4TexPro.M2020.BigIcon_M2020',InventorySize=7,bIsBW=True)
     Weapons(87)=(ClassName="BWBPRecolorsPro.MARSAssaultRifle",ItemName="MARS-2 Assault Rifle",SmallIconMaterial=Texture'BallisticRecolors4TexPro.MARS.SmallIcon_F2000',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticRecolors4TexPro.MARS.BigIcon_F2000',InventorySize=7,bIsBW=True)
     Weapons(88)=(ClassName="BWBPRecolorsPro.SK410Shotgun",ItemName="SK-410 Assault Shotgun",SmallIconMaterial=Texture'BallisticRecolors3TexPro.SK410.SmallIcon_SK410',SmallIconCoords=(X2=127,Y2=35),InventoryGroup=7,BigIconMaterial=Texture'BallisticRecolors3TexPro.SK410.BigIcon_SK410',InventorySize=7,bIsBW=True)
     Weapons(89)=(ClassName="BallisticProV55.A500Reptile",ItemName="A500 'Reptile' Acid Gun",SmallIconMaterial=Texture'BallisticTextures_25.Reptile.SmallIcon_Reptile',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=7,BigIconMaterial=Texture'BallisticTextures_25.Reptile.BigIcon_Reptile',InventorySize=7,bIsBW=True)
     Weapons(90)=(ClassName="BallisticProV55.E23PlasmaRifle",ItemName="E-23 'ViPeR' Plasma Rifle",SmallIconMaterial=Texture'BWBP4-Tex.VPR.SmallIcon_VPR',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=5,BigIconMaterial=Texture'BWBP4-Tex.VPR.BigIcon_VPR',InventorySize=7,bIsBW=True)
     Weapons(91)=(ClassName="BallisticProV55.MACWeapon",ItemName="Heavy Anti-Materiel Rifle",SmallIconMaterial=Texture'BWBP4-Tex.Artillery.SmallIcon_Artillery',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=8,BigIconMaterial=Texture'BWBP4-Tex.Artillery.BigIcon_Artillery',InventorySize=16,bIsBW=True)
     Weapons(92)=(ClassName="BallisticProV55.MRocketLauncher",ItemName="JL21-MRL PeaceMaker",SmallIconMaterial=Texture'BWBP4-Tex.MRL.SmallIcon_MRL',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=8,BigIconMaterial=Texture'BWBP4-Tex.MRL.BigIcon_MRL',InventorySize=18,bIsBW=True)
     Weapons(93)=(ClassName="BallisticProV55.R9RangerRifle",ItemName="R9 Ranger Rifle",SmallIconMaterial=Texture'BallisticTextures3.ui.SmallIcon_R9',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=9,BigIconMaterial=Texture'BallisticTextures3.ui.BigIcon_R9',InventorySize=7,bIsBW=True)
     Weapons(94)=(ClassName="BallisticProV55.RSDarkStar",ItemName="Dark Star",SmallIconMaterial=Texture'BWBP4-Tex.DarkStar.SmallIcon_DarkStar',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=5,BigIconMaterial=Texture'BWBP4-Tex.DarkStar.BigIcon_DarkStar',InventorySize=7,bIsBW=True)
     Weapons(95)=(ClassName="BallisticProV55.RSNovaStaff",ItemName="Nova Staff",SmallIconMaterial=Texture'BWBP4-Tex.NovaStaff.SmallIcon_NovaStaff',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=5,BigIconMaterial=Texture'BWBP4-Tex.NovaStaff.BigIcon_NovaStaff',InventorySize=7,bIsBW=True)
     Weapons(96)=(ClassName="BallisticProV55.RandomWeaponDummy",ItemName="Random Weapon",InventoryGroup=99,InventorySize=7,bIsBW=True)
     Weapons(97)=(ClassName="BallisticProV55.SRS600Rifle",ItemName="SRS-600 Battle Rifle",SmallIconMaterial=Texture'BallisticProTextures.SRS.SmallIcon_SRSM2',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=4,BigIconMaterial=Texture'BallisticProTextures.SRS.BigIcon_SRSM2',InventorySize=7,bIsBW=True)
     Weapons(98)=(ClassName="BallisticProV55.SandbagLayer",ItemName="Sandbags",SmallIconMaterial=Texture'BallisticProTextures.Sandbags.SmallIcon_Sandbags',SmallIconCoords=(X2=127,Y2=31),BigIconMaterial=Texture'BallisticProTextures.Sandbags.Icon_Sandbags',InventorySize=2,bIsBW=True)
     Weapons(99)=(ClassName="BallisticProV55.leMatRevolver",ItemName="Wilson 41",SmallIconMaterial=Texture'BWBP4-Tex.leMat.SmallIcon_Wilson41DB',SmallIconCoords=(X2=127,Y2=31),InventoryGroup=2,BigIconMaterial=Texture'BWBP4-Tex.leMat.BigIcon_Wilson41DB',InventorySize=3,bIsBW=True)
     Weapons(100)=(ClassName="Onslaught.ONSAVRiL",ItemName="AVRiL",SmallIconMaterial=Texture'HUDContent.Generic.HUD',SmallIconCoords=(X1=429,Y1=212,X2=508,Y2=251),InventoryGroup=8)
     Weapons(101)=(ClassName="Onslaught.ONSGrenadeLauncher",ItemName="Grenade Launcher",SmallIconMaterial=Texture'HUDContent.Generic.HUD',SmallIconCoords=(X1=434,Y1=253,X2=506,Y2=292),InventoryGroup=7)
     Weapons(102)=(ClassName="Onslaught.ONSMineLayer",ItemName="Mine Layer",SmallIconMaterial=Texture'HUDContent.Generic.HUD',SmallIconCoords=(X1=229,Y1=258,X2=296,Y2=307),InventoryGroup=3)
     Weapons(103)=(ClassName="OnslaughtFull.ONSPainter",ItemName="Target Painter",SmallIconMaterial=Texture'HUDContent.Generic.HUD',SmallIconCoords=(Y1=407,X2=118,Y2=442))
     Weapons(104)=(ClassName="UTClassic.ClassicSniperRifle",ItemName="Sniper Rifle",SmallIconMaterial=Texture'HUDContent.Generic.HUD',SmallIconCoords=(X1=420,Y1=180,X2=512,Y2=210),InventoryGroup=9)
     Weapons(105)=(ClassName="XWeapons.AssaultRifle",ItemName="Assault Rifle",SmallIconMaterial=Texture'HUDContent.Generic.HUD',SmallIconCoords=(X1=245,Y1=39,X2=329,Y2=79),InventoryGroup=2)
     Weapons(106)=(ClassName="XWeapons.BioRifle",ItemName="Bio-Rifle",SmallIconMaterial=Texture'HUDContent.Generic.HUD',SmallIconCoords=(X1=179,Y1=127,X2=241,Y2=175),InventoryGroup=3)
     Weapons(107)=(ClassName="XWeapons.FlakCannon",ItemName="Flak Cannon",SmallIconMaterial=Texture'HUDContent.Generic.HUD',SmallIconCoords=(X1=169,Y1=172,X2=245,Y2=208),InventoryGroup=7)
     Weapons(108)=(ClassName="XWeapons.LinkGun",ItemName="Link Gun",SmallIconMaterial=Texture'HUDContent.Generic.HUD',SmallIconCoords=(X1=169,Y1=78,X2=244,Y2=124),InventoryGroup=5)
     Weapons(109)=(ClassName="XWeapons.Minigun",ItemName="Minigun",SmallIconMaterial=Texture'HUDContent.Generic.HUD',SmallIconCoords=(X1=246,Y1=80,X2=332,Y2=106),InventoryGroup=6)
     Weapons(110)=(ClassName="XWeapons.Painter",ItemName="Ion Painter",SmallIconMaterial=Texture'HUDContent.Generic.HUD',SmallIconCoords=(Y1=407,X2=118,Y2=442))
     Weapons(111)=(ClassName="XWeapons.Redeemer",ItemName="Redeemer",SmallIconMaterial=Texture'HUDContent.Generic.HUD',SmallIconCoords=(X1=4,Y1=350,X2=110,Y2=395))
     Weapons(112)=(ClassName="XWeapons.RocketLauncher",ItemName="Rocket Launcher",SmallIconMaterial=Texture'HUDContent.Generic.HUD',SmallIconCoords=(X1=253,Y1=146,X2=333,Y2=181),InventoryGroup=8)
     Weapons(113)=(ClassName="XWeapons.ShieldGun",ItemName="Shield Gun",SmallIconMaterial=Texture'HUDContent.Generic.HUD',SmallIconCoords=(X1=169,Y1=39,X2=241,Y2=77),InventoryGroup=1)
     Weapons(114)=(ClassName="XWeapons.ShockRifle",ItemName="Shock Rifle",SmallIconMaterial=Texture'HUDContent.Generic.HUD',SmallIconCoords=(X1=250,Y1=110,X2=330,Y2=145),InventoryGroup=4)
     Weapons(115)=(ClassName="XWeapons.SniperRifle",ItemName="Lightning Gun",SmallIconMaterial=Texture'HUDContent.Generic.HUD',SmallIconCoords=(X1=246,Y1=182,X2=331,Y2=210),InventoryGroup=9)
     Weapons(116)=(ClassName="XWeapons.Translauncher",ItemName="Translocator",SmallIconMaterial=Texture'HUDContent.Generic.HUD',SmallIconCoords=(X2=2,Y2=2),InventoryGroup=10)
}
