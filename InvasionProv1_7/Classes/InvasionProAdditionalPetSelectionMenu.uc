class InvasionProAdditionalPetSelectionMenu extends GUICustomPropertyPage;

var() Automated GUILabel currentSelectInfo;
var() InvasionProPetStatsItem MyPetStats;
var() Automated moComboBox currentPetClass;
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

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local Rotator SpinnyDudeRotation;

	Super.InitComponent(MyController, MyOwner);

	t_WindowTitle.Caption = "Pet Selection";
	b_OK.WinWidth = default.b_OK.WinWidth;
	b_OK.WinHeight = default.b_OK.WinHeight;
	b_OK.WinLeft = default.b_OK.WinLeft;
	b_OK.WinTop = default.b_OK.WinTop;
	b_Cancel.WinWidth = default.b_Cancel.WinWidth;
	b_Cancel.WinHeight = default.b_Cancel.WinHeight;
	b_Cancel.WinLeft = default.b_Cancel.WinLeft;
	b_Cancel.WinTop = default.b_Cancel.WinTop;
	b_DropTarget.WinWidth = default.b_DropTarget.WinWidth;
	b_DropTarget.WinHeight = default.b_DropTarget.WinHeight;
	b_DropTarget.WinLeft = default.b_DropTarget.WinLeft;
	b_DropTarget.WinTop = default.b_DropTarget.WinTop;

	if(InvasionProPetMenuConfig(ParentPage) != None)
	{
		MyPetStats = InvasionProPetMenuConfig(ParentPage).MyPetStats;
		if(MyPetStats == None)
		{
			log("Error Pet Stats Item could not be found!",'PetSelectionMenu');
			DisableMenu();
			return;
		}
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

	currentModelFOV.SetValue(90);
	currentModelFOV.MyLabel.FontScale = FNS_Small;
	currentModelRotation.MyLabel.FontScale = FNS_Small;
	currentAnimList.MyLabel.FontScale = FNS_Small;
	currentAnimList.MyComboBox.Edit.FontScale = FNS_Small;
	currentPetClass.MyComboBox.Edit.FontScale = FNS_Small;
	currentPetClass.MyLabel.FontScale = FNS_Small;
	currentPetClass.MyLabel.TextAlign = TXTA_Center;
	currentPetClass.StandardHeight = 0.050000;

	Initialize();
}

function Initialize()
{
	local int i;
	local string PetName;

	//if(MyPetStats.bTierMode)
	//{
		//currentSelectInfo.Caption = "The companion aura allows you to select a companion pet for your main pet. Please select a pet from the list.";
		currentPetClass.MyLabel.Caption = "Species";//$" (Tier "$MyPetStats.Tier$")";
	//}

	currentPetClass.myComboBox.Clear();

	for(i=0;i<250;i++)
	{
		PetName = MyPetStats.GetServerPet(i,true);
		if(PetName != "None")
		{
			currentPetClass.AddItem(PetName);
		}
	}

	currentPetClass.SetIndex(0);

	UpdateSpinnyDude(true);
}

function bool InternalOnClick(GUIComponent Sender)
{
	local class<Monster> PetClass;
	local string PetClassName;

	if(Sender == b_OK)
	{
		PetClassName = MyPetStats.GetPetClass(currentPetClass.GetText());
		PetClass = class<Monster>(DynamicLoadObject(PetClassName,class'class',true));
		if(PetClass != None)
		{
			MyPetStats.ServerSetCompanionPetClass(PetClassName);
			b_OK.DisableMe();
			currentPetClass.DisableMe();
			MyPetStats.SaveCompanionPet();
		}

		return true;
	}

	Controller.CloseMenu(false);
	return true;
}

event Closed(GUIComponent Sender, bool bCancelled)
{
    Super.Closed(Sender, bCancelled);

	if(SpinnyDude != None)
	{
		SpinnyDude.Destroy();
	}

	InvasionProPetMenuConfig(ParentPage).Initialize();
}

function DisableMenu()
{
	currentPetClass.DisableMe();
	b_OK.DisableMe();
}

function UpdateSpinnyDude(bool bPreview)
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

	if(!bPreview)
	{
		PetClassName = MyPetStats.PetClass;
	}
	else
	{
		PetClassName = MyPetStats.GetPetClass(currentPetClass.GetText());
	}

	M = class<Monster>(DynamicLoadObject(PetClassName,class'class',true));

    if(M == None)
    {
		b_DropTarget.Caption = "# Preview Not Available #";
		return;
	}

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

function bool InternalDraw(Canvas canvas)
{
    local vector CamPos, X, Y, Z;
    local rotator CamRot;
    local float   oOrgX, oOrgY;
    local float   oClipX, oClipY;

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

    return true;
}

function bool RaceCapturedMouseMove(float deltaX, float deltaY)
{
    local rotator r;

	if(SpinnyDude == None)
	{
		return true;
	}

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
		if(SpinnyDude == None)
		{
			return true;
		}

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
	if(Sender == currentPetClass)
	{
		UpdateSpinnyDude(true);
	}

	if(Sender == currentModelRotation)
	{
		if(SpinnyDude != None)
		{
			SpinnyDude.RotateSpeed = currentModelRotation.GetValue();
		}
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

function name StringToName(string str)
{
	SetPropertyText("NameConversion", str);
 	return NameConversion;
}

function PlayNewAnim()
{
	if(SpinnyDude == None)
	{
		return;
	}

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
	if(SpinnyDude == None)
	{
		return;
	}

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
		if(SpinnyDude == None)
		{
			return true;
		}

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

defaultproperties
{
     Begin Object Class=GUILabel Name=SelectInfo
         Caption="The companion aura allows you to select a companion pet for your main pet. The companion pet inherits the health, speed, damage and dodge attributes of your pet. Please select a pet from the list."
         bMultiLine=True
         FontScale=FNS_Small
         StyleName="TextLabel"
         WinTop=0.221338
         WinLeft=0.403012
         WinWidth=0.534617
         WinHeight=0.402146
         RenderWeight=0.200000
         TabOrder=0
         bScaleToParent=True
     End Object
     currentSelectInfo=GUILabel'InvasionProv1_7.InvasionProAdditionalPetSelectionMenu.SelectInfo'

     Begin Object Class=moComboBox Name=PetClass
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         Caption="Species"
         OnCreateComponent=PetClass.InternalOnCreateComponent
         Hint="Select a pet from this list."
         WinTop=0.184938
         WinLeft=0.061591
         WinWidth=0.323678
         WinHeight=0.075785
         TabOrder=40
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.050000
         OnChange=InvasionProAdditionalPetSelectionMenu.InternalOnChange
     End Object
     currentPetClass=moComboBox'InvasionProv1_7.InvasionProAdditionalPetSelectionMenu.PetClass'

     Begin Object Class=moComboBox Name=c_animlist
         bReadOnly=True
         bVerticalLayout=True
         ComponentJustification=TXTA_Left
         CaptionWidth=0.300000
         ComponentWidth=0.250000
         Caption="Available Anims: "
         OnCreateComponent=c_animlist.InternalOnCreateComponent
         FontScale=FNS_Small
         Hint="Choose an animation to play."
         WinTop=0.376925
         WinLeft=0.060507
         WinWidth=0.211541
         WinHeight=0.121255
         TabOrder=20
         bBoundToParent=True
         bScaleToParent=True
         StandardHeight=0.040000
         OnChange=InvasionProAdditionalPetSelectionMenu.InternalOnChange
     End Object
     currentAnimList=moComboBox'InvasionProv1_7.InvasionProAdditionalPetSelectionMenu.c_animlist'

     Begin Object Class=GUIGFXButton Name=PanUp
         Graphic=Texture'InvasionProTexturesv1_4.GUI.arrowUp_p'
         Position=ICP_Scaled
         StyleName="BindBox"
         Hint="Pan up."
         WinTop=0.365209
         WinLeft=0.330782
         WinWidth=0.039756
         WinHeight=0.039220
         RenderWeight=0.510000
         TabOrder=22
         bScaleToParent=True
         bNeverFocus=True
         bRepeatClick=True
         OnClickSound=CS_Down
         OnClick=InvasionProAdditionalPetSelectionMenu.PanView
         OnKeyEvent=PanUp.InternalOnKeyEvent
     End Object
     b_UArrow=GUIGFXButton'InvasionProv1_7.InvasionProAdditionalPetSelectionMenu.PanUp'

     Begin Object Class=GUIGFXButton Name=PanDown
         Graphic=Texture'InvasionProTexturesv1_4.GUI.arrowDown_p'
         Position=ICP_Scaled
         StyleName="BindBox"
         Hint="Pan down."
         WinTop=0.439334
         WinLeft=0.330782
         WinWidth=0.039756
         WinHeight=0.041462
         RenderWeight=0.510000
         TabOrder=24
         bScaleToParent=True
         bNeverFocus=True
         bRepeatClick=True
         OnClickSound=CS_Down
         OnClick=InvasionProAdditionalPetSelectionMenu.PanView
         OnKeyEvent=PanDown.InternalOnKeyEvent
     End Object
     b_DArrow=GUIGFXButton'InvasionProv1_7.InvasionProAdditionalPetSelectionMenu.PanDown'

     Begin Object Class=GUIGFXButton Name=PanLeft
         Graphic=Texture'InvasionProv1_7.arrowLeft_p'
         Position=ICP_Scaled
         StyleName="BindBox"
         Hint="Pan left."
         WinTop=0.391544
         WinLeft=0.310635
         WinWidth=0.029837
         WinHeight=0.060714
         RenderWeight=0.510000
         TabOrder=21
         bScaleToParent=True
         bNeverFocus=True
         bRepeatClick=True
         OnClickSound=CS_Down
         OnClick=InvasionProAdditionalPetSelectionMenu.PanView
         OnKeyEvent=PanLeft.InternalOnKeyEvent
     End Object
     b_LArrow=GUIGFXButton'InvasionProv1_7.InvasionProAdditionalPetSelectionMenu.PanLeft'

     Begin Object Class=GUIGFXButton Name=PanRight
         Graphic=Texture'InvasionProv1_7.arrowRight_p'
         Position=ICP_Scaled
         StyleName="BindBox"
         Hint="Pan right."
         WinTop=0.391544
         WinLeft=0.360041
         WinWidth=0.029837
         WinHeight=0.060714
         RenderWeight=0.510000
         TabOrder=23
         bScaleToParent=True
         bNeverFocus=True
         bRepeatClick=True
         OnClickSound=CS_Down
         OnClick=InvasionProAdditionalPetSelectionMenu.PanView
         OnKeyEvent=PanRight.InternalOnKeyEvent
     End Object
     b_RArrow=GUIGFXButton'InvasionProv1_7.InvasionProAdditionalPetSelectionMenu.PanRight'

     Begin Object Class=GUIGFXButton Name=PanReset
         ImageIndex=7
         Graphic=Texture'InvasionProv1_7.arrowHome_p'
         Position=ICP_Scaled
         StyleName="BindBox"
         Hint="Reset the pet preview view."
         WinTop=0.391356
         WinLeft=0.330783
         WinWidth=0.039756
         WinHeight=0.060714
         RenderWeight=0.510000
         TabOrder=25
         bScaleToParent=True
         bNeverFocus=True
         bRepeatClick=True
         OnClickSound=CS_Down
         OnClick=InvasionProAdditionalPetSelectionMenu.PanView
         OnKeyEvent=PanReset.InternalOnKeyEvent
     End Object
     b_CArrow=GUIGFXButton'InvasionProv1_7.InvasionProAdditionalPetSelectionMenu.PanReset'

     Begin Object Class=GUIGFXButton Name=Play
         ImageIndex=7
         Graphic=Texture'2K4Menus.MP3.Play'
         Position=ICP_Scaled
         StyleName="CharButton"
         Hint="Play Animation."
         WinTop=0.685336
         WinLeft=0.092253
         WinWidth=0.020878
         WinHeight=0.029947
         RenderWeight=0.510000
         TabOrder=28
         bScaleToParent=True
         bNeverFocus=True
         bRepeatClick=True
         OnClickSound=CS_Down
         OnClick=InvasionProAdditionalPetSelectionMenu.AnimControls
         OnKeyEvent=Play.InternalOnKeyEvent
     End Object
     b_Play=GUIGFXButton'InvasionProv1_7.InvasionProAdditionalPetSelectionMenu.Play'

     Begin Object Class=GUIGFXButton Name=Pause
         ImageIndex=7
         Graphic=Texture'2K4Menus.MP3.Pause'
         Position=ICP_Scaled
         StyleName="CharButton"
         Hint="Pause Animation."
         WinTop=0.685336
         WinLeft=0.063880
         WinWidth=0.020878
         WinHeight=0.029947
         RenderWeight=0.510000
         TabOrder=27
         bScaleToParent=True
         bNeverFocus=True
         bRepeatClick=True
         OnClickSound=CS_Down
         OnClick=InvasionProAdditionalPetSelectionMenu.AnimControls
         OnKeyEvent=Pause.InternalOnKeyEvent
     End Object
     b_Pause=GUIGFXButton'InvasionProv1_7.InvasionProAdditionalPetSelectionMenu.Pause'

     Begin Object Class=GUIButton Name=DropTarget
         bAutoShrink=False
         StyleName="VertGrip"
         WinTop=0.366640
         WinLeft=0.059335
         WinWidth=0.328061
         WinHeight=0.373214
         RenderWeight=0.100000
         MouseCursorIndex=5
         bTabStop=False
         bBoundToParent=True
         bScaleToParent=True
         bNeverFocus=True
         bDropTarget=True
         OnKeyEvent=DropTarget.InternalOnKeyEvent
         OnCapturedMouseMove=InvasionProAdditionalPetSelectionMenu.RaceCapturedMouseMove
     End Object
     b_DropTarget=GUIButton'InvasionProv1_7.InvasionProAdditionalPetSelectionMenu.DropTarget'

     Begin Object Class=moSlider Name=ModelFOV
         MaxValue=1000.000000
         SliderCaptionStyleName="TextLabel"
         CaptionWidth=0.200000
         Caption="Zoom"
         OnCreateComponent=ModelFOV.InternalOnCreateComponent
         Hint="Zoom the pet preview in or out."
         WinTop=0.270403
         WinLeft=0.060413
         WinWidth=0.323408
         WinHeight=0.033333
         TabOrder=18
         bBoundToParent=True
         bScaleToParent=True
         OnChange=InvasionProAdditionalPetSelectionMenu.InternalOnChange
     End Object
     currentModelFOV=moSlider'InvasionProv1_7.InvasionProAdditionalPetSelectionMenu.ModelFOV'

     Begin Object Class=GUILabel Name=ModelDrawer
         StyleName="TextLabel"
         WinTop=0.211205
         WinLeft=0.692450
         WinWidth=0.241218
         WinHeight=0.557467
         RenderWeight=0.200000
         OnDraw=InvasionProAdditionalPetSelectionMenu.InternalDraw
     End Object
     currentModelViewer=GUILabel'InvasionProv1_7.InvasionProAdditionalPetSelectionMenu.ModelDrawer'

     Begin Object Class=moSlider Name=ModelRot
         MaxValue=100.000000
         SliderCaptionStyleName="TextLabel"
         CaptionWidth=0.200000
         Caption="Rotate Speed"
         OnCreateComponent=ModelRot.InternalOnCreateComponent
         Hint="Adjust the rotation speed of the pet preview."
         WinTop=0.313736
         WinLeft=0.060413
         WinWidth=0.323408
         WinHeight=0.033333
         TabOrder=19
         bBoundToParent=True
         bScaleToParent=True
         OnChange=InvasionProAdditionalPetSelectionMenu.InternalOnChange
     End Object
     currentModelRotation=moSlider'InvasionProv1_7.InvasionProAdditionalPetSelectionMenu.ModelRot'

     nfov=120
     Begin Object Class=GUIButton Name=CancelButton
         Caption="Close"
         Hint="Close this window."
         WinTop=0.638636
         WinLeft=0.562568
         WinWidth=0.171970
         WinHeight=0.060698
         TabOrder=9
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProAdditionalPetSelectionMenu.InternalOnClick
         OnKeyEvent=CancelButton.InternalOnKeyEvent
     End Object
     b_Cancel=GUIButton'InvasionProv1_7.InvasionProAdditionalPetSelectionMenu.CancelButton'

     Begin Object Class=GUIButton Name=OkButton
         Caption="Select"
         Hint="Select the current pet."
         WinTop=0.754386
         WinLeft=0.102251
         WinWidth=0.251747
         WinHeight=0.065055
         TabOrder=8
         bBoundToParent=True
         bScaleToParent=True
         OnClick=InvasionProAdditionalPetSelectionMenu.InternalOnClick
         OnKeyEvent=OkButton.InternalOnKeyEvent
     End Object
     b_OK=GUIButton'InvasionProv1_7.InvasionProAdditionalPetSelectionMenu.OkButton'

     bRequire640x480=True
     WinTop=0.078000
     WinLeft=0.010000
     WinWidth=0.724674
     WinHeight=0.659765
     bScaleToParent=True
}
