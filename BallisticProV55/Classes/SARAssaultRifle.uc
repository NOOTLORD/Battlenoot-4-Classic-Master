//=============================================================================
// Weapon class for Sub Assault Rifle
//
// Highly compact, but innacurate assault rifle with switchable stock,
// flash, large mag, quick reloading and red-dot sights.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class SARAssaultRifle extends BallisticWeapon;

// This uhhh... thing is added to allow manual drawing of brass OVER the muzzle flash
struct UziBrass
{
	var() actor Actor;
	var() float KillTime;
};
var   array<UziBrass>	UziBrassList;

simulated event RenderOverlays( Canvas Canvas )
{
	local int i;

	super.RenderOverlays(Canvas);

	if (UziBrassList.length < 1)
		return;

    bDrawingFirstPerson = true;
    for (i=UziBrassList.length-1;i>=0;i--)
    {
    	if (UziBrassList[i].Actor == None)
    		continue;
	    Canvas.DrawActor(UziBrassList[i].Actor, false, false, Instigator.Controller.FovAngle);
    	if (UziBrassList[i].KillTime <= level.TimeSeconds)
    	{
    		UziBrassList[i].Actor.bHidden=false;
    		UziBrassList.Remove(i,1);
    	}
    }
    bDrawingFirstPerson = false;
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
function float SuggestAttackStyle()	{	return 0.4;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.4;	}

// End AI Stuff =====

defaultproperties
{
	 AIRating=0.72
	 CurrentRating=0.72
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_SAR'
     BigIconCoords=(Y1=24,Y2=250)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     SightFXClass=Class'BallisticProV55.SARSightDot'	 
     bWT_Bullet=True
     bWT_Machinegun=True
     SpecialInfo(0)=(Info="240.0;25.0;0.8;90.0;0.0;1.0;0.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.M50.M50Pullout',Volume=0.375000)
     PutDownSound=(Sound=Sound'BallisticSounds2.M50.M50Putaway',Volume=0.375000)
     MagAmmo=40
     CockAnimPostReload="ReloadEndCock"
     CockAnimRate=1.250000
     CockSound=(Sound=Sound'BallisticSounds2.SAR.SAR-Cock',Volume=0.900000)
     ReloadAnimRate=1.100000
     ClipHitSound=(Volume=0.625000)
     ClipOutSound=(Sound=Sound'BallisticSounds2.SAR.SAR-ClipOut',Volume=0.900000)
     ClipInSound=(Sound=Sound'BallisticSounds2.SAR.SAR-ClipIn',Volume=0.900000)
     ClipInFrame=0.650000
     bCockOnEmpty=True
     WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
     bNoCrosshairInScope=True
     SightPivot=(Pitch=350)
     SightOffset=(X=20.000000,Y=-0.010000,Z=12.400000)
     SightDisplayFOV=40.000000
     SightingTime=0.250000
     GunLength=16.000000
     CrouchAimFactor=1.000000
     SightAimFactor=0.200000
     SprintOffSet=(Pitch=-3000,Yaw=-4000)
     AimAdjustTime=100.000000
     AimSpread=12
     AimDamageThreshold=0.000000
     ChaosDeclineTime=1.250000
     ChaosSpeedThreshold=15000.000000
     ChaosAimSpread=2000
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=-0.060000),(InVal=0.400000,OutVal=0.110000),(InVal=0.500000,OutVal=-0.120000),(InVal=0.600000,OutVal=0.130000),(InVal=0.800000,OutVal=0.160000),(InVal=1.000000)))
     RecoilYCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.230000),(InVal=0.400000,OutVal=0.360000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.250000
     RecoilYFactor=0.250000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.150000
     FireModeClass(0)=Class'BallisticProV55.SARPrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     SelectForce="SwitchToAssaultRifle"
     AmmoClass(0)=Class'BallisticProV55.Ammo_SAR_Rifle'
     AmmoClass(1)=Class'BallisticProV55.Ammo_SAR_Rifle'	 
     Description="Sub-Assault Rifle"
     DisplayFOV=55.000000
     Priority=32
     HudColor=(B=255,G=200,R=200)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=1
     GroupOffset=4
     PlayerViewOffset=(X=14.000000,Y=13.000000,Z=-11.000000)
     AttachmentClass=Class'BallisticProV55.SARAttachment'
     IconMaterial=Texture'BallisticUI.Icons.SmallIcon_SAR'
     IconCoords=(X2=127,Y2=31)
     ItemName="Sub-Assault Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticAnims2.SAR_FP'
     DrawScale=0.300000
     AmbientGlow=5 
	 Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticWeapons2.SAR.SARSkin'
	 Skins(2)=Texture'BallisticWeapons2.SAR.SAR-SightCross'
	 
}
