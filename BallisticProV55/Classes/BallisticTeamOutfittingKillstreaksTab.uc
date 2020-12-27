//=============================================================================
// BallisticTeamOutfittingKillstreaksTab
//
// Menu for selecting weapon loadout. Consists of several categories, user can
// pick what weapon they want for each category (e.g. Streak1, Streak2, Streak3)
//
// by Nolan "Dark Carnivour" Richert.
// Modified by Azarael
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticTeamOutfittingKillstreaksTab extends UT2K4TabPanel config(BallisticProV55);

// Use GUILoadOutItems to select weapons. This control has some text with an image that cycles when you click on it
var automated GUILoadOutItem Item_Streak1, Item_Streak2;
var automated GUIComboBox	 cb_Streak1, cb_Streak2;
var automated moComboBox		cb_Presets;
var Automated GUIImage MyBack, Box_Streak1, Box_Streak2, Streak1Back, Streak2Back;
var Automated GUIButton BDone, BCancel, BSavePreset;
var automated GUIHeader MyHeader;
var automated GUILabel	l_Receiving;
var BallisticTeamOutfittingMenu p_Anchor;

var config int CurrentIndex;
var bool bWeaponsLoaded;

struct StreakWeapons
{
    var string PresetName;
	var string Weapons[2];
};

var() config array<StreakWeapons>			SavedStreaks[5];  //Saved loadouts
var() array<String>								DefaultStreaks;

var int NumPresets;

var() localized string QuickListText;

var localized string ReceivingText[2];

var ClientTeamOutfittinginterface COI;	// The ClientOutfittingInterface actor we can use to comunicate with the mutator

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.InitComponent(MyController, MyOwner);
	
	if(BallisticTeamOutfittingMenu(Controller.ActivePage) != None)
	p_Anchor = BallisticTeamOutfittingMenu(Controller.ActivePage);
}

function ShowPanel(bool bShow)
{
	Super.ShowPanel(bShow);

	if(!bWeaponsLoaded)
	{
		if (COI == None || !COI.bWeaponsReady)
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

	cb_Streak1.List.bSorted=true;
	cb_Streak1.List.Sort();
	cb_Streak2.List.bSorted=true;
	cb_Streak2.List.Sort();
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

	// Load the weapons into their GUILoadOutItems

	for(i=0;i<COI.GroupLength(5);i++)
	{
		if (GetItemInfo(5, i, IC, IMat, ICN, ICrds))
		{
			Item_Streak1.AddItem(IC, IMat, ICN, ICrds);
			Item_Streak1.SetItem(SavedStreaks[CurrentIndex].Weapons[0]);
   			cb_Streak1.AddItem(IC, ,ICN);
   			cb_Streak1.SetText(QuickListText);
   		}
	}
	
	for(i=0;i<COI.GroupLength(6);i++)
	{
		if (GetItemInfo(6, i, IC, IMat, ICN, ICrds))
		{
			Item_Streak2.AddItem(IC, IMat, ICN, ICrds);
			Item_Streak2.SetItem(SavedStreaks[CurrentIndex].Weapons[1]);
   			cb_Streak2.AddItem(IC, ,ICN);
   			cb_Streak2.SetText(QuickListText);
   		}
	}
	
	//Load presets
	for(i=0;i<5;i++) //fixme
	    cb_Presets.AddItem(SavedStreaks[i].PresetName ,,string(i));
	    cb_Presets.SetIndex(CurrentIndex);
	    
	
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


function bool InternalOnKeyEvent(out byte Key, out byte State, float delta)
{
	return false;
}

function bool InternalOnClick(GUIComponent Sender)
{
	if (Sender==BSavePreset) //SAVE PRESET
	{
			SavedStreaks[cb_Presets.GetIndex()].PresetName = cb_Presets.GetText();
			
		if (Item_Streak1.Items.length > Item_Streak1.Index)
			SavedStreaks[cb_Presets.GetIndex()].Weapons[0] = Item_Streak1.Items[Item_Streak1.Index].Text;
		if (Item_Streak2.Items.length > Item_Streak2.Index)
			SavedStreaks[cb_Presets.GetIndex()].Weapons[1] = Item_Streak2.Items[Item_Streak2.Index].Text;
		SaveConfig();	
	}
	return true;
}

function SaveStreaks()
{

		if(!bWeaponsLoaded)
		return;
		
		SavedStreaks[cb_Presets.GetIndex()].PresetName = cb_Presets.GetText();
			
		if (Item_Streak1.Items.length > Item_Streak1.Index)
			SavedStreaks[cb_Presets.GetIndex()].Weapons[0] = Item_Streak1.Items[Item_Streak1.Index].Text;
		if (Item_Streak2.Items.length > Item_Streak2.Index)
			SavedStreaks[cb_Presets.GetIndex()].Weapons[1] = Item_Streak2.Items[Item_Streak2.Index].Text;
			
		if (Item_Streak1.Items.length > Item_Streak1.Index)
			class'Mut_TeamOutfitting'.default.Killstreaks[0] = SavedStreaks[cb_Presets.GetIndex()].Weapons[0];
		if (Item_Streak2.Items.length > Item_Streak2.Index)
			class'Mut_TeamOutfitting'.default.Killstreaks[1] = SavedStreaks[cb_Presets.GetIndex()].Weapons[1];
		
		CurrentIndex=cb_Presets.GetIndex();
		SaveConfig();
		
		class'Mut_TeamOutfitting'.static.StaticSaveConfig();
}

function InternalOnChange(GUIComponent Sender)
{
	if (COI == None || !COI.bWeaponsReady)
		return;
		
	if (Sender == cb_Streak1)
		Item_Streak1.SetItem(cb_Streak1.GetExtra());
	else if (Sender == cb_Streak2)
		Item_Streak2.SetItem(cb_Streak2.GetExtra());
		
	else if (Sender == cb_Presets && cb_Presets.GetExtra() != "")
	{
		Item_Streak1.SetItem(SavedStreaks[cb_Presets.GetIndex()].Weapons[0]);
		Item_Streak2.SetItem(SavedStreaks[cb_Presets.GetIndex()].Weapons[1]);
	}
}

defaultproperties
{
     Begin Object Class=GUILoadOutItem Name=Streak1Image
         NAImage=Texture'BallisticProUITex.Icons.BigIcon_NA'
         Caption="4 Kills"
         WinTop=0.200000
         WinLeft=0.250000
         WinWidth=0.200000
         WinHeight=0.200000
         OnRendered=Streak1Image.InternalOnDraw
         OnClick=Streak1Image.InternalOnClick
         OnRightClick=Streak1Image.InternalOnRightClick
     End Object
     Item_Streak1=GUILoadOutItem'BallisticProV55.BallisticTeamOutfittingKillstreaksTab.Streak1Image'

     Begin Object Class=GUILoadOutItem Name=Streak2Image
         NAImage=Texture'BallisticProUITex.Icons.BigIcon_NA'
         Caption="9 Kills"
         WinTop=0.200000
         WinLeft=0.550000
         WinWidth=0.200000
         WinHeight=0.200000
         OnRendered=Streak2Image.InternalOnDraw
         OnClick=Streak2Image.InternalOnClick
         OnRightClick=Streak2Image.InternalOnRightClick
     End Object
     Item_Streak2=GUILoadOutItem'BallisticProV55.BallisticTeamOutfittingKillstreaksTab.Streak2Image'

     Begin Object Class=GUIComboBox Name=cb_Streak1ComBox
         MaxVisibleItems=16
         Hint="Quick list of Streak1 items"
         WinTop=0.400000
         WinLeft=0.251563
         WinWidth=0.196094
         WinHeight=0.040000
         TabOrder=0
         OnChange=BallisticTeamOutfittingKillstreaksTab.InternalOnChange
         OnKeyEvent=cb_Streak1ComBox.InternalOnKeyEvent
     End Object
     cb_Streak1=GUIComboBox'BallisticProV55.BallisticTeamOutfittingKillstreaksTab.cb_Streak1ComBox'

     Begin Object Class=GUIComboBox Name=cb_Streak2Box
         MaxVisibleItems=16
         Hint="Quick list of Streak2 items"
         WinTop=0.400000
         WinLeft=0.550977
         WinWidth=0.196094
         WinHeight=0.040000
         TabOrder=0
         OnChange=BallisticTeamOutfittingKillstreaksTab.InternalOnChange
         OnKeyEvent=cb_Streak2Box.InternalOnKeyEvent
     End Object
     cb_Streak2=GUIComboBox'BallisticProV55.BallisticTeamOutfittingKillstreaksTab.cb_Streak2Box'

     Begin Object Class=moComboBox Name=co_PresetsCB
         ComponentJustification=TXTA_Left
         CaptionWidth=0.400000
         Caption="Presets"
         OnCreateComponent=co_PresetsCB.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Choose a preset replacements configuration, or type a new preset name here and click 'Save' to make the current configuration a new preset."
         WinTop=0.640000
         WinLeft=0.630000
         WinWidth=0.250000
         OnChange=BallisticTeamOutfittingKillstreaksTab.InternalOnChange
     End Object
     cb_Presets=moComboBox'BallisticProV55.BallisticTeamOutfittingKillstreaksTab.co_PresetsCB'

     Begin Object Class=GUIImage Name=ImageBoxStreak1
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.180000
         WinLeft=0.237500
         WinWidth=0.225000
         WinHeight=0.240000
         RenderWeight=0.002000
     End Object
     Box_Streak1=GUIImage'BallisticProV55.BallisticTeamOutfittingKillstreaksTab.ImageBoxStreak1'

     Begin Object Class=GUIImage Name=ImageBoxStreak2
         Image=Texture'2K4Menus.NewControls.Display99'
         ImageStyle=ISTY_Stretched
         WinTop=0.180000
         WinLeft=0.537500
         WinWidth=0.225000
         WinHeight=0.240000
         RenderWeight=0.002000
     End Object
     Box_Streak2=GUIImage'BallisticProV55.BallisticTeamOutfittingKillstreaksTab.ImageBoxStreak2'

     Begin Object Class=GUIImage Name=Streak1BackImage
         Image=Texture'Engine.MenuBlack'
         ImageStyle=ISTY_Stretched
         WinTop=0.200000
         WinLeft=0.250000
         WinWidth=0.200000
         WinHeight=0.200000
         RenderWeight=0.003000
     End Object
     Streak1Back=GUIImage'BallisticProV55.BallisticTeamOutfittingKillstreaksTab.Streak1BackImage'

     Begin Object Class=GUIImage Name=Streak2BackImage
         Image=Texture'Engine.MenuBlack'
         ImageStyle=ISTY_Stretched
         WinTop=0.200000
         WinLeft=0.550000
         WinWidth=0.200000
         WinHeight=0.200000
         RenderWeight=0.003000
     End Object
     Streak2Back=GUIImage'BallisticProV55.BallisticTeamOutfittingKillstreaksTab.Streak2BackImage'

     Begin Object Class=GUIButton Name=BSavePresetButton
         Caption="SAVE"
         Hint="Saves the current configuration as a new preset."
         WinTop=0.640000
         WinLeft=0.115500
         WinWidth=0.257000
         WinHeight=0.065000
         TabOrder=0
         OnClick=BallisticTeamOutfittingKillstreaksTab.InternalOnClick
         OnKeyEvent=BSavePresetButton.InternalOnKeyEvent
     End Object
     BSavePreset=GUIButton'BallisticProV55.BallisticTeamOutfittingKillstreaksTab.BSavePresetButton'

     Begin Object Class=GUILabel Name=l_Receivinglabel
         TextAlign=TXTA_Center
         TextColor=(B=0,G=255,R=255)
         FontScale=FNS_Large
         WinTop=0.087000
         WinLeft=0.050000
         WinWidth=0.900000
         WinHeight=0.040000
     End Object
     l_Receiving=GUILabel'BallisticProV55.BallisticTeamOutfittingKillstreaksTab.l_Receivinglabel'

     SavedStreaks(0)=(PresetName="DEFAULT",Weapons[0]="BallisticProV55.RX22AFlamer",Weapons[1]="BallisticProV55.MRocketLauncher")
     SavedStreaks(1)=(PresetName="DEFAULT2",Weapons[0]="BallisticProV55.RX22AFlamer",Weapons[1]="BallisticProV55.MRocketLauncher")
     SavedStreaks(2)=(PresetName="DEFAULT3",Weapons[0]="BallisticProV55.RX22AFlamer",Weapons[1]="BallisticProV55.MRocketLauncher")
     SavedStreaks(3)=(PresetName="DEFAULT4",Weapons[0]="BallisticProV55.RX22AFlamer",Weapons[1]="BallisticProV55.MRocketLauncher")
     SavedStreaks(4)=(PresetName="DEFAULT5",Weapons[0]="BallisticProV55.RX22AFlamer",Weapons[1]="BallisticProV55.MRocketLauncher")
     DefaultStreaks(0)="BallisticProV55.RX22AFlamer"
     DefaultStreaks(1)="BallisticProV55.MRocketLauncher"
     QuickListText="QuickList"
     ReceivingText(0)="Receiving..."
     ReceivingText(1)="Loading..."
}
