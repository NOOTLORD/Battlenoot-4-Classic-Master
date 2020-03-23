//=============================================================================
// Weapon class for LK-05 Carbine
//
// by Sarge.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class LK05Carbine extends BallisticWeapon;

var   bool		bSilenced;				// Silencer on. Silenced
var() name		SilencerBone;			// Bone to use for hiding silencer
var() name		SilencerBone2;			// Bone to use for hiding silencer
var() sound		SilencerOnSound;		// Silencer stuck on sound
var() sound		SilencerOffSound;		//
var() name		SilencerOnAnim;			// Think hard about this one...
var() name		SilencerOffAnim;		//
var() name		ScopeBone;			    // Bone to use for hiding scope

replication
{
	reliable if (Role < ROLE_Authority)
		ServerSwitchSilencer;
}

//=================================
//Silencer Code
//=================================

function ServerSwitchSilencer(bool bNewValue)
{
	if (!Instigator.IsLocallyControlled())
		LK05PrimaryFire(FireMode[0]).SwitchSilencerMode(bNewValue);

	LK05Attachment(ThirdPersonActor).bSilenced=bNewValue;	
	PlaySuppressorAttachment(bNewValue);
	bSilenced = bNewValue;
	BFireMode[0].bAISilent = bSilenced;
}

exec simulated function SwitchSilencer() 
{
	if (ReloadState != RS_None)
		return;
	if (Clientstate != WS_ReadyToFire)
		return;

	bSilenced = !bSilenced;
	ServerSwitchSilencer(bSilenced);
	PlaySuppressorAttachment(bSilenced);
	LK05PrimaryFire(FireMode[0]).SwitchSilencerMode(bSilenced);
	LK05Attachment(ThirdPersonActor).IAOverride(bSilenced);
}

simulated function PlaySuppressorAttachment(bool bSuppressed)
{
	if (Role == ROLE_Authority)
		bServerReloading=True;
	ReloadState = RS_GearSwitch;
	
	if (bSuppressed)
		PlayAnim(SilencerOnAnim);
	else
		PlayAnim(SilencerOffAnim);
}

simulated function Notify_SilencerOn()
{
	PlaySound(SilencerOnSound,,0.5);
}

simulated function Notify_SilencerOff()
{
	PlaySound(SilencerOffSound,,0.5);
	SetBoneScale (0, 0.0, SilencerBone);
	SetBoneScale (1, 1.0, SilencerBone2);
}

simulated function Notify_SilencerShow()
{
	SetBoneScale (0, 1.0, SilencerBone);
	SetBoneScale (1, 0.0, SilencerBone2);
}

simulated function PlayReload()
{
	super.PlayReload();

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);
}

//=================================
// Sights and custom anim support
//=================================
simulated function BringUp(optional Weapon PrevWeapon)
{
	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		IdleAnim = 'OpenIdle';
		ReloadAnim = 'ReloadEmpty';
	}
	
	else
	{
		IdleAnim = 'Idle';
		ReloadAnim = 'Reload';
	}

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

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);

	if (Anim == 'OpenFire' || Anim == 'Pullout' || Anim == 'PulloutFancy' || Anim == 'Fire' || Anim == 'SightFire' || Anim == 'OpenSightFire' ||Anim == CockAnim || Anim == ReloadAnim)
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			IdleAnim = 'OpenIdle';
			ReloadAnim = 'ReloadEmpty';
		}
		else
		{
			IdleAnim = 'Idle';
			ReloadAnim = 'Reload';
		}
	}
	Super.AnimEnd(Channel);
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
function float SuggestAttackStyle()	{	return 0.0;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}

// End AI Stuff =====

defaultproperties
{
     ManualLines(0)="5.56 fire. Higher DPS than comparable weapons, but awkward recoil and highly visible tracers."
     ManualLines(1)="Attaches or remvoes the suppressor. When active, the suppressor reduces recoil and noise output and hides the muzzle flash, but reduces range."
     ManualLines(2)="The Weapon Function key, when used, first cycles between the weapon's laser sight and flashlight, and then activates both at once. Activate again to disable both. The laser sight reduces the spread of the hipfire, but compromises stealth.||Effective at close and medium range."																												   																																																																																																																			  
     SilencerBone="Silencer"
     SilencerBone2="Silencer2"
     SilencerOnSound=Sound'BallisticSounds1.SRS600.SRS-SilencerOn'
     SilencerOffSound=Sound'BallisticSounds1.SRS600.SRS-SilencerOff'
     SilencerOnAnim="SilencerOn"
     SilencerOffAnim="SilencerOff"
     ScopeBone="EOTech"
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_LK-05'
     BigIconCoords=(Y1=36,Y2=225)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     BringUpSound=(Sound=Sound'BallisticRecolorsSounds.M4.M4-PullOut',Volume=0.425000)
     PutDownSound=(Sound=Sound'BallisticRecolorsSounds.M4.M4-Putaway',Volume=0.425000)
     MagAmmo=32
     CockSound=(Sound=Sound'BallisticRecolorsSounds.LK05.LK05-Cock',Volume=0.800000)
     ClipOutSound=(Sound=Sound'BallisticRecolorsSounds.LK05.LK05-MagOut',Volume=0.800000)
     ClipInSound=(Sound=Sound'BallisticRecolorsSounds.LK05.LK05-MagIn',Volume=0.800000)
     ClipInFrame=0.650000
     bCockOnEmpty=True
     WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
     bNoCrosshairInScope=True
     SightOffset=(X=10.000000,Y=-8.550000,Z=24.660000)
     SightDisplayFOV=40.000000
     SightingTime=0.300000
     SprintOffSet=(Pitch=-3072,Yaw=-4096)
     AimAdjustTime=100.000000
     AimSpread=16
     AimDamageThreshold=0.000000
	 ViewRecoilFactor=1.000000	 
     ChaosDeclineTime=1.250000
     ChaosSpeedThreshold=15000.000000
     ChaosAimSpread=3072
     RecoilXCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.250000,OutVal=-0.100000),(InVal=0.600000,OutVal=0.130000),(InVal=0.700000,OutVal=0.060000),(InVal=0.850000,OutVal=-0.040000),(InVal=1.000000)))
     RecoilYCurve=(Points=(,(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.750000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.200000
     RecoilYFactor=0.350000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.200000
     FireModeClass(0)=Class'BWBPRecolorsPro.LK05PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     IdleAnimRate=0.500000
     SelectAnimRate=1.660000
     PutDownAnimRate=1.330000
     PutDownTime=0.400000
     BringUpTime=0.450000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.70000
     CurrentRating=0.700000
     bCanThrow=False
     AmmoClass(0)=Class'BWBPRecolorsPro.Ammo_LK05_Rifle'  
     Priority=41
     HudColor=(B=255,G=200,R=200)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=3
     PlayerViewOffset=(X=-6.000000,Y=12.000000,Z=-17.000000)
     BobDamping=2.000000
     AttachmentClass=Class'BWBPRecolorsPro.LK05Attachment'
     IconMaterial=Texture'BallisticUI.Icons.SmallIcon_LK-05'
     IconCoords=(X2=127,Y2=31)
     ItemName="LK-05 Carbine"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BallisticRecolorsAnims.LK05_FP'
     DrawScale=0.300000
     AmbientGlow=5
}
