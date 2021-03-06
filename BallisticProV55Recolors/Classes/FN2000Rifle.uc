//=============================================================================
// Weapon class for the FN2000 Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class FN2000Rifle extends BallisticWeapon;

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

	return class'BUtil'.static.DistanceAtten(Rating, 0.5, Dist, BallisticRangeAttenFire(BFireMode[0]).CutOffStartRange, BallisticRangeAttenFire(BFireMode[0]).CutOffDistance); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.4;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.4;	}
// End AI Stuff =====

defaultproperties
{
     AIReloadTime=1.000000
     PlayerSpeedFactor=1.000000
     PlayerJumpFactor=1.000000	 
     BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_FN2000'
     BigIconCoords=(X1=32,Y1=40,X2=475)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Machinegun=True	
     InventorySize=12	 
     BringUpSound=(Sound=Sound'BallisticProSounds.M50.M50-Pullout',Volume=0.425000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     PutDownSound=(Sound=Sound'BallisticProSounds.M50.M50-Putaway',Volume=0.425000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     MagAmmo=30
     CockAnimRate=1.250000 	 
     CockSound=(Sound=Sound'BallisticProRecolorsSounds.FN2000.FN2000-BoltPull',Volume=0.950000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ReloadAnimRate=1.350000 
     ClipHitSound=(Sound=Sound'BallisticProRecolorsSounds.FN2000.FN2000-MagFiddle',Volume=0.950000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipOutSound=(Sound=Sound'BallisticProRecolorsSounds.FN2000.FN2000-MagOut',Volume=0.950000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipInSound=(Sound=Sound'BallisticProRecolorsSounds.FN2000.FN2000-MagIn',Volume=0.950000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipInFrame=77.000000
     WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
     bNoCrosshairInScope=True
	 SightZoomFactor=0	 
     SightOffset=(X=6.000000,Y=-6.350000,Z=23.150000)
     SightDisplayFOV=40.000000
     SightingTime=0.350000
     GunLength=64.000000
     LongGunPivot=(Pitch=-4000,Yaw=-12000)
     LongGunOffset=(X=5.000000,Y=10.000000,Z=-11.000000)	
     CrouchAimFactor=0.800000
     SightAimFactor=0.250000
     HipRecoilFactor=1.600000
     SprintChaos=0.100000	 
     SprintOffSet=(Pitch=-3000,Yaw=-4096)
     AimSpread=16 
     ChaosDeclineTime=0.500000
     ChaosSpeedThreshold=7500.000000
     ChaosAimSpread=3072
     RecoilXCurve=(Points=(,(InVal=0.100000,OutVal=0.080000),(InVal=0.25000,OutVal=0.2000),(InVal=0.3500000,OutVal=0.150000),(InVal=0.4800000,OutVal=0.20000),(InVal=0.600000,OutVal=-0.050000),(InVal=0.750000,OutVal=0.0500000),(InVal=0.900000,OutVal=0.15),(InVal=1.000000,OutVal=0.3)))
     RecoilYCurve=(Points=(,(InVal=0.200000,OutVal=0.250000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
     RecoilPitchFactor=1.000000
     RecoilYawFactor=1.000000
     RecoilXFactor=0.200000
     RecoilYFactor=0.200000
     RecoilMax=4096.000000	 
     RecoilDeclineTime=0.500000
     RecoilDeclineDelay=0.140000
     SelectAnimRate=1.000000
     PutDownAnimRate=1.000000	 
     PutDownTime=0.500000
     BringUpTime=0.500000	
     DisplayFOV=60.000000	 
     Priority=65	 
     FireModeClass(0)=Class'BallisticProV55Recolors.FN2000PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     AIRating=0.750000
     CurrentRating=0.750000	 
     AmmoClass(0)=Class'BallisticProV55Recolors.Ammo_FN2000Rifle'
     AmmoClass(1)=Class'BallisticProV55Recolors.Ammo_FN2000Rifle'	
     Description="FN2000"
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=1
     PlayerViewOffset=(X=8.000000,Y=12.500000,Z=-18.000000)
     AttachmentClass=Class'BallisticProV55Recolors.FN2000Attachment'
     IconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_FN2000'
     IconCoords=(X2=127,Y2=31)
	 BobDamping=1.500000
     ItemName="FN2000"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticProRecolorsAnims.FN2000_FP'
     DrawScale=0.300000
	 Skins(0)=Shader'BallisticProTex.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticProRecolorsTex.FN2000.FN2000-Main'
	 Skins(2)=Texture'BallisticProRecolorsTex.FN2000.FN2000-Misc'
	 Skins(3)=Texture'BallisticProRecolorsTex.FN2000.FN2000-EOTech'
}
