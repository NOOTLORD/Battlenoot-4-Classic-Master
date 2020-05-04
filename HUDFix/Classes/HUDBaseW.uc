//===========================================================================
// HUDBaseW. Contains the two functions used to draw Widgets via DrawTile and some
// additional exec functions.
//
// The UT2003 HUDs derive from this class.
//===========================================================================
class HUDBaseW extends HudBase;

//Positioning
var const float XShifts[9];
var const float YShifts[9];

//Scaling
var bool bCorrectAspectRatio;

//Colors
var() color HudColorRed, HudColorBlue, HudColorBlack, HudColorHighLight, HudColorNormal, HudColorTeam[2];

//Greater than normal HUD scaling is sometimes desirable.
exec function ScaleHUD(float F)
{
	HUDScale = FClamp(F, 0.5, ResScaleX/ResScaleY);
	SaveConfig();
}

//===========================================================================
// Draws a SpriteWidget using DrawTile.
//===========================================================================
simulated function DrawWidgetAsTile(Canvas C, SpriteWidget W, optional bool bUseHUDColors)
{
	local byte SavedAlpha;
	
	if (!bCorrectAspectRatio)
	{
		if (bUseHUDColors) //For some reason, this is necessary.
		{
			SavedAlpha = W.Tints[TeamIndex].A;
			if (TeamIndex == 1)
				W.Tints[TeamIndex] = HudColorBlue;
			else W.Tints[TeamIndex] = HudColorRed;
			W.Tints[TeamIndex].A = SavedAlpha;
		}
		
		DrawSpriteWidget(C, W);
		return;
	}
	
	C.Style = W.RenderStyle;
	
	if (bUseHUDColors)
	{
		if (TeamIndex == 1)
			C.DrawColor = HudColorBlue;
		else C.DrawColor = HudColorRed;
		C.DrawColor.A = W.Tints[TeamIndex].A;
	}
	
	else C.DrawColor = W.Tints[TeamIndex];
	
	switch(W.ScaleMode)
	{
		case SM_None:
			C.SetPos(
				(C.ClipX * W.PosX) + (W.OffsetX - Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * XShifts[W.DrawPivot]) * (W.TextureScale * ResScaleY * HUDScale),
				(C.ClipY * W.PosY) + (W.OffsetY - Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * YShifts[W.DrawPivot]) * (W.TextureScale * ResScaleY * HUDScale)
				);
			C.DrawTile(
					W.WidgetTexture, 
					Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * W.TextureScale  * ResScaleY * HUDScale,  
					Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * W.TextureScale * ResScaleY * HUDScale, 
					W.TextureCoords.X1, 
					W.TextureCoords.Y1, 
					W.TextureCoords.X2 - W.TextureCoords.X1, 
					W.TextureCoords.Y2 - W.TextureCoords.Y1
					);
			break;
		
		case SM_Right:
			C.SetPos(
				(C.ClipX * W.PosX) + (W.OffsetX - Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * XShifts[W.DrawPivot]) * (W.TextureScale * ResScaleY * HUDScale),
				(C.ClipY * W.PosY) + (W.OffsetY - Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * YShifts[W.DrawPivot]) * (W.TextureScale * ResScaleY * HUDScale)
				);
			C.DrawTile(
				W.WidgetTexture, 
				Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * W.TextureScale * W.Scale * ResScaleY * HUDScale,  
				Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * W.TextureScale * ResScaleY * HUDScale, 
				W.TextureCoords.X1, 
				W.TextureCoords.Y1, 
				(W.TextureCoords.X2 - W.TextureCoords.X1) * W.Scale, 
				W.TextureCoords.Y2 - W.TextureCoords.Y1
				);
			break;
			
		case SM_Left:
			C.SetPos(
				(C.ClipX * W.PosX) + (W.OffsetX - Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * XShifts[W.DrawPivot] + (Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * (1- W.Scale))) * (W.TextureScale * ResScaleY *  HUDScale),
				(C.ClipY * W.PosY) + (W.OffsetY - Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * YShifts[W.DrawPivot])  * (W.TextureScale * ResScaleY * HUDScale)
				);
			C.DrawTile(
				W.WidgetTexture, 
				Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * W.TextureScale * W.Scale * ResScaleY * HUDScale,  
				Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * W.TextureScale * ResScaleY * HUDScale, 
				W.TextureCoords.X1	+	((W.TextureCoords.X2 - W.TextureCoords.X1) * (1-W.Scale)), 
				W.TextureCoords.Y1, 
				(W.TextureCoords.X2 - W.TextureCoords.X1) * W.Scale, 
				W.TextureCoords.Y2 - W.TextureCoords.Y1
				);
			break;
		
		case SM_Down:
			C.SetPos(
				(C.ClipX * W.PosX) + (W.OffsetX - Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * XShifts[W.DrawPivot]) * (W.TextureScale * ResScaleY * HUDScale),
				(C.ClipY * W.PosY) + (W.OffsetY - Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * YShifts[W.DrawPivot]) * (W.TextureScale * ResScaleY * HUDScale)
				);
			C.DrawTile(
				W.WidgetTexture, 
				Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * W.TextureScale * ResScaleY * HUDScale,  
				Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * W.TextureScale * W.Scale * ResScaleY * HUDScale, 
				W.TextureCoords.X1, 
				W.TextureCoords.Y1, 
				W.TextureCoords.X2 - W.TextureCoords.X1,
				(W.TextureCoords.Y2 - W.TextureCoords.Y1) * W.Scale
				);
			break;
			
		case SM_Up:
			C.SetPos(
				(C.ClipX * W.PosX) + (W.OffsetX - Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * XShifts[W.DrawPivot]) * (W.TextureScale * ResScaleY *  HUDScale),
				(C.ClipY * W.PosY) + (W.OffsetY - Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * YShifts[W.DrawPivot] + (Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * (1- W.Scale)))  * (W.TextureScale * ResScaleY * HUDScale)
				);
			C.DrawTile(
				W.WidgetTexture, 
				Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * W.TextureScale * ResScaleY * HUDScale,  
				Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * W.TextureScale * W.Scale * ResScaleY * HUDScale, 
				W.TextureCoords.X1, 
				W.TextureCoords.Y1	+	((W.TextureCoords.Y2 - W.TextureCoords.Y1) * (1-W.Scale)), 
				W.TextureCoords.X2 - W.TextureCoords.X1,
				(W.TextureCoords.Y2 - W.TextureCoords.Y1) * W.Scale
				);
			break;
			
		default:
			C.SetPos(
				(C.ClipX * W.PosX) + (W.OffsetX - Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * XShifts[W.DrawPivot]) * (W.TextureScale * ResScaleY *  HUDScale),
				(C.ClipY * W.PosY) + (W.OffsetY - Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * YShifts[W.DrawPivot])  * (W.TextureScale * ResScaleY * HUDScale)
				);
			C.DrawTile(
					W.WidgetTexture, 
					Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * W.TextureScale  * ResScaleY * HUDScale,  
					Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * W.TextureScale * ResScaleY * HUDScale, 
					W.TextureCoords.X1, 
					W.TextureCoords.Y1, 
					W.TextureCoords.X2 - W.TextureCoords.X1, 
					W.TextureCoords.Y2 - W.TextureCoords.Y1
					);
		break;
	}
}

//===========================================================================
//	Draws a NumericWidget via DrawTile.
//===========================================================================
simulated function DrawNumericWidgetAsTiles(Canvas C, NumericWidget W, DigitSet D)
{
	local String s;
	local array<String> t;
	local int padding, length, i;
	local byte coordindex;
	
	if (!bCorrectAspectRatio)
	{
		DrawNumericWidget(C, W, D);
		return;
	}
	
	C.Style = W.RenderStyle;

	s = String(W.Value);
	length = Len(s);
	
	padding= Max(0, W.MinDigitCount - length);
	
	if (W.bPadWithZeroes != 0)
		length += padding;

	for (i=0; i < length; i++)
	{
		if (W.bPadWithZeroes == 1 && i < padding)
			t[i] = "0";
		else
		{
			t[i] = "";
			EatStr(t[i], s, 1);
		}
	}
	
	C.SetPos((C.ClipX * W.PosX) + (W.OffsetX - (D.TextureCoords[0].X2 - D.TextureCoords[0].X1) * (((length + padding) * XShifts[W.DrawPivot]) - (padding * (1-W.bPadWithZeroes) )) ) * (W.TextureScale * ResScaleY *  HUDScale),
			(C.ClipY * W.PosY) + (W.OffsetY - (D.TextureCoords[0].Y2 - D.TextureCoords[0].Y1) * YShifts[W.DrawPivot])  * (W.TextureScale * ResScaleY * HUDScale));
	C.DrawColor = W.Tints[TeamIndex];
	
	for (i = 0; i < length; i++)
	{
		if (t[i] == "-")
			coordindex = 10;
		else coordindex = byte(t[i]);
		
		C.DrawTile(
						D.DigitTexture,
						(D.TextureCoords[coordindex].X2 - D.TextureCoords[coordindex].X1) * W.TextureScale * ResScaleY * HUDScale,  
						(D.TextureCoords[coordindex].Y2 - D.TextureCoords[coordindex].Y1) * W.TextureScale * ResScaleY * HUDScale, 
						D.TextureCoords[coordindex].X1, 
						D.TextureCoords[coordindex].Y1, 
						(D.TextureCoords[coordindex].X2 - D.TextureCoords[coordindex].X1), 
						(D.TextureCoords[coordindex].Y2 - D.TextureCoords[coordindex].Y1)
						);
	}
}

//===========================================================================
// Manage HUD override.
//===========================================================================
simulated event PostRender( canvas Canvas )
{
    local float XPos, YPos;
    local plane OldModulate,OM;
    local color OldColor;
    local int i;

    BuildMOTD();

    OldModulate = Canvas.ColorModulate;
    OldColor = Canvas.DrawColor;

    Canvas.ColorModulate.X = 1;
    Canvas.ColorModulate.Y = 1;
    Canvas.ColorModulate.Z = 1;
    Canvas.ColorModulate.W = HudOpacity/255;

    LinkActors();

    ResScaleX = Canvas.SizeX / 640.0;
    ResScaleY = Canvas.SizeY / 480.0;
	
	if (!bCorrectAspectRatio && ResScaleX/ResScaleY > 1)
		bCorrectAspectRatio = True;
	else if (ResScaleX / ResScaleY <= 1)
		bCorrectAspectRatio = False;

	CheckCountDown(PlayerOwner.GameReplicationInfo);

    if ( PawnOwner != None )
    {
		if ( !PlayerOwner.bBehindView )
		{
			if ( PlayerOwner.bDemoOwner || ((Level.NetMode == NM_Client) && (PlayerOwner.Pawn != PawnOwner)) )
				PawnOwner.GetDemoRecordingWeapon();
			else
				CanvasDrawActors( Canvas, false );
		}
		else
			CanvasDrawActors( Canvas, false );
	}

	if ( PawnOwner != None && PawnOwner.bSpecialHUD )
		PawnOwner.DrawHud(Canvas);
    if ( bShowDebugInfo )
    {
        Canvas.Font = GetConsoleFont(Canvas);
        Canvas.Style = ERenderStyle.STY_Alpha;
        Canvas.DrawColor = ConsoleColor;

        PlayerOwner.ViewTarget.DisplayDebug(Canvas, XPos, YPos);
        if (PlayerOwner.ViewTarget != PlayerOwner && (Pawn(PlayerOwner.ViewTarget) == None || Pawn(PlayerOwner.ViewTarget).Controller == None))
        {
        	YPos += XPos * 2;
        	Canvas.SetPos(4, YPos);
        	Canvas.DrawText("----- VIEWER INFO -----");
        	YPos += XPos;
        	Canvas.SetPos(4, YPos);
        	PlayerOwner.DisplayDebug(Canvas, XPos, YPos);
        }
    }
	else if( !bHideHud )
    {
        if ( bShowLocalStats )
        {
			if ( LocalStatsScreen == None )
				GetLocalStatsScreen();
            if ( LocalStatsScreen != None )
            {
            	OM = Canvas.ColorModulate;
                Canvas.ColorModulate = OldModulate;
                LocalStatsScreen.DrawScoreboard(Canvas);
				DisplayMessages(Canvas);
                Canvas.ColorModulate = OM;
			}
		}
        else if (bShowScoreBoard)
        {
            if (ScoreBoard != None)
            {
            	OM = Canvas.ColorModulate;
                Canvas.ColorModulate = OldModulate;
                ScoreBoard.DrawScoreboard(Canvas);
				if ( Scoreboard.bDisplayMessages )
					DisplayMessages(Canvas);
                Canvas.ColorModulate = OM;
			}
        }
        else
        {
			if ( (PlayerOwner == None) || (PawnOwner == None) || (PawnOwnerPRI == None) || (PlayerOwner.IsSpectating() && PlayerOwner.bBehindView) )
            	DrawSpectatingHud(Canvas);
			else if( !PawnOwner.bHideRegularHUD )
				DrawHud(Canvas);

			for (i = 0; i < Overlays.length; i++)
				Overlays[i].Render(Canvas);

            if (!DrawLevelAction (Canvas))
            {
            	if (PlayerOwner!=None)
                {
                	if (PlayerOwner.ProgressTimeOut > Level.TimeSeconds)
                    {
	                    DisplayProgressMessages (Canvas);
                    }
                    else if (MOTDState==1)
                    	MOTDState=2;
                }
           }

            if (bShowBadConnectionAlert)
                DisplayBadConnectionAlert (Canvas);
            DisplayMessages(Canvas);

        }

        if( bShowVoteMenu && VoteMenu!=None )
            VoteMenu.RenderOverlays(Canvas);
    }
    else if ( PawnOwner != None )
        DrawInstructionGfx(Canvas);


    PlayerOwner.RenderOverlays(Canvas);

    if (PlayerOwner.bViewingMatineeCinematic)
	DrawCinematicHUD(Canvas);

    if ((PlayerConsole != None) && PlayerConsole.bTyping)
        DrawTypingPrompt(Canvas, PlayerConsole.TypedStr, PlayerConsole.TypedStrPos);

    Canvas.ColorModulate=OldModulate;
    Canvas.DrawColor = OldColor;

    OnPostRender(Self, Canvas);
}

defaultproperties
{
     XShifts(1)=0.500000
     XShifts(2)=1.000000
     XShifts(3)=1.000000
     XShifts(4)=1.000000
     XShifts(5)=0.500000
     XShifts(8)=0.500000
     YShifts(3)=0.500000
     YShifts(4)=1.000000
     YShifts(5)=1.000000
     YShifts(6)=1.000000
     YShifts(7)=0.500000
     YShifts(8)=0.500000
     bCorrectAspectRatio=True
     HudColorRed=(R=200,A=255)
     HudColorBlue=(B=200,G=64,R=50,A=255)
     HudColorBlack=(A=255)
     HudColorHighLight=(G=160,R=255,A=255)
     HudColorNormal=(B=255,G=255,R=255,A=255)
     HudColorTeam(0)=(R=200,A=255)
     HudColorTeam(1)=(B=200,G=64,R=50,A=255)
}
