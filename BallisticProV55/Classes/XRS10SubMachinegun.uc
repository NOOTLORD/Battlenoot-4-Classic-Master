//=============================================================================
// Weapon class for XRS10 SubMachinegun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class XRS10SubMachinegun extends BallisticWeapon;

simulated function PlayIdle()
{
	super.PlayIdle();

	if (!bPendingSightUp || SightingState != SS_None || bScopeView || !CanPlayAnim(IdleAnim, ,"IDLE"))
		return;
	FreezeAnimAt(0.0);
}

// Change some properties when using sights...
simulated function SetScopeBehavior()
{
	super.SetScopeBehavior();

	bUseNetAim = default.bUseNetAim || bScopeView;
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
function float SuggestAttackStyle()	{	return 0.8;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.8;	}

// End AI Stuff =====

defaultproperties
{
	 AIRating=0.85
	 CurrentRating=0.85
     PlayerSpeedFactor=1.100000
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_XRS10'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     bWT_Machinegun=True
     SpecialInfo(0)=(Info="60.0;5.0;0.4;-1.0;0.0;0.2;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Pullout',Volume=0.325000)
     PutDownSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Putaway',Volume=0.325000)
     MagAmmo=25
     CockSound=(Sound=Sound'BallisticSounds1.TEC.TEC-Cock',Volume=0.850000)
     ClipOutSound=(Sound=Sound'BallisticSounds1.TEC.TEC-Clipout',Volume=0.850000)
     ClipInSound=(Sound=Sound'BallisticSounds1.TEC.TEC-Clipin',Volume=0.850000)
     ClipInFrame=0.650000
     bCockOnEmpty=True
     WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
     bNoCrosshairInScope=True
     SightOffset=(X=-10.000000,Z=12.200000)
	 SightPivot=(Pitch=512)
     SightDisplayFOV=50.000000
     SightingTime=0.250000
     SightAimFactor=0.200000
	 SightZoomFactor=0
     HipRecoilFactor=2.250000
     SprintOffSet=(Pitch=-3000,Yaw=-4000)
     AimAdjustTime=100.000000
     AimSpread=16
     AimDamageThreshold=0.000000
     ChaosSpeedThreshold=7500.000000
     RecoilXCurve=(Points=(,(InVal=0.200000),(InVal=0.400000,OutVal=0.100000),(InVal=0.600000,OutVal=-0.100000),(InVal=0.800000,OutVal=0.200000),(InVal=1.000000,OutVal=-0.200000)))
     RecoilYCurve=(Points=(,(InVal=0.200000,OutVal=0.150000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.250000
     RecoilYFactor=0.300000
     RecoilMax=6144.000000
     RecoilDeclineTime=1.200000
     RecoilDeclineDelay=0.125000
     FireModeClass(0)=Class'BallisticProV55.XRS10PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     SelectForce="SwitchToAssaultRifle"
     AmmoClass(0)=Class'BallisticProV55.Ammo_XRS10_SMG'
     AmmoClass(1)=Class'BallisticProV55.Ammo_XRS10_SMG'	 
     Description="XRS-10 Submachine gun"
     Priority=27
     HudColor=(B=255,G=200,R=200)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=2
     PlayerViewOffset=(X=10.000000,Y=12.000000,Z=-9.500000)
     AttachmentClass=Class'BallisticProV55.XRS10Attachment'
     IconMaterial=Texture'BallisticUI.Icons.SmallIcon_XRS10'
     IconCoords=(X2=127,Y2=31)
     ItemName="XRS-10"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticAnims1.XRS10_FP'
     DrawScale=0.200000
     AmbientGlow=5
	 Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticWeapons1.XRS10.XRS10Skin'
}
