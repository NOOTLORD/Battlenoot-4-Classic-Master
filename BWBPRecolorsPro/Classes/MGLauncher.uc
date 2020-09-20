//=============================================================================
// Weapon class for the MGL Grenade Launcher
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class MGLauncher extends BallisticWeapon;

var() Rotator	DrumRot;
var() name		NadeBone0;

simulated function Notify_ReloadStart()
{
    DrumRot.Roll = 0;
        SetBoneRotation('drum',DrumRot);	
		
	SetBoneScale (0, 0.0, NadeBone0);			
}

simulated function Notify_ReloadFinished()
{	
	SetBoneScale (0, 1.0, NadeBone0);		
}

simulated function AnimEnded (int Channel, name anim, float frame, float rate)
{
	if (anim == FireMode[0].FireAnim || (FireMode[1] != None && anim == FireMode[1].FireAnim))
	{
		bPreventReload=false;
		DrumRot.Roll -= 65535 / 6 ;
		SetBoneRotation('drum',DrumRot);	
	}
	
	//Phase out Channel 1 if a sight fire animation has just ended.
	if (anim == BFireMode[0].AimedFireAnim || anim == BFireMode[1].AimedFireAnim)
	{
		AnimBlendParams(1, 0);
		//Cut the basic fire anim if it's too long.
		if (SightingState > FireAnimCutThreshold && SafePlayAnim(IdleAnim, 1.0))
			FreezeAnimAt(0.0);
		bPreventReload=False;
		DrumRot.Roll -= 65535 / 6 ;
		SetBoneRotation('drum',DrumRot);	
	}

	// Modified stuff from Engine.Weapon
	if ((ClientState == WS_ReadyToFire || (ClientState == WS_None && Instigator.Weapon == self)) && ReloadState == RS_None)
    {
        if (anim == FireMode[0].FireAnim && HasAnim(FireMode[0].FireEndAnim)) // rocket hack
			SafePlayAnim(FireMode[0].FireEndAnim, FireMode[0].FireEndAnimRate, 0.0);
        else if (FireMode[1]!=None && anim== FireMode[1].FireAnim && HasAnim(FireMode[1].FireEndAnim))
            SafePlayAnim(FireMode[1].FireEndAnim, FireMode[1].FireEndAnimRate, 0.0);
        else if (MeleeState < MS_Held)
			bPreventReload=false;
		if (Channel == 0)
			PlayIdle();
    }
	// End stuff from Engine.Weapon

	// Start Shovel ended, move on to Shovel loop
	if (ReloadState == RS_StartShovel)
	{
		ReloadState = RS_Shovel;
		PlayShovelLoop();
		return;	
	}
	// Shovel loop ended, start it again
	if (ReloadState == RS_PostShellIn)
	{
		if (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1 )
		{
			PlayShovelEnd();
			ReloadState = RS_EndShovel;
			return;
		}
		ReloadState = RS_Shovel;
		PlayShovelLoop();
		return;
	}
	// End of reloading, either cock the gun or go to idle
	if (ReloadState == RS_PostClipIn || ReloadState == RS_EndShovel)
	{
		if (bNeedCock && MagAmmo > 0)
			CommonCockGun();
		else
		{
			bNeedCock=false;
			ReloadState = RS_None;
			ReloadFinished();
			PlayIdle();
			ReAim(0.05);
		}
		return;
	}
	//Cock anim ended, goto idle
	if (ReloadState == RS_Cocking)
	{
		bNeedCock=false;
		ReloadState = RS_None;
		ReloadFinished();
		PlayIdle();
		ReAim(0.05);
	}
	
	if (ReloadState == RS_GearSwitch)
		ReloadState = RS_None;
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

	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.5, Dist, 1024, 3072); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	return -0.2;
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
	return 0.2;
}

// End AI Stuff =====

defaultproperties
{
     NadeBone0="S6"
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_MGL'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'	 
     IdleTweenTime=0.000000
     bWT_Hazardous=True
     bWT_Splash=True
     bWT_Projectile=True
     bWT_Super=True
     SpecialInfo(0)=(Info="300.0;30.0;0.5;60.0;0.0;1.0;0.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.M763.M763Pullout',Volume=0.475000)
     PutDownSound=(Sound=Sound'BallisticSounds2.M763.M763Putaway',Volume=0.475000)
     MagAmmo=6
     ReloadAnim="ReloadLoop"
     ReloadAnimRate=1.250000	 
     ClipOutSound=(Sound=Sound'BallisticSounds2.BX5.BX5-SecOff',Volume=0.650000)
     ClipInSound=(Sound=Sound'BallisticSounds2.BX5.BX5-SecOn',Volume=0.650000)
     ClipInFrame=0.325000
     WeaponModes(0)=(ModeName="Timed",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
     bCanSkipReload=True
     bShovelLoad=True
     StartShovelAnim="ReloadStart"
     StartShovelAnimRate=1.250000
     EndShovelAnim="ReloadEnd"
     EndShovelAnimRate=1.250000	 
     bNoCrosshairInScope=False
     SightPivot=(Pitch=512)
     SightOffset=(X=-30.000000,Y=12.485000,Z=11.750000)
     GunLength=48.000000
     SprintOffSet=(Pitch=-3000,Yaw=-4096)
     AimAdjustTime=100.000000
     AimSpread=192
     AimDamageThreshold=0.000000
	 ViewRecoilFactor=1.000000	 
     ChaosDeclineTime=1.000000
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
     RecoilYCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
     RecoilYawFactor=0.000000
     RecoilXFactor=0.400000
     RecoilYFactor=0.400000
     RecoilMax=6144.000000
     RecoilDeclineDelay=0.500000
     FireModeClass(0)=Class'BWBPRecolorsPro.MGLPrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     SelectAnimRate=1.500000
     PutDownAnimRate=2.000000
     PutDownTime=0.660000
     BringUpTime=0.660000
     AIRating=0.900000
     CurrentRating=0.900000
     AmmoClass(0)=Class'BWBPRecolorsPro.Ammo_MGL_Launcher'
     AmmoClass(1)=Class'BWBPRecolorsPro.Ammo_MGL_Launcher'
     Description="MGL Grenade Launcher"
     Priority=245
     HudColor=(B=255,G=200,R=200)	 
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=4
     PlayerViewOffset=(X=9.000000,Y=-1.000000,Z=-7.000000)
     AttachmentClass=Class'BWBPRecolorsPro.MGLAttachment'
     IconMaterial=Texture'BallisticUI.Icons.SmallIcon_MGL'
     IconCoords=(X2=127,Y2=35)
     ItemName="MGL"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticRecolorsAnims.Conqueror_FP'
     DrawScale=0.130000
     AmbientGlow=5
	 Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticRecolorsTex.MGL.MGL-Main'
	 Skins(2)=Texture'BallisticRecolorsTex.MGL.MGL-ScreenBase'
}