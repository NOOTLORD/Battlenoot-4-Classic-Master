//=====================================
// Additional Rules tab.
//
// Contains additional game rules for BallisticPro.
//=====================================

class BallisticTab_ProSettings extends UT2K4TabPanel;

var automated moFloatEdit fl_HeadPct, fl_LimbPct;
var automated moCheckbox  ch_DmgModifier, ch_LimitCarry;
var automated moNumericEdit int_MaxWeps;

var BallisticConfigMenuPro p_Anchor;
var bool bInitialised;

function InitComponent(GUIController myController, GUIComponent myOwner)
{
	Super.InitComponent(myController, myOwner);
	if(BallisticConfigMenuPro(Controller.ActivePage) != None)
	p_Anchor = BallisticConfigMenuPro(Controller.ActivePage);
}

function ShowPanel (bool bShow)
{
	super.ShowPanel(bShow);
	if(bInitialised)
	return;
	LoadSettings();
	bInitialised=True;
}

function LoadSettings()
{
	ch_DmgModifier.Checked(class'BallisticWeapon'.default.bUseModifiers);
	fl_HeadPct.SetValue(class'BallisticInstantFire'.default.DamageModHead);
	fl_LimbPct.SetValue(class'BallisticInstantFire'.default.DamageModLimb);
	ch_LimitCarry.Checked(class'BallisticWeapon'.default.bLimitCarry);
	int_MaxWeps.SetValue(class'BallisticWeapon'.default.MaxWeaponsPerSlot);
}

function SaveSettings()
{
	if(!bInitialised)
		return;
	class'BallisticWeapon'.default.bUseModifiers = ch_DmgModifier.IsChecked();
	class'BallisticInstantFire'.default.DamageModHead = fl_HeadPct.GetValue();
	class'BallisticInstantFire'.default.DamageModLimb = fl_LimbPct.GetValue();
	class'BallisticProjectile'.default.DamageModHead = fl_HeadPct.GetValue();
	class'BallisticProjectile'.default.DamageModLimb = fl_LimbPct.GetValue();
	class'BallisticWeapon'.default.bLimitCarry = ch_LimitCarry.IsChecked();
	class'BallisticWeapon'.default.MaxWeaponsPerSlot = int_MaxWeps.GetValue();
	class'BallisticReplicationInfo'.static.StaticSaveConfig();
	class'BallisticWeapon'.static.StaticSaveConfig();
	class'BallisticInstantFire'.static.StaticSaveConfig();
	class'BallisticProjectile'.static.StaticSaveConfig();
}

function DefaultSettings()
{
	fl_HeadPct.SetValue(1.5);
	fl_LimbPct.SetValue(0.75);
	ch_LimitCarry.Checked(False);
	int_MaxWeps.SetValue(1);
}

defaultproperties
{
     Begin Object Class=moCheckBox Name=ch_DmgModifierCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Use Damage Modifiers"
         OnCreateComponent=ch_DmgModifierCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Enable to use config modifiers for head and limb damage."
         WinTop=0.100000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_DmgModifier=moCheckBox'BallisticProV55.BallisticTab_ProSettings.ch_DmgModifierCheck'

     Begin Object Class=moFloatEdit Name=fl_HeadPctFloat
         MinValue=1.000000
         MaxValue=5.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.800000
         Caption="Headshot Damage Modifier"
         OnCreateComponent=fl_HeadPctFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Headshot damage is base damage multiplied by this if modifiers are enabled."
         WinTop=0.150000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_HeadPct=moFloatEdit'BallisticProV55.BallisticTab_ProSettings.fl_HeadPctFloat'

     Begin Object Class=moFloatEdit Name=fl_LimbPctFloat
         MinValue=0.100000
         MaxValue=1.000000
         ComponentJustification=TXTA_Left
         CaptionWidth=0.800000
         Caption="Limb Damage Modifier"
         OnCreateComponent=fl_LimbPctFloat.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Limb damage is base damage multiplied by this if modifiers are enabled."
         WinTop=0.200000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     fl_LimbPct=moFloatEdit'BallisticProV55.BallisticTab_ProSettings.fl_LimbPctFloat'

     Begin Object Class=moCheckBox Name=ch_LimitCarryCheck
         ComponentJustification=TXTA_Left
         CaptionWidth=0.900000
         Caption="Limit Carrying Capacity"
         OnCreateComponent=ch_LimitCarryCheck.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="If enabled, you can only carry a limited number of weapons of each type."
         WinTop=0.250000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     ch_LimitCarry=moCheckBox'BallisticProV55.BallisticTab_ProSettings.ch_LimitCarryCheck'

     Begin Object Class=moNumericEdit Name=int_MaxWepsInt
         MinValue=1
         MaxValue=3
         ComponentJustification=TXTA_Left
         CaptionWidth=0.800000
         Caption="Maximum Weapons Per Slot"
         OnCreateComponent=int_MaxWepsInt.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Sets the maximum number of weapons a player can carry in each InventoryGroup if Limit Carry is on."
         WinTop=0.300000
         WinLeft=0.250000
         WinHeight=0.040000
     End Object
     int_MaxWeps=moNumericEdit'BallisticProV55.BallisticTab_ProSettings.int_MaxWepsInt'
}
