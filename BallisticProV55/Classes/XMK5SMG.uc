//=============================================================================
// Weapon class for the XMK-5 SMG
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class XMK5SMG extends BallisticWeapon;

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
function float SuggestAttackStyle()	{	return 0.6;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.6;	}

// End AI Stuff =====

defaultproperties
{
     PlayerSpeedFactor=1.000000
     PlayerJumpFactor=1.000000
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticProUITex.Icons.OA-SMG.BigIcon_XMK5'
     BigIconCoords=(Y1=16,Y2=210)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Machinegun=True
     InventorySize=12	 
     SpecialInfo(0)=(Info="180.0;15.0;0.7;60.0;0.1;0.4;-999.0")
     BringUpSound=(Sound=Sound'BallisticProSounds.M50.M50-Pullout',Volume=0.385000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     PutDownSound=(Sound=Sound'BallisticProSounds.M50.M50-Putaway',Volume=0.385000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     MagAmmo=32
     CockAnimRate=1.250000
     CockSound=(Sound=Sound'BallisticProSounds.XMK-5-Cock',Volume=0.875000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ReloadAnimRate=1.250000
     ClipOutSound=(Sound=Sound'BallisticProSounds.XMK-5-ClipOut',Volume=0.875000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipInSound=(Sound=Sound'BallisticProSounds.XMK-5-ClipIn',Volume=0.875000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipInFrame=56.000000
     WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
     bNoCrosshairInScope=True
     SightPivot=(Pitch=200)
	 SightZoomFactor=0
     SightOffset=(X=1.000000,Z=14.600000)
     SightDisplayFOV=40.000000
     SightingTime=0.250000
     GunLength=40.000000
     LongGunPivot=(Pitch=-4000,Yaw=-12000)
     LongGunOffset=(X=5.000000,Y=10.000000,Z=-11.000000)
     CrouchAimFactor=0.800000
     SightAimFactor=0.250000
     HipRecoilFactor=1.600000
     SprintChaos=0.100000	 
     SprintOffSet=(Pitch=-3000,Yaw=-4000)
     AimSpread=16
     ChaosDeclineTime=0.800000
     ChaosSpeedThreshold=7500.000000
     ChaosAimSpread=2048	 
	 RecoilXCurve=(Points=(,(InVal=0.15,OutVal=0.08),(InVal=0.3,OutVal=0.18),(InVal=0.4,OutVal=0.22),(InVal=0.6,OutVal=0.27),(InVal=0.8,OutVal=0.28),(InVal=1.0,OutVal=0.35)))
	 RecoilYCurve=(Points=(,(InVal=0.150000,OutVal=0.250000),(InVal=0.30000,OutVal=0.350000),(InVal=0.450000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
     RecoilPitchFactor=1.000000
     RecoilYawFactor=1.000000
     RecoilXFactor=0.200000
     RecoilYFactor=0.350000
     RecoilMax=4096.000000	 
     RecoilDeclineTime=0.500000
     RecoilDeclineDelay=0.125000
     SelectAnimRate=1.000000
     PutDownAnimRate=1.000000	 
	 PutDownTime=0.350000 
     BringUpTime=0.300000
     DisplayFOV=60.000000	 
     Priority=41	 
     FireModeClass(0)=Class'BallisticProV55.XMK5PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
	 AIRating=0.800000
	 CurrentRating=0.800000	 
     AmmoClass(0)=Class'BallisticProV55.Ammo_XMK5SMG'
     AmmoClass(1)=Class'BallisticProV55.Ammo_XMK5SMG'	 
     Description="XMk5 Submachine Gun"
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=1
     PlayerViewOffset=(X=2.000000,Y=6.000000,Z=-10.000000)
     AttachmentClass=Class'BallisticProV55.XMK5Attachment'
     IconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_XMK5'
     IconCoords=(X2=127,Y2=31)
     ItemName="XMK-5"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticProAnims.XMK-5_FP'
     DrawScale=0.450000
	 Skins(0)=Shader'BallisticProTex.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticProTex.XMK-5.XMK-5-Main'
	 Skins(2)=Texture'BallisticProTex.XMK-5.XMK-5-Misc'
	 Skins(3)=Texture'BallisticProTex.XMK-5.XMK-5-Clip'
	 Skins(4)=FinalBlend'BallisticProTex.XMK-5.XMK-5-SightFB'	 
}
