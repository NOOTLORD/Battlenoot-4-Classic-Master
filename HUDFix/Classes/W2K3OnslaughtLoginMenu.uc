class W2K3OnslaughtLoginMenu extends UT2K4OnslaughtLoginMenu;

function HandleParameters(string Param1, string Param2)
{
	if (PlayerOwner().IsInState('PlayerWaiting') || PlayerOwner().IsDead())
	{
		c_Main.ActivateTabByName(OnslaughtMapPanel.Caption, True);
		return;
	}

	if (Param1 ~= "TL")
	{
		c_Main.ActivateTabByName(OnslaughtMapPanel.Caption, True);
		UT2K4Tab_W2K3OnslaughtMap(c_Main.ActiveTab.MyPanel).NodeTeleporting();
		return;
	}

	c_Main.ActivateTabByName(Panels[1].Caption, true);
}

defaultproperties
{
     OnslaughtMapPanel=(ClassName="HUDFix.UT2K4Tab_W2K3OnslaughtMap")
}
