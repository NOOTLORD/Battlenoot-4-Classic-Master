//=============================================================================
// Weapon class for the M763 Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class M763Shotgun extends BallisticProShotgun;

simulated function Notify_CockStart()
{
	if (ReloadState == RS_None)	return;
		ReloadState = RS_Cocking;
	PlayOwnedSound(CockSound.Sound,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
}

simulated event AnimEnded (int Channel, name anim, float frame, float rate) 
{	
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
	if ((ClientState == WS_ReadyToFire || (ClientState == WS_None && Instigator.Weapon == self)) && ReloadState == RS_None)
    {
		if (Channel == 0 && (bNeedReload || ((FireMode[0] == None || !FireMode[0].bIsFiring) && (FireMode[1] == None || !FireMode[1].bIsFiring))) && MeleeState < MS_Held)
			PlayIdle();
    }
	// End stuff from Engine.Weapon

	if (ReloadState == RS_None)
		return;
	
	// Start Shovel ended, move on to Shovel loop
	else if (ReloadState == RS_StartShovel)
	{
		ReloadState = RS_Shovel;
		PlayShovelLoop();
		return;
	}
	// Shovel loop ended, start it again
	else if (ReloadState == RS_PostShellIn)
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
	else if (ReloadState == RS_EndShovel)
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
	else if (ReloadState == RS_Cocking)
	{
		bNeedCock=false;
		ReloadState = RS_None;
		ReloadFinished();		
		PlayIdle();
		ReAim(0.05);
	}
	
	else if (ReloadState == RS_GearSwitch)
	{
		if (Role == ROLE_Authority)
			bServerReloading=false;
		ReloadState = RS_None;
		PlayIdle();
	}
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, BallisticProShotgunFire(BFireMode[0]).CutOffStartRange, BallisticProShotgunFire(BFireMode[0]).CutOffDistance); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	return 0.5;
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
	return -0.5;
}

// End AI Stuff =====

defaultproperties
{
     PlayerSpeedFactor=1.000000
     PlayerJumpFactor=1.000000
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticProUITex.Icons.SmallIcon_M763'
     BigIconCoords=(Y1=35,Y2=230)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     InventorySize=12
     SpecialInfo(0)=(Info="120.0;20.0;0.7;50.0;0.0;0.5;0.0")
     BringUpSound=(Sound=Sound'BallisticProSounds.M763.M763-Pullout',Volume=0.375000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     PutDownSound=(Sound=Sound'BallisticProSounds.M763.M763-Putaway',Volume=0.375000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     MagAmmo=7
     CockAnimRate=1.700000
     CockSound=(Sound=Sound'BallisticProSounds.M763.M763-Cock',Volume=0.400000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ReloadAnim="ReloadLoop"
     ReloadAnimRate=1.100000
     ClipInSound=(Sound=Sound'BallisticProSounds.M763.M763-ShellIn',Volume=1.000000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipInFrame=9.000000
     WeaponModes(0)=(ModeName="Pump-Action",ModeID="WM_SemiAuto",)
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0	 
     bCanSkipReload=True
     bShovelLoad=True
     StartShovelAnim="ReloadStart"
     StartShovelAnimRate=1.100000
     EndShovelAnim="ReloadEnd"
     EndShovelAnimRate=1.100000
     bNoCrosshairInScope=True
	 SightZoomFactor=0 
     SightPivot=(Pitch=32)
     SightOffset=(X=5.000000,Z=11.500000)
     SightDisplayFOV=40.000000
     SightingTime=0.350000
     GunLength=48.000000
     LongGunPivot=(Pitch=-4000,Yaw=-12000)
     LongGunOffset=(X=5.000000,Y=10.000000,Z=-11.000000)
     CrouchAimFactor=0.800000	 
	 SightAimFactor=0.50000	
     HipRecoilFactor=1.600000	
     SprintChaos=0.100000	 
     SprintOffSet=(Pitch=-1000,Yaw=-2048)
     AimSpread=16
     ChaosDeclineTime=0.750000
     ChaosSpeedThreshold=6000.000000	 
     ChaosAimSpread=256
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=0.10000),(InVal=0.350000,OutVal=0.13000),(InVal=0.550000,OutVal=0.230000),(InVal=0.800000,OutVal=0.35000),(InVal=1.000000,OutVal=0.45)))
     RecoilYCurve=(Points=(,(InVal=0.150000,OutVal=0.150000),(InVal=0.40000,OutVal=0.50000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
     RecoilPitchFactor=1.000000
     RecoilYawFactor=1.000000
     RecoilXFactor=0.100000
     RecoilYFactor=0.100000
     RecoilMax=4096.000000	 
     RecoilDeclineTime=0.500000
     RecoilDeclineDelay=0.750000
     SelectAnimRate=1.000000
	 PutDownAnimRate=1.500000
	 PutDownTime=0.350000
     BringUpTime=0.300000	 
     DisplayFOV=60.000000
     Priority=37	 
     FireModeClass(0)=Class'BallisticProV55.M763PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     AIRating=0.750000
     CurrentRating=0.750000
     AmmoClass(0)=BallisticProV55.Ammo_M763Shotgun'
     AmmoClass(1)=BallisticProV55.Ammo_M763Shotgun'	 
     Description="M763"
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=1
     PlayerViewOffset=(X=4.000000,Y=12.000000,Z=-12.000000)
     AttachmentClass=Class'BallisticProV55.M763Attachment'
     IconMaterial=Texture'BallisticProUITex.Icons.BigIcon_M763'
     IconCoords=(X2=127,Y2=31)
	 BobDamping=1.250000
     ItemName="M763"						  
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticProAnims.M763_FP'
     DrawScale=0.500000
	 Skins(0)=Shader'BallisticProTex.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticProTex.M763.M763-Main'
	 Skins(2)=Texture'BallisticProTex.M763.M763-Shell'	
}
