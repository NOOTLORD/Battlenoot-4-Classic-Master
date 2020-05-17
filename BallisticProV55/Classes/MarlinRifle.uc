//=============================================================================
// Weapon class for Marlin Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class MarlinRifle extends BallisticWeapon;

simulated function AnimEnded (int Channel, name anim, float frame, float rate)
{
	if (Anim == ZoomInAnim)
	{
		SightingState = SS_Active;
		ScopeUpAnimEnd();
		return;
	}
	else if (Anim == ZoomOutAnim)
	{
		SightingState = SS_None;
		ScopeDownAnimEnd();
		return;
	}

	if (anim == FireMode[0].FireAnim || (FireMode[1] != None && anim == FireMode[1].FireAnim))
		bPreventReload=false;
		
		
	//Phase out Channel 1 if a sight fire animation has just ended.
	if (anim == BFireMode[0].AimedFireAnim || anim == BFireMode[1].AimedFireAnim)
	{
		AnimBlendParams(1, 0);
		//Cut the basic fire anim if it's too long.
		if (SightingState > FireAnimCutThreshold && SafePlayAnim(IdleAnim, 1.0))
			FreezeAnimAt(0.0);
		bPreventReload=False;
	}

	// Modified stuff from Engine.Weapon
	if (ClientState == WS_ReadyToFire && ReloadState == RS_None)
    {
        if (anim == FireMode[0].FireAnim && HasAnim(FireMode[0].FireEndAnim)) // rocket hack
			SafePlayAnim(FireMode[0].FireEndAnim, FireMode[0].FireEndAnimRate, 0.0);
        else if (FireMode[1]!=None && anim== FireMode[1].FireAnim && HasAnim(FireMode[1].FireEndAnim))
            SafePlayAnim(FireMode[1].FireEndAnim, FireMode[1].FireEndAnimRate, 0.0);
        else if ((FireMode[0] == None || !FireMode[0].bIsFiring) && (FireMode[1] == None || !FireMode[1].bIsFiring) && MeleeState < MS_Held)
        {
			bPreventReload=false;
            PlayIdle();
        }
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
		if (Ammo[0].AmmoAmount < 1 || MagAmmo >= default.MagAmmo)
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
	{
		if (Role == ROLE_Authority)
			bServerReloading=false;
		ReloadState = RS_None;
		PlayIdle();
	}
}

simulated function CommonCockGun(optional byte Type)
{
	if (!FireMode[1].IsFiring())
		super.CommonCockGun(Type);
}

simulated function TickLongGun (float DT)
{
	if (!FireMode[1].IsFiring())
	{
		if (ReloadState != RS_None && ReloadState != RS_Cocking)
			GunLength = 1;
		else if (GunLength == 1)
			GunLength = default.GunLength;
	}
	super.TickLongGun(DT);
}										 

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2 && HasAnim(CockAnimPostReload))
		SafePlayAnim(CockAnimPostReload, CockAnimRate, 0.2, , "RELOAD");
	else
		SafePlayAnim(CockAnim, CockAnimRate, 0.2, , "RELOAD");

	//if (SightingState != SS_None)
	//	TemporaryScopeDown(Default.SightingTime*Default.SightingTimeScale);
}

// Animation notify for when cocking action starts. Used to time sounds
simulated function Notify_CockAimed()
{
	bNeedCock = False;
	PlayOwnedSound(CockSound.Sound,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
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

	// the deermaster is effective at close range as well
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.8, Dist, 1024, 4096); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.4;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.4;	}

// End AI Stuff =====

defaultproperties
{
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_Marlin'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     SpecialInfo(0)=(Info="240.0;25.0;0.6;50.0;1.0;0.5;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.R78.R78Pullout',Volume=0.375000)
     PutDownSound=(Sound=Sound'BallisticSounds2.R78.R78Putaway',Volume=0.375000)
	 PutDownTime=0.4
     MagAmmo=8
     CockAnimRate=1.700000
     CockSound=(Sound=Sound'BallisticSounds1.Marlin.Mar-Cock',Volume=0.800000)
     ReloadAnim="ReloadLoop"
     ReloadAnimRate=2.000000
     ClipInSound=(Sound=SoundGroup'BallisticSounds1.Marlin.Mar-ShellIn',Volume=0.800000)
     ClipInFrame=0.650000
     bCockOnEmpty=True
     bCanSkipReload=True
     bShovelLoad=True
     StartShovelAnim="StartReload"
     EndShovelAnim="EndReload"
     WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",)
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
     FullZoomFOV=70.000000
     bNoCrosshairInScope=False
     SightZoomFactor=20
     SightOffset=(X=4.000000,Y=-0.075000,Z=4.750000)
     SightingTime=0.300000
     CrouchAimFactor=0.750000
     SprintOffSet=(Pitch=-1000,Yaw=-2048)
     JumpChaos=0.200000
     FallingChaos=0.100000
     SprintChaos=0.200000
     AimAdjustTime=100.000000
     AimDamageThreshold=0.000000
     ChaosDeclineTime=1.000000
     RecoilXFactor=0.400000
     RecoilMinRandFactor=0.500000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=1.000000
     FireModeClass(0)=Class'BallisticProV55.MarlinPrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.80000
     CurrentRating=0.800000
     bSniping=True
     AmmoClass(0)=Class'BallisticProV55.Ammo_Marlin_Rifle'
     AmmoClass(1)=Class'BallisticProV55.Ammo_Marlin_Rifle'	 
     Description="Redwood 6000 Rifle"
     Priority=33
     HudColor=(B=255,G=200,R=200)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=1
     GroupOffset=1
     PlayerViewOffset=(X=7.000000,Y=14.500000,Z=-10.000000)
     AttachmentClass=Class'BallisticProV55.MarlinAttachment'
     IconMaterial=Texture'BallisticUI.Icons.SmallIcon_Marlin'
     IconCoords=(X2=127,Y2=31)
     ItemName="Marlin"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticAnims1.Marlin_FP'
     DrawScale=0.500000
     AmbientGlow=5
	 Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticWeapons1.Marlin.Marlin_Main'
	 Skins(2)=Texture'BallisticEffects.Brass.Marlin_Shell'
}
