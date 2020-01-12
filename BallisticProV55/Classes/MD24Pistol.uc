//=============================================================================
// MD24Pistol.
//
// Semi Automatic pistol with decent damage.
// Secondary fixes the unpredictable aiming by providing a laser sight so that
// the user knows where to expect the bullets.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
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
		else	BFireMode[0].FireAnim = 'NewOpenFire';
	}
	else
	{
		if (bScopeView)
			BFireMode[0].FireAnim = 'SightFire';
		else BFireMode[0].FireAnim = 'NewFire';
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
     bShouldDualInLoadout=False
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.500000
     BigIconMaterial=Texture'BallisticTextures_25.MD24.BigIcon_MD24'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     ManualLines(0)="Low-recoil pistol fire. Has the option of burst fire. Very controllable."
     ManualLines(1)="Prepares a bludgeoning attack,which will be executed upon release. The damage of the attack increases the longer altfire is held, up to 1.5 seconds for maximum damage output. As a blunt attack, has lower base damage compared to bayonets but inflicts a short-duration blinding effect when striking. This attack inflicts more damage from behind."
     ManualLines(2)="The Weapon Function key toggles a laser sight, which reduces the spread of the weapon's hipfire, but exposes the user's position to the enemy. This laser sight makes the MD24 a strong choice for dual wielding.||Effective at close range."
     SpecialInfo(0)=(Info="120.0;10.0;-999.0;25.0;0.0;0.0;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.M806.M806Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.M806.M806Putaway')
     MagAmmo=12
     CockSound=(Sound=Sound'BallisticSounds_25.MD24.MD24_Cock',Volume=0.550000)
     ReloadAnimRate=1.350000
     ClipHitSound=(Sound=Sound'BallisticSounds_25.MD24.MD24_ClipHit',Volume=0.550000)
     ClipOutSound=(Sound=Sound'BallisticSounds_25.MD24.MD24_ClipOut',Volume=0.550000)
     ClipInSound=(Sound=Sound'BallisticSounds_25.MD24.MD24_ClipIn',Volume=0.550000)
     ClipInFrame=0.580000
     bCockOnEmpty=True
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
     bNoCrosshairInScope=True
     SightOffset=(X=-22.000000,Y=-0.030000,Z=7.400000)
     SightDisplayFOV=40.000000
     SightingTime=0.200000
	 SightZoomFactor=0
     SightAimFactor=0.100000
     AimAdjustTime=0.000000
     AimSpread=16
     AimDamageThreshold=0.000000
     ChaosDeclineTime=0.450000
     ChaosSpeedThreshold=7500.000000
     ChaosAimSpread=384
     RecoilYawFactor=0.200000
     RecoilXFactor=0.250000
     RecoilYFactor=0.250000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.250000
     FireModeClass(0)=Class'BallisticProV55.MD24PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000	 
     Description="The MD24 is a lightweight, medium powered pistol, recently developed by the internal UTC Defense Tech manufacturer for those troops in need of the simple maneuverability. The MD24 is primarily made up of specialised polymers and lightweight metals to make it useful to stealth and Commando units. Fitted with a stock laser pointing device, the MD24 is an easy to use sidearm, especially useful in tight spots."
     Priority=19
     HudColor=(B=25,G=150,R=50)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=2
     GroupOffset=6
     PlayerViewOffset=(X=6.500000,Y=6.000000,Z=-6.500000)
     AttachmentClass=Class'BallisticProV55.MD24Attachment'
     IconMaterial=Texture'BallisticTextures_25.MD24.SmallIcon_MD24'
     IconCoords=(X2=127,Y2=31)
     ItemName="MD24 Pistol"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BallisticProAnims.MD24'
     DrawScale=0.350000
     AmbientGlow=0
}
