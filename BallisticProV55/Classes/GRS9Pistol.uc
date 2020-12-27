//=============================================================================
// Weapon class for the GRS9 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class GRS9Pistol extends BallisticHandgun;
 
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

simulated function Notify_ClipOutOfSight()
{
	SetBoneScale (1, 1.0, 'Bullet');
}

simulated function PlayReload()
{
	super.PlayReload();

	if (MagAmmo < 1)
		SetBoneScale (1, 0.0, 'Bullet');
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
     PlayerSpeedFactor=1.100000
     PlayerJumpFactor=1.100000	
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticProUI.Icons.BigIcon_GRS-9
     BigIconCoords=(Y1=30,Y2=230)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	 InventorySize=6
     SpecialInfo(0)=(Info="120.0;8.0;-999.0;25.0;0.0;0.0;-999.0")
     BringUpSound=(Sound=Sound'BallisticProSounds.M806.M806-Pullout',Volume=0.325000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     PutDownSound=(Sound=Sound'BallisticProSounds.M806.M806-Putaway',Volume=0.325000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     MagAmmo=15
     CockAnimRate=1.200000
     CockSound=(Sound=Sound'BallisticProSounds.GRS-9.GRS-9-Cock',Volume=0.700000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ReloadAnimRate=1.350000
     ClipHitSound=(Sound=Sound'BallisticProSounds.GRS-9.GRS-9-ClipHit',Volume=0.800000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipOutSound=(Sound=Sound'BallisticProSounds.GRS-9.GRS-9-ClipOut',Volume=0.800000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipInSound=(Sound=Sound'BallisticProSounds.GRS-9.GRS-9-ClipIn',Volume=0.800000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipInFrame=37.000000
     WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",)
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
     bNoCrosshairInScope=True
     SightZoomFactor=0	 
     SightOffset=(X=-15.000000,Z=5.900000)
     SightDisplayFOV=45.000000
     SightingTime=0.200000
     GunLength=16.000000
     LongGunPivot=(Pitch=5000,Yaw=6000)
     LongGunOffset=(X=5.000000,Y=10.000000,Z=-11.000000)	 
     CrouchAimFactor=0.800000	 
     SightAimFactor=2.000000
	 HipRecoilFactor=1.50000	 
     SprintChaos=0.050000
     SprintOffSet=(Pitch=-1000,Yaw=-2048)	 
     AimSpread=16
     ChaosDeclineTime=0.450000
     ChaosSpeedThreshold=7500.000000
     ChaosAimSpread=384
	 RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=0.12),(InVal=0.300000,OutVal=0.150000),(InVal=0.4,OutVal=0.02),(InVal=0.550000,OutVal=-0.120000),(InVal=0.700000,OutVal=0.050000),(InVal=1.000000,OutVal=0.200000)))
	 RecoilYCurve=(Points=(,(InVal=0.200000,OutVal=0.25000),(InVal=0.450000,OutVal=0.450000),(InVal=0.650000,OutVal=0.75000),(InVal=0.800000,OutVal=0.820000),(InVal=1.000000,OutVal=1.000000)))	 
     RecoilPitchFactor=1.000000
     RecoilYawFactor=0.000000
     RecoilXFactor=0.250000
     RecoilYFactor=0.250000
	 RecoilMax=6144
	 RecoilDeclineTime=0.750000
	 RecoilDeclineDelay=0.350000	 
	 SelectAnimRate=1.250000
	 PutDownAnimRate=1.250000
     PutDownTime=0.300000
     BringUpTime=0.300000	 
     DisplayFOV=60.000000		 
     Priority=9	 
     FireModeClass(0)=Class'BallisticProV55.GRS9PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'	 	 
	 AIRating=0.600000
	 CurrentRating=0.600000
     AmmoClass(0)=Class'BallisticProV55.Ammo_GRS9Pistol'
     AmmoClass(1)=Class'BallisticProV55.Ammo_GRS9Pistol'	 
     Description="GRS-9"
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=2
     PlayerViewOffset=(X=10.000000,Y=10.50000,Z=-8.500000)
     AttachmentClass=Class'BallisticProV55.GRS9Attachment'
     IconMaterial=Texture'BallisticProUI.Icons.SmallIcon_GRS-9
     IconCoords=(X2=127,Y2=31)
     ItemName="GRS-9"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=2.250000
     Mesh=SkeletalMesh'BallisticProAnims.GRS9_FP'
     DrawScale=0.150000
	 Skins(0)=Shader'BallisticProTex.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticProTex.GRS-9.GRS-9-Main'
}
