//=============================================================================
// Weapon class for the M46 Rifle 
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class M46Rifle extends BallisticWeapon;

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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.75, Dist, BallisticRangeAttenFire(BFireMode[0]).CutOffStartRange, BallisticRangeAttenFire(BFireMode[0]).CutOffDistance); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.0;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.0;	}

// End AI Stuff =====

defaultproperties
{
     PlayerSpeedFactor=1.000000
     PlayerJumpFactor=1.000000	 
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_M46'
     BigIconCoords=(Y1=40,Y2=235)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Machinegun=True	
     InventorySize=12	 
     SpecialInfo(0)=(Info="240.0;25.0;0.9;70.0;0.9;0.2;0.7")
     BringUpSound=(Sound=Sound'BallisticProSounds.M50.M50-Pullout',Volume=0.415000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     PutDownSound=(Sound=Sound'BallisticProSounds.M50.M50-Putaway',Volume=0.415000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     MagAmmo=25
     CockAnimRate=1.250000	 																																									   																					   						  
     CockSound=(Sound=Sound'BallisticProSounds.M46.M46-Cock',Volume=0.800000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ReloadAnimRate=1.250000						
     ClipHitSound=(Sound=Sound'BallisticProSounds.M46.M46-ClipHit',Volume=0.800000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipOutSound=(Sound=Sound'BallisticProSounds.M46.M46-ClipOut',Volume=0.800000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipInSound=(Sound=Sound'BallisticProSounds.M46.M46-ClipIn',Volume=0.800000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipInFrame=53.000000		
     WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
     bNoCrosshairInScope=True							 
     SightPivot=(Pitch=-300,Roll=0)
	 SightZoomFactor=0	 
     SightOffset=(X=-10.000000,Y=0.000000,Z=11.550000)
     SightDisplayFOV=35.000000
     SightingTime=0.350000	 
     GunLength=64.000000 
     LongGunPivot=(Pitch=-4000,Yaw=-12000)
     LongGunOffset=(X=5.000000,Y=10.000000,Z=-11.000000)	 
	 CrouchAimFactor=0.800000 
     SightAimFactor=1.000000
	 HipRecoilFactor=1.600000
     SprintChaos=0.100000
     SprintOffSet=(Pitch=-3000,Yaw=-4000)
     AimSpread=24
     ChaosDeclineTime=1.250000
     ChaosSpeedThreshold=15000.000000	 
     ChaosAimSpread=3072
     RecoilXCurve=(Points=(,(InVal=0.080000,OutVal=0.050000),(InVal=0.110000,OutVal=0.080000),(InVal=0.150000,OutVal=0.14000),(InVal=0.300000,OutVal=0.2300000),(InVal=0.450000,OutVal=0.2500000),(InVal=0.600000,OutVal=0.350000),(InVal=0.800000,OutVal=0.380000),(InVal=1.000000,OutVal=0.25)))
     RecoilYCurve=(Points=(,(InVal=0.150000,OutVal=0.120000),(InVal=0.300000,OutVal=0.350000),(InVal=0.500000,OutVal=0.600000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
     RecoilPitchFactor=1.000000
     RecoilYawFactor=1.000000
     RecoilXFactor=0.250000
     RecoilYFactor=0.250000
     RecoilMax=4096.000000	 
	 RecoilDeclineTime=0.6500000	 
     RecoilDeclineDelay=0.1700000
     SelectAnimRate=1.000000
     PutDownAnimRate=1.000000
     PutDownTime=0.300000
     BringUpTime=0.300000	 
     DisplayFOV=55.000000																																																																																																																																					  						 
     Priority=41
     FireModeClass(0)=Class'BallisticProV55.M46PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'	 
     AIRating=0.700000
     CurrentRating=0.700000	 
     AmmoClass(0)=Class'BallisticProV55.Ammo_M46Rifle'
     AmmoClass(1)=Class'BallisticProV55.Ammo_M46Rifle'	 	 
     Description="M46"	 
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=1
     PlayerViewOffset=(X=8.400000,Y=5.000000,Z=-8.000000)
     PlayerViewPivot=(Pitch=384)														 								
     AttachmentClass=Class'BallisticProV55.M46Attachment'
     IconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_M46'
     IconCoords=(X2=127,Y2=31)																								  
     ItemName="M46"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000				   																									   						 
     Mesh=SkeletalMesh'BallisticProAnims.M46_FP'
     DrawScale=0.300000	 
	 Skins(0)=Shader'BallisticProTex.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticProTex.M46.M46-Main'
	 Skins(2)=Texture'BallisticProTex.M46.M46-Clip'
	 Skins(3)=Texture'BallisticProTex.M46.M46-GrenadeLauncher'
	 Skins(4)=FinalBlend'BallisticProTex.M46.RDS-FB'
}
