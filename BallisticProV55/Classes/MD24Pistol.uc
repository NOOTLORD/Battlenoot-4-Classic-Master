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
	 PlayerSpeedFactor=1.100000
     PlayerJumpFactor=1.100000	 
     AIReloadTime=1.500000
     BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_MD24'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     SpecialInfo(0)=(Info="120.0;10.0;-999.0;25.0;0.0;0.0;-999.0")
     BringUpSound=(Sound=Sound'BallisticProSounds.M806.M806-Pullout',Volume=0.325000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     PutDownSound=(Sound=Sound'BallisticProSounds.M806.M806-Putaway',Volume=0.325000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     MagAmmo=12 
     CockAnimRate=1.000000	 
     CockSound=(Sound=Sound'BallisticProSounds.MD24.MD24-Cock',Volume=0.700000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ReloadAnimRate=1.250000
     ClipHitSound=(Sound=Sound'BallisticProSounds.MD24.MD24-ClipHit',Volume=0.700000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipOutSound=(Sound=Sound'BallisticProSounds.MD24.MD24-ClipOut',Volume=0.700000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipInSound=(Sound=Sound'BallisticProSounds.MD24.MD24-ClipIn',Volume=0.700000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipInFrame=52.000000
     WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",)
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
     bNoCrosshairInScope=True
	 SightZoomFactor=0	 
     SightOffset=(X=-22.000000,Y=-0.030000,Z=7.400000)
     SightDisplayFOV=40.000000
     SightingTime=0.200000
     GunLength=16.000000
     LongGunPivot=(Pitch=5000,Yaw=6000)
     LongGunOffset=(X=5.000000,Y=10.000000,Z=-11.000000)
     CrouchAimFactor=0.800000	 
     SightAimFactor=2.000000
     HipRecoilFactor=1.600000	
     SprintChaos=0.100000	
     SprintOffSet=(Pitch=-1000,Yaw=-2048)	 
     AimSpread=16
     ChaosDeclineTime=0.450000
     ChaosSpeedThreshold=7500.000000
     ChaosAimSpread=384
     RecoilXCurve=(Points=(,(InVal=1.000000)))
     RecoilYCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
     RecoilPitchFactor=1.000000
     RecoilYawFactor=1.000000		 
     RecoilXFactor=0.030000
     RecoilYFactor=0.030000
     RecoilMax=4096.000000	 
     RecoilDeclineTime=0.500000
     RecoilDeclineDelay=0.220000
     SelectAnimRate=1.000000
     PutDownAnimRate=1.000000
     PutDownTime=0.300000
     BringUpTime=0.300000
     DisplayFOV=60.000000
     Priority=19	
	 FireModeClass(0)=Class'BallisticProV55.MD24PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire' 
     AIRating=0.600000
     CurrentRating=0.600000	  
     AmmoClass(0)=Class'BallisticProV55.Ammo_MD24Pistol'	 
     AmmoClass(1)=Class'BallisticProV55.Ammo_MD24Pistol'		 
     Description="MD24"
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"		 
     InventoryGroup=2
     PlayerViewOffset=(X=10.000000,Y=6.500000,Z=-6.750000)
     AttachmentClass=Class'BallisticProV55.MD24Attachment'
     IconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_MD24'
     IconCoords=(X2=127,Y2=31)
     ItemName="MD24"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=2.250000
     Mesh=SkeletalMesh'BallisticProAnims.MD24_FP'
     DrawScale=0.350000
	 Skins(0)=Shader'BallisticProTex.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticProTex.MD24.MD24-Main'
	 Skins(2)=Texture'BallisticProTex.MD24.MD24-Clip'	 	 
}
