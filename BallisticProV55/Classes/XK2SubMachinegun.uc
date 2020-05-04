//=============================================================================
// Weapon class for XK2 SubMachinegun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class XK2SubMachinegun extends BallisticWeapon;

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
	SwitchSilencer(bSilenced);
	bServerReloading=True;
	ReloadState = RS_GearSwitch;
	
	XK2PrimaryFire(BFireMode[0]).SetSilenced(bNewValue);
}

exec simulated function WeaponSpecial(optional byte i)
{
	if (ReloadState != RS_None)
		return;
	if (Clientstate != WS_ReadyToFire)
		return;
	TemporaryScopeDown(0.5);
	bSilenced = !bSilenced;
	ServerSwitchSilencer(bSilenced);
	SwitchSilencer(bSilenced);
	ReloadState = RS_GearSwitch;
}

simulated function SwitchSilencer(bool bNewValue)
{
	if (bNewValue)
		PlayAnim(SilencerOnAnim);
	else
		PlayAnim(SilencerOffAnim);
}

simulated function Notify_XK2SilencerOn()
{
	PlaySound(SilencerOnSound,,0.5);
}

simulated function Notify_XK2SilencerOnTurn()
{
	PlaySound(SilencerOnTurnSound,,0.5);
}

simulated function Notify_XK2SilencerOff()
{
	PlaySound(SilencerOffSound,,0.5);
}

simulated function Notify_XK2SilencerOffTurn()
{
	PlaySound(SilencerOffTurnSound,,0.5);
}

simulated function Notify_XK2SilencerShow()
{
	SetBoneScale (0, 1.0, SilencerBone);
}

simulated function Notify_XK2SilencerHide()
{
	SetBoneScale (0, 0.0, SilencerBone);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	if (AIController(Instigator.Controller) != None)
		bSilenced = (FRand() > 0.5);

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);
}

simulated function PlayReload()
{
	if (MagAmmo < 1)
		SetBoneScale (1, 0.0, 'Bullet');

	super.PlayReload();

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);
}

simulated function Notify_ClipOutOfSight()
{
	SetBoneScale (1, 1.0, 'Bullet');
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

	return class'BUtil'.static.DistanceAtten(Rating, 0.6, Dist, BallisticRangeAttenFire(BFireMode[0]).CutOffStartRange, BallisticRangeAttenFire(BFireMode[0]).CutOffDistance);
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.6;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.6;	}

// End AI Stuff =====

defaultproperties
{
     SilencerBone="Silencer"
     SilencerOnAnim="SilencerOn"
     SilencerOffAnim="SilencerOff"
     SilencerOnSound=Sound'BallisticSounds2.XK2.XK2-SilenceOn'
     SilencerOffSound=Sound'BallisticSounds2.XK2.XK2-SilenceOff'
     SilencerOnTurnSound=SoundGroup'BallisticSounds2.XK2.XK2-SilencerTurn'
     SilencerOffTurnSound=SoundGroup'BallisticSounds2.XK2.XK2-SilencerTurn'
     PlayerSpeedFactor=1.100000
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_XK2'
     BigIconCoords=(X1=24,X2=450)
     SightFXClass=Class'BallisticProV55.XK2SightLEDs'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     bWT_Machinegun=True
     SpecialInfo(0)=(Info="120.0;10.0;0.6;60.0;0.3;0.1;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Pullout',Volume=0.350000)
     PutDownSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Putaway',Volume=0.350000)
     MagAmmo=40	
     CockSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Cock',Volume=0.850000)
     ClipHitSound=(Volume=0.600000)
     ClipOutSound=(Sound=Sound'BallisticSounds2.XK2.XK2-ClipOut',Volume=0.850000)
     ClipInSound=(Sound=Sound'BallisticSounds2.XK2.XK2-ClipIn',Volume=0.850000)
     ClipInFrame=0.650000
     bCockOnEmpty=True
     WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
	 CockAnimRate=1.25				   
     bNoCrosshairInScope=True
     SightPivot=(Pitch=256)
     SightOffset=(X=5.000000,Z=12.700000)
     SightDisplayFOV=40.000000
     SightingTime=0.250000
     SightAimFactor=0.400000
	 SightZoomFactor=0
     SprintOffSet=(Pitch=-3000,Yaw=-4000)
     AimAdjustTime=100.000000
     AimSpread=16
	 AIRating=0.8
	 CurrentRating=0.8
     AimDamageThreshold=0.000000
     ChaosDeclineTime=0.800000
     ChaosSpeedThreshold=7500.000000
     ChaosAimSpread=2048
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=0.050000),(InVal=0.400000,OutVal=-0.100000),(InVal=0.600000,OutVal=0.150000),(InVal=0.800000,OutVal=-0.050000),(InVal=1.000000)))
     RecoilYCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.400000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.250000
     RecoilYFactor=0.250000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.110000
     FireModeClass(0)=Class'BallisticProV55.Xk2PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     SelectForce="SwitchToAssaultRifle"
     AmmoClass(0)=Class'BallisticProV55.Ammo_XK2_SMG'
     AmmoClass(1)=Class'BallisticProV55.Ammo_XK2_SMG'	 
     Description="XK2 Submachine Gun"
     DisplayFOV=55.000000
     Priority=32
     HudColor=(B=255,G=200,R=200)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=1
     GroupOffset=1
     PlayerViewOffset=(X=10.000000,Y=8.000000,Z=-11.000000)
     AttachmentClass=Class'BallisticProV55.Xk2Attachment'
     IconMaterial=BallisticUI.Icons.SmallIcon_XK2'
     IconCoords=(X2=127,Y2=31)
     ItemName="XK2 Submachine Gun"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticAnims2.XK2_FP'
     DrawScale=0.200000
     AmbientGlow=5
	 Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticWeapons2.XK2.XK2Skin'
}
