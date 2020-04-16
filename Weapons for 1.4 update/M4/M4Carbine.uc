//=============================================================================
// Weapon class for M4 Carbine
//
// by Sarge.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class M4Carbine extends BallisticWeapon;

// Change some properties when using sights...
simulated function SetScopeBehavior()
{
	super.SetScopeBehavior();
	bUseNetAim = default.bUseNetAim || bScopeView;
	if (bScopeView)
	{
//		SightAimFactor = 0.0;
        	FireMode[0].FireAnim='SightFire';
	}
	else
	{
//		SightAimFactor = default.ViewRecoilFactor;
        	FireMode[0].FireAnim='Fire';
	}
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
function float SuggestAttackStyle()	{	return 0.0;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}

// End AI Stuff =====

defaultproperties
{
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_M4'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'	 
     bWT_Bullet=True
     SpecialInfo(0)=(Info="240.0;20.0;0.9;75.0;0.8;0.7;0.2")
     BringUpSound=(Sound=Sound'BallisticRecolorsSounds.M4A1.M4A1-PullOut',Volume=2.200000)
     PutDownSound=(Sound=Sound'BallisticRecolorsSounds.M4A1.M4A1-Putaway',Volume=2.200000)
     MagAmmo=30	 
     CockSound=(Sound=Sound'BallisticRecolorsSounds.M4A1.M4A1-Cock',Volume=2.200000)
     ClipHitSound=(Sound=Sound'BallisticRecolorsSounds.M4A1.M4A1-MagIn',Volume=4.800000)
     ClipOutSound=(Sound=Sound'BallisticRecolorsSounds.M4A1.M4A1-MagOut',Volume=4.800000)
     ClipInFrame=0.650000
	 bCockOnEmpty=True
     ReloadEmptyAnim="Reload" 	 
     WeaponModes(0)=(bUnavailable=True)
     WeaponModes(1)=(ModeName="Burst",ModeID="WM_Burst")
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=1
     bNoCrosshairInScope=False
     SightOffset=(Y=-6.450000,Z=20.500000)
     SightDisplayFOV=40.000000
     SightingTime=0.300000
     SprintOffSet=(Pitch=-3500,Yaw=-3000,Roll=3000)
     AimAdjustTime=100.000000
     AimSpread=16
     AimDamageThreshold=0.000000
	 ViewRecoilFactor=1.000000	 
     ChaosDeclineTime=1.250000
     ChaosSpeedThreshold=15000.000000
     ChaosAimSpread=3072
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.400000),(InVal=1.000000,OutVal=-0.200000)))
     RecoilYCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.650000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.200000
     RecoilYFactor=0.350000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.100000
     FireModeClass(0)=Class'BWBPRecolorsPro.M4PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'	 
     IdleAnimRate=0.500000
     SelectAnimRate=1.660000
     PutDownAnimRate=1.330000
     PutDownTime=0.400000
     BringUpTime=0.450000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000
     bCanThrow=False	 
     Description="MJ51 Carbine||Manufacturer: Majestic Firearms 12|Primary: 5.56mm CAP Rifle Fire|Secondary: Attach Smoke Grenade||The MJ51 is a 3-round burst carbine based off the popular M50 assault rifle. Unlike the M50 and SAR though, it fires a shorter 5.56mm CAP round and is more controllable than its larger cousin, though this comes at the expense of long range accuracy and power. While the S-AR 12 is the UTC's weapon of choice for close range engagements, the MJ51 is often seen in the hands of MP and urban security details. When paired with its native MOA-C Rifle Grenade attachment, the MJ51 makes an efficient riot control weapon. |Majestic Firearms 12 designed their MJ51 carbine alongside their MOA-C Chaff Grenade to produce a rifle with grenade launching capabilities without the need of a bulky launcher that has to be sperately maintained. Utilizing a hardened tungsten barrel and an advanced rifle grenade design, a soldier is able to seamlessly ready a grenade projectile without having to rechamber specilized rounds"
     AmmoClass(0)=Class'BWBPRecolorsPro.Ammo_M4_Rifle'     
	 Priority=41
     HudColor=(B=255,G=200,R=200)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=3
     PlayerViewOffset=(X=-8.000000,Y=10.000000,Z=-14.000000)
     AttachmentClass=Class'BWBPRecolorsPro.M4Attachment'
     IconMaterial=Texture'BallisticUI.Icons.SmallIcon_M4'
     IconCoords=(X2=127,Y2=31)
     ItemName="M4 Carbine"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticRecolorsAnims.M4Carbine_FP'
     DrawScale=0.300000
     AmbientGlow=5	 
}