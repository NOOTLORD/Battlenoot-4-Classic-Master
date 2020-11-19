//==============================================================================
//	Description
//
//	Created by Ron Prestenback
//	© 2003, Epic Games, Inc.  All Rights Reserved
//
// Modified by (NL)NOOTLORD
//==============================================================================
class UT2K4Tab_IForceSettings extends Settings_Tabs;

var automated GUISectionBackground i_BG1, i_BG2, i_BG3;
var automated moFloatEdit	fl_Sensitivity, fl_MenuSensitivity, fl_DodgeTime;

var automated GUIButton b_Controls, b_Speech;

var float fSens, fMSens, fDodge;

var config string ControlBindMenu, SpeechBindMenu;

event InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.Initcomponent(MyController, MyOwner);

    i_BG1.ManageComponent(b_Controls);
    i_BG1.ManageComponent(b_Speech);

    i_BG3.ManageComponent(fl_Sensitivity);
    i_BG3.ManageComponent(fl_MenuSensitivity);
    i_BG3.ManageComponent(fl_DodgeTime);
}


function InternalOnLoadINI(GUIComponent Sender, string s)
{
	local PlayerController PC;

	PC = PlayerOwner();

	switch (Sender)
	{
	case fl_Sensitivity:
		fSens = class'PlayerInput'.default.MouseSensitivity;
		fl_Sensitivity.SetComponentValue(fSens,true);
		break;

	case fl_MenuSensitivity:
		fMSens = Controller.MenuMouseSens;
		fl_MenuSensitivity.SetComponentValue(fMSens,true);
		break;

	case fl_DodgeTime:
		fDodge = class'PlayerInput'.Default.DoubleClickTime;
		fl_DodgeTime.SetComponentValue(fDodge,true);
		break;

	default:
		log(Name@"Unknown component calling LoadINI:"$ GUIMenuOption(Sender).Caption);
		GUIMenuOption(Sender).SetComponentValue(s,true);
	}
}

function SaveSettings()
{
	local PlayerController PC;
	local bool bSave, bInputSave;

	Super.SaveSettings();

	PC = PlayerOwner();

	if ( Controller.MenuMouseSens != FMax(0.0, fMSens) )
		Controller.SaveConfig();

	if ( class'PlayerInput'.default.DoubleClickTime != FMax(0.0, fDodge) )
	{
		class'PlayerInput'.default.DoubleClickTime = fDodge;
		bInputSave = True;
	}

	if ( class'PlayerInput'.default.MouseSensitivity != FMax(0.0, fSens) )
	{
		PC.SetSensitivity(fSens);
		bInputSave = False;
	}

	if (bInputSave)
		class'PlayerInput'.static.StaticSaveConfig();

	if (bSave)
		PC.SaveConfig();
}

function ResetClicked()
{
	local int i;
	local string Str;
	local class					 	ViewportClass;
	local class<RenderDevice>		RenderClass;

	Super.ResetClicked();
	Str = PlayerOwner().ConsoleCommand("get ini:Engine.Engine.ViewportManager Class");
	Str = Mid(Str, InStr(Str, "'") + 1);
	Str = Left(Str, Len(Str) - 1);
	ViewportClass = class(DynamicLoadObject(Str, class'Class'));

	Str = PlayerOwner().ConsoleCommand("get ini:Engine.Engine.RenderDevice Class");
	Str = Mid(Str, InStr(Str, "'") + 1);
	Str = Left(Str, Len(Str) - 1);
	RenderClass = class<RenderDevice>(DynamicLoadObject(Str, class'Class'));

	Controller.static.ResetConfig("MenuMouseSens");

	class'PlayerInput'.static.ResetConfig("MouseSensitivity");
	class'PlayerInput'.static.ResetConfig("DoubleClickTime");

	for (i = 0; i < Components.Length; i++)
		Components[i].LoadINI();
}

function InternalOnChange(GUIComponent Sender)
{
	Super.InternalOnChange(Sender);
	switch (Sender)
	{
	case fl_Sensitivity:
		fSens = fl_Sensitivity.GetValue();
		break;

	case fl_MenuSensitivity:
		Controller.MenuMouseSens = fl_MenuSensitivity.GetValue();
		break;
		
	case fl_DodgeTime:
		fDodge = fl_DodgeTime.GetValue();
		break;
	}
}

function bool InternalOnClick(GUIComponent Sender)
{
	local GUITabControl C;
	local int i;

	if ( Sender == b_Controls )
	{
		Controller.OpenMenu(ControlBindMenu);
	}

	else if ( Sender == b_Speech )
	{
		// Hack - need to update the players character and voice options before opening the speechbind menu
		C = GUITabControl(MenuOwner);
		if ( C != None )
		{
			for ( i = 0; i < C.TabStack.Length; i++ )
			{
				if ( C.TabStack[i] != None && UT2K4Tab_PlayerSettings(C.TabStack[i].MyPanel) != None )
				{
					UT2K4Tab_PlayerSettings(C.TabStack[i].MyPanel).SaveSettings();
					break;
				}
			}
		}

		Controller.OpenMenu(SpeechBindMenu);
	}

	return true;
}

defaultproperties
{
     Begin Object Class=GUISectionBackground Name=InputBK1
         Caption="Options"
         WinTop=0.028176
         WinLeft=0.021641
         WinWidth=0.381328
         WinHeight=0.655039
         OnPreDraw=InputBK1.InternalPreDraw
     End Object
     i_BG1=GUISectionBackground'GUI2K4.UT2K4Tab_IForceSettings.InputBK1'

     Begin Object Class=GUISectionBackground Name=InputBK3
         Caption="Fine Tuning"
         WinTop=0.028176
         WinLeft=0.451289
         WinWidth=0.527812
         WinHeight=0.655039
         OnPreDraw=InputBK3.InternalPreDraw
     End Object
     i_BG3=GUISectionBackground'GUI2K4.UT2K4Tab_IForceSettings.InputBK3'

     Begin Object Class=moFloatEdit Name=InputMouseSensitivity
         MinValue=0.000000
         MaxValue=25.000000
         Step=0.10000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.725000
         Caption="Mouse Sensitivity (Game)"
         OnCreateComponent=InputMouseSensitivity.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Adjust mouse sensitivity"
         WinTop=0.105365
         WinLeft=0.502344
         WinWidth=0.421680
         WinHeight=0.045352
         TabOrder=7
         OnChange=UT2K4Tab_IForceSettings.InternalOnChange
         OnLoadINI=UT2K4Tab_IForceSettings.InternalOnLoadINI
     End Object
     fl_Sensitivity=moFloatEdit'GUI2K4.UT2K4Tab_IForceSettings.InputMouseSensitivity'

     Begin Object Class=moFloatEdit Name=InputMenuSensitivity
         MinValue=0.000000
         MaxValue=6.000000
         Step=0.10000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.725000
         Caption="Mouse Sensitivity (Menus)"
         OnCreateComponent=InputMenuSensitivity.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Adjust mouse speed within the menus"
         WinTop=0.188698
         WinLeft=0.502344
         WinWidth=0.421875
         WinHeight=0.045352
         TabOrder=8
         OnChange=UT2K4Tab_IForceSettings.InternalOnChange
         OnLoadINI=UT2K4Tab_IForceSettings.InternalOnLoadINI
     End Object
     fl_MenuSensitivity=moFloatEdit'GUI2K4.UT2K4Tab_IForceSettings.InputMenuSensitivity'

     Begin Object Class=moFloatEdit Name=InputDodgeTime
         MinValue=0.000000
         MaxValue=1.000000
         Step=0.050000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.725000
         Caption="Dodge Double-Click Time"
         OnCreateComponent=InputDodgeTime.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Determines how fast you have to double click to dodge"
         WinTop=0.582083
         WinLeft=0.502344
         WinWidth=0.421875
         WinHeight=0.045352
         TabOrder=9
         OnChange=UT2K4Tab_IForceSettings.InternalOnChange
         OnLoadINI=UT2K4Tab_IForceSettings.InternalOnLoadINI
     End Object
     fl_DodgeTime=moFloatEdit'GUI2K4.UT2K4Tab_IForceSettings.InputDodgeTime'

     Begin Object Class=GUIButton Name=ControlBindButton
         Caption="Configure Controls"
         SizingCaption="XXXXXXXXXX"
         Hint="Configure controls and keybinds"
         WinTop=0.018333
         WinLeft=0.130000
         WinWidth=0.153281
         WinHeight=0.043750
         TabOrder=0
         OnClick=UT2K4Tab_IForceSettings.InternalOnClick
         OnKeyEvent=ControlBindButton.InternalOnKeyEvent
     End Object
     b_Controls=GUIButton'GUI2K4.UT2K4Tab_IForceSettings.ControlBindButton'

     Begin Object Class=GUIButton Name=SpeechBindButton
         Caption="Speech Binder"
         SizingCaption="XXXXXXXXXX"
         Hint="Configure custom keybinds for in-game messages"
         WinTop=0.018333
         WinLeft=0.670000
         WinWidth=0.153281
         WinHeight=0.043750
         TabOrder=1
         OnClick=UT2K4Tab_IForceSettings.InternalOnClick
         OnKeyEvent=SpeechBindButton.InternalOnKeyEvent
     End Object
     b_Speech=GUIButton'GUI2K4.UT2K4Tab_IForceSettings.SpeechBindButton'

     ControlBindMenu="GUI2K4.ControlBinder"
     SpeechBindMenu="GUI2K4.SpeechBinder"
     PanelCaption="Input"
     PropagateVisibility=False
     WinTop=0.150000
     WinHeight=0.740000
}