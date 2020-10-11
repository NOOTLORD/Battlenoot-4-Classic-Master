//=============================================================================
// Weapon class for the MD24 Pistol
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class MD24Pistol extends BallisticHandgun;

var name			BulletBone;

// Animation notify for when the clip is stuck in
simulated function Notify_ClipIn()
{
	Super.Notify_ClipIn();

	SetBoneScale(0,1.0,BulletBone);
}

simulated function Notify_ClipOut()
{
	Super.Notify_ClipOut();

	if(MagAmmo < 1)
		SetBoneScale(0,0.0,BulletBone);
}

simulated function PlayIdle()
{
	super.PlayIdle();

	if (!bPendingSightUp || SightingState != SS_None || bScopeView || !CanPlayAnim(IdleAnim, ,"IDLE"))
		return;
	FreezeAnimAt(0.0);
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

// Change some properties when using sights...
simulated function SetScopeBehavior()
{
	super.SetScopeBehavior();

	bUseNetAim = default.bUseNetAim || bScopeView;
	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		if (bScopeView)
			BFireMode[0].FireAnim = 'SightOpenFire';
		else	BFireMode[0].FireAnim = 'OpenFire';
	}
	else
	{
		if (bScopeView)
			BFireMode[0].FireAnim = 'SightFire';
		else BFireMode[0].FireAnim = 'Fire';
	}
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
function float SuggestAttackStyle()	{	return 0.8;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.8;	}

// End AI Stuff =====

defaultproperties
{
     BulletBone="Bullet"
     AIReloadTime=1.500000
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_MD24'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     SpecialInfo(0)=(Info="120.0;10.0;-999.0;25.0;0.0;0.0;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.M806.M806Pullout',Volume=0.325000)
     PutDownSound=(Sound=Sound'BallisticSounds2.M806.M806Putaway',Volume=0.325000)
     MagAmmo=12 
     CockSound=(Sound=Sound'BallisticSounds1.MD24.MD24_Cock',Volume=0.700000)
     ReloadAnimRate=1.250000
     ClipHitSound=(Sound=Sound'BallisticSounds1.MD24.MD24_ClipHit',Volume=0.700000)
     ClipOutSound=(Sound=Sound'BallisticSounds1.MD24.MD24_ClipOut',Volume=0.700000)
     ClipInSound=(Sound=Sound'BallisticSounds1.MD24.MD24_ClipIn',Volume=0.700000)
     ClipInFrame=52.000000
     bCockOnEmpty=True
     WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",)
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
     bNoCrosshairInScope=True
     SightOffset=(X=-22.000000,Y=-0.030000,Z=7.400000)
     SightDisplayFOV=40.000000
     SightingTime=0.200000
     SightAimFactor=2.000000
     SprintOffSet=(Pitch=-1000,Yaw=-2048)	 
     AimSpread=16
     ChaosDeclineTime=0.450000
     ChaosSpeedThreshold=7500.000000
     ChaosAimSpread=384
     RecoilXFactor=0.03000
     RecoilYFactor=0.03000
     RecoilDeclineTime=0.500000
     RecoilDeclineDelay=0.220000
     FireModeClass(0)=Class'BallisticProV55.MD24PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000
     AmmoClass(0)=Class'BallisticProV55.Ammo_MD24_Pistol'	 
     AmmoClass(1)=Class'BallisticProV55.Ammo_MD24_Pistol'		 
     Description="MD24"
     Priority=19
     HudColor=(B=255,G=200,R=200)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=2
     GroupOffset=6
     PlayerViewOffset=(X=10.000000,Y=6.500000,Z=-6.750000)
     AttachmentClass=Class'BallisticProV55.MD24Attachment'
     IconMaterial=Texture'BallisticUI.Icons.SmallIcon_MD24'
     IconCoords=(X2=127,Y2=31)
     ItemName="MD24"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=2.250000
     Mesh=SkeletalMesh'BallisticAnims1.MD24_FP'
     DrawScale=0.350000
     AmbientGlow=5
	 Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticWeapons1.MD24.MD24_Main'
	 Skins(2)=Texture'BallisticWeapons1.MD24.MD24_Clip'	 	 
}
