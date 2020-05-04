class InvasionProPlayerLoginControls extends UT2K4Tab_PlayerLoginControlsInvasion;

var() Automated GUIButton G_HUDButton;
var() Automated GUIButton G_PetButton;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.InitComponent(MyController,MyOwner);

	if(InvasionProXPlayer(PlayerOwner()) != None && InvasionProXPlayer(PlayerOwner()).bPetMode)
	{
		G_PetButton.EnableMe();
		G_PetButton.bVisible=true;
	}
	else
	{
		G_PetButton.DisableMe();
		G_PetButton.bVisible=false;
	}
}

function bool InternalOnPreDraw(Canvas C)
{
    local GameReplicationInfo GRI;

    GRI = GetGRI();
    if (InvasionProGameReplicationInfo(GRI) != None)
    {
        if (bInit)
            InitGRI();

        if ( bTeamGame )
        {
            if ( GRI.Teams[0] != None )
                sb_Red.Caption = RedTeam@string(int(GRI.Teams[0].Score));

            if ( GRI.Teams[1] != None )
                sb_Blue.Caption = BlueTeam@string(int(GRI.Teams[1].Score));

            if (PlayerOwner().PlayerReplicationInfo.Team != None)
            {
                if (PlayerOwner().PlayerReplicationInfo.Team.TeamIndex == 0)
                {
                    sb_Red.HeaderBase = texture'Display95';
                    sb_Blue.HeaderBase = sb_blue.default.headerbase;
                }
                else
                {
                    sb_Blue.HeaderBase = texture'Display95';
                    sb_Red.HeaderBase = sb_blue.default.headerbase;
                }
            }
        }

        SetButtonPositions(C);
        UpdatePlayerLists();

		if(EnableSpecJoinButton(GRI))
        {
            EnableComponent(b_Spec);
		}
		else
		{
			DisableComponent(b_Spec);
		}
    }

    return false;
}

function bool EnableSpecJoinButton(GameReplicationInfo GRI)
{
	if(b_Spec.Caption ~= SpectateButtonText)
	{
		if( (PlayerOwner().myHUD == None) || (PlayerOwner().myHUD != None && InvasionProHud(PlayerOwner().myHUD).bMeshesLoaded && !PlayerOwner().myHUD.IsInCinematic()) )
		{
			return true;
		}
	}
	else if(b_Spec.Caption ~= JoinGameButtonText)
	{
		if(GRI.bMatchHasBegun && !PlayerOwner().IsInState('GameEnded') && InvasionProGameReplicationInfo(GRI).bPlayersCanJoin && !PlayerOwner().myHUD.IsInCinematic())
		{
			return true;
		}
	}

	return false;
}

function bool InternalOnClick(GUIComponent Sender)
{
	if(Sender == G_HUDButton)
	{
		Controller.OpenMenu("InvasionProv1_7.InvasionProHudConfig", "", "");
	}
	else if(Sender == G_PetButton)
	{
		Controller.OpenMenu("InvasionProv1_7.InvasionProPetMenuConfig", "", "");
	}

	return true;
}

defaultproperties
{
     Begin Object Class=GUIButton Name=HUDButton
         Caption="InvasionPro HUD"
         bAutoSize=True
         TabOrder=6
         OnClick=InvasionProPlayerLoginControls.InternalOnClick
         OnKeyEvent=HUDButton.InternalOnKeyEvent
     End Object
     G_HUDButton=GUIButton'InvasionProv1_7.InvasionProPlayerLoginControls.HUDButton'

     Begin Object Class=GUIButton Name=PetButton
         Caption="Pet Menu"
         bAutoSize=True
         TabOrder=7
         OnClick=InvasionProPlayerLoginControls.InternalOnClick
         OnKeyEvent=PetButton.InternalOnKeyEvent
     End Object
     G_PetButton=GUIButton'InvasionProv1_7.InvasionProPlayerLoginControls.PetButton'

}
