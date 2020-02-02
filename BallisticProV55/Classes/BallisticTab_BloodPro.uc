//=============================================================================
// BallisticTab_BloodPro.
//
// Settings for the Ballistic blood and gore system
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class BallisticTab_BloodPro extends UT2K4TabPanel;

var automated moCheckbox    ch_BloodFX;
var automated moFloatEdit	fl_BloodTimeScale;
var automated moSlider		sl_GibMulti;

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
	ch_BloodFX.Checked(class'BloodManager'.default.bUseBloodEffects);
	fl_BloodTimeScale.SetValue(class'AD_BloodDecal'.default.StayScale);
	sl_GibMulti.SetValue(class'BloodManager'.default.GibMultiplier);
}

function SaveSettings()
{
	if (!bInitialized)
		return;
	class'AD_BloodDecal'.default.StayScale			= fl_BloodTimeScale.GetValue();
	class'BloodManager'.default.bUseBloodEffects	= ch_BloodFX.IsChecked();
	class'BloodManager'.default.GibMultiplier		= sl_GibMulti.GetValue();

	class'BWBloodControl'.static.StaticSaveConfig();
	class'BloodManager'.static.StaticSaveConfig();
	class'BallisticGib'.static.StaticSaveConfig();
	class'AD_BloodDecal'.static.StaticSaveConfig();
}

function DefaultSettings()
{
	ch_BloodFX.Checked(false);
	fl_BloodTimeScale.SetValue(1.0);
	//Radeon
	sl_GibMulti.SetValue(1);
}

defaultproperties
{
     Begin Object Class=moCheckBox Name=ch_BloodFXCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Blood Particle Effects"
         OnCreateComponent=ch_BloodFXCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Toggles blood effects when damaging players."
         WinTop=0.100000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_BloodFX=moCheckBox'BallisticProV55.BallisticTab_BloodPro.ch_BloodFXCheck'
	 
     Begin Object Class=moFloatEdit Name=fl_BloodTimeScaleFloat
         MinValue=0.000000
         MaxValue=100.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Blood Stay Scale"
         OnCreateComponent=fl_BloodTimeScaleFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales the life time of blood effects. 0 = Forever."
         WinTop=0.150000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_BloodTimeScale=moFloatEdit'BallisticProV55.BallisticTab_BloodPro.fl_BloodTimeScaleFloat'

     Begin Object Class=moSlider Name=sl_GibMultiSlider
         MaxValue=20.000000
         bIntSlider=True
         Caption="Gib Multiplier"
         OnCreateComponent=sl_GibMultiSlider.InternalOnCreateComponent
         Hint="Multiplies number of gibs spawned. 1 = Normal, 0 = None. WARNING: Higher than 1 may kill performance!"
         WinTop=0.200000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     sl_GibMulti=moSlider'BallisticProV55.BallisticTab_BloodPro.sl_GibMultiSlider'
}
