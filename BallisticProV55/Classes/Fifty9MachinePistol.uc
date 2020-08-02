//=============================================================================
// Weapon class for the Fifty-9 Machine Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class Fifty9MachinePistol extends BallisticWeapon;

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

	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, 768, 2048); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.9;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.9;	}

// End AI Stuff =====

defaultproperties
{
	 AIRating=0.85
	 CurrentRating=0.85
     PlayerSpeedFactor=1.100000
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_Fifty9'
     BigIconCoords=(Y1=24)
     SightFXClass=Class'BallisticProV55.Fifty9SightLEDs'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     bWT_Machinegun=True
     SpecialInfo(0)=(Info="120.0;10.0;0.8;40.0;0.0;0.4;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Pullout',Volume=0.325000)
     PutDownSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Putaway',Volume=0.325000)
     MagAmmo=25
     CockSound=(Sound=Sound'BallisticSounds2.UZI.UZI-Cock',Volume=0.900000)
     ClipHitSound=(Volume=0.600000)
     ClipOutSound=(Sound=Sound'BallisticSounds2.UZI.UZI-ClipOut',Volume=0.900000)
     ClipInSound=(Sound=Sound'BallisticSounds2.UZI.UZI-ClipIn',Volume=0.900000)
     ClipInFrame=0.650000
     bCockOnEmpty=True
     WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0	
     bNoCrosshairInScope=True
	 SightPivot=(Pitch=512)
     SightOffset=(X=-10.000000,Z=12.00000)
     SightDisplayFOV=60.000000
     SightingTime=0.200000
	 SightZoomFactor=0
     CrouchAimFactor=0.750000
     SightAimFactor=0.500000
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
     RecoilDeclineDelay=0.120000
     FireModeClass(0)=Class'BallisticProV55.Fifty9PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     PutDownTime=0.400000
     BringUpTime=0.500000
     SelectForce="SwitchToAssaultRifle"
     AmmoClass(0)=Class'BallisticProV55.Ammo_Fifty_SMG'
     AmmoClass(1)=Class'BallisticProV55.Ammo_Fifty_SMG'	 
     Description="Fifty-9"
     Priority=31
     HudColor=(B=255,G=200,R=200)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=2
     PlayerViewOffset=(X=21.000000,Y=10.500000,Z=-9.500000)
     AttachmentClass=Class'BallisticProV55.Fifty9Attachment'
     IconMaterial=Texture'BallisticUI.Icons.SmallIcon_Fifty9'
     IconCoords=(X2=127,Y2=31)
     ItemName="Fifty-9"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticAnims2.UZI_FP'
     DrawScale=0.300000
     AmbientGlow=5
	 Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticWeapons2.Fifty9.Fifty9Skin'
}
