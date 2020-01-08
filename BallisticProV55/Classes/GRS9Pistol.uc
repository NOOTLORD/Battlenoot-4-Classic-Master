//=============================================================================
// GRS9Pistol.
//
// Glock style low power, high capacity, low recoil, high accuracy light pistol
// with low power burning laser attachment.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class GRS9Pistol extends BallisticHandgun;

simulated function PlayIdle()
{
	super.PlayIdle();

	if (!bPendingSightUp || SightingState != SS_None || bScopeView || !CanPlayAnim(IdleAnim, ,"IDLE"))
		return;
	FreezeAnimAt(0.0);
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);

	if (Anim == 'OpenFire' || Anim == 'Fire' || Anim == CockAnim || Anim == ReloadAnim)
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			IdleAnim = 'OpenIdle';
			ReloadAnim = 'OpenReload';
		}
		else
		{
			IdleAnim = 'Idle';
			ReloadAnim = 'Reload';
		}
	}
	Super.AnimEnd(Channel);
}

simulated function Notify_ClipOutOfSight()
{
	SetBoneScale (1, 1.0, 'Bullet');
}

simulated function PlayReload()
{
	super.PlayReload();

	if (MagAmmo < 1)
		SetBoneScale (1, 0.0, 'Bullet');
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
function float SuggestAttackStyle()	{	return 0.8;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.8;	}

// End AI Stuff =====

defaultproperties
{
	 AIRating=0.6
	 CurrentRating=0.6
     bShouldDualInLoadout=False
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BWBP4-Tex.Glock.BigIcon_Glock'
     BigIconCoords=(Y1=30,Y2=230)
     SightFXBone="SightBone"
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     ManualLines(0)="Automatic fire. Short ranged, but has higher DPS than most pistols. Recoil is moderate."
     ManualLines(1)="Projects a laser beam. Has extremely low DPS, but consistent damage over range and recharges over time."
     ManualLines(2)="The Weapon Function key causes a hitscan single-shot beam to be projected from the unit, dealing good damage. The GRS-9 is effective at close range."
     SpecialInfo(0)=(Info="120.0;8.0;-999.0;25.0;0.0;0.0;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Putaway')
     MagAmmo=15
     CockAnimRate=1.200000
     CockSound=(Sound=Sound'BWBP4-Sounds.Glock.Glk-Cock',Volume=0.600000)
     ReloadAnimRate=1.350000
     ClipHitSound=(Sound=Sound'BWBP4-Sounds.Glock.Glk-ClipHit',Volume=0.600000)
     ClipOutSound=(Sound=Sound'BWBP4-Sounds.Glock.Glk-ClipOut',Volume=0.600000)
     ClipInSound=(Sound=Sound'BWBP4-Sounds.Glock.Glk-ClipIn',Volume=0.600000)
     ClipInFrame=0.650000
     bCockOnEmpty=True
     WeaponModes(0)=(bUnavailable=True)
     WeaponModes(1)=(bUnavailable=True)
     bNoCrosshairInScope=True
     SightOffset=(X=-15.000000,Z=5.900000)
     SightDisplayFOV=40.000000
     SightingTime=0.200000
	 SightZoomFactor=0
     SightAimFactor=0.050000
     SprintChaos=0.050000
     AimAdjustTime=100.000000
     AimSpread=16
     AimDamageThreshold=0.000000
     ChaosDeclineTime=0.450000
     ChaosSpeedThreshold=7500.000000
     ChaosAimSpread=384
     RecoilYawFactor=0.000000
     RecoilXFactor=0.250000
     RecoilYFactor=0.250000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.150000
     FireModeClass(0)=Class'BallisticProV55.GRS9PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     SelectAnimRate=1.500000
     PutDownAnimRate=1.500000
     SelectForce="SwitchToAssaultRifle"
     bCanThrow=False
     AmmoClass(0)=Class'BallisticProV55.Ammo_GRS9Clip'
     Description="The GRS9 from Drake & Co. is used primarily by inner core planets for law enforcement purposes. The additional laser unit adds an alternative attack to the GRS9. The laser unit can be held down, for up to 3.5 seconds, releasing a searing beam upon enemies. This drains the rechargeable battery however, which must be left to replenish when empty."
     Priority=9
     HudColor=(B=25,G=25,R=200)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=2
     PlayerViewOffset=(X=6.000000,Y=8.000000,Z=-9.000000)
     AttachmentClass=Class'BallisticProV55.GRS9Attachment'
     IconMaterial=Texture'BWBP4-Tex.Glock.SmallIcon_Glock'
     IconCoords=(X2=127,Y2=31)
     ItemName="GRS-9 Pistol"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BWBP4-Anims.Glock'
     DrawScale=0.150000
     AmbientGlow=0
}
