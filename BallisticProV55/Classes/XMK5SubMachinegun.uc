//=============================================================================
// XMK5SubMachinegun.
//
// XMK5 SubMachinegun, a powerful SubMachinegun with an attached dart launcher for stunning and poisoning your prey.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class XMK5SubMachinegun extends BallisticWeapon;

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
function float SuggestAttackStyle()	{	return 0.6;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.6;	}

// End AI Stuff =====

defaultproperties
{
     PlayerSpeedFactor=1.050000
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticTextures_25.OA-SMG.BigIcon_OASMG'
     BigIconCoords=(Y1=16,Y2=210)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     bWT_Machinegun=True
     ManualLines(0)="Automatic submachinegun fire. Higher damage per bullet than other SMGs, good range and solid DPS, but higher recoil. Penetration is acceptable."
     ManualLines(1)="Launches a stun dart. Upon impact with the enemy, deals damage over time and inflicts a blinding effect multiple times upon them."
     ManualLines(2)="Effective at close range."
     SpecialInfo(0)=(Info="180.0;15.0;0.7;60.0;0.1;0.4;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.M50.M50Pullout',Volume=0.700000)
     PutDownSound=(Sound=Sound'BallisticSounds2.M50.M50Putaway',Volume=0.700000)
     MagAmmo=32
	 AIRating=0.8
	 CurrentRating=0.8
     CockAnimPostReload="ReloadEndCock"
     CockAnimRate=1.250000
     CockSound=(Sound=Sound'BallisticSounds_25.OA-SMG.OA-SMG_Cock',Volume=0.875000)
     ReloadAnimRate=1.250000
     ClipOutSound=(Sound=Sound'BallisticSounds_25.OA-SMG.OA-SMG_ClipOut',Volume=0.875000)
     ClipInSound=(Sound=Sound'BallisticSounds_25.OA-SMG.OA-SMG_ClipIn',Volume=0.875000)
     ClipInFrame=0.760000
     bCockOnEmpty=True
     WeaponModes(0)=(bUnavailable=True)
     WeaponModes(1)=(bUnavailable=True)
     bNoCrosshairInScope=True
     SightPivot=(Pitch=200)
	 SightZoomFactor=0
     SightOffset=(X=1.000000,Z=17.750000)
     SightDisplayFOV=40.000000
     SightingTime=0.250000
     GunLength=40.000000
     SprintOffSet=(Pitch=-3000,Yaw=-4000)
     AimAdjustTime=100.000000
     AimSpread=16
     AimDamageThreshold=0.000000
     ChaosDeclineTime=0.800000
     ChaosSpeedThreshold=7500.000000
     ChaosAimSpread=2048
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=0.050000),(InVal=0.400000,OutVal=-0.250000),(InVal=0.600000,OutVal=0.350000),(InVal=0.800000,OutVal=-0.400000),(InVal=1.000000)))
     RecoilYCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.225000,OutVal=0.450000),(InVal=0.350000,OutVal=0.600000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.200000
     RecoilYFactor=0.350000
     RecoilDeclineTime=1.250000
     RecoilDeclineDelay=0.125000
     FireModeClass(0)=Class'BallisticProV55.XMK5PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     PutDownTime=0.350000
     SelectForce="SwitchToAssaultRifle"
     bCanThrow=False
     AmmoClass(0)=Class'BallisticProV55.Ammo_XMK5Clip''
     Description="NDTR's recent line of urban submachineguns, specfically the XMk5, has garnered attention from various UTC units operating in such environments. The XMk5 is often, and is indeed encouraged to be, fitted with all manner of attachments designed by NDTR as well. While many of the attachments are 'standard' sights, grenade launchers, flash lights and laser sights, there are other more peculiar devices. One of the most popular of these, is a unique, air-powered, dart launcher. The most commonly used dart, is one that stuns and poisons the victim, making them easy prey for the XMk5's primary bullet fire mode."
     Priority=41
     HudColor=(G=150,R=225)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=3
     GroupOffset=2
     PlayerViewOffset=(X=2.000000,Y=8.000000,Z=-10.000000)
     AttachmentClass=Class'BallisticProV55.XMK5Attachment'
     IconMaterial=Texture'BallisticTextures_25.OA-SMG.SmallIcon_OASMG'
     IconCoords=(X2=127,Y2=31)
     ItemName="XMk5 Submachine Gun"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BallisticProAnims.OA-SMG'
     DrawScale=0.450000
     AmbientGlow=0
}
