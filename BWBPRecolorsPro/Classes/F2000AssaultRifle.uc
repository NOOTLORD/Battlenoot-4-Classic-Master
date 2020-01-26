//=============================================================================
// Main weapon class for MARS-3 Assault Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class F2000AssaultRifle extends BallisticWeapon;

var   bool		bSilenced;				// Silencer on. Silenced
var() name		SilencerBone;			// Bone to use for hiding silencer
var() name		SilencerOnAnim;			// Think hard about this one...
var() name		SilencerOffAnim;		//
var() sound		SilencerOnSound;		// Silencer stuck on sound
var() sound		SilencerOffSound;		//
var() sound		SilencerOnTurnSound;	// Silencer screw on sound
var() sound		SilencerOffTurnSound;	//

var(F2000AssaultRifle) name		ScopeBone;			// Bone to use for hiding scope

replication
{
	reliable if (Role < ROLE_Authority)
		ServerSwitchSilencer;
}

//=====================================================================
// SUPPRESSOR CODE
//=====================================================================
function ServerSwitchSilencer(bool bNewValue)
{
	bSilenced = bNewValue;
	SwitchSilencer(bSilenced);
	F2000PrimaryFire(BFireMode[0]).SetSilenced(bNewValue);
}

//simulated function DoWeaponSpecial(optional byte i)
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
}

simulated function SwitchSilencer(bool bNewValue)
{
	if (Role == ROLE_Authority)
		bServerReloading=True;
	ReloadState = RS_GearSwitch;
	
	if (bNewValue)
		PlayAnim(SilencerOnAnim);
	else
		PlayAnim(SilencerOffAnim);
}

simulated function Notify_MARSSilencerOn()
{
	PlaySound(SilencerOnSound,,0.5);
}
simulated function Notify_MARSSilencerOnTurn()
{
	PlaySound(SilencerOnTurnSound,,0.5);
}
simulated function Notify_MARSSilencerOff()
{
	PlaySound(SilencerOffSound,,0.5);
}
simulated function Notify_MARSSilencerOffTurn()
{
	PlaySound(SilencerOffTurnSound,,0.5);
}
simulated function Notify_MARSSilencerShow()
{
	SetBoneScale (0, 1.0, SilencerBone);
}
simulated function Notify_MARSSilencerHide()
{
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

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	if (AIController(Instigator.Controller) != None)
		bSilenced = (FRand() > 0.5);

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);

	Instigator.AmbientSound = UsedAmbientSound;
	Instigator.SoundVolume = default.SoundVolume;
	Instigator.SoundPitch = default.SoundPitch;
	Instigator.SoundRadius = default.SoundRadius;
	Instigator.bFullVolume = true;
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		Instigator.AmbientSound = UsedAmbientSound;
		Instigator.SoundVolume = default.SoundVolume;
		Instigator.SoundPitch = default.SoundPitch;
		Instigator.SoundRadius = default.SoundRadius;
		Instigator.bFullVolume = false;
		return true;
	}
	return false;
}

simulated function float RateSelf()
{
	if (!HasAmmo())
		CurrentRating = 0;
	else if (Ammo[0].AmmoAmount < 1 && MagAmmo < 1)
		CurrentRating = Instigator.Controller.RateWeapon(self)*0.3;
	else
		return Super.RateSelf();
	return CurrentRating;
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

	return class'BUtil'.static.DistanceAtten(Rating, 0.5, Dist, BallisticRangeAttenFire(BFireMode[0]).CutOffStartRange, BallisticRangeAttenFire(BFireMode[0]).CutOffDistance); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.4;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.4;	}
// End AI Stuff =====

defaultproperties
{
     SilencerBone="tip2"
     SilencerOnAnim="SilencerOn"
     SilencerOffAnim="SilencerOff"
     SilencerOnSound=Sound'BallisticSounds2.XK2.XK2-SilenceOn'
     SilencerOffSound=Sound'BallisticSounds2.XK2.XK2-SilenceOff'
     SilencerOnTurnSound=SoundGroup'BallisticSounds2.XK2.XK2-SilencerTurn'
     SilencerOffTurnSound=SoundGroup'BallisticSounds2.XK2.XK2-SilencerTurn'
     ScopeBone="EOTech"
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticRecolors4TexPro.MARS.BigIcon_F2000Alt'
     BigIconCoords=(X1=32,Y1=40,X2=475)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     ManualLines(0)="Powerful 5.56mm fire. Has a fast fire rate and high sustained DPS, but excessive recoil."
     ManualLines(1)="Launches a cryogenic grenade. Upon impact, freezes nearby enemies, slowing their movement. The effect is proportional to their distance from the epicentre. This attack will also extinguish the fires of an FP7 grenade."
     ManualLines(2)="The Weapon Special key attaches a suppressor. This reduces the recoil, but also the effective range. The flash is removed and the gunfire becomes less audible.||Effective at close to medium range."
     BringUpSound=(Sound=Sound'BallisticSounds2.M50.M50Pullout',Volume=0.425000)
     PutDownSound=(Sound=Sound'BallisticSounds2.M50.M50Putaway',Volume=0.425000)
     CockAnimPostReload="ReloadEndCock"
     CockAnimRate=1.250000
     CockSound=(Sound=Sound'PackageSounds4ProExp.MARS.MARS-BoltPull',Volume=0.950000)
     ReloadAnimRate=1.350000
     ClipHitSound=(Sound=Sound'PackageSounds4ProExp.MARS.MARS-MagFiddle',Volume=0.950000)
     ClipOutSound=(Sound=Sound'PackageSounds4ProExp.MARS.MARS-MagOut',Volume=0.950000)
     ClipInSound=(Sound=Sound'PackageSounds4ProExp.MARS.MARS-MagIn',Volume=0.950000)
     ClipInFrame=0.650000
     bCockOnEmpty=True
     WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
     bNoCrosshairInScope=True
     SightOffset=(X=6.000000,Y=-6.350000,Z=23.150000)
     SightDisplayFOV=40.000000
     SprintOffSet=(Pitch=-3000,Yaw=-4096)
     AimAdjustTime=100.000000
     AimSpread=16
     AimDamageThreshold=0.000000
	 ViewRecoilFactor=1.000000	 
     ChaosDeclineTime=1.250000
     ChaosSpeedThreshold=7500.000000
     ChaosAimSpread=3072
     RecoilXCurve=(Points=(,(InVal=0.100000,OutVal=0.070000),(InVal=0.250000,OutVal=0.250000),(InVal=0.500000,OutVal=0.050000),(InVal=0.650000,OutVal=-0.200000),(InVal=0.900000,OutVal=-0.100000),(InVal=1.000000)))
     RecoilYCurve=(Points=(,(InVal=0.200000,OutVal=0.250000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.200000
     RecoilYFactor=0.200000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.140000
     FireModeClass(0)=Class'BWBPRecolorsPro.F2000PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     PutDownTime=0.700000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.750000
     CurrentRating=0.750000
     bCanThrow=False
     AmmoClass(0)=Class'BWBPRecolorsPro.Ammo_F2000Clip'
     Description="The 3 variant of the Modular Assault Rifle System is one of many rifles built under NDTR Industries' MARS project. The project, which was aimed to produce a successor to the army's current M50 and M30 rifles, has produced a number of functional prototypes. ||The 3 variant is a short barreled model designed for CQC use with non-standard ammunition. Field tests have shown excellent results when loaded with Snowstorm or Firestorm rounds, and above-average performance with Zero-G, toxic and electro rounds. This specific MARS-3 is loaded with Snowstorm XII rounds and is set to fire at a blistering 850 RPM. Enemies hit with this ammunition will be chilled and slowed."
     Priority=65
     HudColor=(B=255,G=200,R=200)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=3
     PlayerViewOffset=(X=0.500000,Y=12.000000,Z=-18.000000)
     BobDamping=2.000000
     AttachmentClass=Class'BWBPRecolorsPro.F2000Attachment'
     IconMaterial=Texture'BallisticRecolors4TexPro.MARS.SmallIcon_F2000Alt'
     IconCoords=(X2=127,Y2=31)
     ItemName="MARS-3 Assault Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BallisticRecolors4AnimProExp.MARS3_FP'
     DrawScale=0.300000
     AmbientGlow=10
}
