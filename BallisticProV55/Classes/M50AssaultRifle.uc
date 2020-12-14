//=============================================================================
// Weapon class for the M50 Assault Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class M50AssaultRifle extends BallisticWeapon;

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
     BigIconMaterial=Texture'BallisticProUI.Icons.BigIcon_M50'
     BigIconCoords=(Y1=40,Y2=235)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Machinegun=True
     InventorySize=12	 
     SpecialInfo(0)=(Info="240.0;25.0;0.9;80.0;0.7;0.7;0.4")
     BringUpSound=(Sound=Sound'BallisticSounds2.M50.M50Pullout',Volume=0.375000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     PutDownSound=(Sound=Sound'BallisticSounds2.M50.M50Putaway',Volume=0.375000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     CockAnimRate=1.250000
     CockSound=(Sound=Sound'BallisticSounds2.M50.M50Cock',Volume=0.850000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipHitSound=(Sound=Sound'BallisticSounds2.M50.M50ClipHit',Volume=0.850000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipOutSound=(Sound=Sound'BallisticSounds2.M50.M50ClipOut',Volume=0.850000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipInSound=(Sound=Sound'BallisticSounds2.M50.M50ClipIn',Volume=0.850000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipInFrame=67.000000
     WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0	 
     bNoCrosshairInScope=True
	 SightZoomFactor=0	 
     SightPivot=(Pitch=200)
     SightOffset=(Y=0.050000,Z=11.500000)
     SightDisplayFOV=40.000000	 
     SightingTime=0.350000
     GunLength=16.000000
     LongGunPivot=(Pitch=5000,Yaw=6000)
     LongGunOffset=(X=5.000000,Y=10.000000,Z=-11.000000)	 
     CrouchAimFactor=0.750000	
     SightAimFactor=0.200000
     HipRecoilFactor=1.600000
     SprintChaos=0.100000	 
     SprintOffSet=(Pitch=-3000,Yaw=-4000)	 
     AimSpread=16
     ChaosDeclineTime=0.500000
     ChaosSpeedThreshold=15000.000000
     ChaosAimSpread=3072
     RecoilXCurve=(Points=((InVal=0,OutVal=0),(InVal=0.150000,OutVal=0.06),(InVal=0.40000,OutVal=0.21000),(InVal=0.6500000,OutVal=0.25000),(InVal=0.800000,OutVal=0.050000),(InVal=1.00000,OutVal=0.150000)))
     RecoilYCurve=(Points=((InVal=0,OutVal=0),(InVal=0.200000,OutVal=0.210000),(InVal=0.400000,OutVal=0.350000),(InVal=0.600000,OutVal=0.600000),(InVal=0.800000,OutVal=0.7500000),(InVal=1.000000,OutVal=1.000000)))
     RecoilPitchFactor=1.000000
     RecoilYawFactor=1.000000
     RecoilXFactor=0.150000
     RecoilYFactor=0.300000
     RecoilMax=4096.000000	 
	 RecoilDeclineDelay=0.140000 
     RecoilDeclineTime=0.500000	 
     FireModeClass(0)=Class'BallisticProV55.M50PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     SelectAnimRate=1.000000
     PutDownAnimRate=1.500000
     PutDownTime=0.300000
     BringUpTime=0.300000
     DisplayFOV=60.000000	
     Priority=41	 	 
     AIRating=0.600000
     CurrentRating=0.600000
     AmmoClass(0)=Class'BallisticProV55.Ammo_M50_Rifle'
     AmmoClass(1)=Class'BallisticProV55.Ammo_M50_Rifle'	 
     Description="M50"
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"	 
     InventoryGroup=1
     PlayerViewOffset=(X=5.500000,Y=6.600000,Z=-8.000000)
     AttachmentClass=Class'BallisticProV55.M50Attachment'
     IconMaterial=Texture'BallisticProUI.Icons.SmallIcon_M50'
     IconCoords=(X2=127,Y2=31)
     ItemName="M50"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticAnims2.M50_FP'
     DrawScale=0.285000
	 Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticWeapons2.M50.M50SkinA'
	 Skins(2)=Texture'BallisticWeapons2.M50.M50SkinB'
	 Skins(3)=Texture'BN4misc.Albedo.Placeholder_albedo
	 Skins(4)=Texture'BallisticWeapons2.M50.M50Laser'
	 Skins(5)=Texture'BallisticWeapons2.M50.M50Gren'
	 Skins(6)=Texture'BallisticWeapons2.M50.M900Grenade'
}
