//=============================================================================
// Weapon class for M46 Assault Rifle 
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class M46AssaultRifleQS extends BallisticWeapon;


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
defaultproperties
{
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_M46'
     BigIconCoords=(Y1=40,Y2=235)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     bWT_Machinegun=True	 
     ManualLines(0)="Automatic battle rifle fire. Moderate damage per shot with greater range and penetration than assault rifles. Recoil is moderate."
     ManualLines(1)="Deploys a mine. These mines can be detonated with the Weapon Function key shortly after being placed for severe damage. Mines can be picked up with the Use key."
     ManualLines(2)="Effective at medium to long range."
     SpecialInfo(0)=(Info="240.0;25.0;0.9;70.0;0.9;0.2;0.7")
     BringUpSound=(Sound=Sound'BallisticSounds2.M50.M50Pullout',Volume=0.415000)
     PutDownSound=(Sound=Sound'BallisticSounds2.M50.M50Putaway',Volume=0.415000)
     MagAmmo=25
     CockAnimPostReload="ReloadEndCock"
     CockAnimRate=1.250000	 																																									   																					   						  
     CockSound=(Sound=Sound'BallisticSounds1.OA-AR.OA-AR_Cock',Volume=0.800000)
     ReloadAnimRate=1.250000						
     ClipHitSound=(Sound=Sound'BallisticSounds1.OA-AR.OA-AR_ClipHit',Volume=0.800000)
     ClipOutSound=(Sound=Sound'BallisticSounds1.OA-AR.OA-AR_ClipOut',Volume=0.800000)
     ClipInSound=(Sound=Sound'BallisticSounds1.OA-AR.OA-AR_ClipIn',Volume=0.800000)
     bCockOnEmpty=True
     ClipInFrame=0.700000		
     WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
     ZoomType=ZT_Irons
     ZoomInAnim=
     ZoomOutAnim=
     ScopeViewTex=None
     bNoMeshInScope=False
     bNoCrosshairInScope=True							 
     SightPivot=(Pitch=-300,Roll=0)
     SightOffset=(X=-10.000000,Y=0.000000,Z=11.550000)
     SightDisplayFOV=35.000000
     SightingTime=0.350000
     SightAimFactor=0.200000
     SprintOffSet=(Pitch=-3000,Yaw=-4000)										 
     AimAdjustTime=100.000000
     AimDamageThreshold=0.000000
     ChaosSpeedThreshold=15000.000000
     AimSpread=16
     ChaosDeclineTime=1.250000
     ChaosAimSpread=3072
     RecoilXCurve=(Points=(,(InVal=0.080000),(InVal=0.150000,OutVal=0.050000),(InVal=0.300000,OutVal=-0.100000),(InVal=0.600000,OutVal=0.150000),(InVal=0.800000,OutVal=-0.150000),(InVal=1.000000)))
     RecoilYCurve=(Points=(,(InVal=0.150000,OutVal=0.120000),(InVal=0.300000,OutVal=0.350000),(InVal=0.500000,OutVal=0.600000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.250000
     RecoilYFactor=0.250000
     RecoilDeclineDelay=0.200000																																																															 																																																  						   						   								
     FireModeClass(0)=Class'BallisticProV55.M46PrimaryFireQS'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     bCanThrow=False
     AmmoClass(0)=Class'BallisticProV55.Ammo_M46_Rifle'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.700000
     CurrentRating=0.700000
     Description="The M46 was one of Black & Wood's first forays into high powered assault weaponry, specifically rifles. As with all of Black & Wood's weapons, the 'Jackal' is incredibly reliable and tough. Used by certain Terran units, the M46 is typically equipped with a short-range optical scope and often various Grenade Launcher attachments. While not quite yet a widely used weapon, its reputation has grown in recent times as heroic stories of Armoured Squadron 190's use of it has spread amongst the bulk of the UTC troops."
     DisplayFOV=55.000000																																																																																																																																					  						 
     Priority=41
     HudColor=(B=255,G=200,R=200)	 
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=3															 					 
     GroupOffset=1
     PlayerViewOffset=(X=5.000000,Y=4.750000,Z=-8.000000)
     PlayerViewPivot=(Pitch=384)														 								
     AttachmentClass=Class'BallisticProV55.M46AttachmentQS'
     IconMaterial=Texture'BallisticUI.Icons.SmallIcon_M46'
     IconCoords=(X2=127,Y2=31)																								  
     ItemName="M46 Assault Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000					   																									   						 
     Mesh=SkeletalMesh'BallisticAnims1.OA-AR-RDS'
     DrawScale=0.300000	 
     AmbientGlow=5
}
