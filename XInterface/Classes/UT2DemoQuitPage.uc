// ====================================================================
//  Class:  XInterface.UT2DemoQuitPage
//  Parent: XInterface.GUIPage
//
//  <Enter a description here>
// ====================================================================

class UT2DemoQuitPage extends UT2K3GUIPage;

var int	TimeLeft;
var bool bClickedBuy;  // need a tick or two for the start to take place

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.Initcomponent(MyController, MyOwner);
	GUIButton(Controls[17]).Caption = GUIButton(default.Controls[17]).Caption$"("$TimeLeft$")";
	SetTimer(1,true);
}

event Timer()
{

	if ( bClickedBuy )
	{
		PlayerOwner().ConsoleCommand("exit");
	}
	else
	{
		TimeLeft--;
		GUIButton(Controls[17]).Caption = GUIButton(default.Controls[17]).Caption$"("$TimeLeft$")";
		if(TimeLeft <= 0)
			OnQuitClicked(Controls[17]);
	}
}

function bool OnBuyClicked(GUIComponent Sender)
{
	PlayerOwner().ConsoleCommand("start http://www.unrealtournament.com/");
	bClickedBuy = true;
	SetTimer(0.5,true);
	return true;
}

function bool OnQuitClicked(GUIComponent Sender)
{
	PlayerOwner().ConsoleCommand("exit");
	return true;
}

defaultproperties
{
     TimeLeft=20

     Begin Object Class=GUIButton Name=BuyButton
         Caption="Buy"
         WinTop=0.850000
         WinLeft=0.800000
         WinWidth=0.150000
         OnClick=UT2DemoQuitPage.OnBuyClicked
         OnKeyEvent=BuyButton.InternalOnKeyEvent
     End Object
     Controls(16)=GUIButton'XInterface.UT2DemoQuitPage.BuyButton'

     Begin Object Class=GUIButton Name=QuitButton
         Caption="Quit"
         WinTop=0.910000
         WinLeft=0.800000
         WinWidth=0.150000
         OnClick=UT2DemoQuitPage.OnQuitClicked
         OnKeyEvent=QuitButton.InternalOnKeyEvent
     End Object
     Controls(17)=GUIButton'XInterface.UT2DemoQuitPage.QuitButton'

     WinHeight=1.000000
}