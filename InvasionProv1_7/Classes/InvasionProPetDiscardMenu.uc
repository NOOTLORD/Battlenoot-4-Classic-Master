class InvasionProPetDiscardMenu extends GUICustomPropertyPage;

var() Automated GUILabel currentDiscardText;
var() InvasionProPetStatsItem MyPetStats;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.InitComponent(MyController, MyOwner);

	t_WindowTitle.Caption = "Pet Selection";
	b_OK.WinWidth = default.b_OK.WinWidth;
	b_OK.WinHeight = default.b_OK.WinHeight;
	b_OK.WinLeft = default.b_OK.WinLeft;
	b_OK.WinTop = default.b_OK.WinTop;
	b_Cancel.WinWidth = default.b_Cancel.WinWidth;
	b_Cancel.WinHeight = default.b_Cancel.WinHeight;
	b_Cancel.WinLeft = default.b_Cancel.WinLeft;
	b_Cancel.WinTop = default.b_Cancel.WinTop;

	if(InvasionProPetMenuConfig(ParentPage) != None)
	{
		MyPetStats = InvasionProPetMenuConfig(ParentPage).MyPetStats;
	}
}

function bool InternalOnClick(GUIComponent Sender)
{

	if(Sender == b_OK)
	{
		if(MyPetStats != None)
		{
			MyPetStats.DiscardPet(false);
		}
	}

	Controller.CloseMenu(false);
	return true;
}

defaultproperties
{
     Begin Object Class=GUILabel Name=DiscardText
         Caption="Are you sure you want to discard your pet and choose a new one? (Discarded pets lose all of their abilities)."
         TextAlign=TXTA_Center
         bMultiLine=True
         FontScale=FNS_Small
         StyleName="TextLabel"
         WinTop=0.221338
         WinLeft=0.089997
         WinWidth=0.827654
         WinHeight=0.342207
         RenderWeight=0.200000
         TabOrder=0
         bScaleToParent=True
     End Object
     currentDiscardText=GUILabel'InvasionProv1_7.InvasionProPetDiscardMenu.DiscardText'

     Begin Object Class=GUIButton Name=CancelButton
         Caption="No"
         Hint="Click this button to cancel."
         WinTop=0.573362
         WinLeft=0.627835
         WinWidth=0.178488
         WinHeight=0.094359
         TabOrder=9
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProPetDiscardMenu.InternalOnClick
         OnKeyEvent=CancelButton.InternalOnKeyEvent
     End Object
     b_Cancel=GUIButton'InvasionProv1_7.InvasionProPetDiscardMenu.CancelButton'

     Begin Object Class=GUIButton Name=OkButton
         Caption="Yes"
         Hint="Click this button to discard your pet."
         WinTop=0.573362
         WinLeft=0.242109
         WinWidth=0.178488
         WinHeight=0.094359
         TabOrder=8
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProPetDiscardMenu.InternalOnClick
         OnKeyEvent=OkButton.InternalOnKeyEvent
     End Object
     b_OK=GUIButton'InvasionProv1_7.InvasionProPetDiscardMenu.OkButton'

     bRequire640x480=True
     WinTop=0.078000
     WinLeft=0.010000
     WinWidth=0.724674
     WinHeight=0.659765
     bScaleToParent=True
}
