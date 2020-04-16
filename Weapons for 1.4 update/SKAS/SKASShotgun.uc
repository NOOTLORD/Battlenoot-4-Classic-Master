//=============================================================================
// Weapon class for SKAS-21 Shotgun
//
// by Nolan "Dark Carnivour" Richert
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD 
//=============================================================================
class SKASShotgun extends BallisticProShotgun;

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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, 768, 1536); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	if (AIController(Instigator.Controller) == None)
		return 0.5;
	return AIController(Instigator.Controller).Skill / 7;
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
	local Bot B;
	local float Result, Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return -0.5;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	Result = -1 * (B.Skill / 6);
	Result *= (1 - (Dist/4000));
    return FClamp(Result, -1.0, -0.3);
}

// End AI Stuff =====

defaultproperties
{
     ManualLines(0)="Automatic fire has moderate spread, moderate damage, short range and fast fire rate.||Manual fire has tight spread, long range, good damage and low fire rate."
     ManualLines(1)="Multi-shot attack. Loads a shell into each of the barrels, then fires them all at once. Very high damage, short range and wide spread."
     ManualLines(2)="Extremely effective at close range."
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny',SkinNum=2)
     TeamSkins(1)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny',SkinNum=3)
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_SKAS'
     BigIconCoords=(Y1=24)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Shotgun=True
     bWT_Machinegun=True
     BringUpSound=(Sound=Sound'BallisticSounds2.M763.M763Pullout',Volume=0.475000)
     PutDownSound=(Sound=Sound'BallisticSounds2.M763.M763Putaway',Volume=0.475000)
     MagAmmo=12
     CockAnimRate=1.250000
     CockSound=(Sound=Sound'BallisticRecolorsSounds.SKAS.SKAS-CockLong',Volume=1.100000)
     ReloadAnimRate=1.550000
     ClipOutSound=(Sound=Sound'BallisticRecolorsSounds.SKAS.SKAS-ClipOut1',Volume=1.100000)
     ClipInSound=(Sound=Sound'BallisticRecolorsSounds.SKAS.SKAS-ClipIn',Volume=1.100000)
     ClipInFrame=0.650000
     bCockOnEmpty=True
     WeaponModes(0)=(ModeName="Automatic",ModeID="WM_FullAuto")
	 WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True) 
     CurrentWeaponMode=0
     bNotifyModeSwitch=True
     bNoCrosshairInScope=True
     SightPivot=(Pitch=1024)
     SightOffset=(X=-20.000000,Y=9.700000,Z=17.849998)
	 SightZoomFactor=0
     GunLength=32.000000
     SprintOffSet=(Pitch=-1000,Yaw=-2048)
     AimAdjustTime=100.000000
     AimSpread=0
     AimDamageThreshold=0.000000
     ChaosDeclineTime=0.800000
     ChaosSpeedThreshold=3000.000000
     ChaosAimSpread=0
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
     RecoilYCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.350000
     RecoilYFactor=0.350000
     RecoilMinRandFactor=0.350000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.450000
     FireModeClass(0)=Class'BWBPRecolorsPro.SKASPrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     IdleAnimRate=0.100000
     PutDownTime=0.700000
     AIRating=0.850000
     CurrentRating=0.850000
     bShowChargingBar=False
     bCanThrow=False
     AmmoClass(0)=Class'BWBPRecolorsPro.Ammo_SKAS_Shotgun'
     Description="SKAS-21 Super Shotgun||Manufacturer: UTC Defense Tech|Primary: Variable Fire Buckshot|Secondary: Tri-Barrel Blast"
     Priority=245
     HudColor=(B=255,G=200,R=200)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=3
     GroupOffset=4
     PlayerViewOffset=(X=-4.000000,Y=1.000000,Z=-10.000000)
     AttachmentClass=Class'BWBPRecolorsPro.SKASAttachment'
     IconMaterial=Texture'BallisticUI.Icons.SmallIcon_SKAS'
     IconCoords=(X2=127,Y2=30)
     ItemName="SKAS-21 Shotgun"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticRecolorsAnims.SKAS_FP'
     DrawScale=0.260000
     AmbientGlow=5
}
