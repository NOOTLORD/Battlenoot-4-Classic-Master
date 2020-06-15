//=============================================================================
// Weapon class for AK-470 Assault Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class AK47AssaultRifle extends BallisticWeapon;

var name			BulletBone;

// Animation notify for when the clip is stuck in
simulated function Notify_ClipIn()
{
	Super.Notify_ClipIn();

	SetBoneScale(0,1.0,BulletBone);
}

simulated function Notify_ClipOut()
{
	Super.Notify_ClipOut();

	if(MagAmmo < 1)
		SetBoneScale(0,0.0,BulletBone);
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
function float SuggestDefenseStyle()	{	return 0.0;	}

// End AI Stuff =====

defaultproperties
{
     BulletBone="Bullet1"
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_AK-470'
     BigIconCoords=(Y1=32,Y2=220)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'	 
     bWT_Bullet=True
     BringUpSound=(Sound=Sound'BallisticSounds2.M50.M50Pullout',Volume=0.400000)
     PutDownSound=(Sound=Sound'BallisticSounds2.M50.M50Putaway',Volume=0.400000)
     MagAmmo=25  
     CockingBringUpTime=1.300000
     CockSound=(Sound=Sound'BallisticRecolorsSounds.AK47.AK47-Cock',Volume=0.900000)
     ReloadAnimRate=1.250000
     ClipHitSound=(Sound=Sound'BallisticRecolorsSounds.AK47.AK47-ClipHit',Volume=0.900000)
     ClipOutSound=(Sound=Sound'BallisticRecolorsSounds.AK47.AK47-ClipOut',Volume=0.900000)
     ClipInSound=(Sound=Sound'BallisticRecolorsSounds.AK47.AK47-ClipIn',Volume=0.900000)
     ClipInFrame=0.650000
     bCockOnEmpty=True
     WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
     bNoCrosshairInScope=True
     SightPivot=(Pitch=64)
     SightOffset=(X=10.000000,Y=-10.020000,Z=20.600000)
     SightDisplayFOV=40.000000
     HipRecoilFactor=1.000000
     SprintOffSet=(Pitch=-1000,Yaw=-2048)
     AimAdjustTime=100.000000
     AimSpread=16
     AimDamageThreshold=0.000000
	 ViewRecoilFactor=1.000000
     ChaosDeclineTime=1.250000
     ChaosSpeedThreshold=15000.000000
     ChaosAimSpread=3072
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=-0.10000),(InVal=0.400000,OutVal=0.130000),(InVal=0.600000,OutVal=-0.160000),(InVal=1.000000,OutVal=-0.080000)))
     RecoilYCurve=(Points=(,(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.450000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.220000
     RecoilYFactor=0.300000
     RecoilMinRandFactor=0.15000
     RecoilDeclineTime=1.500000
     FireModeClass(0)=Class'BWBPRecolorsPro.AK47PrimaryFire'
	 FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     IdleAnimRate=0.400000
     SelectAnimRate=1.700000
     PutDownAnimRate=1.750000
     BringUpTime=0.400000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.700000
     CurrentRating=0.700000
     AmmoClass(0)=Class'BWBPRecolorsPro.Ammo_AK470_Rifle'
     AmmoClass(1)=Class'BWBPRecolorsPro.Ammo_AK470_Rifle'	 
     Description="AK-470 Assault Rifle"
     Priority=65
     HudColor=(B=255,G=200,R=200)
     CustomCrossHairScale=0.000000	 
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=1
     GroupOffset=5
     PlayerViewOffset=(X=2.000000,Y=15.500000,Z=-16.000000)
     AttachmentClass=Class'BWBPRecolorsPro.AK47Attachment'
     IconMaterial=Texture'BallisticUI.Icons.AK-470.SmallIcon_AK-470'
     IconCoords=(X2=127,Y2=31)
     ItemName="AK-470"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticRecolorsAnims.AK490_FP'
     DrawScale=0.350000
     AmbientGlow=5
	 Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticRecolorsTex.AK490.AK490-Main'
	 Skins(2)=Texture'BallisticRecolorsTex.AK490.AK490-Misc'
}