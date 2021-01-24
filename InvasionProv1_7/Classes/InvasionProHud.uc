// Modified by (NL)NOOTLORD

class InvasionProHud extends HudWTeamDeathMatch config(User);

#exec OBJLOAD FILE=2K4Menus.utx

var() float RadarPulse,RadarScale;
var() float LastDrawRadar;
var() float MinEnemyDist;
var() String MonsterScoretext;
var() float RadarSpecialOffsetX;
var() float RadarSpecialOffsetY;
var() config bool bHideRadar;
var() config bool bAddFriendlyMonstersToPlayerList;
var() config bool bDisplayBossTimer;
var() config bool bDisplayBossNames;
var() config Color MonsterColor;
var() config Color PlayerColor;
var() config Color RadarColor;
var() config Color OwnerColor;
var() config bool bDisplayMonsterCounter;
var() config bool bDisplayPlayerList;
var() config bool bDisplayNecroPool;
var() config bool bClassicRadar;
var() config bool bNoRadarSound;
var() config float RadarPosX, RadarPosY;
var() config Color PulseColor;
var() config bool bStartThirdPerson;
var() config bool bDisplayMonsterHealthBars;
var() config bool bSpecMonsters;
var() config array<string> MonsterKillSounds;
var() config string CurrentKillSound;
var() config string RadarSound;
var() Sound PulseSound;
var() config Material RadarImage;
var() config Material PulseImage;
var() config array<Material> RadarMaterials;
var() config array<Material> PulseMaterials;
var() config Material OwnerIcon;
var() config Material MonsterIcon;
var() config Material FriendlyPlayerIcon;
var() config Material FriendlyMonsterIcon;
var() config bool bDrawPetInfo;
var() float RadarRange;
var() float ClassicRadarRange;
var() Color MonsterCounterColor;
var() float Dotwidth;
var() float DotHeight;
var() float DotUCoordinate;
var() float DotVCoordinate;
var() float DotULWidth;
var() float DotVLHeight;
var() bool bMeshesLoaded;
var() bool bLoadingStarted;
var() Font MonsterCounterFont;
var() Color LoadingContainerColor;
var() Color OrangeColor;
var() Color MonsterNumColor;
var() Color NecroAlertColor;
var() Color BossNameColor;
var() Material LoadingContainerImage;
var() Material LoadingContainerCompanionImage;
var() Material LoadingBarImage;
var() Material NecroImage; //group adren
var() Material NecroWorldImage;
var() Material NecroBackground;
var() Material MonsterNumImage;
var() Material NecroAlertImage;
var() float LoadingBarSizeX;
var() float LoadingBarSpread;
var() Font LoadingFont;
var() Font NecroFont;
var() Font PlayerFont;
var() SpriteWidget MonsterCountBackground;
var() SpriteWidget MonsterCountBackgroundDisc;
var() SpriteWidget MonsterCountImage;
var() NumericWidget MonsterCount;
var() SpriteWidget NecroCountBackground;
var() SpriteWidget NecroCountBackgroundDisc;
var() SpriteWidget NecroAlert;
var() SpriteWidget NecroAdrenaline;
var() SpriteWidget NecroSlash;
var() NumericWidget NecroCount;
var() NumericWidget NecroCountMax;
var() NumericWidget BossTime;
var() SpriteWidget PlayerBackground;
var() float PlayerBackgroundSpacer;
var() float PlayerBackgroundAbsoluteY;
var() int PlayerFontScale;
var() float PlayerNameSpacer;
var() float PlayerFontYSize;
var() float PlayerFontXSize;
var() float PlayerListPosY;
var() float PlayerListSpacerY;
var() bool bDrawLoading;
var() SpriteWidget BossBarBackground;
var() material BossImage;
var() float TestX;
var() float TestY;
var() float TestX2;
var() float TestY2;
var() String PreloadingText;
var() vector BehindViewCrosshairLocation;
var() float BehindViewCrosshairSize;
var() Color TestColor;
var() Color FriendlyMonsterNameColor;
var() Color HostileMonsterNameColor;
var() float MonsterNameOffset;
var() ERenderStyle TestStyle;
var() int MonsterNameFontScale;
var() float MonsterFontYSize;
var() float MonsterFontXSize;
var() int BossDrawPosition;
var() EDrawPivot TestPivot;
var() string AuraText[9]; //0=none, 1=heal, 2=damage, 3=defense 4=pet 5=frost 6=lightning 7=resurrect 8=retribution
var() color AuraTextColor;

function DrawEnemyName(Canvas C)
{}

function DrawCustomBeacon(Canvas C, Pawn P, float ScreenLocX, float ScreenLocY)
{
	//only way to turn off native beacon code for friendly monsters
	//is to empty this function and set bScriptPostRender=true in the monster class?
	return;
}

simulated function DrawMonsterHealth(Canvas C, Monster M, float Health, float HealthMax, InvasionProMonsterIDInv MonsterInv)
{
	local Vector DrawLocation;
 	local Color FinalColor;
	local float HealthPercent;

	DrawLocation = C.WorldToScreen(M.Location+(vect(0,0,1)*(M.CollisionHeight+12)));
	if(DrawLocation.Z > 1.0 || M == None || MonsterInv == None || !FastTrace(PawnOwner.Location,M.Location))
	{
		return;
	}

	C.Reset();
	C.Style = ERenderStyle.STY_Normal;
	C.SetPos(DrawLocation.X - (M.CollisionRadius/2), DrawLocation.Y);

	FinalColor.R = 0;
	FinalColor.G = 0;
	FinalColor.B = 0;
	FinalColor.A = 255;

	if(bDisplayMonsterHealthBars && !MonsterInv.bBoss)
	{
		HealthPercent = 1.00f * ( Health/HealthMax );

		if(HealthPercent == 0.50)
		{
			FinalColor.R = 255;
			FinalColor.G = 255;
		}
		else if(HealthPercent > 0.50)
		{
			FinalColor.R = 255-(255*HealthPercent);
			FinalColor.G = 255;
		}
		else if(HealthPercent < 0.50)
		{
			FinalColor.R = 255;
			FinalColor.G = 255*HealthPercent;
		}

		C.DrawColor = FinalColor;
		C.DrawRect( Texture'Background_bevel01', 25, 5 );
	}

    if(MonsterInv.MonsterName != "") //this monster has a name and is game relevant so render the name
    {
		if(MonsterInv.bFriendly)
		{
			M.bScriptPostRender = true;
			if(bDrawPetInfo)
			{
				C.DrawColor = FriendlyMonsterNameColor;
				C.Font = class'UT2MidGameFont'.static.GetMidGameFont( C.ClipX*TestX * HUDScale );
				//draw aura
				if(MonsterInv.AuraID > 0)
				{
					C.DrawColor = AuraTextColor;
					C.SetPos(DrawLocation.X - (M.CollisionRadius/2), DrawLocation.Y - 12);
					C.DrawTextClipped(AuraText[MonsterInv.AuraID]);
					//draw name
					C.DrawColor = FriendlyMonsterNameColor;
					C.SetPos(DrawLocation.X - (M.CollisionRadius/2), DrawLocation.Y - 20);
					C.DrawTextClipped(MonsterInv.MonsterName);
				}
				else
				{
					C.DrawColor = FriendlyMonsterNameColor;
					C.SetPos(DrawLocation.X - (M.CollisionRadius/2), DrawLocation.Y - 12);
					C.DrawTextClipped(MonsterInv.MonsterName);
				}
			}
		}
		else
		{
			C.DrawColor = HostileMonsterNameColor;
			C.Font = class'UT2MidGameFont'.static.GetMidGameFont( C.ClipX*TestX * HUDScale );
			C.SetPos(DrawLocation.X - (M.CollisionRadius/2), DrawLocation.Y - 20);
			C.DrawTextClipped(MonsterInv.MonsterName);
		}
	}
}

function DisplayEnemyName(Canvas C, PlayerReplicationInfo PRI)
{
	if(PlayerOwner != None)
	{
  		PlayerOwner.ReceiveLocalizedMessage(class'PlayerNameMessage',0,PRI);
	}
}
//don't draw crosshair if in behindview and aerialview is active
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
    {
        return;

	}

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

	if(PlayerOwner != None && PlayerOwner.Pawn != None)
	{
		if(Vehicle(PlayerOwner.Pawn) == None && InvasionProGameReplicationInfo(PlayerOwner.GameReplicationInfo) != None && InvasionProGameReplicationInfo(PlayerOwner.GameReplicationInfo).bAerialView && PlayerOwner.bBehindView)
		{
			DrawBehindViewCrosshair(C, CHTexture.WidgetTexture,CurrentCrosshairColor);
			HudScale=OldScale;
			DrawEnemyName(C);
			return;
		}
	}

    DrawSpriteWidget (C, CHTexture);
    C.ColorModulate.W = OldW;
    HudScale=OldScale;
    CHTexture.TextureScale = NormalScale;

    //DrawEnemyName(C);
}

simulated function DrawBehindViewCrosshair( Canvas C , Material BehindViewTexture, Color BehindViewColour)
{
    local int XPos, YPos;
    local vector ScreenPos;
    local vector X,Y,Z,Dir;
    local float RatioX, RatioY;
    local float tileX, tileY;
    local float Dist;

    local float SizeX;
    local float SizeY;

    SizeX = BehindViewCrosshairSize * 96.0;
    SizeY = BehindViewCrosshairSize * 96.0;


    ScreenPos = C.WorldToScreen( BehindViewCrosshairLocation );

    RatioX = C.SizeX / 640.0;
    RatioY = C.SizeY / 480.0;

    tileX = sizeX * RatioX;
    tileY = sizeY * RatioX;

    GetAxes(PlayerOwner.Rotation, X,Y,Z);
    Dir = BehindViewCrosshairLocation - PawnOwner.Location;
    Dist = VSize(Dir);
    Dir = Dir/Dist;

    if ( (Dir Dot X) > 0.6 ) // don't draw if it's behind the eye
    {
        XPos = ScreenPos.X;
        YPos = ScreenPos.Y;
        C.Style = ERenderStyle.STY_Additive;
        C.DrawColor = BehindViewColour;
        C.SetPos(XPos - tileX*0.5, YPos - tileY*0.5);
        if(BehindViewTexture != None)
        {
        	C.DrawTile( BehindViewTexture, tileX, tileY, 0, 0, 64, 64);
		}
    }
}

simulated function ShowTeamScorePassA(Canvas C)
{
	local float RadarWidth, PulseWidth, PulseBrightness;

	if(PawnOwner == None || InvasionProXPlayer(PlayerOwner) == None || InvasionProGameReplicationInfo(PlayerOwner.GameReplicationInfo).bHideRadar || bHideRadar)
	{
		return;
	}

	if(bClassicRadar)
	{
		PulseBrightness = FMax(0,(1 - 2*RadarPulse) * 255.0);
		RadarRange = ClassicRadarRange;

		RadarScale = Default.RadarScale * HUDScale;
		RadarWidth = 0.5 * RadarScale * C.ClipX;
		PulseWidth = RadarScale * C.ClipX;
		C.DrawColor = RedColor;
		C.Style = ERenderStyle.STY_Translucent;

		C.DrawColor.R = PulseBrightness;
		C.SetPos(RadarPosX*C.ClipX - 0.5*PulseWidth,RadarPosY*C.ClipY+RadarWidth-0.5*PulseWidth);
		C.DrawTile( Material'InterfaceContent.SkinA', PulseWidth, PulseWidth, 0, 880, 142, 142);

		PulseWidth = RadarPulse * RadarScale * C.ClipX;
		C.DrawColor = RedColor;
		C.SetPos(RadarPosX*C.ClipX - 0.5*PulseWidth,RadarPosY*C.ClipY+RadarWidth-0.5*PulseWidth);
		C.DrawTile( Material'InterfaceContent.SkinA', PulseWidth, PulseWidth, 0, 880, 142, 142);

		C.Style = ERenderStyle.STY_Alpha;
		C.DrawColor = GetTeamColor( PawnOwner.GetTeamNum() );
		C.SetPos(RadarPosX*C.ClipX - RadarWidth,RadarPosY*C.ClipY+RadarWidth);
		C.DrawTile( Material'AS_FX_TX.AssaultRadar', RadarWidth, RadarWidth, 0, 512, 512, -512);
		C.SetPos(RadarPosX*C.ClipX,RadarPosY*C.ClipY+RadarWidth);
		C.DrawTile( Material'AS_FX_TX.AssaultRadar', RadarWidth, RadarWidth, 512, 512, -512, -512);
		C.SetPos(RadarPosX*C.ClipX - RadarWidth,RadarPosY*C.ClipY);
		C.DrawTile( Material'AS_FX_TX.AssaultRadar', RadarWidth, RadarWidth, 0, 0, 512, 512);
		C.SetPos(RadarPosX*C.ClipX,RadarPosY*C.ClipY);
		C.DrawTile( Material'AS_FX_TX.AssaultRadar', RadarWidth, RadarWidth, 512, 0, -512, 512);
	}
	else
	{
		RadarRange = default.RadarRange;
		RadarScale = Default.RadarScale * HUDScale;
		RadarWidth = 0.75 * RadarScale * C.ClipX;

		C.Reset();

		C.Style = ERenderStyle.STY_Alpha;

		if(PulseImage != None)
		{
			C.DrawColor = PulseColor;
			C.SetPos(RadarPosX * C.ClipX - (0.625 * RadarWidth),RadarPosY * C.ClipY - (-0.05 * RadarWidth));
			C.DrawTile( PulseImage, RadarWidth * 1.25, RadarWidth * 1.25, 2, 2, 512, 512);
		}

		if(RadarImage != None)
		{
			C.DrawColor = RadarColor;
			C.SetPos(RadarPosX * C.ClipX - (0.5 * RadarWidth),RadarPosY * C.ClipY - (-0.175 * RadarWidth));
			C.DrawTile( RadarImage, RadarWidth, RadarWidth, 2, 2, 512, 512);
		}
	}
}

simulated function ShowTeamScorePassC(Canvas C)
{
    local Pawn P;
    local float Dist, MaxDist, RadarWidth, Angle, DotSize, OffsetY, PulseBrightness, OffsetScale;
    local rotator Dir;
    local vector Start;
    local Material DrawMaterial;
	local InvasionProMonsterIDInv Inv;

    LastDrawRadar = Level.TimeSeconds;
    RadarWidth = 0.5 * RadarScale * C.ClipX;
    DotSize = 10;
    if ( PawnOwner == None )
    {
        Start = PlayerOwner.Location;
	}
    else
    {
        Start = PawnOwner.Location;
	}

	if(InvasionProGameReplicationInfo(PlayerOwner.GameReplicationInfo) != None)
	{
		if(!InvasionProGameReplicationInfo(PlayerOwner.GameReplicationInfo).bHideNecroPool && InvasionProGameReplicationInfo(PlayerOwner.GameReplicationInfo).bTeamNecro && bDisplayNecroPool)
		{
			DrawNecroPool(C);
		}

		if(!InvasionProGameReplicationInfo(PlayerOwner.GameReplicationInfo).bHideMonsterCount && bDisplayMonsterCounter)
		{
			DrawMonsterCount(C);
		}

		if(!bMeshesLoaded && bDrawLoading)
		{
			DrawLoading(C);
		}

		if(!InvasionProGameReplicationInfo(PlayerOwner.GameReplicationInfo).bHidePlayerList && bDisplayPlayerList && Monster(PawnOwner) == None)
		{
			DrawPlayerNames(C);
		}

		if(InvasionProGameReplicationInfo(PlayerOwner.GameReplicationInfo).bBossEncounter && bDisplayBossTimer)
		{
			DrawBossTime(C);
		}

		if(bDisplayBossNames && InvasionProGameReplicationInfo(PlayerOwner.GameReplicationInfo).bBossEncounter)
		{
			BossDrawPosition = 1;
			DrawBossHealth(C);
		}

		if(InvasionProGameReplicationInfo(PlayerOwner.GameReplicationInfo).bHideRadar || bHideRadar)
		{
			return;
		}
	}

    MaxDist = 3000 * RadarPulse;
    OffsetY = RadarPosY + RadarWidth/C.ClipY;
    MinEnemyDist = 3000;

    ForEach DynamicActors(class'Pawn',P)
    {
        if ( P != None && P.Health > 0 )
        {
            Dist = VSize(Start - P.Location);
            if ( Dist < RadarRange )
            {
                if ( Dist < MaxDist )
                {
                    PulseBrightness = 255 - 255*Abs(Dist*0.00033 - RadarPulse);
				}
                else
                {
                    PulseBrightness = 255 - 255*Abs(Dist*0.00033 - RadarPulse - 5); //1
				}

				MinEnemyDist = FMin(MinEnemyDist, Dist);
				Dir = rotator(P.Location - Start);
				DrawMaterial = MonsterIcon;

				if(Monster(P) != None)
				{
					foreach DynamicActors(class'InvasionProMonsterIDInv',Inv)
					{
						if(Inv.MyMonster == Monster(P))
						{
							DrawMonsterHealth(C, Monster(P), Inv.MonsterHealth, Inv.MonsterHealthMax, Inv);
							if(Inv.bFriendly)
							{
								C.DrawColor = PlayerColor;
								DrawMaterial = FriendlyMonsterIcon;
							}
							else
							{
								C.DrawColor = MonsterColor;
							}

							break;
						}
					}
				}
				else if ( Vehicle(P) != None && Vehicle(P).Driver == None && !Vehicle(P).bDriving)
				{
					C.DrawColor.R = 125;
					C.DrawColor.G = 125;
					C.DrawColor.B = 125;
					Dir = rotator(P.Location - Start);
					DrawMaterial = FriendlyPlayerIcon;
				}
				else if ( P.IsA('DruidBlock') || P.IsA('DruidExplosive') )
				{
					//make blocks grey.
					C.DrawColor.R = 125;
					C.DrawColor.G = 125;
					C.DrawColor.B = 125;
					Dir = rotator(P.Location - Start);
					DrawMaterial = FriendlyPlayerIcon;
				}
				else if(PawnOwner == P)
				{
					C.DrawColor = OwnerColor;
					Dir = rotator(P.Location - Start);
					DrawMaterial = OwnerIcon;
				}
				else if(Vehicle(P) != None && Vehicle(P).Driver != None)
				{
					C.DrawColor = PlayerColor;
					Dir = rotator(P.Location - Start);
					DrawMaterial = FriendlyPlayerIcon;
				}
				else
				{
					C.DrawColor = PlayerColor;
					Dir = rotator(P.Location - Start);
					DrawMaterial = FriendlyPlayerIcon;
				}

				C.Style = ERenderStyle.STY_Translucent;
				C.DrawColor.A = PulseBrightness;
				OffsetScale = RadarScale*Dist*0.000167;
				Angle = ((Dir.Yaw - PlayerOwner.Rotation.Yaw) & 65535) * 6.2832/65536;
				C.SetPos(RadarPosX * C.ClipX + OffsetScale * C.ClipX * sin(Angle) - 0.5*DotSize,
				OffsetY * C.ClipY - OffsetScale * C.ClipX * cos(Angle) - 0.5*DotSize);
				if(DrawMaterial != None)
				{
					C.DrawTile(DrawMaterial,Dotwidth, DotHeight, DotUCoordinate, DotVCoordinate, DotULWidth, DotVLHeight);
				}
            }
        }
	}
}

simulated function DrawBossHealth(Canvas C)
{
	local InvasionProMonsterIDInv Inv;
 	local Color FinalColor;
	local float HealthMax, HealthPercent, DrawYPos;
	local int Health;

	foreach DynamicActors(class'InvasionProMonsterIDInv',Inv)
	{
		if(Inv.bBoss)
		{
			Health = Inv.MonsterHealth;
			HealthMax = Inv.MonsterHealthMax;
			HealthPercent = 1.00f * ( Health/HealthMax );

			if(HealthPercent == 0.50)
			{
				FinalColor.R = 255;
				FinalColor.G = 255;
			}
			else if(HealthPercent > 0.50)
			{
				FinalColor.R = 255-(255*HealthPercent);
				FinalColor.G = 255;
			}
			else if(HealthPercent < 0.50)
			{
				FinalColor.R = 255;
				FinalColor.G = 255*HealthPercent;
			}

			DrawYPos = 0.06 + (0.03 * BossDrawPosition);
			C.Reset();
			C.Style = ERenderStyle.STY_Normal;
			C.Font = GetFontSizeIndex(C, 1);
			C.FontScaleX = 0.4;
			C.FontScaleY = 0.4;
			FinalColor.A = 255;
			C.DrawColor = FinalColor;
			C.DrawScreenText (Inv.MonsterName@" ("@Health@"HP)", 0.5, DrawYPos , DP_UpperMiddle);
			BossDrawPosition++;
		}
	}
}

simulated function DrawBossTime(Canvas C)
{
	if(!InvasionProGameReplicationInfo(PlayerOwner.GameReplicationInfo).bInfiniteBossTime)
	{
		C.Reset();
		C.Style = ERenderStyle.STY_Normal;
		//draw time limit
		if(!InvasionProGameReplicationInfo(PlayerOwner.GameReplicationInfo).bOverTime )
		{
			BossTime.Value = InvasionProGameReplicationInfo(PlayerOwner.GameReplicationInfo).BossTimeLimit;
			DrawNumericWidget( C, BossTime, DigitsBig);
			C.Font = GetFontSizeIndex(C, 1);
			C.FontScaleX = 0.55;
			C.FontScaleY = 0.55;
			C.DrawColor = BossTime.Tints[0];
			C.DrawScreenText ("Boss Time Limit", 0.5, 0.001 , DP_UpperMiddle);
		}
		else
		{
			C.Font = GetFontSizeIndex(C, 1);
			C.FontScaleX = 1;
			C.FontScaleY = 1;
			C.DrawColor = BossTime.Tints[0];
			C.DrawScreenText ("Overtime", 0.5, 0.0275 , DP_UpperMiddle);
		}
	}
}

simulated function DrawPlayerNames(Canvas C)
{
	local int i, FramePos;
	local string PlayerName;
	local float DrawOffset;

	FramePos = 0;
	C.Reset();

	for(i=0;i<PlayerOwner.GameReplicationInfo.PRIArray.Length;i++)
	{
		if(PlayerOwner.GameReplicationInfo.PRIArray[i].StringUnknown != "Proxie")//dont draw proxies from chaos mod
		{
			//don't draw owners info
			if(PlayerOwner.GameReplicationInfo.PRIArray[i] != PlayerOwner.PlayerReplicationInfo && PlayerOwner.GameReplicationInfo.PRIArray[i].PlayerName != "WebAdmin")
			{
				if(InvasionProFakeFriendlyMonsterReplicationInfo(PlayerOwner.GameReplicationInfo.PRIArray[i]) == None || (bAddFriendlyMonstersToPlayerList && !InvasionProFakeFriendlyMonsterReplicationInfo(PlayerOwner.GameReplicationInfo.PRIArray[i]).bMinion) )
				{
					DrawOffset = HudScale * (PlayerListPosY + (PlayerListSpacerY * FramePos) );
					//draw tiles
					PlayerBackground.PosY = DrawOffset;
					DrawSpriteWidget( C, PlayerBackground);
					//draw names and health information
					PlayerName = PlayerOwner.GameReplicationInfo.PRIArray[i].PlayerName;
					//health color and amount
					//players/bots
					C.Font = class'UT2MidGameFont'.static.GetMidGameFont( C.ClipX*0.5 * HUDScale );
					C.DrawColor = WhiteColor;
					C.Style = ERenderStyle.STY_Alpha;
					if(InvasionProPlayerReplicationInfo(PlayerOwner.GameReplicationInfo.PRIArray[i]) != None)
					{
						PlayerName = Left(PlayerName, 18);

						C.DrawScreenText (PlayerName, HudScale * 0.005, DrawOffset + (HudScale * 0.02855), DP_UpperLeft);
						C.DrawColor = GetDrawColor( PlayerOwner.GameReplicationInfo.PRIArray[i] );
						C.DrawScreenText (string(InvasionProPlayerReplicationInfo(PlayerOwner.GameReplicationInfo.PRIArray[i]).PlayerHealth), HudScale * 0.14, DrawOffset + (HudScale * 0.02855), DP_UpperLeft);
					}
					else  if(InvasionProFakeFriendlyMonsterReplicationInfo(PlayerOwner.GameReplicationInfo.PRIArray[i]) != None)//Monster's version of info
					{
						PlayerName = Repl( PlayerName, "SMP", "", false);
						PlayerName = Left(PlayerName, 18);
						C.DrawScreenText (PlayerName, HudScale * 0.005, DrawOffset + (HudScale * 0.02855), DP_UpperLeft);
						C.DrawColor = GetMonsterDrawColor(PlayerOwner.GameReplicationInfo.PRIArray[i]);
						C.DrawScreenText (string(InvasionProFakeFriendlyMonsterReplicationInfo(PlayerOwner.GameReplicationInfo.PRIArray[i]).MonsterHealth), HudScale * 0.14, DrawOffset + (HudScale * 0.02855), DP_UpperLeft);
					}

					FramePos++;
				}
			}
		}
	}
}

simulated function Pawn GetMonsterPawn(PlayerReplicationInfo PRI)
{
	local Pawn P;

	ForEach DynamicActors(class'Pawn', P)
	{
		if ( P != None && P.PlayerReplicationInfo == PRI )
		{
			return P;
		}
	}

	return None;
}

simulated function color GetMonsterDrawColor(PlayerReplicationInfo PRI)
{
	local Color FinalColor;
	local float Health, HealthMax, HealthPercent;

	FinalColor.R = 0;
	FinalColor.G = 0;
	FinalColor.B = 0;
	FinalColor.A = 255;
	Health = InvasionProFakeFriendlyMonsterReplicationInfo(PRI).MonsterHealth;
	HealthMax = InvasionProFakeFriendlyMonsterReplicationInfo(PRI).MonsterHealthMax;
	HealthPercent = 1.00f * ( Health/HealthMax );

	if(HealthPercent == 0.50)
	{
		FinalColor.R = 255;
		FinalColor.G = 255;
	}
	else if(HealthPercent > 0.50)
	{
		FinalColor.R = 255-(255*HealthPercent);
		FinalColor.G = 255;
	}
	else if(HealthPercent < 0.50)
	{
		FinalColor.R = 255;
		FinalColor.G = 255*HealthPercent;
	}

	return FinalColor;
}

simulated function color GetDrawColor(PlayerReplicationInfo PRI)
{
	local Color FinalColor;
	local float Health, HealthMax, HealthPercent;

	FinalColor.R = 0;
	FinalColor.G = 0;
	FinalColor.B = 0;
	FinalColor.A = 255;
	Health = InvasionProPlayerReplicationInfo(PRI).PlayerHealth;
	HealthMax = InvasionProPlayerReplicationInfo(PRI).PlayerHealthMax;
	HealthPercent = 1.00f * ( Health/HealthMax );

	if(HealthPercent == 0.50)
	{
		FinalColor.R = 255;
		FinalColor.G = 255;
	}
	else if(HealthPercent > 0.50)
	{
		FinalColor.R = 255-(255*HealthPercent);
		FinalColor.G = 255;
	}
	else if(HealthPercent < 0.50)
	{
		FinalColor.R = 255;
		FinalColor.G = 255*HealthPercent;
	}

	return FinalColor;
}

simulated function DrawNecroPool(Canvas C)
{
	local string NecroInfo;

	//black background bar
	//black circle
	C.Reset();
	DrawSpriteWidget( C, NecroCountBackground);
	DrawSpriteWidget( C, NecroCountBackgroundDisc);
	//flashing alert
	if( InvasionProGameReplicationInfo(PlayerOwner.GameReplicationInfo).NecroName != "None" )
	{
		DrawSpriteWidget( C, NecroAlert);
	}

	PassStyle=STY_None;
	DrawSpriteWidget( C, NecroAdrenaline);
	PassStyle=STY_Alpha;

	//adrenaline text
	if( InvasionProGameReplicationInfo(PlayerOwner.GameReplicationInfo).NecroName != "None" )
	{
		NecroInfo = "Resurrecting: "$InvasionProGameReplicationInfo(PlayerOwner.GameReplicationInfo).NecroName;
		C.Font = class'UT2MidGameFont'.static.GetMidGameFont( C.ClipX*1 * HUDScale );
		C.Style = ERenderStyle.STY_Alpha;
		C.DrawColor = WhiteColor;
		C.DrawScreenText (NecroInfo, HudScale * 0.05, HudScale * 0.0785, DP_UpperLeft);
	}
	else
	{
		NecroCount.MinDigitCount = Max ( Len ( string(InvasionProGameReplicationInfo(PlayerOwner.GameReplicationInfo).TeamNecroPoolMax) ), 1 );
		NecroCount.Value = InvasionProGameReplicationInfo(PlayerOwner.GameReplicationInfo).TeamNecroPool;
		NecroCountMax.Value = InvasionProGameReplicationInfo(PlayerOwner.GameReplicationInfo).TeamNecroCost;
		NecroSlash.OffsetX = default.NecroSlash.OffsetX + (NecroCount.MinDigitCount * 40);
		NecroCountMax.OffsetX = default.NecroCountMax.OffsetX + (NecroCount.MinDigitCount * 40);
		DrawNumericWidget( C, NecroCount, DigitsBig);
		DrawNumericWidget( C, NecroCountMax, DigitsBig);
		DrawSpriteWidget( C, NecroSlash);
	}
}

simulated function DrawLoading(Canvas C)
{
	DrawLoadingContainer(C);
	DrawLoadingBar(C);

	if(!bLoadingStarted)
	{
		SetTimer(0.0175,true);
		bLoadingStarted = true;
	}
}

simulated function DrawLoadingContainer(Canvas C)
{
	C.Reset();
	C.Style = ERenderStyle.STY_Translucent;
	C.DrawColor = LoadingContainerColor;
	C.SetPos( 0.5 * C.ClipX - ((0.625 * C.ClipY)/2), 0.85 * C.ClipY );
	C.DrawTilePartialStretched(LoadingContainerImage, 0.625 * C.ClipY, 16 );
	C.DrawColor = WhiteColor;
	C.SetPos( 0.5 * C.ClipX - ((0.625 * C.ClipY)/2), 0.85 * C.ClipY );
	C.DrawTilePartialStretched(LoadingContainerCompanionImage, 0.625 * C.ClipY, 16 );
	C.DrawColor = WhiteColor;
	C.Font = GetFontSizeIndex(C, -4 + int(HudScale * 1.25));
	C.DrawScreenText (PreloadingText, 0.5, 0.9, DP_MiddleMiddle);
}

simulated function DrawLoadingBar(Canvas C)
{
	C.Reset();
	C.Style = ERenderStyle.STY_Normal;
	C.DrawColor = WhiteColor;
	C.SetPos( 0.5 * C.ClipX - ((LoadingBarSizeX * C.ClipY)/2), 0.85 * C.ClipY );
	C.DrawTilePartialStretched(LoadingBarImage, LoadingBarSizeX * C.ClipY, 15 );
}

simulated function Timer()
{
	Super.Timer();

	LoadingBarSpread = ( FClamp ( 0.625 / InvasionProGameReplicationInfo(PlayerOwner.GameReplicationInfo).NumMonstersToLoad, 0.001, 0.625 ) ) / 10;

	if(LoadingBarSizeX < 0.625)
	{
		LoadingBarSizeX = Fmin( LoadingBarSizeX + LoadingBarSpread ,0.625 );
	}
	else
	{
		SetTimer(0.0,false);
		bMeshesLoaded = true;
	}
}

simulated function DrawMonsterCount(Canvas C)
{
	DrawSpriteWidget( C, MonsterCountBackground);
	DrawSpriteWidget( C, MonsterCountBackgroundDisc);
	DrawSpriteWidget( C, MonsterCountImage);

	MonsterCount.Value = InvasionProGameReplicationInfo(PlayerOwner.GameReplicationInfo).CurrentMonstersNum;
	DrawNumericWidget( C, MonsterCount, DigitsBig);
}

simulated function Tick(float DeltaTime)
{
	if(InvasionProXPlayer(PlayerOwner) != None)
	{
		InvasionProXPlayer(PlayerOwner).SetSpecMonsters(bSpecMonsters);
	}

    Super.Tick(DeltaTime);
    RadarPulse = RadarPulse + 0.5 * DeltaTime;
    if ( RadarPulse >= 1 )
    {
        if ( !bNoRadarSound && (Level.TimeSeconds - LastDrawRadar < 0.2) )
        {
			if(PulseSound != None)
			{
            	PlayerOwner.ClientPlaySound(PulseSound,true,50);
			}
		}

        RadarPulse = RadarPulse - 1;
    }
}

simulated function DrawSpectatingHud(Canvas C)
{
    local string InfoString;
    local plane OldModulate;
    local float xl,yl,Full, Height, Top, TextTop, MedH, SmallH,Scale;

    if(PlayerOwner == None)
    {
		return;
	}

    // Hack for tutorials.
    bIsCinematic = IsInCinematic();

    DisplayLocalMessages(C);

    if ( bIsCinematic )
        return;

	if (InvasionProGameReplicationInfo(PlayerOwner.GameReplicationInfo) != None)
	{
		if(bDisplayMonsterCounter)
		{
			DrawMonsterCount(C);
		}

		if (InvasionProGameReplicationInfo(PlayerOwner.GameReplicationInfo).bTeamNecro && bDisplayNecroPool)
		{
			DrawNecroPool(C);
		}

		if(bDisplayPlayerList && Monster(PawnOwner) == None)
		{
			DrawPlayerNames(C);
		}
	}

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

    if ( UnrealPlayer(Owner).bDisplayWinner ||  UnrealPlayer(Owner).bDisplayLoser )
    {
        if ( UnrealPlayer(Owner).bDisplayWinner )
            InfoString = YouveWonTheMatch;
        else
        {
            if ( PlayerReplicationInfo(PlayerOwner.GameReplicationInfo.Winner) != None )
                InfoString = WonMatchPrefix$PlayerReplicationInfo(PlayerOwner.GameReplicationInfo.Winner).PlayerName$WonMatchPostFix;
            else
                InfoString = YouveLostTheMatch;
        }

        C.SetDrawColor(255,255,255,255);
        C.Font = GetMediumFontFor(C);
        C.StrLen(InfoString,XL,YL);
        C.SetPos( (C.ClipX/2) - (XL/2), Top + (Full/2) - (YL/2));
        C.DrawText(InfoString,false);
    }
    else if ( Pawn(PlayerOwner.ViewTarget) != None && Pawn(PlayerOwner.ViewTarget).PlayerReplicationInfo != None )
    {
        // Draw View Target info

        C.SetDrawColor(32,255,32,255);

        if ( C.ClipX < 640 )
            SmallH = 0;
        else
        {
            // Draw "Now Viewing"

            C.SetPos((256*Scale*0.75),TextTop);
            C.DrawText(NowViewing,false);

            // Draw "Score"

            InfoString = GetScoreText();
            C.StrLen(InfoString,Xl,Yl);
            C.SetPos(C.ClipX-5-XL,TextTop);
            C.DrawText(InfoString);
        }

        // Draw Player Name

        C.SetDrawColor(255,255,0,255);
        C.Font = GetMediumFontFor(C);
        C.SetPos((256*Scale*0.75),TextTop+SmallH);
        C.DrawText(Pawn(PlayerOwner.ViewTarget).PlayerReplicationInfo.PlayerName,false);

        // Draw Score

        InfoString = GetScoreValue(Pawn(PlayerOwner.ViewTarget).PlayerReplicationInfo);
        C.StrLen(InfoString,xl,yl);
        C.SetPos(C.ClipX-5-XL,TextTop+SmallH);
        C.DrawText(InfoString,false);

        // Draw Tag Line

        C.Font = GetConsoleFont(C);
        InfoString = GetScoreTagLine();
        C.StrLen(InfoString,xl,yl);
        C.SetPos( (C.ClipX/2) - (XL/2),Top-3-YL);
        C.DrawText(InfoString);
    }
    else if(Monster(PlayerOwner.ViewTarget) != None)
    {
		// Draw View Target info

		C.SetDrawColor(32,255,32,255);

		if ( C.ClipX < 640 )
			SmallH = 0;
		else
		{
			// Draw "Now Viewing"
			C.SetPos((256*Scale*0.75),TextTop);
			C.DrawText(NowViewing,false);

			// Draw "Monster Team Score"

			InfoString = MonsterScoretext;
			C.StrLen(InfoString,Xl,Yl);
			C.SetPos(C.ClipX-5-XL,TextTop);
			C.DrawText(InfoString);
		}

		// Draw Monster Name

		C.SetDrawColor(255,255,0,255);
		C.Font = GetMediumFontFor(C);
		C.SetPos((256*Scale*0.75),TextTop+SmallH);
		C.DrawText(Monster(PlayerOwner.ViewTarget).Name,false);

		// Draw Monster Score

		InfoString = ""$(InvasionProGameReplicationInfo(PlayerOwner.GameReplicationInfo).MonsterTeamScore);
		C.StrLen(InfoString,xl,yl);
		C.SetPos(C.ClipX-5-XL,TextTop+SmallH);
		C.DrawText(InfoString,false);

		// Draw Tag Line

		C.Font = GetConsoleFont(C);
		InfoString = GetScoreTagLine();
		C.StrLen(InfoString,xl,yl);
		C.SetPos( (C.ClipX/2) - (XL/2),Top-3-YL);
        C.DrawText(InfoString);
	}
    else
    {
        InfoString = GetInfoString();

        // Draw
        C.SetDrawColor(255,255,255,255);
        C.Font = GetMediumFontFor(C);
        C.StrLen(InfoString,XL,YL);
        C.SetPos( (C.ClipX/2) - (XL/2), Top + (Full/2) - (YL/2));
        C.DrawText(InfoString,false);
    }

    C.ColorModulate = OldModulate;
}

simulated function LocalizedMessage( class<LocalMessage> Message, optional int Switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2, optional Object OptionalObject, optional String CriticalString)
{
    if( Message == None || PlayerOwner == None)
    {
        return;
	}

	Super.LocalizedMessage(Message, Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject, CriticalString);
}

function DisplayHit(vector HitDir, int Damage, class<DamageType> damageType)
{
    local int i;
    local vector X,Y,Z;
    local byte Ignore[4];
    local rotator LookDir;
    local float NewDamageTime,Forward,Left;

	if(PawnOwner != None)
	{
    	LookDir = PawnOwner.Rotation;
   		LookDir.Pitch = 0;
	}
   	else
   	{
		LookDir.Yaw = 0;
		LookDir.Roll = 0;
		LookDir.Pitch = 0;
	}

    GetAxes(LookDir, X,Y,Z);
    HitDir.Z = 0;
    HitDir = Normal(HitDir);

    Forward = HitDir Dot X;
    Left = HitDir Dot Y;

    if ( Forward > 0 )
    {
        if ( Forward > 0.7 )
            Emphasized[0] = 1;
        Ignore[1] = 1;
    }
    else
    {
        if ( Forward < -0.7 )
            Emphasized[1] = 1;
        Ignore[0] = 1;
    }
    if ( Left > 0 )
    {
        if ( Left > 0.7 )
            Emphasized[3] = 1;
        Ignore[2] = 1;
    }
    else
    {
        if ( Left < -0.7 )
            Emphasized[2] = 1;
        Ignore[3] = 1;
    }

    NewDamageTime = 5 * Clamp(Damage,20,30);
    for ( i=0; i<4; i++ )
        if ( Ignore[i] != 1 )
        {
            DamageFlash[i].R = 255;
            DamageTime[i] = NewDamageTime;
        }
}

simulated function DrawMessage( Canvas C, int i, float PosX, float PosY, out float DX, out float DY )
{
    local float FadeValue;
    local float ScreenX, ScreenY;

	//Draw color
	if(ClassIsChildOf (LocalMessages[i].Message, class'InvasionProWaveMessage'))
	{
		LocalMessages[i].DrawColor = InvasionProGameReplicationInfo(PlayerOwner.GameReplicationInfo).WaveDrawColour;
	}
	else if(ClassIsChildOf (LocalMessages[i].Message, class'InvasionProWaveCountDownMessage'))
	{
		LocalMessages[i].DrawColor = InvasionProGameReplicationInfo(PlayerOwner.GameReplicationInfo).WaveCountDownColour;
	}

    if ( !LocalMessages[i].Message.default.bFadeMessage )
    {
        C.DrawColor = LocalMessages[i].DrawColor;
	}
    else
    {
        FadeValue = (LocalMessages[i].EndOfLife - Level.TimeSeconds);
        C.DrawColor = LocalMessages[i].DrawColor;
        C.DrawColor.A = LocalMessages[i].DrawColor.A * (FadeValue/LocalMessages[i].LifeTime);
    }

    C.Font = LocalMessages[i].StringFont;
    GetScreenCoords( PosX, PosY, ScreenX, ScreenY, LocalMessages[i], C );
    C.SetPos( ScreenX, ScreenY );
    DX = LocalMessages[i].DX / C.ClipX;
    DY = LocalMessages[i].DY / C.ClipY;

    if ( LocalMessages[i].Message.default.bComplexString )
    {
        LocalMessages[i].Message.static.RenderComplexMessage( C, LocalMessages[i].DX, LocalMessages[i].DY,
            LocalMessages[i].StringMessage, LocalMessages[i].Switch, LocalMessages[i].RelatedPRI,
            LocalMessages[i].RelatedPRI2, LocalMessages[i].OptionalObject );
    }
    else
    {
        C.DrawTextClipped( LocalMessages[i].StringMessage, false );
    }

    LocalMessages[i].Drawn = true;
}

defaultproperties
{
     RadarScale=0.200000
     MonsterScoretext="Monster Team Score"
     RadarSpecialOffsetX=0.621000
     RadarSpecialOffsetY=0.010000
     bDisplayBossTimer=True
     bDisplayBossNames=True
     MonsterColor=(G=255,R=255,A=255)
     PlayerColor=(B=255,G=255,A=255)
     RadarColor=(B=100,G=150,A=255)
     OwnerColor=(B=255,G=255,R=255,A=255)
     bDisplayMonsterCounter=True
     bDisplayPlayerList=True
     bDisplayNecroPool=True
     RadarPosX=0.912558
     RadarPosY=0.192209
     PulseColor=(B=215,G=160,R=50,A=255)
     bSpecMonsters=True
     MonsterKillSounds(0)="None"
     MonsterKillSounds(1)="InvasionProv1_7.KillSound01"
     MonsterKillSounds(2)="InvasionProv1_7.KillSound02"
     MonsterKillSounds(3)="InvasionProv1_7.KillSound03"
     MonsterKillSounds(4)="InvasionProv1_7.KillSound04"
     MonsterKillSounds(5)="InvasionProv1_7.KillSound05"
     CurrentKillSound="None"
     RadarSound="SkaarjPack_rc.RadarPulseSound.RadarPulseSound"
     RadarImage=Texture'InvasionProTexturesv1_4.HUD.NewRadar01'
     PulseImage=Shader'InvasionProTexturesv1_4.HUD.PulseRing01_Shader'
     RadarMaterials(1)=Texture'InvasionProTexturesv1_4.HUD.NewRadar01'
     RadarMaterials(2)=Texture'InvasionProTexturesv1_4.HUD.NewRadar02'
     RadarMaterials(3)=Texture'InvasionProTexturesv1_4.HUD.NewRadar03'
     RadarMaterials(4)=Texture'InvasionProTexturesv1_4.HUD.NewRadar04'
     RadarMaterials(5)=Texture'InvasionProTexturesv1_4.HUD.NewRadar05'
     RadarMaterials(6)=Texture'InvasionProTexturesv1_4.HUD.NewRadar06'
     RadarMaterials(7)=Texture'InvasionProTexturesv1_4.HUD.NewRadar07'
     RadarMaterials(8)=Texture'InvasionProTexturesv1_4.HUD.NewRadar08'
     RadarMaterials(9)=Texture'InvasionProTexturesv1_4.HUD.NewRadar09'
     RadarMaterials(10)=Texture'InvasionProTexturesv1_4.HUD.NewRadar10'
     PulseMaterials(1)=Shader'InvasionProTexturesv1_4.HUD.PulseRing01_Shader'
     PulseMaterials(2)=TexRotator'InvasionProTexturesv1_4.HUD.PulseRing02_Rot'
     PulseMaterials(3)=TexRotator'InvasionProTexturesv1_4.HUD.PulseRing03_Rot'
     PulseMaterials(4)=TexRotator'InvasionProTexturesv1_4.HUD.PulseRing04_Rot'
     PulseMaterials(5)=TexRotator'InvasionProTexturesv1_4.HUD.PulseRing05_Rot'
     OwnerIcon=Texture'InvasionProv1_7.Radar_Dot'
     MonsterIcon=Texture'InvasionProv1_7.Radar_Dot'
     FriendlyPlayerIcon=Texture'InvasionProv1_7.Radar_Dot'
     FriendlyMonsterIcon=Texture'InvasionProv1_7.Radar_Dot'
     bDrawPetInfo=True
     RadarRange=2200.000000
     ClassicRadarRange=3000.000000
     MonsterCounterColor=(G=255,R=255)
     Dotwidth=10.000000
     DotHeight=10.000000
     DotULWidth=128.000000
     DotVLHeight=128.000000
     MonsterCounterFont=Font'2k4Fonts.Verdana24'
     LoadingContainerColor=(B=255,G=255,R=255)
     OrangeColor=(G=128,R=255,A=255)
     MonsterNumColor=(G=192,R=255,A=255)
     NecroAlertColor=(B=242,G=121,R=197,A=255)
     BossNameColor=(B=10,G=187,R=245,A=255)
     LoadingContainerImage=Texture'2K4Menus.NewControls.ComboTickWatched'
     LoadingContainerCompanionImage=Shader'XGameShaders.BRShaders.BombIconBS'
     LoadingBarImage=Texture'2K4Menus.NewControls.GradientButtonFocused'
     NecroImage=Texture'InvasionProTexturesv1_4.HUD.NecroAdrenaline'
     NecroWorldImage=Texture'HUDContent.Generic.HUD'
     NecroBackground=Texture'HUDContent.Generic.HUD'
     MonsterNumImage=Texture'InvasionProTexturesv1_4.HUD.MonsterCountImage'
     NecroAlertImage=FinalBlend'HUDContent.Generic.fbHUDAlertSlow'
     LoadingBarSizeX=0.001000
     LoadingFont=Font'2k4Fonts.Verdana24'
     NecroFont=Font'UT2003Fonts.FontMedium'
     PlayerFont=Font'UT2003Fonts.FontMedium'
     MonsterCountBackground=(WidgetTexture=Texture'HUDContent.Generic.HUD',RenderStyle=STY_Alpha,TextureCoords=(X1=168,Y1=211,X2=334,Y2=255),TextureScale=0.500000,OffsetX=40,OffsetY=8,ScaleMode=SM_Right,Scale=1.000000,Tints[0]=(A=255),Tints[1]=(A=255))
     MonsterCountBackgroundDisc=(WidgetTexture=Texture'HUDContent.Generic.HUD',RenderStyle=STY_Alpha,TextureCoords=(X1=119,Y1=258,X2=173,Y2=313),TextureScale=0.530000,ScaleMode=SM_Right,Scale=1.000000,Tints[0]=(B=255,G=255,R=255,A=255),Tints[1]=(B=255,G=255,R=255,A=255))
     MonsterCountImage=(WidgetTexture=Texture'InvasionProTexturesv1_4.HUD.MonsterCountImage',RenderStyle=STY_Alpha,TextureCoords=(Y1=258,X2=64,Y2=313),TextureScale=0.350000,OffsetX=6,OffsetY=10,ScaleMode=SM_Right,Scale=1.000000,Tints[0]=(B=11,G=216,R=244,A=255),Tints[1]=(B=11,G=216,R=244,A=255))
     MonsterCount=(RenderStyle=STY_Alpha,TextureScale=0.390000,OffsetX=80,OffsetY=20,Tints[0]=(B=255,G=255,R=255,A=255),Tints[1]=(B=255,G=255,R=255,A=255))
     NecroCountBackground=(WidgetTexture=Texture'HUDContent.Generic.HUD',RenderStyle=STY_Alpha,TextureCoords=(X1=168,Y1=211,X2=334,Y2=255),TextureScale=0.400000,OffsetX=60,OffsetY=85,ScaleMode=SM_Right,Scale=1.000000,Tints[0]=(A=255),Tints[1]=(A=255))
     NecroCountBackgroundDisc=(WidgetTexture=Texture'HUDContent.Generic.HUD',RenderStyle=STY_Alpha,TextureCoords=(X1=119,Y1=258,X2=173,Y2=313),TextureScale=0.530000,OffsetY=55,ScaleMode=SM_Right,Scale=1.000000,Tints[0]=(B=255,G=255,R=255,A=255),Tints[1]=(B=255,G=255,R=255,A=255))
     NecroAlert=(WidgetTexture=FinalBlend'HUDContent.Generic.fb_Pulse001',RenderStyle=STY_Alpha,TextureCoords=(X2=64,Y2=64),TextureScale=0.500000,OffsetX=-3,OffsetY=56,ScaleMode=SM_Right,Scale=1.000000,Tints[0]=(G=176,A=255),Tints[1]=(G=176,A=255))
     NecroAdrenaline=(WidgetTexture=Texture'XEffectMat.Shock.shock_core',RenderStyle=STY_Translucent,TextureCoords=(X2=256,Y2=256),TextureScale=0.090000,OffsetX=35,OffsetY=360,ScaleMode=SM_Right,Scale=1.000000,Tints[0]=(B=255,G=174,R=174,A=255),Tints[1]=(B=255,G=175,R=175,A=255))
     NecroSlash=(WidgetTexture=Texture'UT2003Fonts.FontEurostile37.FontEurostile37_PageADXT',RenderStyle=STY_Alpha,TextureCoords=(X1=410,X2=440,Y2=50),TextureScale=0.280000,OffsetX=145,OffsetY=125,ScaleMode=SM_Right,Scale=1.000000,Tints[0]=(B=255,G=255,R=255,A=150),Tints[1]=(B=255,G=255,R=255,A=150))
     NecroCount=(RenderStyle=STY_Alpha,TextureScale=0.300000,OffsetX=100,OffsetY=125,Tints[0]=(B=255,G=255,R=255,A=255),Tints[1]=(B=255,G=255,R=255,A=255))
     NecroCountMax=(RenderStyle=STY_Alpha,TextureScale=0.300000,OffsetX=170,OffsetY=125,Tints[0]=(B=255,G=255,R=255,A=255),Tints[1]=(B=255,G=255,R=255,A=255))
     BossTime=(RenderStyle=STY_Alpha,MinDigitCount=5,TextureScale=0.500000,OffsetX=540,OffsetY=30,Tints[0]=(R=255,A=255),Tints[1]=(R=255,A=255),bPadWithZeroes=1)
     PlayerBackground=(WidgetTexture=Texture'HUDContent.Generic.HUD',RenderStyle=STY_Alpha,TextureCoords=(X1=168,Y1=211,X2=334,Y2=255),TextureScale=0.500000,OffsetX=10,ScaleMode=SM_Up,Scale=0.500000,Tints[0]=(B=255,G=255,R=255,A=75),Tints[1]=(B=255,G=255,R=255,A=255))
     PlayerBackgroundSpacer=0.550000
     PlayerBackgroundAbsoluteY=110.000000
     PlayerFontScale=-2
     PlayerNameSpacer=0.000452
     PlayerFontYSize=0.750000
     PlayerFontXSize=0.750000
     PlayerListPosY=0.125000
     PlayerListSpacerY=0.025000
     bDrawLoading=True
     BossBarBackground=(WidgetTexture=Texture'InvasionProTexturesv1_4.HUD.Background_bar01',RenderStyle=STY_Alpha,TextureCoords=(X2=256,Y2=22),TextureScale=1.000000,OffsetX=256,OffsetY=3,ScaleMode=SM_Right,Scale=1.000000,Tints[0]=(A=255),Tints[1]=(A=255))
     BossImage=Texture'2K4Menus.Controls.checkBoxBall_w'
     testX=0.500000
     testY=0.080000
     TestX2=0.600000
     TestY2=0.500000
     PreloadingText="Preloading"
     BehindViewCrosshairSize=0.250000
     TestColor=(G=255,A=255)
     FriendlyMonsterNameColor=(B=255,G=255,A=255)
     HostileMonsterNameColor=(R=255,A=255)
     MonsterNameOffset=12.000000
     AuraText(0)="No Aura"
     AuraText(1)="(Heal Aura)"
     AuraText(2)="(Damage Aura)"
     AuraText(3)="(Defense Aura)"
     AuraText(4)="(Companion Aura)"
     AuraText(5)="(Frost Aura)"
     AuraText(6)="(Chain Lightning Aura)"
     AuraText(7)="(Resurrect Aura)"
     AuraText(8)="(Retribution Aura)"
     AuraTextColor=(B=255,G=150,A=255)
     bDrawTimer=False
     WaitingToSpawn="Press [Fire] to join the Invasion!"
     YouveLostTheMatch="The Invasion Continues"
}
