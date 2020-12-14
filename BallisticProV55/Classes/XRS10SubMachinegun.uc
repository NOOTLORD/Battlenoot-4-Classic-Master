//=============================================================================
// Weapon class for the XRS10 SubMachinegun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class XRS10SubMachinegun extends BallisticWeapon;

simulated function PlayIdle()
{
	super.PlayIdle();

	if (!bPendingSightUp || SightingState != SS_None || bScopeView || !CanPlayAnim(IdleAnim, ,"IDLE"))
		return;
	FreezeAnimAt(0.0);
}

// Change some properties when using sights...
simulated function SetScopeBehavior()
{
	super.SetScopeBehavior();

	bUseNetAim = default.bUseNetAim || bScopeView;
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
function float SuggestAttackStyle()	{	return 0.8;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.8;	}

// End AI Stuff =====

defaultproperties
{
     PlayerSpeedFactor=1.100000
     PlayerJumpFactor=1.100000		 
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticProUI.Icons.BigIcon_XRS10'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Machinegun=True
	 InventorySize=10
     SpecialInfo(0)=(Info="60.0;5.0;0.4;-1.0;0.0;0.2;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Pullout',Volume=0.325000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     PutDownSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Putaway',Volume=0.325000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     MagAmmo=25
     CockSound=(Sound=Sound'BallisticSounds1.XRS-10.XRS-10-Cock',Volume=0.850000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipOutSound=(Sound=Sound'BallisticSounds1.XRS-10.XRS-10-Clipout',Volume=0.850000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipInSound=(Sound=Sound'BallisticSounds1.XRS-10.XRS-10-Clipin',Volume=0.850000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipInFrame=35.000000
     WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
     bNoCrosshairInScope=True
	 SightZoomFactor=0	 
     SightOffset=(X=-10.000000,Z=12.200000)
	 SightPivot=(Pitch=512)
     SightDisplayFOV=50.000000
     SightingTime=0.250000
     GunLength=16.000000
     LongGunPivot=(Pitch=5000,Yaw=6000)
     LongGunOffset=(X=5.000000,Y=10.000000,Z=-11.000000) 
     CrouchAimFactor=0.800000	 
     SightAimFactor=2.000000
     HipRecoilFactor=1.000000
     SprintChaos=0.100000	 
     SprintOffSet=(Pitch=-3000,Yaw=-4000)
     AimSpread=16
     ChaosDeclineTime=0.640000	 
     ChaosSpeedThreshold=7500.000000
     ChaosAimSpread=1536	 
	 RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=0.05),(InVal=0.400000,OutVal=0.10000),(InVal=0.5500000,OutVal=0.120000),(InVal=0.800000,OutVal=0.15000),(InVal=1.000000,OutVal=0.100000)))
	 RecoilYCurve=(Points=(,(InVal=0.200000,OutVal=0.220000),(InVal=0.400000,OutVal=0.400000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
     RecoilPitchFactor=1.000000
     RecoilYawFactor=1.000000
     RecoilXFactor=0.250000
     RecoilYFactor=0.300000
     RecoilMax=6144.000000
     RecoilDeclineTime=0.500000
     RecoilDeclineDelay=0.200000
     SelectAnimRate=1.000000
     PutDownAnimRate=1.000000
     PutDownTime=0.300000
     BringUpTime=0.300000		 
     DisplayFOV=60.000000	 
     Priority=27	 
     FireModeClass(0)=Class'BallisticProV55.XRS10PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
	 AIRating=0.850000
	 CurrentRating=0.850000
     AmmoClass(0)=Class'BallisticProV55.Ammo_XRS10_SMG'
     AmmoClass(1)=Class'BallisticProV55.Ammo_XRS10_SMG'	 
     Description="XRS-10 Submachine gun"
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=2
     PlayerViewOffset=(X=10.000000,Y=12.000000,Z=-9.500000)
     AttachmentClass=Class'BallisticProV55.XRS10Attachment'
     IconMaterial=Texture'BallisticProUI.Icons.SmallIcon_XRS10'
     IconCoords=(X2=127,Y2=31)
     ItemName="XRS-10"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticAnims1.XRS10_FP'
     DrawScale=0.200000
	 Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticWeapons1.XRS10.XRS10Skin'
}
