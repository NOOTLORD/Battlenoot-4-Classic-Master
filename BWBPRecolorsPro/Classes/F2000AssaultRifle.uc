//=============================================================================
// Weapon class for F2000 Assault Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class F2000AssaultRifle extends BallisticWeapon;

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

	return class'BUtil'.static.DistanceAtten(Rating, 0.5, Dist, BallisticRangeAttenFire(BFireMode[0]).CutOffStartRange, BallisticRangeAttenFire(BFireMode[0]).CutOffDistance); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.4;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.4;	}
// End AI Stuff =====

defaultproperties
{
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_F2000'
     BigIconCoords=(X1=32,Y1=40,X2=475)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     bWT_Machinegun=True	 
     ManualLines(0)="Powerful 5.56mm fire. Has a fast fire rate and high sustained DPS, but excessive recoil."
     ManualLines(1)="Launches a cryogenic grenade. Upon impact, freezes nearby enemies, slowing their movement. The effect is proportional to their distance from the epicentre. This attack will also extinguish the fires of an FP7 grenade."
     ManualLines(2)="The Weapon Special key attaches a suppressor. This reduces the recoil, but also the effective range. The flash is removed and the gunfire becomes less audible.||Effective at close to medium range."
     BringUpSound=(Sound=Sound'BallisticSounds2.M50.M50Pullout',Volume=0.425000)
     PutDownSound=(Sound=Sound'BallisticSounds2.M50.M50Putaway',Volume=0.425000)
     ReloadAnimRate=1.350000	 
     CockAnimPostReload="ReloadEndCock"
     ReloadEmptyAnim="Reload"	 
     CockAnimRate=1.250000
     bCockOnEmpty=True	 
     CockSound=(Sound=Sound'BallisticRecolorsSounds.MARS.MARS-BoltPull',Volume=0.950000)
     ClipHitSound=(Sound=Sound'BallisticRecolorsSounds.MARS.MARS-MagFiddle',Volume=0.950000)
     ClipOutSound=(Sound=Sound'BallisticRecolorsSounds.MARS.MARS-MagOut',Volume=0.950000)
     ClipInSound=(Sound=Sound'BallisticRecolorsSounds.MARS.MARS-MagIn',Volume=0.950000)
     ClipInFrame=0.650000
     WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
     bNoCrosshairInScope=True
     SightOffset=(X=6.000000,Y=-6.350000,Z=23.150000)
     SightDisplayFOV=40.000000
     SprintOffSet=(Pitch=-3000,Yaw=-4096)
     AimAdjustTime=100.000000
     AimSpread=16
     AimDamageThreshold=0.000000
	 ViewRecoilFactor=1.000000	 
     ChaosDeclineTime=1.250000
     ChaosSpeedThreshold=7500.000000
     ChaosAimSpread=3072
     RecoilXCurve=(Points=(,(InVal=0.100000,OutVal=0.070000),(InVal=0.250000,OutVal=0.250000),(InVal=0.500000,OutVal=0.050000),(InVal=0.650000,OutVal=-0.200000),(InVal=0.900000,OutVal=-0.100000),(InVal=1.000000)))
     RecoilYCurve=(Points=(,(InVal=0.200000,OutVal=0.250000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.200000
     RecoilYFactor=0.200000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.140000
     FireModeClass(0)=Class'BWBPRecolorsPro.F2000PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     PutDownTime=0.700000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.750000
     CurrentRating=0.750000
     bCanThrow=False
     AmmoClass(0)=Class'BWBPRecolorsPro.Ammo_F2000_Rifle'
     AmmoClass(1)=Class'BWBPRecolorsPro.Ammo_F2000_Rifle'	 
     Description="The 3 variant of the Modular Assault Rifle System is one of many rifles built under NDTR Industries' MARS project. The project, which was aimed to produce a successor to the army's current M50 and M30 rifles, has produced a number of functional prototypes. ||The 3 variant is a short barreled model designed for CQC use with non-standard ammunition. Field tests have shown excellent results when loaded with Snowstorm or Firestorm rounds, and above-average performance with Zero-G, toxic and electro rounds. This specific MARS-3 is loaded with Snowstorm XII rounds and is set to fire at a blistering 850 RPM. Enemies hit with this ammunition will be chilled and slowed."
     Priority=65
     HudColor=(B=255,G=200,R=200)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=3
     PlayerViewOffset=(X=8.000000,Y=13.000000,Z=-18.000000)
     AttachmentClass=Class'BWBPRecolorsPro.F2000Attachment'
     IconMaterial=Texture'BallisticUI.Icons.SmallIcon_F2000'
     IconCoords=(X2=127,Y2=31)
     ItemName="F2000 Assault Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticRecolorsAnims.F2000_FP'
     DrawScale=0.300000
     AmbientGlow=5
}
