//==============================================================================
//	Description
//
//	Created by Ron Prestenback
//	© 2003, Epic Games, Inc.  All Rights Reserved
//==============================================================================
class UT2K4Tab_AudioSettings extends Settings_Tabs;

#exec OBJ LOAD FILE=PickupSounds.uax
#exec OBJ LOAD FILE=AnnouncerMale2K4.uax

var array<CacheManager.AnnouncerRecord> Announcers;

var string StatusPreviewSound, RewardPreviewSound;

var localized string	AudioModes[4],
						VoiceModes[4],
						AnnounceModes[3];


var automated GUISectionBackground	i_BG1, i_BG2;
var automated moSlider		sl_MusicVol, sl_EffectsVol, sl_VoiceVol;
var automated moComboBox	co_Mode, co_Voices, co_Announce, co_RewardAnnouncer, co_StatusAnnouncer;
var automated moCheckbox 	ch_AutoTaunt, ch_MatureTaunts, ch_Default;

var float	fMusic, fEffects;
var int		iVoice, iMode, iVoiceMode, iAnnounce;
var string	sStatAnnouncer, sRewAnnouncer;
var bool	bAuto, bMature, bCompat, b3DSound, bEAX, bDefault;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local int i;
    local bool bIsWin32;

	bIsWin32 = ( ( PlatformIsWindows() ) && ( !PlatformIs64Bit() ) );

	Super.InitComponent(MyController, MyOwner);

	if ( bIsWin32 )
	{
		for(i = 0;i < ArrayCount(AudioModes);i++)
			co_Mode.AddItem(AudioModes[i]);
	}
	else
	{
		co_Mode.AddItem("OpenAL");
	}

	for(i = 0;i < ArrayCount(VoiceModes);i++)
		co_Voices.AddItem(VoiceModes[i]);

	for(i = 0;i < ArrayCount(AnnounceModes);i++)
		co_Announce.AddItem(AnnounceModes[i]);

	i_BG2.WinWidth=0.503398;
	i_BG2.WinHeight=0.453045;
	i_BG2.WinLeft=0.004063;
	i_BG2.WinTop=0.540831;

	i_BG1.ManageComponent(sl_MusicVol);
	i_BG1.ManageComponent(sl_EffectsVol);
	i_BG1.ManageComponent(co_Mode);
	i_BG1.ManageComponent(ch_Default);
	i_BG1.ManageComponent(co_Voices);
	i_BG1.ManageComponent(ch_MatureTaunts);
	i_BG1.ManageComponent(ch_AutoTaunt);

	i_BG2.ManageComponent(sl_VoiceVol);
	i_BG2.ManageComponent(co_Announce);

	i_BG2.ManageComponent(co_StatusAnnouncer);
	i_BG2.ManageComponent(co_RewardAnnouncer);

	class'CacheManager'.static.GetAnnouncerList( Announcers );
	for ( i = 0; i < Announcers.Length; i++ )
	{
		if ( Announcers[i].FriendlyName != "" )
		{
			co_StatusAnnouncer.AddItem( Announcers[i].FriendlyName,,string(i) );
	        co_RewardAnnouncer.AddItem( Announcers[i].FriendlyName,,string(i) );
		}
	}

	// !!! FIXME: Might use a preinstalled system OpenAL in the future on
	// !!! FIXME:  Mac or Unix, but for now, we don't...  --ryan.
	if ( !PlatformIsWindows() )
		ch_Default.DisableMe();
}

function ResetClicked()
{
	local class<AudioSubSystem> A;
	local class UnrealPlayerClass;
	local PlayerController PC;
	local int i;

	Super.ResetClicked();

	PC = PlayerOwner();

	A = class<AudioSubSystem>(DynamicLoadObject(GetNativeClassName("Engine.Engine.AudioDevice"), Class'Class'));
	A.static.ResetConfig();

	class'PlayerController'.static.ResetConfig("bAutoTaunt");
	class'PlayerController'.static.ResetConfig("bNoMatureLanguage");
	class'PlayerController'.static.ResetConfig("bNoAutoTaunts");
	class'PlayerController'.static.ResetConfig("bNoVoiceTaunts");
	class'PlayerController'.static.ResetConfig("bNoVoiceMessages");
	class'PlayerController'.static.ResetConfig("AnnouncerLevel");

	UnrealPlayerClass = class(DynamicLoadObject("UnrealGame.UnrealPlayer",class'Class'));
	if ( UnrealPlayerClass != None )
	{
		UnrealPlayerClass.static.ResetConfig("CustomRewardAnnouncerPack");
		UnrealPlayerClass.static.ResetConfig("CustomStatusAnnouncerPack");
	}

	for (i = 0; i < Components.Length; i++)
		Components[i].LoadINI();
}

function InternalOnLoadINI(GUIComponent Sender, string s)
{
	local int i;
	local PlayerController PC;
	local bool bIsWin32;

	PC = PlayerOwner();

	switch (Sender)
	{
	case sl_VoiceVol:
		iVoice = PC.AnnouncerVolume;
     	sl_VoiceVol.SetComponentValue(iVoice,true);
		break;

	case sl_MusicVol:
		fMusic = float(PC.ConsoleCommand("get ini:Engine.Engine.AudioDevice MusicVolume"));
		sl_MusicVol.SetComponentValue(fMusic,true);
		break;

	case sl_EffectsVol:
		fEffects = float(PC.ConsoleCommand("get ini:Engine.Engine.AudioDevice SoundVolume"));
		sl_EffectsVol.SetComponentValue(fEffects,true);
		break;

	case co_Mode:
		iMode = 1;
		bIsWin32 = ( ( PlatformIsWindows() ) && ( !PlatformIs64Bit() ) );
		if ( !bIsWin32 )
		{
			bCompat = False;
			b3DSound = True;
			iMode = 0;
		}
		else
		{
			if ( bool(PC.ConsoleCommand("get ini:Engine.Engine.AudioDevice CompatibilityMode")) )
			{
				bCompat = True;
				iMode = 0;
			}

			if ( bool(PC.ConsoleCommand("get ini:Engine.Engine.AudioDevice Use3DSound")) )
			{
				b3DSound = True;
				iMode = 2;
			}

			if ( bool(PC.ConsoleCommand("get ini:Engine.Engine.AudioDevice UseEAX" )) )
			{
				bEAX = True;
				iMode = 3;
			}
		}
		co_Mode.SilentSetIndex(iMode);
		break;
		
	case ch_Default:
		bDefault = bool(PC.ConsoleCommand("get ini:Engine.Engine.AudioDevice UseDefaultDriver"));
		ch_Default.SetComponentValue(bDefault,true);
		break;

	case co_Voices:
		if ( PC.bNoAutoTaunts ) iVoiceMode = 1;
		if ( PC.bNoVoiceTaunts ) iVoiceMode = 2;
		if ( PC.bNoVoiceMessages ) iVoiceMode = 3;
		co_Voices.SilentSetIndex(iVoiceMode);
		break;

	case ch_AutoTaunt:
		bAuto = PC.bAutoTaunt;
		ch_AutoTaunt.SetComponentValue(bAuto,true);
		break;

	case ch_MatureTaunts:
		bMature = !PC.bNoMatureLanguage;
		ch_MatureTaunts.SetComponentValue(bMature,true);
		break;

	case co_Announce:
		iAnnounce = PC.AnnouncerLevel;
		co_Announce.SilentSetIndex(iAnnounce);
		break;

	case co_RewardAnnouncer:

		if ( PC.IsA('UnrealPlayer') )
		{
			sStatAnnouncer = PC.GetCustomStatusAnnouncerClass();
			sRewAnnouncer = PC.GetCustomRewardAnnouncerClass();
		}
		else
		{
			sStatAnnouncer = class'UnrealPlayer'.default.CustomStatusAnnouncerPack;
			sRewAnnouncer = class'UnrealPlayer'.default.CustomRewardAnnouncerPack;
		}

		i = FindAnnouncerClassIndex(sStatAnnouncer);
		if ( i != -1 )
		{
			i = co_StatusAnnouncer.FindIndex(Announcers[i].FriendlyName);
			if ( i != -1 )
				co_StatusAnnouncer.SilentSetIndex(i);
		}

		i = FindAnnouncerClassIndex(sRewAnnouncer);
		if (i != -1)
		{
			i = co_RewardAnnouncer.FindIndex(Announcers[i].FriendlyName);
			if ( i != -1 )
				co_RewardAnnouncer.SilentSetIndex(i);
		}

		break;

	default:
		log(Name@"Unknown component calling LoadINI:"$ GUIMenuOption(Sender).Caption);
		GUIMenuOption(Sender).SetComponentValue(s,true);
	}
}

function InternalOnChange(GUIComponent Sender)
{
	local PlayerController PC;
	local float AnnouncerVol;
	local Sound snd;
	local int AnnouncerIdx;
	local bool bIsWin32;

	bIsWin32 = ( ( PlatformIsWindows() ) && ( !PlatformIs64Bit() ) );

	Super.InternalOnChange(Sender);
	PC = PlayerOwner();

	switch(Sender)
	{
		case sl_VoiceVol:
			iVoice = sl_VoiceVol.GetValue();
			AnnouncerVol = 2.0 * FClamp(0.1 + iVoice*0.225,0.2,1.0);
			if ( co_StatusAnnouncer == None )
				return;

			snd = sound(co_StatusAnnouncer.GetObject());
			if ( snd == None && Announcers.Length > 0 )
			{
				snd = Sound(DynamicLoadObject(Announcers[AnnouncerIdx].PackageName $ "." $ StatusPreviewSound,class'Sound'));
				if ( snd == none )
					snd = Sound(DynamicLoadObject(Announcers[AnnouncerIdx].FallbackPackage $ "." $ StatusPreviewSound,class'Sound'));

				co_StatusAnnouncer.MyComboBox.List.SetObjectAtIndex(co_StatusAnnouncer.MyComboBox.List.Index,snd);
			}

			if ( snd != None )
				PC.PlaySound(snd,SLOT_Talk,AnnouncerVol);

			break;

		case sl_MusicVol:
			fMusic = sl_MusicVol.GetValue();
			PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice MusicVolume"@fMusic);
			PC.ConsoleCommand("SetMusicVolume"@fMusic);

			if( PC.Level.Song != "" && PC.Level.Song != "None" )
				PC.ClientSetMusic( PC.Level.Song, MTRAN_Instant );
			else PC.ClientSetMusic( class'UT2K4MainMenu'.default.MenuSong, MTRAN_Instant );
			break;

		case sl_EffectsVol:
			fEffects = sl_EffectsVol.GetValue();
			PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice SoundVolume"@fEffects);
			PC.ConsoleCommand("stopsounds");
			PC.PlaySound(sound'PickupSounds.AdrenelinPickup');
			break;

		case co_Mode:
			if ( !bIsWin32 )  // Simple OpenAL abstraction...  --ryan.
				break;

			iMode = co_Mode.GetIndex();
			if (iMode > 1)
				ShowPerformanceWarning();

			bCompat = iMode < 1;
			b3DSound = iMode > 1;
			bEAX = iMode > 2;
	        PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice CompatibilityMode"@bCompat);
	        PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice Use3DSound"@b3DSound);
	        PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice UseEAX"@bEAX);
			PC.ConsoleCommand("SOUND_REBOOT");

			// Restart music.
			if( PC.Level.Song != "" && PC.Level.Song != "None" )
				PC.ClientSetMusic( PC.Level.Song, MTRAN_Instant );
			else PC.ClientSetMusic( class'UT2K4MainMenu'.default.MenuSong, MTRAN_Instant );
			break;

		case ch_AutoTaunt:
			bAuto = ch_AutoTaunt.IsChecked();
			break;

		case ch_MatureTaunts:
			bMature = ch_MatureTaunts.IsChecked();
			break;

		case co_Voices:
			iVoiceMode = co_Voices.GetIndex();
			break;

		case ch_Default:
			bDefault = ch_Default.IsChecked();
			PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice UseDefaultDriver"@bDefault);
			PC.ConsoleCommand("SOUND_REBOOT");
			break;

		case co_Announce:
			iAnnounce = co_Announce.GetIndex();
			break;

		case co_RewardAnnouncer:
			AnnouncerIdx = int(co_RewardAnnouncer.GetExtra());
			sRewAnnouncer = Announcers[AnnouncerIdx].ClassName;

			AnnouncerVol = 2.0 * FClamp(0.1 + iVoice*0.225,0.2,1.0);
			snd = sound(co_RewardAnnouncer.GetObject());
			if ( snd == None )
			{
				snd = Sound(DynamicLoadObject(Announcers[AnnouncerIdx].PackageName $ "." $ RewardPreviewSound,class'Sound'));
				if ( snd == none )
					snd = Sound(DynamicLoadObject(Announcers[AnnouncerIdx].FallbackPackage $ "." $ RewardPreviewSound,class'Sound'));

				co_RewardAnnouncer.MyComboBox.List.SetObjectAtIndex(co_RewardAnnouncer.MyComboBox.List.Index,snd);
			}
			PC.PlaySound(snd,SLOT_Talk,AnnouncerVol);
			break;

		case co_StatusAnnouncer:
			AnnouncerIdx = int(co_StatusAnnouncer.GetExtra());
			sStatAnnouncer = Announcers[AnnouncerIdx].ClassName;

			AnnouncerVol = 2.0 * FClamp(0.1 + iVoice*0.225,0.2,1.0);
			snd = sound(co_StatusAnnouncer.GetObject());
			if ( snd == None )
			{
				snd = Sound(DynamicLoadObject(Announcers[AnnouncerIdx].PackageName $ "." $ StatusPreviewSound,class'Sound'));
				if ( snd == none )
					snd = Sound(DynamicLoadObject(Announcers[AnnouncerIdx].FallbackPackage $ "." $ StatusPreviewSound,class'Sound'));

				co_StatusAnnouncer.MyComboBox.List.SetObjectAtIndex(co_StatusAnnouncer.MyComboBox.List.Index,snd);
			}
			PC.PlaySound(snd,SLOT_Talk,AnnouncerVol);
			break;
	}
}

function SaveSettings()
{
	local PlayerController PC;
	local bool bSave, bReboot;

	Super.SaveSettings();
	PC = PlayerOwner();

	if (PC.AnnouncerLevel != iAnnounce)
	{
		PC.AnnouncerLevel = iAnnounce;
		PC.default.AnnouncerLevel = PC.AnnouncerLevel;
		bSave = True;
	}

	if (PC.AnnouncerVolume != iVoice)
	{
		PC.AnnouncerVolume = iVoice;
		PC.default.AnnouncerVolume = iVoice;
		bSave = True;
	}

	if (PC.bNoMatureLanguage == bMature)
	{
		PC.bNoMatureLanguage = !bMature;
		PC.default.bNoMatureLanguage = !bMature;
		bSave = True;
	}

	if (PC.bNoAutoTaunts != iVoiceMode > 0)
	{
		PC.bNoAutoTaunts = iVoiceMode > 0;
		PC.default.bNoAutoTaunts = PC.bNoAutoTaunts;
		bSave = True;
	}

	if (PC.bNoVoiceTaunts != iVoiceMode > 1)
	{
		PC.bNoVoiceTaunts = iVoiceMode > 1;
		PC.default.bNoVoiceTaunts = PC.bNoVoiceTaunts;
		bSave = True;
	}

	if (PC.bNoVoiceMessages != iVoiceMode == 3)
	{
		PC.bNoVoiceMessages = iVoiceMode == 3;
		PC.default.bNoVoiceMessages = PC.bNoVoiceMessages;
		bSave = True;
	}

	if (fMusic != sl_MusicVol.GetValue())
		PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice MusicVolume"@fMusic);

	if (fEffects != sl_EffectsVol.GetValue())
		PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice SoundVolume"@fEffects);

	if (bDefault != bool(PC.ConsoleCommand("get ini:Engine.Engine.AudioDevice UseDefaultDriver")))
	{
		PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice UseDefaultDriver"@bDefault);
		bReboot = True;
	}

    if ( !PC.Level.IsDemoBuild() && PC.IsA('UnrealPlayer') )
    {
    	if ( PC.GetCustomStatusAnnouncerClass() != sStatAnnouncer )
    	{
    		PC.SetCustomStatusAnnouncerClass(sStatAnnouncer);
    		bSave = True;
    	}

    	if ( PC.GetCustomRewardAnnouncerClass() != sRewAnnouncer )
    	{
    		PC.SetCustomRewardAnnouncerClass(sRewAnnouncer);
    		bSave = True;
    	}
    }

	if (bSave)
		PC.SaveConfig();

	if ( PC.bAutoTaunt != bAuto )
		PC.SetAutoTaunt(bAuto);

    if ( !PC.Level.IsDemoBuild() && !PC.IsA('UnrealPlayer') )
    {
    	if ( !(class'UnrealPlayer'.default.CustomStatusAnnouncerPack ~= sStatAnnouncer) ||
    		 !(class'UnrealPlayer'.default.CustomRewardAnnouncerPack ~= sRewAnnouncer) )
    	{
	    	class'UnrealPlayer'.default.CustomStatusAnnouncerPack = sStatAnnouncer;
	    	class'UnrealPlayer'.default.CustomRewardAnnouncerPack = sRewAnnouncer;
	    	class'UnrealPlayer'.static.StaticSaveConfig();
	    }
    }

	if (bReboot)
		PC.ConsoleCommand("SOUND_REBOOT");
}

function int FindAnnouncerClassIndex( string AnnouncerClass )
{
	local int i;

	for ( i = 0; i < Announcers.Length; i++ )
		if ( Announcers[i].ClassName ~= AnnouncerClass )
			return i;

	return -1;
}

function string GetAnnouncerClass( int Index )
{
	if ( Index < 0 || Index >= Announcers.Length )
		return "";

	return Announcers[Index].ClassName;
}

function string GetAnnouncerPackage( int Index )
{
	if ( Index < 0 || Index >= Announcers.Length )
		return "";

	return Announcers[Index].PackageName;
}

defaultproperties
{
     StatusPreviewSound="1_minute_remains"
     RewardPreviewSound="unstoppable"
     AudioModes(0)="Safe Mode"
     AudioModes(1)="3D Audio"
     AudioModes(2)="H/W 3D Audio"
     AudioModes(3)="H/W 3D + EAX"
     VoiceModes(0)="All"
     VoiceModes(1)="No auto-taunts"
     VoiceModes(2)="No taunts"
     VoiceModes(3)="None"
     AnnounceModes(0)="None"
     AnnounceModes(1)="Minimal"
     AnnounceModes(2)="All"
     Begin Object Class=GUISectionBackground Name=AudioBK1
         Caption="Sound Effects"
         NumColumns=2
         MaxPerColumn=5
         WinTop=0.017393
         WinLeft=0.004063
         WinWidth=0.987773
         WinHeight=0.502850
         OnPreDraw=AudioBK1.InternalPreDraw
     End Object
     i_BG1=GUISectionBackground'GUI2K4.UT2K4Tab_AudioSettings.AudioBK1'

     Begin Object Class=GUISectionBackground Name=AudioBK2
         Caption="Announcer"
         WinTop=0.004372
         WinLeft=0.004063
         WinWidth=0.987773
         WinHeight=0.517498
         OnPreDraw=AudioBK2.InternalPreDraw
     End Object
     i_BG2=GUISectionBackground'GUI2K4.UT2K4Tab_AudioSettings.AudioBK2'

     Begin Object Class=moSlider Name=AudioMusicVolume
         MaxValue=1.000000
         Caption="Music Volume"
         OnCreateComponent=AudioMusicVolume.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="0.5"
         Hint="Adjusts the volume of the background music."
         WinTop=0.070522
         WinLeft=0.018164
         WinWidth=0.450000
         TabOrder=0
         OnChange=UT2K4Tab_AudioSettings.InternalOnChange
         OnLoadINI=UT2K4Tab_AudioSettings.InternalOnLoadINI
     End Object
     sl_MusicVol=moSlider'GUI2K4.UT2K4Tab_AudioSettings.AudioMusicVolume'

     Begin Object Class=moSlider Name=AudioEffectsVolumeSlider
         MaxValue=1.000000
         Caption="Effects Volume"
         OnCreateComponent=AudioEffectsVolumeSlider.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="0.9"
         Hint="Adjusts the volume of all in game sound effects."
         WinTop=0.070522
         WinLeft=0.524024
         WinWidth=0.450000
         TabOrder=5
         OnChange=UT2K4Tab_AudioSettings.InternalOnChange
         OnLoadINI=UT2K4Tab_AudioSettings.InternalOnLoadINI
     End Object
     sl_EffectsVol=moSlider'GUI2K4.UT2K4Tab_AudioSettings.AudioEffectsVolumeSlider'

     Begin Object Class=moSlider Name=AudioAnnouncerVolume
         MaxValue=4.000000
         MinValue=1.000000
         bIntSlider=True
         CaptionWidth=0.650000
         Caption="Volume"
         OnCreateComponent=AudioAnnouncerVolume.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Adjusts the volume of all in game voice messages."
         WinTop=0.597866
         WinLeft=0.011329
         WinWidth=0.470703
         TabOrder=10
         OnChange=UT2K4Tab_AudioSettings.InternalOnChange
         OnLoadINI=UT2K4Tab_AudioSettings.InternalOnLoadINI
     End Object
     sl_VoiceVol=moSlider'GUI2K4.UT2K4Tab_AudioSettings.AudioAnnouncerVolume'

     Begin Object Class=moComboBox Name=AudioMode
         bReadOnly=True
         Caption="Audio Mode"
         OnCreateComponent=AudioMode.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="Software 3D Audio"
         Hint="Changes the audio system mode."
         WinTop=0.149739
         WinLeft=0.018164
         WinWidth=0.450000
         TabOrder=1
         OnChange=UT2K4Tab_AudioSettings.InternalOnChange
         OnLoadINI=UT2K4Tab_AudioSettings.InternalOnLoadINI
     End Object
     co_Mode=moComboBox'GUI2K4.UT2K4Tab_AudioSettings.AudioMode'

     Begin Object Class=moComboBox Name=AudioPlayVoices
         bReadOnly=True
         Caption="Play Voices"
         OnCreateComponent=AudioPlayVoices.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="All"
         Hint="Defines the types of voice messages to play."
         WinTop=0.149739
         WinLeft=0.524024
         WinWidth=0.450000
         TabOrder=6
         OnChange=UT2K4Tab_AudioSettings.InternalOnChange
         OnLoadINI=UT2K4Tab_AudioSettings.InternalOnLoadINI
     End Object
     co_Voices=moComboBox'GUI2K4.UT2K4Tab_AudioSettings.AudioPlayVoices'

     Begin Object Class=moComboBox Name=AudioAnnounce
         bReadOnly=True
         CaptionWidth=0.650000
         Caption="Announcements"
         OnCreateComponent=AudioAnnounce.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="All"
         Hint="Adjusts the amount of in-game announcements."
         WinTop=0.711079
         WinLeft=0.011329
         WinWidth=0.470703
         TabOrder=11
         OnChange=UT2K4Tab_AudioSettings.InternalOnChange
         OnLoadINI=UT2K4Tab_AudioSettings.InternalOnLoadINI
     End Object
     co_Announce=moComboBox'GUI2K4.UT2K4Tab_AudioSettings.AudioAnnounce'

     Begin Object Class=moComboBox Name=AudioRewardAnnouncer
         bReadOnly=True
         CaptionWidth=0.650000
         Caption="Reward Announcer"
         OnCreateComponent=AudioRewardAnnouncer.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="Each tournament player is linked to a Reward announcer that informs you when you've demonstrated exceptional combat skills."
         WinTop=0.890991
         WinLeft=0.011329
         WinWidth=0.470703
         TabOrder=13
         OnChange=UT2K4Tab_AudioSettings.InternalOnChange
         OnLoadINI=UT2K4Tab_AudioSettings.InternalOnLoadINI
     End Object
     co_RewardAnnouncer=moComboBox'GUI2K4.UT2K4Tab_AudioSettings.AudioRewardAnnouncer'

     Begin Object Class=moComboBox Name=AudioStatusAnnouncer
         bReadOnly=True
         CaptionWidth=0.650000
         Caption="Status Announcer"
         OnCreateComponent=AudioStatusAnnouncer.InternalOnCreateComponent
         IniOption="@Internal"
         Hint="The Status announcer relays important information about the game to tournament players and spectators."
         WinTop=0.801035
         WinLeft=0.011329
         WinWidth=0.470703
         TabOrder=12
         OnChange=UT2K4Tab_AudioSettings.InternalOnChange
     End Object
     co_StatusAnnouncer=moComboBox'GUI2K4.UT2K4Tab_AudioSettings.AudioStatusAnnouncer'

     Begin Object Class=moCheckBox Name=AudioAutoTaunt
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Auto-Taunt"
         OnCreateComponent=AudioAutoTaunt.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="True"
         Hint="Enables your in-game player to automatically taunt opponents."
         WinTop=0.320365
         WinLeft=0.524024
         WinWidth=0.450000
         TabOrder=8
         OnChange=UT2K4Tab_AudioSettings.InternalOnChange
         OnLoadINI=UT2K4Tab_AudioSettings.InternalOnLoadINI
     End Object
     ch_AutoTaunt=moCheckBox'GUI2K4.UT2K4Tab_AudioSettings.AudioAutoTaunt'

     Begin Object Class=moCheckBox Name=AudioMatureTaunts
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Mature Taunts"
         OnCreateComponent=AudioMatureTaunts.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="True"
         Hint="Enables off-color commentary."
         WinTop=0.235052
         WinLeft=0.524024
         WinWidth=0.450000
         TabOrder=7
         OnChange=UT2K4Tab_AudioSettings.InternalOnChange
         OnLoadINI=UT2K4Tab_AudioSettings.InternalOnLoadINI
     End Object
     ch_MatureTaunts=moCheckBox'GUI2K4.UT2K4Tab_AudioSettings.AudioMatureTaunts'

     PanelCaption="Audio"
     WinTop=0.150000
     WinHeight=0.740000
}