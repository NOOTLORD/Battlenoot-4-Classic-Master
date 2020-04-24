class BallisticProMenuPanel extends MidGamePanel
   dependsOn(Interactions);

var automated KeyBindEdit e_ADSEdit;
var automated KeyBindEdit e_ReloadEdit;
var automated KeyBindEdit e_WpnSpcEdit;
var automated KeyBindEdit e_SprintEdit;
var automated KeyBindEdit e_FireModeEdit;
var automated KeyBindEdit e_LoadoutEdit;

var automated GUILabel l_ADSLabel;
var automated GUILabel l_ReloadLabel;
var automated GUILabel l_WpnSpcLabel;
var automated GUILabel l_SprintLabel;
var automated GUILabel l_FireModeLabel;
var automated GUILabel l_LoadoutLabel;

var automated GUIEditBox b_Caption;

var localized string ADSText;
var localized string ReloadText;
var localized string WpnSpcText;
var localized string SprintText;
var localized string LoadoutText;
var localized string FireModeText;
var localized string CaptionText;

function InitComponent( GUIController InController, GUIComponent InOwner )
{
   b_Caption.Caption = CaptionText;
   l_ADSLabel.Caption = ADSText;
   l_ReloadLabel.Caption = ReloadText;
   l_WpnSpcLabel.Caption = WpnSpcText;
   l_SprintLabel.Caption = SprintText;
   l_FireModeLabel.Caption = FireModeText;
   l_LoadoutLabel.Caption = LoadoutText;
   Super.InitComponent(InController, InOwner);
}

function ADSKeyInit(out byte keyCode)
{
   keyCode = class'BallisticProInteractions'.default.ADSKey;
}

function ReloadKeyInit(out byte keyCode)
{
   keyCode = class'BallisticProInteractions'.default.ReloadKey;
}

function WpnSpcKeyInit(out byte keyCode)
{
   keyCode = class'BallisticProInteractions'.default.WpnSpcKey;
}

function SprintKeyInit(out byte keyCode)
{
   keyCode = class'BallisticProInteractions'.default.SprintKey;
}

function FireModeKeyInit(out byte keyCode)
{
   keyCode = class'BallisticProInteractions'.default.FireModeKey;
}

function LoadoutKeyInit(out byte keyCode)
{
   keyCode = class'BallisticProInteractions'.default.LoadoutKey;
}

function ADSKeyChanged(byte keyCode)
{
   class'BallisticProInteractions'.default.ADSKey = EInputKey(keyCode);
   class'BallisticProInteractions'.static.StaticSaveConfig();
}

function ReloadKeyChanged(byte keyCode)
{
   class'BallisticProInteractions'.default.ReloadKey = EInputKey(keyCode);
   class'BallisticProInteractions'.static.StaticSaveConfig();
}

function WpnSpcKeyChanged(byte keyCode)
{
   class'BallisticProInteractions'.default.WpnSpcKey = EInputKey(keyCode);
   class'BallisticProInteractions'.static.StaticSaveConfig();
}

function SprintKeyChanged(byte keyCode)
{
   class'BallisticProInteractions'.default.SprintKey = EInputKey(keyCode);
   class'BallisticProInteractions'.static.StaticSaveConfig();
}

function FireModeKeyChanged(byte keyCode)
{
   class'BallisticProInteractions'.default.FireModeKey = EInputKey(keyCode);
   class'BallisticProInteractions'.static.StaticSaveConfig();
}

function LoadoutKeyChanged(byte keyCode)
{
   class'BallisticProInteractions'.default.LoadoutKey = EInputKey(keyCode);
   class'BallisticProInteractions'.static.StaticSaveConfig();
}

defaultproperties
{
     Begin Object Class=KeyBindEdit Name=ADSEdit
         OnInitKey=BallisticProMenuPanel.ADSKeyInit
         OnKeyChanged=BallisticProMenuPanel.ADSKeyChanged
         WinTop=0.090000
         WinLeft=0.550000
         WinWidth=0.150000
         WinHeight=0.040000
         OnActivate=ADSEdit.InternalActivate
         OnDeActivate=ADSEdit.InternalDeactivate
         OnClick=ADSEdit.MouseClick
         OnKeyType=ADSEdit.InternalOnKeyType
         OnKeyEvent=ADSEdit.InternalOnKeyEvent
     End Object
     e_ADSEdit=KeyBindEdit'BWInteractions3.BallisticProMenuPanel.ADSEdit'

     Begin Object Class=KeyBindEdit Name=ReloadEdit
         OnInitKey=BallisticProMenuPanel.ReloadKeyInit
         OnKeyChanged=BallisticProMenuPanel.ReloadKeyChanged
         WinTop=0.155000
         WinLeft=0.550000
         WinWidth=0.150000
         WinHeight=0.040000
         OnActivate=ReloadEdit.InternalActivate
         OnDeActivate=ReloadEdit.InternalDeactivate
         OnClick=ReloadEdit.MouseClick
         OnKeyType=ReloadEdit.InternalOnKeyType
         OnKeyEvent=ReloadEdit.InternalOnKeyEvent
     End Object
     e_ReloadEdit=KeyBindEdit'BWInteractions3.BallisticProMenuPanel.ReloadEdit'

     Begin Object Class=KeyBindEdit Name=WpnSpcEdit
         OnInitKey=BallisticProMenuPanel.WpnSpcKeyInit
         OnKeyChanged=BallisticProMenuPanel.WpnSpcKeyChanged
         WinTop=0.220000
         WinLeft=0.550000
         WinWidth=0.150000
         WinHeight=0.040000
         OnActivate=WpnSpcEdit.InternalActivate
         OnDeActivate=WpnSpcEdit.InternalDeactivate
         OnClick=WpnSpcEdit.MouseClick
         OnKeyType=WpnSpcEdit.InternalOnKeyType
         OnKeyEvent=WpnSpcEdit.InternalOnKeyEvent
     End Object
     e_WpnSpcEdit=KeyBindEdit'BWInteractions3.BallisticProMenuPanel.WpnSpcEdit'

     Begin Object Class=KeyBindEdit Name=SprintEdit
         OnInitKey=BallisticProMenuPanel.SprintKeyInit
         OnKeyChanged=BallisticProMenuPanel.SprintKeyChanged
         WinTop=0.290000
         WinLeft=0.550000
         WinWidth=0.150000
         WinHeight=0.040000
         OnActivate=SprintEdit.InternalActivate
         OnDeActivate=SprintEdit.InternalDeactivate
         OnClick=SprintEdit.MouseClick
         OnKeyType=SprintEdit.InternalOnKeyType
         OnKeyEvent=SprintEdit.InternalOnKeyEvent
     End Object
     e_SprintEdit=KeyBindEdit'BWInteractions3.BallisticProMenuPanel.SprintEdit'

     Begin Object Class=KeyBindEdit Name=FireModeEdit
         OnInitKey=BallisticProMenuPanel.FireModeKeyInit
         OnKeyChanged=BallisticProMenuPanel.FireModeKeyChanged
         WinTop=0.360000
         WinLeft=0.550000
         WinWidth=0.150000
         WinHeight=0.040000
         OnActivate=FireModeEdit.InternalActivate
         OnDeActivate=FireModeEdit.InternalDeactivate
         OnClick=FireModeEdit.MouseClick
         OnKeyType=FireModeEdit.InternalOnKeyType
         OnKeyEvent=FireModeEdit.InternalOnKeyEvent
     End Object
     e_FireModeEdit=KeyBindEdit'BWInteractions3.BallisticProMenuPanel.FireModeEdit'

     Begin Object Class=KeyBindEdit Name=LoadoutEdit
         OnInitKey=BallisticProMenuPanel.LoadoutKeyInit
         OnKeyChanged=BallisticProMenuPanel.LoadoutKeyChanged
         WinTop=0.430000
         WinLeft=0.550000
         WinWidth=0.150000
         WinHeight=0.040000
         OnActivate=LoadoutEdit.InternalActivate
         OnDeActivate=LoadoutEdit.InternalDeactivate
         OnClick=LoadoutEdit.MouseClick
         OnKeyType=LoadoutEdit.InternalOnKeyType
         OnKeyEvent=LoadoutEdit.InternalOnKeyEvent
     End Object
     e_LoadoutEdit=KeyBindEdit'BWInteractions3.BallisticProMenuPanel.LoadoutEdit'

     Begin Object Class=GUILabel Name=ADSLabel
         TextColor=(B=255,G=255,R=255)
         WinTop=0.090000
         WinLeft=0.345000
         WinWidth=0.150000
         WinHeight=0.040000
     End Object
     l_ADSLabel=GUILabel'BWInteractions3.BallisticProMenuPanel.ADSLabel'

     Begin Object Class=GUILabel Name=ReloadLabel
         TextColor=(B=255,G=255,R=255)
         WinTop=0.150000
         WinLeft=0.345000
         WinWidth=0.150000
         WinHeight=0.040000
     End Object
     l_ReloadLabel=GUILabel'BWInteractions3.BallisticProMenuPanel.ReloadLabel'

     Begin Object Class=GUILabel Name=WpnSpcLabel
         TextColor=(B=255,G=255,R=255)
         WinTop=0.220000
         WinLeft=0.345000
         WinWidth=0.180000
         WinHeight=0.040000
     End Object
     l_WpnSpcLabel=GUILabel'BWInteractions3.BallisticProMenuPanel.WpnSpcLabel'

     Begin Object Class=GUILabel Name=SprintLabel
         TextColor=(B=255,G=255,R=255)
         WinTop=0.290000
         WinLeft=0.345000
         WinWidth=0.150000
         WinHeight=0.040000
     End Object
     l_SprintLabel=GUILabel'BWInteractions3.BallisticProMenuPanel.SprintLabel'

     Begin Object Class=GUILabel Name=FireModeLabel
         TextColor=(B=255,G=255,R=255)
         WinTop=0.360000
         WinLeft=0.345000
         WinWidth=0.150000
         WinHeight=0.040000
     End Object
     l_FireModeLabel=GUILabel'BWInteractions3.BallisticProMenuPanel.FireModeLabel'

     Begin Object Class=GUILabel Name=LoadoutLabel
         TextColor=(B=255,G=255,R=255)
         WinTop=0.430000
         WinLeft=0.345000
         WinWidth=0.150000
         WinHeight=0.040000
     End Object
     l_LoadoutLabel=GUILabel'BWInteractions3.BallisticProMenuPanel.LoadoutLabel'
	 
     Begin Object Class=GUIEditBox Name=MyBorder
         bReadOnly=True
         WinTop=0.025000
         WinLeft=0.010000
         WinWidth=0.980000
         WinHeight=0.040000
         bTabStop=False
         bNeverFocus=True
         OnActivate=MyBorder.InternalActivate
         OnDeActivate=MyBorder.InternalDeactivate
         OnKeyType=MyBorder.InternalOnKeyType
         OnKeyEvent=MyBorder.InternalOnKeyEvent
     End Object
     b_Caption=GUIEditBox'BWInteractions3.BallisticProMenuPanel.MyBorder'

     ADSText="Iron Sights"
     ReloadText="Reload"
     WpnSpcText="Wep Function"
     SprintText="Sprint"
     LoadoutText="Loadout Menu"
     FireModeText="Fire Mode"
     CaptionText="Key Assignments"
}
