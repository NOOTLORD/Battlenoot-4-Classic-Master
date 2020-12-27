//=============================================================================
// Weapon class for the Fifty-9 SMG
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class Fifty9SMG extends BallisticWeapon;

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
	 PlayerSpeedFactor=1.050000
     PlayerJumpFactor=1.050000
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_Fifty9'
     BigIconCoords=(Y1=24)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	 InventorySize=8	 
     bWT_Machinegun=True
     SpecialInfo(0)=(Info="120.0;10.0;0.8;40.0;0.0;0.4;-999.0")
     BringUpSound=(Sound=Sound'BallisticProSounds.XK2.XK2-Pullout',Volume=0.325000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     PutDownSound=(Sound=Sound'BallisticProSounds.XK2.XK2-Putaway',Volume=0.325000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     MagAmmo=25
     CockAnimRate=1.250000	 
     CockSound=(Sound=Sound'BallisticProSounds.Fifty-9.Fifty-9-Cock',Volume=0.900000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ReloadAnimRate=1.250000
     ClipOutSound=(Sound=Sound'BallisticProSounds.Fifty-9.Fifty-9-ClipOut',Volume=0.900000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipInSound=(Sound=Sound'BallisticProSounds.Fifty-9.Fifty-9-ClipIn',Volume=0.900000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipInFrame=47.000000
     WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0	
     bNoCrosshairInScope=True
	 SightZoomFactor=0
	 SightPivot=(Pitch=512)
     SightOffset=(X=-10.000000,Z=12.00000)
     SightDisplayFOV=60.000000
     SightingTime=0.200000
     GunLength=64.000000
     LongGunPivot=(Pitch=-4000,Yaw=-12000)
     LongGunOffset=(X=5.000000,Y=10.000000,Z=-11.000000)		 
     CrouchAimFactor=1.000000
	 SightAimFactor=2.000000
	 HipRecoilFactor=1.000000
     SprintChaos=0.100000	 
     SprintOffSet=(Pitch=-3000,Yaw=-4000)
     AimSpread=16
     ChaosDeclineTime=0.450000	 
     ChaosSpeedThreshold=7500.000000
     ChaosAimSpread=768	 
     RecoilXCurve=(Points=(,(InVal=0.200000),(InVal=0.400000,OutVal=0.100000),(InVal=0.600000,OutVal=-0.100000),(InVal=0.800000,OutVal=0.200000),(InVal=1.000000,OutVal=-0.200000)))
     RecoilYCurve=(Points=(,(InVal=0.200000,OutVal=0.150000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
     RecoilPitchFactor=1.000000
     RecoilYawFactor=1.000000
     RecoilXFactor=0.250000
     RecoilYFactor=0.300000
	 RecoilMax=6144	 
	 RecoilDeclineTime=0.50000
	 RecoilDeclineDelay=0.220000
     SelectAnimRate=1.000000
     PutDownAnimRate=1.000000	
     PutDownTime=0.400000
     BringUpTime=0.500000
     DisplayFOV=60.000000
     Priority=31	 
     FireModeClass(0)=Class'BallisticProV55.Fifty9PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
	 AIRating=0.850000
	 CurrentRating=0.850000	 
     AmmoClass(0)=Class'BallisticProV55.Ammo_Fifty9SMG'
     AmmoClass(1)=Class'BallisticProV55.Ammo_Fifty9SMG'	 
     Description="Fifty-9"
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=2 
     PlayerViewOffset=(X=21.000000,Y=10.500000,Z=-9.500000)
     AttachmentClass=Class'BallisticProV55.Fifty9Attachment'
     IconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_Fifty9'
     IconCoords=(X2=127,Y2=31)
     ItemName="Fifty-9"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticProAnims.Fifty-9_FP'
     DrawScale=0.300000
     AmbientGlow=5
	 Skins(0)=Shader'BallisticProTex.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticProTex.Fifty-9.Fifty-9-Main'
}
