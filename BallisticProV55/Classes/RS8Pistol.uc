//=============================================================================
// Weapon class for RS8 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class RS8Pistol extends BallisticHandgun;

var   bool		bSilenced;				// Silencer on. Silenced
var() name		SilencerBone;			// Bone to use for hiding silencer
var() name		SilencerOnAnim;			// Think hard about this one...
var() name		SilencerOffAnim;		//
var() sound		SilencerOnSound;		// Silencer stuck on sound
var() sound		SilencerOffSound;		//
var() sound		SilencerOnTurnSound;	// Silencer screw on sound
var() sound		SilencerOffTurnSound;	//

replication
{
	reliable if (Role < ROLE_Authority)
		ServerSwitchSilencer;
}

simulated function PlayIdle()
{
	super.PlayIdle();

	if (!bPendingSightUp || SightingState != SS_None || bScopeView || !CanPlayAnim(IdleAnim, ,"IDLE"))
		return;
	FreezeAnimAt(0.0);
}

// Change some properties when using sights...
simulated function SetScopeBehavior()
{
	super(BallisticHandgun).SetScopeBehavior();
	bUseNetAim = default.bUseNetAim || bScopeView;
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

function ServerSwitchSilencer(bool bNewValue)
{
	bSilenced = bNewValue;
	BFireMode[0].bAISilent = bSilenced;
	SwitchSilencer(bSilenced);
	if (bSilenced)
		BFireMode[0].RecoilPerShot *= 0.85;
	else BFireMode[0].RecoilPerShot = BFireMode[0].default.RecoilPerShot;
}

exec simulated function WeaponSpecial(optional byte i)
{
	if (ReloadState != RS_None)
		return;
	if (bIsPendingHandGun || PendingHandGun!=None)
		return;
	if (Clientstate != WS_ReadyToFire)
		return;
	if (Othergun != None)
	{
		if (Othergun.Clientstate != WS_ReadyToFire)
			return;
		if (IsinState('DualAction'))
			return;
		if (!Othergun.IsinState('Lowered'))
		{
			GotoState('PendingSwitchSilencer');
			return;
		}
	}
	TemporaryScopeDown(0.5);
	bSilenced = !bSilenced;
	ServerSwitchSilencer(bSilenced);
	SwitchSilencer(bSilenced);
}

simulated function SwitchSilencer(bool bNewValue)
{
	if(Role == ROLE_Authority)
		bServerReloading=False;
	ReloadState = RS_GearSwitch;
	
	if (bNewValue)
		PlayAnim(SilencerOnAnim);
	else
		PlayAnim(SilencerOffAnim);
}
simulated function Notify_SilencerOn()
{
	PlaySound(SilencerOnSound,,0.5);
}
simulated function Notify_SilencerOnTurn()
{
	PlaySound(SilencerOnTurnSound,,0.5);
}
simulated function Notify_SilencerOff()
{
	PlaySound(SilencerOffSound,,0.5);
}
simulated function Notify_SilencerOffTurn()
{
	PlaySound(SilencerOffTurnSound,,0.5);
}
simulated function Notify_SilencerShow()
{
	SetBoneScale (0, 1.0, SilencerBone);
}
simulated function Notify_SilencerHide()
{
	SetBoneScale (0, 0.0, SilencerBone);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);
	
	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		IdleAnim = 'OpenIdle';
		ReloadAnim = 'OpenReload';
	}
	else
	{
		IdleAnim = 'Idle';
		ReloadAnim = 'Reload';
	}

	if (AIController(Instigator.Controller) != None)
		bSilenced = (FRand() > 0.5);

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);

	if (Anim == 'OpenFire' || Anim == 'Fire' || Anim == CockAnim || Anim == ReloadAnim)
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			IdleAnim = 'OpenIdle';
			ReloadAnim = 'OpenReload';
		}
		else
		{
			IdleAnim = 'Idle';
			ReloadAnim = 'Reload';
		}
	}
	Super.AnimEnd(Channel);
}

simulated function Notify_ClipOutOfSight()
{
	SetBoneScale (1, 1.0, 'Bullet');
}

simulated function PlayReload()
{
	super.PlayReload();

	if (MagAmmo < 1)
		SetBoneScale (1, 0.0, 'Bullet');

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);
}

// AI Interface =====
// choose between regular or alt-fire

function byte BestMode()	{	return 0;	}

function float GetAIRating()
{
	local Bot B;
	local float Dist;
	local float Rating;

	B = Bot(Instigator.Controller);
	if ( B == None )
		return AIRating;

	Rating = Super.GetAIRating();

	if (B.Enemy == None)
		return Rating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, 768, 2048); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.1;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}

// End AI Stuff =====

defaultproperties
{
     SilencerBone="Silencer"
     SilencerOnAnim="SilencerOn"
     SilencerOffAnim="SilencerOff"
     SilencerOnSound=Sound'BallisticSounds2.XK2.XK2-SilenceOn'
     SilencerOffSound=Sound'BallisticSounds2.XK2.XK2-SilenceOff'
     SilencerOnTurnSound=Sound'BallisticSounds1.Pistol.RSP-SilencerTurn'
     SilencerOffTurnSound=Sound'BallisticSounds1.Pistol.RSP-SilencerTurn'
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_RS8'
     BigIconCoords=(X1=64,Y1=70,X2=418)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     SpecialInfo(0)=(Info="0.0;-5.0;-999.0;-1.0;0.0;-999.0;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.M806.M806Pullout',Volume=0.325000)
     PutDownSound=(Sound=Sound'BallisticSounds2.M806.M806Putaway',Volume=0.325000)
     MagAmmo=10
     CockAnimRate=1.250000
     CockSound=(Sound=Sound'BallisticSounds1.Pistol.RSP-Cock',Volume=0.800000)
     ReloadAnimRate=1.250000
     ClipHitSound=(Volume=0.600000)
     ClipOutSound=(Sound=Sound'BallisticSounds1.Pistol.RSP-ClipOut',Volume=0.800000)
     ClipInSound=(Sound=Sound'BallisticSounds1.Pistol.RSP-ClipIn',Volume=0.800000)
     ClipInFrame=0.650000
     bCockOnEmpty=True
     WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",)
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
     bNoCrosshairInScope=True
     SightOffset=(X=-15.000000,Z=8.700000)
     SightDisplayFOV=45.000000
     SightingTime=0.200000
     SightAimFactor=0.150000
     SprintOffSet=(Pitch=-1000,Yaw=-2048)	 
     AimAdjustTime=100.000000
     AimSpread=16
     AimDamageThreshold=0.000000
     ChaosDeclineTime=0.450000
     ChaosSpeedThreshold=7500.000000
     ChaosAimSpread=384
     RecoilYawFactor=0.000000
     RecoilXFactor=0.250000
     RecoilYFactor=0.250000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.250000
     FireModeClass(0)=Class'BallisticProV55.RS8PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
	 CurrentRating=0.6
     AmmoClass(0)=Class'BallisticProV55.Ammo_RS8_Pistol'	
     AmmoClass(1)=Class'BallisticProV55.Ammo_RS8_Pistol'		 
     Description="RS8 Pistol"
     DisplayFOV=65.000000
     Priority=17
     HudColor=(B=255,G=200,R=200)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=2
     GroupOffset=7
     PlayerViewOffset=(X=12.000000,Y=12.500000,Z=-12.000000)
     AttachmentClass=Class'BallisticProV55.RS8Attachment'
     IconMaterial=Texture'BallisticUI.Icons.SmallIcon_RS8'
     IconCoords=(X2=127,Y2=31)
     ItemName="RS8"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=2.250000
     Mesh=SkeletalMesh'BallisticAnims1.RS8_FP'
     DrawScale=0.300000
     AmbientGlow=5
	 Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticWeapons1.RS8.M1911-Skin'
}
