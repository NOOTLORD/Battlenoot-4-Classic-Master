//=============================================================================
// Weapon class for the SRS-600-Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class SRS600Rifle extends BallisticWeapon;

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	SetBoneScale (0, 0.0, 'Silencer');
}

simulated function Notify_ClipOutOfSight()	
{	
    SetBoneScale (1, 1.0, 'Bullet');	
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
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_SRS600'
     BigIconCoords=(Y2=240)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     InventorySize=14	 
     SpecialInfo(0)=(Info="240.0;20.0;0.9;75.0;1.0;0.0;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.R78.R78Pullout',Volume=0.375000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     PutDownSound=(Sound=Sound'BallisticSounds2.R78.R78Putaway',Volume=0.375000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     MagAmmo=20
     CockAnimRate=1.200000
     CockSound=(Sound=Sound'BallisticSounds1.SRS600.SRS-Cock',Volume=0.875000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipHitSound=(Sound=Sound'BallisticSounds1.SRS600.SRS-ClipHit',Volume=0.875000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipOutSound=(Sound=Sound'BallisticSounds1.SRS600.SRS-ClipOut',Volume=0.875000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipInSound=(Sound=Sound'BallisticSounds1.SRS600.SRS-ClipIn',Volume=0.875000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipInFrame=50.000000 
     WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",)
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
     bNoCrosshairInScope=True
	 SightZoomFactor=0	 
     SightOffset=(X=16.000000,Z=8.660000)
     SightDisplayFOV=40.000000
     SightingTime=0.350000	 
     GunLength=72.000000
     LongGunPivot=(Pitch=-4000,Yaw=-12000)
     LongGunOffset=(X=5.000000,Y=10.000000,Z=-11.000000)	
     CrouchAimFactor=0.800000
     SightAimFactor=0.250000
     HipRecoilFactor=1.600000	 
     SprintChaos=0.100000	 
     SprintOffSet=(Pitch=-3000,Yaw=-4000)
     AimSpread=32
     ChaosDeclineTime=0.750000
     ChaosSpeedThreshold=9000.000000
     ChaosAimSpread=3072
     RecoilXCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.250000,OutVal=0.180000),(InVal=0.400000,OutVal=0.30000),(InVal=0.800000,OutVal=0.40000),(InVal=1.000000,OutVal=0.60000)))
     RecoilYCurve=(Points=(,(InVal=0.150000,OutVal=0.180000),(InVal=0.300000,OutVal=0.320000),(InVal=0.500000,OutVal=0.5000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
     RecoilPitchFactor=1.000000
     RecoilYawFactor=1.000000 
     RecoilXFactor=0.250000
     RecoilYFactor=0.250000
     RecoilMax=4096.000000	 
     RecoilDeclineTime=1.00000
     RecoilDeclineDelay=0.400000
     SelectAnimRate=1.350000
     PutDownAnimRate=1.000000
     PutDownTime=0.300000	 
     BringUpTime=0.350000	 
     DisplayFOV=60.000000	 
     Priority=40	 
     FireModeClass(0)=Class'BallisticProV55.SRS600PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     AIRating=0.80000
     CurrentRating=0.80000
     AmmoClass(0)=Class'BallisticProV55.Ammo_SRS600_Rifle'	
     AmmoClass(1)=Class'BallisticProV55.Ammo_SRS600_Rifle'		 
     Description="SRS-600"
     CustomCrossHairScale=0.000000								  
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=1 
     PlayerViewOffset=(X=5.000000,Y=9.000000,Z=-10.000000)
     AttachmentClass=Class'BallisticProV55.SRS600Attachment'
     IconMaterial=Texture'BallisticUI.Icons.SmallIcon_SRS600'
     IconCoords=(X2=127,Y2=31)
     ItemName="SRS-600"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticAnims1.SRS600_FP'
     DrawScale=0.500000
     Skins(0)=Texture'BallisticWeapons1.SRS600.SRS-600main'
     Skins(1)=Texture'BallisticWeapons1.SRS600.SRS600Ammo'
     Skins(2)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
}
