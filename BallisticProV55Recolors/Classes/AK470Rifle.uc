//=============================================================================
// Weapon class for AK-470 Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class AK470Rifle extends BallisticWeapon;

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
function float SuggestDefenseStyle()	{	return 0.0;	}

// End AI Stuff =====

defaultproperties
{
     PlayerSpeedFactor=1.000000
     PlayerJumpFactor=1.000000	 
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_AK-470'
     BigIconCoords=(Y1=32,Y2=220)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'	 
     InventorySize=12
     BringUpSound=(Sound=Sound'BallisticProSounds.M50.M50-Pullout',Volume=0.400000)
     PutDownSound=(Sound=Sound'BallisticProSounds.M50.M50-Putaway',Volume=0.400000)
     MagAmmo=25  
     CockingBringUpTime=1.300000
     CockSound=(Sound=Sound'BallisticProRecolorsSounds.AK470.AK470-Cock',Volume=0.900000)
     ReloadAnimRate=1.250000
     ClipHitSound=(Sound=Sound'BallisticProRecolorsSounds.AK470.AK470-ClipHit',Volume=0.900000)
     ClipOutSound=(Sound=Sound'BallisticProRecolorsSounds.AK470.AK470-ClipOut',Volume=0.900000)
     ClipInSound=(Sound=Sound'BallisticProRecolorsSounds.AK470.AK470-ClipIn',Volume=0.900000)
     ClipInFrame=64.000000
     WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
     bNoCrosshairInScope=True
     SightZoomFactor=0	 
     SightPivot=(Pitch=64)
     SightOffset=(X=10.000000,Y=-10.020000,Z=20.600000)
     SightDisplayFOV=40.000000
     GunLength=64.000000
     LongGunPivot=(Pitch=-4000,Yaw=-12000)
     LongGunOffset=(X=5.000000,Y=10.000000,Z=-11.000000)	
     CrouchAimFactor=0.800000
     SightAimFactor=0.250000
     HipRecoilFactor=1.600000	 
     SprintChaos=0.100000	 
     SprintOffSet=(Pitch=-1000,Yaw=-2048)
     AimSpread=24
     ChaosSpeedThreshold=15000.000000	 
     ChaosDeclineTime=1.250000
     ChaosAimSpread=3072
     RecoilXCurve=(Points=(,(InVal=0.100000,OutVal=0.05000),(InVal=0.200000,OutVal=0.060000),(InVal=0.300000,OutVal=0.10000),(InVal=0.400000,OutVal=0.150000),(InVal=0.500000,OutVal=0.170000),(InVal=0.65000000,OutVal=0.100000),(InVal=0.75.000000,OutVal=0.05000),(InVal=1.000000,OutVal=0.080000)))
     RecoilYCurve=(Points=(,(InVal=0.200000,OutVal=0.150000),(InVal=0.300000,OutVal=0.40000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
     RecoilPitchFactor=1.000000
     RecoilYawFactor=1.000000
     RecoilXFactor=0.220000
     RecoilYFactor=0.300000
     RecoilMax=4096.000000	 
     RecoilDeclineTime=0.650000
	 RecoilDeclineDelay=0.150000	 
     SelectAnimRate=1.700000
     PutDownAnimRate=1.750000
     BringUpTime=0.400000	 
     PutDownTime=0.300000
     DisplayFOV=60.000000	
     Priority=65	 
     FireModeClass(0)=Class'BallisticProV55Recolors.AK470PrimaryFire'
	 FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     AIRating=0.700000
     CurrentRating=0.700000
     AmmoClass(0)=Class'BallisticProV55Recolors.Ammo_AK470Rifle'
     AmmoClass(1)=Class'BallisticProV55Recolors.Ammo_AK470Rifle'	 
     Description="AK-470"
     CustomCrossHairScale=0.000000	 
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=1
     PlayerViewOffset=(X=2.000000,Y=15.500000,Z=-16.000000)
     AttachmentClass=Class'BallisticProV55Recolors.AK470Attachment'
     IconMaterial=Texture'BallisticProUITex.Icons.AK-470.SmallIcon_AK-470'
     IconCoords=(X2=127,Y2=31)
	 BobDamping=1.500000
     ItemName="AK-470"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticProRecolorsAnims.AK470_FP'
     DrawScale=0.350000
	 Skins(0)=Shader'BallisticProTex.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticProRecolorsTex.AK470.AK470-Main'
	 Skins(2)=Texture'BallisticProRecolorsTex.AK470.AK470-Misc'
}