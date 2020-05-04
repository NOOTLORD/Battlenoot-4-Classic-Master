class InvasionProWaveConfig extends GUICustomPropertyPage;

var() int ActiveWave;
var() Automated GUIButton b_Copy;
var() Automated GUIButton b_Paste;
var() Automated GUIButton b_Reset;
var() Automated GUIButton b_Random;
var() Automated GUIButton b_Default;
var() Automated moCheckBox currentbBossWave;
var() Automated moCheckBox currentbBossesSpawnTogether;
var() Automated moFloatEdit currentWaveDifficulty;
var() Automated moNumericEdit currentWave;
var() Automated moNumericEdit currentWaveDuration;
var() Automated moNumericEdit currentWaveMaxMonsters;
var() Automated moNumericEdit currentMaxMonsters;
var() Automated moNumericEdit currentWaveOverTimeDamage;
var() Automated moNumericEdit currentBossTimeLimit;
var() Automated moEditBox currentBossID;
var() Automated moNumericEdit currentMaxLives;
var() Automated moComboBox currentFallbackMonster;
var() Automated moComboBox currentWaveMonster[30];
var() Automated moEditBox currentWaveName;
var() Automated moNumericEdit currentFallbackBossID;
var() Automated moSlider currentWaveColourR;
var() Automated moSlider currentWaveColourG;
var() Automated moSlider currentWaveColourB;
var() Automated GUILabel currentWaveColour;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local int i, h;

	Super.InitComponent(MyController, MyOwner);

	b_OK.WinWidth = default.b_OK.WinWidth;
	b_OK.WinHeight = default.b_OK.WinHeight;
	b_OK.WinLeft = default.b_OK.WinLeft;
	b_OK.WinTop = default.b_OK.WinTop;
	b_Cancel.WinWidth = default.b_Cancel.WinWidth;
	b_Cancel.WinHeight = default.b_Cancel.WinHeight;
	b_Cancel.WinLeft = default.b_Cancel.WinLeft;
	b_Cancel.WinTop = default.b_Cancel.WinTop;

	currentFallbackMonster.MyComboBox.MaxVisibleItems=20;
	currentFallbackMonster.MyComboBox.Edit.FontScale=FNS_Small;
	currentFallbackMonster.StandardHeight=0.03;

	sb_Main.Caption = "Wave Configuration";
	sb_Main.bScaleToParent=true;
	sb_Main.WinWidth=0.948281;
	sb_Main.WinHeight=0.918939;
	sb_Main.WinLeft=0.025352;
	sb_Main.WinTop=0.045161;

	t_WindowTitle.Caption = "InvasionPro: Wave Configuration";

	for(i=0;i<class'InvasionProMonsterTable'.default.MonsterTable.Length;i++)
	{
		currentFallbackMonster.AddItem(class'InvasionProMonsterTable'.default.MonsterTable[i].MonsterName);
	}

	for(i=0;i<30;i++)
	{
		currentWaveMonster[i].StandardHeight=0.04;
		currentWaveMonster[i].MyComboBox.MaxVisibleItems=15;
	}

	for(i=0;i<30;i++)
	{
		for(h=0;h<class'InvasionProMonsterTable'.default.MonsterTable.Length;h++)
		{
			if(class'InvasionProMonsterTable'.default.MonsterTable[h].MonsterName != "")
			{
				currentWaveMonster[i].AddItem(class'InvasionProMonsterTable'.default.MonsterTable[h].MonsterName);
			}
			else
			{
				currentWaveMonster[i].SetText("None");
			}
		}
	}

	currentBossID.MyEditBox.AllowedCharSet = "0123456789,";
	currentWave.SetValue(0);
	ActiveWave = currentWave.GetValue();
	RefreshWave();
}

function bool InternalDraw(Canvas Canvas)
{
	local color TestColor;

	if(Canvas != None)
	{
		TestColor.R = currentWaveColourR.GetValue();
		TestColor.G = currentWaveColourG.GetValue();
		TestColor.B = currentWaveColourB.GetValue();
		TestColor.A = 255;
		currentWaveColour.TextColor = TestColor;
		currentWaveColour.FocusedTextColor = TestColor;
	}

	return false;
}

function bool ExitWave(GUIComponent Sender)
{
	Controller.CloseMenu(false);

	return true;
}

function bool InternalOnClick(GUIComponent Sender)
{
	Controller.CloseMenu(false);
	return true;
}

function InternalOnChange(GUIComponent Sender)
{
	if(Sender == currentWave)
	{
		ActiveWave = currentWave.GetValue();
		RefreshWave();
	}
}

function bool ClearWave(GUIComponent Sender)
{
	local int i;

	ActiveWave = currentWave.GetValue();
	for(i=0;i<30;i++)
	{
		currentWaveMonster[i].SetText("None");
	}

	return true;
}

function bool RandomWave(GUIComponent Sender)
{
	local int i;

	ActiveWave = currentWave.GetValue();
	for(i=0;i<30;i++)
	{
		currentWaveMonster[i].SetText(RandomMonster());
	}

	return true;
}

function bool DefaultWave(GUIComponent Sender)
{
	local int i;

	ActiveWave = currentWave.GetValue();

	currentbBossWave.SetComponentValue(class'InvasionProDefaultWaves'.default.Waves[ActiveWave].bBossWave);
	currentBossID.SetText(class'InvasionProDefaultWaves'.default.Waves[ActiveWave].BossID);
	currentFallbackBossID.SetComponentValue(class'InvasionProDefaultWaves'.default.Waves[ActiveWave].FallbackBossID);
	currentWaveName.SetText(class'InvasionProDefaultWaves'.default.Waves[ActiveWave].WaveName);
	currentWaveDuration.SetComponentValue(class'InvasionProDefaultWaves'.default.Waves[ActiveWave].WaveDuration);
	currentWaveDifficulty.SetComponentValue(class'InvasionProDefaultWaves'.default.Waves[ActiveWave].WaveDifficulty);
	currentWaveMaxMonsters.SetComponentValue(class'InvasionProDefaultWaves'.default.Waves[ActiveWave].WaveMaxMonsters);
	currentFallbackMonster.SetText(class'InvasionProDefaultWaves'.default.Waves[ActiveWave].WaveFallbackMonster);
	currentMaxLives.SetComponentValue(class'InvasionProDefaultWaves'.default.Waves[ActiveWave].MaxLives);
	currentWaveColourR.SetComponentValue(class'InvasionProDefaultWaves'.default.Waves[ActiveWave].WaveDrawColour.R);
	currentWaveColourG.SetComponentValue(class'InvasionProDefaultWaves'.default.Waves[ActiveWave].WaveDrawColour.G);
	currentWaveColourB.SetComponentValue(class'InvasionProDefaultWaves'.default.Waves[ActiveWave].WaveDrawColour.B);
	currentMaxMonsters.SetComponentValue(class'InvasionProDefaultWaves'.default.Waves[ActiveWave].MaxMonsters);
	currentWaveOverTimeDamage.SetComponentValue(class'InvasionProDefaultWaves'.default.Waves[ActiveWave].BossOverTimeDamage);
	currentBossTimeLimit.SetComponentValue(class'InvasionProDefaultWaves'.default.Waves[ActiveWave].BossTimeLimit);
	currentbBossesSpawnTogether.SetComponentValue(class'InvasionProDefaultWaves'.default.Waves[ActiveWave].bBossesSpawnTogether);

	for(i=0;i<30;i++)
	{
		if(class'InvasionProDefaultWaves'.default.Waves[ActiveWave].Monsters[i] != "")
		{
			currentWaveMonster[i].SetText(class'InvasionProDefaultWaves'.default.Waves[ActiveWave].Monsters[i]);
		}
		else
		{
			currentWaveMonster[i].SetText("None");
		}
	}

	return true;
}

function string RandomMonster()
{
	local string LuckyMonster;
	local int i;

	i = Max(1,Rand(class'InvasionProMonsterTable'.default.MonsterTable.Length));
	//default to which ever monster happens to be in number 1 position (default is pupae)
	LuckyMonster = class'InvasionProMonsterTable'.default.MonsterTable[i].MonsterName;
	return LuckyMonster;
}

function bool SaveWave(GUIComponent Sender)
{
	local int i;

	ActiveWave = currentWave.GetValue();
	class'InvasionProConfigs'.default.Waves[ActiveWave].BossID = currentBossID.GetText();
	class'InvasionProConfigs'.default.Waves[ActiveWave].bBossWave = currentbBossWave.IsChecked();
	class'InvasionProConfigs'.default.Waves[ActiveWave].FallbackBossID = currentFallbackBossID.GetValue();
	class'InvasionProConfigs'.default.Waves[ActiveWave].WaveName = currentWaveName.GetText();
	class'InvasionProConfigs'.default.Waves[ActiveWave].WaveDuration = currentWaveDuration.GetValue();
	class'InvasionProConfigs'.default.Waves[ActiveWave].WaveDifficulty = currentWaveDifficulty.GetValue();
	class'InvasionProConfigs'.default.Waves[ActiveWave].WaveMaxMonsters = currentWaveMaxMonsters.GetValue();
	class'InvasionProConfigs'.default.Waves[ActiveWave].MaxMonsters = currentMaxMonsters.GetValue();
	class'InvasionProConfigs'.default.Waves[ActiveWave].WaveFallbackMonster = currentFallbackMonster.GetText();
	class'InvasionProConfigs'.default.Waves[ActiveWave].MaxLives = currentMaxLives.GetValue();
	class'InvasionProConfigs'.default.Waves[ActiveWave].WaveDrawColour.R = currentWaveColourR.GetValue();
	class'InvasionProConfigs'.default.Waves[ActiveWave].WaveDrawColour.G = currentWaveColourG.GetValue();
	class'InvasionProConfigs'.default.Waves[ActiveWave].WaveDrawColour.B = currentWaveColourB.GetValue();
	class'InvasionProConfigs'.default.Waves[ActiveWave].BossOverTimeDamage = currentWaveOverTimeDamage.GetValue();
	class'InvasionProConfigs'.default.Waves[ActiveWave].BossTimeLimit = currentBossTimeLimit.GetValue();
	class'InvasionProConfigs'.default.Waves[ActiveWave].bBossesSpawnTogether = currentbBossesSpawnTogether.IsChecked();

	for(i=0;i<30;i++)
	{
		class'InvasionProConfigs'.default.Waves[ActiveWave].Monsters[i] = currentWaveMonster[i].GetText();
	}

	class'InvasionProConfigs'.static.StaticSaveConfig();
	return true;
}

function RefreshWave()
{
	local int i;

	ActiveWave = currentWave.GetValue();
	if( (ActiveWave + 1) > class'InvasionProConfigs'.default.Waves.Length )
	{
		class'InvasionProConfigs'.default.Waves.Insert(class'InvasionProConfigs'.default.Waves.Length, 1);
		class'InvasionProConfigs'.static.StaticSaveConfig();
	}

	currentbBossWave.SetComponentValue(class'InvasionProConfigs'.default.Waves[ActiveWave].bBossWave);
	currentBossID.SetText(class'InvasionProConfigs'.default.Waves[ActiveWave].BossID);
	currentFallbackBossID.SetComponentValue(class'InvasionProConfigs'.default.Waves[ActiveWave].FallbackBossID);
	currentWaveName.SetText(class'InvasionProConfigs'.default.Waves[ActiveWave].WaveName);
	currentWaveDuration.SetComponentValue(class'InvasionProConfigs'.default.Waves[ActiveWave].WaveDuration);
	currentWaveDifficulty.SetComponentValue(class'InvasionProConfigs'.default.Waves[ActiveWave].WaveDifficulty);
	currentWaveMaxMonsters.SetComponentValue(class'InvasionProConfigs'.default.Waves[ActiveWave].WaveMaxMonsters);
	currentMaxMonsters.SetComponentValue(class'InvasionProConfigs'.default.Waves[ActiveWave].MaxMonsters);
	currentFallbackMonster.SetText(class'InvasionProConfigs'.default.Waves[ActiveWave].WaveFallbackMonster);
	currentMaxLives.SetComponentValue(class'InvasionProConfigs'.default.Waves[ActiveWave].MaxLives);
	currentWaveColourR.SetComponentValue(class'InvasionProConfigs'.default.Waves[ActiveWave].WaveDrawColour.R);
	currentWaveColourG.SetComponentValue(class'InvasionProConfigs'.default.Waves[ActiveWave].WaveDrawColour.G);
	currentWaveColourB.SetComponentValue(class'InvasionProConfigs'.default.Waves[ActiveWave].WaveDrawColour.B);
	currentWaveOverTimeDamage.SetComponentValue(class'InvasionProConfigs'.default.Waves[ActiveWave].BossOverTimeDamage);
	currentBossTimeLimit.SetComponentValue(class'InvasionProConfigs'.default.Waves[ActiveWave].BossTimeLimit);
	currentbBossesSpawnTogether.SetComponentValue(class'InvasionProConfigs'.default.Waves[ActiveWave].bBossesSpawnTogether);

	for(i=0;i<30;i++)
	{
		if(class'InvasionProConfigs'.default.Waves[ActiveWave].Monsters[i] != "")
		{
			currentWaveMonster[i].SetText(class'InvasionProConfigs'.default.Waves[ActiveWave].Monsters[i]);
		}
		else
		{
			currentWaveMonster[i].SetText("None");
		}
	}
}

function bool CopyWave(GUIComponent Sender)
{
	local int i;

	class'InvasionProCopyPaste'.default.ClipBoardbBossWave = currentbBossWave.IsChecked();
	class'InvasionProCopyPaste'.default.ClipBoardbBossesSpawnTogether = currentbBossesSpawnTogether.IsChecked();
	class'InvasionProCopyPaste'.default.ClipBoardBossID = currentBossID.GetText();
	class'InvasionProCopyPaste'.default.ClipBoardFallbackBossID = currentFallbackBossID.GetValue();
	class'InvasionProCopyPaste'.default.ClipBoardBossOverTimeDamage = currentWaveOverTimeDamage.GetValue();
	class'InvasionProCopyPaste'.default.ClipBoardBossTimeLimit = currentBossTimeLimit.GetValue();
	class'InvasionProCopyPaste'.default.ClipBoardWaveDrawColour.R = currentWaveColourR.GetValue();
	class'InvasionProCopyPaste'.default.ClipBoardWaveDrawColour.G = currentWaveColourG.GetValue();
	class'InvasionProCopyPaste'.default.ClipBoardWaveDrawColour.B = currentWaveColourB.GetValue();
	class'InvasionProCopyPaste'.default.ClipBoardWaveDuration = currentWaveDuration.GetValue();
	class'InvasionProCopyPaste'.default.ClipBoardWaveDifficulty = currentWaveDifficulty.GetValue();
	class'InvasionProCopyPaste'.default.ClipBoardWaveMaxMonsters = currentWaveMaxMonsters.GetValue();
	class'InvasionProCopyPaste'.default.ClipBoardMaxMonsters = currentMaxMonsters.GetValue();
	class'InvasionProCopyPaste'.default.ClipBoardMaxLives = currentMaxLives.GetValue();
	class'InvasionProCopyPaste'.default.ClipBoardWaveFallbackMonster = currentFallbackMonster.GetText();

	for(i=0;i<30;i++)
	{
		class'InvasionProCopyPaste'.default.ClipBoardMonsters[i] = currentWaveMonster[i].GetText();
	}

	class'InvasionProCopyPaste'.static.StaticSaveConfig();
	return true;
}

function bool PasteWave(GUIComponent Sender)
{
	local int i;

	currentbBossWave.SetComponentValue(class'InvasionProCopyPaste'.default.ClipBoardbBossWave);
	currentBossID.SetText(class'InvasionProCopyPaste'.default.ClipBoardBossID);
	currentFallbackBossID.SetComponentValue(class'InvasionProCopyPaste'.default.ClipBoardFallbackBossID);
	//currentWaveName.SetText(class'InvasionProCopyPaste'.default.ClipBoardWaveName);
	currentWaveDuration.SetComponentValue(class'InvasionProCopyPaste'.default.ClipBoardWaveDuration);
	currentWaveDifficulty.SetComponentValue(class'InvasionProCopyPaste'.default.ClipBoardWaveDifficulty);
	currentWaveMaxMonsters.SetComponentValue(class'InvasionProCopyPaste'.default.ClipBoardWaveMaxMonsters);
	currentMaxMonsters.SetComponentValue(class'InvasionProCopyPaste'.default.ClipBoardMaxMonsters);
	currentFallbackMonster.SetText(class'InvasionProCopyPaste'.default.ClipBoardWaveFallbackMonster);
	currentMaxLives.SetComponentValue(class'InvasionProCopyPaste'.default.ClipBoardMaxLives);
	currentWaveColourR.SetComponentValue(class'InvasionProCopyPaste'.default.ClipBoardWaveDrawColour.R);
	currentWaveColourG.SetComponentValue(class'InvasionProCopyPaste'.default.ClipBoardWaveDrawColour.G);
	currentWaveColourB.SetComponentValue(class'InvasionProCopyPaste'.default.ClipBoardWaveDrawColour.B);
	currentWaveOverTimeDamage.SetComponentValue(class'InvasionProCopyPaste'.default.ClipBoardBossOverTimeDamage);
	currentBossTimeLimit.SetComponentValue(class'InvasionProCopyPaste'.default.ClipBoardBossTimeLimit);
	currentbBossesSpawnTogether.SetComponentValue(class'InvasionProCopyPaste'.default.ClipBoardbBossesSpawnTogether);

	for(i=0;i<30;i++)
	{
		currentWaveMonster[i].SetText(class'InvasionProCopyPaste'.default.ClipBoardMonsters[i]);
	}

	return true;
}

defaultproperties
{
     Begin Object Class=GUIButton Name=CopyButton
         Caption="Copy"
         Hint="Copy the current wave settings to the clipboard, they can then be pasted onto another wave."
         WinTop=0.910102
         WinLeft=0.450489
         WinWidth=0.096758
         WinHeight=0.043801
         TabOrder=50
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProWaveConfig.CopyWave
         OnKeyEvent=CopyButton.InternalOnKeyEvent
     End Object
     b_Copy=GUIButton'InvasionProv1_7.InvasionProWaveConfig.CopyButton'

     Begin Object Class=GUIButton Name=PasteButton
         Caption="Paste"
         Hint="Paste the wave settings that are currently on the clipboard into the current wave."
         WinTop=0.910102
         WinLeft=0.554238
         WinWidth=0.096758
         WinHeight=0.043801
         TabOrder=51
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProWaveConfig.PasteWave
         OnKeyEvent=PasteButton.InternalOnKeyEvent
     End Object
     b_Paste=GUIButton'InvasionProv1_7.InvasionProWaveConfig.PasteButton'

     Begin Object Class=GUIButton Name=ResetButton
         Caption="Clear All"
         Hint="remove all wave monsters."
         WinTop=0.910102
         WinLeft=0.322483
         WinWidth=0.121758
         WinHeight=0.043801
         TabOrder=49
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProWaveConfig.ClearWave
         OnKeyEvent=ResetButton.InternalOnKeyEvent
     End Object
     b_Reset=GUIButton'InvasionProv1_7.InvasionProWaveConfig.ResetButton'

     Begin Object Class=GUIButton Name=RandomButton
         Caption="Random"
         Hint="random monsters will be chosen for the wave."
         WinTop=0.910102
         WinLeft=0.197489
         WinWidth=0.121758
         WinHeight=0.043801
         TabOrder=48
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProWaveConfig.RandomWave
         OnKeyEvent=RandomButton.InternalOnKeyEvent
     End Object
     b_Random=GUIButton'InvasionProv1_7.InvasionProWaveConfig.RandomButton'

     Begin Object Class=GUIButton Name=LockedDefaultButton
         Caption="Default"
         Hint="Set the default for this wave."
         WinTop=0.910102
         WinLeft=0.073427
         WinWidth=0.121758
         WinHeight=0.043801
         TabOrder=47
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProWaveConfig.DefaultWave
         OnKeyEvent=LockedDefaultButton.InternalOnKeyEvent
     End Object
     b_Default=GUIButton'InvasionProv1_7.InvasionProWaveConfig.LockedDefaultButton'

     Begin Object Class=moCheckBox Name=bBossWave
         CaptionWidth=0.500000
         Caption="Boss Wave"
         OnCreateComponent=bBossWave.InternalOnCreateComponent
         Hint="Toggles whether this is a Boss wave."
         WinTop=0.107481
         WinLeft=0.336451
         WinWidth=0.156239
         WinHeight=0.033333
         TabOrder=6
         bBoundToParent=True
     End Object
     currentbBossWave=moCheckBox'InvasionProv1_7.InvasionProWaveConfig.bBossWave'

     Begin Object Class=moCheckBox Name=bBossesSpawnTogether
         CaptionWidth=0.500000
         Caption="Bosses Spawn Together"
         OnCreateComponent=bBossesSpawnTogether.InternalOnCreateComponent
         Hint="Toggles whether bosses spawn together all at once or one after another."
         WinTop=0.150814
         WinLeft=0.051451
         WinWidth=0.277489
         WinHeight=0.033333
         TabOrder=1
         bBoundToParent=True
     End Object
     currentbBossesSpawnTogether=moCheckBox'InvasionProv1_7.InvasionProWaveConfig.bBossesSpawnTogether'

     Begin Object Class=moFloatEdit Name=WaveDifficulty
         MinValue=0.000000
         MaxValue=4.000000
         Step=0.050000
         CaptionWidth=1.000000
         ComponentWidth=0.305000
         Caption="Wave Difficulty"
         OnCreateComponent=WaveDifficulty.InternalOnCreateComponent
         Hint="How difficult this wave should be."
         WinTop=0.214198
         WinLeft=0.334639
         WinWidth=0.233773
         WinHeight=0.033333
         TabOrder=8
         bBoundToParent=True
         bScaleToParent=True
     End Object
     currentWaveDifficulty=moFloatEdit'InvasionProv1_7.InvasionProWaveConfig.WaveDifficulty'

     Begin Object Class=moNumericEdit Name=WaveNumber
         MinValue=0
         MaxValue=999
         ComponentWidth=0.250000
         Caption="Wave No"
         OnCreateComponent=WaveNumber.InternalOnCreateComponent
         Hint="Select the wave you'd like to configure."
         WinTop=0.107597
         WinLeft=0.051084
         WinWidth=0.277489
         WinHeight=0.033333
         RenderWeight=0.700000
         TabOrder=0
         bBoundToParent=True
         bScaleToParent=True
         OnChange=InvasionProWaveConfig.InternalOnChange
     End Object
     currentWave=moNumericEdit'InvasionProv1_7.InvasionProWaveConfig.WaveNumber'

     Begin Object Class=moNumericEdit Name=WaveDuration
         MinValue=1
         MaxValue=999
         CaptionWidth=1.000000
         ComponentWidth=0.305000
         Caption="Wave Duration"
         OnCreateComponent=WaveDuration.InternalOnCreateComponent
         Hint="Roughly how long should each wave last (in seconds)."
         WinTop=0.165159
         WinLeft=0.334639
         WinWidth=0.233773
         WinHeight=0.033333
         RenderWeight=0.700000
         TabOrder=7
         bBoundToParent=True
         bScaleToParent=True
     End Object
     currentWaveDuration=moNumericEdit'InvasionProv1_7.InvasionProWaveConfig.WaveDuration'

     Begin Object Class=moNumericEdit Name=WaveMaxMonsters
         MinValue=1
         MaxValue=100
         CaptionWidth=1.000000
         ComponentWidth=0.190000
         Caption="Wave Max Monsters"
         OnCreateComponent=WaveMaxMonsters.InternalOnCreateComponent
         Hint="Maximum number of monsters to spawn this wave."
         WinTop=0.214198
         WinLeft=0.577958
         WinWidth=0.375022
         WinHeight=0.033333
         RenderWeight=0.700000
         TabOrder=12
         bBoundToParent=True
         bScaleToParent=True
     End Object
     currentWaveMaxMonsters=moNumericEdit'InvasionProv1_7.InvasionProWaveConfig.WaveMaxMonsters'

     Begin Object Class=moNumericEdit Name=MaxMonsters
         MinValue=1
         MaxValue=100
         CaptionWidth=1.000000
         ComponentWidth=0.305000
         Caption="Max Monsters"
         OnCreateComponent=MaxMonsters.InternalOnCreateComponent
         Hint="Maximum amount of monsters that may be in the map at one time."
         WinTop=0.261328
         WinLeft=0.334639
         WinWidth=0.233773
         WinHeight=0.033333
         RenderWeight=0.700000
         TabOrder=9
         bBoundToParent=True
         bScaleToParent=True
     End Object
     currentMaxMonsters=moNumericEdit'InvasionProv1_7.InvasionProWaveConfig.MaxMonsters'

     Begin Object Class=moNumericEdit Name=WaveOverTimeDamage
         MinValue=0
         MaxValue=999999
         ComponentWidth=0.250000
         Caption="Over Time Damage"
         OnCreateComponent=WaveOverTimeDamage.InternalOnCreateComponent
         Hint="If this is a boss wave and the boss time limit is reached, how much damage per second should players take?"
         WinTop=0.327968
         WinLeft=0.051084
         WinWidth=0.277489
         WinHeight=0.033333
         RenderWeight=0.700000
         TabOrder=5
         bBoundToParent=True
         bScaleToParent=True
     End Object
     currentWaveOverTimeDamage=moNumericEdit'InvasionProv1_7.InvasionProWaveConfig.WaveOverTimeDamage'

     Begin Object Class=moNumericEdit Name=BossTimeLimit
         MinValue=0
         MaxValue=999999
         ComponentWidth=0.250000
         Caption="Boss Time Limit"
         OnCreateComponent=BossTimeLimit.InternalOnCreateComponent
         Hint="If this is a boss wave how much time do players have to kill the boss or bosses? (In seconds)."
         WinTop=0.285375
         WinLeft=0.051084
         WinWidth=0.277489
         WinHeight=0.033333
         RenderWeight=0.700000
         TabOrder=4
         bBoundToParent=True
         bScaleToParent=True
     End Object
     currentBossTimeLimit=moNumericEdit'InvasionProv1_7.InvasionProWaveConfig.BossTimeLimit'

     Begin Object Class=moEditBox Name=BossID
         CaptionWidth=1.000000
         ComponentWidth=0.600000
         Caption="Boss ID"
         OnCreateComponent=BossID.InternalOnCreateComponent
         Hint="This should be the same as the chosen boss id, separate multiple bosses with a comma. I.e if you wanted 2 bosses it might look like 1,2."
         WinTop=0.189842
         WinLeft=0.050643
         WinWidth=0.277489
         WinHeight=0.044444
         TabOrder=2
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentBossID=moEditBox'InvasionProv1_7.InvasionProWaveConfig.BossID'

     Begin Object Class=moNumericEdit Name=MaxLives
         MinValue=1
         MaxValue=999
         CaptionWidth=1.000000
         ComponentWidth=0.190000
         Caption="Max Lives"
         OnCreateComponent=MaxLives.InternalOnCreateComponent
         Hint="The number of lives player have on this wave."
         WinTop=0.261298
         WinLeft=0.577958
         WinWidth=0.375022
         WinHeight=0.033333
         RenderWeight=0.700000
         TabOrder=13
         bBoundToParent=True
         bScaleToParent=True
     End Object
     currentMaxLives=moNumericEdit'InvasionProv1_7.InvasionProWaveConfig.MaxLives'

     Begin Object Class=moComboBox Name=FallbackMonster
         bReadOnly=True
         CaptionWidth=0.250000
         Caption="Fallback Monster"
         OnCreateComponent=FallbackMonster.InternalOnCreateComponent
         Hint="If monsters cannot spawn; this fallback monster can attempt to take their place."
         WinTop=0.166187
         WinLeft=0.577016
         WinWidth=0.373480
         WinHeight=0.033333
         TabOrder=11
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentFallbackMonster=moComboBox'InvasionProv1_7.InvasionProWaveConfig.FallbackMonster'

     Begin Object Class=moComboBox Name=MonsterNum01
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum01.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.364239
         WinLeft=0.068388
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=17
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(0)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum01'

     Begin Object Class=moComboBox Name=MonsterNum02
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum02.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.410506
         WinLeft=0.068388
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=18
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(1)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum02'

     Begin Object Class=moComboBox Name=MonsterNum03
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum03.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.456773
         WinLeft=0.068388
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=19
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(2)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum03'

     Begin Object Class=moComboBox Name=MonsterNum04
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum04.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.503040
         WinLeft=0.068388
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=20
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(3)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum04'

     Begin Object Class=moComboBox Name=MonsterNum05
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum05.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.549307
         WinLeft=0.068388
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=21
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(4)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum05'

     Begin Object Class=moComboBox Name=MonsterNum06
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum06.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.595574
         WinLeft=0.068388
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=22
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(5)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum06'

     Begin Object Class=moComboBox Name=MonsterNum07
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum07.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.641841
         WinLeft=0.068388
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=23
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(6)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum07'

     Begin Object Class=moComboBox Name=MonsterNum08
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum08.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.688108
         WinLeft=0.068388
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=24
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(7)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum08'

     Begin Object Class=moComboBox Name=MonsterNum09
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum09.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.734375
         WinLeft=0.068388
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=25
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(8)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum09'

     Begin Object Class=moComboBox Name=MonsterNum10
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum10.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.780642
         WinLeft=0.068388
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=26
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(9)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum10'

     Begin Object Class=moComboBox Name=MonsterNum11
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum11.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.364239
         WinLeft=0.382208
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=27
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(10)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum11'

     Begin Object Class=moComboBox Name=MonsterNum12
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum12.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.410506
         WinLeft=0.382208
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=28
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(11)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum12'

     Begin Object Class=moComboBox Name=MonsterNum13
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum13.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.456773
         WinLeft=0.382208
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=29
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(12)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum13'

     Begin Object Class=moComboBox Name=MonsterNum14
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum14.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.503040
         WinLeft=0.382208
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=30
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(13)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum14'

     Begin Object Class=moComboBox Name=MonsterNum15
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum15.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.549307
         WinLeft=0.382208
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=31
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(14)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum15'

     Begin Object Class=moComboBox Name=MonsterNum16
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum16.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.595574
         WinLeft=0.382208
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=32
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(15)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum16'

     Begin Object Class=moComboBox Name=MonsterNum17
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum17.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.641841
         WinLeft=0.382208
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=33
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(16)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum17'

     Begin Object Class=moComboBox Name=MonsterNum18
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum18.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.688108
         WinLeft=0.382208
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=34
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(17)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum18'

     Begin Object Class=moComboBox Name=MonsterNum19
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum19.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.734375
         WinLeft=0.382208
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=35
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(18)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum19'

     Begin Object Class=moComboBox Name=MonsterNum20
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum20.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.780642
         WinLeft=0.382208
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=36
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(19)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum20'

     Begin Object Class=moComboBox Name=MonsterNum21
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum21.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.364239
         WinLeft=0.716932
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=37
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(20)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum21'

     Begin Object Class=moComboBox Name=MonsterNum22
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum22.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.410506
         WinLeft=0.716932
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=38
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(21)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum22'

     Begin Object Class=moComboBox Name=MonsterNum23
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum23.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.456773
         WinLeft=0.716932
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=39
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(22)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum23'

     Begin Object Class=moComboBox Name=MonsterNum24
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum24.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.503040
         WinLeft=0.716932
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=40
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(23)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum24'

     Begin Object Class=moComboBox Name=MonsterNum25
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum25.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.549307
         WinLeft=0.716932
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=41
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(24)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum25'

     Begin Object Class=moComboBox Name=MonsterNum26
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum26.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.595574
         WinLeft=0.716932
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=42
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(25)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum26'

     Begin Object Class=moComboBox Name=MonsterNum27
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum27.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.641841
         WinLeft=0.716932
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=43
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(26)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum27'

     Begin Object Class=moComboBox Name=MonsterNum28
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum28.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.688108
         WinLeft=0.716932
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=44
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(27)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum28'

     Begin Object Class=moComboBox Name=MonsterNum29
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum29.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.734375
         WinLeft=0.716932
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=45
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(28)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum29'

     Begin Object Class=moComboBox Name=MonsterNum30
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         OnCreateComponent=MonsterNum30.InternalOnCreateComponent
         Hint="Select a monster that may spawn on this wave."
         WinTop=0.780642
         WinLeft=0.716932
         WinWidth=0.231566
         WinHeight=0.048525
         TabOrder=46
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveMonster(29)=moComboBox'InvasionProv1_7.InvasionProWaveConfig.MonsterNum30'

     Begin Object Class=moEditBox Name=WaveName
         CaptionWidth=1.000000
         ComponentWidth=0.700000
         Caption="Wave Name"
         OnCreateComponent=WaveName.InternalOnCreateComponent
         Hint="Input the desired name for this wave."
         WinTop=0.104180
         WinLeft=0.497139
         WinWidth=0.457147
         WinHeight=0.044444
         TabOrder=10
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
     End Object
     currentWaveName=moEditBox'InvasionProv1_7.InvasionProWaveConfig.WaveName'

     Begin Object Class=moNumericEdit Name=FallbackBossID
         MinValue=0
         MaxValue=100
         CaptionWidth=1.000000
         ComponentWidth=0.250000
         Caption="Fallback Boss ID"
         OnCreateComponent=FallbackBossID.InternalOnCreateComponent
         Hint="This is the id of the fallback boss that should try to spawn if the main boss cannot."
         WinTop=0.241959
         WinLeft=0.050643
         WinWidth=0.277489
         WinHeight=0.033333
         RenderWeight=0.700000
         TabOrder=3
         bBoundToParent=True
         bScaleToParent=True
     End Object
     currentFallbackBossID=moNumericEdit'InvasionProv1_7.InvasionProWaveConfig.FallbackBossID'

     Begin Object Class=moSlider Name=WaveColourR
         MaxValue=255.000000
         bIntSlider=True
         SliderCaptionStyleName="TextLabel"
         ComponentWidth=0.850000
         Caption="R"
         OnCreateComponent=WaveColourR.InternalOnCreateComponent
         Hint="How much Red for the wave name color."
         WinTop=0.313916
         WinLeft=0.521884
         WinWidth=0.128065
         WinHeight=0.033333
         TabOrder=14
         bBoundToParent=True
         bScaleToParent=True
     End Object
     currentWaveColourR=moSlider'InvasionProv1_7.InvasionProWaveConfig.WaveColourR'

     Begin Object Class=moSlider Name=WaveColourG
         MaxValue=255.000000
         bIntSlider=True
         SliderCaptionStyleName="TextLabel"
         ComponentWidth=0.850000
         Caption="G"
         OnCreateComponent=WaveColourG.InternalOnCreateComponent
         Hint="How much Green for the wave name color."
         WinTop=0.313916
         WinLeft=0.671173
         WinWidth=0.128065
         WinHeight=0.033333
         TabOrder=15
         bBoundToParent=True
         bScaleToParent=True
     End Object
     currentWaveColourG=moSlider'InvasionProv1_7.InvasionProWaveConfig.WaveColourG'

     Begin Object Class=moSlider Name=WaveColourB
         MaxValue=255.000000
         bIntSlider=True
         SliderCaptionStyleName="TextLabel"
         ComponentWidth=0.850000
         Caption="B"
         OnCreateComponent=WaveColourB.InternalOnCreateComponent
         Hint="How much Blue for the wave name color."
         WinTop=0.313916
         WinLeft=0.821647
         WinWidth=0.128065
         WinHeight=0.033333
         TabOrder=16
         bBoundToParent=True
         bScaleToParent=True
     End Object
     currentWaveColourB=moSlider'InvasionProv1_7.InvasionProWaveConfig.WaveColourB'

     Begin Object Class=GUILabel Name=WaveColour
         Caption="Wave Name Color"
         WinTop=0.313688
         WinLeft=0.334867
         WinWidth=0.181976
         WinHeight=0.037037
         OnDraw=InvasionProWaveConfig.InternalDraw
     End Object
     currentWaveColour=GUILabel'InvasionProv1_7.InvasionProWaveConfig.WaveColour'

     Begin Object Class=AltSectionBackground Name=InternalFrameImage
         WinTop=0.039439
         WinLeft=0.040977
         WinWidth=0.913323
         WinHeight=0.924130
         bScaleToParent=True
         OnPreDraw=InternalFrameImage.InternalPreDraw
     End Object
     sb_Main=AltSectionBackground'InvasionProv1_7.InvasionProWaveConfig.InternalFrameImage'

     Begin Object Class=GUIButton Name=LockedCancelButton
         Caption="Close"
         Hint="Close this window & changes will not be saved."
         WinTop=0.910102
         WinLeft=0.803740
         WinWidth=0.121758
         WinHeight=0.043801
         TabOrder=53
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProWaveConfig.ExitWave
         OnKeyEvent=LockedCancelButton.InternalOnKeyEvent
     End Object
     b_Cancel=GUIButton'InvasionProv1_7.InvasionProWaveConfig.LockedCancelButton'

     Begin Object Class=GUIButton Name=LockedOKButton
         Caption="Save Wave"
         Hint="Save the current wave."
         WinTop=0.910102
         WinLeft=0.658740
         WinWidth=0.141758
         WinHeight=0.043801
         TabOrder=52
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProWaveConfig.SaveWave
         OnKeyEvent=LockedOKButton.InternalOnKeyEvent
     End Object
     b_OK=GUIButton'InvasionProv1_7.InvasionProWaveConfig.LockedOKButton'

     bRequire640x480=True
     WinTop=0.050000
     WinLeft=0.000000
     WinWidth=1.000000
     WinHeight=0.900000
     bScaleToParent=True
}
