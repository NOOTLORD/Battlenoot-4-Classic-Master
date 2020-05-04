class InvasionProPetMenuConfig extends GUICustomPropertyPage;

var() Automated GUIMultiOptionListBox currentScrollContainer;
var() Automated GUIListSpacer AuraLabel;
var() Automated moButton currentRespecBuy;
var() Automated moButton currentHealthBuy;
var() Automated moButton currentHealthBoostBuy;
var() Automated moButton currentHealthRegenBuy;
var() Automated moButton currentAuraSelectedBuy;
var() Automated moButton currentAuraSelectedRadiusBuy;
var() Automated moButton currentXpLeechBuy;
var() Automated moButton currentKillBonusBuy;
var() Automated moButton currentSpeedBuy;
var() Automated moButton currentSpeedBoostBuy;
var() Automated moButton currentDodgeBuy;
var() Automated moButton currentDamageReductionBuy;
var() Automated moButton currentDamageBonusBuy;
var() Automated moButton currentRespawnTimeBuy;
var() Automated moButton currentTeleportBuy;
var() Automated moButton currentTeleportCooldownBuy;
var() Automated moButton currentTeleportDistanceBuy;
var() Automated moButton currentAuraBuy;
var() Automated moButton AuraHealthBuy;
var() Automated moButton AuraDamageBuy;
var() Automated moButton AuraDefenseBuy;
var() Automated moButton AuraPetBuy;
var() Automated moButton AuraFrostBuy;
var() Automated moButton AuraLightningBuy;
var() Automated moButton AuraResurrectBuy;
var() Automated moButton AuraRetributionBuy;
var() Automated moEditBox currentCompanionPetName;
var() string PlayerID;
var() Automated GUILabel currentOrders;
var() Automated GUIButton button_autopet;
var() Automated GUIButton button_recallpet;
var() Automated GUIButton button_discardpet;
var() Automated GUIButton button_orderDefendOwner;
var() Automated GUIButton button_orderDefendAll;
var() Automated GUIButton button_orderAttack;
var() Automated GUIButton button_orderStay;
var() Automated moEditBox currentPetName;
var() Automated GUILabel currentPetClass;
var() Automated GUIButton button_commitpet;
var() Automated GUILabel currentPointsLabel;
var() Automated GUILabel currentCooldownLabel;
var() Automated GUILabel currentTierModeLabel;
var() Automated GUIToolTip currentTierModeTooltip;
//model view variables
var() editinline editconst noexport InvasionProSpinnyMonster SpinnyDude;
var() vector SpinnyDudeOffset;
var() bool bAnimPaused;
var() Name CurrentAnim;
var() Automated moComboBox currentAnimList;
var() Automated GUIGFXButton b_UArrow;
var() Automated GUIGFXButton b_DArrow;
var() Automated GUIGFXButton b_LArrow;
var() Automated GUIGFXButton b_RArrow;
var() Automated GUIGFXButton b_CArrow;
var() Automated GUIGFXButton b_Play;
var() Automated GUIGFXButton b_Pause;
var() automated GUIButton b_DropTarget;
var() Automated moSlider currentModelFOV;
var() Automated GUILabel currentModelViewer;
var() Automated moSlider currentModelRotation;
var() int nfov;
var() name NameConversion;
var() InvasionProPetStatsItem MyPetStats;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local Rotator SpinnyDudeRotation;
	local InvasionProPetStatsItem PetStats;
	local bool bTemp;

	Super.InitComponent(MyController, MyOwner);

	if(PlayerOwner() == None)
	{
		log("Error Opening Pet Menu Page, PlayerOwner does not exist!");
		return;
	}

	if(PlayerOwner().PlayerReplicationInfo != None)
	{
		PlayerID = PlayerOwner().GetPlayerIDHash();
	}

	foreach PlayerOwner().DynamicActors(class'InvasionProPetStatsItem',PetStats)
	{
		if(PetStats.OwnerID == PlayerId)
		{
			MyPetStats = PetStats;
		}
	}

	if(MyPetStats != None)
	{
		MyPetStats.MyMenu = Self;
	}
	else
	{
		return;
	}

	b_DropTarget.WinWidth = default.b_DropTarget.WinWidth;
	b_DropTarget.WinHeight = default.b_DropTarget.WinHeight;
	b_DropTarget.WinLeft = default.b_DropTarget.WinLeft;
	b_DropTarget.WinTop = default.b_DropTarget.WinTop;
	sb_Main.Caption = "";
	sb_Main.bScaleToParent = true;
	sb_Main.WinWidth=0.932639;
	sb_Main.WinHeight=0.930252;
	sb_Main.WinLeft=0.037070;
	sb_Main.WinTop=0.050586;
	t_WindowTitle.Caption = "InvasionPro: Pet Stats";
	b_OK.WinWidth = default.b_OK.WinWidth;
	b_OK.WinHeight = default.b_OK.WinHeight;
	b_OK.WinLeft = default.b_OK.WinLeft;
	b_OK.WinTop = default.b_OK.WinTop;
	b_Cancel.WinWidth = default.b_Cancel.WinWidth;
	b_Cancel.WinHeight = default.b_Cancel.WinHeight;
	b_Cancel.WinLeft = default.b_Cancel.WinLeft;
	b_Cancel.WinTop = default.b_Cancel.WinTop;
	b_Cancel.DisableMe();
	i_FrameBG.ImageRenderStyle = MSTY_Translucent;

	if(ParentPage != None)
	{
		ParentPage.bRequire640x480 = False;
	}

	if ( SpinnyDude == None )
	{
		SpinnyDude = PlayerOwner().Spawn(Class'InvasionProSpinnyMonster');
	}

	if(SpinnyDude != None)
	{
		SpinnyDude.bPlayRandomAnims = false;
		SpinnyDude.SetDrawScale(0.9);
		SpinnyDude.SpinRate = 0;
		SpinnyDude.AmbientGlow = SpinnyDude.default.AmbientGlow * 0.8;
		SpinnyDudeRotation.Yaw = 32768;
		SpinnyDudeRotation.Pitch = -1024;
		SpinnyDude.SetRotation(SpinnyDudeRotation+PlayerOwner().Rotation);
		SpinnyDude.bHidden = false;
	}


	bTemp = Controller.bCurMenuInitialized;
    Controller.bCurMenuInitialized = False;
	currentScrollContainer.List.ColumnWidth = 0.995;
	currentScrollContainer.List.ItemScaling = 0.035000;
	currentScrollContainer.List.ItemPadding = 0.1;
	currentHealthBuy = moButton(currentScrollContainer.List.AddItem("XInterface.moButton", ,"Health",true));
    currentHealthBuy.ToolTip.SetTip("Your pets base health when it spawns. The health boost ability is applied when the pet spawns. Unlike most other abilities newly purchased health isn't applied until the next time your pet spawns. Click to purchase.");
	currentHealthBuy.MyButton.Caption = "BUY";
	currentHealthBuy.MyButton.OnClick = BuyHealth;
	currentHealthBoostBuy = moButton(currentScrollContainer.List.AddItem("XInterface.moButton", ,"Health Boost",true));
    currentHealthBoostBuy.ToolTip.SetTip("Health boost increases your pets health by an additional % of your pets base health. Click to purchase.");
	currentHealthBoostBuy.MyButton.Caption = "BUY";
	currentHealthBoostBuy.MyButton.OnClick = BuyHealthBoost;
	currentHealthRegenBuy = moButton(currentScrollContainer.List.AddItem("XInterface.moButton", ,"Health Regen",true));
    currentHealthRegenBuy.ToolTip.SetTip("This ability allows your pet to regeneration health every second. Click to purchase.");
	currentHealthRegenBuy.MyButton.Caption = "BUY";
	currentHealthRegenBuy.MyButton.OnClick = BuyHealthRegen;
	currentSpeedBuy = moButton(currentScrollContainer.List.AddItem("XInterface.moButton", ,"Speed",true));
    currentSpeedBuy.ToolTip.SetTip("Your pets base speed when it spawns. Speed abilities are applied to pets immediately upon purchase. Click to purchase.");
	currentSpeedBuy.MyButton.Caption = "BUY";
	currentSpeedBuy.MyButton.OnClick = BuySpeed;
	currentSpeedBoostBuy = moButton(currentScrollContainer.List.AddItem("XInterface.moButton", ,"Speed Boost",true));
    currentSpeedBoostBuy.ToolTip.SetTip("Speed boost gives an additional % of your pets base speed. Click to purchase.");
	currentSpeedBoostBuy.MyButton.Caption = "BUY";
	currentSpeedBoostBuy.MyButton.OnClick = BuySpeedBoost;
	currentDodgeBuy = moButton(currentScrollContainer.List.AddItem("XInterface.moButton", ,"Dodge Skill",true));
    currentDodgeBuy.ToolTip.SetTip("Increasing the dodge skill increases your pets ability to avoid attacks. Click to purchase.");
	currentDodgeBuy.MyButton.Caption = "BUY";
	currentDodgeBuy.MyButton.OnClick = BuyDodgeSkill;
	currentDamageBonusBuy = moButton(currentScrollContainer.List.AddItem("XInterface.moButton", ,"Damage Bonus",true));
    currentDamageBonusBuy.ToolTip.SetTip("Damage bonus increases the damage output of your pet. Click to purchase.");
	currentDamageBonusBuy.MyButton.Caption = "BUY";
	currentDamageBonusBuy.MyButton.OnClick = BuyDamageBonus;
	currentDamageReductionBuy = moButton(currentScrollContainer.List.AddItem("XInterface.moButton", ,"Armor",true));
    currentDamageReductionBuy.ToolTip.SetTip("Pet armor reduces the amount of damage your pet receives from attacks. Click to purchase.");
	currentDamageReductionBuy.MyButton.Caption = "BUY";
	currentDamageReductionBuy.MyButton.OnClick = BuyArmor;
	currentKillBonusBuy = moButton(currentScrollContainer.List.AddItem("XInterface.moButton", ,"Kill Bonus",true));
    currentKillBonusBuy.ToolTip.SetTip("This ability allows the pet to earn additional points per kill. Click to purchase.");
	currentKillBonusBuy.MyButton.Caption = "BUY";
	currentKillBonusBuy.MyButton.OnClick = BuyKillBonus;
	currentXpLeechBuy = moButton(currentScrollContainer.List.AddItem("XInterface.moButton", ,"Xp Leech",true));
    currentXpLeechBuy.ToolTip.SetTip("This ability allows the pets owner to earn experience points for the pet. Damage done by the owner will count as pet experience. Click to purchase.");
	currentXpLeechBuy.MyButton.Caption = "BUY";
	currentXpLeechBuy.MyButton.OnClick = BuyXpLeech;
	currentRespawnTimeBuy = moButton(currentScrollContainer.List.AddItem("XInterface.moButton", ,"Respawn Time",true));
    currentRespawnTimeBuy.ToolTip.SetTip("This ability reduces the respawn time of your pet. Click to purchase.");
	currentRespawnTimeBuy.MyButton.Caption = "BUY";
	currentRespawnTimeBuy.MyButton.OnClick = BuyRespawnTime;
	currentTeleportBuy = moButton(currentScrollContainer.List.AddItem("XInterface.moButton", ,"Teleport",true));
    currentTeleportBuy.ToolTip.SetTip("This ability allows your pet to teleport to and from enemies, as well as to and from players it may be protecting, and other goals. Click to purchase.");
	currentTeleportBuy.MyButton.Caption = "BUY";
	currentTeleportBuy.MyButton.OnClick = BuyTeleport;
	currentTeleportCooldownBuy = moButton(currentScrollContainer.List.AddItem("XInterface.moButton", ,"Teleport Cooldown",true));
    currentTeleportCooldownBuy.ToolTip.SetTip("Each time your pet teleports it must wait for the spell to cooldown before it can use it again. this ability reduces the amount of time your pet has to wait in-between teleports. Click to purchase.");
	currentTeleportCooldownBuy.MyButton.Caption = "BUY";
	currentTeleportCooldownBuy.MyButton.OnClick = BuyTeleportCooldown;
	currentTeleportDistanceBuy = moButton(currentScrollContainer.List.AddItem("XInterface.moButton", ,"Teleport Distance",true));
    currentTeleportDistanceBuy.ToolTip.SetTip("This ability increases the distance your pet can teleport. Click to purchase.");
	currentTeleportDistanceBuy.MyButton.Caption = "BUY";
	currentTeleportDistanceBuy.MyButton.OnClick = BuyTeleportDistance;
	currentAuraBuy = moButton(currentScrollContainer.List.AddItem("XInterface.moButton", ,"Aura",true));
    currentAuraBuy.ToolTip.SetTip("Auras are special abilities only available at a certain level. Choose an aura that best suits your pet. Pets can only have 1 aura.");
	currentAuraBuy.MyButton.DisableMe();
	currentAuraBuy.MyButton.bVisible = false;
	currentAuraBuy.MyLabel.EnableMe();
	SetDefaultComponent(currentHealthBuy);
	SetDefaultComponent(currentHealthBoostBuy);
	SetDefaultComponent(currentHealthRegenBuy);
	SetDefaultComponent(currentSpeedBuy);
	SetDefaultComponent(currentSpeedBoostBuy);
	SetDefaultComponent(currentDodgeBuy);
	SetDefaultComponent(currentDamageBonusBuy);
	SetDefaultComponent(currentDamageReductionBuy);
	SetDefaultComponent(currentKillBonusBuy);
	SetDefaultComponent(currentXpLeechBuy);
	SetDefaultComponent(currentRespawnTimeBuy);
	SetDefaultComponent(currentTeleportBuy);
	SetDefaultComponent(currentTeleportCooldownBuy);
	SetDefaultComponent(currentTeleportDistanceBuy);
	SetDefaultComponent(currentAuraBuy);
	currentAuraBuy.MyLabel.TextAlign = TXTA_Center;
	Controller.bCurMenuInitialized = bTemp;
	currentModelFOV.SetValue(90);
	currentModelFOV.MyLabel.FontScale = FNS_Small;
	currentModelRotation.MyLabel.FontScale = FNS_Small;
	currentAnimList.MyLabel.FontScale = FNS_Small;
	currentAnimList.MyComboBox.Edit.FontScale = FNS_Small;
	currentPetClass.StandardHeight = 0.050000;
	currentPetName.MyEditBox.FontScale = FNS_Small;
	currentPetName.MyEditBox.MaxWidth = 20;
	currentPetName.MyLabel.FontScale = FNS_Small;
	currentPetName.MyEditBox.AllowedCharSet = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMONPQRSTUVWXYZ'^()<>[]{}\/|* ";
	currentModelFOV.StandardHeight = 0.05;
	currentModelRotation.StandardHeight = 0.05;
    CheckPetName();
	Initialize();
}

function CreateAuraMenu()
{
	local int MenuOptionIndex;

	if(MyPetStats.Aura == 0)
	{
		if(currentRespecBuy != None)
		{
			MenuOptionIndex = currentScrollContainer.List.Find("Aura Respec");
			if(MenuOptionIndex != -1)
			{
				currentScrollContainer.List.RemoveItem(MenuOptionIndex);
				currentRespecBuy = None;
			}
		}

		if(currentAuraSelectedBuy != None)
		{
			MenuOptionIndex = currentScrollContainer.List.Find("Aura Value");
			if(MenuOptionIndex != -1)
			{
				currentScrollContainer.List.RemoveItem(MenuOptionIndex);
				currentAuraSelectedBuy = None;
			}
		}

		if(currentAuraSelectedRadiusBuy != None)
		{
			MenuOptionIndex = currentScrollContainer.List.Find("Aura Second Value");
			if(MenuOptionIndex != -1)
			{
				currentScrollContainer.List.RemoveItem(MenuOptionIndex);
				currentAuraSelectedRadiusBuy = None;
			}
		}

		if(currentCompanionPetName != None)
		{
			MenuOptionIndex = currentScrollContainer.List.Find("Companion Name");
			if(MenuOptionIndex != -1)
			{
				currentScrollContainer.List.RemoveItem(MenuOptionIndex);
				currentCompanionPetName = None;
			}
		}

		if(!MyPetStats.Ability_AuraHeal.bDisabled && AuraHealthBuy == None)
		{
			AuraHealthBuy = moButton(currentScrollContainer.List.AddItem("XInterface.moButton", ,"Heal (Aura)",true));
			AuraHealthBuy.ToolTip.SetTip("The heal aura heals all nearby friendly players and pets, the amount and radius is upgradable. Click to purchase.");
			AuraHealthBuy.MyButton.Caption = "Select";
			AuraHealthBuy.MyButton.OnClick = SetAuraHealth;
			SetDefaultComponent(AuraHealthBuy);
			AuraHealthBuy.ComponentWidth = 0.25;
		}

		if(!MyPetStats.Ability_AuraDamage.bDisabled && AuraDamageBuy == None)
		{
			AuraDamageBuy = moButton(currentScrollContainer.List.AddItem("XInterface.moButton", ,"Damage (Aura)",true));
			AuraDamageBuy.ToolTip.SetTip("The damage aura damages all nearby enemies, the amount and radius is upgradable.");
			AuraDamageBuy.MyButton.Caption = "Select";
			AuraDamageBuy.MyButton.OnClick = SetAuraDamage;
			SetDefaultComponent(AuraDamageBuy);
			AuraDamageBuy.ComponentWidth = 0.25;
		}

		if(!MyPetStats.Ability_AuraDefense.bDisabled && AuraDefenseBuy == None)
		{
			AuraDefenseBuy = moButton(currentScrollContainer.List.AddItem("XInterface.moButton", ,"Defense (Aura)",true));
			AuraDefenseBuy.ToolTip.SetTip("The defense aura allows the pet to deflect enemy projectiles, the pet also receives a shield which absorbs damage. The deflection radius and shield amount is upgradable.");
			AuraDefenseBuy.MyButton.Caption = "Select";
			AuraDefenseBuy.MyButton.OnClick = SetAuraDefense;
			SetDefaultComponent(AuraDefenseBuy);
			AuraDefenseBuy.ComponentWidth = 0.25;
		}

		if(!MyPetStats.Ability_AuraCompanion.bDisabled && AuraPetBuy == None)
		{
			AuraPetBuy = moButton(currentScrollContainer.List.AddItem("XInterface.moButton", ,"Companion (Aura)",true));
			AuraPetBuy.ToolTip.SetTip("This ability allows you to choose a second pet to accompany your main pet. The second pet inherits most of the stats the first one has.");
			AuraPetBuy.MyButton.Caption = "Select";
			AuraPetBuy.MyButton.OnClick = SetAuraCompanion;
			SetDefaultComponent(AuraPetBuy);
			AuraPetBuy.ComponentWidth = 0.25;
		}

		if(!MyPetStats.Ability_AuraFrost.bDisabled && AuraFrostBuy == None)
		{
			AuraFrostBuy = moButton(currentScrollContainer.List.AddItem("XInterface.moButton", ,"Frost (Aura)",true));
			AuraFrostBuy.ToolTip.SetTip("The frost aura slows down nearby enemies by a percentage of their speed, the amount and radius is upgradable.");
			AuraFrostBuy.MyButton.Caption = "Select";
			AuraFrostBuy.MyButton.OnClick = SetAuraFrost;
			SetDefaultComponent(AuraFrostBuy);
			AuraFrostBuy.ComponentWidth = 0.25;
		}

		if(!MyPetStats.Ability_AuraChainLightning.bDisabled && AuraLightningBuy == None)
		{
			AuraLightningBuy = moButton(currentScrollContainer.List.AddItem("XInterface.moButton", ,"Chain Lightning (Aura)",true));
			AuraLightningBuy.ToolTip.SetTip("The chain lightning aura gives the pet a chance to cause a chain lightning effect when the pet causes damage, the damage and chain lightning range is upgradable.");
			AuraLightningBuy.MyButton.Caption = "Select";
			AuraLightningBuy.MyButton.OnClick = SetAuraChainLightning;
			SetDefaultComponent(AuraLightningBuy);
			AuraLightningBuy.ComponentWidth = 0.25;
		}

		if(!MyPetStats.Ability_AuraResurrect.bDisabled && AuraResurrectBuy == None)
		{
			AuraResurrectBuy = moButton(currentScrollContainer.List.AddItem("XInterface.moButton", ,"Necromancer (Aura)",true));
			AuraResurrectBuy.ToolTip.SetTip("The necromancer aura allows the pet to resurrect fallen enemies as friendly minions for a short period of time, the starting health percentage of the minions and radius of this ability is upgradable.");
			AuraResurrectBuy.MyButton.Caption = "Select";
			AuraResurrectBuy.MyButton.OnClick = SetAuraResurrect;
			SetDefaultComponent(AuraResurrectBuy);
			AuraResurrectBuy.ComponentWidth = 0.25;
		}

		if(!MyPetStats.Ability_AuraRetribution.bDisabled && AuraRetributionBuy == None)
		{
			AuraRetributionBuy = moButton(currentScrollContainer.List.AddItem("XInterface.moButton", ,"Retribution (Aura)",true));
			AuraRetributionBuy.ToolTip.SetTip("The retribution aura causes a percentage of the damage taken by the pet to be mirrored back to the attacker. The amount is upgradable.");
			AuraRetributionBuy.MyButton.Caption = "Select";
			AuraRetributionBuy.MyButton.OnClick = SetAuraRetribution;
			SetDefaultComponent(AuraRetributionBuy);
			AuraRetributionBuy.ComponentWidth = 0.25;
		}
	}
	else
	{
		CreateAuraOptions();
	}
}

function CreateAuraOptions()
{
	local int MenuOptionIndex;

	if(MyPetStats.Aura != 0)
	{
		if(AuraHealthBuy != None)
		{
			MenuOptionIndex = currentScrollContainer.List.Find("Heal (Aura)");
			if(MenuOptionIndex != -1)
			{
				currentScrollContainer.List.RemoveItem(MenuOptionIndex);
				AuraHealthBuy = None;
			}
		}

		if(AuraDamageBuy != None)
		{
			MenuOptionIndex = currentScrollContainer.List.Find("Damage (Aura)");
			if(MenuOptionIndex != -1)
			{
				currentScrollContainer.List.RemoveItem(MenuOptionIndex);
				AuraDamageBuy = None;
			}
		}

		if(AuraDefenseBuy != None)
		{
			MenuOptionIndex = currentScrollContainer.List.Find("Defense (Aura)");
			if(MenuOptionIndex != -1)
			{
				currentScrollContainer.List.RemoveItem(MenuOptionIndex);
				AuraDefenseBuy = None;
			}
		}

		if(AuraPetBuy != None)
		{
			MenuOptionIndex = currentScrollContainer.List.Find("Companion (Aura)");
			if(MenuOptionIndex != -1)
			{
				currentScrollContainer.List.RemoveItem(MenuOptionIndex);
				AuraPetBuy = None;
			}
		}

		if(AuraFrostBuy != None)
		{
			MenuOptionIndex = currentScrollContainer.List.Find("Frost (Aura)");
			if(MenuOptionIndex != -1)
			{
				currentScrollContainer.List.RemoveItem(MenuOptionIndex);
				AuraFrostBuy = None;
			}
		}

		if(AuraLightningBuy != None)
		{
			MenuOptionIndex = currentScrollContainer.List.Find("Chain Lightning (Aura)");
			if(MenuOptionIndex != -1)
			{
				currentScrollContainer.List.RemoveItem(MenuOptionIndex);
				AuraLightningBuy = None;
			}
		}

		if(AuraResurrectBuy != None)
		{
			MenuOptionIndex = currentScrollContainer.List.Find("Necromancer (Aura)");
			if(MenuOptionIndex != -1)
			{
				currentScrollContainer.List.RemoveItem(MenuOptionIndex);
				AuraResurrectBuy = None;
			}
		}

		if(AuraRetributionBuy != None)
		{
			MenuOptionIndex = currentScrollContainer.List.Find("Retribution (Aura)");
			if(MenuOptionIndex != -1)
			{
				currentScrollContainer.List.RemoveItem(MenuOptionIndex);
				AuraRetributionBuy = None;
			}
		}

		if(currentAuraSelectedBuy == None)
		{
			currentAuraSelectedBuy = moButton(currentScrollContainer.List.AddItem("XInterface.moButton", ,"Aura Value",true));
			currentAuraSelectedBuy.MyButton.Caption = "BUY";
			SetDefaultComponent(currentAuraSelectedBuy);
			currentAuraSelectedBuy.MyButton.OnClick = BuyAuraPower;
		}

		if(currentAuraSelectedRadiusBuy == None)
		{
			currentAuraSelectedRadiusBuy = moButton(currentScrollContainer.List.AddItem("XInterface.moButton", ,"Aura Second Value",true));
			currentAuraSelectedRadiusBuy.MyButton.Caption = "BUY";
			SetDefaultComponent(currentAuraSelectedRadiusBuy);
			currentAuraSelectedRadiusBuy.MyButton.OnClick = BuyAuraRadius;
		}

		Switch(MyPetStats.Aura)
		{
			case 1:
				currentAuraSelectedBuy.ToolTip.SetTip("Increases the amount of health healed by the heal aura. Click to purchase.");
				currentAuraSelectedRadiusBuy.ToolTip.SetTip("Increases the radius of the heal aura. Click to purchase.");
			break;
			case 2:
				currentAuraSelectedBuy.ToolTip.SetTip("Increases the amount of damage done by the damage aura. Click to purchase.");
				currentAuraSelectedRadiusBuy.ToolTip.SetTip("Increases the radius of the damage aura. Click to purchase.");
			break;
			case 3:
				currentAuraSelectedBuy.ToolTip.SetTip("Increases the amount of damage absorbed by the shield aura, the shield energy slowly regenerates over time. Click to purchase.");
				currentAuraSelectedRadiusBuy.ToolTip.SetTip("Increases the radius of the defense aura, deflecting projectiles that are further away. Click to purchase.");
			break;
			case 4:
				if(currentAuraSelectedRadiusBuy != None)
				{
					MenuOptionIndex = currentScrollContainer.List.Find("Aura Second Value");
					if(MenuOptionIndex != -1)
					{
						currentScrollContainer.List.RemoveItem(MenuOptionIndex);
						currentAuraSelectedRadiusBuy = None;
					}
				}

				currentAuraSelectedBuy.MyLabel.Caption = "Companion Species";
				currentAuraSelectedBuy.MyButton.Caption = "Choose Companion Pet";
				currentAuraSelectedBuy.ToolTip.SetTip("Click to choose a new companion for your pet. The new companion pet must wait 30 seconds before it's first spawn, it then inherits your pets respawn time.");
				if(currentCompanionPetName == None)
				{
					currentCompanionPetName = moEditBox(currentScrollContainer.List.AddItem("XInterface.moEditBox", ,"Companion Name",true));
					SetDefaultComponent(currentCompanionPetName);
					currentCompanionPetName.ComponentWidth = 0.5;
					currentCompanionPetName.MyEditBox.AllowedCharSet = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMONPQRSTUVWXYZ'^()<>[]{}\/|* ";
					currentCompanionPetName.OnDeActivate = PetNameUnFocus;
				}
				currentAuraSelectedBuy.ComponentWidth = 0.5;
				currentAuraSelectedBuy.MyButton.OnClick = OpenAuraPetMenu;
			break;
			case 5:
				currentAuraSelectedBuy.ToolTip.SetTip("Increases the percentage of slowing force applied to enemies. Click to purchase.");
				currentAuraSelectedRadiusBuy.ToolTip.SetTip("Increases the radius of the frost aura. Click to purchase.");
			break;
			case 6:
				currentAuraSelectedBuy.ToolTip.SetTip("Increases the amount of damage done by the chain lightning effect. Click to purchase.");
				currentAuraSelectedRadiusBuy.ToolTip.SetTip("Chain lightning will jump to enemies within this range. Click to purchase.");
			break;
			case 7:
				currentAuraSelectedBuy.ToolTip.SetTip("Increases the amount of health resurrected minions spawn with. Click to purchase.");
				currentAuraSelectedRadiusBuy.ToolTip.SetTip("Increase the range at which the pet can resurrect enemies from. Click to purchase.");
			break;
			case 8:
				currentAuraSelectedBuy.ToolTip.SetTip("Increases the percentage of damage reflected back at the attacker. Click to purchase.");
				if(currentAuraSelectedRadiusBuy != None)
				{
					MenuOptionIndex = currentScrollContainer.List.Find("Aura Second Value");
					if(MenuOptionIndex != -1)
					{
						currentScrollContainer.List.RemoveItem(MenuOptionIndex);
						currentAuraSelectedRadiusBuy = None;
					}
				}
			break;
			default:
				currentAuraBuy.MyLabel.Caption = "Aura (Available Level "$MyPetStats.UnlockAuraLevel$")";
			break;
		}

		//add respec button to bottom of aura options
		if(currentRespecBuy == None)
		{
			currentRespecBuy = moButton(currentScrollContainer.List.AddItem("XInterface.moButton", ,"Aura Respec",true));
			currentRespecBuy.ToolTip.SetTip("Click to change the aura type for your pet if you have enough points.");
			currentRespecBuy.MyButton.Caption = "RESPEC";
			SetDefaultComponent(currentRespecBuy);
			currentRespecBuy.MyButton.OnClick = RespecAura;
		}

		currentScrollContainer.List.MyScrollBar.WheelUp();
	}
}

function bool BuyAuraPower(GUIComponent Sender)
{
	Switch(MyPetStats.Aura)
	{
		case 1:
			MyPetStats.UpdateAbility("AuraHeal");
		break;
		case 2:
			MyPetStats.UpdateAbility("AuraDamage");
		break;
		case 3:
			MyPetStats.UpdateAbility("AuraHeal");
		break;
		case 5:
			MyPetStats.UpdateAbility("AuraFrost");
		break;
		case 6:
			MyPetStats.UpdateAbility("AuraChainLightning");
		break;
		case 7:
			MyPetStats.UpdateAbility("AuraResurrect");
		break;
		case 8:
			MyPetStats.UpdateAbility("AuraRetribution");
		break;
		default:
		break;
	}

	PlayerOwner().ClientReliablePlaySound(Sound'Pet_Upgrade');

	return true;
}

function bool BuyAuraRadius(GUIComponent Sender)
{
	Switch(MyPetStats.Aura)
	{
		case 1:
			MyPetStats.UpdateAbility("AuraHealRadius");
		break;
		case 2:
			MyPetStats.UpdateAbility("AuraDamageRadius");
		break;
		case 3:
			MyPetStats.UpdateAbility("AuraHealRadius");
		break;
		case 5:
			MyPetStats.UpdateAbility("AuraFrostRadius");
		break;
		case 6:
			MyPetStats.UpdateAbility("AuraChainLightningRadius");
		break;
		case 7:
			MyPetStats.UpdateAbility("AuraResurrectRadius");
		break;
		default:
		break;
	}

	PlayerOwner().ClientReliablePlaySound(Sound'Pet_Upgrade');

	return true;
}

function bool BuyHealth(GUIComponent Sender)
{
	MyPetStats.UpdateAbility("Health");
	PlayerOwner().ClientReliablePlaySound(Sound'Pet_Upgrade');
	return true;
}

function bool BuyHealthBoost(GUIComponent Sender)
{
	MyPetStats.UpdateAbility("HealthBoost");
	PlayerOwner().ClientReliablePlaySound(Sound'Pet_Upgrade');
	return true;
}

function bool BuyHealthRegen(GUIComponent Sender)
{
	MyPetStats.UpdateAbility("HealthRegen");
	PlayerOwner().ClientReliablePlaySound(Sound'Pet_Upgrade');
	return true;
}

function bool BuySpeed(GUIComponent Sender)
{
	MyPetStats.UpdateAbility("Speed");
	PlayerOwner().ClientReliablePlaySound(Sound'Pet_Upgrade');
	return true;
}

function bool BuySpeedBoost(GUIComponent Sender)
{
	MyPetStats.UpdateAbility("SpeedBoost");
	PlayerOwner().ClientReliablePlaySound(Sound'Pet_Upgrade');
	return true;
}

function bool BuyDodgeSkill(GUIComponent Sender)
{
	MyPetStats.UpdateAbility("Dodge");
	PlayerOwner().ClientReliablePlaySound(Sound'Pet_Upgrade');
	return true;
}

function bool BuyDamageBonus(GUIComponent Sender)
{
	MyPetStats.UpdateAbility("DamageBonus");
	PlayerOwner().ClientReliablePlaySound(Sound'Pet_Upgrade');
	return true;
}

function bool BuyArmor(GUIComponent Sender)
{
	MyPetStats.UpdateAbility("DamageReduction");
	PlayerOwner().ClientReliablePlaySound(Sound'Pet_Upgrade');
	return true;
}

function bool BuyRespawnTime(GUIComponent Sender)
{
	MyPetStats.UpdateAbility("Respawn");
	PlayerOwner().ClientReliablePlaySound(Sound'Pet_Upgrade');
	return true;
}

function bool BuyTeleport(GUIComponent Sender)
{
	MyPetStats.UpdateAbility("Teleport");
	PlayerOwner().ClientReliablePlaySound(Sound'Pet_Upgrade');
	return true;
}

function bool BuyTeleportCooldown(GUIComponent Sender)
{
	MyPetStats.UpdateAbility("TeleportTime");
	PlayerOwner().ClientReliablePlaySound(Sound'Pet_Upgrade');
	return true;
}

function bool BuyTeleportDistance(GUIComponent Sender)
{
	MyPetStats.UpdateAbility("TeleportDistance");
	PlayerOwner().ClientReliablePlaySound(Sound'Pet_Upgrade');
	return true;
}

function bool BuyKillBonus(GUIComponent Sender)
{
	MyPetStats.UpdateAbility("KillBonus");
	PlayerOwner().ClientReliablePlaySound(Sound'Pet_Upgrade');
	return true;
}

function bool BuyXpLeech(GUIComponent Sender)
{
	MyPetStats.UpdateAbility("XpLeech");
	PlayerOwner().ClientReliablePlaySound(Sound'Pet_Upgrade');
	return true;
}

function bool SetAuraHealth(GUIComponent Sender)
{
	UpdateAbility("Aura",true,"1");
	PlayerOwner().ClientReliablePlaySound(Sound'Pet_Upgrade');
	return true;
}

function bool SetAuraDamage(GUIComponent Sender)
{
	UpdateAbility("Aura",true,"2");
	PlayerOwner().ClientReliablePlaySound(Sound'Pet_Upgrade');
	return true;
}

function bool SetAuraDefense(GUIComponent Sender)
{
	UpdateAbility("Aura",true,"3");
	PlayerOwner().ClientReliablePlaySound(Sound'Pet_Upgrade');
	return true;
}

function bool SetAuraCompanion(GUIComponent Sender)
{
	UpdateAbility("Aura",true,"4");
	PlayerOwner().ClientReliablePlaySound(Sound'Pet_Upgrade');
	return true;
}

function bool SetAuraFrost(GUIComponent Sender)
{
	UpdateAbility("Aura",true,"5");
	PlayerOwner().ClientReliablePlaySound(Sound'Pet_Upgrade');
	return true;
}

function bool SetAuraChainLightning(GUIComponent Sender)
{
	UpdateAbility("Aura",true,"6");
	PlayerOwner().ClientReliablePlaySound(Sound'Pet_Upgrade');
	return true;
}

function bool SetAuraResurrect(GUIComponent Sender)
{
	UpdateAbility("Aura",true,"7");
	PlayerOwner().ClientReliablePlaySound(Sound'Pet_Upgrade');
	return true;
}

function bool SetAuraRetribution(GUIComponent Sender)
{
	UpdateAbility("Aura",true,"8");
	PlayerOwner().ClientReliablePlaySound(Sound'Pet_Upgrade');
	return true;
}

function SetDefaultComponent(GUIMenuOption PassedComponent)
{
	PassedComponent.CaptionWidth = 1;
	PassedComponent.ComponentWidth = 0.15;
	PassedComponent.ComponentJustification = TXTA_Right;
	PassedComponent.bStandardized = false;
	PassedComponent.bBoundToParent = False;
	PassedComponent.bScaleToParent = False;
	if(moButton(PassedComponent) != None)
	{
		moButton(PassedComponent).MyButton.FontScale = FNS_Small;
	}

	if(PassedComponent.MyLabel != None)
	{
		PassedComponent.MyLabel.TextAlign = TXTA_Left;
		PassedComponent.MyLabel.FontScale = FNS_Small;
	}
}

function Initialize()
{
	CreateAuraMenu();
	if(MyPetStats.bTierMode)
	{
		currentTierModeLabel.bVisible = true;
	}

	currentPetName.myEditBox.bReadOnly = true;
	if(currentCompanionPetName != None)
	{
		currentCompanionPetName.myEditBox.bReadOnly = true;
	}

	if(!PlayerHasPet())
	{
		DeactivatedState();
	}
	else
	{
		ActivatedState();
	}

	SetPetSelectButton();
}

function string GetPetShortName(string TestString)
{
	local string StringLeft, StringRight;

	if(Divide(TestString, ".", StringLeft, StringRight))
	{
		return Left(StringRight, 16);
	}

	return "";
}

function DeactivatedState()
{
	currentPetClass.Caption = "Species: ";
	UpdateSpinnyDude();
}

function bool OpenSelectPetMenu(GUIComponent Sender)
{
	if(Sender == button_commitpet)
	{
		PlayerOwner().ClientOpenMenu("InvasionProv1_7.InvasionProPetSelectionMenu");
	}

	return true;
}

function bool OpenAuraPetMenu(GUIComponent Sender)
{
	PlayerOwner().ClientOpenMenu("InvasionProv1_7.InvasionProAdditionalPetSelectionMenu");
	return true;
}

function bool ValidName(String TestName)
{
	if(TestName ~= "" || TestName ~= "None")
	{
		return false;
	}

	return true;
}

function bool ValidPackage(String TestName)
{
	local string PackageLeft, PackageRight;

	if(TestName ~= "" || TestName ~= "None")
	{
		return false;
	}

	if(!Divide(TestName,".",PackageLeft, PackageRight))
	{
		return false;
	}

	return true;
}

function SetPetSelectButton()
{
	button_commitpet.DisableMe();

	if(MyPetStats.bTierMode)
	{
		button_commitpet.Caption = "Select Pet (Tier "$MyPetStats.Tier$")";

		if(MyPetStats.PetCanEvolve() || !PlayerHasPet())
		{
			button_commitpet.EnableMe();
		}
	}
	else
	{
		button_commitpet.Caption = default.button_commitpet.Caption;
		if(!PlayerHasPet())
		{
			button_commitpet.EnableMe();
		}
	}
}

function ActivatedState()
{
	local string PetName;

	PetName = GetPetShortName(MyPetStats.PetClass);
	currentPetClass.Caption = "Species: "$PetName;
	currentPetName.SetComponentValue(MyPetStats.PetName);
	currentPetName.myEditBox.bReadOnly = false;
	if(currentCompanionPetName != None)
	{
		currentCompanionPetName.SetComponentValue(MyPetStats.DTPetName);
		currentCompanionPetName.myEditBox.bReadOnly = false;
	}

	UpdateAbility("Orders",false,MyPetStats.PetOrders);
	UpdateSpinnyDude();
}

function UpdatePointsLabel()
{
	if(MyPetStats.bTierMode)
	{
		currentPointsLabel.Caption = default.currentPointsLabel.Caption$int(MyPetStats.Points)$" | "$"Level: "$MyPetStats.PetLevel$"/"$MyPetStats.MaxLevel$" | "$"Tier: "$MyPetStats.Tier$"/"$MyPetStats.MaxTier;
	}
	else
	{
		currentPointsLabel.Caption = default.currentPointsLabel.Caption$int(MyPetStats.Points)$" | "$"Level: "$MyPetStats.PetLevel$"/"$MyPetStats.MaxLevel;
	}
}

function SetConfigs()
{
	Switch(MyPetStats.Aura)
	{
		case 1:
			currentAuraBuy.MyLabel.Caption = "Aura (Heal)";
			currentAuraSelectedBuy.MyLabel.Caption = "Heal Amount"$" (+"$MyPetStats.AAxp*MyPetStats.Ability_AuraHeal.AuraHealIncrease$") "$"+"$MyPetStats.Ability_AuraHeal.AuraHealIncrease$" Costs "$MyPetStats.Ability_AuraHeal.AuraHealIncreaseCost;
			currentAuraSelectedRadiusBuy.MyLabel.Caption = "Heal Radius"$" (+"$MyPetStats.ABxp*MyPetStats.Ability_AuraHeal.AuraRadiusIncrease$") "$"+"$MyPetStats.Ability_AuraHeal.AuraRadiusIncrease$" Costs "$MyPetStats.Ability_AuraHeal.AuraRadiusIncreaseCost;
		break;
		case 2:
			currentAuraBuy.MyLabel.Caption = "Aura (Damage)";
			currentAuraSelectedBuy.MyLabel.Caption = "Damage Amount"$" (+"$MyPetStats.AAxp*MyPetStats.Ability_AuraDamage.AuraDamageIncrease$") "$"+"$MyPetStats.Ability_AuraDamage.AuraDamageIncrease$" Costs "$MyPetStats.Ability_AuraDamage.AuraDamageIncreaseCost;
			currentAuraSelectedRadiusBuy.MyLabel.Caption = "Damage Radius"$" (+"$MyPetStats.ABxp*MyPetStats.Ability_AuraDamage.AuraRadiusIncrease$") "$"+"$MyPetStats.Ability_AuraDamage.AuraRadiusIncrease$" Costs "$MyPetStats.Ability_AuraDamage.AuraRadiusIncreaseCost;
		break;
		case 3:
			currentAuraBuy.MyLabel.Caption = "Aura (Defense)";
			currentAuraSelectedBuy.MyLabel.Caption = "Shield Energy"$" (+"$MyPetStats.AAxp*MyPetStats.Ability_AuraDefense.AuraDefenseIncrease$") "$"+"$MyPetStats.Ability_AuraDefense.AuraDefenseIncrease$" Costs "$MyPetStats.Ability_AuraDefense.AuraDefenseIncreaseCost;
			currentAuraSelectedRadiusBuy.MyLabel.Caption = "Deflection Radius"$" (+"$MyPetStats.ABxp*MyPetStats.Ability_AuraDefense.AuraRadiusIncrease$") "$"+"$MyPetStats.Ability_AuraDefense.AuraRadiusIncrease$" Costs "$MyPetStats.Ability_AuraDefense.AuraRadiusIncreaseCost;
		break;
		case 4:
			if(GetPetShortName(MyPetStats.DTClass) != "")
			{
				currentAuraBuy.MyLabel.Caption = "Aura (Companion | "$GetPetShortName(MyPetStats.DTClass)$")";
			}
			else
			{
				currentAuraBuy.MyLabel.Caption = "Aura (Companion)";
			}

		break;
		case 5:
			currentAuraBuy.MyLabel.Caption = "Aura (Frost)";
			currentAuraSelectedBuy.MyLabel.Caption = "Frost Effect"$" (+"$MyPetStats.AAxp*MyPetStats.Ability_AuraFrost.AuraFrostIncrease$"%) "$"+"$MyPetStats.Ability_AuraFrost.AuraFrostIncrease$" Costs "$MyPetStats.Ability_AuraFrost.AuraFrostIncreaseCost;
			currentAuraSelectedRadiusBuy.MyLabel.Caption = "Frost Radius"$" (+"$MyPetStats.ABxp*MyPetStats.Ability_AuraFrost.AuraRadiusIncrease$") "$"+"$MyPetStats.Ability_AuraFrost.AuraRadiusIncrease$" Costs "$MyPetStats.Ability_AuraFrost.AuraRadiusIncreaseCost;
		break;
		case 6:
			currentAuraBuy.MyLabel.Caption = "Aura (Chain Lightning)";
			currentAuraSelectedBuy.MyLabel.Caption = "Chain Lightning Damage"$" (+"$MyPetStats.AAxp*MyPetStats.Ability_AuraChainLightning.AuraChainLightningIncrease$") "$"+"$MyPetStats.Ability_AuraChainLightning.AuraChainLightningIncrease$" Costs "$MyPetStats.Ability_AuraChainLightning.AuraChainLightningIncreaseCost;
			currentAuraSelectedRadiusBuy.MyLabel.Caption = "Chain Lightning Radius"$" (+"$MyPetStats.ABxp*MyPetStats.Ability_AuraChainLightning.AuraRadiusIncrease$") "$"+"$MyPetStats.Ability_AuraChainLightning.AuraRadiusIncrease$" Costs "$MyPetStats.Ability_AuraChainLightning.AuraRadiusIncreaseCost;
		break;
		case 7:
			currentAuraBuy.MyLabel.Caption = "Aura (Necromancer)";
			currentAuraSelectedBuy.MyLabel.Caption = "Minion Base Health"$" (+"$MyPetStats.AAxp*MyPetStats.Ability_AuraResurrect.AuraResurrectIncrease$") "$"+"$MyPetStats.Ability_AuraResurrect.AuraResurrectIncrease$" Costs "$MyPetStats.Ability_AuraResurrect.AuraResurrectIncreaseCost;
			currentAuraSelectedRadiusBuy.MyLabel.Caption = "Resurrection Radius"$" (+"$MyPetStats.ABxp*MyPetStats.Ability_AuraResurrect.AuraRadiusIncrease$") "$"+"$MyPetStats.Ability_AuraResurrect.AuraRadiusIncrease$" Costs "$MyPetStats.Ability_AuraResurrect.AuraRadiusIncreaseCost;
		break;
		case 8:
			currentAuraBuy.MyLabel.Caption = "Aura (Retribution)";
			currentAuraSelectedBuy.MyLabel.Caption = "Retribution Damage"$" (+"$MyPetStats.AAxp*MyPetStats.Ability_AuraRetribution.AuraRetributionIncrease$"%) "$"+"$MyPetStats.Ability_AuraRetribution.AuraRetributionIncrease$" Costs "$MyPetStats.Ability_AuraRetribution.AuraRetributionIncreaseCost;
		break;
		default:
			currentAuraBuy.MyLabel.Caption = "Aura (Available Level "$MyPetStats.UnlockAuraLevel$")";
		break;
	}

	if(currentRespecBuy != None)
	{
		currentRespecBuy.MyLabel.Caption = "Aura Respec Costs "$MyPetStats.AuraRespecCost;
	}

	currentHealthBuy.MyLabel.Caption = "Health"$" ("$MyPetStats.Ability_Health.BasePetHealth+(MyPetStats.HpXp*MyPetStats.Ability_Health.HealthIncrease)$") "$"+"$MyPetStats.Ability_Health.HealthIncrease$" Costs "$MyPetStats.Ability_Health.HealthIncreaseCost;
	currentHealthBoostBuy.MyLabel.Caption = "Health Boost"$" (+"$MyPetStats.HpBoost*MyPetStats.Ability_HealthBoost.HealthBoostIncrease$"%) "$"+"$MyPetStats.Ability_HealthBoost.HealthBoostIncrease$"%"$" Costs "$MyPetStats.Ability_HealthBoost.HealthBoostIncreaseCost;
	currentHealthRegenBuy.MyLabel.Caption = "Health Regen"$" (+"$MyPetStats.HpRegenXp*MyPetStats.Ability_HealthRegen.HealthRegenIncrease$") "$"+"$MyPetStats.Ability_HealthRegen.HealthRegenIncrease$" Costs "$MyPetStats.Ability_HealthRegen.HealthRegenIncreaseCost;
	currentSpeedBuy.MyLabel.Caption = "Speed"$" ("$MyPetStats.Ability_Speed.BasePetSpeed+(MyPetStats.SdXp*MyPetStats.Ability_Speed.SpeedIncrease)$") "$"+"$MyPetStats.Ability_Speed.SpeedIncrease$" Costs "$MyPetStats.Ability_Speed.SpeedIncreaseCost;
	currentSpeedBoostBuy.MyLabel.Caption = "Speed Boost"$" (+"$MyPetStats.SdBoost*MyPetStats.Ability_SpeedBoost.SpeedBoostIncrease$"%) "$"+"$MyPetStats.Ability_SpeedBoost.SpeedBoostIncrease$"%"$" Costs "$MyPetStats.Ability_SpeedBoost.SpeedBoostIncreaseCost;
	currentDodgeBuy.MyLabel.Caption = "Dodge Skill"$" (+"$MyPetStats.DdgXp*MyPetStats.Ability_Dodge.DodgeIncrease$") "$"+"$MyPetStats.Ability_Dodge.DodgeIncrease$" Costs "$MyPetStats.Ability_Dodge.DodgeIncreaseCost;
	currentDamageBonusBuy.MyLabel.Caption = "Damage Bonus"$" (+"$MyPetStats.DmgXp*MyPetStats.Ability_DamageBonus.DamageBonusIncrease$"%) "$"+"$MyPetStats.Ability_DamageBonus.DamageBonusIncrease$"%"$" Costs "$MyPetStats.Ability_DamageBonus.DamageBonusIncreaseCost;
	currentDamageReductionBuy.MyLabel.Caption = "Armor"$" (+"$MyPetStats.ArmorXp*MyPetStats.Ability_DamageReduction.DamageReductionIncrease$"%) "$"+"$MyPetStats.Ability_DamageReduction.DamageReductionIncrease$"%"$" Costs "$MyPetStats.Ability_DamageReduction.DamageReductionIncreaseCost;
	currentRespawnTimeBuy.MyLabel.Caption = "Respawn Time"$" (-"$MyPetStats.SpwnXp*MyPetStats.Ability_Respawn.RespawnIncrease$"%) "$"-"$MyPetStats.Ability_Respawn.RespawnIncrease$"%"$" Costs "$MyPetStats.Ability_Respawn.RespawnIncreaseCost;
	currentKillBonusBuy.MyLabel.Caption = "Kill Bonus"$" (+"$MyPetStats.KBXp*MyPetStats.Ability_KillBonus.KillBonusIncrease$") "$"+"$MyPetStats.Ability_KillBonus.KillBonusIncrease$" Costs "$MyPetStats.Ability_KillBonus.KillBonusIncreaseCost;

	if(MyPetStats.XpL > 0)
	{
		currentXpLeechBuy.MyLabel.Caption = "Xp Leech (Purchased)";
	}
	else
	{
		currentXpLeechBuy.MyLabel.Caption = "Xp Leech"$" Costs "$MyPetStats.Ability_XpLeech.XpLeechCost;
	}

	if(MyPetStats.TlprtXp > 0)
	{
		currentTeleportBuy.MyLabel.Caption = "Teleport (Purchased)";
	}
	else
	{
		currentTeleportBuy.MyLabel.Caption = "Teleport"$" Costs "$MyPetStats.Ability_Teleport.TeleportCost;
	}

	currentTeleportCooldownBuy.MyLabel.Caption = "Teleport Cooldown"$" (-"$MyPetStats.TlprtDwnXp*MyPetStats.Ability_TeleportTime.TeleportTimeIncrease$"%) "$"-"$MyPetStats.Ability_TeleportTime.TeleportTimeIncrease$"%"$" Costs "$MyPetStats.Ability_TeleportTime.TeleportTimeIncreaseCost;
	currentTeleportDistanceBuy.MyLabel.Caption = "Teleport Distance"$" ("$MyPetStats.Ability_TeleportDistance.BaseTeleportDistance+(MyPetStats.TlprtDstXp*MyPetStats.Ability_TeleportDistance.TeleportDistanceIncrease)$") "$"+"$MyPetStats.Ability_TeleportDistance.TeleportDistanceIncrease$" Costs "$MyPetStats.Ability_TeleportDistance.TeleportDistanceIncreaseCost;
}

function UpdateAbilities()
{
	UpdateBuyButtons();
	SetConfigs();
	UpdatePointsLabel();
}

function UpdateBuyButtons()
{
	local float Points;
	local int PetLevel;

	Points = MyPetStats.Points;
	PetLevel = MyPetStats.PetLevel;
	currentHealthBuy.MyButton.Caption = "BUY";
	currentHealthBoostBuy.MyButton.Caption = "BUY";
	currentHealthRegenBuy.MyButton.Caption = "BUY";
	currentSpeedBuy.MyButton.Caption = "BUY";
	currentSpeedBoostBuy.MyButton.Caption = "BUY";
	currentDodgeBuy.MyButton.Caption = "BUY";
	currentDamageReductionBuy.MyButton.Caption = "BUY";
	currentDamageBonusBuy.MyButton.Caption = "BUY";
	currentRespawnTimeBuy.MyButton.Caption = "BUY";
	currentTeleportBuy.MyButton.Caption = "BUY";
	currentTeleportCooldownBuy.MyButton.Caption = "BUY";
	currentTeleportDistanceBuy.MyButton.Caption = "BUY";
	currentKillBonusBuy.MyButton.Caption = "BUY";
	currentXpLeechBuy.MyButton.Caption = "BUY";

	if(PetLevel >= MyPetStats.Ability_Health.Level)
	{
		if((MyPetStats.Ability_Health.BasePetHealth+(MyPetStats.HpXp*MyPetStats.Ability_Health.HealthIncrease)) < MyPetStats.Ability_Health.HealthMax)
		{
			if(Points >= MyPetStats.Ability_Health.HealthIncreaseCost )
			{
				currentHealthBuy.MyButton.EnableMe();
			}
			else
			{
				currentHealthBuy.MyButton.DisableMe();
			}
		}
		else
		{
			currentHealthBuy.MyButton.Caption = "MAX";
			currentHealthBuy.MyButton.DisableMe();
		}
	}
	else
	{
		currentHealthBuy.MyButton.Caption = "Lvl "$MyPetStats.Ability_Health.Level;
		currentHealthBuy.MyButton.DisableMe();
	}


	if(PetLevel >= MyPetStats.Ability_HealthRegen.Level)
	{
		if((MyPetStats.HpRegenXp*MyPetStats.Ability_HealthRegen.HealthRegenIncrease) < MyPetStats.Ability_HealthRegen.HealthRegenMax)
		{
			if(Points >= MyPetStats.Ability_HealthRegen.HealthRegenIncreaseCost)
			{
				currentHealthRegenBuy.MyButton.EnableMe();
			}
			else
			{
				currentHealthRegenBuy.MyButton.DisableMe();
			}
		}
		else
		{
			currentHealthRegenBuy.MyButton.Caption = "MAX";
			currentHealthRegenBuy.MyButton.DisableMe();
		}
	}
	else
	{
		currentHealthRegenBuy.MyButton.Caption = "Lvl "$MyPetStats.Ability_HealthRegen.Level;
		currentHealthRegenBuy.MyButton.DisableMe();
	}


	if(PetLevel >= MyPetStats.Ability_HealthBoost.Level)
	{
		if((MyPetStats.HpBoost*MyPetStats.Ability_HealthBoost.HealthBoostIncrease) < MyPetStats.Ability_HealthBoost.HealthBoostMax)
		{
			if(Points >= MyPetStats.Ability_HealthBoost.HealthBoostIncreaseCost)
			{
				currentHealthBoostBuy.MyButton.EnableMe();
			}
			else
			{
				currentHealthBoostBuy.MyButton.DisableMe();
			}
		}
		else
		{
			currentHealthBoostBuy.MyButton.Caption = "MAX";
			currentHealthBoostBuy.MyButton.DisableMe();
		}
	}
	else
	{
		currentHealthBoostBuy.MyButton.Caption = "Lvl "$MyPetStats.Ability_HealthBoost.Level;
		currentHealthBoostBuy.MyButton.DisableMe();
	}


	if(PetLevel >= MyPetStats.Ability_Speed.Level)
	{
		if((MyPetStats.Ability_Speed.BasePetSpeed+(MyPetStats.SdXp*MyPetStats.Ability_Speed.SpeedIncrease)) < MyPetStats.Ability_Speed.SpeedMax)
		{
			if(Points >= MyPetStats.Ability_Speed.SpeedIncreaseCost)
			{
				currentSpeedBuy.MyButton.EnableMe();
			}
			else
			{
				currentSpeedBuy.MyButton.DisableMe();
			}
		}
		else
		{
			currentSpeedBuy.MyButton.Caption = "MAX";
			currentSpeedBuy.MyButton.DisableMe();
		}
	}
	else
	{
		currentSpeedBuy.MyButton.Caption = "Lvl "$MyPetStats.Ability_Speed.Level;
		currentSpeedBuy.MyButton.DisableMe();
	}

	if(PetLevel >= MyPetStats.Ability_Dodge.Level)
	{
		if((MyPetStats.DdgXp*MyPetStats.Ability_Dodge.DodgeIncrease) < MyPetStats.Ability_Dodge.DodgeMax)
		{
			if(Points >= MyPetStats.Ability_Dodge.DodgeIncreaseCost)
			{
				currentDodgeBuy.MyButton.EnableMe();
			}
			else
			{
				currentDodgeBuy.MyButton.DisableMe();
			}
		}
		else
		{
			currentDodgeBuy.MyButton.Caption = "MAX";
			currentDodgeBuy.MyButton.DisableMe();
		}
	}
	else
	{
		currentDodgeBuy.MyButton.Caption = "Lvl "$MyPetStats.Ability_Dodge.Level;
		currentDodgeBuy.MyButton.DisableMe();
	}

	if(PetLevel >= MyPetStats.Ability_SpeedBoost.Level)
	{
		if((MyPetStats.SdBoost*MyPetStats.Ability_SpeedBoost.SpeedBoostIncrease) < MyPetStats.Ability_SpeedBoost.SpeedBoostMax)
		{
			if(Points >= MyPetStats.Ability_SpeedBoost.SpeedBoostIncreaseCost)
			{
				currentSpeedBoostBuy.MyButton.EnableMe();
			}
			else
			{
				currentSpeedBoostBuy.MyButton.DisableMe();
			}
		}
		else
		{
			currentSpeedBoostBuy.MyButton.Caption = "MAX";
			currentSpeedBoostBuy.MyButton.DisableMe();
		}
	}
	else
	{
		currentSpeedBoostBuy.MyButton.Caption = "Lvl "$MyPetStats.Ability_SpeedBoost.Level;
		currentSpeedBoostBuy.MyButton.DisableMe();
	}

	if(PetLevel >= MyPetStats.Ability_DamageReduction.Level)
	{
		if((MyPetStats.ArmorXp*MyPetStats.Ability_DamageReduction.DamageReductionIncrease) < MyPetStats.Ability_DamageReduction.DamageReductionMax)
		{
			if(Points >= MyPetStats.Ability_DamageReduction.DamageReductionIncreaseCost)
			{
				currentDamageReductionBuy.MyButton.EnableMe();
			}
			else
			{
				currentDamageReductionBuy.MyButton.DisableMe();
			}
		}
		else
		{
			currentDamageReductionBuy.MyButton.Caption = "MAX";
			currentDamageReductionBuy.MyButton.DisableMe();
		}
	}
	else
	{
		currentDamageReductionBuy.MyButton.Caption = "Lvl "$MyPetStats.Ability_DamageReduction.Level;
		currentDamageReductionBuy.MyButton.DisableMe();
	}

	if(PetLevel >= MyPetStats.Ability_DamageBonus.Level)
	{
		if((MyPetStats.DmgXp*MyPetStats.Ability_DamageBonus.DamageBonusIncrease) < MyPetStats.Ability_DamageBonus.DamageBonusMax)
		{
			if(Points >= MyPetStats.Ability_DamageBonus.DamageBonusIncreaseCost)
			{
				currentDamageBonusBuy.MyButton.EnableMe();
			}
			else
			{
				currentDamageBonusBuy.MyButton.DisableMe();
			}
		}
		else
		{
			currentDamageBonusBuy.MyButton.Caption = "MAX";
			currentDamageBonusBuy.MyButton.DisableMe();
		}
	}
	else
	{
		currentDamageBonusBuy.MyButton.Caption = "Lvl "$MyPetStats.Ability_DamageBonus.Level;
		currentDamageBonusBuy.MyButton.DisableMe();
	}

	if(PetLevel >= MyPetStats.Ability_Respawn.Level)
	{
		if((MyPetStats.SpwnXp*MyPetStats.Ability_Respawn.RespawnIncrease) < MyPetStats.Ability_Respawn.RespawnMax)
		{
			if(Points >= MyPetStats.Ability_Respawn.RespawnIncreaseCost)
			{
				currentRespawnTimeBuy.MyButton.EnableMe();
			}
			else
			{
				currentRespawnTimeBuy.MyButton.DisableMe();
			}
		}
		else
		{
			currentRespawnTimeBuy.MyButton.Caption = "MAX";
			currentRespawnTimeBuy.MyButton.DisableMe();
		}
	}
	else
	{
		currentRespawnTimeBuy.MyButton.Caption = "Lvl "$MyPetStats.Ability_Respawn.Level;
		currentRespawnTimeBuy.MyButton.DisableMe();
	}

	if(PetLevel >= MyPetStats.Ability_Teleport.Level)
	{
		if(MyPetStats.TlprtXp <= 0)
		{
			if(Points >= MyPetStats.Ability_Teleport.TeleportCost)
			{
				currentTeleportBuy.MyButton.EnableMe();
			}
			else
			{
				currentTeleportBuy.MyButton.DisableMe();
			}
		}
		else
		{
			currentTeleportBuy.MyButton.Caption = "MAX";
			currentTeleportBuy.MyButton.DisableMe();
		}
	}
	else
	{
		currentTeleportBuy.MyButton.Caption = "Lvl "$MyPetStats.Ability_Teleport.Level;
		currentTeleportBuy.MyButton.DisableMe();
	}

	if(PetLevel >= MyPetStats.Ability_TeleportTime.Level)
	{
		if((MyPetStats.TlprtDwnXp*MyPetStats.Ability_TeleportTime.TeleportTimeIncrease) < MyPetStats.Ability_TeleportTime.TeleportTimeMax)
		{
			if(Points >= MyPetStats.Ability_TeleportTime.TeleportTimeIncreaseCost)
			{
				currentTeleportCooldownBuy.MyButton.EnableMe();
			}
			else
			{
				currentTeleportCooldownBuy.MyButton.DisableMe();
			}
		}
		else
		{
			currentTeleportCooldownBuy.MyButton.Caption = "MAX";
			currentTeleportCooldownBuy.MyButton.DisableMe();
		}
	}
	else
	{
		currentTeleportCooldownBuy.MyButton.Caption = "Lvl "$MyPetStats.Ability_TeleportTime.Level;
		currentTeleportCooldownBuy.MyButton.DisableMe();
	}

	if(PetLevel >= MyPetStats.Ability_TeleportDistance.Level)
	{
		if((MyPetStats.Ability_TeleportDistance.BaseTeleportDistance+(MyPetStats.TlprtDstXp*MyPetStats.Ability_TeleportDistance.TeleportDistanceIncrease)) < MyPetStats.Ability_TeleportDistance.TeleportDistanceMax)
		{
			if(Points >= MyPetStats.Ability_TeleportDistance.TeleportDistanceIncreaseCost)
			{
				currentTeleportDistanceBuy.MyButton.EnableMe();
			}
			else
			{
				currentTeleportDistanceBuy.MyButton.DisableMe();
			}
		}
		else
		{
			currentTeleportDistanceBuy.MyButton.Caption = "MAX";
			currentTeleportDistanceBuy.MyButton.DisableMe();
		}
	}
	else
	{
		currentTeleportDistanceBuy.MyButton.Caption = "Lvl "$MyPetStats.Ability_TeleportDistance.Level;
		currentTeleportDistanceBuy.MyButton.DisableMe();
	}

	if(PetLevel >= MyPetStats.Ability_KillBonus.Level)
	{
		if((MyPetStats.KBxP*MyPetStats.Ability_KillBonus.KillBonusIncrease) < MyPetStats.Ability_KillBonus.KillBonusMax)
		{
			if(Points >= MyPetStats.Ability_KillBonus.KillBonusIncreaseCost)
			{
				currentKillBonusBuy.MyButton.EnableMe();
			}
			else
			{
				currentKillBonusBuy.MyButton.DisableMe();
			}
		}
		else
		{
			currentKillBonusBuy.MyButton.Caption = "MAX";
			currentKillBonusBuy.MyButton.DisableMe();
		}
	}
	else
	{
		currentKillBonusBuy.MyButton.Caption = "Lvl "$MyPetStats.Ability_KillBonus.Level;
		currentKillBonusBuy.MyButton.DisableMe();
	}

	if(PetLevel >= MyPetStats.Ability_XpLeech.Level)
	{
		if(MyPetStats.XpL <= 0)
		{
			if(Points >= MyPetStats.Ability_XpLeech.XpLeechCost)
			{
				currentXpLeechBuy.MyButton.EnableMe();
			}
			else
			{
				currentXpLeechBuy.MyButton.DisableMe();
			}
		}
		else
		{
			currentXpLeechBuy.MyButton.Caption = "MAX";
			currentXpLeechBuy.MyButton.DisableMe();
		}
	}
	else
	{
		currentXpLeechBuy.MyButton.Caption = "Lvl "$MyPetStats.Ability_XpLeech.Level;
		currentXpLeechBuy.MyButton.DisableMe();
	}

	if(PetLevel >= MyPetStats.UnlockAuraLevel)
	{
		//have not yet selected an aura
		if(MyPetStats.Aura == 0)
		{
			//enable aura buttons so player can choose one
			if(AuraHealthBuy != None)
				AuraHealthBuy.MyButton.EnableMe();
			if(AuraDamageBuy != None)
				AuraDamageBuy.MyButton.EnableMe();
			if(AuraDefenseBuy != None)
				AuraDefenseBuy.MyButton.EnableMe();
			if(AuraPetBuy != None)
				AuraPetBuy.MyButton.EnableMe();
			if(AuraFrostBuy != None)
				AuraFrostBuy.MyButton.EnableMe();
			if(AuraLightningBuy != None)
				AuraLightningBuy.MyButton.EnableMe();
			if(AuraResurrectBuy != None)
				AuraResurrectBuy.MyButton.EnableMe();
			if(AuraRetributionBuy != None)
				AuraRetributionBuy.MyButton.EnableMe();
		}
		else
		{
			if(currentRespecBuy != None)
			{
				if(Points >= MyPetStats.AuraRespecCost)
				{
					currentRespecBuy.MyButton.EnableMe();
				}
				else
				{
					currentRespecBuy.MyButton.DisableMe();
				}
			}


			if(MyPetStats.Aura == 1 && currentAuraSelectedBuy != None && currentAuraSelectedRadiusBuy != None)
			{
				if((MyPetStats.AAxp*MyPetStats.Ability_AuraHeal.AuraHealIncrease) < MyPetStats.Ability_AuraHeal.AuraHealMax)
				{
					if(Points >= MyPetStats.Ability_AuraHeal.AuraHealIncreaseCost)
					{
						currentAuraSelectedBuy.MyButton.EnableMe();
					}
					else
					{
						currentAuraSelectedBuy.MyButton.DisableMe();
					}
				}
				else
				{
					currentAuraSelectedBuy.MyButton.Caption = "MAX";
					currentAuraSelectedBuy.MyButton.DisableMe();
				}

				if((MyPetStats.ABxp*MyPetStats.Ability_AuraHeal.AuraRadiusIncrease) < MyPetStats.Ability_AuraHeal.AuraRadiusMax)
				{
					if(Points >= MyPetStats.Ability_AuraHeal.AuraRadiusIncreaseCost)
					{
						currentAuraSelectedRadiusBuy.MyButton.EnableMe();
					}
					else
					{
						currentAuraSelectedRadiusBuy.MyButton.DisableMe();
					}
				}
				else
				{
					currentAuraSelectedRadiusBuy.MyButton.Caption = "MAX";
					currentAuraSelectedRadiusBuy.MyButton.DisableMe();
				}
			}
			else if(MyPetStats.Aura == 2 && currentAuraSelectedBuy != None && currentAuraSelectedRadiusBuy != None)
			{
				if((MyPetStats.AAxp*MyPetStats.Ability_AuraDamage.AuraDamageIncrease) < MyPetStats.Ability_AuraDamage.AuraDamageMax)
				{
					if(Points >= MyPetStats.Ability_AuraDamage.AuraDamageIncreaseCost)
					{
						currentAuraSelectedBuy.MyButton.EnableMe();
					}
					else
					{
						currentAuraSelectedBuy.MyButton.DisableMe();
					}
				}
				else
				{
					currentAuraSelectedBuy.MyButton.Caption = "MAX";
					currentAuraSelectedBuy.MyButton.DisableMe();
				}

				if((MyPetStats.ABxp*MyPetStats.Ability_AuraDamage.AuraRadiusIncrease) < MyPetStats.Ability_AuraDamage.AuraRadiusMax)
				{
					if(Points >= MyPetStats.Ability_AuraDamage.AuraRadiusIncreaseCost)
					{
						currentAuraSelectedRadiusBuy.MyButton.EnableMe();
					}
					else
					{
						currentAuraSelectedRadiusBuy.MyButton.DisableMe();
					}
				}
				else
				{
					currentAuraSelectedRadiusBuy.MyButton.Caption = "MAX";
					currentAuraSelectedRadiusBuy.MyButton.DisableMe();
				}
			}
			else if(MyPetStats.Aura == 3 && currentAuraSelectedBuy != None && currentAuraSelectedRadiusBuy != None)
			{
				if((MyPetStats.AAxp*MyPetStats.Ability_AuraDefense.AuraDefenseIncrease) < MyPetStats.Ability_AuraDefense.AuraDefenseMax)
				{
					if(Points >= MyPetStats.Ability_AuraDefense.AuraDefenseIncreaseCost)
					{
						currentAuraSelectedBuy.MyButton.EnableMe();
					}
					else
					{
						currentAuraSelectedBuy.MyButton.DisableMe();
					}
				}
				else
				{
					currentAuraSelectedBuy.MyButton.Caption = "MAX";
					currentAuraSelectedBuy.MyButton.DisableMe();
				}

				if((MyPetStats.ABxp*MyPetStats.Ability_AuraDefense.AuraRadiusIncrease) < MyPetStats.Ability_AuraDefense.AuraRadiusMax)
				{
					if(Points >= MyPetStats.Ability_AuraDefense.AuraRadiusIncreaseCost)
					{
						currentAuraSelectedRadiusBuy.MyButton.EnableMe();
					}
					else
					{
						currentAuraSelectedRadiusBuy.MyButton.DisableMe();
					}
				}
				else
				{
					currentAuraSelectedRadiusBuy.MyButton.Caption = "MAX";
					currentAuraSelectedRadiusBuy.MyButton.DisableMe();
				}
			}
			else if(MyPetStats.Aura == 4)
			{
				//
			}
			else if(MyPetStats.Aura == 5 && currentAuraSelectedBuy != None && currentAuraSelectedRadiusBuy != None)
			{
				if((MyPetStats.AAxp*MyPetStats.Ability_AuraFrost.AuraFrostIncrease) < MyPetStats.Ability_AuraFrost.AuraFrostMax)
				{
					if(Points >= MyPetStats.Ability_AuraFrost.AuraFrostIncreaseCost)
					{
						currentAuraSelectedBuy.MyButton.EnableMe();
					}
					else
					{
						currentAuraSelectedBuy.MyButton.DisableMe();
					}
				}
				else
				{
					currentAuraSelectedBuy.MyButton.Caption = "MAX";
					currentAuraSelectedBuy.MyButton.DisableMe();
				}

				if((MyPetStats.ABxp*MyPetStats.Ability_AuraFrost.AuraRadiusIncrease) < MyPetStats.Ability_AuraFrost.AuraRadiusMax)
				{
					if(Points >= MyPetStats.Ability_AuraFrost.AuraRadiusIncreaseCost)
					{
						currentAuraSelectedRadiusBuy.MyButton.EnableMe();
					}
					else
					{
						currentAuraSelectedRadiusBuy.MyButton.DisableMe();
					}
				}
				else
				{
					currentAuraSelectedRadiusBuy.MyButton.Caption = "MAX";
					currentAuraSelectedRadiusBuy.MyButton.DisableMe();
				}
			}
			else if(MyPetStats.Aura == 6 && currentAuraSelectedBuy != None && currentAuraSelectedRadiusBuy != None)
			{
				if((MyPetStats.AAxp*MyPetStats.Ability_AuraChainLightning.AuraChainLightningIncrease) < MyPetStats.Ability_AuraChainLightning.AuraChainLightningMax)
				{
					if(Points >= MyPetStats.Ability_AuraChainLightning.AuraChainLightningIncreaseCost)
					{
						currentAuraSelectedBuy.MyButton.EnableMe();
					}
					else
					{
						currentAuraSelectedBuy.MyButton.DisableMe();
					}
				}
				else
				{
					currentAuraSelectedBuy.MyButton.Caption = "MAX";
					currentAuraSelectedBuy.MyButton.DisableMe();
				}

				if((MyPetStats.ABxp*MyPetStats.Ability_AuraChainLightning.AuraRadiusIncrease) < MyPetStats.Ability_AuraChainLightning.AuraRadiusMax)
				{
					if(Points >= MyPetStats.Ability_AuraChainLightning.AuraRadiusIncreaseCost)
					{
						currentAuraSelectedRadiusBuy.MyButton.EnableMe();
					}
					else
					{
						currentAuraSelectedRadiusBuy.MyButton.DisableMe();
					}
				}
				else
				{
					currentAuraSelectedRadiusBuy.MyButton.Caption = "MAX";
					currentAuraSelectedRadiusBuy.MyButton.DisableMe();
				}
			}
			else if(MyPetStats.Aura == 7 && currentAuraSelectedBuy != None && currentAuraSelectedRadiusBuy != None)
			{
				if((MyPetStats.AAxp*MyPetStats.Ability_AuraResurrect.AuraResurrectIncrease) < MyPetStats.Ability_AuraResurrect.AuraResurrectMax)
				{
					if(Points >= MyPetStats.Ability_AuraResurrect.AuraResurrectIncreaseCost)
					{
						currentAuraSelectedBuy.MyButton.EnableMe();
					}
					else
					{
						currentAuraSelectedBuy.MyButton.DisableMe();
					}
				}
				else
				{
					currentAuraSelectedBuy.MyButton.Caption = "MAX";
					currentAuraSelectedBuy.MyButton.DisableMe();
				}

				if((MyPetStats.ABxp*MyPetStats.Ability_AuraResurrect.AuraRadiusIncrease) < MyPetStats.Ability_AuraResurrect.AuraRadiusMax)
				{
					if(Points >= MyPetStats.Ability_AuraResurrect.AuraRadiusIncreaseCost)
					{
						currentAuraSelectedRadiusBuy.MyButton.EnableMe();
					}
					else
					{
						currentAuraSelectedRadiusBuy.MyButton.DisableMe();
					}
				}
				else
				{
					currentAuraSelectedRadiusBuy.MyButton.Caption = "MAX";
					currentAuraSelectedRadiusBuy.MyButton.DisableMe();
				}
			}
			else if(MyPetStats.Aura == 8 && currentAuraSelectedBuy != None)
			{
				if((MyPetStats.AAxp*MyPetStats.Ability_AuraRetribution.AuraRetributionIncrease) < MyPetStats.Ability_AuraRetribution.AuraRetributionMax)
				{
					if(Points >= MyPetStats.Ability_AuraRetribution.AuraRetributionIncreaseCost)
					{
						currentAuraSelectedBuy.MyButton.EnableMe();
					}
					else
					{
						currentAuraSelectedBuy.MyButton.DisableMe();
					}
				}
				else
				{
					currentAuraSelectedBuy.MyButton.Caption = "MAX";
					currentAuraSelectedBuy.MyButton.DisableMe();
				}
			}

			if(currentAuraSelectedBuy != None)
			{
				currentAuraSelectedBuy.MyLabel.EnableMe();
			}

			if(currentAuraSelectedRadiusBuy != None)
			{
				currentAuraSelectedRadiusBuy.MyLabel.EnableMe();
			}
		}
	}

	currentHealthBuy.MyLabel.EnableMe();
	currentHealthBoostBuy.MyLabel.EnableMe();
	currentHealthRegenBuy.MyLabel.EnableMe();
	currentSpeedBuy.MyLabel.EnableMe();
	currentSpeedBoostBuy.MyLabel.EnableMe();
	currentDodgeBuy.MyLabel.EnableMe();
	currentDamageReductionBuy.MyLabel.EnableMe();
	currentDamageBonusBuy.MyLabel.EnableMe();
	currentRespawnTimeBuy.MyLabel.EnableMe();
	currentTeleportBuy.MyLabel.EnableMe();
	currentTeleportCooldownBuy.MyLabel.EnableMe();
	currentTeleportDistanceBuy.MyLabel.EnableMe();
	currentKillBonusBuy.MyLabel.EnableMe();
	currentXpLeechBuy.MyLabel.EnableMe();

	if(MyPetStats.Aura == 0)
	{
		if(PetLevel < MyPetStats.UnlockAuraLevel)
		{
			if(AuraHealthBuy != None)
				AuraHealthBuy.MyButton.DisableMe();
			if(AuraDamageBuy != None)
				AuraDamageBuy.MyButton.DisableMe();
			if(AuraDefenseBuy != None)
				AuraDefenseBuy.MyButton.DisableMe();
			if(AuraPetBuy != None)
				AuraPetBuy.MyButton.DisableMe();
			if(AuraFrostBuy != None)
				AuraFrostBuy.MyButton.DisableMe();
			if(AuraLightningBuy != None)
				AuraLightningBuy.MyButton.DisableMe();
			if(AuraResurrectBuy != None)
				AuraResurrectBuy.MyButton.DisableMe();
			if(AuraRetributionBuy != None)
				AuraRetributionBuy.MyButton.DisableMe();
		}

		if(AuraHealthBuy != None)
			AuraHealthBuy.MyLabel.EnableMe();
		if(AuraDamageBuy != None)
			AuraDamageBuy.MyLabel.EnableMe();
		if(AuraDefenseBuy != None)
			AuraDefenseBuy.MyLabel.EnableMe();
		if(AuraPetBuy != None)
			AuraPetBuy.MyLabel.EnableMe();
		if(AuraFrostBuy != None)
			AuraFrostBuy.MyLabel.EnableMe();
		if(AuraLightningBuy != None)
			AuraLightningBuy.MyLabel.EnableMe();
		if(AuraResurrectBuy != None)
			AuraResurrectBuy.MyLabel.EnableMe();
		if(AuraRetributionBuy != None)
			AuraRetributionBuy.MyLabel.EnableMe();

	}
	else
	{
		if(currentRespecBuy != None)
			currentRespecBuy.MyLabel.EnableMe();
	}
}

function UpdateSummonCoolDown()
{
	local int CooldownTime;
	local string AutoText;

	if(!PlayerHasPet())
	{
		currentCooldownLabel.Caption = default.currentCooldownLabel.Caption$"-";
		return;
	}

	CooldownTime = MyPetStats.PetCoolDown;
	if(CooldownTime <= 0)
	{
		CooldownTime = 0;
	}

	if(CooldownTime <= 0 && PlayerHasPet() && MyPetStats.MyPet == None)
	{
		b_Cancel.EnableMe();
	}
	else
	{
		b_Cancel.DisableMe();
	}

	AutoText = "";
	if(MyPetStats.bAutoSummon)
	{
		AutoText = " (Auto)";
	}

	currentCooldownLabel.Caption = default.currentCooldownLabel.Caption$String(CooldownTime)$AutoText;
}

function bool PlayerHasPet()
{
	if(ValidPackage(MyPetStats.PetClass))
	{
		return true;
	}

	return false;
}

function CheckPetName()
{
	local string PackageLeft, PackageRight;

	if(!ValidName(MyPetStats.PetName))
	{
		if(!Divide(MyPetStats.PetClass,".",PackageLeft, PackageRight))
		{
			MyPetStats.ServerSetPetName(PackageRight);
		}
		else
		{
			MyPetStats.ServerSetPetName("Friendly Pet");
		}
	}

	if(!ValidName(MyPetStats.DTPetName))
	{
		if(!Divide(MyPetStats.DTClass,".",PackageLeft, PackageRight))
		{
			MyPetStats.ServerSetCompanionPetName(PackageRight);
		}
		else
		{
			MyPetStats.ServerSetCompanionPetName("Friendly Pet");
		}
	}
}

function UpdateSpinnyDude()
{
    local Material MonsterSkin;
    local array<string> SkinList;
    local int i;
    local class<Monster> M;
    local string PetClassName;

    if(MyPetStats == None || SpinnyDude == None)
    {
		return;
	}

	PetClassName = MyPetStats.PetClass;
	M = class<Monster>(DynamicLoadObject(PetClassName,class'class',true));
    if(M == None)
    {
		b_DropTarget.Caption = "# Preview Not Available #";
		SpinnyDude.bHidden = true;
		currentAnimList.RemoveItem(0, currentAnimList.ItemCount());
		return;
	}

	SpinnyDude.bHidden = false;
	SpinnyDudeOffset.X = currentModelFOV.GetValue();
	SpinnyDude.SetDrawScale(M.default.DrawScale);
	b_DropTarget.Caption = "";

	for(i=0;i<M.default.Skins.Length;i++)
	{
		SkinList.Insert(i,1);
		SkinList[i] = string(M.default.Skins[i]);
	}

	SpinnyDude.SetDrawType(M.default.DrawType);
	SpinnyDude.SetStaticMesh(M.default.StaticMesh);
	SpinnyDude.LinkMesh(M.default.Mesh);
	SpinnyDude.Texture = M.default.Texture;
	//Metal Skaarj & SMPMerc fix & any with none applied
	for(i=0;i<SkinList.Length;i++)
	{
		if(SkinList[i] ~= "None" || SkinList[i] ~= "")
		{
			SkinList[i] = "Engine.DefaultTexture";
		}

		MonsterSkin = Material(DynamicLoadObject(SkinList[i], class'Engine.Material',true));
	    if(MonsterSkin == None)
   		{
        	Log("Could not load body material: " @ SkinList[i] @"for" @ M @ "mesh = " @ M.default.Mesh,'InvasionPro Pet Page');
   		}

   		SpinnyDude.Skins[i] = MonsterSkin;
	}

	if(MonsterIs2D(M))
	{
		SpinnyDude.SetDrawType(DT_StaticMesh);
		SpinnyDude.SetStaticMesh(StaticMesh'InvasionProv1_7.SpritePreviewMesh');
		SpinnyDude.Skins[0] = SpinnyDude.Texture;
		currentAnimList.DisableMe();
		b_Play.DisableMe();
		b_Pause.DisableMe();
	}
	else
	{
		currentAnimList.EnableMe();
		b_Play.EnableMe();
		b_Pause.EnableMe();
	}

    SetUpAnimation(PetClassName);
}

function bool MonsterIs2D(class<Monster> MClass)
{
	local string PackageLeft, PackageRight;

	Divide(string(MClass),".",PackageLeft, PackageRight);

	if(PackageLeft ~= "BloodMonstersv1" || PackageLeft ~= "DukeNukemMonstersv1"
	|| PackageLeft ~= "HereticMonstersv1" || PackageLeft ~= "HexenMonstersv2"
	|| PackageLeft ~= "HexenMonstersv1" || PackageLeft ~= "ShadowWarriorMonstersv1" || PackageLeft ~= "DoomPawns2k4")
	{
		return true;
	}

	return false;
}

function bool RespecAura(GUIComponent Sender)
{
	MyPetStats.RespecAura();
	return true;
}

function bool SummonPet(GUIComponent Sender)
{
	MyPetStats.SummonPet();
	return true;
}

function DiscardPet(bool bUpgrade)
{
	MyPetStats.DiscardPet(bUpGrade);
}

function bool InternalDraw(Canvas canvas)
{
    local vector CamPos, X, Y, Z;
    local rotator CamRot;
    local float   oOrgX, oOrgY;
    local float   oClipX, oClipY;

	UpdateAbilities();

    if(SpinnyDude == None)
    {
		return true;
	}

	oOrgX = Canvas.OrgX;
	oOrgY = Canvas.OrgY;
	oClipX = Canvas.ClipX;
	oClipY = Canvas.ClipY;

	Canvas.OrgX = b_DropTarget.ActualLeft();
	Canvas.OrgY = b_DropTarget.ActualTop();
	Canvas.ClipX = b_DropTarget.ActualWidth();
	Canvas.ClipY = b_DropTarget.ActualHeight();

	canvas.GetCameraLocation(CamPos, CamRot);
	GetAxes(CamRot, X, Y, Z);

	SpinnyDude.SetLocation(CamPos + (SpinnyDudeOffset.X * X) + (SpinnyDudeOffset.Y * Y) + (SpinnyDudeOffset.Z * Z));
	canvas.DrawActorClipped(SpinnyDude, false,  b_DropTarget.ActualLeft(), b_DropTarget.ActualTop(), b_DropTarget.ActualWidth(), b_DropTarget.ActualHeight(), true, nFov);

	Canvas.OrgX = oOrgX;
	Canvas.OrgY = oOrgY;
	Canvas.ClipX = oClipX;
	Canvas.ClipY = oClipY;

	UpdateSummonCoolDown();

    return true;
}

function bool RaceCapturedMouseMove(float deltaX, float deltaY)
{
    local rotator r;

    r = SpinnyDude.Rotation;
    r.Yaw -= (256 * DeltaX);
    r.Pitch += (256 * DeltaY);
    SpinnyDude.SetRotation(r);
    return true;
}

function bool PanView(GUIComponent Sender)
{
	local Rotator R;

	if(Sender == b_UArrow)
	{
		SpinnyDudeOffset.Z = (SpinnyDudeOffset.Z + 5);
	}

	if(Sender == b_DArrow)
	{
		SpinnyDudeOffset.Z = (SpinnyDudeOffset.Z - 5);
	}

	if(Sender == b_LArrow)
	{
		SpinnyDudeOffset.Y = (SpinnyDudeOffset.Y - 5);
	}

	if(Sender == b_RArrow)
	{
		SpinnyDudeOffset.Y = (SpinnyDudeOffset.Y + 5);
	}

	if(Sender == b_CArrow)
	{
		SpinnyDudeOffset.X = 70;
		SpinnyDudeOffset.Y = 0;
		SpinnyDudeOffset.Z = 0;
		R.Yaw = 32768;
		R.Pitch = -1024;
		SpinnyDude.SetRotation(R+PlayerOwner().Rotation);
		currentModelFOV.SetValue(65);
	}

	return true;
}

function InternalOnChange(GUIComponent Sender)
{
	if(Sender == currentModelRotation)
	{
		SpinnyDude.RotateSpeed = currentModelRotation.GetValue();
	}

	if(Sender == currentAnimList)
	{
		CurrentAnim = StringToName( currentAnimList.GetText() );
		PlayNewAnim();
	}

	if(Sender == currentModelFOV)
	{
		SpinnyDudeOffset.X = currentModelFOV.GetValue();
	}
}

function UpdateAbility(string Ability, bool bImmediately, optional string SubText)
{
	if(bImmediately)
	{
		MyPetStats.UpdateAbility(Ability,SubText);
	}

	if(Ability ~= "Orders")
	{
		SetOrderButtons(SubText);
	}
}

function SetOrderButtons(string NewOrder)
{
	if(NewOrder ~= "Defend")
	{
		button_orderDefendOwner.DisableMe();
		button_orderDefendAll.EnableMe();
		button_orderAttack.EnableMe();
		button_orderStay.EnableMe();
	}
	else if(NewOrder ~= "DefendAll")
	{
		button_orderDefendOwner.EnableMe();
		button_orderDefendAll.DisableMe();
		button_orderAttack.EnableMe();
		button_orderStay.EnableMe();
	}
	else if(NewOrder ~= "Attack")
	{
		button_orderDefendOwner.EnableMe();
		button_orderDefendAll.EnableMe();
		button_orderAttack.DisableMe();
		button_orderStay.EnableMe();
	}
	else if(NewOrder ~= "Stay")
	{
		button_orderDefendOwner.EnableMe();
		button_orderDefendAll.EnableMe();
		button_orderAttack.EnableMe();
		button_orderStay.DisableMe();
	}
	else //default order
	{
		button_orderDefendOwner.DisableMe();
		button_orderDefendAll.EnableMe();
		button_orderAttack.EnableMe();
		button_orderStay.EnableMe();
	}
}

function bool InternalOnClick(GUIComponent Sender)
{
	if(Sender == button_autopet)
	{
		MyPetStats.SetAutoSummon(!MyPetStats.bAutoSummon);
		return true;
	}

	if(Sender == button_recallpet)
	{
		MyPetStats.RecallPet(false);
		return true;
	}

	if(Sender == button_discardpet)
	{
		PlayerOwner().ClientOpenMenu("InvasionProv1_7.InvasionProPetDiscardMenu");
		//DiscardPet(false);
		return true;
	}

	if(Sender == button_orderDefendOwner)
	{
		UpdateAbility("Orders",true,"Defend");
		return true;
	}

	if(Sender == button_orderDefendAll)
	{
		UpdateAbility("Orders",true,"DefendAll");
		return true;
	}

	if(Sender == button_orderAttack)
	{
		UpdateAbility("Orders",true,"Attack");
		return true;
	}

	if(Sender == button_orderStay)
	{
		UpdateAbility("Orders",true,"Stay");
		return true;
	}

	Controller.CloseMenu();
	return true;
}

event Closed(GUIComponent Sender, bool bCancelled)
{
    Super.Closed(Sender, bCancelled);

	if(SpinnyDude != None)
	{
		SpinnyDude.Destroy();
	}
}

function name StringToName(string str)
{
	SetPropertyText("NameConversion", str);
 	return NameConversion;
}

function PlayNewAnim()
{
	if(CurrentAnim != '')
	{
		if(bAnimPaused)
		{
			if( SpinnyDude.TweenAnim( CurrentAnim, 1.0, 0 ) )
			{
				SpinnyDude.LoopAnim(CurrentAnim,1.0/SpinnyDude.Level.TimeDilation,,0 );
			}
		}

		SpinnyDude.LoopAnim(CurrentAnim,1.0/SpinnyDude.Level.TimeDilation,,0 );
		bAnimPaused = false;
	}
}

function SetUpAnimation(string MonsterClass)
{
	local int i;
	local int AnimCount;
	local class<Monster> M;

	AnimCount = currentAnimList.ItemCount();

	currentAnimList.RemoveItem(0, AnimCount);

	M = class<Monster>(DynamicLoadObject(MonsterClass,class'class',true));
	FindMonsterAnimations(M);
	for(i=0;i<class'InvasionProAnimationManager'.default.AnimNames.Length;i++)
	{
		ValidAnim(class'InvasionProAnimationManager'.default.AnimNames[i]);
	}

	currentAnimList.MyComboBox.List.Sort();
	CurrentAnim = StringToName( currentAnimList.GetText() );
}

function FindMonsterAnimations(class<Monster> M)
{
	local int i;

	for(i=0;i<4;i++)
	{
		ValidAnim(M.default.MovementAnims[i]);
		ValidAnim(M.default.CrouchAnims[i]);
		ValidAnim(M.default.AirAnims[i]);
		ValidAnim(M.default.TakeoffAnims[i]);
		ValidAnim(M.default.LandAnims[i]);
		ValidAnim(M.default.DodgeAnims[i]);
		ValidAnim(M.default.DoubleJumpAnims[i]);
		ValidAnim(M.default.WallDodgeAnims[i]);
		ValidAnim(M.default.WalkAnims[i]);
		ValidAnim(M.default.SwimAnims[i]);
	}

	ValidAnim(M.default.TakeoffStillAnim);
	ValidAnim(M.default.AirStillAnim);
	ValidAnim(M.default.CrouchTurnRightAnim);
	ValidAnim(M.default.CrouchTurnLeftAnim);
	ValidAnim(M.default.TurnLeftAnim);
	ValidAnim(M.default.TurnLeftAnim);
	ValidAnim(M.default.TurnRightAnim);
	ValidAnim(M.default.IdleRifleAnim);
	ValidAnim(M.default.IdleHeavyAnim);
	ValidAnim(M.default.IdleWeaponAnim);
	ValidAnim(M.default.FireHeavyBurstAnim);
	ValidAnim(M.default.FireHeavyRapidAnim);
	ValidAnim(M.default.FireRifleBurstAnim);
	ValidAnim(M.default.FireRifleRapidAnim);
	ValidAnim(M.default.IdleChatAnim);
	ValidAnim(M.default.IdleSwimAnim);
}

function ValidAnim(name vAnim)
{
	if(vAnim != '' && SpinnyDude.HasAnim(vAnim) && currentAnimList.Find(string(vAnim),false,false) == "" )
	{
		currentAnimList.AddItem( String(vAnim) );
	}
}

function bool AnimControls(GUIComponent Sender)
{
	local float AnimRate, AnimFrame;

	if(Sender == b_Play)
	{
		PlayNewAnim();
	}

	if(Sender == b_Pause)
	{
		if(CurrentAnim != '')
		{
			if(bAnimPaused)
			{
				return true;
			}

			SpinnyDude.GetAnimParams ( 0, CurrentAnim, AnimFrame, AnimRate );
			SpinnyDude.TweenAnim( CurrentAnim, 0, 0 );
			SpinnyDude.SetAnimFrame(AnimFrame, 0, 0);
			bAnimPaused = true;
		}
	}

	return true;
}

function PetNameUnFocus()
{
	CheckPetName();
	SavePetName();
	SaveCompanionPetName();
}

function SavePetName()
{
	if(ValidName(currentPetName.GetText()))
	{
		MyPetStats.ServerSetPetName(currentPetName.GetText());
	}
	else
	{
		currentPetName.SetText(MyPetStats.PetName);
	}
}

function SaveCompanionPetName()
{
	if(ValidName(currentCompanionPetName.GetText()))
	{
		MyPetStats.ServerSetCompanionPetName(currentCompanionPetName.GetText());
	}
	else
	{
		currentCompanionPetName.SetText(MyPetStats.DTPetName);
	}
}

defaultproperties
{
     Begin Object Class=GUIMultiOptionListBox Name=MyRulesList
         bVisibleWhenEmpty=True
         OnCreateComponent=InvasionProPetMenuConfig.InternalOnCreateComponent
         StyleName="ServerBrowserGrid"
         WinTop=0.111738
         WinLeft=0.394180
         WinWidth=0.561765
         WinHeight=0.783580
         bBoundToParent=True
         bScaleToParent=True
     End Object
     currentScrollContainer=GUIMultiOptionListBox'InvasionProv1_7.InvasionProPetMenuConfig.MyRulesList'

     Begin Object Class=GUILabel Name=PetOrders
         Caption="Orders"
         TextAlign=TXTA_Center
         FontScale=FNS_Small
         StyleName="TextLabel"
         WinTop=0.751883
         WinLeft=0.172842
         WinWidth=0.210001
         WinHeight=0.038699
         RenderWeight=0.200000
         bBoundToParent=True
         bScaleToParent=True
     End Object
     CurrentOrders=GUILabel'InvasionProv1_7.InvasionProPetMenuConfig.PetOrders'

     Begin Object Class=GUIButton Name=autopet
         Caption="Auto"
         FontScale=FNS_Small
         Hint="Click this button to automatically summon your pet when the cooldown has finished."
         WinTop=0.805809
         WinLeft=0.061067
         WinWidth=0.105407
         WinHeight=0.048857
         TabOrder=32
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProPetMenuConfig.InternalOnClick
         OnKeyEvent=autopet.InternalOnKeyEvent
     End Object
     button_autopet=GUIButton'InvasionProv1_7.InvasionProPetMenuConfig.autopet'

     Begin Object Class=GUIButton Name=RecallPet
         Caption="Recall"
         FontScale=FNS_Small
         Hint="Click to recall your pet and put it away."
         WinTop=0.874327
         WinLeft=0.061067
         WinWidth=0.105407
         WinHeight=0.048857
         TabOrder=32
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProPetMenuConfig.InternalOnClick
         OnKeyEvent=RecallPet.InternalOnKeyEvent
     End Object
     button_recallpet=GUIButton'InvasionProv1_7.InvasionProPetMenuConfig.RecallPet'

     Begin Object Class=GUIButton Name=b_discardpet
         Caption="Discard"
         FontScale=FNS_Small
         Hint="Click to discard your pet. You can then choose a new pet."
         WinTop=0.160204
         WinLeft=0.279774
         WinWidth=0.105407
         WinHeight=0.048857
         TabOrder=32
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProPetMenuConfig.InternalOnClick
         OnKeyEvent=b_discardpet.InternalOnKeyEvent
     End Object
     button_discardpet=GUIButton'InvasionProv1_7.InvasionProPetMenuConfig.b_discardpet'

     Begin Object Class=GUIButton Name=orderDefendOwner
         Caption="Follow"
         FontScale=FNS_Small
         Hint="Click to order your pet to follow you, your pet may still attack enemies within sight."
         WinTop=0.805809
         WinLeft=0.171483
         WinWidth=0.105407
         WinHeight=0.048857
         TabOrder=32
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProPetMenuConfig.InternalOnClick
         OnKeyEvent=orderDefendOwner.InternalOnKeyEvent
     End Object
     button_orderDefendOwner=GUIButton'InvasionProv1_7.InvasionProPetMenuConfig.orderDefendOwner'

     Begin Object Class=GUIButton Name=orderDefendAll
         Caption="Defend"
         FontScale=FNS_Small
         Hint="Click to order your pet to defend all players. Your pet will decide which players to defend."
         WinTop=0.874327
         WinLeft=0.280900
         WinWidth=0.105407
         WinHeight=0.048857
         TabOrder=32
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProPetMenuConfig.InternalOnClick
         OnKeyEvent=orderDefendAll.InternalOnKeyEvent
     End Object
     button_orderDefendAll=GUIButton'InvasionProv1_7.InvasionProPetMenuConfig.orderDefendAll'

     Begin Object Class=GUIButton Name=orderAttack
         Caption="Attack"
         FontScale=FNS_Small
         Hint="Click to order your pet to attack at will, your pet will free roam about the map and attack all enemies."
         WinTop=0.805809
         WinLeft=0.280900
         WinWidth=0.105407
         WinHeight=0.048857
         TabOrder=32
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProPetMenuConfig.InternalOnClick
         OnKeyEvent=orderAttack.InternalOnKeyEvent
     End Object
     button_orderAttack=GUIButton'InvasionProv1_7.InvasionProPetMenuConfig.orderAttack'

     Begin Object Class=GUIButton Name=orderStay
         Caption="Stay"
         FontScale=FNS_Small
         Hint="Click to order your pet to hold the current position, your pet will still attack nearby monsters but will return to defend this location."
         WinTop=0.874327
         WinLeft=0.171483
         WinWidth=0.105407
         WinHeight=0.048857
         TabOrder=32
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProPetMenuConfig.InternalOnClick
         OnKeyEvent=orderStay.InternalOnKeyEvent
     End Object
     button_orderStay=GUIButton'InvasionProv1_7.InvasionProPetMenuConfig.orderStay'

     Begin Object Class=moEditBox Name=PetName
         CaptionWidth=0.250000
         Caption="Pet Name:"
         OnCreateComponent=PetName.InternalOnCreateComponent
         Hint="Once you select a pet you can edit its name here!"
         WinTop=0.120134
         WinLeft=0.062980
         WinWidth=0.322979
         WinHeight=0.033333
         TabOrder=6
         bBoundToParent=True
         bScaleToParent=True
         OnDeActivate=InvasionProPetMenuConfig.PetNameUnFocus
     End Object
     currentPetName=moEditBox'InvasionProv1_7.InvasionProPetMenuConfig.PetName'

     Begin Object Class=GUILabel Name=PetClass
         Caption="Species: "
         TextAlign=TXTA_Center
         FontScale=FNS_Small
         StyleName="TextLabel"
         WinTop=0.650712
         WinLeft=0.066207
         WinWidth=0.313127
         WinHeight=0.039992
         bScaleToParent=True
     End Object
     currentPetClass=GUILabel'InvasionProv1_7.InvasionProPetMenuConfig.PetClass'

     Begin Object Class=GUIButton Name=b_commitpet
         Caption="Select Pet"
         FontScale=FNS_Small
         Hint="Click this button to select a pet!"
         WinTop=0.155844
         WinLeft=0.057761
         WinWidth=0.221899
         WinHeight=0.055968
         TabOrder=45
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProPetMenuConfig.OpenSelectPetMenu
         OnKeyEvent=b_commitpet.InternalOnKeyEvent
     End Object
     button_commitpet=GUIButton'InvasionProv1_7.InvasionProPetMenuConfig.b_commitpet'

     Begin Object Class=GUILabel Name=pointsLabel
         Caption="Points: "
         TextAlign=TXTA_Center
         FontScale=FNS_Small
         StyleName="TextLabel"
         WinTop=0.923231
         WinLeft=0.239650
         WinWidth=0.500419
         WinHeight=0.052540
         RenderWeight=0.200000
     End Object
     currentPointsLabel=GUILabel'InvasionProv1_7.InvasionProPetMenuConfig.pointsLabel'

     Begin Object Class=GUILabel Name=CooldownLabel
         Caption="Respawn Timer: "
         TextAlign=TXTA_Center
         FontScale=FNS_Small
         StyleName="BrowserListSelection"
         WinTop=0.681209
         WinLeft=0.060110
         WinWidth=0.324590
         WinHeight=0.050152
         RenderWeight=1.200000
         bScaleToParent=True
     End Object
     currentCooldownLabel=GUILabel'InvasionProv1_7.InvasionProPetMenuConfig.CooldownLabel'

     Begin Object Class=InvasionProGUILabel Name=TierModeLabel
         Caption="Tier Mode"
         TextAlign=TXTA_Center
         FontScale=FNS_Small
         StyleName="TextLabel"
         Hint="The server is running in Tier mode. In Tier mode once your pet reaches the max level for his tier you will be able to choose a new pet from the next tier (up to the max set of Tier 3 pets). Generally, the higher the Tier, the better the monster! New monsters keep all previous abilities and stats that were purchased."
         WinTop=0.066999
         WinLeft=0.091758
         WinWidth=0.825189
         WinHeight=0.037324
         RenderWeight=0.500000
         bScaleToParent=True
         bVisible=False
     End Object
     currentTierModeLabel=InvasionProGUILabel'InvasionProv1_7.InvasionProPetMenuConfig.TierModeLabel'

     SpinnyDudeOffset=(X=70.000000)
     Begin Object Class=moComboBox Name=c_animlist
         bReadOnly=True
         ComponentJustification=TXTA_Left
         CaptionWidth=1.000000
         ComponentWidth=1.000000
         Caption="Preview Anims "
         OnCreateComponent=c_animlist.InternalOnCreateComponent
         FontScale=FNS_Small
         Hint="Choose an animation to play."
         WinTop=0.280492
         WinLeft=0.060383
         WinWidth=0.162448
         WinHeight=0.033333
         TabOrder=20
         bBoundToParent=True
         bScaleToParent=True
         OnChange=InvasionProPetMenuConfig.InternalOnChange
     End Object
     currentAnimList=moComboBox'InvasionProv1_7.InvasionProPetMenuConfig.c_animlist'

     Begin Object Class=GUIGFXButton Name=PanUp
         Graphic=Texture'InvasionProTexturesv1_4.GUI.arrowUp_p'
         Position=ICP_Scaled
         StyleName="BindBox"
         Hint="Pan up."
         WinTop=0.332073
         WinLeft=0.342206
         WinWidth=0.030014
         WinHeight=0.023419
         RenderWeight=0.510000
         TabOrder=22
         bScaleToParent=True
         bNeverFocus=True
         bRepeatClick=True
         OnClickSound=CS_Down
         OnClick=InvasionProPetMenuConfig.PanView
         OnKeyEvent=PanUp.InternalOnKeyEvent
     End Object
     b_UArrow=GUIGFXButton'InvasionProv1_7.InvasionProPetMenuConfig.PanUp'

     Begin Object Class=GUIGFXButton Name=PanDown
         Graphic=Texture'InvasionProTexturesv1_4.GUI.arrowDown_p'
         Position=ICP_Scaled
         StyleName="BindBox"
         Hint="Pan down."
         WinTop=0.376966
         WinLeft=0.341637
         WinWidth=0.030014
         WinHeight=0.024757
         RenderWeight=0.510000
         TabOrder=24
         bScaleToParent=True
         bNeverFocus=True
         bRepeatClick=True
         OnClickSound=CS_Down
         OnClick=InvasionProPetMenuConfig.PanView
         OnKeyEvent=PanDown.InternalOnKeyEvent
     End Object
     b_DArrow=GUIGFXButton'InvasionProv1_7.InvasionProPetMenuConfig.PanDown'

     Begin Object Class=GUIGFXButton Name=PanLeft
         Graphic=Texture'InvasionProv1_7.arrowLeft_p'
         Position=ICP_Scaled
         StyleName="BindBox"
         Hint="Pan left."
         WinTop=0.348516
         WinLeft=0.326123
         WinWidth=0.022526
         WinHeight=0.036252
         RenderWeight=0.510000
         TabOrder=21
         bScaleToParent=True
         bNeverFocus=True
         bRepeatClick=True
         OnClickSound=CS_Down
         OnClick=InvasionProPetMenuConfig.PanView
         OnKeyEvent=PanLeft.InternalOnKeyEvent
     End Object
     b_LArrow=GUIGFXButton'InvasionProv1_7.InvasionProPetMenuConfig.PanLeft'

     Begin Object Class=GUIGFXButton Name=PanRight
         Graphic=Texture'InvasionProv1_7.arrowRight_p'
         Position=ICP_Scaled
         StyleName="BindBox"
         Hint="Pan right."
         WinTop=0.348516
         WinLeft=0.364645
         WinWidth=0.022526
         WinHeight=0.036252
         RenderWeight=0.510000
         TabOrder=23
         bScaleToParent=True
         bNeverFocus=True
         bRepeatClick=True
         OnClickSound=CS_Down
         OnClick=InvasionProPetMenuConfig.PanView
         OnKeyEvent=PanRight.InternalOnKeyEvent
     End Object
     b_RArrow=GUIGFXButton'InvasionProv1_7.InvasionProPetMenuConfig.PanRight'

     Begin Object Class=GUIGFXButton Name=PanReset
         ImageIndex=7
         Graphic=Texture'InvasionProv1_7.arrowHome_p'
         Position=ICP_Scaled
         StyleName="BindBox"
         Hint="Reset the pet preview view."
         WinTop=0.348062
         WinLeft=0.341922
         WinWidth=0.030014
         WinHeight=0.036252
         RenderWeight=0.510000
         TabOrder=25
         bScaleToParent=True
         bNeverFocus=True
         bRepeatClick=True
         OnClickSound=CS_Down
         OnClick=InvasionProPetMenuConfig.PanView
         OnKeyEvent=PanReset.InternalOnKeyEvent
     End Object
     b_CArrow=GUIGFXButton'InvasionProv1_7.InvasionProPetMenuConfig.PanReset'

     Begin Object Class=GUIGFXButton Name=Play
         ImageIndex=7
         Graphic=Texture'2K4Menus.MP3.Play'
         Position=ICP_Scaled
         StyleName="CharButton"
         Hint="Play Animation."
         WinTop=0.336305
         WinLeft=0.095436
         WinWidth=0.023198
         WinHeight=0.025874
         RenderWeight=0.510000
         TabOrder=28
         bScaleToParent=True
         bNeverFocus=True
         bRepeatClick=True
         OnClickSound=CS_Down
         OnClick=InvasionProPetMenuConfig.AnimControls
         OnKeyEvent=Play.InternalOnKeyEvent
     End Object
     b_Play=GUIGFXButton'InvasionProv1_7.InvasionProPetMenuConfig.Play'

     Begin Object Class=GUIGFXButton Name=Pause
         ImageIndex=7
         Graphic=Texture'2K4Menus.MP3.Pause'
         Position=ICP_Scaled
         StyleName="CharButton"
         Hint="Pause Animation."
         WinTop=0.336722
         WinLeft=0.066611
         WinWidth=0.023198
         WinHeight=0.025874
         RenderWeight=0.510000
         TabOrder=27
         bScaleToParent=True
         bNeverFocus=True
         bRepeatClick=True
         OnClickSound=CS_Down
         OnClick=InvasionProPetMenuConfig.AnimControls
         OnKeyEvent=Pause.InternalOnKeyEvent
     End Object
     b_Pause=GUIGFXButton'InvasionProv1_7.InvasionProPetMenuConfig.Pause'

     Begin Object Class=GUIButton Name=DropTarget
         bAutoShrink=False
         StyleName="VertGrip"
         WinTop=0.324593
         WinLeft=0.059335
         WinWidth=0.325397
         WinHeight=0.407759
         RenderWeight=0.100000
         MouseCursorIndex=5
         bTabStop=False
         bBoundToParent=True
         bScaleToParent=True
         bNeverFocus=True
         bDropTarget=True
         OnKeyEvent=DropTarget.InternalOnKeyEvent
         OnCapturedMouseMove=InvasionProPetMenuConfig.RaceCapturedMouseMove
     End Object
     b_DropTarget=GUIButton'InvasionProv1_7.InvasionProPetMenuConfig.DropTarget'

     Begin Object Class=moSlider Name=ModelFOV
         MaxValue=1000.000000
         SliderCaptionStyleName="TextLabel"
         bVerticalLayout=True
         Caption="Zoom"
         OnCreateComponent=ModelFOV.InternalOnCreateComponent
         Hint="Zoom the pet preview in or out."
         WinTop=0.214847
         WinLeft=0.060413
         WinWidth=0.157171
         WinHeight=0.055556
         TabOrder=18
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.050000
         OnChange=InvasionProPetMenuConfig.InternalOnChange
     End Object
     currentModelFOV=moSlider'InvasionProv1_7.InvasionProPetMenuConfig.ModelFOV'

     Begin Object Class=GUILabel Name=ModelDrawer
         StyleName="TextLabel"
         WinTop=0.211205
         WinLeft=0.692450
         WinWidth=0.241218
         WinHeight=0.557467
         RenderWeight=0.200000
         OnDraw=InvasionProPetMenuConfig.InternalDraw
     End Object
     currentModelViewer=GUILabel'InvasionProv1_7.InvasionProPetMenuConfig.ModelDrawer'

     Begin Object Class=moSlider Name=ModelRot
         MaxValue=100.000000
         SliderCaptionStyleName="TextLabel"
         bVerticalLayout=True
         Caption="Rotate Speed"
         OnCreateComponent=ModelRot.InternalOnCreateComponent
         Hint="Adjust the rotation speed of the pet preview."
         WinTop=0.215445
         WinLeft=0.225578
         WinWidth=0.160389
         WinHeight=0.055556
         TabOrder=19
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.050000
         OnChange=InvasionProPetMenuConfig.InternalOnChange
     End Object
     currentModelRotation=moSlider'InvasionProv1_7.InvasionProPetMenuConfig.ModelRot'

     nfov=120
     Begin Object Class=AltSectionBackground Name=InternalFrameImage
         WinTop=0.075000
         WinLeft=0.040000
         WinWidth=0.675859
         WinHeight=0.550976
         bScaleToParent=True
         OnPreDraw=InternalFrameImage.InternalPreDraw
     End Object
     sb_Main=AltSectionBackground'InvasionProv1_7.InvasionProPetMenuConfig.InternalFrameImage'

     Begin Object Class=GUIButton Name=LockedCancelButton
         Caption="Summon"
         FontScale=FNS_Small
         Hint="Click to summon your pet. You may only summon your pet if you are alive and the game is in progress."
         WinTop=0.745900
         WinLeft=0.061067
         WinWidth=0.105407
         WinHeight=0.048857
         TabOrder=32
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProPetMenuConfig.SummonPet
         OnKeyEvent=LockedCancelButton.InternalOnKeyEvent
     End Object
     b_Cancel=GUIButton'InvasionProv1_7.InvasionProPetMenuConfig.LockedCancelButton'

     Begin Object Class=GUIButton Name=LockedOKButton
         Caption="Close"
         FontScale=FNS_Small
         Hint="Click to close the pet stats page."
         WinTop=0.923838
         WinLeft=0.761501
         WinWidth=0.105419
         WinHeight=0.048597
         TabOrder=31
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProPetMenuConfig.InternalOnClick
         OnKeyEvent=LockedOKButton.InternalOnKeyEvent
     End Object
     b_OK=GUIButton'InvasionProv1_7.InvasionProPetMenuConfig.LockedOKButton'

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
