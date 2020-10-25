//=============================================================================
// Weapon class for the XK2 SubMachinegun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class XK2SubMachinegun extends BallisticWeapon;

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	SetBoneScale (0, 0.0, 'Silencer');
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
function float SuggestAttackStyle()	{	return 0.6;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.6;	}

// End AI Stuff =====

defaultproperties
{
     PlayerSpeedFactor=1.000000
     PlayerJumpFactor=1.000000	
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_XK2'
     BigIconCoords=(X1=24,X2=450)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Machinegun=True
     InventorySize=12	 
     SpecialInfo(0)=(Info="120.0;10.0;0.6;60.0;0.3;0.1;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Pullout',Volume=0.350000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     PutDownSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Putaway',Volume=0.350000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     MagAmmo=40	
	 CockAnimRate=1.250000	 
     CockSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Cock',Volume=0.850000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True) 
     ClipHitSound=(Volume=0.600000)
     ClipOutSound=(Sound=Sound'BallisticSounds2.XK2.XK2-ClipOut',Volume=0.850000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipInSound=(Sound=Sound'BallisticSounds2.XK2.XK2-ClipIn',Volume=0.850000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipInFrame=45.000000
     WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0		   
     bNoCrosshairInScope=True
	 SightZoomFactor=0	 
     SightPivot=(Pitch=256)
     SightOffset=(X=5.000000,Z=12.700000)
     SightDisplayFOV=40.000000
     SightingTime=0.250000
     GunLength=64.000000
     LongGunPivot=(Pitch=-4000,Yaw=-12000)
     LongGunOffset=(X=5.000000,Y=10.000000,Z=-11.000000)	 
     CrouchAimFactor=0.800000	 
     SightAimFactor=0.400000
     HipRecoilFactor=1.600000
     SprintChaos=0.100000
     SprintOffSet=(Pitch=-3000,Yaw=-4000)	 
     AimSpread=16
     ChaosDeclineTime=0.800000
     ChaosSpeedThreshold=7500.000000
     ChaosAimSpread=2048
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=0.030000),(InVal=0.400000,OutVal=0.050000),(InVal=0.600000,OutVal=0.10000),(InVal=0.800000,OutVal=0.120000),(InVal=1.000000,OutVal=0.16)))
     RecoilYCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.25),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
     RecoilPitchFactor=1.000000
     RecoilYawFactor=1.000000 
     RecoilXFactor=0.250000
     RecoilYFactor=0.250000
     RecoilMax=4096.000000	 
     RecoilDeclineTime=0.500000
     RecoilDeclineDelay=0.150000
     SelectAnimRate=1.000000
     PutDownAnimRate=1.000000
     PutDownTime=0.300000
     BringUpTime=0.300000	
     DisplayFOV=55.000000
     Priority=32	 
     FireModeClass(0)=Class'BallisticProV55.Xk2PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
	 AIRating=0.800000
	 CurrentRating=0.800000"
     AmmoClass(0)=Class'BallisticProV55.Ammo_XK2_SMG'
     AmmoClass(1)=Class'BallisticProV55.Ammo_XK2_SMG'	 
     Description="XK2"
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=1
     PlayerViewOffset=(X=10.000000,Y=8.000000,Z=-11.000000)
     AttachmentClass=Class'BallisticProV55.Xk2Attachment'
     IconMaterial=BallisticUI.Icons.SmallIcon_XK2'
     IconCoords=(X2=127,Y2=31)
     ItemName="XK2"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticAnims2.XK2_FP'
     DrawScale=0.200000
	 Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticWeapons2.XK2.XK2Skin'
}
