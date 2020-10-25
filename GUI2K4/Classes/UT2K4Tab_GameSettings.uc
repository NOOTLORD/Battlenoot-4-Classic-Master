//==============================================================================
//  Contains all client-side (mostly) game configuration properties
//
//  Written by Ron Prestenback
//  © 2003, Epic Games, Inc.  All Rights Reserved
//==============================================================================
class UT2K4Tab_GameSettings extends Settings_Tabs;

var automated GUISectionBackground i_BG1, i_BG3, i_BG4;
var automated moCheckBox    ch_Dodging, ch_LandShake;                        
var automated moComboBox    co_GoreLevel;

var GUIComponent LastGameOption;  // Hack

var bool    bBob, bDodge, bLandShake, bLandShakeD;
var int     iGore;

var localized string    StatsURL;

var automated GUILabel  l_Warning;
var automated GUIButton b_Stats;
var automated moCheckBox    ch_TrackStats, ch_Precache;
var automated moEditBox     ed_Name, ed_Password;

var string sPassword, sName;
var bool bStats, bPrecache;


function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local int i;

    Super.InitComponent(MyController, MyOwner);
    if ( class'GameInfo'.Default.bAlternateMode )
    	RemoveComponent(co_GoreLevel);
    else
    {
    	for (i = 0; i < ArrayCount(class'GameInfo'.default.GoreLevelText); i++)
    		co_GoreLevel.AddItem(class'GameInfo'.default.GoreLevelText[i]);
    }

    LastGameOption = ch_LandShake;

    ed_Name.MyEditBox.bConvertSpaces = true;
    ed_Name.MyEditBox.MaxWidth=14;

    ed_Password.MyEditBox.MaxWidth=14;

    ed_Password.MaskText(true);
}

function string FormatID(string id)
{
    id=Caps(id);
    return mid(id,0,8)$"-"$mid(id,8,8)$"-"$mid(id,16,8)$"-"$mid(id,24,8);
}

function ShowPanel(bool bShow)
{
    Super.ShowPanel(bShow);
    if ( bShow )
	{
		if ( bInit )
	    {
            i_BG1.ManageComponent(ch_Dodging);
            i_BG1.ManageComponent(ch_LandShake);
	        i_BG1.Managecomponent(co_GoreLevel);
	    }
    	UpdateStatsItems();
    }
}

function InternalOnLoadINI(GUIComponent Sender, string s)
{
    local PlayerController PC;

    if (GUIMenuOption(Sender) != None)
    {
        PC = PlayerOwner();

        switch (GUIMenuOption(Sender))
        {
            case co_GoreLevel:
            	if ( PC.Level.Game != None )
            		iGore = PC.Level.Game.GoreLevel;
                else iGore = class'GameInfo'.default.GoreLevel;
                co_GoreLevel.SetIndex(iGore);
                break;

            case ch_Dodging:
                bDodge = PC.DodgingIsEnabled();
                ch_Dodging.Checked(bDodge);
                break;

			case ch_LandShake:
				bLandShake = PC.bLandingShake;
				ch_LandShake.Checked(bLandShake);
				break;

        // Network
        	case ch_Precache:
        		bPrecache = PC.Level.bDesireSkinPreload;
        		ch_Precache.Checked(bPrecache);
        		break;

            case ed_Name:
                sName = PC.StatsUserName;
                ed_Name.SetText(sName);
                break;

            case ed_Password:
                sPassword = PC.StatsPassword;
                ed_Password.SetText(sPassword);
                break;

            case ch_TrackStats:
            	bStats = PC.bEnableStatsTracking;
                ch_TrackStats.Checked(bStats);
                UpdateStatsItems();
                break;
        }
    }
}

function SaveSettings()
{
    local PlayerController PC;
    local bool bSave;

	Super.SaveSettings();
    PC = PlayerOwner();

	if (PC.bLandingShake != bLandShake)
	{
		PC.bLandingShake = bLandShake;
		bSave = True;
	}

    if (PC.DodgingIsEnabled() != bDodge)
    {
        PC.SetDodging(bDodge);
        bSave = True;
    }
	
    if (PC.Pawn != None)
    {

        PC.Pawn.bWeaponBob = bBob;
        PC.Pawn.SaveConfig();
    }
    else if (class'Engine.Pawn'.default.bWeaponBob != bBob)
    {
        class'Engine.Pawn'.default.bWeaponBob = bBob;
        class'Engine.Pawn'.static.StaticSaveConfig();
    }

    if (PC.Level != None && PC.Level.Game != None)
    {
    	if ( PC.Level.Game.GoreLevel != iGore )
    	{
	        PC.Level.Game.GoreLevel = iGore;
	        PC.Level.Game.SaveConfig();
	    }
    }
    else
    {
		if ( class'Engine.GameInfo'.default.GoreLevel != iGore )
		{
	        class'Engine.GameInfo'.default.GoreLevel = iGore;
	        class'Engine.GameInfo'.static.StaticSaveConfig();
	    }
    }

	// Network
	if ( bPrecache != PC.Level.bDesireSkinPreload )
	{
		PC.Level.bDesireSkinPreload = bPrecache;
		PC.Level.SaveConfig();
	}

	if ( bStats != PC.bEnableStatsTracking )
	{
		PC.bEnableStatsTracking = bStats;
		bSave = True;
	}

	if ( sName != PC.StatsUserName )
	{
		PC.StatsUserName = sName;
		bSave = True;
	}

	if ( PC.StatsPassword != sPassword )
	{
		PC.StatsPassword = sPassword;
		bSave = True;
	}

    if (bSave)
        PC.SaveConfig();
}

function ResetClicked()
{
    local class<Client> ViewportClass;
    local bool bTemp;
    local PlayerController PC;
    local int i;

    Super.ResetClicked();

	PC = PlayerOwner();
    ViewportClass = class<Client>(DynamicLoadObject(GetNativeClassName("Engine.Engine.ViewportManager"), class'Class'));

    ViewportClass.static.ResetConfig("ScreenFlashes");

    PC.ResetConfig("bEnableDodging");
	PC.ResetConfig("bLandingShake");

    class'Engine.Pawn'.static.ResetConfig("bWeaponBob");
    class'Engine.GameInfo'.static.ResetConfig("GoreLevel");

    // Network
    class'Engine.LevelInfo'.static.ResetConfig("bDesireSkinPreload");
    PC.ResetConfig("bEnableStatsTracking");
    PC.ClearConfig("StatsUserName");
    PC.ClearConfig("StatsPassword");

    bTemp = Controller.bCurMenuInitialized;
    Controller.bCurMenuInitialized = False;

    for (i = 0; i < Components.Length; i++)
        Components[i].LoadINI();

    Controller.bCurMenuInitialized = bTemp;
}

function InternalOnChange(GUIComponent Sender)
{
    local PlayerController PC;

	Super.InternalOnChange(Sender);
    if (GUIMenuOption(Sender) != None)
    {
        PC = PlayerOwner();

        switch (GUIMenuOption(Sender))
        {
            case co_GoreLevel:
                iGore = co_GoreLevel.GetIndex();
                break;

            case ch_Dodging:
                bDodge = ch_Dodging.IsChecked();
                break;

			case ch_LandShake:
				bLandShake = ch_LandShake.IsChecked();
				break;

		// Network
        	case ch_Precache:
        		bPrecache = ch_Precache.IsChecked();
        		break;
				
            case ed_Name:
                sName = ed_Name.GetText();
                break;

            case ed_Password:
                sPassword = ed_Password.GetText();
                break;

            case ch_TrackStats:
            	bStats = ch_TrackStats.IsChecked();
                UpdateStatsItems();
                break;
        }
    }

    l_Warning.SetVisibility(!ValidStatConfig());
}

function bool ValidStatConfig()
{
    if(bStats)
    {
        if(Len(ed_Name.GetText()) < 4)
            return false;

        if(Len(ed_Password.GetText()) < 6)
            return false;
    }

    return true;
}

function bool OnViewStats(GUIComponent Sender)
{
    PlayerOwner().ConsoleCommand("start"@StatsURL);
    return true;
}

function UpdateStatsItems()
{
	if ( bStats )
	{
		EnableComponent(ed_Name);
		EnableComponent(ed_Password);
		EnableComponent(b_Stats);
	}
	else
	{
		DisableComponent(ed_Name);
		DisableComponent(ed_Password);
		DisableComponent(b_Stats);
	}

	l_Warning.SetVisibility(!ValidStatConfig());
}

defaultproperties
{
     Begin Object Class=GUISectionBackground Name=GameBK1
         Caption="Gameplay"
         WinTop=0.033853
         WinLeft=0.014649
         WinWidth=0.449609
         WinHeight=0.748936
         RenderWeight=0.100100
         OnPreDraw=GameBK1.InternalPreDraw
     End Object
     i_BG1=GUISectionBackground'GUI2K4.UT2K4Tab_GameSettings.GameBK1'

     Begin Object Class=GUISectionBackground Name=GameBK3
         Caption="Stats"
         WinTop=0.240491
         WinLeft=0.486328
         WinWidth=0.496484
         WinHeight=0.308985
         RenderWeight=0.100200
         OnPreDraw=GameBK3.InternalPreDraw
     End Object
     i_BG3=GUISectionBackground'GUI2K4.UT2K4Tab_GameSettings.GameBK3'

     Begin Object Class=GUISectionBackground Name=GameBK4
         Caption="Misc"
         WinTop=0.559889
         WinLeft=0.486328
         WinWidth=0.496484
         WinHeight=0.219141
         RenderWeight=0.100200
         OnPreDraw=GameBK4.InternalPreDraw
     End Object
     i_BG4=GUISectionBackground'GUI2K4.UT2K4Tab_GameSettings.GameBK4'

     Begin Object Class=moCheckBox Name=GameDodging
         Caption="Dodging"
         OnCreateComponent=GameDodging.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Turn this option off to disable special dodge moves."
         WinTop=0.541563
         WinLeft=0.050000
         WinWidth=0.400000
         RenderWeight=1.040000
         TabOrder=1
         OnChange=UT2K4Tab_GameSettings.InternalOnChange
         OnLoadINI=UT2K4Tab_GameSettings.InternalOnLoadINI
     End Object
     ch_Dodging=moCheckBox'GUI2K4.UT2K4Tab_GameSettings.GameDodging'

     Begin Object Class=moCheckBox Name=LandShaking
         CaptionWidth=0.900000
         Caption="Landing Viewshake"
         OnCreateComponent=LandShaking.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enable view shaking upon landing."
         WinTop=0.150261
         WinLeft=0.705430
         WinWidth=0.266797
         TabOrder=7
         OnChange=UT2K4Tab_GameSettings.InternalOnChange
         OnLoadINI=UT2K4Tab_GameSettings.InternalOnLoadINI
     End Object
     ch_LandShake=moCheckBox'GUI2K4.UT2K4Tab_GameSettings.LandShaking'

     Begin Object Class=moComboBox Name=GameGoreLevel
         bReadOnly=True
         Caption="Gore Level"
         OnCreateComponent=GameGoreLevel.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Configure the amount of blood and gore you see while playing the game"
         WinTop=0.415521
         WinLeft=0.050000
         WinWidth=0.400000
         RenderWeight=1.040000
         TabOrder=2
         OnChange=UT2K4Tab_GameSettings.InternalOnChange
         OnLoadINI=UT2K4Tab_GameSettings.InternalOnLoadINI
     End Object
     co_GoreLevel=moComboBox'GUI2K4.UT2K4Tab_GameSettings.GameGoreLevel'

     StatsURL="http://ut2004stats.epicgames.com/"
     Begin Object Class=GUILabel Name=InvalidWarning
         Caption="Your stats username or password is invalid.  Your username must be at least 4 characters long, and your password must be at least 6 characters long."
         TextAlign=TXTA_Center
         TextColor=(B=0,G=255,R=255)
         TextFont="UT2SmallFont"
         bMultiLine=True
         WinTop=0.916002
         WinLeft=0.057183
         WinWidth=0.887965
         WinHeight=0.058335
     End Object
     l_Warning=GUILabel'GUI2K4.UT2K4Tab_GameSettings.InvalidWarning'

     Begin Object Class=GUIButton Name=ViewOnlineStats
         Caption="View Stats"
         Hint="Click to launch the UT stats website."
         WinTop=0.469391
         WinLeft=0.780383
         WinWidth=0.166055
         WinHeight=0.050000
         TabOrder=13
         OnClick=UT2K4Tab_GameSettings.OnViewStats
         OnKeyEvent=ViewOnlineStats.InternalOnKeyEvent
     End Object
     b_Stats=GUIButton'GUI2K4.UT2K4Tab_GameSettings.ViewOnlineStats'

     Begin Object Class=moCheckBox Name=OnlineTrackStats
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Track Stats"
         OnCreateComponent=OnlineTrackStats.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="True"
         Hint="Enable this option to join the online ranking system."
         WinTop=0.321733
         WinLeft=0.642597
         WinWidth=0.170273
         TabOrder=10
         OnChange=UT2K4Tab_GameSettings.InternalOnChange
         OnLoadINI=UT2K4Tab_GameSettings.InternalOnLoadINI
     End Object
     ch_TrackStats=moCheckBox'GUI2K4.UT2K4Tab_GameSettings.OnlineTrackStats'

     Begin Object Class=moCheckBox Name=PrecacheSkins
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Preload all player skins"
         OnCreateComponent=PrecacheSkins.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Preloads all player skins, increasing level load time but reducing hitches during network games.  You must have at least 512 MB of system memory to use this option."
         WinTop=0.667553
         WinLeft=0.540058
         WinWidth=0.403353
         TabOrder=15
         OnChange=UT2K4Tab_GameSettings.InternalOnChange
         OnLoadINI=UT2K4Tab_GameSettings.InternalOnLoadINI
     End Object
     ch_Precache=moCheckBox'GUI2K4.UT2K4Tab_GameSettings.PrecacheSkins'

     Begin Object Class=moEditBox Name=OnlineStatsName
         CaptionWidth=0.400000
         Caption="UserName"
         OnCreateComponent=OnlineStatsName.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Please select a name to use for UT Stats!"
         WinTop=0.373349
         WinLeft=0.524912
         WinWidth=0.419316
         TabOrder=11
         OnChange=UT2K4Tab_GameSettings.InternalOnChange
         OnLoadINI=UT2K4Tab_GameSettings.InternalOnLoadINI
     End Object
     ed_Name=moEditBox'GUI2K4.UT2K4Tab_GameSettings.OnlineStatsName'

     Begin Object Class=moEditBox Name=OnlineStatsPW
         CaptionWidth=0.400000
         Caption="Password"
         OnCreateComponent=OnlineStatsPW.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Please select a password that will secure your UT Stats!"
         WinTop=0.430677
         WinLeft=0.524912
         WinWidth=0.419316
         TabOrder=12
         OnChange=UT2K4Tab_GameSettings.InternalOnChange
         OnLoadINI=UT2K4Tab_GameSettings.InternalOnLoadINI
     End Object
     ed_Password=moEditBox'GUI2K4.UT2K4Tab_GameSettings.OnlineStatsPW'

     PanelCaption="Game"
     WinTop=0.150000
     WinHeight=0.740000
}