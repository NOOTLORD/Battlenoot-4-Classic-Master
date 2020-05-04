class InvasionProBossConfig extends GUICustomPropertyPage;

var() int ActiveBoss;
var() class<Monster> CurrentMonsterClass; //current monsterclass for current boss
var() bool bEditMode;

var() Automated moNumericEdit currentBoss;
var() Automated moNumericEdit currentBossID;
var() Automated moNumericEdit currentBossScoreAward;
var() Automated moNumericEdit currentBossHealth;

var() Automated moComboBox currentBossMonsterName;

var() Automated moEditBox currentBossName;
var() Automated moEditBox currentBossSound;

var() Automated moSlider currentGroundSpeed;
var() Automated moSlider currentAirSpeed;
var() Automated moSlider currentWaterSpeed;
var() Automated moSlider currentJumpZ;
var() Automated moSlider currentGibMultiplier;
var() Automated moSlider currentGibSizeMultiplier;
var() Automated moSlider currentBossDamageMultiplier;

var() Automated moFloatEdit currentDrawScale;
var() Automated moFloatEdit currentCollisionHeight;
var() Automated moFloatEdit currentCollisionRadius;

var() Automated moFloatEdit currentPrePivotX;
var() Automated moFloatEdit currentPrePivotY;
var() Automated moFloatEdit currentPrePivotZ;

var() Automated GUIButton b_EditMode;

var() Automated GUIButton b_Default;
var() Automated GUIButton b_Random;

var() Automated GUIButton b_Paste;

var() Automated GUILabel monsterPrePivotLabel;
var() Automated moCheckBox currentbSetup;

//var() String LastMonsterName;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local int i;

	Super.InitComponent(MyController, MyOwner);

	b_OK.WinWidth=0.251747;
	b_OK.WinHeight=0.049962;
	b_OK.WinLeft=0.385094;
	b_OK.WinTop=0.782116;

	b_Cancel.WinWidth=0.251747;
	b_Cancel.WinHeight=0.049962;
	b_Cancel.WinLeft=0.385094;
	b_Cancel.WinTop=0.851290;

	currentBossMonsterName.MyComboBox.MaxVisibleItems=20;
	currentBossMonsterName.MyComboBox.Edit.FontScale=FNS_Small;
	currentBossMonsterName.StandardHeight=0.03;

	currentBossName.StandardHeight=0.03;

	sb_Main.Caption = "InvasionPro Boss Configuration";
	sb_Main.bScaleToParent=true;
	sb_Main.WinWidth=0.948281;
	sb_Main.WinHeight=0.918939;
	sb_Main.WinLeft=0.025352;
	sb_Main.WinTop=0.045161;

	t_WindowTitle.Caption = "InvasionPro: Boss Configuration";

	for(i=0;i<class'InvasionProMonsterTable'.default.MonsterTable.Length;i++)
	{
		currentBossMonsterName.AddItem(class'InvasionProMonsterTable'.default.MonsterTable[i].MonsterName);
	}

	currentBossName.MyEditBox.FontScale=FNS_Small;

	currentBoss.Setup(0, class'InvasionProConfigs'.default.Bosses.Length - 1, 1);
	currentBoss.SetValue(0);

	bEditMode = false;
	RefreshBoss(False);
}

function bool SaveBoss(GUIComponent Sender)
{
	ActiveBoss = currentBoss.GetValue();

	class'InvasionProConfigs'.default.Bosses[ActiveBoss].BossID = currentBossID.GetValue();
	class'InvasionProConfigs'.default.Bosses[ActiveBoss].BossMonsterName = currentBossMonsterName.GetText();
	class'InvasionProConfigs'.default.Bosses[ActiveBoss].BossName = currentBossName.GetText();
	class'InvasionProConfigs'.default.Bosses[ActiveBoss].BossHealth = currentBossHealth.GetValue();
	class'InvasionProConfigs'.default.Bosses[ActiveBoss].BossScoreAward = currentBossScoreAward.GetValue();
	class'InvasionProConfigs'.default.Bosses[ActiveBoss].BossDamageMultiplier = currentBossDamageMultiplier.GetValue();
	class'InvasionProConfigs'.default.Bosses[ActiveBoss].BossGroundSpeed = currentGroundSpeed.GetValue();
	class'InvasionProConfigs'.default.Bosses[ActiveBoss].BossAirSpeed = currentAirSpeed.GetValue();
	class'InvasionProConfigs'.default.Bosses[ActiveBoss].BossWaterSpeed = currentWaterSpeed.GetValue();
	class'InvasionProConfigs'.default.Bosses[ActiveBoss].BossJumpZ = currentJumpZ.GetValue();
	class'InvasionProConfigs'.default.Bosses[ActiveBoss].BossGibMultiplier = currentGibMultiplier.GetValue();
	class'InvasionProConfigs'.default.Bosses[ActiveBoss].BossGibSizeMultiplier = currentGibSizeMultiplier.GetValue();
	class'InvasionProConfigs'.default.Bosses[ActiveBoss].WarningSound = currentBossSound.GetText();

	if(bEditMode || !class'InvasionProConfigs'.default.Bosses[ActiveBoss].bSetup)
	{
		class'InvasionProConfigs'.default.Bosses[ActiveBoss].NewDrawScale = currentDrawScale.GetValue();
		class'InvasionProConfigs'.default.Bosses[ActiveBoss].NewCollisionHeight = currentCollisionHeight.GetValue();
		class'InvasionProConfigs'.default.Bosses[ActiveBoss].NewCollisionRadius = currentCollisionRadius.GetValue();
		class'InvasionProConfigs'.default.Bosses[ActiveBoss].NewPrePivot.X = currentPrePivotX.GetValue();
		class'InvasionProConfigs'.default.Bosses[ActiveBoss].NewPrePivot.Y = currentPrePivotY.GetValue();
		class'InvasionProConfigs'.default.Bosses[ActiveBoss].NewPrePivot.Z = currentPrePivotZ.GetValue();
	}

	class'InvasionProConfigs'.default.Bosses[ActiveBoss].bSetup = true;

	class'InvasionProConfigs'.static.StaticSaveConfig();

	return true;
}

function bool ExitBoss(GUIComponent Sender)
{
	Controller.CloseMenu(false);

	return true;
}

function SetNone()
{
	currentBossID.SetComponentValue(0);
	currentBossMonsterName.SetText("This is a fake boss");
	currentBossName.SetText("None");
	currentBossSound.SetText("None");
	currentBossHealth.SetComponentValue(0);
	currentBossScoreAward.SetComponentValue(0);
	currentBossDamageMultiplier.SetComponentValue(0);
	currentGroundSpeed.SetComponentValue(0);
	currentAirSpeed.SetComponentValue(0);
	currentWaterSpeed.SetComponentValue(0);
	currentJumpZ.SetComponentValue(0);
	currentGibMultiplier.SetComponentValue(0);
	currentGibSizeMultiplier.SetComponentValue(0);
	currentDrawScale.SetComponentValue(0);
	currentCollisionHeight.SetComponentValue(0);
	currentCollisionRadius.SetComponentValue(0);
	currentPrePivotX.SetComponentValue(0);
	currentPrePivotY.SetComponentValue(0);
	currentPrePivotZ.SetComponentValue(0);
	currentbSetup.SetComponentValue(false);
}

function bool DefaultBoss(GUIComponent Sender)
{
	//if(CurrentMonsterClass == None)
	//{
		RefreshBoss(False);
	//}

	if(CurrentMonsterClass != None)
	{
		currentBossHealth.SetComponentValue(CurrentMonsterClass.default.Health);
		currentBossScoreAward.SetComponentValue(CurrentMonsterClass.default.ScoringValue);
		currentBossDamageMultiplier.SetComponentValue(1.00);
		currentGroundSpeed.SetComponentValue(CurrentMonsterClass.default.GroundSpeed);
		currentAirSpeed.SetComponentValue(CurrentMonsterClass.default.AirSpeed);
		currentWaterSpeed.SetComponentValue(CurrentMonsterClass.default.WaterSpeed);
		currentJumpZ.SetComponentValue(CurrentMonsterClass.default.JumpZ);
		currentGibMultiplier.SetComponentValue(1.00);
		currentGibSizeMultiplier.SetComponentValue(1.00);
		currentDrawScale.SetComponentValue(CurrentMonsterClass.default.DrawScale);
		currentCollisionHeight.SetComponentValue(CurrentMonsterClass.default.CollisionHeight);
		currentCollisionRadius.SetComponentValue(CurrentMonsterClass.default.CollisionRadius);
		currentPrePivotX.SetComponentValue(CurrentMonsterClass.default.PrePivot.X);
		currentPrePivotY.SetComponentValue(CurrentMonsterClass.default.PrePivot.Y);
		currentPrePivotZ.SetComponentValue(CurrentMonsterClass.default.PrePivot.Z);
	}

	return true;
}

function bool RandomBoss(GUIComponent Sender)
{
	local int i;

	i = Max(100,Rand(1000));

	currentBossHealth.SetComponentValue( i );
	i = Max(10,Rand(200));
	currentBossScoreAward.SetComponentValue( i );
	currentBossDamageMultiplier.SetComponentValue(fRand() * 10);
	currentGroundSpeed.SetComponentValue(fRand() * 1000);
	currentAirSpeed.SetComponentValue(fRand() * 1000);
	currentWaterSpeed.SetComponentValue(fRand() * 1000);
	currentJumpZ.SetComponentValue(fRand() * 1000);
	currentGibMultiplier.SetComponentValue(fRand() * 10);
	currentGibSizeMultiplier.SetComponentValue(fRand() * 10);

	return true;
}

function bool InternalOnClick(GUIComponent Sender)
{
	Controller.CloseMenu(false);
	return true;
}

function InternalOnChange(GUIComponent Sender)
{
	if(Sender == currentBoss)
	{
		RefreshBoss(False);
	}
	else if(Sender == currentBossMonsterName && !currentbSetup.IsChecked())
	{
		RefreshBoss(True);
	}
}

function bool PasteSize(GUIComponent Sender)
{
	if(bEditMode)
	{
		currentDrawScale.SetComponentValue(class'InvasionProCopyPaste'.default.ClipBoardDrawScale);
		currentCollisionHeight.SetComponentValue(class'InvasionProCopyPaste'.default.ClipBoardCollisionHeight);
		currentCollisionRadius.SetComponentValue(class'InvasionProCopyPaste'.default.ClipBoardCollisionRadius);
		currentPrePivotX.SetComponentValue(class'InvasionProCopyPaste'.default.ClipBoardPrePivot.X);
		currentPrePivotY.SetComponentValue(class'InvasionProCopyPaste'.default.ClipBoardPrePivot.Y);
		currentPrePivotZ.SetComponentValue(class'InvasionProCopyPaste'.default.ClipBoardPrePivot.Z);
	}

	return true;
}

function bool ValidString(String TestString)
{
	if(TestString ~= "" || TestString ~= "None" || TestString ~= "This is a fake boss")
	{
		return false;
	}

	return true;
}


function RefreshBoss(bool NewBoss)
{
	local int i;

	ActiveBoss = currentBoss.GetValue();
	currentbSetup.SetComponentValue(class'InvasionProConfigs'.default.Bosses[ActiveBoss].bSetup);
	if(!NewBoss)
	{
		currentBossMonsterName.SetText(class'InvasionProConfigs'.default.Bosses[ActiveBoss].BossMonsterName);
		//LastMonsterName = currentBossMonsterName.GetText();
	}

	currentBossID.SetComponentValue(class'InvasionProConfigs'.default.Bosses[ActiveBoss].BossID);
	currentBossName.SetText(class'InvasionProConfigs'.default.Bosses[ActiveBoss].BossName);
	currentBossHealth.SetComponentValue(class'InvasionProConfigs'.default.Bosses[ActiveBoss].BossHealth);
	currentBossScoreAward.SetComponentValue(class'InvasionProConfigs'.default.Bosses[ActiveBoss].BossScoreAward);
	currentBossDamageMultiplier.SetComponentValue(class'InvasionProConfigs'.default.Bosses[ActiveBoss].BossDamageMultiplier);
	currentGroundSpeed.SetComponentValue(class'InvasionProConfigs'.default.Bosses[ActiveBoss].BossGroundSpeed);
	currentAirSpeed.SetComponentValue(class'InvasionProConfigs'.default.Bosses[ActiveBoss].BossAirSpeed);
	currentWaterSpeed.SetComponentValue(class'InvasionProConfigs'.default.Bosses[ActiveBoss].BossWaterSpeed);
	currentJumpZ.SetComponentValue(class'InvasionProConfigs'.default.Bosses[ActiveBoss].BossJumpZ);
	currentGibMultiplier.SetComponentValue(class'InvasionProConfigs'.default.Bosses[ActiveBoss].BossGibMultiplier);
	currentGibSizeMultiplier.SetComponentValue(class'InvasionProConfigs'.default.Bosses[ActiveBoss].BossGibSizeMultiplier);
	currentDrawScale.SetComponentValue(class'InvasionProConfigs'.default.Bosses[ActiveBoss].NewDrawScale);
	currentCollisionHeight.SetComponentValue(class'InvasionProConfigs'.default.Bosses[ActiveBoss].NewCollisionHeight);
	currentCollisionRadius.SetComponentValue(class'InvasionProConfigs'.default.Bosses[ActiveBoss].NewCollisionRadius);
	currentPrePivotX.SetComponentValue(class'InvasionProConfigs'.default.Bosses[ActiveBoss].NewPrePivot.X);
	currentPrePivotY.SetComponentValue(class'InvasionProConfigs'.default.Bosses[ActiveBoss].NewPrePivot.Y);
	currentPrePivotZ.SetComponentValue(class'InvasionProConfigs'.default.Bosses[ActiveBoss].NewPrePivot.Z);

	CurrentMonsterClass = None;

	if(ValidString(currentBossMonsterName.GetText()))
	{
		for(i=0;i<class'InvasionProMonsterTable'.default.MonsterTable.Length;i++)
		{
			if( class'InvasionProMonsterTable'.default.MonsterTable[i].MonsterName ~= currentBossMonsterName.GetText() )
			{
				CurrentMonsterClass = class<Monster>(DynamicLoadObject(class'InvasionProMonsterTable'.default.MonsterTable[i].MonsterClassName, class'Class',true));
				break;
			}
		}
	}

	//initialize boss if not set up
	if( !currentbSetup.IsChecked())
	{
		if(CurrentMonsterClass != None)
		{
			if(!ValidString(currentBossSound.GetText()))
			{
				currentBossSound.SetText("");
			}

			if(!ValidString(currentBossName.GetText()))
			{
				currentBossSound.SetText("Boss");
			}

			currentBossID.SetComponentValue(currentBoss.GetValue());
			currentBossHealth.SetComponentValue(CurrentMonsterClass.default.Health);
			currentBossScoreAward.SetComponentValue(CurrentMonsterClass.default.ScoringValue);
			currentBossDamageMultiplier.SetComponentValue(1);
			currentGroundSpeed.SetComponentValue(CurrentMonsterClass.default.GroundSpeed);
			currentAirSpeed.SetComponentValue(CurrentMonsterClass.default.AirSpeed);
			currentWaterSpeed.SetComponentValue(CurrentMonsterClass.default.WaterSpeed);
			currentJumpZ.SetComponentValue(CurrentMonsterClass.default.JumpZ);
			currentGibMultiplier.SetComponentValue(1);
			currentGibSizeMultiplier.SetComponentValue(1);
			currentDrawScale.SetComponentValue(CurrentMonsterClass.default.DrawScale);
			currentCollisionHeight.SetComponentValue(CurrentMonsterClass.default.CollisionHeight);
			currentCollisionRadius.SetComponentValue(CurrentMonsterClass.default.CollisionRadius);
			currentPrePivotX.SetComponentValue(CurrentMonsterClass.default.PrePivot.X);
			currentPrePivotY.SetComponentValue(CurrentMonsterClass.default.PrePivot.Y);
			currentPrePivotZ.SetComponentValue(CurrentMonsterClass.default.PrePivot.Z);
			currentbSetup.SetComponentValue(true);
			currentBossName.SetText("Boss ("$currentBossMonsterName.GetText()$")");
			SaveBoss(b_OK);
		}
	}

	SetAvailableConfigs();
	if(CurrentMonsterClass != None)
	{
		if(CurrentMonsterClass.default.bUseCylinderCollision == false)
		{
			b_EditMode.DisableMe();
		}
		else
		{
			b_EditMode.EnableMe();
		}
	}

	/*if(NewBoss)
	{
		SaveBoss(currentBossMonsterName);
	}*/
}

function bool ToggleEditMode(GUIComponent Sender)
{
	if(Sender == b_EditMode)
	{
		bEditMode = !bEditMode;
		SetAvailableConfigs();
	}

	return true;
}

function SetAvailableConfigs()
{
	if( currentBoss.GetValue() == 0)
	{
		currentDrawScale.DisableMe();
		currentCollisionHeight.DisableMe();
		currentCollisionRadius.DisableMe();
		currentBoss.EnableMe();
		currentPrePivotX.DisableMe();
		currentPrePivotY.DisableMe();
		currentPrePivotZ.DisableMe();
		b_Paste.DisableMe();
		currentBossID.DisableMe();
		currentBossMonsterName.DisableMe();
		currentBossName.DisableMe();
		currentBossHealth.DisableMe();
		currentBossScoreAward.DisableMe();
		currentBossDamageMultiplier.DisableMe();
		currentGroundSpeed.DisableMe();
		currentAirSpeed.DisableMe();
		currentWaterSpeed.DisableMe();
		currentJumpZ.DisableMe();
		currentGibMultiplier.DisableMe();
		currentGibSizeMultiplier.DisableMe();
		b_default.DisableMe();
		b_OK.DisableMe();
		b_random.DisableMe();
		currentBossSound.DisableMe();
		currentbSetup.DisableMe();
		b_EditMode.DisableMe();

		return;
	}
	else
	{
		currentBoss.EnableMe();
		currentBossSound.EnableMe();
		currentBossID.EnableMe();
		currentBossMonsterName.EnableMe();
		currentBossName.EnableMe();
		currentBossHealth.EnableMe();
		currentBossScoreAward.EnableMe();
		currentBossDamageMultiplier.EnableMe();
		currentGroundSpeed.EnableMe();
		currentAirSpeed.EnableMe();
		currentWaterSpeed.EnableMe();
		currentJumpZ.EnableMe();
		currentGibMultiplier.EnableMe();
		currentGibSizeMultiplier.EnableMe();
		b_default.EnableMe();
		b_OK.EnableMe();
		b_random.EnableMe();
		currentbSetup.EnableMe();
		b_EditMode.EnableMe();
	}

	if( !bEditMode)
	{
		currentDrawScale.DisableMe();
		currentCollisionHeight.DisableMe();
		currentCollisionRadius.DisableMe();
		currentBoss.EnableMe();
		currentPrePivotX.DisableMe();
		currentPrePivotY.DisableMe();
		currentPrePivotZ.DisableMe();
		b_Paste.DisableMe();

		return;
	}
	else
	{
		currentBoss.DisableMe();
		currentBossID.DisableMe();
		currentBossMonsterName.DisableMe();
		currentBossName.DisableMe();
		currentBossHealth.DisableMe();
		currentBossScoreAward.DisableMe();
		currentBossDamageMultiplier.DisableMe();
		currentGroundSpeed.DisableMe();
		currentAirSpeed.DisableMe();
		currentWaterSpeed.DisableMe();
		currentJumpZ.DisableMe();
		currentGibMultiplier.DisableMe();
		currentGibSizeMultiplier.DisableMe();
		b_default.DisableMe();
		b_random.DisableMe();
		currentBossSound.DisableMe();
		currentbSetup.DisableMe();
		currentDrawScale.EnableMe();
		currentCollisionHeight.EnableMe();
		currentCollisionRadius.EnableMe();
		currentPrePivotX.EnableMe();
		currentPrePivotY.EnableMe();
		currentPrePivotZ.EnableMe();
	}
}

defaultproperties
{
     Begin Object Class=moNumericEdit Name=Bosses
         ComponentJustification=TXTA_Left
         CaptionWidth=0.400000
         ComponentWidth=0.560000
         Caption="Boss:"
         OnCreateComponent=Bosses.InternalOnCreateComponent
         Hint="Select the boss you'd like to configure."
         WinTop=0.103292
         WinLeft=0.417101
         WinWidth=0.158253
         WinHeight=0.033333
         RenderWeight=0.700000
         TabOrder=0
         bBoundToParent=True
         bScaleToParent=True
         OnChange=InvasionProBossConfig.InternalOnChange
     End Object
     currentBoss=moNumericEdit'InvasionProv1_7.InvasionProBossConfig.Bosses'

     Begin Object Class=moNumericEdit Name=BossID
         MinValue=0
         MaxValue=100
         CaptionWidth=0.400000
         ComponentWidth=0.300000
         Caption="Boss ID:"
         OnCreateComponent=BossID.InternalOnCreateComponent
         Hint="This should be the same as the chosen boss id."
         WinTop=0.165106
         WinLeft=0.066513
         WinWidth=0.396244
         WinHeight=0.033333
         RenderWeight=0.700000
         TabOrder=1
         bBoundToParent=True
         bScaleToParent=True
     End Object
     currentBossID=moNumericEdit'InvasionProv1_7.InvasionProBossConfig.BossID'

     Begin Object Class=moNumericEdit Name=BossScoreAward
         MinValue=0
         MaxValue=999999
         CaptionWidth=0.100000
         ComponentWidth=0.300000
         Caption="Score Value:"
         OnCreateComponent=BossScoreAward.InternalOnCreateComponent
         Hint="The amount of points that are shared between the surviving players when this boss has been defeated."
         WinTop=0.332694
         WinLeft=0.066513
         WinWidth=0.396244
         WinHeight=0.033333
         RenderWeight=0.700000
         TabOrder=4
         bBoundToParent=True
         bScaleToParent=True
     End Object
     currentBossScoreAward=moNumericEdit'InvasionProv1_7.InvasionProBossConfig.BossScoreAward'

     Begin Object Class=moNumericEdit Name=BossHealth
         MinValue=1
         MaxValue=999999
         CaptionWidth=0.220000
         ComponentWidth=0.300000
         Caption="Health:"
         OnCreateComponent=BossHealth.InternalOnCreateComponent
         Hint="How much health should the boss have."
         WinTop=0.219939
         WinLeft=0.066513
         WinWidth=0.396244
         WinHeight=0.033333
         RenderWeight=0.700000
         TabOrder=2
         bBoundToParent=True
         bScaleToParent=True
     End Object
     currentBossHealth=moNumericEdit'InvasionProv1_7.InvasionProBossConfig.BossHealth'

     Begin Object Class=moComboBox Name=BossClass
         bReadOnly=True
         CaptionWidth=0.250000
         Caption="Species:"
         OnCreateComponent=BossClass.InternalOnCreateComponent
         Hint="Choose a monster to be the boss for this wave."
         WinTop=0.167246
         WinLeft=0.500538
         WinWidth=0.439792
         WinHeight=0.033333
         TabOrder=12
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
         OnChange=InvasionProBossConfig.InternalOnChange
     End Object
     currentBossMonsterName=moComboBox'InvasionProv1_7.InvasionProBossConfig.BossClass'

     Begin Object Class=moEditBox Name=BossName
         CaptionWidth=0.250000
         Caption="Name:"
         OnCreateComponent=BossName.InternalOnCreateComponent
         Hint="Input the desired name for this boss."
         WinTop=0.218577
         WinLeft=0.500538
         WinWidth=0.439792
         WinHeight=0.033333
         TabOrder=13
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentBossName=moEditBox'InvasionProv1_7.InvasionProBossConfig.BossName'

     Begin Object Class=moEditBox Name=BossSound
         CaptionWidth=0.250000
         Caption="Warning Sound:"
         OnCreateComponent=BossSound.InternalOnCreateComponent
         Hint="Input the sound to be played when this boss spawns."
         WinTop=0.713882
         WinLeft=0.499364
         WinWidth=0.440966
         WinHeight=0.044444
         TabOrder=13
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentBossSound=moEditBox'InvasionProv1_7.InvasionProBossConfig.BossSound'

     Begin Object Class=moSlider Name=BossGroundSpeed
         MaxValue=2000.000000
         SliderCaptionStyleName="TextLabel"
         Caption="Ground Speed:"
         OnCreateComponent=BossGroundSpeed.InternalOnCreateComponent
         Hint="How fast the boss can move on the ground."
         WinTop=0.385418
         WinLeft=0.066513
         WinWidth=0.396244
         WinHeight=0.033333
         TabOrder=5
         bBoundToParent=True
         bScaleToParent=True
     End Object
     currentGroundSpeed=moSlider'InvasionProv1_7.InvasionProBossConfig.BossGroundSpeed'

     Begin Object Class=moSlider Name=BossAirSpeed
         MaxValue=2000.000000
         SliderCaptionStyleName="TextLabel"
         Caption="Air Speed:"
         OnCreateComponent=BossAirSpeed.InternalOnCreateComponent
         Hint="How fast the boss moves through the air."
         WinTop=0.488357
         WinLeft=0.066513
         WinWidth=0.396244
         WinHeight=0.033333
         TabOrder=7
         bBoundToParent=True
         bScaleToParent=True
     End Object
     currentAirSpeed=moSlider'InvasionProv1_7.InvasionProBossConfig.BossAirSpeed'

     Begin Object Class=moSlider Name=BossWaterSpeed
         MaxValue=2000.000000
         SliderCaptionStyleName="TextLabel"
         Caption="Water Speed:"
         OnCreateComponent=BossWaterSpeed.InternalOnCreateComponent
         Hint="How fast the boss can move through water."
         WinTop=0.437844
         WinLeft=0.066513
         WinWidth=0.396244
         WinHeight=0.033333
         TabOrder=6
         bBoundToParent=True
         bScaleToParent=True
     End Object
     currentWaterSpeed=moSlider'InvasionProv1_7.InvasionProBossConfig.BossWaterSpeed'

     Begin Object Class=moSlider Name=BossJumpZ
         MaxValue=2000.000000
         SliderCaptionStyleName="TextLabel"
         Caption="JumpZ:"
         OnCreateComponent=BossJumpZ.InternalOnCreateComponent
         Hint="How high the boss can jump."
         WinTop=0.540231
         WinLeft=0.066513
         WinWidth=0.396244
         WinHeight=0.033333
         TabOrder=8
         bBoundToParent=True
         bScaleToParent=True
     End Object
     currentJumpZ=moSlider'InvasionProv1_7.InvasionProBossConfig.BossJumpZ'

     Begin Object Class=moSlider Name=BossGibMultiplier
         MaxValue=10.000000
         SliderCaptionStyleName="TextLabel"
         Caption="Gib Multiplier:"
         OnCreateComponent=BossGibMultiplier.InternalOnCreateComponent
         Hint="If the boss is gibbed, how gibby should the experience be."
         WinTop=0.648266
         WinLeft=0.066513
         WinWidth=0.396244
         WinHeight=0.033333
         TabOrder=10
         bBoundToParent=True
         bScaleToParent=True
     End Object
     currentGibMultiplier=moSlider'InvasionProv1_7.InvasionProBossConfig.BossGibMultiplier'

     Begin Object Class=moSlider Name=BossGibSizeMultiplier
         MaxValue=10.000000
         SliderCaptionStyleName="TextLabel"
         Caption="GibSize Multiplier:"
         OnCreateComponent=BossGibSizeMultiplier.InternalOnCreateComponent
         Hint="If the boss is gibbed, how big should the gibs be."
         WinTop=0.699117
         WinLeft=0.066513
         WinWidth=0.396244
         WinHeight=0.033333
         TabOrder=11
         bBoundToParent=True
         bScaleToParent=True
     End Object
     currentGibSizeMultiplier=moSlider'InvasionProv1_7.InvasionProBossConfig.BossGibSizeMultiplier'

     Begin Object Class=moSlider Name=BossDamage
         MaxValue=10.000000
         SliderCaptionStyleName="TextLabel"
         Caption="Damage Multiplier:"
         OnCreateComponent=BossDamage.InternalOnCreateComponent
         Hint="This value will multiply the damage out put of the boss."
         WinTop=0.591560
         WinLeft=0.066513
         WinWidth=0.396244
         WinHeight=0.033333
         TabOrder=9
         bBoundToParent=True
         bScaleToParent=True
     End Object
     currentBossDamageMultiplier=moSlider'InvasionProv1_7.InvasionProBossConfig.BossDamage'

     Begin Object Class=moFloatEdit Name=cDrawScale
         MinValue=0.000001
         MaxValue=10.000000
         Step=0.050000
         CaptionWidth=0.400000
         ComponentWidth=0.350000
         Caption="Draw Scale: "
         OnCreateComponent=cDrawScale.InternalOnCreateComponent
         Hint="The draw scale of the boss."
         WinTop=0.267143
         WinLeft=0.500538
         WinWidth=0.439792
         WinHeight=0.085457
         TabOrder=14
         OnChange=InvasionProBossConfig.InternalOnChange
     End Object
     currentDrawScale=moFloatEdit'InvasionProv1_7.InvasionProBossConfig.cDrawScale'

     Begin Object Class=moFloatEdit Name=cCollisionHeight
         MinValue=0.000000
         MaxValue=2000.000000
         Step=0.050000
         CaptionWidth=0.400000
         ComponentWidth=0.350000
         Caption="Collision Height: "
         OnCreateComponent=cCollisionHeight.InternalOnCreateComponent
         Hint="The collision height of the boss."
         WinTop=0.322074
         WinLeft=0.500538
         WinWidth=0.439792
         WinHeight=0.033333
         TabOrder=15
         OnChange=InvasionProBossConfig.InternalOnChange
     End Object
     currentCollisionHeight=moFloatEdit'InvasionProv1_7.InvasionProBossConfig.cCollisionHeight'

     Begin Object Class=moFloatEdit Name=cCollisionRadius
         MinValue=0.000000
         MaxValue=2000.000000
         Step=0.050000
         CaptionWidth=0.400000
         ComponentWidth=0.350000
         Caption="Collision Radius: "
         OnCreateComponent=cCollisionRadius.InternalOnCreateComponent
         Hint="The collision radius of the boss."
         WinTop=0.377005
         WinLeft=0.500538
         WinWidth=0.439792
         WinHeight=0.033333
         TabOrder=16
         OnChange=InvasionProBossConfig.InternalOnChange
     End Object
     currentCollisionRadius=moFloatEdit'InvasionProv1_7.InvasionProBossConfig.cCollisionRadius'

     Begin Object Class=moFloatEdit Name=cPrePivotX
         MinValue=-1000.000000
         MaxValue=1000.000000
         Step=0.050000
         CaptionWidth=0.400000
         ComponentWidth=0.445000
         Caption=".X "
         OnCreateComponent=cPrePivotX.InternalOnCreateComponent
         Hint="The Prepivot.X value of the boss."
         WinTop=0.437226
         WinLeft=0.592556
         WinWidth=0.349353
         WinHeight=0.033333
         TabOrder=17
         OnChange=InvasionProBossConfig.InternalOnChange
     End Object
     currentPrePivotX=moFloatEdit'InvasionProv1_7.InvasionProBossConfig.cPrePivotX'

     Begin Object Class=moFloatEdit Name=cPrePivotY
         MinValue=-1000.000000
         MaxValue=1000.000000
         Step=0.050000
         CaptionWidth=0.400000
         ComponentWidth=0.445000
         Caption=".Y "
         OnCreateComponent=cPrePivotY.InternalOnCreateComponent
         Hint="The Prepivot.Y value of the boss."
         WinTop=0.489853
         WinLeft=0.592556
         WinWidth=0.349353
         WinHeight=0.033333
         TabOrder=18
         OnChange=InvasionProBossConfig.InternalOnChange
     End Object
     currentPrePivotY=moFloatEdit'InvasionProv1_7.InvasionProBossConfig.cPrePivotY'

     Begin Object Class=moFloatEdit Name=cPrePivotZ
         MinValue=-1000.000000
         MaxValue=1000.000000
         Step=0.050000
         CaptionWidth=0.400000
         ComponentWidth=0.445000
         Caption=".Z "
         OnCreateComponent=cPrePivotZ.InternalOnCreateComponent
         Hint="The Prepivot.Z value of the boss."
         WinTop=0.541122
         WinLeft=0.592556
         WinWidth=0.349353
         WinHeight=0.033333
         TabOrder=19
         OnChange=InvasionProBossConfig.InternalOnChange
     End Object
     currentPrePivotZ=moFloatEdit'InvasionProv1_7.InvasionProBossConfig.cPrePivotZ'

     Begin Object Class=GUIButton Name=EditButton
         Caption="Edit Mode"
         Hint="Activate edit mode to change size values."
         WinTop=0.851290
         WinLeft=0.687682
         WinWidth=0.251747
         WinHeight=0.049962
         TabOrder=25
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProBossConfig.ToggleEditMode
         OnKeyEvent=EditButton.InternalOnKeyEvent
     End Object
     b_EditMode=GUIButton'InvasionProv1_7.InvasionProBossConfig.EditButton'

     Begin Object Class=GUIButton Name=DefaultButton
         Caption="Default"
         Hint="Set the defaults for the current boss monster."
         WinTop=0.782116
         WinLeft=0.069518
         WinWidth=0.251747
         WinHeight=0.049962
         TabOrder=20
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProBossConfig.DefaultBoss
         OnKeyEvent=DefaultButton.InternalOnKeyEvent
     End Object
     b_Default=GUIButton'InvasionProv1_7.InvasionProBossConfig.DefaultButton'

     Begin Object Class=GUIButton Name=RandomButton
         Caption="Random"
         Hint="Create a random boss."
         WinTop=0.851290
         WinLeft=0.069518
         WinWidth=0.251747
         WinHeight=0.049962
         TabOrder=21
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProBossConfig.RandomBoss
         OnKeyEvent=RandomButton.InternalOnKeyEvent
     End Object
     b_Random=GUIButton'InvasionProv1_7.InvasionProBossConfig.RandomButton'

     Begin Object Class=GUIButton Name=PasteButton
         Caption="Paste"
         Hint="Paste the saved size properties to this boss."
         WinTop=0.782116
         WinLeft=0.687682
         WinWidth=0.251747
         WinHeight=0.049962
         TabOrder=24
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProBossConfig.PasteSize
         OnKeyEvent=PasteButton.InternalOnKeyEvent
     End Object
     b_Paste=GUIButton'InvasionProv1_7.InvasionProBossConfig.PasteButton'

     Begin Object Class=GUILabel Name=PivotLabel
         Caption="PrePivot"
         StyleName="TextLabel"
         WinTop=0.409001
         WinLeft=0.500538
         WinWidth=0.439792
         WinHeight=0.085457
         RenderWeight=0.200000
     End Object
     monsterPrePivotLabel=GUILabel'InvasionProv1_7.InvasionProBossConfig.PivotLabel'

     Begin Object Class=moCheckBox Name=c_bSetup
         bValueReadOnly=True
         CaptionWidth=0.200000
         Caption="Initialized: "
         OnCreateComponent=c_bSetup.InternalOnCreateComponent
         Hint="The boss is ready to join the invasion."
         WinTop=0.114658
         WinLeft=0.671098
         WinWidth=0.267203
         WinHeight=0.033333
         TabOrder=32
         bBoundToParent=True
     End Object
     currentbSetup=moCheckBox'InvasionProv1_7.InvasionProBossConfig.c_bSetup'

     Begin Object Class=GUIButton Name=LockedCancelButton
         Caption="Close"
         Hint="Close this window and cancel unsaved changes."
         WinTop=0.851290
         WinLeft=0.385094
         WinWidth=0.251747
         WinHeight=0.049962
         TabOrder=23
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProBossConfig.ExitBoss
         OnKeyEvent=LockedCancelButton.InternalOnKeyEvent
     End Object
     b_Cancel=GUIButton'InvasionProv1_7.InvasionProBossConfig.LockedCancelButton'

     Begin Object Class=GUIButton Name=LockedOKButton
         Caption="Save Boss"
         Hint="Save the current boss."
         WinTop=0.782116
         WinLeft=0.385094
         WinWidth=0.251747
         WinHeight=0.049962
         TabOrder=22
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProBossConfig.SaveBoss
         OnKeyEvent=LockedOKButton.InternalOnKeyEvent
     End Object
     b_OK=GUIButton'InvasionProv1_7.InvasionProBossConfig.LockedOKButton'

     bRequire640x480=True
     WinTop=0.050000
     WinLeft=0.000000
     WinWidth=1.000000
     WinHeight=0.900000
     bScaleToParent=True
}
