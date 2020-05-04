class HudWMutant extends HudMutant;

//Positioning
var const float XShifts[9];
var const float YShifts[9];

//Scaling
var bool bCorrectAspectRatio;

var()	float				BFIOffsetX;

var float ScaleYCache;


//Greater than normal HUD scaling is sometimes desirable.
exec final function ScaleHUD(float F)
{
	HUDScale = FClamp(F, 0.5, ResScaleX/ResScaleY);
	SaveConfig();
}

//===========================================================================
// Draws a SpriteWidget using DrawTile.
//===========================================================================
simulated final function DrawWidgetAsTile(Canvas C, SpriteWidget W)
{
	if (!bCorrectAspectRatio)
	{
		DrawSpriteWidget(C, W);
		return;
	}
	
	C.Style = W.RenderStyle;
	
	C.DrawColor = W.Tints[TeamIndex];
	
	if (W.Scale == 1.0f || W.ScaleMode == SM_None)
	{
		C.SetPos(
					(C.ClipX * W.PosX) + (W.OffsetX - Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * XShifts[W.DrawPivot]) * (W.TextureScale * ScaleYCache),
					(C.ClipY * W.PosY) + (W.OffsetY - Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * YShifts[W.DrawPivot]) * (W.TextureScale * ScaleYCache)
		);
		C.DrawTile(
			W.WidgetTexture, 
			Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * W.TextureScale * ScaleYCache,  
			Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * W.TextureScale * ScaleYCache, 
			W.TextureCoords.X1, 
			W.TextureCoords.Y1, 
			W.TextureCoords.X2 - W.TextureCoords.X1, 
			W.TextureCoords.Y2 - W.TextureCoords.Y1
		);
	}
	else
	{
		switch(W.ScaleMode)
		{
			case SM_Right:
				C.SetPos(
					(C.ClipX * W.PosX) + (W.OffsetX - Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * XShifts[W.DrawPivot]) * (W.TextureScale * ScaleYCache),
					(C.ClipY * W.PosY) + (W.OffsetY - Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * YShifts[W.DrawPivot]) * (W.TextureScale * ScaleYCache)
					);
					C.DrawTile(
						W.WidgetTexture, 
						Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * W.TextureScale * W.Scale * ScaleYCache,  
						Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * W.TextureScale * ScaleYCache, 
						W.TextureCoords.X1, 
						W.TextureCoords.Y1, 
						(W.TextureCoords.X2 - W.TextureCoords.X1) * W.Scale, 
						W.TextureCoords.Y2 - W.TextureCoords.Y1
					);
				break;
				
			case SM_Left:
				C.SetPos(
					(C.ClipX * W.PosX) + (W.OffsetX - Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * XShifts[W.DrawPivot] + (Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * (1- W.Scale))) * (W.TextureScale * ScaleYCache),
					(C.ClipY * W.PosY) + (W.OffsetY - Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * YShifts[W.DrawPivot])  * (W.TextureScale * ScaleYCache)
					);
					C.DrawTile(
					W.WidgetTexture, 
					Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * W.TextureScale * W.Scale * ScaleYCache,  
					Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * W.TextureScale * ScaleYCache, 
					W.TextureCoords.X1	+	((W.TextureCoords.X2 - W.TextureCoords.X1) * (1-W.Scale)), 
					W.TextureCoords.Y1, 
					(W.TextureCoords.X2 - W.TextureCoords.X1) * W.Scale, 
					W.TextureCoords.Y2 - W.TextureCoords.Y1
					);
				break;
			
			case SM_Down:
				C.SetPos(
					(C.ClipX * W.PosX) + (W.OffsetX - Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * XShifts[W.DrawPivot]) * (W.TextureScale * ScaleYCache),
					(C.ClipY * W.PosY) + (W.OffsetY - Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * YShifts[W.DrawPivot]) * (W.TextureScale * ScaleYCache)
					);
					C.DrawTile(
					W.WidgetTexture, 
					Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * W.TextureScale * ScaleYCache,  
					Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * W.TextureScale * W.Scale * ScaleYCache, 
					W.TextureCoords.X1, 
					W.TextureCoords.Y1, 
					W.TextureCoords.X2 - W.TextureCoords.X1,
					(W.TextureCoords.Y2 - W.TextureCoords.Y1) * W.Scale
					);
				break;
				
			case SM_Up:
				C.SetPos(
					(C.ClipX * W.PosX) + (W.OffsetX - Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * XShifts[W.DrawPivot]) * (W.TextureScale * ScaleYCache),
					(C.ClipY * W.PosY) + (W.OffsetY - Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * YShifts[W.DrawPivot] + (Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * (1- W.Scale)))  * (W.TextureScale * ScaleYCache)
					);
					C.DrawTile(
					W.WidgetTexture, 
					Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * W.TextureScale * ScaleYCache,  
					Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * W.TextureScale * W.Scale * ScaleYCache, 
					W.TextureCoords.X1, 
					W.TextureCoords.Y1	+	((W.TextureCoords.Y2 - W.TextureCoords.Y1) * (1-W.Scale)), 
					W.TextureCoords.X2 - W.TextureCoords.X1,
					(W.TextureCoords.Y2 - W.TextureCoords.Y1) * W.Scale
					);
		}
	}
}

//===========================================================================
//	Draws a NumericWidget via DrawTile.
//===========================================================================
simulated final function DrawNumericWidgetAsTiles(Canvas C, NumericWidget W, DigitSet D)
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
			(C.ClipY * W.PosY) + (W.OffsetY - (D.TextureCoords[0].Y2 - D.TextureCoords[0].Y1) * YShifts[W.DrawPivot])  * (W.TextureScale * ScaleYCache));
	C.DrawColor = W.Tints[TeamIndex];
	
	for (i = 0; i < length; i++)
	{
		if (t[i] == "-")
			coordindex = 10;
		else coordindex = byte(t[i]);
		
		C.DrawTile(
						D.DigitTexture,
						(D.TextureCoords[coordindex].X2 - D.TextureCoords[coordindex].X1) * W.TextureScale * ScaleYCache,  
						(D.TextureCoords[coordindex].Y2 - D.TextureCoords[coordindex].Y1) * W.TextureScale * ScaleYCache, 
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
	
	ScaleYCache = ResScaleY * HUDScale;
	
	if (!bCorrectAspectRatio && ResScaleX/ResScaleY > 1.05)
		bCorrectAspectRatio = True;
	else if (bCorrectAspectRatio && ResScaleX / ResScaleY <= 1.05)
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
	
simulated function DrawAdrenaline( Canvas C )
{
	if ( !PlayerOwner.bAdrenalineEnabled )
		return;

	DrawWidgetAsTile( C, AdrenalineBackground );
	DrawWidgetAsTile( C, AdrenalineBackgroundDisc );

	if( CurEnergy == MaxEnergy )
	{
		DrawWidgetAsTile( C, AdrenalineAlert );
		AdrenalineAlert.Tints[TeamIndex] = HudColorHighLight;
	}

	DrawWidgetAsTile( C, AdrenalineIcon );
	DrawNumericWidgetAsTiles( C, AdrenalineCount, DigitsBig);

	if(CurEnergy > LastEnergy)
		LastAdrenalineTime = Level.TimeSeconds;

	LastEnergy = CurEnergy;
	DrawHUDAnimWidget( AdrenalineIcon, default.AdrenalineIcon.TextureScale, LastAdrenalineTime, 0.6, 0.6);
	AdrenalineBackground.Tints[TeamIndex] = HudColorBlack;
	AdrenalineBackground.Tints[TeamIndex].A = 150;

}

simulated function DrawTimer(Canvas C)
{
	local GameReplicationInfo GRI;
	local int Minutes, Hours, Seconds;

	GRI = PlayerOwner.GameReplicationInfo;

	if ( GRI.TimeLimit != 0 )
		Seconds = GRI.RemainingTime;
	else
		Seconds = GRI.ElapsedTime;

	TimerBackground.Tints[TeamIndex] = HudColorBlack;
    TimerBackground.Tints[TeamIndex].A = 150;

	DrawWidgetAsTile( C, TimerBackground);
	DrawWidgetAsTile( C, TimerBackgroundDisc);
	DrawWidgetAsTile( C, TimerIcon);

	TimerMinutes.OffsetX = default.TimerMinutes.OffsetX - 80;
	TimerSeconds.OffsetX = default.TimerSeconds.OffsetX - 80;
	TimerDigitSpacer[0].OffsetX = Default.TimerDigitSpacer[0].OffsetX;
	TimerDigitSpacer[1].OffsetX = Default.TimerDigitSpacer[1].OffsetX;

	if( Seconds > 3600 )
    {
        Hours = Seconds / 3600;
        Seconds -= Hours * 3600;

		DrawNumericWidgetAsTiles( C, TimerHours, DigitsBig);
        TimerHours.Value = Hours;

		if(Hours>9)
		{
			TimerMinutes.OffsetX = default.TimerMinutes.OffsetX;
			TimerSeconds.OffsetX = default.TimerSeconds.OffsetX;
		}
		else
		{
			TimerMinutes.OffsetX = default.TimerMinutes.OffsetX -40;
			TimerSeconds.OffsetX = default.TimerSeconds.OffsetX -40;
			TimerDigitSpacer[0].OffsetX = Default.TimerDigitSpacer[0].OffsetX - 32;
			TimerDigitSpacer[1].OffsetX = Default.TimerDigitSpacer[1].OffsetX - 32;
		}
		DrawWidgetAsTile( C, TimerDigitSpacer[0]);
	}
	DrawWidgetAsTile( C, TimerDigitSpacer[1]);

	Minutes = Seconds / 60;
    Seconds -= Minutes * 60;

    TimerMinutes.Value = Min(Minutes, 60);
	TimerSeconds.Value = Min(Seconds, 60);

	DrawNumericWidgetAsTiles( C, TimerMinutes, DigitsBig);
	DrawNumericWidgetAsTiles( C, TimerSeconds, DigitsBig);
}


simulated function DrawUDamage( Canvas C )
{
	local xPawn P;

	if (Vehicle(PawnOwner) != None)
		P = xPawn(Vehicle(PawnOwner).Driver);
	else
		P = xPawn(PawnOwner);

	if (P != None && P.UDamageTime > Level.TimeSeconds)
	{
         if (P.UDamageTime > Level.TimeSeconds + 15 )
			UDamageIcon.TextureScale = default.UDamageIcon.TextureScale * FMin((P.UDamageTime - Level.TimeSeconds)* 0.0333,1);

         DrawWidgetAsTile(C, UDamageIcon);
         UDamageTime.Value = P.UDamageTime - Level.TimeSeconds ;
         DrawNumericWidgetAsTiles(C, UDamageTime, DigitsBig);
    }
}

simulated function UpdateRankAndSpread(Canvas C)
{
    local int i;

	if ( (Scoreboard == None) || !Scoreboard.UpdateGRI() )
		return;

    for( i=0 ; i<PlayerOwner.GameReplicationInfo.PRIArray.Length ; i++ )
         if(PawnOwnerPRI == PlayerOwner.GameReplicationInfo.PRIArray[i])
         {
            myRank.Value = (i+1);
            break;
         }

	myScore.Value = Min (PawnOwnerPRI.Score, 999);  // max display space
	if ( PawnOwnerPRI == PlayerOwner.GameReplicationInfo.PRIArray[0] )
	{
		if ( PlayerOwner.GameReplicationInfo.PRIArray.Length > 1 )
			mySpread.Value = Min (PawnOwnerPRI.Score - PlayerOwner.GameReplicationInfo.PRIArray[1].Score, 999);
		else
			mySpread.Value = 0;
	}
	else
		mySpread.Value = Min (PawnOwnerPRI.Score - PlayerOwner.GameReplicationInfo.PRIArray[0].Score, 999);

    if( bShowPoints )
    {
		DrawWidgetAsTile( C, MyScoreBackground );
		MyScoreBackground.Tints[TeamIndex] = HudColorBlack;
		MyScoreBackground.Tints[TeamIndex].A = 150;

        DrawNumericWidgetAsTiles (C, myScore, DigitsBig);
        if ( C.ClipX >= 640 )
			DrawNumericWidgetAsTiles (C, mySpread, DigitsBig);
        DrawNumericWidgetAsTiles (C, myRank, DigitsBig);
    }
}

simulated function DrawCrosshair (Canvas C)
{
    local float NormalScale;
    local int i, CurrentCrosshair;
    local float OldScale,OldW, CurrentCrosshairScale;
    local color CurrentCrosshairColor;
	local SpriteWidget CHtexture;

	if ( PawnOwner.bSpecialCrosshair )
	{
		PawnOwner.SpecialDrawCrosshair( C );
		return;
	}

	if (!bCrosshairShow)
        return;

	if ( bUseCustomWeaponCrosshairs && (PawnOwner != None) && (PawnOwner.Weapon != None) )
	{
		CurrentCrosshair = PawnOwner.Weapon.CustomCrosshair;
		if (CurrentCrosshair == -1 || CurrentCrosshair == Crosshairs.Length)
		{
			CurrentCrosshair = CrosshairStyle;
			CurrentCrosshairColor = CrosshairColor;
			CurrentCrosshairScale = CrosshairScale;
		}
		else
		{
			CurrentCrosshairColor = PawnOwner.Weapon.CustomCrosshairColor;
			CurrentCrosshairScale = PawnOwner.Weapon.CustomCrosshairScale;
			if ( PawnOwner.Weapon.CustomCrosshairTextureName != "" )
			{
				if ( PawnOwner.Weapon.CustomCrosshairTexture == None )
				{
					PawnOwner.Weapon.CustomCrosshairTexture = Texture(DynamicLoadObject(PawnOwner.Weapon.CustomCrosshairTextureName,class'Texture'));
					if ( PawnOwner.Weapon.CustomCrosshairTexture == None )
					{
						log(PawnOwner.Weapon$" custom crosshair texture not found!");
						PawnOwner.Weapon.CustomCrosshairTextureName = "";
					}
				}
				CHTexture = Crosshairs[0];
				CHTexture.WidgetTexture = PawnOwner.Weapon.CustomCrosshairTexture;
			}
		}
	}
	else
	{
		CurrentCrosshair = CrosshairStyle;
		CurrentCrosshairColor = CrosshairColor;
		CurrentCrosshairScale = CrosshairScale;
	}

	CurrentCrosshair = Clamp(CurrentCrosshair, 0, Crosshairs.Length - 1);

    NormalScale = Crosshairs[CurrentCrosshair].TextureScale;
	if ( CHTexture.WidgetTexture == None )
		CHTexture = Crosshairs[CurrentCrosshair];
    CHTexture.TextureScale *= 0.5 * CurrentCrosshairScale;

    for( i = 0; i < ArrayCount(CHTexture.Tints); i++ )
        CHTexture.Tints[i] = CurrentCrossHairColor;

	if ( LastPickupTime > Level.TimeSeconds - 0.4 )
	{
		if ( LastPickupTime > Level.TimeSeconds - 0.2 )
			CHTexture.TextureScale *= (1 + 5 * (Level.TimeSeconds - LastPickupTime));
		else
			CHTexture.TextureScale *= (1 + 5 * (LastPickupTime + 0.4 - Level.TimeSeconds));
	}
    OldScale = HudScale;
    HudScale=1;
    OldW = C.ColorModulate.W;
    C.ColorModulate.W = 1;
    DrawWidgetAsTile (C, CHTexture);
    C.ColorModulate.W = OldW;
	HudScale=OldScale;
    CHTexture.TextureScale = NormalScale;

	DrawEnemyName(C);
}

simulated function DrawChargeBar( Canvas C)
{
	local float ScaleFactor;

	ScaleFactor = HUDScale * 0.135 * C.ClipX;
	if (bCorrectAspectRatio)
		ScaleFactor *= ResScaleY / ResScaleX;
	C.Style = ERenderStyle.STY_Alpha;
	if ( (PawnOwner.PlayerReplicationInfo == None) || (PawnOwner.PlayerReplicationInfo.Team == None)
		|| (PawnOwner.PlayerReplicationInfo.Team.TeamIndex == 1) )
		C.DrawColor = HudColorBlue;
	else
		C.DrawColor = HudColorRed;

	C.SetPos(C.ClipX - ScaleFactor - 0.0011*HUDScale*C.ClipX, (1 - 0.0975*HUDScale)*C.ClipY);
	C.DrawTile( Material'HudContent.HUD', ScaleFactor, 0.223*ScaleFactor, 0, 110, 166, 53 );

	RechargeBar.Scale = FMin(PawnOwner.Weapon.ChargeBar(), 1);
	if ( RechargeBar.Scale > 0 )
	{
		DrawWidgetAsTile( C, RechargeBar);
		ShowReloadingPulse(RechargeBar.Scale);
	}
}

simulated function DrawVehicleChargeBar(Canvas C)
{
	local float ScaleFactor;

	ScaleFactor = HUDScale * 0.135 * C.ClipX;
	if (bCorrectAspectRatio)
		ScaleFactor *= ResScaleY / ResScaleX;
	C.Style = ERenderStyle.STY_Alpha;
	if ( (PawnOwner.PlayerReplicationInfo == None) || (PawnOwner.PlayerReplicationInfo.Team == None)
		|| (PawnOwner.PlayerReplicationInfo.Team.TeamIndex == 1) )
		C.DrawColor = HudColorBlue;
	else
		C.DrawColor = HudColorRed;

	C.SetPos(C.ClipX - ScaleFactor - 0.0011*HUDScale*C.ClipX, (1 - 0.0975*HUDScale)*C.ClipY);
	C.DrawTile( Material'HudContent.HUD', ScaleFactor, 0.223*ScaleFactor, 0, 110, 166, 53 );

	DrawWidgetAsTile(C, RechargeBar);
	RechargeBar.Scale = Vehicle(PawnOwner).ChargeBar();
	ShowReloadingPulse(RechargeBar.Scale);
}



exec function ToggleCenterRadar()
{
	bCenterRadar = !bCenterRadar;
	SaveConfig();
}

function color LerpColor(float Alpha, color A, color B)
{
	local color output;

	output.R = lerp(Alpha, A.R, B.R);
	output.G = lerp(Alpha, A.G, B.G);
	output.B = lerp(Alpha, A.B, B.B);
	output.A = lerp(Alpha, A.A, B.A);

	return output;
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Material'InterfaceContent.HUD.SkinA');
	Super(HudCDeathMatch).UpdatePrecacheMaterials();
}

simulated function font LoadMutantRangeFont()
{
	if( MutantRangeFontFont == None )
	{
		MutantRangeFontFont = Font(DynamicLoadObject(MutantRangeFontName, class'Font'));
		if( MutantRangeFontFont == None )
			Log("Warning: "$Self$" Couldn't dynamically load font "$MutantRangeFontName);
	}
	return MutantRangeFontFont;
}

// Alpha Pass ==================================================================================
// Draw radar showing 

simulated function bool PRIIsBottomFeeder(PlayerReplicationInfo PRI)
{
	local MutantGameReplicationInfo mutantInfo;

	mutantInfo = MutantGameReplicationInfo( PlayerOwner.GameReplicationInfo );

	// Check this players PRI against the current BF PRI to see...
	if(PRI == mutantInfo.BottomFeederPRI)
		return true;
	else
		return false;
}

simulated function bool PRIIsMutant(PlayerReplicationInfo PRI)
{
	local MutantGameReplicationInfo mutantInfo;

	mutantInfo = MutantGameReplicationInfo( PlayerOwner.GameReplicationInfo );


	// Check this players PRI against the current Mutant PRI to see...
	if(PRI == mutantInfo.MutantPRI)
		return true;
	else
		return false;
}

// Copy from HudCDeathMatch - need to hack it to change HUD color.
simulated function DrawWeaponBar( Canvas C )
{
    local int i, Count, Pos;
    local float IconOffset;
	local float HudScaleOffset, HudMinScale;

    local Weapon Weapons[WEAPON_BAR_SIZE];
    local byte ExtraWeapon[WEAPON_BAR_SIZE];
    local Inventory Inv;
    local Weapon W, PendingWeapon;
	local color RealRedColor, RealBlueColor;
	
	if ( !bMutantHUDColor )
	{
		//super's DrawWeaponBar!
		HudMinScale=0.5;
		//no weaponbar for vehicles
		if (Vehicle(PawnOwner) != None)
		return;

		if (PawnOwner.PendingWeapon != None)
			PendingWeapon = PawnOwner.PendingWeapon;
		else
			PendingWeapon = PawnOwner.Weapon;

		// fill:
		for( Inv=PawnOwner.Inventory; Inv!=None; Inv=Inv.Inventory )
		{
			W = Weapon( Inv );
			Count++;
			if ( Count > 100 )
				break;

			if( (W == None) || (W.IconMaterial == None) )
				continue;

			if ( W.InventoryGroup == 0 )
				Pos = 8;
			else if ( W.InventoryGroup < 10 )
				Pos = W.InventoryGroup-1;
			else
				continue;

			if ( Weapons[Pos] != None )
				ExtraWeapon[Pos] = 1;
			else
				Weapons[Pos] = W;
		}

		if ( PendingWeapon != None )
		{
			if ( PendingWeapon.InventoryGroup == 0 )
				Weapons[8] = PendingWeapon;
			else if ( PendingWeapon.InventoryGroup < 10 )
				Weapons[PendingWeapon.InventoryGroup-1] = PendingWeapon;
		}

		// Draw:
		for( i=0; i<WEAPON_BAR_SIZE; i++ )
		{
			W = Weapons[i];

			// Keep weaponbar organized when scaled
			HudScaleOffset= 1-(HudScale-HudMinScale)/HudMinScale;
			if (!bCorrectAspectRatio)
				BarBorder[i].PosX =  default.BarBorder[i].PosX +( BarBorderScaledPosition[i] - default.BarBorder[i].PosX) *HudScaleOffset;
			else
				BarBorder[i].PosX = 0.5 - ((0.5 - default.BarBorder[i].PosX) * (ResScaleY / ResScaleX) * HUDScale); 
			BarWeaponIcon[i].PosX = BarBorder[i].PosX;

			IconOffset = (default.BarBorder[i].TextureCoords.X2 - default.BarBorder[i].TextureCoords.X1) * 0.5;
			
			BarBorder[i].Tints[0] = HudColorRed;
			BarBorder[i].Tints[1] = HudColorBlue;
			BarBorder[i].OffsetY = 0;
			BarWeaponIcon[i].OffsetY = default.BarWeaponIcon[i].OffsetY;

			if( W == none )
			{
				BarWeaponStates[i].HasWeapon = false;
				if ( bShowMissingWeaponInfo )
				{
					BarWeaponIcon[i].OffsetX =  IconOffset;
					
					if ( BarWeaponIcon[i].Tints[TeamIndex] != HudColorBlack )
					{
						BarWeaponIcon[i].WidgetTexture = default.BarWeaponIcon[i].WidgetTexture;
						BarWeaponIcon[i].TextureCoords = default.BarWeaponIcon[i].TextureCoords;
						BarWeaponIcon[i].TextureScale = default.BarWeaponIcon[i].TextureScale;
						BarWeaponIcon[i].Tints[TeamIndex] = HudColorBlack;
						BarWeaponIconAnim[i] = 0;
					}
					DrawWidgetAsTile( C, BarBorder[i] );
					DrawWidgetAsTile( C, BarWeaponIcon[i] ); // FIXME- have combined version
				}
		   }
			else
			{
				if( !BarWeaponStates[i].HasWeapon )
				{
					// just picked this weapon up!
					BarWeaponStates[i].PickupTimer = Level.TimeSeconds;
					BarWeaponStates[i].HasWeapon = true;
				}

				BarBorderAmmoIndicator[i].PosX = BarBorder[i].PosX;
				BarBorderAmmoIndicator[i].OffsetY = 0;
				
				BarWeaponIcon[i].WidgetTexture = W.IconMaterial;
				BarWeaponIcon[i].TextureCoords = W.IconCoords;
				
				//Cheese
				if (Abs(W.IconCoords.Y1 - W.IconCoords.Y2) > 64)
				{
					BarWeaponIcon[i].TextureScale = default.BarWeaponIcon[i].TextureScale / ((Abs(W.IconCoords.Y1 - W.IconCoords.Y2) + 1)/ 32);
					IconOffset *= (default.BarWeaponIcon[i].TextureScale / BarWeaponIcon[i].TextureScale);
					BarWeaponIcon[i].OffsetY = -30 * (default.BarWeaponIcon[i].TextureScale / BarWeaponIcon[i].TextureScale);
				}
				else
				{
					BarWeaponIcon[i].TextureScale = default.BarWeaponIcon[i].TextureScale;
					BarWeaponIcon[i].OffsetY = default.BarWeaponIcon[i].OffsetY;
				}
				
				BarWeaponIcon[i].OffsetX =  IconOffset;
				
				BarBorderAmmoIndicator[i].Scale = FMin(W.AmmoStatus(), 1);
				BarWeaponIcon[i].Tints[TeamIndex] = HudColorNormal;

				if( BarWeaponIconAnim[i] == 0 )
				{
					if ( BarWeaponStates[i].PickupTimer > Level.TimeSeconds - 0.6 )
					{
					   if ( BarWeaponStates[i].PickupTimer > Level.TimeSeconds - 0.3 )
					   {
							BarWeaponIcon[i].TextureScale = BarWeaponIcon[i].TextureScale * (1 + 1.3 * (Level.TimeSeconds - BarWeaponStates[i].PickupTimer));
							BarWeaponIcon[i].OffsetX =  IconOffset - IconOffset * ( Level.TimeSeconds - BarWeaponStates[i].PickupTimer );
					   }
					   else
					   {
							BarWeaponIcon[i].TextureScale = BarWeaponIcon[i].TextureScale * (1 + 1.3 * (BarWeaponStates[i].PickupTimer + 0.6 - Level.TimeSeconds));
							BarWeaponIcon[i].OffsetX = IconOffset - IconOffset * (BarWeaponStates[i].PickupTimer + 0.6 - Level.TimeSeconds);
					   }
					}
					else
						BarWeaponIconAnim[i] = 1;
				}

				if (W == PendingWeapon)
				{
					// Change color to highlight and possibly changeTexture or animate it
					BarBorder[i].Tints[TeamIndex] = HudColorHighLight;
					BarBorder[i].OffsetY = -10;
					BarBorderAmmoIndicator[i].OffsetY = -10;
					BarWeaponIcon[i].OffsetY += -10 * (default.BarWeaponIcon[i].TextureScale / BarWeaponIcon[i].TextureScale);
				}
				
				if ( ExtraWeapon[i] == 1 )
				{
					if ( W == PendingWeapon )
					{
						BarBorder[i].Tints[0] = HudColorRed;
						BarBorder[i].Tints[1] = HudColorBlue;
						BarBorder[i].OffsetY = 0;
						BarBorder[i].TextureCoords.Y1 = 80;
						DrawWidgetAsTile( C, BarBorder[i] );
						BarBorder[i].TextureCoords.Y1 = 39;
						BarBorder[i].OffsetY = -10;
						BarBorder[i].Tints[TeamIndex] = HudColorHighLight;
					}
					else
					{
						BarBorder[i].OffsetY = -52;
						BarBorder[i].TextureCoords.Y2 = 48;
						DrawWidgetAsTile( C, BarBorder[i] );
						BarBorder[i].TextureCoords.Y2 = 93;
						BarBorder[i].OffsetY = 0;
					}
				}
				DrawWidgetAsTile( C, BarBorder[i] );
				DrawWidgetAsTile( C, BarBorderAmmoIndicator[i] );
				DrawWidgetAsTile( C, BarWeaponIcon[i] );
		   }
		}
		return;
	}
	
	RealRedColor = HudColorRed;
	RealBlueColor = HudColorBlue;
	
	HudColorRed = MutantHUDTint;
	HudColorBlue = MutantHUDTint;

	//Super's DrawWeaponBar!
	HudMinScale=0.5;
    //no weaponbar for vehicles
    if (Vehicle(PawnOwner) != None)
	return;

    if (PawnOwner.PendingWeapon != None)
        PendingWeapon = PawnOwner.PendingWeapon;
    else
        PendingWeapon = PawnOwner.Weapon;

	// fill:
    for( Inv=PawnOwner.Inventory; Inv!=None; Inv=Inv.Inventory )
    {
        W = Weapon( Inv );
		Count++;
		if ( Count > 100 )
			break;

        if( (W == None) || (W.IconMaterial == None) )
            continue;

		if ( W.InventoryGroup == 0 )
			Pos = 8;
		else if ( W.InventoryGroup < 10 )
			Pos = W.InventoryGroup-1;
		else
			continue;

		if ( Weapons[Pos] != None )
			ExtraWeapon[Pos] = 1;
		else
			Weapons[Pos] = W;
    }

	if ( PendingWeapon != None )
	{
		if ( PendingWeapon.InventoryGroup == 0 )
			Weapons[8] = PendingWeapon;
		else if ( PendingWeapon.InventoryGroup < 10 )
			Weapons[PendingWeapon.InventoryGroup-1] = PendingWeapon;
	}

    // Draw:
    for( i=0; i<WEAPON_BAR_SIZE; i++ )
    {
        W = Weapons[i];

		// Keep weaponbar organized when scaled
		HudScaleOffset= 1-(HudScale-HudMinScale)/HudMinScale;
		if (!bCorrectAspectRatio)
			BarBorder[i].PosX =  default.BarBorder[i].PosX +( BarBorderScaledPosition[i] - default.BarBorder[i].PosX) *HudScaleOffset;
		else
			BarBorder[i].PosX = 0.5 - ((0.5 - default.BarBorder[i].PosX) * (ResScaleY / ResScaleX) * HUDScale); 
		BarWeaponIcon[i].PosX = BarBorder[i].PosX;

		IconOffset = (default.BarBorder[i].TextureCoords.X2 - default.BarBorder[i].TextureCoords.X1) * 0.5;
		
        BarBorder[i].Tints[0] = HudColorRed;
        BarBorder[i].Tints[1] = HudColorBlue;
        BarBorder[i].OffsetY = 0;
		BarWeaponIcon[i].OffsetY = default.BarWeaponIcon[i].OffsetY;

		if( W == none )
        {
			BarWeaponStates[i].HasWeapon = false;
			if ( bShowMissingWeaponInfo )
			{
				BarWeaponIcon[i].OffsetX =  IconOffset;
				
				if ( BarWeaponIcon[i].Tints[TeamIndex] != HudColorBlack )
				{
					BarWeaponIcon[i].WidgetTexture = default.BarWeaponIcon[i].WidgetTexture;
					BarWeaponIcon[i].TextureCoords = default.BarWeaponIcon[i].TextureCoords;
					BarWeaponIcon[i].TextureScale = default.BarWeaponIcon[i].TextureScale;
					BarWeaponIcon[i].Tints[TeamIndex] = HudColorBlack;
					BarWeaponIconAnim[i] = 0;
				}
				DrawWidgetAsTile( C, BarBorder[i] );
				DrawWidgetAsTile( C, BarWeaponIcon[i] ); // FIXME- have combined version
			}
       }
        else
        {
			if( !BarWeaponStates[i].HasWeapon )
			{
				// just picked this weapon up!
				BarWeaponStates[i].PickupTimer = Level.TimeSeconds;
				BarWeaponStates[i].HasWeapon = true;
			}

	    	BarBorderAmmoIndicator[i].PosX = BarBorder[i].PosX;
			BarBorderAmmoIndicator[i].OffsetY = 0;
			
			BarWeaponIcon[i].WidgetTexture = W.IconMaterial;
			BarWeaponIcon[i].TextureCoords = W.IconCoords;
			
			//Cheese
			if (Abs(W.IconCoords.Y1 - W.IconCoords.Y2) > 64)
			{
				BarWeaponIcon[i].TextureScale = default.BarWeaponIcon[i].TextureScale / ((Abs(W.IconCoords.Y1 - W.IconCoords.Y2) + 1)/ 32);
				IconOffset *= (default.BarWeaponIcon[i].TextureScale / BarWeaponIcon[i].TextureScale);
				BarWeaponIcon[i].OffsetY = -30 * (default.BarWeaponIcon[i].TextureScale / BarWeaponIcon[i].TextureScale);
			}
			else
			{
				BarWeaponIcon[i].TextureScale = default.BarWeaponIcon[i].TextureScale;
				BarWeaponIcon[i].OffsetY = default.BarWeaponIcon[i].OffsetY;
			}
			
			BarWeaponIcon[i].OffsetX =  IconOffset;
			
            BarBorderAmmoIndicator[i].Scale = FMin(W.AmmoStatus(), 1);
            BarWeaponIcon[i].Tints[TeamIndex] = HudColorNormal;

			if( BarWeaponIconAnim[i] == 0 )
            {
                if ( BarWeaponStates[i].PickupTimer > Level.TimeSeconds - 0.6 )
	            {
		           if ( BarWeaponStates[i].PickupTimer > Level.TimeSeconds - 0.3 )
	               {
					   	BarWeaponIcon[i].TextureScale = BarWeaponIcon[i].TextureScale * (1 + 1.3 * (Level.TimeSeconds - BarWeaponStates[i].PickupTimer));
                        BarWeaponIcon[i].OffsetX =  IconOffset - IconOffset * ( Level.TimeSeconds - BarWeaponStates[i].PickupTimer );
                   }
                   else
                   {
					    BarWeaponIcon[i].TextureScale = BarWeaponIcon[i].TextureScale * (1 + 1.3 * (BarWeaponStates[i].PickupTimer + 0.6 - Level.TimeSeconds));
                        BarWeaponIcon[i].OffsetX = IconOffset - IconOffset * (BarWeaponStates[i].PickupTimer + 0.6 - Level.TimeSeconds);
                   }
                }
                else
                    BarWeaponIconAnim[i] = 1;
			}

            if (W == PendingWeapon)
            {
				// Change color to highlight and possibly changeTexture or animate it
				BarBorder[i].Tints[TeamIndex] = HudColorHighLight;
				BarBorder[i].OffsetY = -10;
				BarBorderAmmoIndicator[i].OffsetY = -10;
				BarWeaponIcon[i].OffsetY += -10 * (default.BarWeaponIcon[i].TextureScale / BarWeaponIcon[i].TextureScale);
			}
			
		    if ( ExtraWeapon[i] == 1 )
		    {
			    if ( W == PendingWeapon )
			    {
                    BarBorder[i].Tints[0] = HudColorRed;
                    BarBorder[i].Tints[1] = HudColorBlue;
				    BarBorder[i].OffsetY = 0;
				    BarBorder[i].TextureCoords.Y1 = 80;
				    DrawWidgetAsTile( C, BarBorder[i] );
				    BarBorder[i].TextureCoords.Y1 = 39;
				    BarBorder[i].OffsetY = -10;
				    BarBorder[i].Tints[TeamIndex] = HudColorHighLight;
			    }
			    else
			    {
				    BarBorder[i].OffsetY = -52;
				    BarBorder[i].TextureCoords.Y2 = 48;
		            DrawWidgetAsTile( C, BarBorder[i] );
				    BarBorder[i].TextureCoords.Y2 = 93;
				    BarBorder[i].OffsetY = 0;
			    }
		    }
	        DrawWidgetAsTile( C, BarBorder[i] );
            DrawWidgetAsTile( C, BarBorderAmmoIndicator[i] );
            DrawWidgetAsTile( C, BarWeaponIcon[i] );
       }
    }
	
	HudColorRed = RealRedColor;
	HudColorBlue = RealBlueColor;
}

simulated function DrawHud(Canvas C)
{
	local color RealRedColor, RealBlueColor;

	bMutantHudColor = PRIIsMutant(PlayerOwner.PlayerReplicationInfo);
	
	if ( !bMutantHUDColor )
	{
		Super(HudCDeathMatch).DrawHud(C);
		return;
	}
	
	RealRedColor = HudColorRed;
	RealBlueColor = HudColorBlue;
	
	HudColorRed = MutantHUDTint;
	HudColorBlue = MutantHUDTint;

	Super(HudCDeathMatch).DrawHud(C);
	
	HudColorRed = RealRedColor;
	HudColorBlue = RealBlueColor;
}

simulated function bool PawnIsVisible(vector vecPawnView, vector X, pawn P)
{
	local vector StartTrace, EndTrace;

    if ( (PawnOwner == None) || (PlayerOwner==None) )
		return false;

	if ( PawnOwner != PlayerOwner.Pawn )
		return false;

	if ( (vecPawnView Dot X) <= 0.70 )
		return false;
		
	StartTrace = PawnOwner.Location;
	StartTrace.Z += PawnOwner.BaseEyeHeight;

	EndTrace = P.Location;
	EndTrace.Z += P.BaseEyeHeight;

	if ( !FastTrace(EndTrace, StartTrace) )
		return false;

	return true;		
}

function DrawCustomBeacon(Canvas C, Pawn P, float ScreenLocX, float ScreenLocY)
{
	if ( P.PlayerReplicationInfo != MutantGameReplicationInfo(PlayerOwner.GameReplicationInfo).BottomFeederPRI )
		return;

	C.DrawColor = BottomFeederTextColor;
	C.SetPos(ScreenLocX - 0.125 * BottomFeederBeaconMat.USize, ScreenLocY - 0.125 * BottomFeederBeaconMat.VSize);
	C.DrawTile(BottomFeederBeaconMat, 
		0.25 * BottomFeederBeaconMat.USize, 
		0.25 * BottomFeederBeaconMat.VSize, 
		0.0,
		0.0,
		BottomFeederBeaconMat.USize,
		BottomFeederBeaconMat.VSize);
}

simulated function DrawBottomFeederIndicator(Canvas C); //OBSOLETE

simulated function DrawHudPassA(Canvas C)
{
    local rotator Dir;
    local float Angle, VertDiff, Range, AngleDelta;
	local MutantGameReplicationInfo mutantInfo;
	local xMutantPawn x;
	local Pawn RealPawnOwner;
	local class<Ammunition> AmmoClass;

	ZoomFadeOut(C);

	if ( PawnOwner != None )
	{
		if( bShowWeaponInfo && (PawnOwner.Weapon != None) )
		{
			if ( PawnOwner.Weapon.bShowChargingBar )
    			DrawChargeBar(C);

			DrawWidgetAsTile( C, HudBorderAmmo );

			if( PawnOwner.Weapon != None )
			{
				AmmoClass = PawnOwner.Weapon.GetAmmoClass(0);
				if ( (AmmoClass != None) && (AmmoClass.Default.IconMaterial != None) )
				{
					if( (CurAmmoPrimary/MaxAmmoPrimary) < 0.15)
					{
						DrawWidgetAsTile(C, HudAmmoALERT);
						HudAmmoALERT.Tints[0] = HudColorRed;
						HudAmmoALERT.Tints[1] = HudColorBlue;
						if ( AmmoClass.Default.IconFlashMaterial == None )
							AmmoIcon.WidgetTexture = Material'HudContent.Generic.HUDPulse';
						else
							AmmoIcon.WidgetTexture = AmmoClass.Default.IconFlashMaterial;
					}
					else
					{
						AmmoIcon.WidgetTexture = AmmoClass.default.IconMaterial;
					}

					AmmoIcon.TextureCoords = AmmoClass.Default.IconCoords;
					DrawWidgetAsTile (C, AmmoIcon);
				}
			}
			DrawNumericWidgetAsTiles( C, DigitsAmmo, DigitsBig);
		}

		if ( bShowWeaponBar && (PawnOwner.Weapon != None) )
			DrawWeaponBar(C);

		if( bShowPersonalInfo )
		{
    		if ( Vehicle(PawnOwner) != None && Vehicle(PawnOwner).Driver != None )
    		{
    			if (Vehicle(PawnOwner).bShowChargingBar)
    				DrawVehicleChargeBar(C);
    			RealPawnOwner = PawnOwner;
    			PawnOwner = Vehicle(PawnOwner).Driver;
    		}

			DrawHUDAnimWidget( HudBorderHealthIcon, default.HudBorderHealthIcon.TextureScale, LastHealthPickupTime, 0.6, 0.6);
			DrawWidgetAsTile( C, HudBorderHealth );

			if(CurHealth/PawnOwner.HealthMax < 0.26)
			{
				HudHealthALERT.Tints[0] = HudColorRed;
				HudHealthALERT.Tints[1] = HudColorBlue;
				DrawWidgetAsTile( C, HudHealthALERT);
				HudBorderHealthIcon.WidgetTexture = Material'HudContent.Generic.HUDPulse';
			}
			else
				HudBorderHealthIcon.WidgetTexture = default.HudBorderHealth.WidgetTexture;

			DrawWidgetAsTile( C, HudBorderHealthIcon);

			if( CurHealth < LastHealth )
				LastDamagedHealth = Level.TimeSeconds;

			DrawHUDAnimDigit( DigitsHealth, default.DigitsHealth.TextureScale, LastDamagedHealth, 0.8, default.DigitsHealth.Tints[TeamIndex], HudColorHighLight);
			DrawNumericWidgetAsTiles( C, DigitsHealth, DigitsBig);

			if(CurHealth > 999)
			{
				DigitsHealth.OffsetX=220;
				DigitsHealth.OffsetY=-35;
				DigitsHealth.TextureScale=0.39;
			}
			else
			{
				DigitsHealth.OffsetX = default.DigitsHealth.OffsetX;
				DigitsHealth.OffsetY = default.DigitsHealth.OffsetY;
				DigitsHealth.TextureScale = default.DigitsHealth.TextureScale;
			}

			if (RealPawnOwner != None)
			{
				PawnOwner = RealPawnOwner;

				DrawWidgetAsTile( C, HudBorderVehicleHealth );

				if (CurVehicleHealth/PawnOwner.HealthMax < 0.26)
				{
					HudVehicleHealthALERT.Tints[0] = HudColorRed;
					HudVehicleHealthALERT.Tints[1] = HudColorBlue;
					DrawWidgetAsTile(C, HudVehicleHealthALERT);
					HudBorderVehicleHealthIcon.WidgetTexture = Material'HudContent.Generic.HUDPulse';
				}
				else
					HudBorderVehicleHealthIcon.WidgetTexture = default.HudBorderVehicleHealth.WidgetTexture;

				DrawWidgetAsTile(C, HudBorderVehicleHealthIcon);

				if (CurVehicleHealth < LastVehicleHealth )
					LastDamagedVehicleHealth = Level.TimeSeconds;

				DrawHUDAnimDigit(DigitsVehicleHealth, default.DigitsVehicleHealth.TextureScale, LastDamagedVehicleHealth, 0.8, default.DigitsVehicleHealth.Tints[TeamIndex], HudColorHighLight);
				DrawNumericWidgetAsTiles(C, DigitsVehicleHealth, DigitsBig);

				if (CurVehicleHealth > 999)
				{
					DigitsVehicleHealth.OffsetX = 445;
					DigitsVehicleHealth.OffsetY = -35;
					DigitsVehicleHealth.TextureScale = 0.39;
				}
				else
				{
					DigitsVehicleHealth.OffsetX = default.DigitsVehicleHealth.OffsetX;
					DigitsVehicleHealth.OffsetY = default.DigitsVehicleHealth.OffsetY;
					DigitsVehicleHealth.TextureScale = default.DigitsVehicleHealth.TextureScale;
				}
			}

			DrawAdrenaline(C);
		}
	}

	UpdateRankAndSpread(C);
    DrawUDamage(C);

    if(bDrawTimer)
		DrawTimer(C);

    // Temp Draw with Hud Colors
    HudBorderShield.Tints[0] = HudColorRed;
    HudBorderShield.Tints[1] = HudColorBlue;
    HudBorderHealth.Tints[0] = HudColorRed;
    HudBorderHealth.Tints[1] = HudColorBlue;
    HudBorderVehicleHealth.Tints[0] = HudColorRed;
    HudBorderVehicleHealth.Tints[1] = HudColorBlue;
    HudBorderAmmo.Tints[0] = HudColorRed;
    HudBorderAmmo.Tints[1] = HudColorBlue;

    if( bShowPersonalInfo && (CurShield > 0) )
    {
	    DrawWidgetAsTile( C, HudBorderShield );
		DrawWidgetAsTile( C, HudBorderShieldIcon);
		DrawNumericWidgetAsTiles( C, DigitsShield, DigitsBig);
		DrawHUDAnimWidget( HudBorderShieldIcon, default.HudBorderShieldIcon.TextureScale, LastArmorPickupTime, 0.6, 0.6);
    }

	if( Level.TimeSeconds - LastVoiceGainTime < 0.333 )
		DisplayVoiceGain(C);

    DisplayLocalMessages (C);

	mutantInfo = MutantGameReplicationInfo(PlayerOwner.GameReplicationInfo);
	x = xMutantPawn(PawnOwner);

	// If there is a mutant, and we are not it - draw radar indicating mutant location.
	if( bTestHud || (mutantInfo.MutantPRI != None && mutantInfo.MutantPRI != PlayerOwner.PlayerReplicationInfo) )
	{
		// Draw radar outline
		if(bCenterRadar)
		{
			PassStyle=STY_None;
			DrawWidgetAsTile (C, CenterRadarBG);
			PassStyle=STY_Alpha;
		}
		else
		{
			DrawWidgetAsTile(C, TopRadarBG);
		}

		if(bTestHud)
		{
			Dir = rotator(vect(0, 0, 0) - PawnOwner.Location);
			VertDiff = 0.0 - PawnOwner.Location.Z;
			Range = VSize(vect(0, 0, 0) - PawnOwner.Location) - class'xPawn'.default.CollisionRadius;
		}
		else
		{
			Dir = rotator(mutantInfo.MutantLocation - PawnOwner.Location);
			VertDiff = mutantInfo.MutantLocation.Z - PawnOwner.Location.Z;

			// Remove player radiii from range (so when you are standing next to the mutant range is zero)
			Range = VSize(mutantInfo.MutantLocation - PawnOwner.Location) - (2 * class'xPawn'.default.CollisionRadius);
		}

		Angle = ((Dir.Yaw - PawnOwner.Rotation.Yaw) & 65535) * 6.2832/65536;
	
		if(VertDiff > LevelRampRegion)
			C.DrawColor = AboveMutantColor;
		else if(VertDiff > 0)
			C.DrawColor = LerpColor(VertDiff/LevelRampRegion, LevelMutantColor, AboveMutantColor);
		else if(VertDiff > -LevelRampRegion)
			C.DrawColor = LerpColor(-VertDiff/LevelRampRegion, LevelMutantColor, BelowMutantColor);
		else
			C.DrawColor = BelowMutantColor;

		C.Style = ERenderStyle.STY_Alpha;

		if (bCorrectAspectRatio)
		{
			if(bCenterRadar)
			{
				C.SetPos(XCen * C.ClipX + HudScale * (ResScaleY/ResScaleX) * XRad * C.ClipX * sin(Angle) - 0.5*BigDotSize*C.ClipX,
					YCen * C.ClipY - HudScale * YRad * C.ClipY * cos(Angle) - 0.5*BigDotSize*C.ClipX );
			}
			else
			{
				C.SetPos(0.492 * C.ClipX + HudScale * (ResScaleY/ResScaleX) * 0.034 * C.ClipX * sin(Angle),
					(0.041 + 0.12) * C.ClipY - (HudScale * 0.045 * C.ClipY * cos(Angle)));
			}
		}
		else
		{
			if(bCenterRadar)
			{
				C.SetPos(XCen * C.ClipX + HudScale * XRad * C.ClipX * sin(Angle) - 0.5*BigDotSize*C.ClipX,
					YCen * C.ClipY - HudScale * YRad * C.ClipY * cos(Angle) - 0.5*BigDotSize*C.ClipX );
			}
			else 	C.SetPos(0.492 * C.ClipX + HudScale * 0.034 * C.ClipX * sin(Angle),
					(0.041 + 0.12) * C.ClipY - (HudScale * 0.045 * C.ClipY * cos(Angle)));
				
		}

		C.DrawTile(Material'InterfaceContent.Hud.SkinA', BigDotSize*C.ClipX, BigDotSize*C.ClipX,838,238,144,144);

		if(bCenterRadar)
		{
			//  Draw dots to indicate mutant range
			AngleDelta = (FMin(RangeRampRegion, Range)/RangeRampRegion) * MaxAngleDelta;

			C.DrawColor = RangeDotColor;
			
			if (bCorrectAspectRatio)
				C.SetPos(XCen * C.ClipX + HudScale * (ResScaleY/ResScaleX) * XRad * C.ClipX * sin(Angle + AngleDelta) - 0.5*SmallDotSize*C.ClipX,
					YCen * C.ClipY - HudScale * YRad * C.ClipY * cos(Angle + AngleDelta) - 0.5*SmallDotSize*C.ClipX );
			
			else 	C.SetPos(XCen * C.ClipX + HudScale * XRad * C.ClipX * sin(Angle + AngleDelta) - 0.5*SmallDotSize*C.ClipX,
					YCen * C.ClipY - HudScale * YRad * C.ClipY * cos(Angle + AngleDelta) - 0.5*SmallDotSize*C.ClipX );

			C.DrawTile(Material'InterfaceContent.Hud.SkinA', SmallDotSize*C.ClipX, SmallDotSize*C.ClipX, 838, 238, 144, 144);

			if(bCorrectAspectRatio)
				C.SetPos(XCen * C.ClipX + HudScale * (ResScaleY/ResScaleX) * XRad * C.ClipX * sin(Angle - AngleDelta) - 0.5*SmallDotSize*C.ClipX,
					YCen * C.ClipY - HudScale * YRad * C.ClipY * cos(Angle - AngleDelta) - 0.5*SmallDotSize*C.ClipX);
					
			else 	C.SetPos(XCen * C.ClipX + HudScale * XRad * C.ClipX * sin(Angle - AngleDelta) - 0.5*SmallDotSize*C.ClipX,
					YCen * C.ClipY - HudScale * YRad * C.ClipY * cos(Angle - AngleDelta) - 0.5*SmallDotSize*C.ClipX);

			C.DrawTile(Material'InterfaceContent.Hud.SkinA', SmallDotSize*C.ClipX, SmallDotSize*C.ClipX, 838, 238, 144, 144);
		}
		else
		{
			// Draw on Mutant range in middle of dial
			C.DrawColor = MutantRangeColor;
			C.Font = LoadMutantRangeFont();
			C.DrawTextJustified( Min(int(Range),9999) , 1, 0.4 * C.ClipX, 0.15 * C.ClipY, 0.6 * C.ClipX, 0.2 * C.ClipY);
		}

		// Draw on Mutant name

		C.DrawColor = WhiteColor;
		C.SetPos(C.ClipX * (0.5 - (ResScaleY/ResScaleX) * MNOriginX), C.ClipY * MNOriginY);
		C.DrawTileStretched(texture 'InterfaceContent.Menu.BorderBoxD', MNSizeX * (ResScaleY/ResScaleX) * C.ClipX, MNSizeY * C.ClipY);

		C.DrawColor = CurrentMutantColor;
		C.Font = LoadLevelActionFont();

		
		if( bTestHud)
			C.DrawTextJustified("DefLoc", 1, 0.3 * C.ClipX, 0.015 * C.ClipY, 0.7 * C.ClipX, 0.065 * C.ClipY);
		else
			C.DrawTextJustified(mutantInfo.MutantPRI.PlayerName, 1, 0.3 * C.ClipX, 0.015 * C.ClipY, 0.7 * C.ClipX, 0.065 * C.ClipY);
	}
		
	// If there is no bottom feeder - no more HUD to do.
	if( mutantInfo.BottomFeederPRI == None)
		return;

	// If we are a bottom feeder - indicate on the screen
	if( PRIIsBottomFeeder(PlayerOwner.PlayerReplicationInfo) )
	{
		C.DrawColor = WhiteColor;
		C.SetPos(C.ClipX + (BFIOffsetX * ResScaleY * HUDScale), C.ClipY * BFIOriginY);
		C.DrawTileStretched(texture 'InterfaceContent.Menu.BorderBoxD', BFISizeX  * ResScaleY * HUDScale, BFISizeY  * ResScaleY * HUDScale);

		C.DrawColor.R = 255 * (0.5 + 0.5 * Cos(Level.TimeSeconds * Pi * BFIPulseRate));
		C.SetPos(C.ClipX + ((BFIOffsetX + BFIMargin) * ResScaleY * HUDScale), C.ClipY * (BFIOriginY + 0.01));
		C.DrawTile( BottomFeederIcon, ((BFISizeX - 2*BFIMargin) * ResScaleY * HUDScale), (BFISizeY - 2*BFIMargin) * ResScaleY * HUDScale, 0, 0, 256, 256);
	}
}

// Draw enemy name. Also indicate bottom feeders.
function DisplayEnemyName(Canvas C, PlayerReplicationInfo PRI)
{
	// Send 'bottom feeder' indication
	if( PRIIsBottomFeeder( PRI ) )
		PlayerOwner.ReceiveLocalizedMessage(class'MutantNameMessage',1,PRI);
	else //send blank bottomfeeder message
		PlayerOwner.ReceiveLocalizedMessage(class'MutantNameMessage',0,PRI);
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
     BFIOffsetX=-64.000000
     TopRadarBG=(PosY=0.120000,OffsetY=0)
     MNOriginX=0.220000
     MNSizeX=0.440000
     BFISizeX=57.000000
     BFISizeY=48.000000
     BFIMargin=6.000000
     DigitsVehicleHealth=(PosX=0.000000,OffsetX=357)
     HudVehicleHealthALERT=(PosX=0.000000,OffsetX=168)
     HudBorderVehicleHealth=(PosX=0.000000,OffsetX=168)
     HudBorderVehicleHealthIcon=(PosX=0.000000,OffsetX=173)
     BarWeaponIcon(0)=(DrawPivot=DP_MiddleMiddle,OffsetY=-30)
     BarWeaponIcon(1)=(DrawPivot=DP_MiddleMiddle,OffsetY=-30)
     BarWeaponIcon(2)=(DrawPivot=DP_MiddleMiddle,OffsetY=-25)
     BarWeaponIcon(3)=(DrawPivot=DP_MiddleMiddle,OffsetY=-30)
     BarWeaponIcon(4)=(DrawPivot=DP_MiddleMiddle,OffsetY=-30)
     BarWeaponIcon(5)=(DrawPivot=DP_MiddleMiddle,OffsetY=-30)
     BarWeaponIcon(6)=(DrawPivot=DP_MiddleMiddle,OffsetY=-30)
     BarWeaponIcon(7)=(DrawPivot=DP_MiddleMiddle,OffsetY=-30)
     BarWeaponIcon(8)=(DrawPivot=DP_MiddleMiddle,OffsetY=-30)
}
