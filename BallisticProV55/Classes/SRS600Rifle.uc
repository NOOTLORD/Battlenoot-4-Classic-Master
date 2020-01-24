//=============================================================================
// SRS600Rifle.
//
// An automatic rifle with elements of both a sniper rifle and assault rifle.
// More powerful than M50, but less firerate and more recoil.
// Can be silenced.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class SRS600Rifle extends BallisticWeapon;

var   bool		bSilenced;				// Silencer on. Silenced
var() name		SilencerBone;			// Bone to use for hiding silencer
var() name		SilencerOnAnim;			// Think hard about this one...
var() name		SilencerOffAnim;		//
var() sound		SilencerOnSound;		// Silencer stuck on sound
var() sound		SilencerOffSound;		//

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
	BFireMode[0].bAISilent = bSilenced;
	SRS600PrimaryFire(BFireMode[0]).SetSilenced(bNewValue);
}

exec simulated function WeaponSpecial(optional byte i)
{
	if (ReloadState != RS_None)
		return;
	TemporaryScopeDown(0.5);
	bSilenced = !bSilenced;
	ServerSwitchSilencer(bSilenced);
	SwitchSilencer(bSilenced);
}

simulated function SwitchSilencer(bool bNewValue)
{
	if (Role == ROLE_Authority)
		bServerReloading = True;
	ReloadState = RS_GearSwitch;
	
	if (bNewValue)
		PlayAnim(SilencerOnAnim);
	else
		PlayAnim(SilencerOffAnim);
}

simulated function Notify_SilencerOn()	{	PlaySound(SilencerOnSound,,0.5);	}
simulated function Notify_SilencerOff()	{	PlaySound(SilencerOffSound,,0.5);	}

simulated function Notify_SilencerShow(){	SetBoneScale (0, 1.0, SilencerBone);	}
simulated function Notify_SilencerHide(){	SetBoneScale (0, 0.0, SilencerBone);	}

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

simulated function Notify_ClipOutOfSight()	{	SetBoneScale (1, 1.0, 'Bullet');	}

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

// Secondary fire doesn't count for this weapon
simulated function bool HasAmmo()
{
	//First Check the magazine
	if (!bNoMag && FireMode[0] != None && MagAmmo >= FireMode[0].AmmoPerFire)
		return true;
	//If it is a non-mag or the magazine is empty
	if (Ammo[0] != None && FireMode[0] != None && Ammo[0].AmmoAmount >= FireMode[0].AmmoPerFire)
			return true;
	return false;	//This weapon is empty
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.75, Dist, BallisticRangeAttenFire(BFireMode[0]).CutOffStartRange, BallisticRangeAttenFire(BFireMode[0]).CutOffDistance); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.0;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.0;	}

// End AI Stuff =====

defaultproperties
{
     SilencerBone="Silencer"
     SilencerOnAnim="SilencerOn"
     SilencerOffAnim="SilencerOff"
     SilencerOnSound=Sound'BWBP3-Sounds.SRS900.SRS-SilencerOn'
     SilencerOffSound=Sound'BWBP3-Sounds.SRS900.SRS-SilencerOff'
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny',SkinNum=3)
     BigIconMaterial=Texture'BallisticProTextures.SRS.BigIcon_SRSM2'
     BigIconCoords=(Y2=240)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     ManualLines(0)="High-powered battle rifle fire. Long range, good penetration and high per-shot damage. Recoil is significant."
     ManualLines(1)="Attaches a suppressor. This reduces the recoil, but also the effective range. The flash is removed and the gunfire becomes less audible."
     ManualLines(2)="Effective at medium to long range."
     SpecialInfo(0)=(Info="240.0;20.0;0.9;75.0;1.0;0.0;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.R78.R78Pullout',Volume=0.375000)
     PutDownSound=(Sound=Sound'BallisticSounds2.R78.R78Putaway',Volume=0.375000)
     MagAmmo=20
     CockAnimRate=1.200000
     CockSound=(Sound=Sound'BWBP3-Sounds.SRS900.SRS-Cock',Volume=0.875000)
     ClipHitSound=(Sound=Sound'BWBP3-Sounds.SRS900.SRS-ClipHit',Volume=0.875000)
     ClipOutSound=(Sound=Sound'BWBP3-Sounds.SRS900.SRS-ClipOut',Volume=0.875000)
     ClipInSound=(Sound=Sound'BWBP3-Sounds.SRS900.SRS-ClipIn',Volume=0.875000)
     ClipInFrame=0.650000
     bCockOnEmpty=True	 
     WeaponModes(0)=(ModeName="Semi-Automatic",ModeID="WM_SemiAuto",)
     CurrentWeaponMode=0
     FullZoomFOV=70.000000
     bNoCrosshairInScope=True
     SightOffset=(X=16.000000,Z=10.460000)
     SightDisplayFOV=40.000000
     GunLength=72.000000
     SprintOffSet=(Pitch=-3000,Yaw=-4000)
     AimAdjustTime=100.000000
     AimDamageThreshold=0.000000	 
     AimSpread=32
     ChaosDeclineTime=1.250000
     ChaosSpeedThreshold=9000.000000
     ChaosAimSpread=3072
     RecoilXCurve=(Points=(,(InVal=0.100000),(InVal=0.250000,OutVal=-0.120000),(InVal=0.400000,OutVal=0.180000),(InVal=0.800000,OutVal=-0.220000),(InVal=1.000000,OutVal=0.250000)))
     RecoilYCurve=(Points=(,(InVal=0.150000,OutVal=0.120000),(InVal=0.300000,OutVal=0.350000),(InVal=0.500000,OutVal=0.445000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.250000
     RecoilYFactor=0.250000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.250000
     FireModeClass(0)=Class'BallisticProV55.SRS600PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     SelectAnimRate=1.350000
     BringUpTime=0.350000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.80000
     CurrentRating=0.80000
     bCanThrow=False
     AmmoClass(0)=Class'BallisticProV55.Ammo_SRS600Clip'																	  												  
     Description="Another battlefield favourite produced by high-tech manufacturer, NDTR Industries, the SRS-900 is indeed a fine weapon. Using high velocity 7.62mm ammunition, this rifle causes a lot of damage to the target, but suffers from high recoil, chaos and a low clip capacity. The altered design, can now incorporate a silencer to the end of the barrel, increasing its capabilities as a stealth weapon. This particular model, also features a versatile, red-filter scope, complete with various tactical readouts and indicators, including a range finder, stability metre, elevation indicator, ammo display and stealth meter."
     Priority=40
     HudColor=(B=255,G=200,R=200)
     CustomCrossHairScale=0.000000								  
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=3
     GroupOffset=6				  
     PlayerViewOffset=(X=2.000000,Y=9.000000,Z=-10.000000)
     AttachmentClass=Class'BallisticProV55.SRS600Attachment'
     IconMaterial=Texture'BallisticProTextures.SRS.SmallIcon_SRSM2'
     IconCoords=(X2=127,Y2=31)
     ItemName="SRS-600 Battle Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=5.000000
     Mesh=SkeletalMesh'BallisticProAnims.SRSEO-1st'
     DrawScale=0.500000
     Skins(0)=Texture'BallisticProTextures.SRS.SRSNSGrey'
     Skins(1)=Texture'BWBP3-Tex.SRS900.SRS900Scope'
     Skins(2)=Texture'BWBP3-Tex.SRS900.SRS900Ammo'
     Skins(3)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
     AmbientGlow=0		 
}
