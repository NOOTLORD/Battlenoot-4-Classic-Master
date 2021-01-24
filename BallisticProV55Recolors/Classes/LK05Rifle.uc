//=============================================================================
// Weapon class for the LK05 Rifle
//
// by Sarge.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class LK05Rifle extends BallisticWeapon;

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	SetBoneScale (0, 0.0, 'Silencer');
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		IdleAnim = 'OpenIdle';
		ReloadAnim = 'Reload';
	}
	
	else
	{
		IdleAnim = 'Idle';
		ReloadAnim = 'Reload';
	}

	Super.BringUp(PrevWeapon);
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);

	if (Anim == 'OpenFire' || Anim == 'Pullout' || Anim == 'Fire' || Anim == 'OpenSightFire' ||Anim == CockAnim || Anim == ReloadAnim)
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			IdleAnim = 'OpenIdle';
			ReloadAnim = 'Reload';
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
     AIReloadTime=1.000000
     PlayerSpeedFactor=1.000000
     PlayerJumpFactor=1.000000	 
     BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_LK-05'
     BigIconCoords=(Y1=36,Y2=225)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     InventorySize=12	 
     BringUpSound=(Sound=Sound'BallisticProRecolorsSounds.M4A1.M4A1-PullOut',Volume=0.425000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     PutDownSound=(Sound=Sound'BallisticProRecolorsSounds.M4A1.M4A1-Putaway',Volume=0.425000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     MagAmmo=32
	 CockAnimPostReload="Pullout"
     CockAnimRate=1.000000	 
     CockSound=(Sound=Sound'BallisticProRecolorsSounds.LK-05.LK-05-Cock',Volume=0.800000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ReloadAnimRate=1.000000
     ClipOutSound=(Sound=Sound'BallisticProRecolorsSounds.LK-05.LK-05-MagOut',Volume=0.800000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipInSound=(Sound=Sound'BallisticProRecolorsSounds.LK-05.LK-05-MagIn',Volume=0.800000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipInFrame=37.000000
     WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
     bNoCrosshairInScope=True
	 SightZoomFactor=0	 
     SightOffset=(X=10.000000,Y=-8.550000,Z=24.660000)
     SightDisplayFOV=40.000000
     SightingTime=0.300000
     GunLength=64.000000
     LongGunPivot=(Pitch=-4000,Yaw=-12000)
     LongGunOffset=(X=5.000000,Y=10.000000,Z=-11.000000)	 
     CrouchAimFactor=0.800000
     SightAimFactor=0.250000
     HipRecoilFactor=1.600000
     SprintChaos=0.100000		 
     SprintOffSet=(Pitch=-3072,Yaw=-4096)
     AimSpread=16 
     ChaosDeclineTime=0.500000
     ChaosSpeedThreshold=15000.000000
     ChaosAimSpread=3072
     RecoilXCurve=(Points=(,(InVal=0.1,OutVal=0.12),(InVal=0.2,OutVal=0.18),(InVal=0.35,OutVal=0.22),(InVal=0.5,OutVal=0.3),(InVal=0.7,OutVal=0.45),(InVal=0.85,OutVal=0.6),(InVal=1.000000,OutVal=0.66)))
     RecoilYCurve=(Points=(,(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.750000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
     RecoilPitchFactor=1.000000
     RecoilYawFactor=1.000000
     RecoilXFactor=0.200000
     RecoilYFactor=0.350000
     RecoilMax=4096.000000	 
     RecoilDeclineTime=0.400000
     RecoilDeclineDelay=0.200000
     SelectAnimRate=1.600000
     PutDownAnimRate=1.300000
     PutDownTime=0.400000
     BringUpTime=0.450000	 
     DisplayFOV=60.000000	 
	 Priority=41
     FireModeClass(0)=Class'BallisticProV55Recolors.LK05PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     AIRating=0.700000
     CurrentRating=0.700000
     AmmoClass(0)=Class'BallisticProV55Recolors.Ammo_LK05Rifle'  
     AmmoClass(1)=Class'BallisticProV55Recolors.Ammo_LK05Rifle' 
     Description="LK-05" 	 
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=1
     PlayerViewOffset=(X=-2.000000,Y=12.500000,Z=-17.000000)
     AttachmentClass=Class'BallisticProV55Recolors.LK05Attachment'
     IconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_LK-05'
     IconCoords=(X2=127,Y2=31)
     ItemName="LK-05"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticProRecolorsAnims.LK-05_FP'
     DrawScale=0.300000
	 Skins(0)=Shader'BallisticProTex.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticProRecolorsTex.LK-05.LK-05-Grip'
	 Skins(2)=Texture'BallisticProRecolorsTex.LK-05.LK-05-Stock'
	 Skins(3)=Texture'BallisticProRecolorsTex.LK-05.LK-05-Receiver'
	 Skins(4)=Texture'BallisticProRecolorsTex.LK-05.LK-05-Bullets'
	 Skins(5)=Texture'BallisticProRecolorsTex.LK-05.LK-05-Mag'
	 Skins(6)=Texture'BallisticProRecolorsTex.LK-05.LK-05-EOTech'
	 Skins(7)=Shader'BallisticProRecolorsTex.LK-05.LK-05-EOTechShader' 
}
