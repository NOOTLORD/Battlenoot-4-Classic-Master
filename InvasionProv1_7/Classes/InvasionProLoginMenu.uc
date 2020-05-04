class InvasionProLoginMenu extends UT2K4InvasionLoginMenu;

function AddPanels()
{
    Panels[0].ClassName = "InvasionProv1_7.InvasionProPlayerLoginControls";
    Super(UT2K4PlayerLoginMenu).AddPanels();
}

defaultproperties
{
}
