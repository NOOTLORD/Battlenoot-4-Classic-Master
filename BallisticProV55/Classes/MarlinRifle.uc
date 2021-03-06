//=============================================================================
// Weapon class for the Marlin Rifle
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
     PlayerSpeedFactor=1.000000
     PlayerJumpFactor=1.000000
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticProUITex.Icons.BigIcon_Marlin'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     InventorySize=12	 
     SpecialInfo(0)=(Info="240.0;25.0;0.6;50.0;1.0;0.5;-999.0")
     BringUpSound=(Sound=Sound'BallisticProSounds.R78A1.R78A1-Pullout',Volume=0.375000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     PutDownSound=(Sound=Sound'BallisticProSounds.R78A1.R78A1-Putaway',Volume=0.375000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     MagAmmo=8
     CockAnimRate=1.700000
     CockSound=(Sound=Sound'BallisticProSounds.Marlin.Marlin-Cock',Volume=0.800000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ReloadAnim="ReloadLoop"
     ReloadAnimRate=2.000000
     ClipInSound=(Sound=SoundGroup'BallisticProSounds.Marlin.Marlin-ShellIn',Volume=0.800000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipInFrame=29.000000
     bCanSkipReload=True
     bShovelLoad=True
     StartShovelAnim="StartReload"
     EndShovelAnim="EndReload"
     WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",)
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
     bNoCrosshairInScope=False
     SightZoomFactor=20
     SightOffset=(X=4.000000,Y=-0.075000,Z=4.750000)
     SightDisplayFOV=30.000000	 
     SightingTime=0.400000
     GunLength=64.000000
     LongGunPivot=(Pitch=-4000,Yaw=-12000)
     LongGunOffset=(X=5.000000,Y=10.000000,Z=-11.000000)	 
     CrouchAimFactor=0.750000	 
     SightAimFactor=0.250000
     HipRecoilFactor=1.600000
     JumpChaos=0.200000
     SprintChaos=0.200000
     SprintOffSet=(Pitch=-1000,Yaw=-2048)	 
     AimSpread=16	 
     ChaosDeclineTime=1.000000
     ChaosSpeedThreshold=6000.000000
     ChaosAimSpread=1536	 
	 RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=0.070000),(InVal=0.400000,OutVal=0.10000),(InVal=0.600000,OutVal=0.25000),(InVal=0.800000,OutVal=0.33000),(InVal=1.000000)))
     RecoilYCurve=(Points=(,(InVal=0.200000,OutVal=0.150000),(InVal=0.400000,OutVal=0.500000),(InVal=0.700000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
     RecoilPitchFactor=1.000000
     RecoilYawFactor=1.000000
     RecoilXFactor=0.000000
     RecoilYFactor=0.000000
     RecoilMax=4096.000000 
     RecoilDeclineTime=1.000000
     RecoilDeclineDelay=0.800000
     SelectAnimRate=1.000000
     PutDownAnimRate=1.000000	 
	 PutDownTime=0.400000
     BringUpTime=0.300000	 
     DisplayFOV=60.000000
     Priority=33	 
     FireModeClass(0)=Class'BallisticProV55.MarlinPrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     AIRating=0.80000
     CurrentRating=0.800000
     bSniping=True
     AmmoClass(0)=Class'BallisticProV55.Ammo_MarlinRifle'
     AmmoClass(1)=Class'BallisticProV55.Ammo_MarlinRifle'	 
     Description="Marlin"
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=1
     PlayerViewOffset=(X=7.000000,Y=14.500000,Z=-10.000000)
     AttachmentClass=Class'BallisticProV55.MarlinAttachment'
     IconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_Marlin'
     IconCoords=(X2=127,Y2=31)
	 BobDamping=1.000000
     ItemName="Marlin"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticProAnims.Marlin_FP'
     DrawScale=0.500000
	 Skins(0)=Shader'BallisticProTex.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticProTex.Marlin.Marlin-Main'
	 Skins(2)=Texture'BallisticProEffectsTex.Brass.Marlin_Shell'
}
