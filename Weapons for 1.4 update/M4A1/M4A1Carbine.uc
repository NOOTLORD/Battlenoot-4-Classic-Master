//=============================================================================
// Weapon class for the M4A1 Carbine
//
// by Sarge.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class M4A1Carbine extends BallisticWeapon;

// Change some properties when using sights...
simulated function SetScopeBehavior()
{
	super.SetScopeBehavior();
	bUseNetAim = default.bUseNetAim || bScopeView;
	if (bScopeView)
	{
//		SightAimFactor = 0.0;
        	FireMode[0].FireAnim='SightFire';
	}
	else
	{
//		SightAimFactor = default.ViewRecoilFactor;
        	FireMode[0].FireAnim='Fire';
	}
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
function float SuggestDefenseStyle()	{	return 0.5;	}

// End AI Stuff =====

defaultproperties
{
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_M4'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'	 
     bWT_Bullet=True
     SpecialInfo(0)=(Info="240.0;20.0;0.9;75.0;0.8;0.7;0.2")
     BringUpSound=(Sound=Sound'BallisticRecolorsSounds.M4A1.M4A1-PullOut',Volume=2.200000)
     PutDownSound=(Sound=Sound'BallisticRecolorsSounds.M4A1.M4A1-Putaway',Volume=2.200000)
     MagAmmo=30	 
     CockSound=(Sound=Sound'BallisticRecolorsSounds.M4A1.M4A1-Cock',Volume=2.200000)
     ClipHitSound=(Sound=Sound'BallisticRecolorsSounds.M4A1.M4A1-MagIn',Volume=4.800000)
     ClipOutSound=(Sound=Sound'BallisticRecolorsSounds.M4A1.M4A1-MagOut',Volume=4.800000)
     ClipInFrame=0.650000
	 bCockOnEmpty=True
     ReloadEmptyAnim="Reload" 	 
     WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
     bNoCrosshairInScope=False
     SightOffset=(Y=-6.450000,Z=20.500000)
     SightDisplayFOV=40.000000
     SightingTime=0.300000
     SprintOffSet=(Pitch=-3500,Yaw=-3000,Roll=3000)
     AimAdjustTime=100.000000
     AimSpread=16
     AimDamageThreshold=0.000000
	 ViewRecoilFactor=1.000000	 
     ChaosDeclineTime=1.250000
     ChaosSpeedThreshold=15000.000000
     ChaosAimSpread=3072
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.400000),(InVal=1.000000,OutVal=-0.200000)))
     RecoilYCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.650000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.200000
     RecoilYFactor=0.350000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.100000
     FireModeClass(0)=Class'BWBPRecolorsPro.M4A1PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'	 
     IdleAnimRate=0.500000
     SelectAnimRate=1.660000
     PutDownAnimRate=1.330000
     PutDownTime=0.400000
     BringUpTime=0.450000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000 
     CurrentRating=0.600000
     AmmoClass(0)=Class'BWBPRecolorsPro.Ammo_M4A1_Rifle'
     AmmoClass(1)=Class'BWBPRecolorsPro.Ammo_M4A1_Rifle'	 
	 Description="M4A1 Carbine"
	 Priority=42
     HudColor=(B=255,G=200,R=200)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=3
     PlayerViewOffset=(X=-6.000000,Y=10.000000,Z=-14.000000)
     AttachmentClass=Class'BWBPRecolorsPro.M4A1Attachment'
     IconMaterial=Texture'BallisticUI.Icons.SmallIcon_M4'
     IconCoords=(X2=127,Y2=31)
     ItemName="M4A1 Carbine"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticRecolorsAnims.M4A1Carbine_FP'
     DrawScale=0.300000
     AmbientGlow=5
	 Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticRecolorsTex.M4A1.M4_Black'
	 Skins(2)=Texture'BallisticRecolorsTex.LK05.LK05-Bullets'
	 Skins(3)=Texture'BallisticRecolorsTex.LK05.LK05-EOTech-RDS'
}
