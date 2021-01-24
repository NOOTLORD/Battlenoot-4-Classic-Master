//=============================================================================
// BallisticTab_PreferencesPro.
//
// The preferences tab has options that are kept client-side and affect only
// the local player.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class BallisticTab_PreferencesPro extends UT2K4TabPanel;

var automated moCheckbox	ch_MSmoke, ch_OldCrosshairs, ch_bDrawCrosshairDot, ch_BloodFX;
var automated moComboBox	co_ADSHandling;
var automated moFloatEdit	fl_BrassTime;
var			  int			OldWeaponDet;
var BallisticConfigMenuPro		p_Anchor;
var bool					bInitialized;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.InitComponent(MyController, MyOwner);
	if (BallisticConfigMenuPro(Controller.ActivePage) != None)
		p_Anchor = BallisticConfigMenuPro(Controller.ActivePage);
}
function ShowPanel(bool bShow)
{
	super.ShowPanel(bShow);
	if (bInitialized)
		return;
	LoadSettings();
	bInitialized = true;
}

function LoadSettings()
{
	fl_BrassTime.SetValue(class'BallisticBrass'.default.LifeTimeScale);
	ch_MSmoke.Checked(class'BallisticMod'.default.bMuzzleSmoke);	
	ch_OldCrosshairs.Checked(class'BallisticWeapon'.default.bOldCrosshairs);
	ch_bDrawCrosshairDot.Checked(class'BallisticWeapon'.default.bDrawCrosshairDot);	
	ch_BloodFX.Checked(class'BloodManager'.default.bUseBloodEffects);
	
	co_ADSHandling.AddItem("Default" ,,string(0));
	co_ADSHandling.AddItem("Hold" ,,string(1));
	co_ADSHandling.ReadOnly(True);
	co_ADSHandling.SetIndex(class'BallisticWeapon'.default.ScopeHandling);	
}

function SaveSettings()
{
	if (!bInitialized)
		return;	
	class'BallisticMod'.default.bMuzzleSmoke 			    = ch_MSmoke.IsChecked();	
	class'BallisticBrass'.default.LifeTimeScale			    = fl_BrassTime.GetValue();
	class'BallisticWeapon'.default.bOldCrosshairs			= ch_OldCrosshairs.IsChecked();
	class'BallisticWeapon'.default.bDrawCrosshairDot	    = ch_bDrawCrosshairDot.IsChecked();	
	class'BloodManager'.default.bUseBloodEffects	        = ch_BloodFX.IsChecked();
	class'BallisticWeapon'.default.ScopeHandling		    = EScopeHandling(co_ADSHandling.GetIndex());
	
	class'Mut_Ballistic'.static.StaticSaveConfig();
	class'BallisticMod'.static.StaticSaveConfig();
	class'BallisticBrass'.static.StaticSaveConfig();
	class'BallisticPlayer'.static.StaticSaveConfig();
	class'BallisticWeapon'.static.StaticSaveConfig();
	class'BWBloodControl'.static.StaticSaveConfig();
	class'BloodManager'.static.StaticSaveConfig();
}

function DefaultSettings()
{
	fl_BrassTime.SetValue(0.10);
	ch_MSmoke.Checked(false);		
	ch_OldCrosshairs.Checked(false);
	ch_bDrawCrosshairDot.Checked(true);	
	ch_BloodFX.Checked(true);	
	co_ADSHandling.SetIndex(1);
}

defaultproperties
{ 
     Begin Object Class=moFloatEdit Name=fl_BrassTimeFloat
         MinValue=0.100000
         MaxValue=1.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Brass Life Scale"
         OnCreateComponent=fl_BrassTimeFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales the life time of ejected brass. 0 = Forever."
         WinTop=0.100000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_BrassTime=moFloatEdit'BallisticProV55.BallisticTab_PreferencesPro.fl_BrassTimeFloat'

     Begin Object Class=moCheckBox Name=ch_MSmokeCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Muzzle Smoke"
         OnCreateComponent=ch_MSmokeCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enable muzzle smoke emitting when firing guns."
         WinTop=0.150000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_MSmoke=moCheckBox'BallisticProV55.BallisticTab_PreferencesPro.ch_MSmokeCheck'

     Begin Object Class=moCheckBox Name=ch_OldCrosshairsCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Allow Static Crosshairs"
         OnCreateComponent=ch_OldCrosshairsCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Allows the player to set a static crosshairs."
         WinTop=0.200000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_OldCrosshairs=moCheckBox'BallisticProV55.BallisticTab_PreferencesPro.ch_OldCrosshairsCheck'

     Begin Object Class=moCheckBox Name=ch_bDrawCrosshairDotCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Draw Crosshair Dot"
         OnCreateComponent=ch_bDrawCrosshairDotCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Display's a dot in the center of the dynamic crosshair"
         WinTop=0.250000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_bDrawCrosshairDot=moCheckBox'BallisticProV55.BallisticTab_PreferencesPro.ch_bDrawCrosshairDotCheck'
	
     Begin Object Class=moCheckBox Name=ch_BloodFXCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Blood Particle Effects"
         OnCreateComponent=ch_BloodFXCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Toggles blood effects when damaging players."
         WinTop=0.300000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_BloodFX=moCheckBox'BallisticProV55.BallisticTab_PreferencesPro.ch_BloodFXCheck'
	 
	     Begin Object Class=moComboBox Name=co_ADSHandlingCombo
        ComponentJustification=TXTA_Left
        CaptionWidth=0.550000
        Caption="ADS Handling"
        OnCreateComponent=co_ADSHandlingCombo.InternalOnCreateComponent
        IniOption="@Internal"
        Hint="How the ADS key should function.||Default: Hold to raise the weapon into scope. Weapon stays in scope until key is pressed again.||Hold: Hold key to ADS. Release to lower.||Toggle: Press key to ADS. Press again to lower."
        WinTop=0.350000
        WinLeft=0.250000
     End Object
     co_ADSHandling=moComboBox'BallisticProV55.BallisticTab_PreferencesPro.co_ADSHandlingCombo'
}
