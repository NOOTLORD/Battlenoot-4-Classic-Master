//==========================================================
//InvasionProMainMenu Copyright © Shaun Goeppinger 2012
//==========================================================
class InvasionProMainMenu extends GUICustomPropertyPage;

var() Automated GUIMultiOptionListBox currentScrollContainer;

var() Automated GUIListSpacer currentHealthAbility;
var() Automated GUIListSpacer currentHealthRegenAbility;
var() Automated GUIListSpacer currentHealthBoostAbility;
var() Automated GUIListSpacer currentSpeedAbility;
var() Automated GUIListSpacer currentSpeedBoostAbility;
var() Automated GUIListSpacer currentDodgeAbility;
var() Automated GUIListSpacer currentDamageReductionAbility;
var() Automated GUIListSpacer currentDamageBonusAbility;
var() Automated GUIListSpacer currentRespawnAbility;
var() Automated GUIListSpacer currentTeleportTimeAbility;
var() Automated GUIListSpacer currentTeleportAbility;
var() Automated GUIListSpacer currentTeleportDistanceAbility;
var() Automated GUIListSpacer currentKillBonusAbility;
var() Automated GUIListSpacer currentXPLeechAbility;
var() Automated GUIListSpacer currentAuraHealAbility;
var() Automated GUIListSpacer currentAuraDamageAbility;
var() Automated GUIListSpacer currentAuraPetAbility;
var() Automated GUIListSpacer currentAuraFrostAbility;
var() Automated GUIListSpacer currentAuraDefenseAbility;
var() Automated GUIListSpacer currentAuraChainLightningAbility;
var() Automated GUIListSpacer currentAuraResurrectAbility;
var() Automated GUIListSpacer currentAuraRetributionAbility;
var() Automated moNumericEdit currentBasePetHealth;
var() Automated moNumericEdit currentHealthMax;
var() Automated moNumericEdit currentHealthIncrease;
var() Automated moNumericEdit currentHealthIncreaseCost;
var() Automated moNumericEdit currentHealthLevel;
var() Automated moNumericEdit currentHealthRegenMax;
var() Automated moNumericEdit currentHealthRegenIncrease;
var() Automated moNumericEdit currentHealthRegenIncreaseCost;
var() Automated moNumericEdit currentHealthRegenLevel;
var() Automated moNumericEdit currentHealthBoostMax;
var() Automated moNumericEdit currentHealthBoostIncrease;
var() Automated moNumericEdit currentHealthBoostIncreaseCost;
var() Automated moNumericEdit currentHealthBoostLevel;
var() Automated moNumericEdit currentBasePetSpeed;
var() Automated moNumericEdit currentSpeedMax;
var() Automated moNumericEdit currentSpeedIncrease;
var() Automated moNumericEdit currentSpeedIncreaseCost;
var() Automated moNumericEdit currentSpeedLevel;
var() Automated moNumericEdit currentSpeedBoostMax;
var() Automated moNumericEdit currentSpeedBoostIncrease;
var() Automated moNumericEdit currentSpeedBoostIncreaseCost;
var() Automated moNumericEdit currentSpeedBoostLevel;
var() Automated moNumericEdit currentDodgeMax;
var() Automated moNumericEdit currentDodgeIncrease;
var() Automated moNumericEdit currentDodgeIncreaseCost;
var() Automated moNumericEdit currentDodgeLevel;
var() Automated moNumericEdit currentDamageReductionMax;
var() Automated moNumericEdit currentDamageReductionIncrease;
var() Automated moNumericEdit currentDamageReductionIncreaseCost;
var() Automated moNumericEdit currentDamageReductionLevel;
var() Automated moNumericEdit currentBasePetDamage;
var() Automated moNumericEdit currentDamageBonusMax;
var() Automated moNumericEdit currentDamageBonusIncrease;
var() Automated moNumericEdit currentDamageBonusIncreaseCost;
var() Automated moNumericEdit currentDamageBonusLevel;
var() Automated moNumericEdit currentRespawnMax;
var() Automated moNumericEdit currentRespawnIncrease;
var() Automated moNumericEdit currentRespawnIncreaseCost;
var() Automated moNumericEdit currentRespawnLevel;
var() Automated moNumericEdit currentBaseTeleportCoolDownTime;
var() Automated moNumericEdit currentTeleportTimeMax;
var() Automated moNumericEdit currentTeleportTimeIncrease;
var() Automated moNumericEdit currentTeleportTimeIncreaseCost;
var() Automated moNumericEdit currentTeleportTimeLevel;
var() Automated moNumericEdit currentTeleportCost;
var() Automated moNumericEdit currentTeleportLevel;
var() Automated moNumericEdit currentBaseTeleportDistance;
var() Automated moNumericEdit currentTeleportDistanceMax;
var() Automated moNumericEdit currentTeleportDistanceIncrease;
var() Automated moNumericEdit currentTeleportDistanceIncreaseCost;
var() Automated moNumericEdit currentTeleportDistanceLevel;
var() Automated moNumericEdit currentKillBonusMax;
var() Automated moNumericEdit currentKillBonusIncrease;
var() Automated moNumericEdit currentKillBonusIncreaseCost;
var() Automated moNumericEdit currentKillBonusLevel;
var() Automated moNumericEdit currentXpLeechCost;
var() Automated moNumericEdit currentXpLeechLevel;
var() Automated moNumericEdit currentAuraHealMax;
var() Automated moNumericEdit currentAuraHealIncrease;
var() Automated moNumericEdit currentAuraHealIncreaseCost;
var() Automated moNumericEdit currentAuraHealRadiusMax;
var() Automated moNumericEdit currentAuraHealRadiusIncrease;
var() Automated moNumericEdit currentAuraHealRadiusIncreaseCost;
var() Automated moCheckBox currentAuraHealDisabled;
var() Automated moNumericEdit currentAuraDamageMax;
var() Automated moNumericEdit currentAuraDamageIncrease;
var() Automated moNumericEdit currentAuraDamageIncreaseCost;
var() Automated moNumericEdit currentAuraDamageRadiusMax;
var() Automated moNumericEdit currentAuraDamageRadiusIncrease;
var() Automated moNumericEdit currentAuraDamageRadiusIncreaseCost;
var() Automated moCheckBox currentAuraDamageDisabled;
var() Automated moNumericEdit currentAuraDefenseMax;
var() Automated moNumericEdit currentAuraDefenseIncrease;
var() Automated moNumericEdit currentAuraDefenseIncreaseCost;
var() Automated moNumericEdit currentAuraDefenseRadiusMax;
var() Automated moNumericEdit currentAuraDefenseRadiusIncrease;
var() Automated moNumericEdit currentAuraDefenseRadiusIncreaseCost;
var() Automated moCheckBox currentAuraDefenseDisabled;
var() Automated moNumericEdit currentAuraFrostMax;
var() Automated moNumericEdit currentAuraFrostIncrease;
var() Automated moNumericEdit currentAuraFrostIncreaseCost;
var() Automated moNumericEdit currentAuraFrostRadiusMax;
var() Automated moNumericEdit currentAuraFrostRadiusIncrease;
var() Automated moNumericEdit currentAuraFrostRadiusIncreaseCost;
var() Automated moCheckBox currentAuraFrostDisabled;
var() Automated moCheckBox currentAuraPetDisabled;
var() Automated moNumericEdit currentAuraChainLightningMax;
var() Automated moNumericEdit currentAuraChainLightningIncrease;
var() Automated moNumericEdit currentAuraChainLightningIncreaseCost;
var() Automated moNumericEdit currentAuraChainLightningRadiusMax;
var() Automated moNumericEdit currentAuraChainLightningRadiusIncrease;
var() Automated moNumericEdit currentAuraChainLightningRadiusIncreaseCost;
var() Automated moCheckBox currentAuraChainLightningDisabled;
var() Automated moNumericEdit currentAuraResurrectMax;
var() Automated moNumericEdit currentAuraResurrectIncrease;
var() Automated moNumericEdit currentAuraResurrectIncreaseCost;
var() Automated moNumericEdit currentAuraResurrectRadiusMax;
var() Automated moNumericEdit currentAuraResurrectRadiusIncrease;
var() Automated moNumericEdit currentAuraResurrectRadiusIncreaseCost;
var() Automated moNumericEdit currentAuraResurrectMinionLifeSpanMin;
var() Automated moNumericEdit currentAuraResurrectMinionLifeSpanMax;
var() Automated moNumericEdit currentAuraResurrectMaxMinions;
var() Automated moCheckBox currentAuraResurrectDisabled;
var() Automated moNumericEdit currentAuraRetributionMax;
var() Automated moNumericEdit currentAuraRetributionIncrease;
var() Automated moNumericEdit currentAuraRetributionIncreaseCost;
var() Automated moCheckBox currentAuraRetributionDisabled;
var() Automated moEditBox currentMonsterStartTag;
var() Automated moEditBox currentPlayerStartTag;
var() Automated moEditBox currentCustomGameTypePrefix;
var() Automated moSlider currentWaveCountDownColourR;
var() Automated moSlider currentWaveCountDownColourG;
var() Automated moSlider currentWaveCountDownColourB;
var() Automated GUIListSpacer currentWaveCountDownColour;
var() color AuraLabelColor;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local bool bTemp;
	local GUIMenuOption MenuOption;

	Super.InitComponent(MyController, MyOwner);

	//resize main window
	sb_Main.Caption = "InvasionPro Configuration";
	sb_Main.bScaleToParent=true;
	sb_Main.WinWidth=0.948281;
	sb_Main.WinHeight=0.918939;
	sb_Main.WinLeft=0.025352;
	sb_Main.WinTop=0.045161;
	//sb_Main.ManageComponent(currentScrollContainer);

	t_WindowTitle.Caption = "";

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

    bTemp = Controller.bCurMenuInitialized;
    Controller.bCurMenuInitialized = False;
	currentScrollContainer.List.ColumnWidth = 0.995;
	currentScrollContainer.List.NumColumns = 2;
    MenuOption = currentScrollContainer.List.AddItem( "XInterface.GUIListHeader",, "General" );
    currentScrollContainer.List.AddItem( "XInterface.GUIListHeader",, "" );
    if ( MenuOption != None )
    {
    	MenuOption.bAutoSizeCaption = True;
    	MenuOption.MyLabel.TextAlign = TXTA_Left;
    	MenuOption.bStandardized = true;
	}

	currentMonsterStartTag = moEditBox(currentScrollContainer.List.AddItem("XInterface.moEditBox", ,"Monster Spawn Tag",true));
    currentMonsterStartTag.ToolTip.SetTip("Input the tag of the navigation points you wish monsters to spawn at (if the nodes exist within the map). Allows you to specify exactly where monsters should spawn.");
	currentPlayerStartTag = moEditBox(currentScrollContainer.List.AddItem("XInterface.moEditBox", ,"Player Spawn Tag",true));
    currentPlayerStartTag.ToolTip.SetTip("Input the tag of the navigation points you wish players to spawn at (if the nodes exist within the map). Allows you to specify exactly where players should spawn.");
	currentCustomGameTypePrefix = moEditBox(currentScrollContainer.List.AddItem("XInterface.moEditBox", ,"Custom Gametype Prefix",true));
    currentCustomGameTypePrefix.ToolTip.SetTip("Input the prefix for a custom gametype you want base spawning to work with.");
	currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

 	currentWaveCountDownColour = GUIListSpacer(currentScrollContainer.List.AddItem("XInterface.GUIListSpacer", ,"Wave Countdown Color",true));
    currentWaveCountDownColour.CaptionWidth = 1;
    currentWaveCountDownColour.MyLabel.OnDraw = InternalDraw;
    currentWaveCountDownColour.MyLabel.Style = None;
 	currentWaveCountDownColourR = moSlider(currentScrollContainer.List.AddItem("XInterface.moSlider", ,"Red",true));
 	currentWaveCountDownColourR.Setup(0, 255, true);
    currentWaveCountDownColourR.ToolTip.SetTip("How much Red for the wave count down color.");
 	currentWaveCountDownColourG = moSlider(currentScrollContainer.List.AddItem("XInterface.moSlider", ,"Green",true));
 	currentWaveCountDownColourG.Setup(0, 255, true);
    currentWaveCountDownColourG.ToolTip.SetTip("How much Green for the wave count down color.");
 	currentWaveCountDownColourB = moSlider(currentScrollContainer.List.AddItem("XInterface.moSlider", ,"Blue",true));
 	currentWaveCountDownColourB.Setup(0, 255, true);
    currentWaveCountDownColourB.ToolTip.SetTip("How much Blue for the wave count down color.");
    MenuOption = currentScrollContainer.List.AddItem( "XInterface.GUIListHeader",, "PET SETTINGS" );
    currentScrollContainer.List.AddItem( "XInterface.GUIListHeader",, "" );
    if ( MenuOption != None )
    {
    	MenuOption.bAutoSizeCaption = True;
    	MenuOption.MyLabel.TextAlign = TXTA_Left;
    	MenuOption.bStandardized = true;
	}

 	currentHealthAbility = GUIListSpacer(currentScrollContainer.List.AddItem("XInterface.GUIListSpacer", ,"Health Ability",true));
    currentHealthAbility.CaptionWidth = 1;
    currentHealthAbility.MyLabel.Style = None;
	currentHealthAbility.MyLabel.TextColor = AuraLabelColor;
	currentHealthAbility.MyLabel.FocusedTextColor = AuraLabelColor;
	currentHealthAbility.MyLabel.TextAlign = TXTA_Left;
	currentHealthAbility.ToolTip.SetTip("The pets base health when it spawns. The health boost ability is applied when the pet spawns. Unlike most other abilities newly purchased health isn't applied until the next time the pet spawns.");
	currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentBasePetHealth = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Base Pet Health",true));
	currentBasePetHealth.Setup(1, 999999, 1);
    currentBasePetHealth.ToolTip.SetTip("How much health pets start with before any modifications or abilities are applied.");

	currentHealthMax = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Health Max",true));
	currentHealthMax.Setup(1, 999999, 1);
    currentHealthMax.ToolTip.SetTip("The maximum amount of health pets can have.");

	currentHealthIncrease = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Health Increase",true));
	currentHealthIncrease.Setup(1, 999999, 1);
    currentHealthIncrease.ToolTip.SetTip("How much this ability is increased by each time it is purchased.");

	currentHealthIncreaseCost = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Health Increase Cost",true));
	currentHealthIncreaseCost.Setup(0, 999999, 1);
    currentHealthIncreaseCost.ToolTip.SetTip("How much it costs to increase this ability.");

	currentHealthLevel = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Health Unlock Level",true));
	currentHealthLevel.Setup(0, 999999, 1);
    currentHealthLevel.ToolTip.SetTip("The level this ability is available at.");
    currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

 	currentHealthRegenAbility = GUIListSpacer(currentScrollContainer.List.AddItem("XInterface.GUIListSpacer", ,"Health Regen Ability",true));
    currentHealthRegenAbility.CaptionWidth = 1;
    currentHealthRegenAbility.MyLabel.Style = None;
	currentHealthRegenAbility.MyLabel.TextColor = AuraLabelColor;
	currentHealthRegenAbility.MyLabel.FocusedTextColor = AuraLabelColor;
	currentHealthRegenAbility.MyLabel.TextAlign = TXTA_Left;
	currentHealthRegenAbility.ToolTip.SetTip("This ability allows the pet to regenerate health every second.");
	currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentHealthRegenMax = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Health Regen Max",true));
	currentHealthRegenMax.Setup(1, 999999, 1);
    currentHealthRegenMax.ToolTip.SetTip("The maximum amount of health regenerated per second.");

	currentHealthRegenIncrease = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Health Regen Increase",true));
	currentHealthRegenIncrease.Setup(1, 999999, 1);
    currentHealthRegenIncrease.ToolTip.SetTip("How much this ability is increased by each time it is purchased.");

	currentHealthRegenIncreaseCost = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Health Regen Increase Cost",true));
	currentHealthRegenIncreaseCost.Setup(0, 999999, 1);
    currentHealthRegenIncreaseCost.ToolTip.SetTip("How much it costs to increase this ability.");

	currentHealthRegenLevel = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Health Regen Unlock Level",true));
	currentHealthRegenLevel.Setup(0, 999999, 1);
    currentHealthRegenLevel.ToolTip.SetTip("The level this ability is available at.");

 	currentHealthBoostAbility = GUIListSpacer(currentScrollContainer.List.AddItem("XInterface.GUIListSpacer", ,"Health Boost Ability",true));
    currentHealthBoostAbility.CaptionWidth = 1;
    currentHealthBoostAbility.MyLabel.Style = None;
	currentHealthBoostAbility.MyLabel.TextColor = AuraLabelColor;
	currentHealthBoostAbility.MyLabel.FocusedTextColor = AuraLabelColor;
	currentHealthBoostAbility.MyLabel.TextAlign = TXTA_Left;
	currentHealthBoostAbility.ToolTip.SetTip("Health boost increases the pets health by an additional % of the pets base health");
	currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentHealthBoostMax = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Health Boost Max",true));
	currentHealthBoostMax.Setup(1, 100, 1);
    currentHealthBoostMax.ToolTip.SetTip("The maximum percentage of health boost available.");

	currentHealthBoostIncrease = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Health Boost Increase",true));
	currentHealthBoostIncrease.Setup(1, 999999, 1);
    currentHealthBoostIncrease.ToolTip.SetTip("How much this ability is increased by each time it is purchased.");

	currentHealthBoostIncreaseCost = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Health Boost Increase Cost",true));
	currentHealthBoostIncreaseCost.Setup(0, 999999, 1);
    currentHealthBoostIncreaseCost.ToolTip.SetTip("How much it costs to increase this ability.");

	currentHealthBoostLevel = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Health Boost Unlock Level",true));
	currentHealthBoostLevel.Setup(0, 999999, 1);
    currentHealthBoostLevel.ToolTip.SetTip("The level this ability is available at.");

 	currentSpeedAbility = GUIListSpacer(currentScrollContainer.List.AddItem("XInterface.GUIListSpacer", ,"Speed Ability",true));
    currentSpeedAbility.CaptionWidth = 1;
    currentSpeedAbility.MyLabel.Style = None;
	currentSpeedAbility.MyLabel.TextColor = AuraLabelColor;
	currentSpeedAbility.MyLabel.FocusedTextColor = AuraLabelColor;
	currentSpeedAbility.MyLabel.TextAlign = TXTA_Left;
	currentSpeedAbility.ToolTip.SetTip("The pets base speed when it spawns. Speed abilities are applied to pets immediately upon purchase.");
	currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentBasePetSpeed = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Base Pet Speed",true));
	currentBasePetSpeed.Setup(0, 999999, 1);
    currentBasePetSpeed.ToolTip.SetTip("How much speed pets start with before any modifications or abilities are applied.");

	currentSpeedMax = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Speed Max",true));
	currentSpeedMax.Setup(1, 999999, 1);
    currentSpeedMax.ToolTip.SetTip("The maximum amount of speed a pet can have.");

	currentSpeedIncrease = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Speed Increase",true));
	currentSpeedIncrease.Setup(1, 999999, 1);
    currentSpeedIncrease.ToolTip.SetTip("How much this ability is increased by each time it is purchased.");

	currentSpeedIncreaseCost = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Speed Increase Cost",true));
	currentSpeedIncreaseCost.Setup(0, 999999, 1);
    currentSpeedIncreaseCost.ToolTip.SetTip("How much it costs to increase this ability.");

	currentSpeedLevel = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Speed Unlock Level",true));
	currentSpeedLevel.Setup(0, 999999, 1);
    currentSpeedLevel.ToolTip.SetTip("The level this ability is available at.");
    currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

 	currentSpeedBoostAbility = GUIListSpacer(currentScrollContainer.List.AddItem("XInterface.GUIListSpacer", ,"Speed Boost Ability",true));
    currentSpeedBoostAbility.CaptionWidth = 1;
    currentSpeedBoostAbility.MyLabel.Style = None;
	currentSpeedBoostAbility.MyLabel.TextColor = AuraLabelColor;
	currentSpeedBoostAbility.MyLabel.FocusedTextColor = AuraLabelColor;
	currentSpeedBoostAbility.MyLabel.TextAlign = TXTA_Left;
	currentSpeedBoostAbility.ToolTip.SetTip("Speed boost gives an additional % of the pets base speed.");
	currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentSpeedBoostMax = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Speed Boost Max",true));
	currentSpeedBoostMax.Setup(1, 100, 1);
    currentSpeedBoostMax.ToolTip.SetTip("The maximum percentage of speed boost available.");

	currentSpeedBoostIncrease = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Speed Boost Increase",true));
	currentSpeedBoostIncrease.Setup(1, 999999, 1);
    currentSpeedBoostIncrease.ToolTip.SetTip("How much this ability is increased by each time it is purchased.");

	currentSpeedBoostIncreaseCost = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Speed Boost Increase Cost",true));
	currentSpeedBoostIncreaseCost.Setup(0, 999999, 1);
    currentSpeedBoostIncreaseCost.ToolTip.SetTip("How much it costs to increase this ability.");

	currentSpeedBoostLevel = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Speed Boost Unlock Level",true));
	currentSpeedBoostLevel.Setup(0, 999999, 1);
    currentSpeedBoostLevel.ToolTip.SetTip("The level this ability is available at.");

 	currentDodgeAbility = GUIListSpacer(currentScrollContainer.List.AddItem("XInterface.GUIListSpacer", ,"Dodge Ability",true));
    currentDodgeAbility.CaptionWidth = 1;
    currentDodgeAbility.MyLabel.Style = None;
	currentDodgeAbility.MyLabel.TextColor = AuraLabelColor;
	currentDodgeAbility.MyLabel.FocusedTextColor = AuraLabelColor;
	currentDodgeAbility.MyLabel.TextAlign = TXTA_Left;
	currentDodgeAbility.ToolTip.SetTip("Increasing the dodge skill increases the pets ability to avoid attacks.");
	currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentDodgeMax = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Dodge Max",true));
	currentDodgeMax.Setup(1, 999999, 1);
    currentDodgeMax.ToolTip.SetTip("The maximum amount of dodge available.");

	currentDodgeIncrease = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Dodge Increase",true));
	currentDodgeIncrease.Setup(1, 999999, 1);
    currentDodgeIncrease.ToolTip.SetTip("How much this ability is increased by each time it is purchased.");

	currentDodgeIncreaseCost = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Dodge Increase Cost",true));
	currentDodgeIncreaseCost.Setup(0, 999999, 1);
    currentDodgeIncreaseCost.ToolTip.SetTip("How much it costs to increase this ability.");

	currentDodgeLevel = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Dodge Unlock Level",true));
	currentDodgeLevel.Setup(0, 999999, 1);
    currentDodgeLevel.ToolTip.SetTip("The level this ability is available at.");

 	currentDamageReductionAbility = GUIListSpacer(currentScrollContainer.List.AddItem("XInterface.GUIListSpacer", ,"Armor Ability",true));
    currentDamageReductionAbility.CaptionWidth = 1;
    currentDamageReductionAbility.MyLabel.Style = None;
	currentDamageReductionAbility.MyLabel.TextColor = AuraLabelColor;
	currentDamageReductionAbility.MyLabel.FocusedTextColor = AuraLabelColor;
	currentDamageReductionAbility.MyLabel.TextAlign = TXTA_Left;
	currentDamageReductionAbility.ToolTip.SetTip("Pet armor reduces the amount of damage the pet receives from attacks by a percentage of the damage received.");
	currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentDamageReductionMax = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Armor Max",true));
	currentDamageReductionMax.Setup(1, 100, 1);
    currentDamageReductionMax.ToolTip.SetTip("The maximum percentage of armor available.");

	currentDamageReductionIncrease = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Armor Increase",true));
	currentDamageReductionIncrease.Setup(1, 999999, 1);
    currentDamageReductionIncrease.ToolTip.SetTip("How much this ability is increased by each time it is purchased.");

	currentDamageReductionIncreaseCost = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Armor Increase Cost",true));
	currentDamageReductionIncreaseCost.Setup(0, 999999, 1);
    currentDamageReductionIncreaseCost.ToolTip.SetTip("How much it costs to increase this ability.");

	currentDamageReductionLevel = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Armor Unlock Level",true));
	currentDamageReductionLevel.Setup(0, 999999, 1);
    currentDamageReductionLevel.ToolTip.SetTip("The level this ability is available at.");

	currentDamageBonusAbility = GUIListSpacer(currentScrollContainer.List.AddItem("XInterface.GUIListSpacer", ,"Damage Bonus Ability",true));
    currentDamageBonusAbility.CaptionWidth = 1;
    currentDamageBonusAbility.MyLabel.Style = None;
	currentDamageBonusAbility.MyLabel.TextColor = AuraLabelColor;
	currentDamageBonusAbility.MyLabel.FocusedTextColor = AuraLabelColor;
	currentDamageBonusAbility.MyLabel.TextAlign = TXTA_Left;
	currentDamageBonusAbility.ToolTip.SetTip("Damage bonus increases the damage output of the pet by a percentage of the pets base damage..");
	currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentBasePetDamage = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Base Pet Damage",true));
	currentBasePetDamage.Setup(0, 999999, 1);
    currentBasePetDamage.ToolTip.SetTip("How much speed pets start with before any modifications or abilities are applied.");

	currentDamageBonusMax = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Damage Bonus Max",true));
	currentDamageBonusMax.Setup(1, 100, 1);
    currentDamageBonusMax.ToolTip.SetTip("The maximum percentage of damage bonus available.");

	currentDamageBonusIncrease = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Damage Bonus Increase",true));
	currentDamageBonusIncrease.Setup(1, 999999, 1);
    currentDamageBonusIncrease.ToolTip.SetTip("How much this ability is increased by each time it is purchased.");

	currentDamageBonusIncreaseCost = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Damage Bonus Increase Cost",true));
	currentDamageBonusIncreaseCost.Setup(0, 999999, 1);
    currentDamageBonusIncreaseCost.ToolTip.SetTip("How much it costs to increase this ability.");

	currentDamageBonusLevel = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Damage Bonus Unlock Level",true));
	currentDamageBonusLevel.Setup(0, 999999, 1);
    currentDamageBonusLevel.ToolTip.SetTip("The level this ability is available at.");
    currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentRespawnAbility = GUIListSpacer(currentScrollContainer.List.AddItem("XInterface.GUIListSpacer", ,"Respawn Ability",true));
    currentRespawnAbility.CaptionWidth = 1;
    currentRespawnAbility.MyLabel.Style = None;
	currentRespawnAbility.MyLabel.TextColor = AuraLabelColor;
	currentRespawnAbility.MyLabel.FocusedTextColor = AuraLabelColor;
	currentRespawnAbility.MyLabel.TextAlign = TXTA_Left;
	currentRespawnAbility.ToolTip.SetTip("This ability reduces the respawn time of the pet.");
	currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentRespawnMax = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Respawn Max",true));
	currentRespawnMax.Setup(1, 100, 1);
    currentRespawnMax.ToolTip.SetTip("The maximum percentage of respawn time available.");

	currentRespawnIncrease = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Respawn Increase",true));
	currentRespawnIncrease.Setup(1, 999999, 1);
    currentRespawnIncrease.ToolTip.SetTip("How much this ability is increased by each time it is purchased.");

	currentRespawnIncreaseCost = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Respawn Increase Cost",true));
	currentRespawnIncreaseCost.Setup(0, 999999, 1);
    currentRespawnIncreaseCost.ToolTip.SetTip("How much it costs to increase this ability.");

	currentRespawnLevel = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Respawn Unlock Level",true));
	currentRespawnLevel.Setup(0, 999999, 1);
    currentRespawnLevel.ToolTip.SetTip("The level this ability is available at.");

	currentTeleportAbility = GUIListSpacer(currentScrollContainer.List.AddItem("XInterface.GUIListSpacer", ,"Teleport Ability",true));
    currentTeleportAbility.CaptionWidth = 1;
    currentTeleportAbility.MyLabel.Style = None;
	currentTeleportAbility.MyLabel.TextColor = AuraLabelColor;
	currentTeleportAbility.MyLabel.FocusedTextColor = AuraLabelColor;
	currentTeleportAbility.MyLabel.TextAlign = TXTA_Left;
	currentTeleportAbility.ToolTip.SetTip("This ability allows the pet to teleport to and from enemies, as well as to and from players it may be protecting, and other goals.");
	currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentTeleportCost = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Teleport Cost",true));
	currentTeleportCost.Setup(0, 999999, 1);
    currentTeleportCost.ToolTip.SetTip("How much it costs to purchase this ability.");

	currentTeleportLevel = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Teleport Unlock Level",true));
	currentTeleportLevel.Setup(0, 999999, 1);
    currentTeleportLevel.ToolTip.SetTip("The level this ability is available at.");

	currentTeleportTimeAbility = GUIListSpacer(currentScrollContainer.List.AddItem("XInterface.GUIListSpacer", ,"Teleport Time Ability",true));
    currentTeleportTimeAbility.CaptionWidth = 1;
    currentTeleportTimeAbility.MyLabel.Style = None;
	currentTeleportTimeAbility.MyLabel.TextColor = AuraLabelColor;
	currentTeleportTimeAbility.MyLabel.FocusedTextColor = AuraLabelColor;
	currentTeleportTimeAbility.MyLabel.TextAlign = TXTA_Left;
	currentTeleportTimeAbility.ToolTip.SetTip("Each time the pet teleports it must wait for the spell to cooldown before it can use it again. this ability reduces the amount of time the pet has to wait in-between teleports.");
	currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentBaseTeleportCoolDownTime = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Base Teleport Time",true));
	currentBaseTeleportCoolDownTime.Setup(0, 999999, 1);
    currentBaseTeleportCoolDownTime.ToolTip.SetTip("How long pets must wait in-between teleports before any modifications or abilities are applied.");

	currentTeleportTimeMax = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Teleport Time Max",true));
	currentTeleportTimeMax.Setup(1, 100, 1);
    currentTeleportTimeMax.ToolTip.SetTip("The maximum percentage of teleport time time available.");

	currentTeleportTimeIncrease = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Teleport Time Increase",true));
	currentTeleportTimeIncrease.Setup(1, 999999, 1);
    currentTeleportTimeIncrease.ToolTip.SetTip("How much this ability is increased by each time it is purchased.");

	currentTeleportTimeIncreaseCost = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Teleport Time Increase Cost",true));
	currentTeleportTimeIncreaseCost.Setup(0, 999999, 1);
    currentTeleportTimeIncreaseCost.ToolTip.SetTip("How much it costs to increase this ability.");

	currentTeleportTimeLevel = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Teleport Time Unlock Level",true));
	currentTeleportTimeLevel.Setup(0, 999999, 1);
    currentTeleportTimeLevel.ToolTip.SetTip("The level this ability is available at.");
    currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentTeleportDistanceAbility = GUIListSpacer(currentScrollContainer.List.AddItem("XInterface.GUIListSpacer", ,"Teleport Distance Ability",true));
    currentTeleportDistanceAbility.CaptionWidth = 1;
    currentTeleportDistanceAbility.MyLabel.Style = None;
	currentTeleportDistanceAbility.MyLabel.TextColor = AuraLabelColor;
	currentTeleportDistanceAbility.MyLabel.FocusedTextColor = AuraLabelColor;
	currentTeleportDistanceAbility.MyLabel.TextAlign = TXTA_Left;
	currentTeleportDistanceAbility.ToolTip.SetTip("This ability increases the distance the pet can teleport.");
	currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentBaseTeleportDistance = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Base Teleport Distance",true));
	currentBaseTeleportDistance.Setup(0, 999999, 1);
    currentBaseTeleportDistance.ToolTip.SetTip("How far pets can teleport before any modifications or abilities are applied.");

	currentTeleportDistanceMax = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Teleport Distance Max",true));
	currentTeleportDistanceMax.Setup(1, 999999, 1);
    currentTeleportDistanceMax.ToolTip.SetTip("The maximum distance a pet can teleport.");

	currentTeleportDistanceIncrease = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Teleport Distance Increase",true));
	currentTeleportDistanceIncrease.Setup(1, 999999, 1);
    currentTeleportDistanceIncrease.ToolTip.SetTip("How much this ability is increased by each time it is purchased.");

	currentTeleportDistanceIncreaseCost = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Teleport Distance Increase Cost",true));
	currentTeleportDistanceIncreaseCost.Setup(0, 999999, 1);
    currentTeleportDistanceIncreaseCost.ToolTip.SetTip("How much it costs to increase this ability.");

	currentTeleportDistanceLevel = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Teleport Distance Unlock Level",true));
	currentTeleportDistanceLevel.Setup(0, 999999, 1);
    currentTeleportDistanceLevel.ToolTip.SetTip("The level this ability is available at.");
    currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentXpLeechAbility = GUIListSpacer(currentScrollContainer.List.AddItem("XInterface.GUIListSpacer", ,"Experience Leech Ability",true));
    currentXpLeechAbility.CaptionWidth = 1;
    currentXpLeechAbility.MyLabel.Style = None;
	currentXpLeechAbility.MyLabel.TextColor = AuraLabelColor;
	currentXpLeechAbility.MyLabel.FocusedTextColor = AuraLabelColor;
	currentXpLeechAbility.MyLabel.TextAlign = TXTA_Left;
	currentXpLeechAbility.ToolTip.SetTip("This ability allows the pets owner to earn experience points for the pet. Damage done by the owner will count as pet experience.");
	currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentXpLeechCost = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Experience Leech Cost",true));
	currentXpLeechCost.Setup(0, 999999, 1);
    currentXpLeechCost.ToolTip.SetTip("How much it costs to purchase this ability.");

	currentXpLeechLevel = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Experience Leech Unlock Level",true));
	currentXpLeechLevel.Setup(0, 999999, 1);
    currentXpLeechLevel.ToolTip.SetTip("The level this ability is available at.");

	currentKillBonusAbility = GUIListSpacer(currentScrollContainer.List.AddItem("XInterface.GUIListSpacer", ,"Kill Bonus Ability",true));
    currentKillBonusAbility.CaptionWidth = 1;
    currentKillBonusAbility.MyLabel.Style = None;
	currentKillBonusAbility.MyLabel.TextColor = AuraLabelColor;
	currentKillBonusAbility.MyLabel.FocusedTextColor = AuraLabelColor;
	currentKillBonusAbility.MyLabel.TextAlign = TXTA_Left;
	currentKillBonusAbility.ToolTip.SetTip("This ability allows the pet to earn additional points per kill.");
	currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentKillBonusMax = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Kill Bonus Max",true));
	currentKillBonusMax.Setup(1, 999999, 1);
    currentKillBonusMax.ToolTip.SetTip("The maximum amount of bonus points pets receive for landing the killing blow on other monsters.");

	currentKillBonusIncrease = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Kill Bonus Increase",true));
	currentKillBonusIncrease.Setup(1, 999999, 1);
    currentKillBonusIncrease.ToolTip.SetTip("How much this ability is increased by each time it is purchased.");

	currentKillBonusIncreaseCost = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Kill Bonus Increase Cost",true));
	currentKillBonusIncreaseCost.Setup(0, 999999, 1);
    currentKillBonusIncreaseCost.ToolTip.SetTip("How much it costs to increase this ability.");

	currentKillBonusLevel = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Kill Bonus Unlock Level",true));
	currentKillBonusLevel.Setup(0, 999999, 1);
    currentKillBonusLevel.ToolTip.SetTip("The level this ability is available at.");

	currentAuraHealAbility = GUIListSpacer(currentScrollContainer.List.AddItem("XInterface.GUIListSpacer", ,"Heal Aura",true));
    currentAuraHealAbility.CaptionWidth = 1;
    currentAuraHealAbility.MyLabel.Style = None;
	currentAuraHealAbility.MyLabel.TextColor = AuraLabelColor;
	currentAuraHealAbility.MyLabel.FocusedTextColor = AuraLabelColor;
	currentAuraHealAbility.MyLabel.TextAlign = TXTA_Left;
	currentAuraHealAbility.ToolTip.SetTip("The heal aura allows the pet to heal all nearby friendly players and pets every second, the amount and radius is upgradable.");
	currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentAuraHealMax = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Heal Amount Max",true));
	currentAuraHealMax.Setup(1, 999999, 1);
    currentAuraHealMax.ToolTip.SetTip("The maximum amount of health healed by the pet per second.");

	currentAuraHealIncrease = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Heal Amount Increase",true));
	currentAuraHealIncrease.Setup(1, 999999, 1);
    currentAuraHealIncrease.ToolTip.SetTip("How much this ability is increased by each time it is purchased.");

	currentAuraHealIncreaseCost = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Heal Amount Increase Cost",true));
	currentAuraHealIncreaseCost.Setup(0, 999999, 1);
    currentAuraHealIncreaseCost.ToolTip.SetTip("How much it costs to increase this ability.");

	currentAuraHealRadiusMax = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Heal Radius Max",true));
	currentAuraHealRadiusMax.Setup(0, 999999, 1);
    currentAuraHealRadiusMax.ToolTip.SetTip("The maximum radius distance this ability has.");

	currentAuraHealRadiusIncrease = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Heal Radius Increase",true));
	currentAuraHealRadiusIncrease.Setup(1, 999999, 1);
    currentAuraHealRadiusIncrease.ToolTip.SetTip("How much the radius of this ability is increased by each time it is purchased.");

	currentAuraHealRadiusIncreaseCost = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Heal Radius Increase Cost",true));
	currentAuraHealRadiusIncreaseCost.Setup(0, 999999, 1);
    currentAuraHealRadiusIncreaseCost.ToolTip.SetTip("How much it costs to increase the radius of this ability.");

	currentAuraHealDisabled = moCheckBox(currentScrollContainer.List.AddItem("XInterface.moCheckBox", ,"Disable Heal Aura",true));
    currentAuraHealDisabled.ToolTip.SetTip("Check to disable this aura.");
	currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentAuraDamageAbility = GUIListSpacer(currentScrollContainer.List.AddItem("XInterface.GUIListSpacer", ,"Damage Aura",true));
    currentAuraDamageAbility.CaptionWidth = 1;
    currentAuraDamageAbility.MyLabel.Style = None;
	currentAuraDamageAbility.MyLabel.TextColor = AuraLabelColor;
	currentAuraDamageAbility.MyLabel.FocusedTextColor = AuraLabelColor;
	currentAuraDamageAbility.MyLabel.TextAlign = TXTA_Left;
	currentAuraDamageAbility.ToolTip.SetTip("The damage aura allows the pet to damage all nearby enemies every second, the amount and radius is upgradable.");
	currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentAuraDamageMax = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Damage Amount Max",true));
	currentAuraDamageMax.Setup(1, 999999, 1);
    currentAuraDamageMax.ToolTip.SetTip("The maximum amount of damage per second.");

	currentAuraDamageIncrease = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Damage Amount Increase",true));
	currentAuraDamageIncrease.Setup(1, 999999, 1);
    currentAuraDamageIncrease.ToolTip.SetTip("How much this ability is increased by each time it is purchased.");

	currentAuraDamageIncreaseCost = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Damage Amount Increase Cost",true));
	currentAuraDamageIncreaseCost.Setup(0, 999999, 1);
    currentAuraDamageIncreaseCost.ToolTip.SetTip("How much it costs to increase this ability.");

	currentAuraDamageRadiusMax = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Damage Radius Max",true));
	currentAuraDamageRadiusMax.Setup(0, 999999, 1);
    currentAuraDamageRadiusMax.ToolTip.SetTip("The maximum radius distance this ability has.");

	currentAuraDamageRadiusIncrease = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Damage Radius Increase",true));
	currentAuraDamageRadiusIncrease.Setup(1, 999999, 1);
    currentAuraDamageRadiusIncrease.ToolTip.SetTip("How much the radius of this ability is increased by each time it is purchased.");

	currentAuraDamageRadiusIncreaseCost = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Damage Radius Increase Cost",true));
	currentAuraDamageRadiusIncreaseCost.Setup(0, 999999, 1);
    currentAuraDamageRadiusIncreaseCost.ToolTip.SetTip("How much it costs to increase the radius of this ability.");

	currentAuraDamageDisabled = moCheckBox(currentScrollContainer.List.AddItem("XInterface.moCheckBox", ,"Disable Damage Aura",true));
    currentAuraDamageDisabled.ToolTip.SetTip("Check to disable this aura.");
	currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentAuraFrostAbility = GUIListSpacer(currentScrollContainer.List.AddItem("XInterface.GUIListSpacer", ,"Frost Aura",true));
    currentAuraFrostAbility.CaptionWidth = 1;
    currentAuraFrostAbility.MyLabel.Style = None;
	currentAuraFrostAbility.MyLabel.TextColor = AuraLabelColor;
	currentAuraFrostAbility.MyLabel.FocusedTextColor = AuraLabelColor;
	currentAuraFrostAbility.MyLabel.TextAlign = TXTA_Left;
	currentAuraFrostAbility.ToolTip.SetTip("The frost aura allows the pet to slow down all nearby enemies every few seconds by a percentage of the enemies speed, the amount and radius is upgradable.");
	currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentAuraFrostMax = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Frost Amount Max",true));
	currentAuraFrostMax.Setup(1, 100, 1);
    currentAuraFrostMax.ToolTip.SetTip("The maximum of speed decrease purchasable.");

	currentAuraFrostIncrease = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Frost Amount Increase",true));
	currentAuraFrostIncrease.Setup(1, 999999, 1);
    currentAuraFrostIncrease.ToolTip.SetTip("How much this ability is increased by each time it is purchased.");

	currentAuraFrostIncreaseCost = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Frost Amount Increase Cost",true));
	currentAuraFrostIncreaseCost.Setup(0, 999999, 1);
    currentAuraFrostIncreaseCost.ToolTip.SetTip("How much it costs to increase this ability.");

	currentAuraFrostRadiusMax = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Frost Radius Max",true));
	currentAuraFrostRadiusMax.Setup(0, 999999, 1);
    currentAuraFrostRadiusMax.ToolTip.SetTip("The maximum radius distance this ability has.");

	currentAuraFrostRadiusIncrease = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Frost Radius Increase",true));
	currentAuraFrostRadiusIncrease.Setup(1, 999999, 1);
    currentAuraFrostRadiusIncrease.ToolTip.SetTip("How much the radius of this ability is increased by each time it is purchased.");

	currentAuraFrostRadiusIncreaseCost = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Frost Radius Increase Cost",true));
	currentAuraFrostRadiusIncreaseCost.Setup(0, 999999, 1);
    currentAuraFrostRadiusIncreaseCost.ToolTip.SetTip("How much it costs to increase the radius of this ability.");

	currentAuraFrostDisabled = moCheckBox(currentScrollContainer.List.AddItem("XInterface.moCheckBox", ,"Disable Frost Aura",true));
    currentAuraFrostDisabled.ToolTip.SetTip("Check to disable this aura.");
	currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentAuraDefenseAbility = GUIListSpacer(currentScrollContainer.List.AddItem("XInterface.GUIListSpacer", ,"Defense Aura",true));
    currentAuraDefenseAbility.CaptionWidth = 1;
    currentAuraDefenseAbility.MyLabel.Style = None;
	currentAuraDefenseAbility.MyLabel.TextColor = AuraLabelColor;
	currentAuraDefenseAbility.MyLabel.FocusedTextColor = AuraLabelColor;
	currentAuraDefenseAbility.MyLabel.TextAlign = TXTA_Left;
	currentAuraDefenseAbility.ToolTip.SetTip("The defense aura allows the pet to deflect enemy projectiles, the pet also receives a shield which absorbs damage and slowly regenerates. The deflection radius and shield amount is upgradable.");
	currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentAuraDefenseMax = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Shield Amount Max",true));
	currentAuraDefenseMax.Setup(1, 99999, 1);
    currentAuraDefenseMax.ToolTip.SetTip("The maximum amount of shield power purchasable.");

	currentAuraDefenseIncrease = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Shield Amount Increase",true));
	currentAuraDefenseIncrease.Setup(1, 999999, 1);
    currentAuraDefenseIncrease.ToolTip.SetTip("How much this ability is increased by each time it is purchased.");

	currentAuraDefenseIncreaseCost = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Shield Amount Increase Cost",true));
	currentAuraDefenseIncreaseCost.Setup(0, 999999, 1);
    currentAuraDefenseIncreaseCost.ToolTip.SetTip("How much it costs to increase this ability.");

	currentAuraDefenseRadiusMax = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Deflection Radius Max",true));
	currentAuraDefenseRadiusMax.Setup(0, 999999, 1);
    currentAuraDefenseRadiusMax.ToolTip.SetTip("The maximum radius distance this ability has.");

	currentAuraDefenseRadiusIncrease = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Deflection Radius Increase",true));
	currentAuraDefenseRadiusIncrease.Setup(1, 999999, 1);
    currentAuraDefenseRadiusIncrease.ToolTip.SetTip("How much the radius of this ability is increased by each time it is purchased.");

	currentAuraDefenseRadiusIncreaseCost = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Deflection Radius Increase Cost",true));
	currentAuraDefenseRadiusIncreaseCost.Setup(0, 999999, 1);
    currentAuraDefenseRadiusIncreaseCost.ToolTip.SetTip("How much it costs to increase the radius of this ability.");

	currentAuraDefenseDisabled = moCheckBox(currentScrollContainer.List.AddItem("XInterface.moCheckBox", ,"Disable Defense Aura",true));
    currentAuraDefenseDisabled.ToolTip.SetTip("Check to disable this aura.");
	currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentAuraPetAbility = GUIListSpacer(currentScrollContainer.List.AddItem("XInterface.GUIListSpacer", ,"Pet Aura",true));
    currentAuraPetAbility.CaptionWidth = 1;
    currentAuraPetAbility.MyLabel.Style = None;
	currentAuraPetAbility.MyLabel.TextColor = AuraLabelColor;
	currentAuraPetAbility.MyLabel.FocusedTextColor = AuraLabelColor;
	currentAuraPetAbility.MyLabel.TextAlign = TXTA_Left;
	currentAuraPetAbility.ToolTip.SetTip("This ability gives the pet a companion to fight along side it, the companion pet inherits most of the pets abilities but cannot use auras or teleport.");
	currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentAuraPetDisabled = moCheckBox(currentScrollContainer.List.AddItem("XInterface.moCheckBox", ,"Disable Pet Aura",true));
    currentAuraPetDisabled.ToolTip.SetTip("Check to disable this aura.");
    currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentAuraChainLightningAbility = GUIListSpacer(currentScrollContainer.List.AddItem("XInterface.GUIListSpacer", ,"Chain Lightning Aura",true));
    currentAuraChainLightningAbility.CaptionWidth = 1;
    currentAuraChainLightningAbility.MyLabel.Style = None;
	currentAuraChainLightningAbility.MyLabel.TextColor = AuraLabelColor;
	currentAuraChainLightningAbility.MyLabel.FocusedTextColor = AuraLabelColor;
	currentAuraChainLightningAbility.MyLabel.TextAlign = TXTA_Left;
	currentAuraChainLightningAbility.ToolTip.SetTip("The chain lightning aura gives the pet a chance to cause a chain lightning effect when the pet causes damage, the damage and chain lightning range is upgradable.");
	currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentAuraChainLightningMax = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Lightning Damage Max",true));
	currentAuraChainLightningMax.Setup(1, 999999, 1);
    currentAuraChainLightningMax.ToolTip.SetTip("The maximum amount of damage the chain lightning strike does.");

	currentAuraChainLightningIncrease = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Lightning Damage Increase",true));
	currentAuraChainLightningIncrease.Setup(1, 999999, 1);
    currentAuraChainLightningIncrease.ToolTip.SetTip("How much this ability is increased by each time it is purchased.");

	currentAuraChainLightningIncreaseCost = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Lightning Damage Increase Cost",true));
	currentAuraChainLightningIncreaseCost.Setup(0, 999999, 1);
    currentAuraChainLightningIncreaseCost.ToolTip.SetTip("How much it costs to increase this ability.");

	currentAuraChainLightningRadiusMax = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Lightning Radius Max",true));
	currentAuraChainLightningRadiusMax.Setup(0, 999999, 1);
    currentAuraChainLightningRadiusMax.ToolTip.SetTip("The maximum radius distance this ability has.");

	currentAuraChainLightningRadiusIncrease = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Lightning Radius Increase",true));
	currentAuraChainLightningRadiusIncrease.Setup(1, 999999, 1);
    currentAuraChainLightningRadiusIncrease.ToolTip.SetTip("How much the radius of this ability is increased by each time it is purchased.");

	currentAuraChainLightningRadiusIncreaseCost = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Lightning Radius Increase Cost",true));
	currentAuraChainLightningRadiusIncreaseCost.Setup(0, 999999, 1);
    currentAuraChainLightningRadiusIncreaseCost.ToolTip.SetTip("How much it costs to increase the radius of this ability.");

	currentAuraChainLightningDisabled = moCheckBox(currentScrollContainer.List.AddItem("XInterface.moCheckBox", ,"Disable Chain Lightning Aura",true));
    currentAuraChainLightningDisabled.ToolTip.SetTip("Check to disable this aura.");
	currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentAuraResurrectAbility = GUIListSpacer(currentScrollContainer.List.AddItem("XInterface.GUIListSpacer", ,"Resurrection Aura",true));
    currentAuraResurrectAbility.CaptionWidth = 1;
    currentAuraResurrectAbility.MyLabel.Style = None;
	currentAuraResurrectAbility.MyLabel.TextColor = AuraLabelColor;
	currentAuraResurrectAbility.MyLabel.FocusedTextColor = AuraLabelColor;
	currentAuraResurrectAbility.MyLabel.TextAlign = TXTA_Left;
	currentAuraResurrectAbility.ToolTip.SetTip("The necromancer aura allows the pet to resurrect fallen enemies as friendly minions for a short period of time, the starting health percentage of the minions, and radius of this ability is upgradable.");
	currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentAuraResurrectMax = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Minion Health Max",true));
	currentAuraResurrectMax.Setup(1, 100, 1);
    currentAuraResurrectMax.ToolTip.SetTip("The maximum amount of health for the minions.");

	currentAuraResurrectIncrease = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Minion Health Increase",true));
	currentAuraResurrectIncrease.Setup(1, 999999, 1);
    currentAuraResurrectIncrease.ToolTip.SetTip("How much this ability is increased by each time it is purchased.");

	currentAuraResurrectIncreaseCost = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Minion Health Increase Cost",true));
	currentAuraResurrectIncreaseCost.Setup(0, 999999, 1);
    currentAuraResurrectIncreaseCost.ToolTip.SetTip("How much it costs to increase this ability.");

	currentAuraResurrectRadiusMax = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Resurrection Radius Max",true));
	currentAuraResurrectRadiusMax.Setup(0, 999999, 1);
    currentAuraResurrectRadiusMax.ToolTip.SetTip("The maximum radius distance this ability has.");

	currentAuraResurrectRadiusIncrease = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Resurrection Radius Increase",true));
	currentAuraResurrectRadiusIncrease.Setup(1, 999999, 1);
    currentAuraResurrectRadiusIncrease.ToolTip.SetTip("How much the radius of this ability is increased by each time it is purchased.");

	currentAuraResurrectRadiusIncreaseCost = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Resurrection Radius Increase Cost",true));
	currentAuraResurrectRadiusIncreaseCost.Setup(0, 999999, 1);
    currentAuraResurrectRadiusIncreaseCost.ToolTip.SetTip("How much it costs to increase the radius of this ability.");

	currentAuraResurrectMinionLifeSpanMin = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Minimum Minion Lifespan",true));
	currentAuraResurrectMinionLifeSpanMin.Setup(1, 999999, 1);
    currentAuraResurrectMinionLifeSpanMin.ToolTip.SetTip("The minimum amount of time the minions can live for.");

	currentAuraResurrectMinionLifeSpanMax = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Maximum Minion Lifespan",true));
	currentAuraResurrectMinionLifeSpanMax.Setup(1, 999999, 1);
    currentAuraResurrectMinionLifeSpanMax.ToolTip.SetTip("The maximum amount of time the minions can live for.");

	currentAuraResurrectMaxMinions = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Maximum Number of Minions",true));
	currentAuraResurrectMaxMinions.Setup(1, 999999, 1);
    currentAuraResurrectMaxMinions.ToolTip.SetTip("The maximum number of resurrected minions the pet can have at any one time.");

	currentAuraResurrectDisabled = moCheckBox(currentScrollContainer.List.AddItem("XInterface.moCheckBox", ,"Disable Resurrection Aura",true));
    currentAuraResurrectDisabled.ToolTip.SetTip("Check to disable this aura.");

	currentAuraRetributionAbility = GUIListSpacer(currentScrollContainer.List.AddItem("XInterface.GUIListSpacer", ,"Retribution Aura",true));
    currentAuraRetributionAbility.CaptionWidth = 1;
    currentAuraRetributionAbility.MyLabel.Style = None;
	currentAuraRetributionAbility.MyLabel.TextColor = AuraLabelColor;
	currentAuraRetributionAbility.MyLabel.FocusedTextColor = AuraLabelColor;
	currentAuraRetributionAbility.MyLabel.TextAlign = TXTA_Left;
	currentAuraRetributionAbility.ToolTip.SetTip("The retribution aura causes a percentage of the damage taken by the pet to be mirrored back to the attacker. The amount is upgradable.");
	currentScrollContainer.List.AddItem("XInterface.GUIListSpacer");

	currentAuraRetributionMax = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Damage Max",true));
	currentAuraRetributionMax.Setup(1, 100, 1);
    currentAuraRetributionMax.ToolTip.SetTip("The maximum percentage of damage that can be reflected back to the attacker.");

	currentAuraRetributionIncrease = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Damage Increase",true));
	currentAuraRetributionIncrease.Setup(1, 999999, 1);
    currentAuraRetributionIncrease.ToolTip.SetTip("How much this ability is increased by each time it is purchased.");

	currentAuraRetributionIncreaseCost = moNumericEdit(currentScrollContainer.List.AddItem("XInterface.moNumericEdit", ,"Damage Increase Cost",true));
	currentAuraRetributionIncreaseCost.Setup(0, 999999, 1);
    currentAuraRetributionIncreaseCost.ToolTip.SetTip("How much it costs to increase this ability.");

	currentAuraRetributionDisabled = moCheckBox(currentScrollContainer.List.AddItem("XInterface.moCheckBox", ,"Disable Retribution Aura",true));
    currentAuraRetributionDisabled.ToolTip.SetTip("Check to disable this aura.");

	Controller.bCurMenuInitialized = bTemp;
	SetDefaultComponent(currentAuraHealMax);
	SetDefaultComponent(currentAuraHealIncrease);
	SetDefaultComponent(currentAuraHealIncreaseCost);
	SetDefaultComponent(currentAuraHealRadiusMax);
	SetDefaultComponent(currentAuraHealRadiusIncrease);
	SetDefaultComponent(currentAuraHealRadiusIncreaseCost);
	SetDefaultComponent(currentAuraHealDisabled);
	SetDefaultComponent(currentAuraDamageMax);
	SetDefaultComponent(currentAuraDamageIncrease);
	SetDefaultComponent(currentAuraDamageIncreaseCost);
	SetDefaultComponent(currentAuraDamageRadiusMax);
	SetDefaultComponent(currentAuraDamageRadiusIncrease);
	SetDefaultComponent(currentAuraDamageRadiusIncreaseCost);
	SetDefaultComponent(currentAuraDamageDisabled);
	SetDefaultComponent(currentAuraDefenseMax);
	SetDefaultComponent(currentAuraDefenseIncrease);
	SetDefaultComponent(currentAuraDefenseIncreaseCost);
	SetDefaultComponent(currentAuraDefenseRadiusMax);
	SetDefaultComponent(currentAuraDefenseRadiusIncrease);
	SetDefaultComponent(currentAuraDefenseRadiusIncreaseCost);
	SetDefaultComponent(currentAuraDefenseDisabled);
	SetDefaultComponent(currentAuraFrostMax);
	SetDefaultComponent(currentAuraFrostIncrease);
	SetDefaultComponent(currentAuraFrostIncreaseCost);
	SetDefaultComponent(currentAuraFrostRadiusMax);
	SetDefaultComponent(currentAuraFrostRadiusIncrease);
	SetDefaultComponent(currentAuraFrostRadiusIncreaseCost);
	SetDefaultComponent(currentAuraFrostDisabled);
	SetDefaultComponent(currentAuraPetDisabled);
	SetDefaultComponent(currentAuraChainLightningMax);
	SetDefaultComponent(currentAuraChainLightningIncrease);
	SetDefaultComponent(currentAuraChainLightningIncreaseCost);
	SetDefaultComponent(currentAuraChainLightningRadiusMax);
	SetDefaultComponent(currentAuraChainLightningRadiusIncrease);
	SetDefaultComponent(currentAuraChainLightningRadiusIncreaseCost);
	SetDefaultComponent(currentAuraChainLightningDisabled);
	SetDefaultComponent(currentAuraResurrectMax);
	SetDefaultComponent(currentAuraResurrectIncrease);
	SetDefaultComponent(currentAuraResurrectIncreaseCost);
	SetDefaultComponent(currentAuraResurrectRadiusMax);
	SetDefaultComponent(currentAuraResurrectRadiusIncrease);
	SetDefaultComponent(currentAuraResurrectRadiusIncreaseCost);
	SetDefaultComponent(currentAuraResurrectMinionLifeSpanMin);
	SetDefaultComponent(currentAuraResurrectMinionLifeSpanMax);
	SetDefaultComponent(currentAuraResurrectMaxMinions);
	SetDefaultComponent(currentAuraResurrectDisabled);
	SetDefaultComponent(currentAuraRetributionMax);
	SetDefaultComponent(currentAuraRetributionIncrease);
	SetDefaultComponent(currentAuraRetributionIncreaseCost);
	SetDefaultComponent(currentAuraRetributionDisabled);
	SetDefaultComponent(currentKillBonusMax);
	SetDefaultComponent(currentKillBonusIncrease);
	SetDefaultComponent(currentKillBonusIncreaseCost);
	SetDefaultComponent(currentKillBonusLevel);
	SetDefaultComponent(currentXpLeechCost);
	SetDefaultComponent(currentXpLeechLevel);
	SetDefaultComponent(currentBaseTeleportDistance);
	SetDefaultComponent(currentTeleportDistanceMax);
	SetDefaultComponent(currentTeleportDistanceIncrease);
	SetDefaultComponent(currentTeleportDistanceIncreaseCost);
	SetDefaultComponent(currentTeleportDistanceLevel);
	SetDefaultComponent(currentTeleportCost);
	SetDefaultComponent(currentTeleportLevel);
	SetDefaultComponent(currentBaseTeleportCoolDownTime);
	SetDefaultComponent(currentTeleportTimeMax);
	SetDefaultComponent(currentTeleportTimeIncrease);
	SetDefaultComponent(currentTeleportTimeIncreaseCost);
	SetDefaultComponent(currentTeleportTimeLevel);
	SetDefaultComponent(currentRespawnMax);
	SetDefaultComponent(currentRespawnIncrease);
	SetDefaultComponent(currentRespawnIncreaseCost);
	SetDefaultComponent(currentRespawnLevel);
	SetDefaultComponent(currentBasePetDamage);
	SetDefaultComponent(currentDamageBonusMax);
	SetDefaultComponent(currentDamageBonusIncrease);
	SetDefaultComponent(currentDamageBonusIncreaseCost);
	SetDefaultComponent(currentDamageBonusLevel);
	SetDefaultComponent(currentDamageReductionMax);
	SetDefaultComponent(currentDamageReductionIncrease);
	SetDefaultComponent(currentDamageReductionIncreaseCost);
	SetDefaultComponent(currentDamageReductionLevel);
	SetDefaultComponent(currentDodgeMax);
	SetDefaultComponent(currentDodgeIncrease);
	SetDefaultComponent(currentDodgeIncreaseCost);
	SetDefaultComponent(currentDodgeLevel);
	SetDefaultComponent(currentHealthMax);
	SetDefaultComponent(currentHealthIncrease);
	SetDefaultComponent(currentHealthIncreaseCost);
	SetDefaultComponent(currentHealthLevel);
	SetDefaultComponent(currentHealthRegenMax);
	SetDefaultComponent(currentHealthRegenIncrease);
	SetDefaultComponent(currentHealthRegenIncreaseCost);
	SetDefaultComponent(currentHealthRegenLevel);
	SetDefaultComponent(currentHealthBoostMax);
	SetDefaultComponent(currentHealthBoostIncrease);
	SetDefaultComponent(currentHealthBoostIncreaseCost);
	SetDefaultComponent(currentHealthBoostLevel);
	SetDefaultComponent(currentBasePetHealth);
	SetDefaultComponent(currentBasePetSpeed);
	SetDefaultComponent(currentSpeedMax);
	SetDefaultComponent(currentSpeedIncrease);
	SetDefaultComponent(currentSpeedIncreaseCost);
	SetDefaultComponent(currentSpeedLevel);
	SetDefaultComponent(currentSpeedBoostMax);
	SetDefaultComponent(currentSpeedBoostIncrease);
	SetDefaultComponent(currentSpeedBoostIncreaseCost);
	SetDefaultComponent(currentSpeedBoostLevel);
	SetDefaultComponent(currentWaveCountDownColourR);
	SetDefaultComponent(currentWaveCountDownColourG);
	SetDefaultComponent(currentWaveCountDownColourB);
	SetDefaultComponent(currentMonsterStartTag);
	SetDefaultComponent(currentPlayerStartTag);
	SetDefaultComponent(currentCustomGameTypePrefix);
 	currentWaveCountDownColourR.ComponentJustification = TXTA_Left;
 	currentWaveCountDownColourR.ComponentWidth = 0.4;
 	currentWaveCountDownColourR.CaptionWidth = 0.3;
 	currentWaveCountDownColourG.ComponentJustification = TXTA_Left;
	currentWaveCountDownColourG.ComponentWidth = 0.4;
 	currentWaveCountDownColourG.CaptionWidth = 0.3;
 	currentWaveCountDownColourB.ComponentJustification = TXTA_Left;
	currentWaveCountDownColourB.ComponentWidth = 0.4;
 	currentWaveCountDownColourB.CaptionWidth = 0.3;
	UpdateCurrentSettings();
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

function bool InternalDraw(Canvas Canvas)
{
	local color TestColor;

	if(Canvas != None)
	{
		TestColor.R = currentWaveCountDownColourR.GetValue();
		TestColor.G = currentWaveCountDownColourG.GetValue();
		TestColor.B = currentWaveCountDownColourB.GetValue();
		TestColor.A = 255;
		currentWaveCountDownColour.MyLabel.TextColor = TestColor;
		currentWaveCountDownColour.MyLabel.FocusedTextColor = TestColor;
	}

	return false;
}

function bool InternalOnClick(GUIComponent Sender)
{
	Controller.CloseMenu(false);
	return true;
}

event Closed(GUIComponent Sender, bool bCancelled)
{
    Super.Closed(Sender, bCancelled);
}

function InternalOnChange(GUIComponent Sender)
{}

function UpdateCurrentSettings()
{
	currentAuraHealMax.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraHeal.AuraHealMax);
	currentAuraHealIncrease.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraHeal.AuraHealIncrease);
	currentAuraHealIncreaseCost.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraHeal.AuraHealIncreaseCost);
	currentAuraHealRadiusMax.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraHeal.AuraRadiusMax);
	currentAuraHealRadiusIncrease.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraHeal.AuraRadiusIncrease);
	currentAuraHealRadiusIncreaseCost.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraHeal.AuraRadiusIncreaseCost);
	currentAuraHealDisabled.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraHeal.bDisabled);
	currentAuraDamageMax.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraDamage.AuraDamageMax);
	currentAuraDamageIncrease.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraDamage.AuraDamageIncrease);
	currentAuraDamageIncreaseCost.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraDamage.AuraDamageIncreaseCost);
	currentAuraDamageRadiusMax.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraDamage.AuraRadiusMax);
	currentAuraDamageRadiusIncrease.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraDamage.AuraRadiusIncrease);
	currentAuraDamageRadiusIncreaseCost.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraDamage.AuraRadiusIncreaseCost);
	currentAuraDamageDisabled.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraDamage.bDisabled);
	currentAuraDefenseMax.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraDefense.AuraDefenseMax);
	currentAuraDefenseIncrease.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraDefense.AuraDefenseIncrease);
	currentAuraDefenseIncreaseCost.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraDefense.AuraDefenseIncreaseCost);
	currentAuraDefenseRadiusMax.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraDefense.AuraRadiusMax);
	currentAuraDefenseRadiusIncrease.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraDefense.AuraRadiusIncrease);
	currentAuraDefenseRadiusIncreaseCost.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraDefense.AuraRadiusIncreaseCost);
	currentAuraDefenseDisabled.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraDefense.bDisabled);
	currentAuraFrostMax.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraFrost.AuraFrostMax);
	currentAuraFrostIncrease.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraFrost.AuraFrostIncrease);
	currentAuraFrostIncreaseCost.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraFrost.AuraFrostIncreaseCost);
	currentAuraFrostRadiusMax.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraFrost.AuraRadiusMax);
	currentAuraFrostRadiusIncrease.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraFrost.AuraRadiusIncrease);
	currentAuraFrostRadiusIncreaseCost.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraFrost.AuraRadiusIncreaseCost);
	currentAuraFrostDisabled.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraFrost.bDisabled);
	currentAuraPetDisabled.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraCompanion.bDisabled);
	currentAuraChainLightningMax.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraChainLightning.AuraChainLightningMax);
	currentAuraChainLightningIncrease.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraChainLightning.AuraChainLightningIncrease);
	currentAuraChainLightningIncreaseCost.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraChainLightning.AuraChainLightningIncreaseCost);
	currentAuraChainLightningRadiusMax.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraChainLightning.AuraRadiusMax);
	currentAuraChainLightningRadiusIncrease.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraChainLightning.AuraRadiusIncrease);
	currentAuraChainLightningRadiusIncreaseCost.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraChainLightning.AuraRadiusIncreaseCost);
	currentAuraChainLightningDisabled.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraChainLightning.bDisabled);
	currentAuraResurrectMax.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.AuraResurrectMax);
	currentAuraResurrectIncrease.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.AuraResurrectIncrease);
	currentAuraResurrectIncreaseCost.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.AuraResurrectIncreaseCost);
	currentAuraResurrectRadiusMax.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.AuraRadiusMax);
	currentAuraResurrectRadiusIncrease.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.AuraRadiusIncrease);
	currentAuraResurrectRadiusIncreaseCost.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.AuraRadiusIncreaseCost);
	currentAuraResurrectMinionLifeSpanMin.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.MinionLifeSpanMin);
	currentAuraResurrectMinionLifeSpanMax.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.MinionLifeSpanMax);
	currentAuraResurrectMaxMinions.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.MaxMinions);
	currentAuraResurrectDisabled.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.bDisabled);
	currentAuraRetributionMax.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraRetribution.AuraRetributionMax);
	currentAuraRetributionIncrease.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraRetribution.AuraRetributionIncrease);
	currentAuraRetributionIncreaseCost.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraRetribution.AuraRetributionIncreaseCost);
	currentAuraRetributionDisabled.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_AuraRetribution.bDisabled);
	currentKillBonusMax.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_KillBonus.KillBonusMax);
	currentKillBonusIncrease.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_KillBonus.KillBonusIncrease);
	currentKillBonusIncreaseCost.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_KillBonus.KillBonusIncreaseCost);
	currentKillBonusLevel.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_KillBonus.Level);
	currentXpLeechCost.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_XpLeech.XpLeechCost);
	currentXpLeechLevel.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_XpLeech.Level);
	currentBaseTeleportDistance.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_TeleportDistance.BaseTeleportDistance);
	currentTeleportDistanceMax.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_TeleportDistance.TeleportDistanceMax);
	currentTeleportDistanceIncrease.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_TeleportDistance.TeleportDistanceIncrease);
	currentTeleportDistanceIncreaseCost.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_TeleportDistance.TeleportDistanceIncreaseCost);
	currentTeleportDistanceLevel.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_TeleportDistance.Level);
	currentTeleportCost.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_Teleport.TeleportCost);
	currentTeleportLevel.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_Teleport.Level);
	currentBaseTeleportCoolDownTime.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_TeleportTime.BaseTeleportCoolDownTime);
	currentTeleportTimeMax.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_TeleportTime.TeleportTimeMax);
	currentTeleportTimeIncrease.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_TeleportTime.TeleportTimeIncrease);
	currentTeleportTimeIncreaseCost.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_TeleportTime.TeleportTimeIncreaseCost);
	currentTeleportTimeLevel.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_TeleportTime.Level);
	currentRespawnMax.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_Respawn.RespawnMax);
	currentRespawnIncrease.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_Respawn.RespawnIncrease);
	currentRespawnIncreaseCost.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_Respawn.RespawnIncreaseCost);
	currentRespawnLevel.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_Respawn.Level);
	currentBasePetDamage.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_DamageBonus.BasePetDamage);
	currentDamageBonusMax.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_DamageBonus.DamageBonusMax);
	currentDamageBonusIncrease.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_DamageBonus.DamageBonusIncrease);
	currentDamageBonusIncreaseCost.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_DamageBonus.DamageBonusIncreaseCost);
	currentDamageBonusLevel.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_DamageBonus.Level);
	currentDamageReductionMax.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_DamageReduction.DamageReductionMax);
	currentDamageReductionIncrease.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_DamageReduction.DamageReductionIncrease);
	currentDamageReductionIncreaseCost.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_DamageReduction.DamageReductionIncreaseCost);
	currentDamageReductionLevel.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_DamageReduction.Level);
	currentDodgeMax.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_Dodge.DodgeMax);
	currentDodgeIncrease.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_Dodge.DodgeIncrease);
	currentDodgeIncreaseCost.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_Dodge.DodgeIncreaseCost);
	currentDodgeLevel.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_Dodge.Level);
	currentBasePetHealth.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_Health.BasePetHealth);
	currentHealthMax.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_Health.HealthMax);
	currentHealthIncrease.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_Health.HealthIncrease);
	currentHealthIncreaseCost.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_Health.HealthIncreaseCost);
	currentHealthLevel.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_Health.Level);
	currentHealthRegenMax.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_HealthRegen.HealthRegenMax);
	currentHealthRegenIncrease.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_HealthRegen.HealthRegenIncrease);
	currentHealthRegenIncreaseCost.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_HealthRegen.HealthRegenIncreaseCost);
	currentHealthRegenLevel.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_HealthRegen.Level);
	currentHealthBoostMax.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_HealthBoost.HealthBoostMax);
	currentHealthBoostIncrease.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_HealthBoost.HealthBoostIncrease);
	currentHealthBoostIncreaseCost.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_HealthBoost.HealthBoostIncreaseCost);
	currentHealthBoostLevel.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_HealthBoost.Level);
	currentBasePetSpeed.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_Speed.BasePetSpeed);
	currentSpeedMax.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_Speed.SpeedMax);
	currentSpeedIncrease.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_Speed.SpeedIncrease);
	currentSpeedIncreaseCost.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_Speed.SpeedIncreaseCost);
	currentSpeedLevel.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_Speed.Level);
	currentSpeedBoostMax.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_SpeedBoost.SpeedBoostMax);
	currentSpeedBoostIncrease.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_SpeedBoost.SpeedBoostIncrease);
	currentSpeedBoostIncreaseCost.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_SpeedBoost.SpeedBoostIncreaseCost);
	currentSpeedBoostLevel.SetComponentValue(class'InvasionProGameReplicationInfo'.default.Ability_SpeedBoost.Level);
	currentMonsterStartTag.SetComponentValue(class'InvasionPro'.default.MonsterStartTag);
	currentPlayerStartTag.SetComponentValue(class'InvasionPro'.default.PlayerStartTag);
	currentCustomGameTypePrefix.SetComponentValue(class'InvasionPro'.default.CustomGameTypePrefix);
	currentWaveCountDownColourR.SetComponentValue(class'InvasionPro'.default.WaveCountDownColour.R);
	currentWaveCountDownColourG.SetComponentValue(class'InvasionPro'.default.WaveCountDownColour.G);
	currentWaveCountDownColourB.SetComponentValue(class'InvasionPro'.default.WaveCountDownColour.B);
}

function bool DefaultMenu(GUIComponent Sender)
{
	currentAuraHealMax.SetComponentValue(25);
	currentAuraHealIncrease.SetComponentValue(1);
	currentAuraHealIncreaseCost.SetComponentValue(25);
	currentAuraHealRadiusMax.SetComponentValue(800);
	currentAuraHealRadiusIncrease.SetComponentValue(20);
	currentAuraHealRadiusIncreaseCost.SetComponentValue(50);
	currentAuraHealDisabled.SetComponentValue(false);
	currentAuraDamageMax.SetComponentValue(25);
	currentAuraDamageIncrease.SetComponentValue(1);
	currentAuraDamageIncreaseCost.SetComponentValue(25);
	currentAuraDamageRadiusMax.SetComponentValue(800);
	currentAuraDamageRadiusIncrease.SetComponentValue(20);
	currentAuraDamageRadiusIncreaseCost.SetComponentValue(50);
	currentAuraDamageDisabled.SetComponentValue(false);
	currentAuraDefenseMax.SetComponentValue(1000);
	currentAuraDefenseIncrease.SetComponentValue(10);
	currentAuraDefenseIncreaseCost.SetComponentValue(30);
	currentAuraDefenseRadiusMax.SetComponentValue(300);
	currentAuraDefenseRadiusIncrease.SetComponentValue(5);
	currentAuraDefenseRadiusIncreaseCost.SetComponentValue(50);
	currentAuraDefenseDisabled.SetComponentValue(false);
	currentAuraFrostMax.SetComponentValue(100);
	currentAuraFrostIncrease.SetComponentValue(1);
	currentAuraFrostIncreaseCost.SetComponentValue(50);
	currentAuraFrostRadiusMax.SetComponentValue(500);
	currentAuraFrostRadiusIncrease.SetComponentValue(10);
	currentAuraFrostRadiusIncreaseCost.SetComponentValue(50);
	currentAuraFrostDisabled.SetComponentValue(false);
	currentAuraPetDisabled.SetComponentValue(false);
	currentAuraChainLightningMax.SetComponentValue(100);
	currentAuraChainLightningIncrease.SetComponentValue(2);
	currentAuraChainLightningIncreaseCost.SetComponentValue(50);
	currentAuraChainLightningRadiusMax.SetComponentValue(2000);
	currentAuraChainLightningRadiusIncrease.SetComponentValue(10);
	currentAuraChainLightningRadiusIncreaseCost.SetComponentValue(50);
	currentAuraChainLightningDisabled.SetComponentValue(false);
	currentAuraResurrectMax.SetComponentValue(150);
	currentAuraResurrectIncrease.SetComponentValue(5);
	currentAuraResurrectIncreaseCost.SetComponentValue(50);
	currentAuraResurrectRadiusMax.SetComponentValue(1000);
	currentAuraResurrectRadiusIncrease.SetComponentValue(10);
	currentAuraResurrectRadiusIncreaseCost.SetComponentValue(50);
	currentAuraResurrectMinionLifeSpanMin.SetComponentValue(30);
	currentAuraResurrectMinionLifeSpanMax.SetComponentValue(60);
	currentAuraResurrectMaxMinions.SetComponentValue(8);
	currentAuraResurrectDisabled.SetComponentValue(false);
	currentAuraRetributionMax.SetComponentValue(100);
	currentAuraRetributionIncrease.SetComponentValue(2);
	currentAuraRetributionIncreaseCost.SetComponentValue(50);
	currentAuraRetributionDisabled.SetComponentValue(false);
	currentKillBonusMax.SetComponentValue(5);
	currentKillBonusIncrease.SetComponentValue(1);
	currentKillBonusIncreaseCost.SetComponentValue(50);
	currentKillBonusLevel.SetComponentValue(3);
	currentXpLeechCost.SetComponentValue(250);
	currentXpLeechLevel.SetComponentValue(1);
	currentBaseTeleportDistance.SetComponentValue(100);
	currentTeleportDistanceMax.SetComponentValue(5000);
	currentTeleportDistanceIncrease.SetComponentValue(50);
	currentTeleportDistanceIncreaseCost.SetComponentValue(100);
	currentTeleportDistanceLevel.SetComponentValue(50);
	currentTeleportCost.SetComponentValue(2500);
	currentTeleportLevel.SetComponentValue(50);
	currentBaseTeleportCoolDownTime.SetComponentValue(60);
	currentTeleportTimeMax.SetComponentValue(100);
	currentTeleportTimeIncrease.SetComponentValue(1);
	currentTeleportTimeIncreaseCost.SetComponentValue(75);
	currentTeleportTimeLevel.SetComponentValue(50);
	currentRespawnMax.SetComponentValue(90);
	currentRespawnIncrease.SetComponentValue(1);
	currentRespawnIncreaseCost.SetComponentValue(200);
	currentRespawnLevel.SetComponentValue(0);
	currentBasePetDamage.SetComponentValue(8);
	currentDamageBonusMax.SetComponentValue(100);
	currentDamageBonusIncrease.SetComponentValue(1);
	currentDamageBonusIncreaseCost.SetComponentValue(50);
	currentDamageBonusLevel.SetComponentValue(0);
	currentDamageReductionMax.SetComponentValue(30);
	currentDamageReductionIncrease.SetComponentValue(1);
	currentDamageReductionIncreaseCost.SetComponentValue(50);
	currentDamageReductionLevel.SetComponentValue(10);
	currentDodgeMax.SetComponentValue(100);
	currentDodgeIncrease.SetComponentValue(1);
	currentDodgeIncreaseCost.SetComponentValue(25);
	currentDodgeLevel.SetComponentValue(15);
	currentHealthMax.SetComponentValue(1000);
	currentHealthIncrease.SetComponentValue(5);
	currentHealthIncreaseCost.SetComponentValue(25);
	currentHealthLevel.SetComponentValue(0);
	currentHealthRegenMax.SetComponentValue(10);
	currentHealthRegenIncrease.SetComponentValue(1);
	currentHealthRegenIncreaseCost.SetComponentValue(100);
	currentHealthRegenLevel.SetComponentValue(5);
	currentHealthBoostMax.SetComponentValue(50);
	currentHealthBoostIncrease.SetComponentValue(1);
	currentHealthBoostIncreaseCost.SetComponentValue(50);
	currentHealthBoostLevel.SetComponentValue(30);
	currentBasePetSpeed.SetComponentValue(320);
	currentSpeedMax.SetComponentValue(500);
	currentSpeedIncrease.SetComponentValue(5);
	currentSpeedIncreaseCost.SetComponentValue(75);
	currentSpeedLevel.SetComponentValue(0);
	currentSpeedBoostMax.SetComponentValue(30);
	currentSpeedBoostIncrease.SetComponentValue(1);
	currentSpeedBoostIncreaseCost.SetComponentValue(75);
	currentSpeedBoostLevel.SetComponentValue(25);
	currentBasePetHealth.SetComponentValue(50);
	currentWaveCountDownColourR.SetComponentValue(255);
	currentWaveCountDownColourG.SetComponentValue(255);
	currentWaveCountDownColourB.SetComponentValue(0);

	return true;
}

function bool ExitMenu(GUIComponent Sender)
{
	class'InvasionProGameReplicationInfo'.default.Ability_AuraHeal.AuraHealMax = currentAuraHealMax.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraHeal.AuraHealIncrease = currentAuraHealIncrease.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraHeal.AuraHealIncreaseCost = currentAuraHealIncreaseCost.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraHeal.AuraRadiusMax = currentAuraHealRadiusMax.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraHeal.AuraRadiusIncrease = currentAuraHealRadiusIncrease.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraHeal.AuraRadiusIncreaseCost = currentAuraHealRadiusIncreaseCost.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraHeal.bDisabled = currentAuraHealDisabled.IsChecked();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraDamage.AuraDamageMax = currentAuraDamageMax.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraDamage.AuraDamageIncrease = currentAuraDamageIncrease.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraDamage.AuraDamageIncreaseCost = currentAuraDamageIncreaseCost.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraDamage.AuraRadiusMax = currentAuraDamageRadiusMax.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraDamage.AuraRadiusIncrease = currentAuraDamageRadiusIncrease.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraDamage.AuraRadiusIncreaseCost = currentAuraDamageRadiusIncreaseCost.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraDamage.bDisabled = currentAuraDamageDisabled.IsChecked();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraDefense.AuraDefenseMax = currentAuraDefenseMax.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraDefense.AuraDefenseIncrease = currentAuraDefenseIncrease.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraDefense.AuraDefenseIncreaseCost = currentAuraDefenseIncreaseCost.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraDefense.AuraRadiusMax = currentAuraDefenseRadiusMax.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraDefense.AuraRadiusIncrease = currentAuraDefenseRadiusIncrease.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraDefense.AuraRadiusIncreaseCost = currentAuraDefenseRadiusIncreaseCost.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraDefense.bDisabled = currentAuraDefenseDisabled.IsChecked();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraFrost.AuraFrostMax = currentAuraFrostMax.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraFrost.AuraFrostIncrease = currentAuraFrostIncrease.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraFrost.AuraFrostIncreaseCost = currentAuraFrostIncreaseCost.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraFrost.AuraRadiusMax = currentAuraFrostRadiusMax.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraFrost.AuraRadiusIncrease = currentAuraFrostRadiusIncrease.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraFrost.AuraRadiusIncreaseCost = currentAuraFrostRadiusIncreaseCost.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraFrost.bDisabled = currentAuraFrostDisabled.IsChecked();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraCompanion.bDisabled = currentAuraPetDisabled.IsChecked();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraChainLightning.AuraChainLightningMax = currentAuraChainLightningMax.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraChainLightning.AuraChainLightningIncrease = currentAuraChainLightningIncrease.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraChainLightning.AuraChainLightningIncreaseCost = currentAuraChainLightningIncreaseCost.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraChainLightning.AuraRadiusMax = currentAuraChainLightningRadiusMax.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraChainLightning.AuraRadiusIncrease = currentAuraChainLightningRadiusIncrease.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraChainLightning.AuraRadiusIncreaseCost = currentAuraChainLightningRadiusIncreaseCost.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraChainLightning.bDisabled = currentAuraChainLightningDisabled.IsChecked();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.AuraResurrectMax = currentAuraResurrectMax.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.AuraResurrectIncrease = currentAuraResurrectIncrease.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.AuraResurrectIncreaseCost = currentAuraResurrectIncreaseCost.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.AuraRadiusMax = currentAuraResurrectRadiusMax.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.AuraRadiusIncrease = currentAuraResurrectRadiusIncrease.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.AuraRadiusIncreaseCost = currentAuraResurrectRadiusIncreaseCost.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.MinionLifeSpanMin = currentAuraResurrectMinionLifeSpanMin.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.MinionLifeSpanMax = currentAuraResurrectMinionLifeSpanMax.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.MaxMinions = currentAuraResurrectMaxMinions.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraResurrect.bDisabled = currentAuraResurrectDisabled.IsChecked();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraRetribution.AuraRetributionMax = currentAuraRetributionMax.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraRetribution.AuraRetributionIncrease = currentAuraRetributionIncrease.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraRetribution.AuraRetributionIncreaseCost = currentAuraRetributionIncreaseCost.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_AuraRetribution.bDisabled = currentAuraRetributionDisabled.IsChecked();
	class'InvasionProGameReplicationInfo'.default.Ability_KillBonus.KillBonusMax = currentKillBonusMax.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_KillBonus.KillBonusIncrease = currentKillBonusIncrease.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_KillBonus.KillBonusIncreaseCost = currentKillBonusIncreaseCost.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_KillBonus.Level = currentKillBonusLevel.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_XpLeech.XpLeechCost = currentXpLeechCost.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_XpLeech.Level = currentXpLeechLevel.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_TeleportDistance.BaseTeleportDistance = currentBaseTeleportDistance.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_TeleportDistance.TeleportDistanceMax = currentTeleportDistanceMax.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_TeleportDistance.TeleportDistanceIncrease = currentTeleportDistanceIncrease.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_TeleportDistance.TeleportDistanceIncreaseCost = currentTeleportDistanceIncreaseCost.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_TeleportDistance.Level = currentTeleportDistanceLevel.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_Teleport.TeleportCost = currentTeleportCost.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_Teleport.Level = currentTeleportLevel.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_TeleportTime.BaseTeleportCoolDownTime = currentBaseTeleportCoolDownTime.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_TeleportTime.TeleportTimeMax = currentTeleportTimeMax.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_TeleportTime.TeleportTimeIncrease = currentTeleportTimeIncrease.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_TeleportTime.TeleportTimeIncreaseCost = currentTeleportTimeIncreaseCost.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_TeleportTime.Level = currentTeleportTimeLevel.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_Respawn.RespawnMax = currentRespawnMax.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_Respawn.RespawnIncrease = currentRespawnIncrease.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_Respawn.RespawnIncreaseCost = currentRespawnIncreaseCost.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_Respawn.Level = currentRespawnLevel.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_DamageBonus.BasePetDamage = currentBasePetDamage.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_DamageBonus.DamageBonusMax = currentDamageBonusMax.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_DamageBonus.DamageBonusIncrease = currentDamageBonusIncrease.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_DamageBonus.DamageBonusIncreaseCost = currentDamageBonusIncreaseCost.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_DamageBonus.Level = currentDamageBonusLevel.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_DamageReduction.DamageReductionMax = currentDamageReductionMax.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_DamageReduction.DamageReductionIncrease = currentDamageReductionIncrease.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_DamageReduction.DamageReductionIncreaseCost = currentDamageReductionIncreaseCost.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_DamageReduction.Level = currentDamageReductionLevel.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_Dodge.DodgeMax = currentDodgeMax.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_Dodge.DodgeIncrease = currentDodgeIncrease.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_Dodge.DodgeIncreaseCost = currentDodgeIncreaseCost.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_Dodge.Level = currentDodgeLevel.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_Health.HealthMax = currentHealthMax.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_Health.HealthIncrease = currentHealthIncrease.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_Health.HealthIncreaseCost = currentHealthIncreaseCost.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_Health.Level = currentHealthLevel.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_HealthRegen.HealthRegenMax = currentHealthRegenMax.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_HealthRegen.HealthRegenIncrease = currentHealthRegenIncrease.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_HealthRegen.HealthRegenIncreaseCost = currentHealthRegenIncreaseCost.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_HealthRegen.Level = currentHealthRegenLevel.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_HealthBoost.HealthBoostMax = currentHealthBoostMax.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_HealthBoost.HealthBoostIncrease = currentHealthBoostIncrease.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_HealthBoost.HealthBoostIncreaseCost = currentHealthBoostIncreaseCost.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_HealthBoost.Level = currentHealthBoostLevel.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_Speed.BasePetSpeed = currentBasePetSpeed.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_Speed.SpeedMax = currentSpeedMax.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_Speed.SpeedIncrease = currentSpeedIncrease.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_Speed.SpeedIncreaseCost = currentSpeedIncreaseCost.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_Speed.Level = currentSpeedLevel.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_SpeedBoost.SpeedBoostMax = currentSpeedBoostMax.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_SpeedBoost.SpeedBoostIncrease = currentSpeedBoostIncrease.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_SpeedBoost.SpeedBoostIncreaseCost = currentSpeedBoostIncreaseCost.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_SpeedBoost.Level = currentSpeedBoostLevel.GetValue();
	class'InvasionProGameReplicationInfo'.default.Ability_Health.BasePetHealth = currentBasePetHealth.GetValue();
	class'InvasionPro'.default.MonsterStartTag = currentMonsterStartTag.GetText();
	class'InvasionPro'.default.PlayerStartTag = currentPlayerStartTag.GetText();
	class'InvasionPro'.default.CustomGameTypePrefix = currentCustomGameTypePrefix.GetText();
	class'InvasionPro'.default.WaveCountDownColour.R = currentWaveCountDownColourR.GetValue();
	class'InvasionPro'.default.WaveCountDownColour.G = currentWaveCountDownColourG.GetValue();
	class'InvasionPro'.default.WaveCountDownColour.B = currentWaveCountDownColourB.GetValue();

	class'InvasionPro'.static.StaticSaveConfig();
	class'InvasionProGameReplicationInfo'.static.StaticSaveConfig();

	Controller.CloseMenu(false);

	return true;
}

function InternalOnCreateComponent(GUIComponent NewComp, GUIComponent Sender)
{
	if (GUIMenuOption(NewComp) != None)
	{
		GUIMenuOption(NewComp).CaptionWidth = 0.8;
		GUIMenuOption(NewComp).ComponentWidth = 0.2;
		GUIMenuOption(NewComp).ComponentJustification = TXTA_Right;
		GUIMenuOption(NewComp).bStandardized = True;
		GUIMenuOption(NewComp).bBoundToParent = False;
		GUIMenuOption(NewComp).bScaleToParent = False;
		GUIMenuOption(NewComp).bAutoSizeCaption = True;

		//if (Sender ==  currentScrollContainer)
			 //currentScrollContainer.InternalOnCreateComponent(NewComp, Sender);
	}

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
         NumColumns=2
         bVisibleWhenEmpty=True
         OnCreateComponent=InvasionProMainMenu.InternalOnCreateComponent
         WinTop=0.096008
         WinLeft=0.041440
         WinWidth=0.921549
         WinHeight=0.817127
         bBoundToParent=True
         bScaleToParent=True
     End Object
     currentScrollContainer=GUIMultiOptionListBox'InvasionProv1_7.InvasionProMainMenu.MyRulesList'

     AuraLabelColor=(G=255,A=255)
     Begin Object Class=GUIButton Name=LockedCancelButton
         Caption="Ok"
         Hint="Close this menu."
         WinTop=0.909098
         WinLeft=0.747843
         WinWidth=0.171970
         WinHeight=0.048624
         TabOrder=1
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProMainMenu.ExitMenu
         OnKeyEvent=LockedCancelButton.InternalOnKeyEvent
     End Object
     b_Cancel=GUIButton'InvasionProv1_7.InvasionProMainMenu.LockedCancelButton'

     Begin Object Class=GUIButton Name=LockedOKButton
         Caption="Defaults"
         Hint="Set everything to default settings."
         WinTop=0.909835
         WinLeft=0.518299
         WinWidth=0.202528
         WinHeight=0.044743
         TabOrder=0
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProMainMenu.DefaultMenu
         OnKeyEvent=LockedOKButton.InternalOnKeyEvent
     End Object
     b_OK=GUIButton'InvasionProv1_7.InvasionProMainMenu.LockedOKButton'

     bRequire640x480=True
     WinTop=0.050000
     WinLeft=0.000000
     WinWidth=1.000000
     WinHeight=0.900000
     bScaleToParent=True
}
