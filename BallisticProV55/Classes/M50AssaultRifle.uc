//=============================================================================
// Weapon class for M50 Assault Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class M50AssaultRifle extends BallisticWeapon;

var() Material	LCDCamOnTex;		//

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
     LCDCamOnTex=Texture'BallisticUI.M50.M50LCDTex'					   
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_M50'
     BigIconCoords=(Y1=40,Y2=235)
     SightFXClass=Class'BallisticProV55.M50SightLEDs'	 
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     bWT_Machinegun=True
     ManualLines(0)="Automatic 5.56 bullet fire. Low damage per shot with medium range, low penetration and low recoil."
     ManualLines(1)="Launches a grenade from the underslung launcher. This grenade has an arming delay and will ricochet from targets hit during this arming period, dealing minor damage. The arming delay can be used to shoot around corners."
     ManualLines(2)="A TX409-Tactical Video camera system is also included with this weapon. It allows the user to deploy a tactical camera to any surface using the Weapon Function key. To survey an area from a safe distance using the gun-mounted LCD, press Weapon Function again. Care should always be taken to deploy TX409-TV cameras in a hidden location to prevent them from being destroyed by enemies.||The M50 is effective at medium to long range."
     SpecialInfo(0)=(Info="240.0;25.0;0.9;80.0;0.7;0.7;0.4")
     BringUpSound=(Sound=Sound'BallisticSounds2.M50.M50Pullout',Volume=0.375000)
     PutDownSound=(Sound=Sound'BallisticSounds2.M50.M50Putaway',Volume=0.375000)
     CockAnimPostReload="ReloadEndCock"
     CockAnimRate=1.250000
     CockSound=(Sound=Sound'BallisticSounds2.M50.M50Cock',Volume=0.850000)
     ClipHitSound=(Sound=Sound'BallisticSounds2.M50.M50ClipHit',Volume=0.850000)
     ClipOutSound=(Sound=Sound'BallisticSounds2.M50.M50ClipOut',Volume=0.850000)
     ClipInSound=(Sound=Sound'BallisticSounds2.M50.M50ClipIn',Volume=0.850000)
     ClipInFrame=0.650000
     bCockOnEmpty=True
     WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0	 
     bNoCrosshairInScope=True
     SightPivot=(Pitch=200)
     SightOffset=(Y=0.050000,Z=12.130000)
     SightDisplayFOV=40.000000
     CrouchAimFactor=0.750000
     SightAimFactor=0.200000
     SprintOffSet=(Pitch=-3000,Yaw=-4000)
     AimAdjustTime=100.000000
     AimSpread=16
     AimDamageThreshold=0.000000
     ChaosDeclineTime=1.250000
     ChaosSpeedThreshold=15000.000000
     ChaosAimSpread=3072
     RecoilXCurve=(Points=(,(InVal=0.150000),(InVal=0.250000,OutVal=-0.080000),(InVal=0.400000,OutVal=0.080000),(InVal=0.600000,OutVal=-0.120000),(InVal=0.800000,OutVal=0.100000),(InVal=1.000000)))
     RecoilYCurve=(Points=(,(InVal=0.200000,OutVal=0.170000),(InVal=0.400000,OutVal=0.350000),(InVal=0.600000,OutVal=0.600000),(InVal=0.800000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.150000
     RecoilYFactor=0.300000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.140000
     FireModeClass(0)=Class'BallisticProV55.M50PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     PutDownAnimRate=1.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000
     bCanThrow=False
     AmmoClass(0)=Class'BallisticProV55.Ammo_M50_Rifle'
     Description="Enravion's crowning achievement, the M50 is the most extensively used weapon in the UTC military corps. The M50 is renowned for its accuracy, damage and reliability in the field. The sturdy M50 was extensively used in both wars and has helped annihilate countless Skrith, Krao and Cryon warriors. The weapon also has the advantage of launching a grenade from the attached M900, for flushing out enemies."
     Priority=41
     HudColor=(B=255,G=200,R=200)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=3
     GroupOffset=3
     PlayerViewOffset=(X=1.000000,Y=7.000000,Z=-8.000000)
     AttachmentClass=Class'BallisticProV55.M50Attachment'
     IconMaterial=Texture'BallisticUI.Icons.SmallIcon_M50'
     IconCoords=(X2=127,Y2=31)
     ItemName="M50 Assault Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticAnims2.M50_FP'
     DrawScale=0.300000
     AmbientGlow=5
}
