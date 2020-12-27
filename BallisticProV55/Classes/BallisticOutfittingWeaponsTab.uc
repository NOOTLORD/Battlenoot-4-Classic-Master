//=============================================================================
// BallisticOutfittingMenu.
//
// Menu for selecting weapon loadout. Consists of several categories, user can
// pick what weapon they want for each category (e.g. melee, sidearm, grenade)
//
// by Nolan "Dark Carnivour" Richert.
// Modified by Azarael
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class BallisticOutfittingWeaponsTab extends UT2K4TabPanel config(BallisticProV55);

// Use GUILoadOutItems to select weapons. This control has some text with an image that cycles when you click on it
var automated GUILoadOutItem Item_SideArm, Item_Primary, Item_Grenade;
var automated GUIComboBox	 cb_SideArm, cb_Primary, cb_Grenade;
var automated moComboBox	 cb_Presets;
var Automated GUIImage       Box_SideArm, Box_Primary, Box_Grenade, SideArmBack, PrimaryBack, GrenadeBack;
var Automated GUIButton BDone, BCancel, BSavePreset;
var automated GUILabel	l_Receiving;
var BallisticOutfittingMenu p_Anchor;

var config int CurrentIndex;
var config bool bInitialised;
var bool bWeaponsLoaded;

struct LoadoutWeapons
{
    var string PresetName;
	var string Weapons[5];
};

var() config array<LoadoutWeapons>			SavedLoadouts[5];  //Saved loadouts

struct WeaponItemInfo
{
	var string ItemCap;
	var Material ItemImage;
	var string ItemClassName;
	var IntBox ImageCoords;
	var int InventoryGroup;
};

var array<WeaponItemInfo> sortedPrimaries;

var int NumPresets;

var() localized string QuickListText;

var localized string ReceivingText[2];

var ClientOutfittinginterface COI;	// The ClientOutfittingInterface actor we can use to comunicate with the mutator

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.InitComponent(MyController, MyOwner);
	
	if(BallisticOutfittingMenu(Controller.ActivePage) != None)
	p_Anchor = BallisticOutfittingMenu(Controller.ActivePage);
}

function ShowPanel(bool bShow)
{
	local int i;
	
	super.ShowPanel(bShow);
	
	if (!bInitialised)
	{
		for(i=0;i<5;i++)
		SavedLoadouts[0].Weapons[i] = class'Mut_Outfitting'.default.LoadOut[i];
		bInitialised=True;
		SaveConfig();
	}
	
	if(!bWeaponsLoaded)
	{
		if (COI == None || COI.bWeaponsReady)
		{
			if (PlayerOwner().level.NetMode == NM_Client)
			{
				l_Receiving.Caption = ReceivingText[0];
				SetTimer(0.5, true);
			}
			else
			{
				l_Receiving.Caption = ReceivingText[1];
				SetTimer(0.1, true);
			}
		}
		else
		{
			LoadWeapons();
			bWeaponsLoaded=True;
		}
	
		cb_SideArm.List.bSorted=true;
		cb_Grenade.List.bSorted=true;
	}
}

event Timer()
{
	if (COI != None && COI.bWeaponsReady && !bWeaponsLoaded)
	{
		KillTimer();
		LoadWeapons();
		bWeaponsLoaded=True;
	}
}

function LoadWeapons()
{
	local int i;
	local string IC, ICN;
	local Material IMat;
	local IntBox ICrds;
	local int lastIndex;
	
	// Load the weapons into their GUILoadOutItems

	for(i=0;i<COI.GroupLength(1);i++)
	{
		if (GetItemInfo(1, i, IC, IMat, ICN, ICrds))
		{
			Item_SideArm.AddItem(IC, IMat, ICN, ICrds);
   			cb_SideArm.AddItem(IC, ,ICN);
   			cb_SideArm.SetText(QuickListText);
   		}
	}

	//=======================================================================
	// Special handling for primary and secondary slots.	
	//=======================================================================
	for(i=0;i<COI.GroupLength(2);i++)
		FillItemInfos(2, i);
		
	lastIndex = -1;
	
	for(i=0; i<sortedPrimaries.Length; i++)
	{
		if (sortedPrimaries[i].InventoryGroup > lastIndex)
		{
			lastIndex = sortedPrimaries[i].InventoryGroup;
			cb_Primary.MyListBox.List.Add(class'BallisticTab_OutfittingPro'.static.GetHeading(lastIndex),None,"",true);
		}
		
		Item_Primary.AddItem(
			sortedPrimaries[i].ItemCap, 
			sortedPrimaries[i].ItemImage, 
			sortedPrimaries[i].ItemClassName, 
			sortedPrimaries[i].ImageCoords
			);
		cb_Primary.AddItem(sortedPrimaries[i].ItemCap,  ,sortedPrimaries[i].ItemClassName);
		cb_Primary.SetText(QuickListText);
	}

	for(i=0;i<COI.GroupLength(4);i++)
	{
		if (GetItemInfo(4, i, IC, IMat, ICN, ICrds))
		{
			Item_Grenade.AddItem(IC, IMat, ICN, ICrds);
   			cb_Grenade.AddItem(IC, ,ICN);
   			cb_Grenade.SetText(QuickListText);
   		}
	}
	
	Item_SideArm.SetItem(SavedLoadOuts[CurrentIndex].Weapons[1]);
	Item_Primary.SetItem(SavedLoadOuts[CurrentIndex].Weapons[2]);
	Item_Grenade.SetItem(SavedLoadOuts[CurrentIndex].Weapons[4]);
	
	//Add Random and None forcibly as separate items here.
	
	//Load presets
	for(i=0;i<5;i++)
	    cb_Presets.AddItem(SavedLoadouts[i].PresetName ,,string(i));
	cb_Presets.SetIndex(Clamp(CurrentIndex, 0, 5));  
	
	class'BC_WeaponInfoCache'.static.EndSession();
	l_Receiving.Caption = "";
}

// Get Name, BigIconMaterial and classname of weapon at index? in group?
function bool GetItemInfo(int Group, int Index, out string ItemCap, out Material ItemImage, out string ItemClassName, optional out IntBox ImageCoords)
{
	local BC_WeaponInfoCache.WeaponInfo WI;
	local int i;

	if (COI.GetGroupItem(Group, Index) == "")
		return false;
	WI = class'BC_WeaponInfoCache'.static.AutoWeaponInfo(COI.GetGroupItem(Group, Index), i);
	if (i==-1)
	{
		log("Error loading item for outfitting: "$COI.GetGroupItem(Group, Index), 'Warning');
		return false;
	}
	ItemCap = WI.ItemName;
	ItemClassName = COI.GetGroupItem(Group, Index);
	if (WI.bIsBW)
	{
		ItemImage = WI.BigIconMaterial;
		ImageCoords.X1=-1; ImageCoords.X2=-1; ImageCoords.Y1=-1; ImageCoords.Y2=-1;
	}
	else
	{
		ItemImage = WI.SmallIconMaterial;
		ImageCoords = WI.SmallIconCoords;
	}
	return true;
}

// Get Name, BigIconMaterial and classname of weapon at index? in group?
function FillItemInfos(int Group, int Index)
{
	local BC_WeaponInfoCache.WeaponInfo WI;
	local int i;
	local WeaponItemInfo WInfo;

	if (COI.GetGroupItem(Group, Index) == "")
		return;
	WI = class'BC_WeaponInfoCache'.static.AutoWeaponInfo(COI.GetGroupItem(Group, Index), i);
	if (i==-1)
	{
		log("Error loading item for outfitting: "$COI.GetGroupItem(Group, Index), 'Warning');
		return;
	}
	WInfo.ItemCap = WI.ItemName;
	WInfo.InventoryGroup = WI.InventoryGroup;
	WInfo.ItemClassName = COI.GetGroupItem(Group, Index);
	if (WI.bIsBW)
	{
		WInfo.ItemImage = WI.BigIconMaterial;
		WInfo.ImageCoords.X1=-1; WInfo.ImageCoords.X2=-1; WInfo.ImageCoords.Y1=-1; WInfo.ImageCoords.Y2=-1;
	}
	else
	{
		WInfo.ItemImage = WI.SmallIconMaterial;
		WInfo.ImageCoords = WI.SmallIconCoords;
	}

	// Sort
	if (Group == 2)
	{
		if (sortedPrimaries.Length == 0)
			sortedPrimaries[sortedPrimaries.Length] = WInfo;
		else 
		{
			for (i = 0; i < sortedPrimaries.Length; ++i)
			{
				if (WInfo.InventoryGroup < sortedPrimaries[i].InventoryGroup)
				{
					sortedPrimaries.Insert(i, 1);
					sortedPrimaries[i] = WInfo;
					break;
				}
				
				if (WInfo.InventoryGroup == sortedPrimaries[i].InventoryGroup)
					if (StrCmp(WInfo.ItemCap, sortedPrimaries[i].ItemCap, 6, True) <= 0)
					{	
						sortedPrimaries.Insert(i, 1);
						sortedPrimaries[i] = WInfo;
						break;
					}

				if (i == sortedPrimaries.Length - 1)
				{
					sortedPrimaries[sortedPrimaries.Length] = WInfo;
					break;
				}
			}
		}
	}
}


function bool InternalOnKeyEvent(out byte Key, out byte State, float delta)
{
	return false;
}

function bool InternalOnClick(GUIComponent Sender)
{
    if (Sender==BSavePreset) //SAVE PRESET
	{
			SavedLoadouts[cb_Presets.GetIndex()].PresetName = cb_Presets.GetText();
		if (Item_SideArm.Items.length > Item_SideArm.Index)
			SavedLoadouts[cb_Presets.GetIndex()].Weapons[1] = Item_SideArm.Items[Item_SideArm.Index].Text;
		if (Item_Primary.Items.length > Item_Primary.Index)
			SavedLoadouts[cb_Presets.GetIndex()].Weapons[2] = Item_Primary.Items[Item_Primary.Index].Text;
		if (Item_Grenade.Items.length > Item_Grenade.Index)
			SavedLoadouts[cb_Presets.GetIndex()].Weapons[4] = Item_Grenade.Items[Item_Grenade.Index].Text;
		SaveConfig();	
	}
	return true;
}

function SaveWeapons()
{
		SavedLoadouts[cb_Presets.GetIndex()].PresetName = cb_Presets.GetText();
			
		if (Item_SideArm.Items.length > Item_SideArm.Index)
			SavedLoadouts[cb_Presets.GetIndex()].Weapons[1] = Item_SideArm.Items[Item_SideArm.Index].Text;
		if (Item_Primary.Items.length > Item_Primary.Index)
			SavedLoadouts[cb_Presets.GetIndex()].Weapons[2] = Item_Primary.Items[Item_Primary.Index].Text;
		if (Item_Grenade.Items.length > Item_Grenade.Index)
			SavedLoadouts[cb_Presets.GetIndex()].Weapons[4] = Item_Grenade.Items[Item_Grenade.Index].Text;

		if (Item_SideArm.Items.length > Item_SideArm.Index)
			class'Mut_Outfitting'.default.LoadOut[1] = Item_SideArm.Items[Item_SideArm.Index].Text;
		if (Item_Primary.Items.length > Item_Primary.Index)
			class'Mut_Outfitting'.default.LoadOut[2] = Item_Primary.Items[Item_Primary.Index].Text;
		if (Item_Grenade.Items.length > Item_Grenade.Index)
			class'Mut_Outfitting'.default.LoadOut[4] = Item_Grenade.Items[Item_Grenade.Index].Text;
		
		CurrentIndex=cb_Presets.GetIndex();
		
		SaveConfig();
		class'Mut_Outfitting'.static.StaticSaveConfig();
		
		//COI.LoadoutChanged(class'Mut_Outfitting'.default.LoadOut);
}

function InternalOnChange(GUIComponent Sender)
{
	if (COI == None || !COI.bWeaponsReady)
		return;
		
		
	else if (Sender == cb_SideArm)
		Item_SideArm.SetItem(cb_SideArm.GetExtra());
	else if (Sender == cb_Primary)
		Item_Primary.SetItem(cb_Primary.GetExtra());
	else if (Sender == cb_Grenade)
		Item_Grenade.SetItem(cb_Grenade.GetExtra());
		
	else if (Sender == cb_Presets && cb_Presets.GetExtra() != "")
	{
		Item_SideArm.SetItem(SavedLoadOuts[cb_Presets.GetIndex()].Weapons[1]);
		Item_Primary.SetItem(SavedLoadOuts[cb_Presets.GetIndex()].Weapons[2]);
		Item_Grenade.SetItem(SavedLoadOuts[cb_Presets.GetIndex()].Weapons[4]);
	}
}

defaultproperties
{
     Begin Object Class=GUILoadOutItem Name=SideArmImage
         NAImage=Texture'BallisticProUITex.Icons.BigIcon_NA'
         Caption="Sidearm"
         WinTop=0.035000
         WinLeft=0.400000
         WinWidth=0.200000
         WinHeight=0.200000
         OnRendered=SideArmImage.InternalOnDraw
         OnClick=SideArmImage.InternalOnClick
         OnRightClick=SideArmImage.InternalOnRightClick
     End Object
     Item_SideArm=GUILoadOutItem'BallisticProV55.BallisticOutfittingWeaponsTab.SideArmImage'

     Begin Object Class=GUILoadOutItem Name=PrimaryImage
         NAImage=Texture'BallisticProUITex.Icons.BigIcon_NA'
         Caption="Primary Weapon"
         WinTop=0.340000
         WinLeft=0.250000
         WinWidth=0.200000
         WinHeight=0.200000
         OnRendered=PrimaryImage.InternalOnDraw
         OnClick=PrimaryImage.InternalOnClick
         OnRightClick=PrimaryImage.InternalOnRightClick
     End Object
     Item_Primary=GUILoadOutItem'BallisticProV55.BallisticOutfittingWeaponsTab.PrimaryImage'

     Begin Object Class=GUILoadOutItem Name=GrenadeImage
         NAImage=Texture'BallisticProUITex.Icons.BigIcon_NA'
         Caption="Abilities"
         WinTop=0.340000
         WinLeft=0.550000
         WinWidth=0.200000
         WinHeight=0.200000
         OnRendered=GrenadeImage.InternalOnDraw
         OnClick=GrenadeImage.InternalOnClick
         OnRightClick=GrenadeImage.InternalOnRightClick
     End Object
     Item_Grenade=GUILoadOutItem'BallisticProV55.BallisticOutfittingWeaponsTab.GrenadeImage'

     Begin Object Class=GUIComboBox Name=cb_SideArmBox
         MaxVisibleItems=16
         Hint="Quick list of sidearms."
         WinTop=0.250000
         WinLeft=0.402930
         WinWidth=0.196094
         WinHeight=0.040000
         TabOrder=0
         OnChange=BallisticOutfittingWeaponsTab.InternalOnChange
         OnKeyEvent=cb_SideArmBox.InternalOnKeyEvent
     End Object
     cb_SideArm=GUIComboBox'BallisticProV55.BallisticOutfittingWeaponsTab.cb_SideArmBox'

     Begin Object Class=GUIComboBox Name=cb_PrimaryComBox
         MaxVisibleItems=16
         Hint="Quick list of primary weapons."
         WinTop=0.550000
         WinLeft=0.251563
         WinWidth=0.196094
         WinHeight=0.040000
         TabOrder=0
         OnChange=BallisticOutfittingWeaponsTab.InternalOnChange
         OnKeyEvent=cb_PrimaryComBox.InternalOnKeyEvent
     End Object
     cb_Primary=GUIComboBox'BallisticProV55.BallisticOutfittingWeaponsTab.cb_PrimaryComBox'

     Begin Object Class=GUIComboBox Name=cb_GrenadeComBox
         MaxVisibleItems=16
         Hint="Quick list of abilities."
         WinTop=0.550000
         WinLeft=0.550977
         WinWidth=0.196094
         WinHeight=0.040000
         TabOrder=0
         OnChange=BallisticOutfittingWeaponsTab.InternalOnChange
         OnKeyEvent=cb_GrenadeComBox.InternalOnKeyEvent
     End Object
     cb_Grenade=GUIComboBox'BallisticProV55.BallisticOutfittingWeaponsTab.cb_GrenadeComBox'

     Begin Object Class=moComboBox Name=co_PresetsCB
         ComponentJustification=TXTA_Left
         CaptionWidth=0.400000
         Caption="Preset:"
         OnCreateComponent=co_PresetsCB.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Choose a preset replacements configuration, or type a new preset name here and click 'Save' to make the current configuration a new preset."
         WinTop=0.640000
         WinLeft=0.630000
         WinWidth=0.250000
         OnChange=BallisticOutfittingWeaponsTab.InternalOnChange
     End Object
     cb_Presets=moComboBox'BallisticProV55.BallisticOutfittingWeaponsTab.co_PresetsCB'

     Begin Object Class=GUIImage Name=ImageBoxSideArm
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.030000
         WinLeft=0.387500
         WinWidth=0.225000
         WinHeight=0.240000
         RenderWeight=0.002000
     End Object
     Box_SideArm=GUIImage'BallisticProV55.BallisticOutfittingWeaponsTab.ImageBoxSideArm'

     Begin Object Class=GUIImage Name=ImageBoxPrimary
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.337500
         WinLeft=0.237500
         WinWidth=0.225000
         WinHeight=0.240000
         RenderWeight=0.002000
     End Object
     Box_Primary=GUIImage'BallisticProV55.BallisticOutfittingWeaponsTab.ImageBoxPrimary'

     Begin Object Class=GUIImage Name=ImageBoxGrenade
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.337500
         WinLeft=0.537500
         WinWidth=0.225000
         WinHeight=0.240000
         RenderWeight=0.002000
     End Object
     Box_Grenade=GUIImage'BallisticProV55.BallisticOutfittingWeaponsTab.ImageBoxGrenade'

     Begin Object Class=GUIImage Name=SideArmBackImage
         Image=Texture'Engine.MenuBlack'
         ImageStyle=ISTY_Stretched
         WinTop=0.050000
         WinLeft=0.400000
         WinWidth=0.200000
         WinHeight=0.200000
         RenderWeight=0.003000
     End Object
     SideArmBack=GUIImage'BallisticProV55.BallisticOutfittingWeaponsTab.SideArmBackImage'

     Begin Object Class=GUIImage Name=PrimaryBackImage
         Image=Texture'Engine.MenuBlack'
         ImageStyle=ISTY_Stretched
         WinTop=0.350000
         WinLeft=0.250000
         WinWidth=0.200000
         WinHeight=0.200000
         RenderWeight=0.003000
     End Object
     PrimaryBack=GUIImage'BallisticProV55.BallisticOutfittingWeaponsTab.PrimaryBackImage'

     Begin Object Class=GUIImage Name=GrenadeBackImage
         Image=Texture'Engine.MenuBlack'
         ImageStyle=ISTY_Stretched
         WinTop=0.350000
         WinLeft=0.550000
         WinWidth=0.200000
         WinHeight=0.200000
         RenderWeight=0.003000
     End Object
     GrenadeBack=GUIImage'BallisticProV55.BallisticOutfittingWeaponsTab.GrenadeBackImage'

     Begin Object Class=GUIButton Name=BSavePresetButton
         Caption="SAVE"
         Hint="Saves the current configuration as a new preset."
         WinTop=0.640000
         WinLeft=0.115500
         WinWidth=0.257000
         WinHeight=0.065000
         TabOrder=0
         OnClick=BallisticOutfittingWeaponsTab.InternalOnClick
         OnKeyEvent=BSavePresetButton.InternalOnKeyEvent
     End Object
     BSavePreset=GUIButton'BallisticProV55.BallisticOutfittingWeaponsTab.BSavePresetButton'

     Begin Object Class=GUILabel Name=l_Receivinglabel
         TextAlign=TXTA_Center
         TextColor=(B=0,G=255,R=255)
         FontScale=FNS_Large
         WinTop=0.087000
         WinLeft=0.050000
         WinWidth=0.900000
         WinHeight=0.040000
     End Object
     l_Receiving=GUILabel'BallisticProV55.BallisticOutfittingWeaponsTab.l_Receivinglabel'

SavedLoadouts[0]=(PresetName="DEFAULT1",Weapons[0]="BallisticProV55.X4Knife",Weapons[1]="BallisticProV55.RS8Pistol",Weapons[2]="BWBPRecolorsPro.AK47AssaultRifle",Weapons[3]="BallisticProV55.M50AssaultRifle",Weapons[4]="BallisticProV55.NRP57Grenade")
SavedLoadouts[1]=(PresetName="DEFAULT2",Weapons[0]="BallisticProV55.X4Knife",Weapons[1]="BWBPRecolorsPro.AH208Pistol",Weapons[2]="BWBPRecolorsPro.LK05Carbine",Weapons[3]=,Weapons[4]="BWBPRecolorsPro.MGLauncher")
SavedLoadouts[2]=(PresetName="DEFAULT3",Weapons[0]="BallisticProV55.X4Knife",Weapons[1]="BallisticProV55.D49Revolver",Weapons[2]="BallisticProV55.M46AssaultRifleQS",Weapons[3]=,Weapons[4]="BallisticProV55.G5Bazooka")
SavedLoadouts[3]=(PresetName="DEFAULT4",Weapons[0]="BallisticProV55.X4Knife",Weapons[1]="BallisticProV55.GRS9Pistol",Weapons[2]="BallisticProV55.M763Shotgun",Weapons[3]=,Weapons[4]="BallisticProV55.NRP57Grenade")
SavedLoadouts[4]=(PresetName="DEFAULT5",Weapons[0]="BallisticProV55.X4Knife",Weapons[1]="BallisticProV55.MD24Pistol",Weapons[2]="BallisticProV55.R78Rifle",Weapons[3]=,Weapons[4]="BallisticProV55.NRP57Grenade")
     QuickListText="QuickList"
     ReceivingText(0)="Receiving..."
     ReceivingText(1)="Loading..."
}
