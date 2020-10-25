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

var automated moCheckbox	ch_UseBrass, ch_MSmoke, ch_SimpleDeathMessages, ch_OldCrosshairs, ch_bDrawCrosshairDot, ch_BloodFX;
var automated moComboBox	co_WeaponDet, co_EffectDet;
var automated moFloatEdit	fl_BrassTime, fl_BloodTimeScale;
var automated moSlider		sl_GibMulti;
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
	local int i;

	ch_UseBrass.Checked(class'BallisticMod'.default.bEjectBrass);
	ch_MSmoke.Checked(class'BallisticMod'.default.bMuzzleSmoke);
	fl_BrassTime.SetValue(class'BallisticBrass'.default.LifeTimeScale);
	ch_SimpleDeathMessages.Checked(class'BallisticDamageType'.default.bSimpleDeathMessages);
	ch_OldCrosshairs.Checked(class'BallisticWeapon'.default.bOldCrosshairs);
	ch_bDrawCrosshairDot.Checked(class'BallisticWeapon'.default.bDrawCrosshairDot);
	ch_BloodFX.Checked(class'BloodManager'.default.bUseBloodEffects);
	fl_BloodTimeScale.SetValue(class'AD_BloodDecal'.default.StayScale);
	sl_GibMulti.SetValue(class'BloodManager'.default.GibMultiplier);

	for (i=1;i<6;i+=2)
	    co_EffectDet.AddItem(class'UT2K4Tab_DetailSettings'.default.DetailLevels[i] ,,string(i));
	co_EffectDet.ReadOnly(True);
	co_EffectDet.SetIndex(class'BallisticMod'.default.EffectsDetailMode);
		

	for (i=0;i<9;i++)
		co_WeaponDet.AddItem(class'UT2K4Tab_DetailSettings'.default.DetailLevels[i]);
	co_WeaponDet.ReadOnly(True);
	OldWeaponDet = co_WeaponDet.FindIndex(p_Anchor.GetDisplayString(PlayerOwner().ConsoleCommand("get ini:Engine.Engine.ViewportManager TextureDetailWeaponSkin")));
	co_WeaponDet.SilentSetIndex(OldWeaponDet);
}

function SaveSettings()
{
	if (!bInitialized)
		return;
	class'BallisticWeapon'.default.bOldCrosshairs			=	ch_OldCrosshairs.IsChecked();
	class'BallisticWeapon'.default.bDrawCrosshairDot			=	ch_bDrawCrosshairDot.IsChecked();
	class'BallisticMod'.default.EffectsDetailMode 		= ELLHDetailMode(co_EffectDet.GetIndex());
	class'BallisticMod'.default.bEjectBrass 			= ch_useBrass.IsChecked();
	class'BallisticMod'.default.bMuzzleSmoke 			= ch_MSmoke.IsChecked();
	class'BallisticBrass'.default.LifeTimeScale			= fl_BrassTime.GetValue();
	class'BallisticDamageType'.default.bSimpleDeathMessages	= ch_SimpleDeathMessages.IsChecked();
	class'AD_BloodDecal'.default.StayScale			= fl_BloodTimeScale.GetValue();
	class'BloodManager'.default.bUseBloodEffects	= ch_BloodFX.IsChecked();
	class'BloodManager'.default.GibMultiplier		= sl_GibMulti.GetValue();
	
	class'BallisticDamageType'.static.StaticSaveConfig();
	class'Mut_Ballistic'.static.StaticSaveConfig();
	class'BallisticMod'.static.StaticSaveConfig();
	class'BallisticBrass'.static.StaticSaveConfig();
	class'BallisticPlayer'.static.StaticSaveConfig();
	class'BallisticWeapon'.static.StaticSaveConfig();
	class'BWBloodControl'.static.StaticSaveConfig();
	class'BloodManager'.static.StaticSaveConfig();
	class'BallisticGib'.static.StaticSaveConfig();
	class'AD_BloodDecal'.static.StaticSaveConfig();	

	if (co_WeaponDet.GetIndex() != OldWeaponDet)
	{
		PlayerOwner().ConsoleCommand("set ini:Engine.Engine.ViewportManager TextureDetailWeaponSkin"@p_Anchor.DetailSettings[co_WeaponDet.GetIndex()]);
		PlayerOwner().ConsoleCommand("flush");
	}
}

function DefaultSettings()
{
	co_EffectDet.SetIndex(2);
	co_WeaponDet.SilentSetIndex(OldWeaponDet);
	ch_UseBrass.Checked(true);
	fl_BrassTime.SetValue(0.10);
	ch_OldCrosshairs.Checked(false);
	ch_bDrawCrosshairDot.Checked(true);
	ch_MSmoke.Checked(false);
	ch_SimpleDeathMessages.Checked(true);
	ch_BloodFX.Checked(true);
	fl_BloodTimeScale.SetValue(0.10);
	sl_GibMulti.SetValue(0);	
}

defaultproperties
{

     Begin Object Class=moComboBox Name=co_WeaponDetCombo
         ComponentJustification=TXTA_Left
         CaptionWidth=0.550000
         Caption="Weapon Detail"
         OnCreateComponent=co_WeaponDetCombo.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="High"
         Hint="Choose the detail level for weapon textures. This should be set after changing the 'Character Detail' setting in the options menu as it will override this setting."
         WinTop=0.100000
         WinLeft=0.250000
     End Object
     co_WeaponDet=moComboBox'BallisticProV55.BallisticTab_PreferencesPro.co_WeaponDetCombo'

     Begin Object Class=moComboBox Name=co_EffectDetCombo
         ComponentJustification=TXTA_Left
         CaptionWidth=0.550000
         Caption="Effects Quality"
         OnCreateComponent=co_EffectDetCombo.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="High"
         Hint="Choose the quality level for Ballistic effects. Remember, if the 'World Detail' setting is lower, it will affect the quality of BW effects."
         WinTop=0.150000
         WinLeft=0.250000
     End Object
     co_EffectDet=moComboBox'BallisticProV55.BallisticTab_PreferencesPro.co_EffectDetCombo'
	 
     Begin Object Class=moCheckBox Name=ch_UseBrassCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Eject Brass"
         OnCreateComponent=ch_UseBrassCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Allow weapons to spew out shell casings and similar effects."
         WinTop=0.200000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_UseBrass=moCheckBox'BallisticProV55.BallisticTab_PreferencesPro.ch_UseBrassCheck'

     Begin Object Class=moFloatEdit Name=fl_BrassTimeFloat
         MinValue=0.000000
         MaxValue=100.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Brass Life Scale"
         OnCreateComponent=fl_BrassTimeFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales the life time of ejected brass. 0 = Forever."
         WinTop=0.250000
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
         WinTop=0.300000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_MSmoke=moCheckBox'BallisticProV55.BallisticTab_PreferencesPro.ch_MSmokeCheck'

     Begin Object Class=moCheckBox Name=ch_SimpleDeathMessagesCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Simplify Death Messages"
         OnCreateComponent=ch_SimpleDeathMessagesCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Renders death messages as Killer [Weapon] Killed"
         WinTop=0.350000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_SimpleDeathMessages=moCheckBox'BallisticProV55.BallisticTab_PreferencesPro.ch_SimpleDeathMessagesCheck'

     Begin Object Class=moCheckBox Name=ch_OldCrosshairsCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="UT2004 Crosshairs"
         OnCreateComponent=ch_OldCrosshairsCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Drops back to UT2004 crosshairs."
         WinTop=0.400000
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
         Hint="Display's a dot in the center of the crosshair"
         WinTop=0.450000
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
         WinTop=0.500000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_BloodFX=moCheckBox'BallisticProV55.BallisticTab_PreferencesPro.ch_BloodFXCheck'
	 
     Begin Object Class=moFloatEdit Name=fl_BloodTimeScaleFloat
         MinValue=0.000000
         MaxValue=100.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Blood Stay Scale"
         OnCreateComponent=fl_BloodTimeScaleFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales the life time of blood effects. 0 = Forever."
         WinTop=0.550000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_BloodTimeScale=moFloatEdit'BallisticProV55.BallisticTab_PreferencesPro.fl_BloodTimeScaleFloat'

     Begin Object Class=moSlider Name=sl_GibMultiSlider
         MaxValue=20.000000
         bIntSlider=True
         Caption="Gib Multiplier"
         OnCreateComponent=sl_GibMultiSlider.InternalOnCreateComponent
         Hint="Multiplies number of gibs spawned. 1 = Normal, 0 = None. WARNING: Higher than 1 may kill performance!"
         WinTop=0.600000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     sl_GibMulti=moSlider'BallisticProV55.BallisticTab_PreferencesPro.sl_GibMultiSlider'	 
}
