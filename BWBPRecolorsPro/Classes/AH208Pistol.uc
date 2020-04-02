//=============================================================================
// Weapon class for AH-208 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class AH208Pistol extends BallisticWeapon;

var(AH208Pistol) name		RDSBone;			// Bone to use for hiding Red Dot Sight
var(AH208Pistol) name		MuzzBone;			// Bone to use for hiding Compensator
var(AH208Pistol) name		LAMBone;			// Bone to use for hiding LAM
var(AH208Pistol) name		ScopeBone;			// Bone to use for hiding scope
var(AH208Pistol) name		BulletBone;			// Bone to use for hiding bullet

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	
	SetBoneScale (0, 0.0, ScopeBone);
	SetBoneScale (3, 0.0, MuzzBone);
	SetBoneScale (5, 0.0, LAMBone);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		IdleAnim = 'OpenIdle';
		ReloadAnim = 'OpenReload';
		SelectAnim = 'OpenPullout';
		BringUpTime=default.BringUpTime;
		SetBoneScale(4,0.0,BulletBone);
	}
	else
	{
		IdleAnim = 'Idle';
		ReloadAnim = 'Reload';
		SelectAnim = 'Pullout';
		BringUpTime=default.BringUpTime;
	}

	Super.BringUp(PrevWeapon);
}

// Animation notify for when cocking action starts. Used to time sounds
simulated function Notify_CockSim()
{
	PlayOwnedSound(CockSound.Sound,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
}

simulated function Notify_HideBullet()
{
	if (MagAmmo < 2)
		SetBoneScale(4,0.0,BulletBone);
}


simulated function Notify_ShowBullet()
{
	SetBoneScale(4,1.0,BulletBone);
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);

	if (Anim == 'OpenFire' || Anim == 'Fire' || Anim == 'OpenFire' || Anim == 'OpenSightFire' || Anim == CockAnim || Anim == ReloadAnim)
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			IdleAnim = 'OpenIdle';
			ReloadAnim = 'OpenReload';
			PutDownAnim = 'OpenPutaway';
			SelectAnim = 'OpenPullout';
		}
		else
		{
			IdleAnim = 'Idle';
			ReloadAnim = 'Reload';
			PutDownAnim = 'Putaway';
			SelectAnim = 'Pullout';
		}
	}
	Super.AnimEnd(Channel);
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}										   							

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()	{	return 0;	}


function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	Result = Super.GetAIRating();
	if (Dist < 500)
		Result -= 1-Dist/500;
	else if (Dist < 3000)
		Result += (Dist-1000) / 2000;
	else
		Result = (Result + 0.66) - (Dist-3000) / 2500;
	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.3;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}

// End AI Stuff =====

defaultproperties
{
     RDSBone="RedDotSight"
     MuzzBone="Compensator"
     LAMBone="LAM"
     ScopeBone="Scope"
     BulletBone="Bullet"
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.500000
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_AH208-Pistol'
     BigIconCoords=(X1=47,Y1=16,X2=455,Y2=245)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     InventorySize=8
     bWT_Bullet=True
     ManualLines(0)="Powerful .44 fire. Massive damage, long range and excellent fire rate."
     ManualLines(1)="Prepares a bludgeoning attack, which will be executed upon release. The damage of the attack increases the longer altfire is held, up to 1.5 seconds for maximum damage output. As a blunt attack, has lower base damage compared to bayonets but inflicts a short-duration blinding effect when striking. This attack inflicts more damage from behind."
     ManualLines(2)="Effective at all ranges."
     BringUpSound=(Sound=Sound'BallisticSounds2.M806.M806Pullout',Volume=0.400000)
     PutDownSound=(Sound=Sound'BallisticSounds2.M806.M806Putaway',Volume=0.400000)
     MagAmmo=7
     CockSound=(Sound=Sound'BallisticRecolorsSounds.Eagle.Eagle-Cock',Volume=1.500000)
     ClipHitSound=(Sound=Sound'BallisticRecolorsSounds.Eagle.Eagle-ClipHit',Volume=1.500000)
     ClipOutSound=(Sound=Sound'BallisticRecolorsSounds.Eagle.Eagle-ClipOut',Volume=1.500000)
     ClipInSound=(Sound=Sound'BallisticRecolorsSounds.Eagle.Eagle-ClipIn',Volume=1.500000)
     ClipInFrame=0.650000
     bCockOnEmpty=True	 
     WeaponModes(0)=(ModeName="Semi-Automatic",ModeID="WM_SemiAuto",)
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
     bNoCrosshairInScope=True
     SightOffset=(X=-20.000000,Y=-7.400000,Z=45.299999)
     SightDisplayFOV=40.000000
     SightingTime=0.200000
	 SightZoomFactor=0
     GunLength=4.000000
     SprintOffSet=(Pitch=-1000,Yaw=-2048)	 
     AimAdjustTime=100.000000
     AimSpread=16	 
     AimDamageThreshold=0.000000
	 ViewRecoilFactor=1.000000
     ChaosDeclineTime=0.450000
     RecoilDeclineDelay=0.750000
     FireModeClass(0)=Class'BWBPRecolorsPro.AH208PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     PutDownAnimRate=1.600000
     PutDownTime=0.500000
     BringUpTime=1.200000
     SelectForce="SwitchToAssaultRifle"
     bCanThrow=False
     AmmoClass(0)=Class'BWBPRecolorsPro.Ammo_AH208_Pistol'
     Description="Built as a more affordable alternative to the AH104, the AH208 is an alternate design chambered for .44 magnum rounds instead of the usual $100 .600 HEAP ones. It is less accurate than the AH104 and D49, but its 8 round magazine and faster reload times let it put more rounds down range than both. Its significant weight and recoil means it requires both hands to shoot and is harder to control than its revolver and handcannon siblings, a fact that comes into play where range is a concern. While not as popular as its larger .600 cousin, the AH208 packs a formidable punch and is a force to be reckoned with."
     Priority=96
     HudColor=(B=255,G=200,R=200)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=2
     GroupOffset=14
     PlayerViewOffset=(Y=19.500000,Z=-30.000000)
     BobDamping=1.200000
     AttachmentClass=Class'BWBPRecolorsPro.AH208Attachment'
     IconMaterial=Texture'BallisticUI.Icons.SmallIcon_AH208-Pistol'
     IconCoords=(X2=127,Y2=31)
     ItemName="AH-208 Pistol"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BallisticRecolorsAnims.DEagle_FP'
     DrawScale=0.800000
     Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
     Skins(1)=Texture'BallisticRecolorsTex.Eagle.Eagle-MainSilverEngraved'
     Skins(2)=Texture'BallisticRecolorsTex.Eagle.Eagle-Misc'
     Skins(3)=Texture'BallisticRecolorsTex.Eagle.Eagle-ScopeGold'
     Skins(4)=Texture'BallisticRecolorsTex.Eagle.Eagle-FrontSilver'
     Skins(5)=Shader'BallisticRecolorsTex.Eagle.Eagle-SightDotGreen'
     AmbientGlow=5
}
