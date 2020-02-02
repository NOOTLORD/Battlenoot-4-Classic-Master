//=============================================================================
// BallisticTab_RulesPro.
//
// Server side options like rules that change the behaviour of the game and
// affect all players. These are used when hosting an MP or SP game.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class BallisticTab_RulesPro extends UT2K4TabPanel;

var automated moCheckbox    ch_StableSprint, ch_NoLongGun, ch_NoDodging, ch_DoubleJump;
var automated moSlider		sl_Accuracy, sl_Recoil, sl_Damage, sl_VDamage;
var automated moFloatEdit	fl_Damage, fl_VDamage;

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
	sl_Accuracy.SetValue(class'BallisticReplicationInfo'.default.AccuracyScale);
	sl_Recoil.SetValue(class'BallisticReplicationInfo'.default.RecoilScale);
	ch_StableSprint.Checked(class'BallisticReplicationInfo'.default.bNoJumpOffset);
	ch_NoLongGun.Checked(class'BallisticReplicationInfo'.default.bNoLongGun);
	fl_Damage.SetValue(class'Rules_Ballistic'.default.DamageScale);
	fl_VDamage.SetValue(class'Rules_Ballistic'.default.VehicleDamageScale);	
	ch_NoDodging.Checked(class'BallisticReplicationInfo'.default.bNoDodging);
	ch_DoubleJump.Checked(class'BallisticReplicationInfo'.default.bLimitDoubleJumps);
}

function SaveSettings()
{
	if (!bInitialized)
		return;
	class'BallisticReplicationInfo'.default.AccuracyScale	  = sl_Accuracy.GetValue();
	class'BallisticReplicationInfo'.default.RecoilScale		  = sl_Recoil.GetValue();	
	class'BallisticReplicationInfo'.default.bNoJumpOffset	  = ch_StableSprint.IsChecked();
	class'BallisticReplicationInfo'.default.bNoLongGun		  = ch_NoLongGun.IsChecked();
	class'Rules_Ballistic'.default.DamageScale 				  = fl_Damage.GetValue();
	class'Rules_Ballistic'.default.VehicleDamageScale		  = fl_VDamage.GetValue();	
	class'BallisticReplicationInfo'.default.bNoDodging		  = ch_NoDodging.IsChecked();
	class'BallisticReplicationInfo'.default.bLimitDoubleJumps = ch_DoubleJump.IsChecked();

	class'BallisticReplicationInfo'.static.StaticSaveConfig();
	class'BallisticWeapon'.static.StaticSaveConfig();
	class'Mut_Ballistic'.static.StaticSaveConfig();
	class'Rules_Ballistic'.static.StaticSaveConfig();
}

function DefaultSettings()
{
	sl_Accuracy.SetValue(1.0);
	sl_Recoil.SetValue(1.0);	
	ch_StableSprint.Checked(false);
	ch_NoLongGun.Checked(false);
	fl_Damage.SetValue(1.0);
	fl_VDamage.SetValue(1.0);	
	ch_NoDodging.Checked(false);
	ch_DoubleJump.Checked(false);
}

/*     Begin Object Class=moSlider Name=sl_DamageSlider
	     CaptionWidth=0.600000
         MaxValue=8.000000
         MinValue=0.050000
         Caption="Damage Scale"
         Hint="Scale the amount of damage done to non vehicles."
         WinTop=0.6
         WinLeft=0.250000
         WinWidth=0.500000
         WinHeight=0.04
     End Object
     sl_Damage=moSlider'BallisticTab_RulesPro.sl_DamageSlider'

     Begin Object Class=moSlider Name=sl_VDamageSlider
	     CaptionWidth=0.600000
         MaxValue=8.000000
         MinValue=0.050000
         Caption="Vehicle Damage Scale"
         Hint="Scale the amount of damage done to vehicles."
         WinTop=0.65
         WinLeft=0.250000
         WinWidth=0.500000
         WinHeight=0.04
     End Object
     sl_VDamage=moSlider'BallisticTab_RulesPro.sl_VDamageSlider'
*/

defaultproperties
{
     Begin Object Class=moSlider Name=sl_AccuracySlider
         MaxValue=2.000000
         Caption="Inaccuracy Scale"
         OnCreateComponent=sl_AccuracySlider.InternalOnCreateComponent
         Hint="Scale the inaccuracy of ballistic weapons."
         WinTop=0.100000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     sl_Accuracy=moSlider'BallisticProV55.BallisticTab_RulesPro.sl_AccuracySlider'

     Begin Object Class=moSlider Name=sl_RecoilSlider
         MaxValue=2.000000
         Caption="Recoil Scale"
         OnCreateComponent=sl_RecoilSlider.InternalOnCreateComponent
         Hint="Scale the amount of recoil applied to ballistic weapons."
         WinTop=0.150000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     sl_Recoil=moSlider'BallisticProV55.BallisticTab_RulesPro.sl_RecoilSlider'

     Begin Object Class=moCheckBox Name=ch_SprintAimCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Stable Jump/Sprint"
         OnCreateComponent=ch_SprintAimCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Disables weapon aiming off when jumping or sprinting"
         WinTop=0.200000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_StableSprint=moCheckBox'BallisticProV55.BallisticTab_RulesPro.ch_SprintAimCheck'

     Begin Object Class=moCheckBox Name=ch_NoLongGunCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="No Long Gun Shifting"
         OnCreateComponent=ch_NoLongGunCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Disables long weapons shifting off when too close to obstuctions"
         WinTop=0.250000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_NoLongGun=moCheckBox'BallisticProV55.BallisticTab_RulesPro.ch_NoLongGunCheck'

     Begin Object Class=moFloatEdit Name=fl_DamageFloat
         MinValue=0.000000
         MaxValue=100.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Damage Scale"
         OnCreateComponent=fl_DamageFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales the amount of damage done to non vehicles."
         WinTop=0.300000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_Damage=moFloatEdit'BallisticProV55.BallisticTab_RulesPro.fl_DamageFloat'

     Begin Object Class=moFloatEdit Name=fl_VDamageFloat
         MinValue=0.000000
         MaxValue=100.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.700000
         Caption="Vehicle Damage Scale"
         OnCreateComponent=fl_VDamageFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Scales the amount of damage done to vehicles."
         WinTop=0.350000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_VDamage=moFloatEdit'BallisticProV55.BallisticTab_RulesPro.fl_VDamageFloat'

     Begin Object Class=moCheckBox Name=ch_NoDodgingCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="No Dodging"
         OnCreateComponent=ch_NoDodgingCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Disables dodging for all players"
         WinTop=0.400000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_NoDodging=moCheckBox'BallisticProV55.BallisticTab_RulesPro.ch_NoDodgingCheck'

     Begin Object Class=moCheckBox Name=ch_DoubleJumpCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="No Double Jump"
         OnCreateComponent=ch_MotionBlurCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Disables the Double Jump capabilities of all players."
         WinTop=0.450000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_DoubleJump=moCheckBox'BallisticProV55.BallisticTab_RulesPro.ch_DoubleJumpCheck'
}
