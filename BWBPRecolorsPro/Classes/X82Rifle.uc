//=============================================================================
// X82Rifle.
//
// BARRET Assault Rifle, aka thez Z. BArrate SOmepre rFIle. Good vs vars.
// Has underslung rifle. It also comes with MEAT VISION, btw.
//
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
     ManualLines(0)="High-powered .50 rifle fire. High damage and fire rate, but strong recoil."
     ManualLines(1)="Deploys the rifle upon the ground or a nearby wall. May also be deployed upon sandbags. Whilst deployed, becomes perfectly accurate, loses its iron sights and gains a reduction in recoil. Locational damage (damage which can target an area on the body) taken from the front is significantly reduced."
     ManualLines(2)="Weapon Function activates infrared vision. Viable infantry targets will be bordered by a box in the weapon's scope.||Effective at long range. Very effective at long range when deployed."																																																			   
     PlayerSpeedFactor=0.800000
     PlayerJumpFactor=0.800000
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny',SkinNum=3)
     BigIconMaterial=Texture'BallisticRecolors3TexPro.X82.BigIcon_X82'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     SpecialInfo(0)=(Info="360.0;35.0;1.0;80.0;10.0;0.0;0.0")
     BringUpSound=(Sound=Sound'BWBP4-Sounds.MRL.MRL-BigOn',Volume=0.200000)
     PutDownSound=(Sound=Sound'BWBP4-Sounds.MRL.MRL-BigOff',Volume=0.200000)
     MagAmmo=5
     CockAnimPostReload="Cock"
     CockSound=(Sound=Sound'PackageSounds4Pro.X82.X83-Charge',Volume=0.750000)
     ReloadAnimRate=0.400000
     ClipHitSound=(Sound=Sound'PackageSounds4Pro.X82.X83-In',Volume=0.750000)
     ClipOutSound=(Sound=Sound'PackageSounds4Pro.X82.X83-Out',Volume=0.750000)
     ClipInSound=(Volume=0.750000)
     ClipInFrame=0.850000
     bCockOnEmpty=True
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)									   									   
     CurrentWeaponMode=0
     ZoomType=ZT_Logarithmic
     ScopeXScale=1.333300
     ScopeViewTex=Texture'BallisticRecolors3TexPro.X82.X82ScopeView'
     ZoomInSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
     ZoomOutSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
     FullZoomFOV=20.000000
     bNoMeshInScope=True
     bNoCrosshairInScope=True
     SightPivot=(Roll=-1024)
     SightOffset=(X=13.000000,Y=-1.600000,Z=7.200000)
     SightingTime=0.650000
     MinZoom=2.000000
     MaxZoom=32.000000
     ZoomStages=10
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
     SelectAnim="Takeout"
     PutDownAnim="PutDown"
     IdleAnimRate=0.040000
     SelectAnimRate=0.500000
     PutDownAnimRate=0.400000
     PutDownTime=0.400000
     BringUpTime=1.200000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.80000
     CurrentRating=0.800000
     bSniping=True
     bCanThrow=False
     AmmoClass(0)=Class'BWBPRecolorsPro.Ammo_X82rifle'
     Description="X83 Anti-Material Rifle||Manufacturer: Evravion Combat Solutions |Primary: Single Powerful Shot|Secondary: Activate Zooming Scope|Special: (Scoped) Activate Night Vision/Detector|Special: (Unscoped) Mount X-83 A1||Enravion's high powered X-83 A1 Anti-Material Rifle is a fearsome sight on the modern day battlefield. With an effective range of about 1.1 miles, the X-83 can target and eliminate infantry and light vehicles with ease and at range using its specialized .50 cal N6-BMG HEAP rounds. This special operations weapon, designed to disable key targets like parked aircraft and APCs, was used extensively prior to the Skrith wars."
     DisplayFOV=55.000000
     Priority=207
     HudColor=(B=175,G=175,R=175)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=9
     GroupOffset=5
     PlayerViewOffset=(X=4.000000,Y=6.000000,Z=-7.500000)
     BobDamping=1.800000
     AttachmentClass=Class'BWBPRecolorsPro.X82Attachment'
     IconMaterial=Texture'BallisticRecolors3TexPro.X82.SmallIcon_X82'
     IconCoords=(X2=127,Y2=31)
     ItemName="X83 Sniper Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=5.000000
     Mesh=SkeletalMesh'BallisticRecolors4AnimPro.X83A1_1st'
     DrawScale=0.450000
     Skins(0)=Shader'BallisticRecolors3TexPro.X82.X82SkinShine'
     Skins(1)=Texture'UT2004Weapons.Pickups.ClassicSniperAmmoT'
     Skins(2)=Shader'BallisticRecolors3TexPro.X82.X82SkinShine'
     Skins(3)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
     AmbientGlow=0
}
