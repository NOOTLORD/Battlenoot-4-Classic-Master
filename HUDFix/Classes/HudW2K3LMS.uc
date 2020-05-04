// ====================================================================
// (C) 2002, Epic Games
// ====================================================================

class HudW2K3LMS extends HudW2K3DeathMatch;

var localized string LivesRemainingString;
var localized string PlayersRemainString;

simulated function DrawSpectatingHud (Canvas C)
{
	local string InfoString;
    local plane OldModulate;
    local float xl,yl,Full, Height, Top, TextTop, MedH, SmallH,Scale;
    local int i,cnt;
    local GameReplicationInfo GRI;

	if (!PlayerOwner.PlayerReplicationInfo.bOutOfLives)
    {
		Super.DrawSpectatingHud(C);
        return;
    }

    DisplayLocalMessages (C);
    OldModulate = C.ColorModulate;

    C.Font = GetMediumFontFor(C);
    C.StrLen("W",xl,MedH);
	Height = MedH;
	C.Font = GetConsoleFont(C);
    C.StrLen("W",xl,SmallH);
    Height += SmallH;

	Full = Height;
    Top  = C.ClipY-8-Full;

	Scale = (Full+16)/128;

	// I like Yellow

    C.ColorModulate.X=255;
    C.ColorModulate.Y=255;
    C.ColorModulate.Z=0;
    C.ColorModulate.W=255;

	// Draw Border

	C.SetPos(0,Top);
    C.SetDrawColor(255,255,255,255);
    C.DrawTileStretched(material'InterfaceContent.SquareBoxA',C.ClipX,Full);
    C.ColorModulate.Z=255;

    TextTop = Top + 4;
    GRI = PlayerOwner.GameReplicationInfo;

	if ( Pawn(PlayerOwner.ViewTarget) != None && Pawn(PlayerOwner.ViewTarget).PlayerReplicationInfo != None )
    {
    	// Draw View Target info

		C.SetDrawColor(32,255,32,255);

		if ( C.ClipX < 640 )
			SmallH = 0;
		else
		{
			C.SetPos((256*Scale*0.75),TextTop);
	        C.DrawText(NowViewing,false);
	        C.StrLen(LivesRemainingString,Xl,Yl);
	        C.SetPos(C.ClipX-5-XL,TextTop);
	        C.DrawText(LivesRemainingString);
        }

        C.SetDrawColor(255,255,0,255);
        C.Font = GetMediumFontFor(C);
        C.SetPos((256*Scale*0.75),TextTop+SmallH);
        C.DrawText(Pawn(PlayerOwner.ViewTarget).PlayerReplicationInfo.PlayerName,false);

	    InfoString = ""$Int(GRI.MaxLives - Pawn(PlayerOwner.ViewTarget).PlayerReplicationInfo.Deaths);
	    C.StrLen(InfoString,xl,yl);

	    C.SetPos(C.ClipX-5-XL,TextTop+SmallH);
	    C.DrawText(InfoString,false);

    }
    else
    {
    	C.SetDrawColor(255,255,255,255);
        C.Font = GetMediumFontFor(C);
        C.StrLen(InitialViewingString,XL,YL);
        C.SetPos( (C.ClipX/2) - (XL/2), Top + (Full/2) - (YL/2));
        C.DrawText(InitialViewingString,false);
    }

    C.Font = GetConsoleFont(C);
    C.StrLen(GRI.GameName,XL,YL);
    C.SetPos( (C.ClipX/2) - (XL/2), 10);
    C.SetDrawColor(255,255,255,255);
    C.ColorModulate.Z = 255;
    C.DrawText(GRI.GameName);

    Cnt=0;

    for (i=0;i<GRI.PRIArray.Length;i++)
    {
        if ( (GRI.PRIArray[i]!=None) && !GRI.PRIArray[i].bOutOfLives && !GRI.PRIArray[i].bIsSpectator && !GRI.PRIArray[i].bOnlySpectator )
            cnt++;
    }


    InfoString = ""$cnt@PlayersRemainString@InitialViewingString;
    C.StrLen(InfoString,xl,yl);
    C.SetPos( (C.ClipX/2) - (XL/2),Top-3-YL);
    C.DrawText(InfoString);


    OldModulate = C.ColorModulate;
}


simulated function UpdateRankAndSpread(Canvas C)
{
    local int i,cnt;


	if ( (Scoreboard == None) || !Scoreboard.UpdateGRI() )
		return;


	 MyRank.Value = PlayerOwner.GameReplicationInfo.MaxLives-PawnOwnerPRI.Deaths;

    cnt=0;
    for( i=0 ; i<PlayerOwner.GameReplicationInfo.PRIArray.Length ; i++ )
		if (!PlayerOwner.GameReplicationInfo.PRIArray[i].bOutOfLives)
        	cnt++;

	MySpread.Value = cnt;

	myScore.Value = Min (PawnOwnerPRI.Score, 999);  // max display space

    if( bShowPoints )
    {
        DrawNumericWidgetAsTiles (C, myScore, DigitsBig);
        if ( C.ClipX >= 640 )
			DrawNumericWidgetAsTiles (C, mySpread, DigitsBig);
        DrawNumericWidgetAsTiles (C, myRank, DigitsBig);
    }

    if(myRank.Value > 9)
    {
        myRank.TextureScale = 0.12;
        myRank.OffsetX = 240;
        myRank.OffsetY = 562;
    }
    else
    {
        myRank.TextureScale = 0.18;
        myRank.OffsetX = 150;
        myRank.OffsetY = 250;
    }

}

defaultproperties
{
     LivesRemainingString="Lives Remaining"
     PlayersRemainString="Players Remain -- "
}
