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

var automated moCheckbox    ch_StableSprint, ch_NoLongGun, ch_NoDodging, ch_DoubleJump, ch_LimitCarry, ch_ToggleADS;
var automated moFloatEdit	fl_Damage, fl_VDamage, fl_Accuracy, fl_Recoil, fl_SightingTime;
var automated moNumericEdit int_MaxWeps;

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
	fl_Accuracy.SetValue(class'BallisticReplicationInfo'.default.AccuracyScale);
	fl_Recoil.SetValue(class'BallisticReplicationInfo'.default.RecoilScale);
	ch_StableSprint.Checked(class'BallisticReplicationInfo'.default.bNoJumpOffset);
	ch_NoLongGun.Checked(class'BallisticReplicationInfo'.default.bNoLongGun);
	fl_Damage.SetValue(class'Rules_Ballistic'.default.DamageScale);
	fl_VDamage.SetValue(class'Rules_Ballistic'.default.VehicleDamageScale);	
	ch_NoDodging.Checked(class'BallisticReplicationInfo'.default.bNoDodging);
	ch_DoubleJump.Checked(class'BallisticReplicationInfo'.default.bLimitDoubleJumps);
	fl_SightingTime.SetValue(class'BallisticWeapon'.default.SightingTimeScale);
	ch_ToggleADS.Checked(class'BallisticWeapon'.default.bSightLock);
	ch_LimitCarry.Checked(class'BallisticWeapon'.default.bLimitCarry);
	int_MaxWeps.SetValue(class'BallisticWeapon'.default.MaxWeaponsPerSlot);	
}

function SaveSettings()
{
	if (!bInitialized)
		return;
	class'BallisticReplicationInfo'.default.AccuracyScale	  = fl_Accuracy.GetValue();
	class'BallisticReplicationInfo'.default.RecoilScale		  = fl_Recoil.GetValue();	
	class'BallisticReplicationInfo'.default.bNoJumpOffset	  = ch_StableSprint.IsChecked();
	class'BallisticReplicationInfo'.default.bNoLongGun		  = ch_NoLongGun.IsChecked();
	class'Rules_Ballistic'.default.DamageScale 				  = fl_Damage.GetValue();
	class'Rules_Ballistic'.default.VehicleDamageScale		  = fl_VDamage.GetValue();	
	class'BallisticReplicationInfo'.default.bNoDodging		  = ch_NoDodging.IsChecked();
	class'BallisticReplicationInfo'.default.bLimitDoubleJumps = ch_DoubleJump.IsChecked();
	class'BallisticWeapon'.default.SightingTimeScale          = fl_SightingTime.GetValue();
    class'BallisticWeapon'.default.bSightLock 	              = ch_ToggleADS.IsChecked();
	class'BallisticWeapon'.default.bLimitCarry                = ch_LimitCarry.IsChecked();
	class'BallisticWeapon'.default.MaxWeaponsPerSlot          = int_MaxWeps.GetValue();

	class'BallisticReplicationInfo'.static.StaticSaveConfig();
	class'BallisticWeapon'.static.StaticSaveConfig();
	class'Mut_Ballistic'.static.StaticSaveConfig();
	class'Rules_Ballistic'.static.StaticSaveConfig();
	class'BallisticInstantFire'.static.StaticSaveConfig();
	class'BallisticProjectile'.static.StaticSaveConfig();		
}

function DefaultSettings()
{
	fl_Accuracy.SetValue(0.30);
	fl_Recoil.SetValue(0.25);	
	ch_StableSprint.Checked(false);
	ch_NoLongGun.Checked(true);
	fl_Damage.SetValue(1.0);
	fl_VDamage.SetValue(1.0);	
	ch_NoDodging.Checked(true);
	ch_DoubleJump.Checked(false);
	fl_SightingTime.SetValue(1.00);
	ch_ToggleADS.Checked(false);
	ch_LimitCarry.Checked(True);
	int_MaxWeps.SetValue(1);
}

defaultproperties
{
     Begin Object Class=moFloatEdit Name=fl_AccuracyFloat
         MinValue=0.500000	 
         MaxValue=2.000000
         CaptionWidth=0.750000		 
         Caption="Inaccuracy Scale"
         OnCreateComponent=fl_AccuracyFloat.InternalOnCreateComponent
         Hint="Scale the inaccuracy of ballistic weapons."
         WinTop=0.100000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_Accuracy=moFloatEdit'BallisticProV55.BallisticTab_RulesPro.fl_AccuracyFloat'

     Begin Object Class=moFloatEdit Name=fl_RecoilFloat
	     MinValue=0.500000	 
         MaxValue=2.000000
         CaptionWidth=0.750000		 
         Caption="Recoil Scale"
         OnCreateComponent=fl_RecoilFloat.InternalOnCreateComponent
         Hint="Scale the amount of recoil applied to ballistic weapons."
         WinTop=0.150000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_Recoil=moFloatEdit'BallisticProV55.BallisticTab_RulesPro.fl_RecoilFloat'

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
         CaptionWidth=0.750000
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
         CaptionWidth=0.750000
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
         OnCreateComponent=ch_DoubleJumpCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Disables the Double Jump capabilities of all players."
         WinTop=0.450000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_DoubleJump=moCheckBox'BallisticProV55.BallisticTab_RulesPro.ch_DoubleJumpCheck'
	 
     Begin Object Class=moFloatEdit Name=fl_SightingTimeFloat
         MinValue=0.500000
         MaxValue=2.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.750000
         Caption="Sighting time scale"
         OnCreateComponent=fl_SightingTimeFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Multiplier of the time it takes to move weapon to and from sight view."
         WinTop=0.500000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_SightingTime=moFloatEdit'BallisticProV55.BallisticTab_RulesPro.fl_SightingTimeFloat'

     Begin Object Class=moCheckBox Name=ch_ToggleADSCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Toggle ADS mode"
         OnCreateComponent=ch_ToggleADSCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="If enabled, ADS will be toggle and will not unscope if u let go of your ADS key, if Disabled it will be Hold to ADS."
         WinTop=0.550000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_ToggleADS=moCheckBox'BallisticProV55.BallisticTab_RulesPro.ch_ToggleADSCheck'

     Begin Object Class=moCheckBox Name=ch_LimitCarryCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Limit Carrying Capacity"
         OnCreateComponent=ch_LimitCarryCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="If enabled, you can only carry a limited number of weapons of each type."
         WinTop=0.600000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_LimitCarry=moCheckBox'BallisticProV55.BallisticTab_RulesPro.ch_LimitCarryCheck'

     Begin Object Class=moNumericEdit Name=int_MaxWepsInt
         MinValue=1
         MaxValue=3
         ComponentJustification=TXTA_Left
         CaptionWidth=0.800000
         Caption="Maximum Weapons Per Slot"
         OnCreateComponent=int_MaxWepsInt.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Sets the maximum number of weapons a player can carry in each InventoryGroup if Limit Carry is on."
         WinTop=0.650000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     int_MaxWeps=moNumericEdit'BallisticProV55.BallisticTab_RulesPro.int_MaxWepsInt' 
}
