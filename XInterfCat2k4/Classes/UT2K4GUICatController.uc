// ====================================================================
//  Written by Joe Wilcox
//  (c) 2002, Epic Games, Inc.  All Rights Reserved
// ====================================================================

class UT2K4GUICatController extends UT2K4GUIController;   // GUIController;




#exec OBJ LOAD FILE=InterfaceContent.utx
#exec OBJ LOAD FIlE=Cat2K4Menus.utx
#exec OBJ LOAD FILE=2K4MenuSounds.uax

function SetMouseCursor()
{
        MouseCursors[0]=Texture'Cat2K4Menus.Cursors.Pointer';
}

function ReturnToMainMenu()
{
	CloseAll(true);

	if ( MenuStack.Length == 0 )
		OpenMenu(GetMainMenuClass());
}

function bool SetFocusTo( FloatingWindow Menu )
{
	local int i;

	if ( ActivePage == Menu )
		return true;

	for ( i = 0; i < MenuStack.Length; i++ )
	{
		if ( FloatingWindow(MenuStack[i]) == None )
			continue;

		if ( MenuStack[i] == Menu )
		{
			if ( i + 1 < MenuStack.Length )
			{
				MenuStack[i+1].ParentPage = Menu.ParentPage;
				Menu.ParentPage = MenuStack[MenuStack.Length - 1];
			}

			MenuStack[MenuStack.Length] = Menu;
			MenuStack.Remove(i,1);
			ActivePage = Menu;
			return true;
		}
	}

	return false;
}

// If the disconnect menu is opened while any other menus are on the stack, they will remain there, since the
// disconnect options menu cannot be closed, only replaced
event bool OpenMenu(string NewMenuName, optional string Param1, optional string Param2)
{
	if ( NewMenuName ~= class'GameEngine'.default.DisconnectMenuClass
	&& ( InStr(Param1,"?closed") != -1 || InStr(Param1,"?failed") != -1 || InStr(Param1,"?disconnect") != -1 ) )
	{
		if ( bModAuthor )
			log("Opening disconnect menu with failed, closed, or disconnect in URL",'ModAuthor');

		CloseAll(True,True);
	}

	return Super.OpenMenu(NewMenuName, Param1, Param2);
}

// Should override this function if you have less options in your custom start menu
static simulated event Validate()
{
	if ( default.MainMenuOptions.Length < 7 )
		ResetConfig();
}

static simulated function string GetSinglePlayerPage()
{
	Validate();
	return default.MainMenuOptions[0];
}

static simulated function string GetServerBrowserPage()
{
	Validate();
	return default.MainMenuOptions[1];
}

static simulated function string GetMultiplayerPage()
{
	Validate();
	return default.MainMenuOptions[2];
}

static simulated function string GetInstantActionPage()
{
	Validate();
	return default.MainMenuOptions[3];
}

static simulated function string GetModPage()
{
	Validate();
	return default.MainMenuOptions[4];
}

static simulated function string GetSettingsPage()
{
	Validate();
	return default.MainMenuOptions[5];
}

static simulated function string GetQuitPage()
{
	Validate();
	return default.MainMenuOptions[6];
}

// 20%!! increase in menu load speed for menus that contain large numbers of the same component
// (such as GUIMenuOption)
function class<GUIComponent> AddComponentClass(string ClassName)
{
	local int i;
	local class<GUIComponent> Cls;


	for ( i = 0; i < RegisteredClasses.Length; i++ )
		if ( string(RegisteredClasses[i]) ~= ClassName )
			return RegisteredClasses[i];

	Cls = class<GUIComponent>(DynamicLoadObject(ClassName,class'Class'));
	if ( Cls != None )

		RegisteredClasses[RegisteredClasses.Length] = Cls;

	return Cls;
}

function PurgeComponentClasses()
{
	if ( RegisteredClasses.Length > 0 )
		RegisteredClasses.Remove(0, RegisteredClasses.Length);

	Super.PurgeComponentClasses();
}

defaultproperties
{
}
