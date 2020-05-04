//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ONSHUDWOnslaught extends ONSHUDOnslaught
    config(user);
	
	//Positioning
var const float XShifts[9];
var const float YShifts[9];

//Scaling
var bool bCorrectAspectRatio;

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

simulated function DrawWeaponBar( Canvas C )
{
    local int i, Count, Pos;
    local float IconOffset;
	local float HudScaleOffset, HudMinScale;

    local Weapon Weapons[WEAPON_BAR_SIZE];
    local byte ExtraWeapon[WEAPON_BAR_SIZE];
    local Inventory Inv;
    local Weapon W, PendingWeapon;

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
}

simulated function DrawSpectatingHud (Canvas C)
{
	Super(HudCTeamDeathMatch).DrawSpectatingHud(C);

	if ( (PlayerOwner == None) || (PlayerOwner.PlayerReplicationInfo == None)
		|| !PlayerOwner.PlayerReplicationInfo.bOnlySpectator )
		return;

	UpdateRankAndSpread(C);
	ShowTeamScorePassA(C);
	ShowTeamScorePassC(C);
	UpdateTeamHUD();
}

simulated function showLinks()
{
	if ( PawnOwner.Weapon != None && PawnOwner.Weapon.IsA('LinkGun') )
		Links = LinkGun(PawnOwner.Weapon).Links;
	else
		Links = 0;
}

simulated function drawLinkText(Canvas C)
{
	text = LinkEstablishedMessage;

	C.Font = LoadLevelActionFont();
	C.DrawColor = LevelActionFontColor;

	C.DrawColor = LevelActionFontColor;
	C.Style = ERenderStyle.STY_Alpha;

	C.DrawScreenText (text, 1, 0.81, DP_LowerRight);
}

simulated function UpdateRankAndSpread(Canvas C)
{
	// making sure that the Rank and Spread dont get drawn in other gametypes
}

simulated function DrawTeamOverlay( Canvas C )
{
     // TODO: draw top 5 playersnames and Position on map
}

simulated function DrawMyScore ( Canvas C )
{
     // Dont show MyScore in team games
}
simulated function DrawHudPassA (Canvas C)
{
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
	UpdateRankAndSpread(C);
	ShowTeamScorePassA(C);

	if ( Links >0 )
	{
		DrawWidgetAsTile (C, LinkIcon);
	    DrawNumericWidgetAsTiles (C, totalLinks, DigitsBigPulse);
	}
	totalLinks.value = Links;
}

simulated function ShowVersusIcon(Canvas C)
{
	DrawWidgetAsTile (C, VersusSymbol );
}

simulated function TeamScoreOffset();

// Alpha Pass ==================================================================================
simulated function DrawHudPassC (Canvas C)
{
    Super(HudCTeamDeathMatch).DrawHudPassC (C);
	ShowTeamScorePassC(C);
}

// Alternate Texture Pass ======================================================================

simulated function UpdateTeamHud()
{
    local GameReplicationInfo GRI;
    local int i;

	GRI = PlayerOwner.GameReplicationInfo;

	if (GRI == None)
        return;

    for (i = 0; i < 2; i++)
    {
        if (GRI.Teams[i] == None)
            continue;

		TeamSymbols[i].Tints[i] = HudColorTeam[i];
        ScoreTeam[i].Value =  Min(GRI.Teams[i].Score, 999);  // max space in hud

        if (GRI.TeamSymbols[i] != None)
			TeamSymbols[i].WidgetTexture = GRI.TeamSymbols [i];
    }
}

simulated function UpdateHud()
{
	UpdateTeamHUD();
	showLinks();
    Super(HudCTeamDeathMatch).UpdateHud();
}

function bool CustomHUDColorAllowed()
{
	return false;
}

simulated event PostBeginPlay()
{
	local ONSPowerCore Core;
	local TerrainInfo T, PrimaryTerrain;
	local int i;

	Super(HudCTeamDeathMatch).PostBeginPlay();

	foreach AllActors( class'ONSPowerCore', Core )
		if ( Core.bFinalCore )
			FinalCore[Core.DefenderTeamIndex] = Core;

	Node = FinalCore[0];

	// Setup links right away, even though these will be overwritten when the new link setup is received from the server
	if ( Level.NetMode == NM_Client )
		SetupLinks();

	// Assign PowerNode numbers
	Core = Node;
	do
	{
        if (ONSPowerNode(Core) != None)
        {
            Core.NodeNum = ++i;
            Core.UpdateLocationName();
        }

        Core = Core.NextCore;
	} until ( Core == None || Core == Node );

	// Determine primary terrain
    foreach AllActors(class'TerrainInfo', T)
    {
        PrimaryTerrain = T;
        if (T.Tag == 'PrimaryTerrain')
            Break;
    }

    // Set RadarMaxRange to size of primary terrain
    if (Level.bUseTerrainForRadarRange && PrimaryTerrain != None)
        RadarRange = abs(PrimaryTerrain.TerrainScale.X * PrimaryTerrain.TerrainMap.USize) / 2.0;
    else if (Level.CustomRadarRange > 0)
        RadarRange = Clamp(Level.CustomRadarRange, 500.0, default.RadarMaxRange);

    SetTimer(1.0, true);
    Timer();
}

simulated function SetupLinks()
{
	local ONSPowerCore Core;
	local int i;

	if ( Node == None )
		return;

//	log(Name@"SetupLinks");
	Core = Node;
	do
	{
		for ( i = 0; i < Core.PowerLinks.Length; i++ )
			AddLink(Core, Core.PowerLinks[i]);

		Core = Core.NextCore;
	} until ( Core == None || Core == Node );
}

simulated function ReceiveLink( ONSPowerCore A, ONSPowerCore B )
{
	bReceivedLinks = True;

//	log(Name@"ReceiveLink  A:"$A.Name@"B:"$B.Name);
	AddLink(A,B);
//	A.AddPowerLink(B);
}

simulated function AddLink( ONSPowerCore A, ONSPowerCore B )
{
	local PowerLink Link;

	if ( HasLink(A,B) )
		return;

	Link = Spawn(class'PowerLink');
	Link.SetNodes(A,B);

	PowerLinks[PowerLinks.Length] = Link;
}

simulated function RemoveLink( ONSPowerCore A, ONSPowerCore B )
{
	local int i;

//	log(Name@"Remove link from A:"$A.Name@"to"@B.Name);

	for ( i = PowerLinks.Length - 1; i >= 0; i-- )
	{
		if ( PowerLinks[i] == None )
		{
			PowerLinks.Remove(i,1);
			continue;
		}

		if ( PowerLinks[i].HasNodes(A,B) )
		{
//			log(Name@"found powerlink containing those nodes:"$PowerLinks[i].Name);
			PowerLinks[i].Destroy();
			PowerLinks.Remove(i,1);
		}
	}
}

simulated function ResetLinks()
{
//	log(Name@"ResetLinks");
	ClearLinks();
	RequestPowerLinks();

/*
	if ( Level.NetMode == NM_Client )
	{
		Core = Node;
		do
		{
			Core.PowerCoreReset();
			Core = Core.NextCore;
		} until ( Core == None || Core == Node );
	}
*/
}

simulated function bool HasLink( ONSPowerCore A, ONSPowerCore B )
{
	local int i;

	for ( i = PowerLinks.Length - 1; i >= 0; i-- )
	{
		if ( PowerLinks[i] == None )
		{
			PowerLinks.Remove(i,1);
			continue;
		}

		if ( PowerLinks[i].HasNodes(A,B) )
			return True;
	}

	return False;
}

simulated function ClearLinks()
{
	local int i;
	bReceivedLinks = False;

//	log(Name@"ClearLinks"@PowerLinks.Length);
	for ( i = 0; i < PowerLinks.Length; i++ )
		if ( PowerLinks[i] != None )
			PowerLinks[i].Destroy();

	PowerLinks.Remove(0, PowerLinks.Length);
}

// Finds a PowerCore within 2500 units of PosX/PosY on the RadarMap (assumes a map centered at 0,0,0)
simulated function ONSPowerCore LocatePowerCore(float PosX, float PosY, float RadarWidth)
{
    local float WorldToMapScaleFactor, Distance, LowestDistance;
    local vector WorldLocation, DistanceVector;
    local ONSPowerCore BestCore, Core;

	if (Node == None)
		return None;

    WorldToMapScaleFactor = RadarRange/RadarWidth;

    WorldLocation.X = PosX * WorldToMapScaleFactor;
    WorldLocation.Y = PosY * WorldToMapScaleFactor;

    LowestDistance = 2500.0;

	Core = Node;
	do
	{
        DistanceVector = Core.Location - WorldLocation;
        DistanceVector.Z = 0;
		Distance = VSize(DistanceVector);
        if (Distance < LowestDistance)
        {
            BestCore = Core;
            LowestDistance = Distance;
        }

		Core = Core.NextCore;
    } until ( Core == None || Core == Node );

    return BestCore;
}

simulated function DrawRadarMap(Canvas C, float CenterPosX, float CenterPosY, float RadarWidth, bool bShowDisabledNodes)
{
	local float PawnIconSize, PlayerIconSize, CoreIconSize, MapScale, MapRadarWidth;
	local vector HUDLocation;
	local FinalBlend PlayerIcon;
	local Actor A;
	local ONSPowerCore CurCore;
	local int i;
	local plane SavedModulation;

	SavedModulation = C.ColorModulate;

	C.ColorModulate.X = 1;
	C.ColorModulate.Y = 1;
	C.ColorModulate.Z = 1;
	C.ColorModulate.W = 1;

	// Make sure that the canvas style is alpha
	C.Style = ERenderStyle.STY_Alpha;

	MapRadarWidth = RadarWidth;
    if (PawnOwner != None)
    {
//    	MapCenter.X = FClamp(PawnOwner.Location.X, -RadarMaxRange + RadarRange, RadarMaxRange - RadarRange);
//    	MapCenter.Y = FClamp(PawnOwner.Location.Y, -RadarMaxRange + RadarRange, RadarMaxRange - RadarRange);
        MapCenter.X = 0.0;
        MapCenter.Y = 0.0;
    }
    else
        MapCenter = vect(0,0,0);

	HUDLocation.X = RadarWidth;
	HUDLocation.Y = RadarRange;
	HUDLocation.Z = RadarTrans;

	DrawMapImage( C, Level.RadarMapImage, CenterPosX, CenterPosY, MapCenter.X, MapCenter.Y, HUDLocation );

	if (Node == None)
		return;

	CurCore = Node;
	do
	{
		if ( CurCore.HasHealthBar() )
			DrawHealthBar(C, CurCore, CurCore.Health, CurCore.DamageCapacity, HealthBarPosition);

		CurCore = CurCore.NextCore;
	} until ( CurCore == None || CurCore == Node );

	CoreIconSize = IconScale * 16 * C.ClipX * HUDScale/1600;
	PawnIconSize = CoreIconSize * 0.5;
	PlayerIconSize = CoreIconSize * 1.5;
    MapScale = MapRadarWidth/RadarRange;
    C.Font = GetConsoleFont(C);

	Node.UpdateHUDLocation( CenterPosX, CenterPosY, RadarWidth, RadarRange, MapCenter );
	for ( i = 0; i < PowerLinks.Length; i++ )
		PowerLinks[i].Render(C, ColorPercent, bShowDisabledNodes);

	CurCore = Node;
	do
	{
		if (!bShowDisabledNodes && (CurCore.CoreStage == 255 || CurCore.PowerLinks.Length == 0))	//hide unused powernodes
		{
			if (PlayerOwner==none || !PlayerOwner.bDemoOwner)
			{
				CurCore = CurCore.NextCore;
				continue;
			}
		}

		C.DrawColor = LinkColor[CurCore.DefenderTeamIndex];

		// Draw appropriate icon to represent the current state of this node
	    if (CurCore.bUnderAttack || (CurCore.CoreStage == 0 && CurCore.bSevered))
	    	DrawAttackIcon( C, CurCore, CurCore.HUDLocation, IconScale, HUDScale, ColorPercent );

		if (CurCore.bFinalCore)
			DrawCoreIcon( C, CurCore.HUDLocation, PowerCoreAttackable(CurCore), IconScale, HUDScale, ColorPercent );
		else
		{
			DrawNodeIcon( C, CurCore.HUDLocation, PowerCoreAttackable(CurCore), CurCore.CoreStage, IconScale, HUDScale, ColorPercent );
			DrawNodeLabel(C, CurCore.HUDLocation, IconScale, HUDScale, C.DrawColor, CurCore.NodeNum);
		}

		CurCore = CurCore.NextCore;

	} until ( CurCore == None || CurCore == Node );

    // Draw PlayerIcon
    if (PawnOwner != None)
    	A = PawnOwner;
    else if (PlayerOwner.IsInState('Spectating'))
        A = PlayerOwner;
    else if (PlayerOwner.Pawn != None)
    	A = PlayerOwner.Pawn;

    if (A != None)
    {
    	PlayerIcon = FinalBlend'CurrentPlayerIconFinal';
    	TexRotator(PlayerIcon.Material).Rotation.Yaw = -A.Rotation.Yaw - 16384;
        HUDLocation = A.Location - MapCenter;
        HUDLocation.Z = 0;
    	if (HUDLocation.X < (RadarRange * 0.95) && HUDLocation.Y < (RadarRange * 0.95))
    	{
        	C.SetPos( CenterPosX + HUDLocation.X * MapScale - PlayerIconSize * 0.5,
                          CenterPosY + HUDLocation.Y * MapScale - PlayerIconSize * 0.5 );

            C.DrawColor = C.MakeColor(40,255,40);
            C.DrawTile(PlayerIcon, PlayerIconSize, PlayerIconSize, 0, 0, 64, 64);
        }
    }

//    // VERY SLOW DEBUGGING CODE for showing all the dynamic actors that exist in the level in real-time
//    ForEach DynamicActors(class'Actor', A)
//    {
//        if (A.IsA('Projectile')) //(A.IsA('Projector') || A.IsA('Emitter') || A.IsA('xEmitter'))
//        {
//            HUDLocation = A.Location - MapCenter;
//            HUDLocation.Z = 0;
//        	C.SetPos(CenterPosX + HUDLocation.X * MapScale - PlayerIconSize * 0.5 * 0.25, CenterPosY + HUDLocation.Y * MapScale - PlayerIconSize * 0.5 * 0.25);
//            C.DrawColor = C.MakeColor(255,255,0);
//            C.DrawTile(Material'NewHUDIcons', PlayerIconSize * 0.25, PlayerIconSize * 0.25, 0, 0, 32, 32);
//        }
//        if (A.IsA('Pawn'))
//        {
//            if (Pawn(A).PlayerReplicationInfo != None && Pawn(A).PlayerReplicationInfo.Team != None)
//            {
//                if (Pawn(A).PlayerReplicationInfo.Team.TeamIndex == 0)
//                    C.DrawColor = C.MakeColor(255,0,0);
//                else if (Pawn(A).PlayerReplicationInfo.Team.TeamIndex == 1)
//                    C.DrawColor = C.MakeColor(0,0,255);
//                else
//                    C.DrawColor = C.MakeColor(255,0,255);
//            }
//            else
//                C.DrawColor = C.MakeColor(255,255,255);
//
//            HUDLocation = A.Location - MapCenter;
//            HUDLocation.Z = 0;
//
//            if (A.IsA('Vehicle'))
//            {
//            	C.SetPos(CenterPosX + HUDLocation.X * MapScale - PlayerIconSize * 0.5 * 0.5, CenterPosY + HUDLocation.Y * MapScale - PlayerIconSize * 0.5 * 0.5);
//                C.DrawTile(Material'NewHUDIcons', PlayerIconSize * 0.5, PlayerIconSize * 0.5, 0, 0, 32, 32);
//            }
//            else
//            {
//            	C.SetPos(CenterPosX + HUDLocation.X * MapScale - PlayerIconSize * 0.5 * 0.25, CenterPosY + HUDLocation.Y * MapScale - PlayerIconSize * 0.5 * 0.25);
//                C.DrawTile(Material'NewHUDIcons', PlayerIconSize * 0.25, PlayerIconSize * 0.25, 0, 0, 32, 32);
//            }
//        }
//    }

    // Draw Border
    C.DrawColor = C.MakeColor(200,200,200);
	C.SetPos(CenterPosX - RadarWidth, CenterPosY - RadarWidth);
	C.DrawTile(BorderMat,
               RadarWidth * 2.0,
               RadarWidth * 2.0,
               0,
               0,
               256,
               256);

    C.ColorModulate = SavedModulation;
}

function bool PowerCoreAttackable(ONSPowerCore PC)
{
    if  (PawnOwnerPRI != None && PawnOwnerPRI.Team != None)
    {
        if (PC.DefenderTeamIndex != PawnOwnerPRI.Team.TeamIndex)
            return (PC.PoweredBy(PawnOwnerPRI.Team.TeamIndex));
        else
        {
            if (PawnOwnerPRI.Team.TeamIndex == 0)
                return (PC.PoweredBy(1));
            else
                return (PC.PoweredBy(0));
        }
    }

    return False;
}

simulated function ShowTeamScorePassA(Canvas C)
{
	local int x;

	if ( bShowPoints )
	{
		DrawWidgetAsTile (C, TeamScoreBackground[0]);
		DrawWidgetAsTile (C, TeamScoreBackground[1]);
		DrawWidgetAsTile (C, TeamScoreBackgroundDisc[0]);
		DrawWidgetAsTile (C, TeamScoreBackgroundDisc[1]);

        TeamScoreBackground[0].Tints[TeamIndex] = HudColorBlack;
        TeamScoreBackground[0].Tints[TeamIndex].A = 150;
        TeamScoreBackground[1].Tints[TeamIndex] = HudColorBlack;
        TeamScoreBackground[1].Tints[TeamIndex].A = 150;


		if (TeamSymbols[0].WidgetTexture != None)
			DrawWidgetAsTile (C, TeamSymbols[0]);

		if (TeamSymbols[1].WidgetTexture != None)
			DrawWidgetAsTile (C, TeamSymbols[1]);

        ShowVersusIcon(C);
	 	DrawNumericWidgetAsTiles (C, ScoreTeam[0], DigitsBig);
		DrawNumericWidgetAsTiles (C, ScoreTeam[1], DigitsBig);

		for (x = 0; x < 2; x++)
		{
			DrawWidgetAsTile (C, SymbolGB[x]);

			if (FinalCore[x] != None && FinalCore[x].CoreStage == 0)
			{
				DrawWidgetAsTile (C, CoreWidgets[x]);

				if (FinalCore[x].bUnderAttack)
				{
					CoreHealthWidgets[x].Tints[TeamIndex].G = 255 * ColorPercent;
					CoreHealthWidgets[x].Tints[TeamIndex].B = 255 * ColorPercent;
				}
				else
					CoreHealthWidgets[x].Tints[TeamIndex] = WhiteColor;

				CoreHealthWidgets[x].Value = round((float(FinalCore[x].Health) / FinalCore[x].DamageCapacity) * 100);
				DrawNumericWidgetAsTiles(C, CoreHealthWidgets[x], DigitsBig);

				//C.DrawColor = HudColorHighLight;
				//Draw2DLocationDot(C, FinalCore[x].Location,0.5 + tmpPosX[x]*HUDScale, tmpPosY*HUDScale, tmpScaleX*HUDScale, tmpScaleY*HUDScale);
			}
		}
	}
}

simulated function ShowTeamScorePassC(Canvas C)
{
    local float RadarWidth, CenterRadarPosX, CenterRadarPosY;

    if (Level.bShowRadarMap && !bMapDisabled)
    {
        RadarWidth = 0.5 * RadarScale * HUDScale * C.ClipX;
        CenterRadarPosX = (RadarPosX * C.ClipX) - RadarWidth;
        CenterRadarPosY = (RadarPosY * C.ClipY) + RadarWidth;
        DrawRadarMap(C, CenterRadarPosX, CenterRadarPosY, RadarWidth, false);
    }
}

simulated function DrawNodeLabel(Canvas C, vector HUDLocation, float IconScaling, float HUDScaling, Color LabelColor, int Num)
{
	local float LabelIconSize;
	local int TensPlace,row,col;
	local float x,y;

	if ( C == None || Num >= 100)
		return;

	LabelIconSize = IconScaling * 16 * C.ClipX * HUDScaling/1600;
    C.DrawColor = WhiteColor;

	if (Num > 9)
    {
        TensPlace = Num / 10;
        Num = Num - (TensPlace * 10);

		X = HUDLocation.X - (1.5 * LabelIconSize * 1.5);
		Y = HUDLocation.Y - LabelIconSize * 1.5;
		C.SetDrawColor(0,0,0,255);
		for (Row=-1;Row<2;Row++)
		{
			for (Col=-1;Col<2;Col++)
			{
		        C.SetPos(X+Col,Y+Row );
		        C.DrawTile(DigitsBig.DigitTexture, LabelIconSize, LabelIconSize, DigitsBig.TextureCoords[TensPlace].X1, DigitsBig.TextureCoords[TensPlace].Y1, DigitsBig.TextureCoords[0].X2, DigitsBig.TextureCoords[0].Y2);
		    }
		}

		C.SetDrawColor(255,255,0,255);
        C.SetPos(X,Y);
        C.DrawTile(DigitsBig.DigitTexture, LabelIconSize, LabelIconSize, DigitsBig.TextureCoords[TensPlace].X1, DigitsBig.TextureCoords[TensPlace].Y1, DigitsBig.TextureCoords[0].X2, DigitsBig.TextureCoords[0].Y2);
    }

	X = HUDLocation.X - LabelIconSize * 1.5;
	Y = HUDLocation.Y - LabelIconSize * 1.5;

	C.SetDrawColor(0,0,0,255);
	for (Row=-1;Row<2;Row++)
	{
		for (Col=-1;Col<2;Col++)
		{
		    C.SetPos(x+Col,y+Row);
		    C.DrawTile(DigitsBig.DigitTexture, LabelIconSize, LabelIconSize, DigitsBig.TextureCoords[Num].X1, DigitsBig.TextureCoords[Num].Y1, DigitsBig.TextureCoords[0].X2, DigitsBig.TextureCoords[0].Y2);
		}
	}
	C.SetDrawColor(255,255,0,255);
    C.SetPos(x,y);
    C.DrawTile(DigitsBig.DigitTexture, LabelIconSize, LabelIconSize, DigitsBig.TextureCoords[Num].X1, DigitsBig.TextureCoords[Num].Y1, DigitsBig.TextureCoords[0].X2, DigitsBig.TextureCoords[0].Y2);

}

simulated function DrawHealthBar(Canvas C, Actor A, int Health, int MaxHealth, float Height)
{
	local vector		CameraLocation, CamDir, TargetLocation, HBScreenPos;
	local rotator		CameraRotation;
	local float			Dist, HealthPct;
	local color         OldDrawColor;

	// rjp --  don't draw the health bar if menus are open
	if ( PlayerOwner.Player.GUIController.bActive )
		return;

	OldDrawColor = C.DrawColor;

	C.GetCameraLocation( CameraLocation, CameraRotation );
	TargetLocation = A.Location + vect(0,0,1) * Height;
	Dist = VSize(TargetLocation - CameraLocation);

	// Check Distance Threshold
	if (Dist > HealthBarViewDist)
		return;

	CamDir	= vector(CameraRotation);

	// Target is located behind camera
	HBScreenPos = C.WorldToScreen(TargetLocation);
	if ((TargetLocation - CameraLocation) dot CamDir < 0 || HBScreenPos.X <= 0 || HBScreenPos.X >= C.SizeX || HBScreenPos.Y <= 0 || HBScreenPos.Y >= C.SizeY)
	{
		TargetLocation = A.Location + vect(0,0,1) * A.CollisionHeight;
		if ((TargetLocation - CameraLocation) dot CamDir < 0)
			return;
		HBScreenPos = C.WorldToScreen(TargetLocation);
		if (HBScreenPos.X <= 0 || HBScreenPos.X >= C.ClipX || HBScreenPos.Y <= 0 || HBScreenPos.Y >= C.ClipY)
			return;
	}

	if (FastTrace(TargetLocation, CameraLocation))
	{
	    	C.DrawColor = WhiteColor;

	    	C.SetPos(HBScreenPos.X - HealthBarWidth * 0.5, HBScreenPos.Y);
	    	C.DrawTileStretched(HealthBarBackMat, HealthBarWidth, HealthBarHeight);

	    	HealthPct = 1.0f * Health / MaxHealth;

	    	if (HealthPct < 0.35)
	    	   C.DrawColor = RedColor;
	    	else if (HealthPct < 0.70)
	    	   C.DrawColor = GoldColor;
	    	else
	    	   C.DrawColor = GreenColor;

	    	C.SetPos(HBScreenPos.X - HealthBarWidth * 0.5, HBScreenPos.Y);
	    	C.DrawTileStretched(HealthBarMat, HealthBarWidth * HealthPct, HealthBarHeight);
	}

	C.DrawColor = OldDrawColor;
}

simulated function Timer()
{
	local ONSPowerCore C;

	if (PlayerOwner.Pawn != None && OwnerPRI != None && OwnerPRI.Team != None)
	{
		C = OwnerPRI.GetCurrentNode();
		if (C != None)
			PlayerOwner.ReceiveLocalizedMessage(class'ONSOnslaughtMessage', 22);
	}
}

simulated function Tick(float deltaTime)
{
    local ONSPowerCore Core;

	Super(HUDCDeathMatch).Tick(deltaTime);

	if (Links >0)
	{
		TeamLinked = true;
	}
	else
	{
		TeamLinked = false;
	}

	if ( OwnerPRI == None && PawnOwnerPRI != None )
		OwnerPRI = ONSPlayerReplicationInfo(PawnOwnerPRI);

	if (FinalCore[0].DefenderTeamIndex != 0)
	{
    	foreach AllActors( class'ONSPowerCore', Core )
    		if ( Core.bFinalCore && (Core.DefenderTeamIndex < 2) )
    			FinalCore[Core.DefenderTeamIndex] = Core;
    }

	if ( !bReceivedLinks && OwnerPRI != None )
	{
		ClearLinks();
		RequestPowerLinks();
	}

	ColorPercent = 0.5f + Cos((Level.TimeSeconds * 4.0) * 3.14159 * 0.5f) * 0.5f;
}

simulated function RequestPowerLinks()
{
	if ( OwnerPRI != None )
	{
		OwnerPRI.OnReceiveLink = ReceiveLink;
		OwnerPRI.OnRemoveLink = RemoveLink;
		OwnerPRI.ResetLinks = ResetLinks;
		OwnerPRI.ServerSendPowerLinks();
		bReceivedLinks = true;
	}
}

exec function ToggleRadarMap()
{
	bMapDisabled = !bMapDisabled;
}

//exec function ZoomInRadarMap()
//{
//    RadarRange = Max(RadarRange - (RadarMaxRange * 0.1), 3000.0);
//}
//
//exec function ZoomOutRadarMap()
//{
//    RadarRange = Min(RadarRange + (RadarMaxRange * 0.1), RadarMaxRange);
//}

exec function LinkDesigner()
{
    if (OwnerPRI != None)
		OwnerPRI.RequestLinkDesigner();
}

exec function CopyLinkSetup()
{
	local ONSPowerLinkOfficialSetup S;
	local ONSOnslaughtGame.PowerLinkSetup BlankSetup;
	local ONSPowerCore O;
	local int x, y;

	S = spawn(class'ONSPowerLinkOfficialSetup');
	foreach DynamicActors(class'ONSPowerCore', O)
	{
		S.LinkSetups[x] = BlankSetup;
		S.LinkSetups[x].BaseNode = O.Name;
		for (y = 0; y < O.PowerLinks.length; y++)
			S.LinkSetups[x].LinkedNodes[y] = O.PowerLinks[y].Name;
		x++;
	}

	CopyObjectToClipboard(S);
	S.Destroy();

	PlayerOwner.ClientMessage("Link setup copied to clipboard");
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'HudContent.Generic.NoEntry');
    Level.AddPrecacheMaterial(Material'HudContent.Generic.HUD');
    Level.AddPrecacheMaterial(Material'InterfaceContent.BorderBoxD');
    Level.AddPrecacheMaterial(Material'ONSInterface-TX.HealthBar');
    Level.AddPrecacheMaterial(Material'ONSInterface-TX.MapBorderTex');
    Level.AddPrecacheMaterial(Material'ONSInterface-TX.NewHUDicons');
    Level.AddPrecacheMaterial(Material'ONSInterface-TX.CurrentPlayerIcon');

	Super(HudCTeamDeathMatch).UpdatePrecacheMaterials();
}

simulated static function bool CoreWorldToScreen( ONSPowerCore Core, out vector ScreenPos, float ScreenX, float ScreenY, float RadarWidth, float Range, vector Center, optional bool bIgnoreRange )
{
	local vector ScreenLocation;
	local float Dist;

	if ( Core == None )
		return false;

    ScreenLocation = Core.Location - Center;
    ScreenLocation.Z = 0;
	Dist = VSize(ScreenLocation);
	if ( bIgnoreRange || (Dist < (Range * 0.95)) )
	{
        ScreenPos.X = ScreenX + ScreenLocation.X * (RadarWidth/Range);
        ScreenPos.Y = ScreenY + ScreenLocation.Y * (RadarWidth/Range);
        ScreenPos.Z = 0;
        return true;
    }

    return false;
}

simulated static function DrawMapImage( Canvas C, Material Image, float MapX, float MapY, float PlayerX, float PlayerY, vector Dimensions )
{
	local float MapScale, MapSize;
	local byte  SavedAlpha;

	/*
	Dimensions.X = Width
	Dimensions.Y = Range
	Dimensions.Z = Alpha

	*/

	if ( Image == None || C == None )
		return;

	MapSize = Image.MaterialUSize();
	MapScale = MapSize / (Dimensions.Y * 2);

	SavedAlpha = C.DrawColor.A;

	C.DrawColor = default.WhiteColor;
	C.DrawColor.A = Dimensions.Z;

	C.SetPos( MapX - Dimensions.X, MapY - Dimensions.X );
	C.DrawTile( Image, Dimensions.X * 2.0, Dimensions.X * 2.0,
	           (PlayerX - Dimensions.Y) * MapScale + MapSize / 2.0,
			   (PlayerY - Dimensions.Y) * MapScale + MapSize / 2.0,
			   Dimensions.Y * 2 * MapScale, Dimensions.Y * 2 * MapScale );

	C.DrawColor.A = SavedAlpha;
}

simulated static function DrawAttackIcon( Canvas C, ONSPowerCore CurCore, vector HUDLocation, float IconScaling, float HUDScaling, float ColorPercentage )
{
	local float AttackIconSize, CoreIconSize;
	local color HoldColor;

	if ( C == None )
		return;

    if (CurCore.bFinalCore)
	   CoreIconSize = 2.0 * IconScaling * 16 * C.ClipX * HUDScaling/1600;
	else
	   CoreIconSize = IconScaling * 16 * C.ClipX * HUDScaling/1600;

    AttackIconSize = CoreIconSize * (2.5 + 1.5 * ColorPercentage);

    HoldColor = C.DrawColor;

    if (CurCore.bSevered && CurCore.CoreStage == 0)
        C.DrawColor = default.SeveredColorA * ColorPercentage + default.SeveredColorB * (1.0 - ColorPercentage);
    else
        C.DrawColor = default.AttackColorA * ColorPercentage + default.AttackColorB * (1.0 - ColorPercentage);

    C.SetPos(HUDLocation.X - AttackIconSize * 0.5, HUDLocation.Y - AttackIconSize * 0.5);
    C.DrawTile(Material'NewHUDIcons', AttackIconSize, AttackIconSize, 0, 64, 64, 64);
    C.DrawColor = HoldColor;
}

simulated static function DrawCoreIcon( Canvas C, vector HUDLocation, bool bAttackable, float IconScaling, float HUDScaling, float ColorPercentage )
{
	local float CoreIconSize;
//	local color HoldColor;

	if ( C == None )
		return;

	CoreIconSize = IconScaling * 16 * C.ClipX * HUDScaling/1600;
    C.SetPos(HUDLocation.X - CoreIconSize * 3.0 * 0.5, HUDLocation.Y - CoreIconSize * 3.0 * 0.5);

//    HoldColor = C.DrawColor;

    if (bAttackable)
        C.DrawColor = C.DrawColor * ColorPercentage + (C.DrawColor * 0.5) * (1.0 - ColorPercentage);

    C.DrawTile(Material'NewHUDIcons', CoreIconSize * 3.0, CoreIconSize * 3.0, 64, 0, 64, 64);
//    C.DrawColor = HoldColor;
}

simulated static function DrawNodeIcon( Canvas C, vector HUDLocation, bool bAttackable, byte Stage, float IconScaling, float HUDScaling, float ColorPercentage )
{
	local float CoreIconSize;

	if ( C == None )
		return;

	CoreIconSize = IconScaling * 16 * C.ClipX * HUDScaling/1600;
    if (Stage == 4 || Stage == 1)
    {
        if (bAttackable)
        {
            C.SetPos(HUDLocation.X - CoreIconSize * 0.75 * 0.5, HUDLocation.Y - CoreIconSize * 0.75 * 0.5);
            C.DrawTile(Material'NewHUDIcons', CoreIconSize * 0.75, CoreIconSize * 0.75, 0, 0, 32, 32);
        }
        else
        {
            C.SetPos(HUDLocation.X - CoreIconSize * 1.75 * 0.5, HUDLocation.Y - CoreIconSize * 1.75 * 0.5);
            C.DrawTile(Material'NewHUDIcons', CoreIconSize * 1.75, CoreIconSize * 1.75, 0, 32, 32, 32);
        }
    }
    else
	{
		if ( Stage != 0 )
			C.DrawColor = C.DrawColor * ColorPercentage + default.LinkColor[2] * (1.0 - ColorPercentage);

		if (bAttackable)
	    {
	        C.SetPos(HUDLocation.X - CoreIconSize * 2.0 * 0.5, HUDLocation.Y - CoreIconSize * 2.0 * 0.5);
	        C.DrawTile(Material'NewHUDIcons', CoreIconSize * 2.0, CoreIconSize * 2.0, 32, 0, 32, 32);
	    }
	    else
	    {
	        C.SetPos(HUDLocation.X - CoreIconSize * 1.75 * 0.5, HUDLocation.Y - CoreIconSize * 1.75 * 0.5);
	        C.DrawTile(Material'NewHUDIcons', CoreIconSize * 1.75, CoreIconSize * 1.75, 0, 32, 32, 32);
	    }
	}
}

simulated static function DrawSpawnIcon( Canvas C, vector HUDLocation, bool bFinalCore, float IconScaling, float HUDScaling )
{
	local float CoreIconSize;

	if ( C == None )
		return;

	CoreIconSize = IconScaling * 16 * C.ClipX * HUDScaling/1600;
    C.DrawColor.B = 0;
    C.DrawColor.G = 200;
    C.DrawColor.R = 0;
    C.DrawColor.A = 255;

    if (bFinalCore)
    {
        C.SetPos(HUDLocation.X - CoreIconSize * 5.5 * 0.5, HUDLocation.Y - CoreIconSize * 5.5 * 0.5);
        C.DrawTile(Material'NewHUDIcons', CoreIconSize * 5.5, CoreIconSize * 5.5, 64, 64, 64, 64);
    }
    else
    {
        C.SetPos(HUDLocation.X - CoreIconSize * 4.5 * 0.5, HUDLocation.Y - CoreIconSize * 4.5 * 0.5);
        C.DrawTile(Material'NewHUDIcons', CoreIconSize * 4.5, CoreIconSize * 4.5, 64, 64, 64, 64);
    }
}

simulated static function DrawSelectionIcon( Canvas C, vector HUDLocation, color IconColor, float IconScaling, float HUDScaling )
{
	local float CoreIconSize;

	if ( C == None )
		return;

	CoreIconSize = IconScaling * 16 * C.ClipX * HUDScaling/1600;

	C.DrawColor = IconColor;
	C.SetPos( HUDLocation.X - CoreIconSize * 1.5, HUDLocation.Y - CoreIconSize * 1.5);
	C.DrawTile( Material'NewHUDIcons', CoreIconSize * 3, CoreIconSize * 3, 32, 32, 32, 32 );
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
