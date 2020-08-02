//=============================================================================
// Weapon class for the X82 Sniper Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class X82Rifle extends BallisticWeapon;

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
function float SuggestAttackStyle()	{	return -0.8;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.8;	}

// End AI Stuff =====

defaultproperties
{																																																																																			
     PlayerSpeedFactor=0.850000
     PlayerJumpFactor=0.850000
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_X82'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     SpecialInfo(0)=(Info="360.0;35.0;1.0;80.0;10.0;0.0;0.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.R78.R78Pullout',Volume=0.425000)
     PutDownSound=(Sound=Sound'BallisticSounds2.R78.R78Putaway',Volume=0.425000)
     MagAmmo=5
     CockSound=(Sound=Sound'BallisticRecolorsSounds.X82.X82-Charge',Volume=0.850000)
     ReloadAnimRate=0.400000
     ClipHitSound=(Sound=Sound'BallisticRecolorsSounds.X82.X82-In',Volume=0.850000)
     ClipOutSound=(Sound=Sound'BallisticRecolorsSounds.X82.X82-Out',Volume=0.850000)
     ClipInFrame=0.850000
     bCockOnEmpty=True
     WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
     ZoomType=ZT_Fixed
     ScopeXScale=1.333300
     ScopeViewTex=Texture'BallisticRecolorsTex.X82.X82ScopeView'
     ZoomInSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
     ZoomOutSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
     FullZoomFOV=20.000000
     bNoMeshInScope=True
     bNoCrosshairInScope=True
     SightPivot=(Roll=-1024)
     SightOffset=(X=13.000000,Y=-1.600000,Z=7.200000)
     SightingTime=0.500000
     MinZoom=2.000000
     MaxZoom=2.000000
     ZoomStages=0
     GunLength=80.000000
     CrouchAimFactor=0.700000
     SprintOffSet=(Pitch=-1000,Yaw=-2048)
     JumpOffSet=(Pitch=-6000,Yaw=2000)
     AimAdjustTime=100.000000
     AimSpread=256
     AimDamageThreshold=0.000000
     ChaosDeclineTime=1.200000
     ChaosSpeedThreshold=800.000000
     ChaosAimSpread=3072
     RecoilXFactor=0.600000
     RecoilYFactor=0.300000
     RecoilDeclineTime=1.500000
     FireModeClass(0)=Class'BWBPRecolorsPro.X82PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     IdleAnimRate=0.040000
     SelectAnimRate=0.500000
     PutDownAnimRate=0.400000
     PutDownTime=0.400000
     BringUpTime=1.200000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.80000
     CurrentRating=0.800000
     bSniping=True
     AmmoClass(0)=Class'BWBPRecolorsPro.Ammo_X82_Sniper'
     AmmoClass(1)=Class'BWBPRecolorsPro.Ammo_X82_Sniper'	 
     DisplayFOV=55.000000
     Description="X82 Sniper Rifle"	 
     Priority=207
     HudColor=(B=255,G=200,R=200)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=1
     GroupOffset=2
     PlayerViewOffset=(X=6.000000,Y=8.000000,Z=-7.500000)
     AttachmentClass=Class'BWBPRecolorsPro.X82Attachment'
     IconMaterial=Texture'BallisticUI.Icons.SmallIcon_X82'
     IconCoords=(X2=127,Y2=31)
     ItemName="X82 Sniper Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticRecolorsAnims.X82_FP'
     DrawScale=0.450000
     AmbientGlow=5
	 Skins(0)=Texture'BallisticRecolorsTex.X82.X82Skin'
	 Skins(1)=Texture'UT2004Weapons.Pickups.ClassicSniperAmmoT'
	 Skins(2)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
}
