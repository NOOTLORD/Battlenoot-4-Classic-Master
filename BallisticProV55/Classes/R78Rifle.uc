//=============================================================================
// Weapon class for R78 Sniper Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class R78Rifle extends BallisticWeapon;

// Animation notify for when cocking action starts. Used to time sounds
simulated function Notify_CockAimed()
{
	bNeedCock = False;
	ReloadState = RS_Cocking;
	PlayOwnedSound(CockSound.Sound,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
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

	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.5, Dist, 2048, 3072); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.9;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.9;	}

// End AI Stuff =====

defaultproperties
{
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_R78'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     SpecialInfo(0)=(Info="240.0;25.0;0.5;60.0;10.0;0.0;0.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.R78.R78Pullout',Volume=0.395000)
     PutDownSound=(Sound=Sound'BallisticSounds2.R78.R78Putaway',Volume=0.395000)
	 PutDownTime=0.5
     MagAmmo=7
     CockAnim="Cock"
	 CockAnimRate=1.250000	
     CockSound=(Sound=Sound'BallisticSounds2.R78.R78-Cock',Volume=1.000000)
     ReloadAnimRate=1.250000
     ClipHitSound=(Sound=Sound'BallisticSounds2.R78.R78-ClipHit',Volume=1.000000)
     ClipOutSound=(Sound=Sound'BallisticSounds2.R78.R78-ClipOut',Volume=1.000000)
     ClipInSound=(Sound=Sound'BallisticSounds2.R78.R78-ClipIn',Volume=1.000000)
     ClipInFrame=0.650000
     bCockOnEmpty=True
     WeaponModes(0)=(ModeName="Bolt-Action",ModeID="WM_SemiAuto",)
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
     ZoomType=ZT_Fixed
     ScopeXScale=1.333000
     ZoomInAnim="ZoomIn"
     ScopeViewTex=Texture'BallisticUI.R78.RifleScopeView'
     ZoomInSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
     ZoomOutSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
     FullZoomFOV=50.000000
     bNoMeshInScope=True
     bNoCrosshairInScope=True
     SightPivot=(Roll=-1024)
     SightOffset=(X=10.000000,Y=-1.600000,Z=17.000000)
     SightingTime=0.450000
     MinZoom=2.000000
     MaxZoom=2.000000	 
     ZoomStages=0
     GunLength=80.000000
     CrouchAimFactor=0.600000
     SightAimFactor=0.150000
     SprintOffSet=(Pitch=-1000,Yaw=-2048)
     AimAdjustTime=100.000000
     AimSpread=192
     AimDamageThreshold=0.000000
     ChaosSpeedThreshold=2400.000000
     ChaosAimSpread=2048
     RecoilYawFactor=0.100000
     RecoilXFactor=0.40000
     RecoilYFactor=0.300000
     RecoilDeclineTime=1.000000
     FireModeClass(0)=Class'BallisticProV55.R78PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     BringUpTime=0.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.800000
     CurrentRating=0.800000
     bSniping=True
     bCanThrow=False
     AmmoClass(0)=Class'BallisticProV55.Ammo_R78_Sniper'
     AmmoClass(1)=Class'BallisticProV55.Ammo_R78_Sniper'	 
     Description="R78A1 Sniper Rifle"
     DisplayFOV=55.000000
     Priority=33
     HudColor=(B=255,G=200,R=200)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=1
     GroupOffset=2
     PlayerViewOffset=(X=12.000000,Y=9.500000,Z=-11.500000)
     AttachmentClass=Class'BallisticProV55.R78Attachment'
     IconMaterial=Texture'BallisticUI.Icons.SmallIcon_R78'
     IconCoords=(X2=127,Y2=31)
     ItemName="R78A1"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticAnims2.R78_FP'
     DrawScale=0.450000
     AmbientGlow=5
	 Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticWeapons2.R78.RifleSkin'
	 Skins(2)=Texture'BallisticWeapons2.R78.ScopeSkin'
}
