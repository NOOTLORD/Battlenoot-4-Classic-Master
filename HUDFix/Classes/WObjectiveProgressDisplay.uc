class WObjectiveProgressDisplay extends ObjectiveProgressDisplay
	config;

/* if bGetBoxSize is true, function calculates the size needed for the objective list box
	Otherwise it draws the objective list... */
simulated function vector DrawObjectives( Canvas C, vector BoxPivot, bool bDefender, bool bGetBoxSize )
{
	local int		i, priority, startpriority, endpriority;
	local bool		bDrawObjectiveNumber;
	local float		XL, YL, XUnit, YOffset;
	local vector	ScreenPos, newBoxSize;
	local string	entry;

	StartPriority	= 0;
	EndPriority		= ASHUD.ASGRI.MaxObjectivePriority;

	if ( !bGetBoxSize )
	{
		C.Font = class'UT2MidGameFont'.static.GetMidGameFont( C.ClipY * ASHUD.HUDScale );
		C.StrLen("0", XL, YL);
		
		XUnit	= XL;
		YOffset	= BoxPivot.Y + YL*0.5;
	}

	for ( priority=StartPriority; priority<=EndPriority; priority++)
	{
		bDrawObjectiveNumber	= true;

		// First pass, primary objectives
		for (i=0; i<ASHUD.OBJ.Length; i++)
		{
			if ( (ASHUD.OBJ[i].ObjectivePriority != priority) || ASHUD.OBJ[i].bOptionalObjective )
				continue;

			if ( ASHUD.ObjectiveProgress == priority )
				C.Font = class'UT2MidGameFont'.static.GetMidGameFont( C.ClipX * 0.75 * ASHUD.HUDScale );
			else
				C.Font = class'UT2MidGameFont'.static.GetMidGameFont( C.ClipX * 0.67 * ASHUD.HUDScale );

			entry = CheckEntry( C, GetObjectiveDescription(ASHUD.OBJ[i], bDefender) );

			if ( bGetBoxSize )
			{
				C.StrLen( entry, XL, YL);
				newBoxSize.X	 = FMax( newBoxSize.X, XL );
				newBoxSize.Y	+= YL;
			}
			else
			{
				C.StrLen("0", XL, YL);

				SetObjectiveColor( C, ASHUD.OBJ[i] );

				C.SetPos( BoxPivot.X + XUnit*4, YOffset );
				C.DrawText( entry );

				if ( ASHUD.OBJ[i].IsCritical() && ASHUD.ObjectiveProgress == priority )
				{
					C.DrawColor = ASHUD.WhiteColor;
					ScreenPos.X = BoxPivot.X + XUnit + XL*0.5;
					ScreenPos.Y = YOffset + YL*0.33;
					ASHUD.DrawCriticalObjectiveOverlay( C, ScreenPos, 0.45 );
				}
				else if ( bDrawObjectiveNumber )	// Objective number
				{
					C.SetPos( BoxPivot.X + XUnit, YOffset );
					C.DrawText( string(priority+1) );

					C.SetPos( BoxPivot.X + XUnit*3, YOffset );
					C.DrawText(PrimaryObjectivePrefix);
				}

				YOffset += YL;
				bDrawObjectiveNumber = false;
			}

			// Display only one objective if not currently relevant
			if ( ASHUD.ObjectiveProgress != priority )
				break;
		}

		// Second pass for Optional Objectives (only shown for relevant objectives)
		if ( ASHUD.ObjectiveProgress == priority )
		{
			C.Font = class'UT2MidGameFont'.static.GetMidGameFont( C.ClipX * 0.67 * ASHUD.HUDScale );
			for (i=0; i<ASHUD.OBJ.Length; i++)
			{
				if ( (ASHUD.OBJ[i].ObjectivePriority > priority) || !ASHUD.OBJ[i].bOptionalObjective )
					continue;

				// Only show non active optional objectives for current priority
				// this way we can still show optional objectives of different priority
				if ( !ASHUD.OBJ[i].IsActive() && ASHUD.OBJ[i].ObjectivePriority != priority )
					continue;

				entry = CheckEntry( C, GetObjectiveDescription(ASHUD.OBJ[i], bDefender) );
				if ( bGetBoxSize )
				{
					C.StrLen( entry, XL, YL);
					newBoxSize.X	 = FMax( newBoxSize.X, XL );
					newBoxSize.Y	+= YL;
				}
				else
				{
					SetObjectiveColor( C, ASHUD.OBJ[i] );
					C.StrLen("0", XL, YL);

					C.SetPos( BoxPivot.X + XUnit*5, YOffset );
					C.DrawText( entry );
					
					if ( ASHUD.OBJ[i].IsCritical() )
					{
						C.DrawColor = ASHUD.WhiteColor;
						ScreenPos.X = BoxPivot.X + XUnit*3 + XL*0.5;
						ScreenPos.Y = YOffset + YL*0.33;
						ASHUD.DrawCriticalObjectiveOverlay( C, ScreenPos, 0.3 );
					}
					else
					{
						C.SetPos( BoxPivot.X + XUnit*4, YOffset );
						C.DrawText( OptionalObjectivePrefix );
					}
					
					YOffset += YL;
				}
			}
		}
	}

	if ( bGetBoxSize )
	{
		// Check in case Header is larger than objectives info...
		C.Font = class'UT2MidGameFont'.static.GetMidGameFont( C.ClipX*0.75 * ASHUD.HUDScale );
		C.StrLen( HeaderText, XL, YL);
		newBoxSize.X = FMax( newBoxSize.X, XL );

		// Expand borders
		C.StrLen("0", XL, YL);
		XUnit = XL;
		newBoxSize.X	+= XUnit * 5;
		newBoxSize.Y	+= YL;

		return newBoxSize;
	}

	return vect(0,0,0);
}

simulated function DrawBigCurrentObjective( Canvas C, bool bDefender, bool bCheckOverlap )
{
	local float		XL, YL, XL2, YL2, XO, YO;
	local String	CurrentObjectiveString;
	local vector	ScreenPos;
	local byte		bProgressPulsing;
	local int		PrimaryObjectiveCount;

	if ( ASHUD.CurrentObjective == None )
		return;

	C.Font	= ASHUD.GetFontSizeIndex( C, 0 );
	C.Style = ERenderStyle.STY_Alpha;

	if ( bDefender )
		CurrentObjectiveString = ASHUD.CurrentObjective.Objective_Info_Defender;
	else
		CurrentObjectiveString = ASHUD.CurrentObjective.Objective_Info_Attacker;

	if ( CurrentObjectiveString != "" )
	{
		PrimaryObjectiveCount = GetPrimaryObjectiveCount();
		if ( PrimaryObjectiveCount > 1 )
			CurrentObjectiveString = CurrentObjectiveString @ ObjTimesString $ PrimaryObjectiveCount;
		
		C.StrLen( CurrentObjectiveString, XL, YL );
		if ( XL > C.ClipX*0.33 * ASHUD.HUDScale )
		{
			C.Font	= ASHUD.GetFontSizeIndex( C, -1 );
			C.StrLen( CurrentObjectiveString, XL, YL );
			if ( XL > C.ClipX*0.33 * ASHUD.HUDScale )
			{
				C.Font	= ASHUD.GetFontSizeIndex( C, -2 );
				C.StrLen( CurrentObjectiveString, XL, YL );
				if ( XL > C.ClipX*0.33 * ASHUD.HUDScale )
				{
					C.Font	= ASHUD.GetFontSizeIndex( C, -3 );
					C.StrLen( CurrentObjectiveString, XL, YL );
				}
			}
		}

		XL2	= XL + 64 * ASHUD.ResScaleY;
		YL2	= YL +  8 * ASHUD.ResScaleY;
		XO = C.ClipX * 0.5;
		YO = YL*0.5 + 10 * ASHUD.ResScaleY;

		// Draw only if not overlapping
		//if ( bCheckOverlap && XO + XL*0.5 > BoxPivot.X )
		//	return;

		// Draw background
		C.DrawColor = C.MakeColor(0, 0, 0, 150);
		C.SetPos( XO - XL2*0.5, YO - YL2*0.5 );
		C.DrawTile(Texture'HudContent.Generic.HUD', XL2, YL2, 168, 211, 166, 44);

		// draw current objective text
		C.DrawColor = ASHUD.GetObjectiveColor( ASHUD.CurrentObjective );
		if ( bCheckOverlap && XO + XL*0.5 > BoxPivot.X )
		{
			XO -= (XO + XL*0.5 - BoxPivot.X);
			C.DrawColor.A = 128;
		}
		C.SetPos( XO - XL*0.5, YO - YL*0.5 );
		C.DrawText( CurrentObjectiveString, false );

		// Draw Objective Type Icon Background
		ScreenPos.X = XO - XL*0.5 - 20*ASHUD.ResScaleX;
		ScreenPos.Y = YO;
		XL2 = 27*ASHUD.ResScaleY*ASHUD.HUDScale*0.60;
		YL2 = 27*ASHUD.ResScaleY*ASHUD.HUDScale*0.60;
		C.DrawColor = C.MakeColor(255, 255, 255, 255);
		C.SetPos( ScreenPos.X - XL2, ScreenPos.Y - YL2);
		C.DrawTile(Texture'HudContent.Generic.HUD', XL2*2, YL2*2, 119, 258, 54, 54);

		// Draw Current Objective Type Icon
		if ( ASHUD.CurrentObjective.ObjectiveTypeIcon != None )
		{
			C.DrawColor = ASHUD.GetObjectiveColor( ASHUD.CurrentObjective );
			XL2 = 32*ASHUD.ResScaleY*ASHUD.HUDScale*0.4;
			YL2 = 32*ASHUD.ResScaleY*ASHUD.HUDScale*0.4;
			C.SetPos( ScreenPos.X - XL2, ScreenPos.Y - YL2);
			C.DrawTile(ASHUD.CurrentObjective.ObjectiveTypeIcon, XL2*2, YL2*2, 0, 0, 64, 64);
		}

		// Draw Shield overlay (defenders)
		if ( bDefender )
		{
			C.DrawColor = ASHUD.GetObjectiveColor( ASHUD.CurrentObjective, bProgressPulsing );
			if ( AnyPrimaryObjectivesCritical() )
				C.DrawColor = ASHUD.GreenColor*ASHUD.fPulse + ASHUD.GoldColor*(1-ASHUD.fPulse);
			else
				C.DrawColor = ASHUD.GreenColor;

			if ( bProgressPulsing == 0 )
				C.DrawColor.A = (127 + 64 * ASHUD.fPulse);
			else
				C.DrawColor.A = 127;

			XL2 = ASHUD.ResScaleY*ASHUD.HUDScale*0.45;
			YL2 = ASHUD.ResScaleY*ASHUD.HUDScale*0.45;
			C.SetPos(ScreenPos.X - XL2 * 32, ScreenPos.Y - YL2 * 32);
			C.DrawTile( Texture'AS_FX_TX.HUD.OBJ_Status', 64*XL2, 64*YL2, 191.0, 191.0, 64, 64);
		}

		// objective progress status
		ASHUD.DrawObjectiveStatusOverlay( C, GetGlobalObjectiveProgress(), AnyPrimaryObjectivesCritical(), ScreenPos, 1.0f );
		ASHUD.DrawObjectiveStatusOverlay( C, GetGlobalObjectiveProgress(), AnyPrimaryObjectivesCritical(), ScreenPos, 1.1f );

		// display critical icon for any critical primary objective
		if ( AnyPrimaryObjectivesCritical() )	
		{
			C.DrawColor = ASHUD.WhiteColor;
			ASHUD.DrawCriticalObjectiveOverlay( C, ScreenPos, 1.f );
		}
	}
}

defaultproperties
{
}
