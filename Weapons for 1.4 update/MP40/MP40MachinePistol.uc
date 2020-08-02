//=============================================================================
// Weapon class for the MP40 MachinePistol
//
// by Sarge.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class MP40MachinePistol extends BallisticWeapon;

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
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_MP40'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo' 
     bWT_Bullet=True
     bWT_Machinegun=True	 
     SpecialInfo(0)=(Info="240.0;25.0;0.9;80.0;0.7;0.7;0.4")
     BringUpSound=(Sound=Sound'BallisticSounds2.M50.M50Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.M50.M50Putaway')
     MagAmmo=25
     CockSound=(Sound=Sound'BallisticSounds2.M50.M50Cock')
     ClipHitSound=(Sound=Sound'BallisticSounds2.M50.M50ClipHit')
     ClipOutSound=(Sound=Sound'BallisticSounds2.M50.M50ClipOut')
     ClipInSound=(Sound=Sound'BallisticSounds2.M50.M50ClipIn')
     ClipInFrame=0.650000
     ReloadEmptyAnim="Reload" 
	 bCockOnEmpty=True 	 
     WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
     bNoCrosshairInScope=True	 
     SightPivot=(Yaw=10)
     SightOffset=(X=5.000000,Y=-7.660000,Z=18.900000)
     SightDisplayFOV=40.000000
     SightingTime=0.250000
     GunLength=40.000000	 
     SprintOffSet=(Pitch=-1000,Yaw=-2048)
	 AimAdjustTime=100.000000
     AimSpread=16
     AIRating=0.600000
     CurrentRating=0.600000	 
     AimDamageThreshold=0.000000
     ChaosDeclineTime=0.800000
     ChaosSpeedThreshold=7500.000000
     ChaosAimSpread=2048
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=0.050000),(InVal=0.400000,OutVal=-0.100000),(InVal=0.600000,OutVal=0.150000),(InVal=0.800000,OutVal=-0.050000),(InVal=1.000000)))
     RecoilYCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.400000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.250000
     RecoilYFactor=0.250000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.110000
     FireModeClass(0)=Class'BWBPRecolorsPro.MP40PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     PutDownTime=0.500000
     SelectForce="SwitchToAssaultRifle"
     AmmoClass(0)=Class'BWBPRecolorsPro.Ammo_MP40'
     AmmoClass(1)=Class'BWBPRecolorsPro.Ammo_MP40'	 
     Description="MP40"
     Priority=41
     HudColor=(B=255,G=200,R=200)
     CustomCrossHairScale=0.000000	 
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=3
     GroupOffset=2	 
     PlayerViewOffset=(X=-2.500000,Y=12.000000,Z=-15.000000)
     AttachmentClass=Class'BWBPRecolorsPro.MP40Attachment'
     IconMaterial=Texture'BallisticUI.Icons.SmallIcon_MP40'
     IconCoords=(X2=127,Y2=31)
     ItemName="MP40"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticRecolorsAnims.MP40_FP'
     DrawScale=0.30000
     AmbientGlow=5
	 Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticRecolorsTex.MP40.MP40-Main'
	 Skins(2)=Texture'BallisticRecolorsTex.MP40.MP40-Mag'
}
