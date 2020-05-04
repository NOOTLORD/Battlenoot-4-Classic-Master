class InvasionProHudConfig extends GUICustomPropertyPage;

var() Automated GUIMultiOptionListBox currentScrollContainer;
var() Automated moSlider MonsterColorR;
var() Automated moSlider MonsterColorG;
var() Automated moSlider MonsterColorB;
var() Automated moSlider PlayerColorR;
var() Automated moSlider PlayerColorG;
var() Automated moSlider PlayerColorB;
var() Automated moSlider OwnerColorR;
var() Automated moSlider OwnerColorG;
var() Automated moSlider OwnerColorB;
var() Automated moSlider RadarColorR;
var() Automated moSlider RadarColorG;
var() Automated moSlider RadarColorB;
var() Automated moSlider RadarColorA;
var() Automated moSlider PulseColorR;
var() Automated moSlider PulseColorG;
var() Automated moSlider PulseColorB;
var() Automated moSlider PulseColorA;
var() Automated moSlider RadarPosX;
var() Automated moSlider RadarPosY;
var() Automated GUILabel RadarPreviewLabel;
var() Automated GUILabel ColorUpdateLabel;

var() Automated GUILabel MonsterLabel;
var() Automated GUILabel PlayerLabel;
var() Automated GUILabel OwnerLabel;

var() Automated moCheckBox bDrawPetInfo;
var() Automated moCheckBox bHideRadar;
var() Automated moCheckBox bDisplayMonsterCounter;
var() Automated moCheckBox bNoRadarSound;
var() Automated moCheckBox bClassicRadar;
var() Automated moCheckBox bDisplayNecroPool;
var() Automated moCheckBox bDisplayPlayerList;
var() Automated moCheckBox bSpecMonsters;
var() Automated moCheckBox bStartThirdPerson;
var() Automated moCheckBox bDisplayMonsterHealthBars;
var() Automated moCheckBox bDisplayBossNames;
var() Automated moCheckBox bDisplayBossTimer;
var() Automated moCheckBox bAddFriendlyMonstersToPlayerList;
var() Automated moComboBox RadarTexture;
var() Automated moComboBox PulseTexture;
var() Automated GUIImage PulseImage;
var() Automated GUIImage RadarImage;
var() Automated GUIImage MonsterImage;
var() Automated GUIImage PlayerImage;
var() Automated GUIImage OwnerImage;
var() array<string> RadarStyle;
var() array<string> PulseStyle;
var() float PulseWidth;
var() float PulseOffsetX, PulseOffsetY;
var() Automated moComboBox currentMonsterKillSound;
var() InvasionProHud BaseHUD;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local int i;
	local bool bTemp;
	local string PackageLeft, PackageRight, TestString;

	Super.InitComponent(MyController, MyOwner);

	BaseHUD = InvasionProHud(PlayerOwner().myHUD);

	sb_Main.Caption = "Hud Configuration";
	sb_Main.bScaleToParent = true;
	sb_Main.WinWidth=0.932639;
	sb_Main.WinHeight=0.930252;
	sb_Main.WinLeft=0.037070;
	sb_Main.WinTop=0.050586;

	t_WindowTitle.Caption = "InvasionPro";

	//resize ok/defaults button
	b_OK.WinWidth = default.b_OK.WinWidth;
	b_OK.WinHeight = default.b_OK.WinHeight;
	b_OK.WinLeft = default.b_OK.WinLeft;
	b_OK.WinTop = default.b_OK.WinTop;

	//resize save/close button
	b_Cancel.WinWidth = default.b_Cancel.WinWidth;
	b_Cancel.WinHeight = default.b_Cancel.WinHeight;
	b_Cancel.WinLeft = default.b_Cancel.WinLeft;
	b_Cancel.WinTop = default.b_Cancel.WinTop;

	i_FrameBG.ImageRenderStyle = MSTY_Translucent;

	if(ParentPage != None)
	{
		ParentPage.bRequire640x480 = False;
	}

    bTemp = Controller.bCurMenuInitialized;
    Controller.bCurMenuInitialized = False;

	currentScrollContainer.List.ColumnWidth = 0.995;

	bHideRadar = moCheckBox(currentScrollContainer.List.AddItem("XInterface.moCheckBox", ,"Hide Radar",true));
    bHideRadar.ToolTip.SetTip("Check this box to hide the radar if the server has it enabled.");

	bClassicRadar = moCheckBox(currentScrollContainer.List.AddItem("XInterface.moCheckBox", ,"Classic Radar",true));
    bClassicRadar.ToolTip.SetTip("Check this box to revert back to the original invasion radar.");

	bNoRadarSound = moCheckBox(currentScrollContainer.List.AddItem("XInterface.moCheckBox", ,"No Radar Sound",true));
    bNoRadarSound.ToolTip.SetTip("Check this box to turn off the radar sound.");

 	RadarPosX = moSlider(currentScrollContainer.List.AddItem("XInterface.moSlider", ,"Radar Position X",true));
 	RadarPosX.Setup(0, 1, false);
    RadarPosX.ToolTip.SetTip("Where the radar is positioned on the X axis.");
 	RadarPosY = moSlider(currentScrollContainer.List.AddItem("XInterface.moSlider", ,"Radar Position Y",true));
 	RadarPosY.Setup(0, 1, false);
    RadarPosY.ToolTip.SetTip("Where the radar is positioned on the Y axis.");

	RadarTexture = moComboBox(currentScrollContainer.List.AddItem("XInterface.moComboBox", ,"Radar Style",true));
    RadarTexture.ToolTip.SetTip("Choose a radar style.");
	RadarTexture.bReadOnly = True;
	//RadarTexture.bVerticalLayout = True;
	RadarTexture.OnChange = InternalOnChange;

	PulseTexture = moComboBox(currentScrollContainer.List.AddItem("XInterface.moComboBox", ,"Pulse Style",true));
    PulseTexture.ToolTip.SetTip("Choose a pulse style.");
	PulseTexture.bReadOnly = True;
	//PulseTexture.bVerticalLayout = True;
	PulseTexture.OnChange = InternalOnChange;

 	RadarColorR = moSlider(currentScrollContainer.List.AddItem("XInterface.moSlider", ,"Radar Red",true));
 	RadarColorR.Setup(0, 255, true);
    RadarColorR.ToolTip.SetTip("How much Red the radar receives.");

 	RadarColorG = moSlider(currentScrollContainer.List.AddItem("XInterface.moSlider", ,"Radar Green",true));
 	RadarColorG.Setup(0, 255, true);
    RadarColorG.ToolTip.SetTip("How much Green the radar receives.");

 	RadarColorB = moSlider(currentScrollContainer.List.AddItem("XInterface.moSlider", ,"Radar Blue",true));
 	RadarColorB.Setup(0, 255, true);
    RadarColorB.ToolTip.SetTip("How much Blue the radar receives.");

  	RadarColorA = moSlider(currentScrollContainer.List.AddItem("XInterface.moSlider", ,"Radar Alpha",true));
 	RadarColorA.Setup(0, 255, true);
    RadarColorA.ToolTip.SetTip("How much Alpha the radar receives.");

 	PulseColorR = moSlider(currentScrollContainer.List.AddItem("XInterface.moSlider", ,"Radar Pulse Red",true));
 	PulseColorR.Setup(0, 255, true);
    PulseColorR.ToolTip.SetTip("How much Red the radar pulse receives.");

 	PulseColorG = moSlider(currentScrollContainer.List.AddItem("XInterface.moSlider", ,"Radar Pulse Green",true));
 	PulseColorG.Setup(0, 255, true);
    PulseColorG.ToolTip.SetTip("How much Green the radar pulse receives.");

 	PulseColorB = moSlider(currentScrollContainer.List.AddItem("XInterface.moSlider", ,"Radar Pulse Blue",true));
 	PulseColorB.Setup(0, 255, true);
    PulseColorB.ToolTip.SetTip("How much Blue the radar pulse receives.");

  	PulseColorA = moSlider(currentScrollContainer.List.AddItem("XInterface.moSlider", ,"Radar Pulse Alpha",true));
 	PulseColorA.Setup(0, 255, true);
    PulseColorA.ToolTip.SetTip("How much Alpha the radar pulse receives.");

 	OwnerColorR = moSlider(currentScrollContainer.List.AddItem("XInterface.moSlider", ,"Owner Beacon Red",true));
 	OwnerColorR.Setup(0, 255, true);
    OwnerColorR.ToolTip.SetTip("How much Red the owner beacon receives.");

 	OwnerColorG = moSlider(currentScrollContainer.List.AddItem("XInterface.moSlider", ,"Owner Beacon Green",true));
 	OwnerColorG.Setup(0, 255, true);
    OwnerColorG.ToolTip.SetTip("How much Green the owner beacon receives.");

 	OwnerColorB = moSlider(currentScrollContainer.List.AddItem("XInterface.moSlider", ,"Owner Beacon Blue",true));
 	OwnerColorB.Setup(0, 255, true);
    OwnerColorB.ToolTip.SetTip("How much Blue the owner beacon receives.");

 	PlayerColorR = moSlider(currentScrollContainer.List.AddItem("XInterface.moSlider", ,"Friendly Beacon Red",true));
 	PlayerColorR.Setup(0, 255, true);
    PlayerColorR.ToolTip.SetTip("How much Red the friendly player beacon receives.");

 	PlayerColorG = moSlider(currentScrollContainer.List.AddItem("XInterface.moSlider", ,"Friendly Beacon Green",true));
 	PlayerColorG.Setup(0, 255, true);
    PlayerColorG.ToolTip.SetTip("How much Green the friendly player beacon receives.");

 	PlayerColorB = moSlider(currentScrollContainer.List.AddItem("XInterface.moSlider", ,"Friendly Beacon Blue",true));
 	PlayerColorB.Setup(0, 255, true);
    PlayerColorB.ToolTip.SetTip("How much Blue the friendly player beacon receives.");

 	MonsterColorR = moSlider(currentScrollContainer.List.AddItem("XInterface.moSlider", ,"Monster Beacon Red",true));
 	MonsterColorR.Setup(0, 255, true);
    MonsterColorR.ToolTip.SetTip("How much Red the monster beacon receives.");

 	MonsterColorG = moSlider(currentScrollContainer.List.AddItem("XInterface.moSlider", ,"Monster Beacon Green",true));
 	MonsterColorG.Setup(0, 255, true);
    MonsterColorG.ToolTip.SetTip("How much Green the monster beacon receives.");

 	MonsterColorB = moSlider(currentScrollContainer.List.AddItem("XInterface.moSlider", ,"Monster Beacon Blue",true));
 	MonsterColorB.Setup(0, 255, true);
    MonsterColorB.ToolTip.SetTip("How much Blue the monster beacon receives.");

	bDisplayMonsterCounter = moCheckBox(currentScrollContainer.List.AddItem("XInterface.moCheckBox", ,"Display Monster Counter",true));
    bDisplayMonsterCounter.ToolTip.SetTip("Check this box to enable the monster counter.");
	bDisplayNecroPool = moCheckBox(currentScrollContainer.List.AddItem("XInterface.moCheckBox", ,"View Necro Pool",true));
    bDisplayNecroPool.ToolTip.SetTip("Check this box to display the necro pool.");
	bDisplayPlayerList = moCheckBox(currentScrollContainer.List.AddItem("XInterface.moCheckBox", ,"View Player List",true));
    bDisplayPlayerList.ToolTip.SetTip("Check this box to display the player list.");
	bAddFriendlyMonstersToPlayerList = moCheckBox(currentScrollContainer.List.AddItem("XInterface.moCheckBox", ,"Add Friendly Monsters To List",true));
    bAddFriendlyMonstersToPlayerList.ToolTip.SetTip("Check this box to display friendly monsters on the player list.");


	bSpecMonsters = moCheckBox(currentScrollContainer.List.AddItem("XInterface.moCheckBox", ,"Spectate Monsters",true));
    bSpecMonsters.ToolTip.SetTip("Check this box to enable monster spectating.");
	bStartThirdPerson = moCheckBox(currentScrollContainer.List.AddItem("XInterface.moCheckBox", ,"Start Third Person",true));
    bStartThirdPerson.ToolTip.SetTip("Check this box to start in third person mode, if the server has it enabled.");
	bDisplayMonsterHealthBars = moCheckBox(currentScrollContainer.List.AddItem("XInterface.moCheckBox", ,"Display Monster Health Bars",true));
    bDisplayMonsterHealthBars.ToolTip.SetTip("Check this box to display health bars above the monsters that are within radar range.");

    bDrawPetInfo = moCheckBox(currentScrollContainer.List.AddItem("XInterface.moCheckBox", ,"Display Pet Info",true));
	bDrawPetInfo.ToolTip.SetTip("Check this box to display the friendly pets name and information.");

	bDisplayBossTimer = moCheckBox(currentScrollContainer.List.AddItem("XInterface.moCheckBox", ,"Display Boss Timer",true));
    bDisplayBossTimer.ToolTip.SetTip("Check this box to display the boss timer during boss waves.");
	bDisplayBossNames = moCheckBox(currentScrollContainer.List.AddItem("XInterface.moCheckBox", ,"Display Boss Names",true));
    bDisplayBossNames.ToolTip.SetTip("Check this box to display the boss names during boss waves.");

	currentMonsterKillSound = moComboBox(currentScrollContainer.List.AddItem("XInterface.moComboBox", ,"Kill Sound",true));
    currentMonsterKillSound.ToolTip.SetTip("Choose a sound to play when you kill a monster.");
	currentMonsterKillSound.bReadOnly = True;
	//currentMonsterKillSound.bVerticalLayout = True;
	currentMonsterKillSound.OnChange = InternalOnChange;
	currentMonsterKillSound.OnClickSound = CS_None;
	currentMonsterKillSound.OnClick = PlayMonsterKillSound;

	Controller.bCurMenuInitialized = bTemp;

	SetDefaultComponent(bDrawPetInfo);
	SetDefaultComponent(bHideRadar);
	SetDefaultComponent(bDisplayMonsterCounter);
	SetDefaultComponent(bNoRadarSound);
	SetDefaultComponent(bClassicRadar);
	SetDefaultComponent(bDisplayNecroPool);
	SetDefaultComponent(bDisplayPlayerList);
	SetDefaultComponent(bSpecMonsters);
	SetDefaultComponent(bStartThirdPerson);
	SetDefaultComponent(bDisplayMonsterHealthBars);
	SetDefaultComponent(bDisplayBossTimer);
	SetDefaultComponent(bDisplayBossNames);
	SetDefaultComponent(RadarTexture);
	SetDefaultComponent(PulseTexture);
	SetDefaultComponent(RadarPosX);
	SetDefaultComponent(RadarPosY);
	SetDefaultComponent(currentMonsterKillSound);
	SetDefaultComponent(bAddFriendlyMonstersToPlayerList);
	SetDefaultComponent(OwnerColorR);
	SetDefaultComponent(OwnerColorG);
	SetDefaultComponent(OwnerColorB);
	SetDefaultComponent(PlayerColorR);
	SetDefaultComponent(PlayerColorG);
	SetDefaultComponent(PlayerColorB);
	SetDefaultComponent(MonsterColorR);
	SetDefaultComponent(MonsterColorG);
	SetDefaultComponent(MonsterColorB);
	SetDefaultComponent(RadarColorR);
	SetDefaultComponent(RadarColorG);
	SetDefaultComponent(RadarColorB);
	SetDefaultComponent(RadarColorA);
	SetDefaultComponent(PulseColorR);
	SetDefaultComponent(PulseColorG);
	SetDefaultComponent(PulseColorB);
	SetDefaultComponent(PulseColorA);
	RadarPosX.CaptionWidth = 1;
	RadarPosX.ComponentWidth = 0.4;
	RadarPosY.CaptionWidth = 1;
	RadarPosY.ComponentWidth = 0.4;

	OwnerColorR.CaptionWidth = 1;
	OwnerColorR.ComponentWidth = 0.4;
	OwnerColorG.CaptionWidth = 1;
	OwnerColorG.ComponentWidth = 0.4;
	OwnerColorB.CaptionWidth = 1;
	OwnerColorB.ComponentWidth = 0.4;

	PlayerColorR.CaptionWidth = 1;
	PlayerColorR.ComponentWidth = 0.4;
	PlayerColorG.CaptionWidth = 1;
	PlayerColorG.ComponentWidth = 0.4;
	PlayerColorB.CaptionWidth = 1;
	PlayerColorB.ComponentWidth = 0.4;

	MonsterColorR.CaptionWidth = 1;
	MonsterColorR.ComponentWidth = 0.4;
	MonsterColorG.CaptionWidth = 1;
	MonsterColorG.ComponentWidth = 0.4;
	MonsterColorB.CaptionWidth = 1;
	MonsterColorB.ComponentWidth = 0.4;

	RadarColorR.CaptionWidth = 1;
	RadarColorR.ComponentWidth = 0.4;
	RadarColorG.CaptionWidth = 1;
	RadarColorG.ComponentWidth = 0.4;
	RadarColorB.CaptionWidth = 1;
	RadarColorB.ComponentWidth = 0.4;
	RadarColorA.CaptionWidth = 1;
	RadarColorA.ComponentWidth = 0.4;

	PulseColorR.CaptionWidth = 1;
	PulseColorR.ComponentWidth = 0.4;
	PulseColorG.CaptionWidth = 1;
	PulseColorG.ComponentWidth = 0.4;
	PulseColorB.CaptionWidth = 1;
	PulseColorB.ComponentWidth = 0.4;
	PulseColorA.CaptionWidth = 1;
	PulseColorA.ComponentWidth = 0.4;

	RadarTexture.CaptionWidth = 1;
	RadarTexture.ComponentWidth = 0.68;
	PulseTexture.CaptionWidth = 1;
	PulseTexture.ComponentWidth = 0.68;
	currentMonsterKillSound.CaptionWidth = 1;
	currentMonsterKillSound.ComponentWidth = 0.68;

	if(BaseHUD != None)
	{
		for(i=0;i<BaseHUD.MonsterKillSounds.Length;i++)
		{
			Divide(BaseHUD.MonsterKillSounds[i],".",PackageLeft, PackageRight);

			if(BaseHUD.MonsterKillSounds[i] ~= "None")
			{
				PackageRight = "None";
			}

			currentMonsterKillSound.AddItem(PackageRight);
		}

		currentMonsterKillSound.MyComboBox.Edit.FontScale = FNS_Small;
		currentMonsterKillSound.StandardHeight = 0.04;
		currentMonsterKillSound.MyComboBox.MaxVisibleItems = 4;

		for(i=0;i<BaseHUD.RadarMaterials.Length;i++)
		{
			TestString = String(BaseHUD.RadarMaterials[i]);
			TestString = Repl(TestString, "'", "");
			if(!Divide(TestString,".",PackageLeft, PackageRight))
			{
				PackageRight = "None";
			}

			TestString = PackageRight;
			Divide(TestString,".",PackageLeft, PackageRight);
			RadarTexture.AddItem(PackageRight);
		}

		RadarTexture.MyComboBox.Edit.FontScale = FNS_Small;
		RadarTexture.StandardHeight = 0.04;

		for(i=0;i<BaseHUD.PulseMaterials.Length;i++)
		{
			TestString = String(BaseHUD.PulseMaterials[i]);
			TestString = Repl(TestString, "'", "");
			Divide(TestString,".",PackageLeft, PackageRight);

			if(!Divide(TestString,".",PackageLeft, PackageRight))
			{
				PackageRight = "None";
			}

			TestString = PackageRight;
			Divide(TestString,".",PackageLeft, PackageRight);
			PulseTexture.AddItem(PackageRight);
		}

		PulseTexture.MyComboBox.Edit.FontScale = FNS_Small;
		PulseTexture.StandardHeight = 0.04;
	}

	Initialize();
}

function SetDefaultComponent(GUIMenuOption PassedComponent)
{
	PassedComponent.CaptionWidth = 0.8;
	PassedComponent.ComponentWidth = 0.2;
	PassedComponent.ComponentJustification = TXTA_Right;
	PassedComponent.bStandardized = false;
	PassedComponent.bBoundToParent = False;
	PassedComponent.bScaleToParent = False;

	if(PassedComponent.MyLabel != None)
	{
		PassedComponent.MyLabel.TextAlign = TXTA_Left;
	}
}

//set current settings
function Initialize()
{
	local int ItemIndex;
	local string PackageLeft, PackageRight, TestString;

	if (BaseHUD != None )
	{
		RadarColorR.SetValue (BaseHUD.default.RadarColor.R);
		RadarColorG.SetValue (BaseHUD.default.RadarColor.G);
		RadarColorB.SetValue (BaseHUD.default.RadarColor.B);
		RadarColorA.SetValue (BaseHUD.default.RadarColor.A);

		RadarImage.Image = BaseHUD.default.RadarImage;
		PulseImage.Image = BaseHUD.default.PulseImage;

		RadarPosX.SetValue(BaseHUD.default.RadarPosX);
		RadarPosY.SetValue(BaseHUD.default.RadarPosY);

		PulseColorR.SetValue (BaseHUD.default.PulseColor.R);
		PulseColorG.SetValue (BaseHUD.default.PulseColor.G);
		PulseColorB.SetValue (BaseHUD.default.PulseColor.B);
		PulseColorA.SetValue (BaseHUD.default.PulseColor.A);

		MonsterColorR.SetValue(BaseHUD.default.MonsterColor.R);
		MonsterColorG.SetValue(BaseHUD.default.MonsterColor.G);
		MonsterColorB.SetValue(BaseHUD.default.MonsterColor.B);

		PlayerColorR.SetValue(BaseHUD.default.PlayerColor.R);
		PlayerColorG.SetValue(BaseHUD.default.PlayerColor.G);
		PlayerColorB.SetValue(BaseHUD.default.PlayerColor.B);

		OwnerColorR.SetValue(BaseHUD.default.OwnerColor.R);
		OwnerColorG.SetValue(BaseHUD.default.OwnerColor.G);
		OwnerColorB.SetValue(BaseHUD.default.OwnerColor.B);

		bHideRadar.SetComponentValue(BaseHUD.default.bHideRadar);

		bAddFriendlyMonstersToPlayerList.SetComponentValue(BaseHUD.default.bAddFriendlyMonstersToPlayerList);
		bDisplayMonsterCounter.SetComponentValue(BaseHUD.default.bDisplayMonsterCounter);
		bNoRadarSound.SetComponentValue(BaseHUD.default.bNoRadarSound);
		bClassicRadar.SetComponentValue(BaseHUD.default.bClassicRadar);
		bDisplayPlayerList.SetComponentValue(BaseHUD.default.bDisplayPlayerList);
		bDisplayNecroPool.SetComponentValue(BaseHUD.default.bDisplayNecroPool);

		bStartThirdPerson.SetComponentValue(BaseHUD.default.bStartThirdPerson);
		bSpecMonsters.SetComponentValue(BaseHUD.default.bSpecMonsters);
		bDisplayMonsterHealthBars.SetComponentValue(BaseHUD.default.bDisplayMonsterHealthBars);

		bDrawPetInfo.SetComponentValue(BaseHUD.default.bDrawPetInfo);

		bDisplayBossNames.SetComponentValue(BaseHUD.default.bDisplayBossNames);
		bDisplayBossTimer.SetComponentValue(BaseHUD.default.bDisplayBossTimer);

		TestString = String(BaseHUD.default.RadarImage);
		TestString = Repl(TestString, "'", "");
		Divide(TestString,".",PackageLeft, PackageRight);
		TestString = PackageRight;
		Divide(TestString,".",PackageLeft, PackageRight);
		ItemIndex = RadarTexture.FindIndex(PackageRight, , ,);
		RadarTexture.SetIndex(ItemIndex);

		TestString = String(BaseHUD.default.PulseImage);
		TestString = Repl(TestString, "'", "");
		Divide(TestString,".",PackageLeft, PackageRight);
		TestString = PackageRight;
		Divide(TestString,".",PackageLeft, PackageRight);
		ItemIndex = PulseTexture.FindIndex(PackageRight, , ,);
		PulseTexture.SetIndex(ItemIndex);

		if(!Divide(BaseHUD.CurrentKillSound,".",PackageLeft, PackageRight))
		{
			PackageRight = "None";
		}

		ItemIndex = currentMonsterKillSound.FindIndex(PackageRight, , ,);
		currentMonsterKillSound.SetIndex(ItemIndex);
	}
}

function SaveHud()
{
	///local Color TempColor;

	if ( BaseHUD != None )
	{
		//TempColor.R = RadarColorR.GetValue();
		//TempColor.G = RadarColorG.GetValue();
		//TempColor.B = RadarColorB.GetValue();
		//TempColor.A = RadarColorA.GetValue();
		BaseHUD.default.bHideRadar = BaseHUD.bHideRadar;
		BaseHUD.default.CurrentKillSound = BaseHUD.MonsterKillSounds[GetKillSoundIndex()];
		BaseHUD.default.RadarColor = BaseHUD.RadarColor;
		BaseHUD.default.PulseColor = BaseHUD.PulseColor;
		BaseHUD.default.MonsterColor = BaseHUD.MonsterColor;
		BaseHUD.default.PlayerColor = BaseHUD.PlayerColor;
		BaseHUD.default.OwnerColor = BaseHUD.OwnerColor;

		BaseHUD.default.RadarPosX = BaseHUD.RadarPosX;
		BaseHUD.default.RadarPosY = BaseHUD.RadarPosY;

		BaseHUD.default.bAddFriendlyMonstersToPlayerList = BaseHUD.bAddFriendlyMonstersToPlayerList;
		BaseHUD.default.bDisplayMonsterHealthBars = BaseHUD.bDisplayMonsterHealthBars;
		BaseHUD.default.bDisplayMonsterCounter = BaseHUD.bDisplayMonsterCounter;
		BaseHUD.default.bDisplayPlayerList = BaseHUD.bDisplayPlayerList;
		BaseHUD.default.bDisplayNecroPool = BaseHUD.bDisplayNecroPool;
		BaseHUD.default.bNoRadarSound = BaseHUD.bNoRadarSound;
		BaseHUD.default.bClassicRadar = BaseHUD.bClassicRadar;

		BaseHUD.default.bDrawPetInfo = BaseHUD.bDrawPetInfo;

		BaseHUD.default.bStartThirdPerson = BaseHUD.bStartThirdPerson;
		BaseHUD.default.bSpecMonsters = BaseHUD.bSpecMonsters;
		BaseHUD.default.bDisplayBossTimer = BaseHUD.bDisplayBossTimer;
		BaseHUD.default.bDisplayBossNames = BaseHUD.bDisplayBossNames;

		BaseHUD.default.RadarImage = BaseHUD.RadarImage;
		BaseHUD.default.PulseImage = BaseHUD.PulseImage;


		BaseHUD.static.StaticSaveConfig();
		//class'InvasionProHud'.static.StaticSaveConfig();
	}
}

function int GetKillSoundIndex()
{
	local int i;
	local string PackageLeft, PackageRight;

	for(i=0;i<BaseHUD.MonsterKillSounds.Length;i++)
	{
		Divide(BaseHUD.MonsterKillSounds[i],".",PackageLeft, PackageRight);
		if( BaseHUD.MonsterKillSounds[i] ~= currentMonsterKillSound.GetText() || PackageRight ~= currentMonsterKillSound.GetText())
		{
			return i;
		}
	}

	return 0;
}

function int GetRadarImageIndex()
{
	local int i;
	local string PackageLeft, PackageRight, TestString;

	for(i=0;i<BaseHUD.RadarMaterials.Length;i++)
	{
		TestString = String(BaseHUD.RadarMaterials[i]);
		TestString = Repl(TestString, "'", "");
		Divide(TestString,".",PackageLeft, PackageRight);
		TestString = PackageRight;
		Divide(TestString,".",PackageLeft, PackageRight);
		if(PackageRight ~= RadarTexture.GetText())
		{
			return i;
		}
	}

	return 0;
}

function int GetPulseImageIndex()
{
	local int i;
	local string PackageLeft, PackageRight, TestString;

	for(i=0;i<BaseHUD.PulseMaterials.Length;i++)
	{
		TestString = String(BaseHUD.PulseMaterials[i]);
		TestString = Repl(TestString, "'", "");
		Divide(TestString,".",PackageLeft, PackageRight);
		TestString = PackageRight;
		Divide(TestString,".",PackageLeft, PackageRight);
		if(PackageRight ~= PulseTexture.GetText())
		{
			return i;
		}
	}

	return 0;
}

function bool DefaultHud(GUIComponent Sender)
{
	RadarColorR.SetValue(0);
	RadarColorG.SetValue(150);
	RadarColorB.SetValue(100);
	RadarColorA.SetValue(255);

	PulseColorR.SetValue(50);
	PulseColorG.SetValue(160);
	PulseColorB.SetValue(215);
	PulseColorA.SetValue(255);

	MonsterColorR.SetValue(255);
	MonsterColorG.SetValue(255);
	MonsterColorB.SetValue(0);

	PlayerColorR.SetValue(0);
	PlayerColorG.SetValue(255);
	PlayerColorB.SetValue(255);

	OwnerColorR.SetValue(255);
	OwnerColorG.SetValue(255);
	OwnerColorB.SetValue(255);

	bHideRadar.SetComponentValue(False);
	bAddFriendlyMonstersToPlayerList.SetComponentValue(False);
	bNoRadarSound.SetComponentValue(False);
	bClassicRadar.SetComponentValue(False);
	bDisplayMonsterCounter.SetComponentValue(True);
	bDisplayPlayerList.SetComponentValue(True);
	bDisplayNecroPool.SetComponentValue(True);
	bSpecMonsters.SetComponentValue(True);
	bDisplayMonsterHealthBars.SetComponentValue(False);
	bDisplayBossTimer.SetComponentValue(True);
	bDisplayBossNames.SetComponentValue(True);
	bDrawPetInfo.SetComponentValue(True);

	RadarImage.Image = BaseHUD.default.RadarMaterials[1];
	PulseImage.Image = BaseHUD.default.PulseMaterials[1];

	bStartThirdPerson.SetComponentValue(False);

	currentMonsterKillSound.SetIndex(0);

	return true;
}

function bool InternalDraw(Canvas Canvas)
{
	local Color TempColor;

	if ( BaseHUD != None )
	{
		TempColor.R = RadarColorR.GetValue();
		TempColor.G = RadarColorG.GetValue();
		TempColor.B = RadarColorB.GetValue();
		TempColor.A = RadarColorA.GetValue();

		RadarImage.ImageColor = TempColor;
		BaseHUD.RadarColor = TempColor;
		BaseHUD.RadarImage = RadarImage.Image;

		TempColor.R = PulseColorR.GetValue();
		TempColor.G = PulseColorG.GetValue();
		TempColor.B = PulseColorB.GetValue();
		TempColor.A = PulseColorA.GetValue();

		PulseImage.ImageColor = TempColor;
		BaseHUD.PulseImage = PulseImage.Image;
		BaseHUD.PulseColor = TempColor;

		TempColor.R = MonsterColorR.GetValue();
		TempColor.G = MonsterColorG.GetValue();
		TempColor.B = MonsterColorB.GetValue();

		MonsterImage.ImageColor = TempColor;
		BaseHUD.MonsterColor = TempColor;

		TempColor.R = PlayerColorR.GetValue();
		TempColor.G = PlayerColorG.GetValue();
		TempColor.B = PlayerColorB.GetValue();

		PlayerImage.ImageColor = TempColor;
		BaseHUD.PlayerColor = TempColor;

		TempColor.R = OwnerColorR.GetValue();
		TempColor.G = OwnerColorG.GetValue();
		TempColor.B = OwnerColorB.GetValue();

		OwnerImage.ImageColor = TempColor;
		BaseHUD.OwnerColor = TempColor;

		BaseHUD.RadarPosX = RadarPosX.GetValue();
		BaseHUD.RadarPosY = RadarPosY.GetValue();

		BaseHUD.bHideRadar = bHideRadar.IsChecked();
		BaseHUD.bAddFriendlyMonstersToPlayerList = bAddFriendlyMonstersToPlayerList.IsChecked();
		BaseHUD.bDisplayMonsterHealthBars = bDisplayMonsterHealthBars.IsChecked();
		BaseHUD.bDrawPetInfo = bDrawPetInfo.IsChecked();
		BaseHUD.bDisplayMonsterCounter = bDisplayMonsterCounter.IsChecked();
		BaseHUD.bDisplayPlayerList = bDisplayPlayerList.IsChecked();
		BaseHUD.bDisplayNecroPool = bDisplayNecroPool.IsChecked();
		BaseHUD.bNoRadarSound = bNoRadarSound.IsChecked();
		BaseHUD.bClassicRadar = bClassicRadar.IsChecked();

		BaseHUD.bStartThirdPerson = bStartThirdPerson.IsChecked();
		BaseHUD.bSpecMonsters = bSpecMonsters.IsChecked();
		BaseHUD.bDisplayBossTimer = bDisplayBossTimer.IsChecked();
		BaseHUD.bDisplayBossNames = bDisplayBossNames.IsChecked();
	}

	return true;
}

function InternalOnChange(GUIComponent Sender)
{
	if(Sender == RadarTexture)
	{
		RadarImage.Image = BaseHUD.RadarMaterials[GetRadarImageIndex()];
	}

	if(Sender == PulseTexture)
	{
		PulseImage.Image = BaseHUD.PulseMaterials[GetPulseImageIndex()];
	}

	SaveHud();
}

function bool InternalOnClick(GUIComponent Sender)
{
	SaveHud();
	Controller.CloseMenu();
	return true;
}

function bool PlayMonsterKillSound(GUIComponent Sender)
{
	local Sound SoundToPlay;

	if( currentMonsterKillSound.GetText() != "None" )
	{
		SoundToPlay = Sound(DynamicLoadObject(BaseHUD.MonsterKillSounds[GetKillSoundIndex()], class'Sound',true));
		PlayerOwner().PlaySound(SoundToPlay,,,true);
	}

	return true;
}

function InternalOnCreateComponent(GUIComponent NewComp, GUIComponent Sender)
{
	if (currentScrollContainer == Sender)
	{
		if(currentScrollContainer.List != None)
		{
			currentScrollContainer.List.ColumnWidth = 0.45;
			currentScrollContainer.List.bVerticalLayout = true;
			currentScrollContainer.List.bHotTrack = true;
		}
	}

	Super.InternalOnCreateComponent(NewComp,Sender);
}

defaultproperties
{
     Begin Object Class=GUIMultiOptionListBox Name=MyRulesList
         bVisibleWhenEmpty=True
         OnCreateComponent=InvasionProHudConfig.InternalOnCreateComponent
         StyleName="ServerBrowserGrid"
         WinTop=0.100754
         WinLeft=0.438223
         WinWidth=0.519482
         WinHeight=0.827554
         bBoundToParent=True
         bScaleToParent=True
     End Object
     currentScrollContainer=GUIMultiOptionListBox'InvasionProv1_7.InvasionProHudConfig.MyRulesList'

     Begin Object Class=GUILabel Name=cRadarPreviewLabel
         Caption="Radar Preview"
         TextAlign=TXTA_Center
         StyleName="ArrowLeft"
         WinTop=0.108102
         WinLeft=0.073798
         WinWidth=0.350654
         WinHeight=0.099198
         RenderWeight=0.200000
         bScaleToParent=True
     End Object
     RadarPreviewLabel=GUILabel'InvasionProv1_7.InvasionProHudConfig.cRadarPreviewLabel'

     Begin Object Class=GUILabel Name=cColorUpdateLabel
         TextAlign=TXTA_Center
         FontScale=FNS_Small
         StyleName="ArrowLeft"
         WinTop=0.168767
         WinLeft=0.591485
         WinWidth=0.294370
         WinHeight=0.073585
         RenderWeight=0.200000
         OnDraw=InvasionProHudConfig.InternalDraw
     End Object
     ColorUpdateLabel=GUILabel'InvasionProv1_7.InvasionProHudConfig.cColorUpdateLabel'

     Begin Object Class=GUILabel Name=cMonsterLabel
         Caption="Monster"
         FontScale=FNS_Small
         StyleName="ArrowLeft"
         WinTop=0.345139
         WinLeft=0.212687
         WinWidth=0.170098
         WinHeight=0.036698
         RenderWeight=0.200000
         bScaleToParent=True
     End Object
     MonsterLabel=GUILabel'InvasionProv1_7.InvasionProHudConfig.cMonsterLabel'

     Begin Object Class=GUILabel Name=cPlayerLabel
         Caption="Friendly"
         FontScale=FNS_Small
         StyleName="ArrowLeft"
         WinTop=0.580128
         WinLeft=0.162426
         WinWidth=0.250654
         WinHeight=0.038087
         RenderWeight=0.200000
         bScaleToParent=True
     End Object
     PlayerLabel=GUILabel'InvasionProv1_7.InvasionProHudConfig.cPlayerLabel'

     Begin Object Class=GUILabel Name=cOwnerLabel
         Caption="Owner"
         FontScale=FNS_Small
         StyleName="ArrowLeft"
         WinTop=0.498843
         WinLeft=0.266854
         WinWidth=0.156209
         WinHeight=0.043642
         RenderWeight=0.200000
         bScaleToParent=True
     End Object
     OwnerLabel=GUILabel'InvasionProv1_7.InvasionProHudConfig.cOwnerLabel'

     Begin Object Class=GUIImage Name=cPulseImage
         Image=TexRotator'InvasionProTexturesv1_4.HUD.PulseRing02_Rot'
         ImageStyle=ISTY_Scaled
         WinTop=0.243467
         WinLeft=0.080373
         WinWidth=0.338142
         WinHeight=0.557261
         bScaleToParent=True
         bNeverFocus=True
     End Object
     PulseImage=GUIImage'InvasionProv1_7.InvasionProHudConfig.cPulseImage'

     Begin Object Class=GUIImage Name=cRadarImage
         ImageStyle=ISTY_Scaled
         WinTop=0.264098
         WinLeft=0.081445
         WinWidth=0.334991
         WinHeight=0.513895
         bScaleToParent=True
         bNeverFocus=True
     End Object
     RadarImage=GUIImage'InvasionProv1_7.InvasionProHudConfig.cRadarImage'

     Begin Object Class=GUIImage Name=cMonsterImage
         Image=Texture'AW-2004Particles.Weapons.LargeSpot'
         ImageStyle=ISTY_Justified
         ImageRenderStyle=MSTY_Translucent
         WinTop=0.345163
         WinLeft=0.185152
         WinWidth=0.024618
         WinHeight=0.051487
         bScaleToParent=True
         bNeverFocus=True
     End Object
     MonsterImage=GUIImage'InvasionProv1_7.InvasionProHudConfig.cMonsterImage'

     Begin Object Class=GUIImage Name=cPlayerImage
         Image=Texture'AW-2004Particles.Weapons.LargeSpot'
         ImageStyle=ISTY_Justified
         ImageRenderStyle=MSTY_Translucent
         WinTop=0.581973
         WinLeft=0.133883
         WinWidth=0.024618
         WinHeight=0.051487
         bScaleToParent=True
         bNeverFocus=True
     End Object
     PlayerImage=GUIImage'InvasionProv1_7.InvasionProHudConfig.cPlayerImage'

     Begin Object Class=GUIImage Name=cOwnerImage
         Image=Texture'AW-2004Particles.Weapons.LargeSpot'
         ImageStyle=ISTY_Justified
         ImageRenderStyle=MSTY_Translucent
         WinTop=0.499403
         WinLeft=0.233786
         WinWidth=0.031563
         WinHeight=0.044543
         bScaleToParent=True
         bNeverFocus=True
     End Object
     OwnerImage=GUIImage'InvasionProv1_7.InvasionProHudConfig.cOwnerImage'

     RadarStyle(0)="Radar Style 01"
     RadarStyle(1)="Radar Style 02"
     RadarStyle(2)="Radar Style 03"
     RadarStyle(3)="Radar Style 04"
     RadarStyle(4)="Radar Style 05"
     RadarStyle(5)="Radar Style 06"
     RadarStyle(6)="Radar Style 07"
     RadarStyle(7)="Radar Style 08"
     RadarStyle(8)="Radar Style 09"
     RadarStyle(9)="Radar Style 10"
     PulseStyle(0)="Pulse Style 01"
     PulseStyle(1)="Pulse Style 02"
     PulseStyle(2)="Pulse Style 03"
     PulseStyle(3)="Pulse Style 04"
     PulseStyle(4)="Pulse Style 05"
     Begin Object Class=AltSectionBackground Name=InternalFrameImage
         WinTop=0.075000
         WinLeft=0.040000
         WinWidth=0.675859
         WinHeight=0.550976
         bScaleToParent=True
         OnPreDraw=InternalFrameImage.InternalPreDraw
     End Object
     sb_Main=AltSectionBackground'InvasionProv1_7.InvasionProHudConfig.InternalFrameImage'

     Begin Object Class=GUIButton Name=LockedCancelButton
         Caption="Default"
         Hint="Set the defaults for the hud"
         WinTop=0.926722
         WinLeft=0.201518
         WinWidth=0.124311
         WinHeight=0.043494
         TabOrder=32
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProHudConfig.DefaultHud
         OnKeyEvent=LockedCancelButton.InternalOnKeyEvent
     End Object
     b_Cancel=GUIButton'InvasionProv1_7.InvasionProHudConfig.LockedCancelButton'

     Begin Object Class=GUIButton Name=LockedOKButton
         Caption="Ok"
         Hint="Close"
         WinTop=0.927805
         WinLeft=0.091097
         WinWidth=0.105633
         WinHeight=0.043234
         TabOrder=31
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProHudConfig.InternalOnClick
         OnKeyEvent=LockedOKButton.InternalOnKeyEvent
     End Object
     b_OK=GUIButton'InvasionProv1_7.InvasionProHudConfig.LockedOKButton'

     DefaultLeft=0.051126
     DefaultTop=0.027817
     DefaultWidth=0.900000
     DefaultHeight=0.900000
     bAllowedAsLast=True
     InactiveFadeColor=(A=0)
     WinTop=0.051109
     WinLeft=0.053726
     WinWidth=0.900000
     WinHeight=0.900000
     bScaleToParent=True
}
