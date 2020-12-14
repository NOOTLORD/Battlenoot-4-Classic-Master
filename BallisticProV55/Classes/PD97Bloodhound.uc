//===========================================================================
// Weapon class for the PD-97 Bloodhound
//
// adapting code by Nolan "Dark Carnivour" Richert
// Aspects of which are copyright (c) 2006 RuneStorm. All rights reserved.
//
// Modified by (NL)NOOTLORD						  
//===========================================================================
class PD97Bloodhound extends BallisticHandgun;

var array<PD97DartControl> StruckTargets;

var rotator DrumRot;
var byte DrumPos;

var array<Name> ShellBones[5];
var array<Name> SpareShellBones[5];
var() name		Drumbone;
var() name      Ejectingshellbone;

simulated function Notify_Hidedrum()
{		
	SetBoneScale (0, 0.0, Drumbone);	
}

simulated function ShellFired()
{
	SetBoneScale(DrumPos, 0.0, ShellBones[DrumPos]);
}

simulated function CycleDrum()
{
	if (DrumPos == 4)
		DrumPos = 0;
	else DrumPos++;
	DrumRot.Roll -= 65535 / 5;
	SetBoneRotation('drum',DrumRot);	
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		if (IdleAnim == 'Idle')
			IdleAnim = 'OpenIdle';
		ReloadAnim = 'OpenReload';
	}
	else
	{
		if (IdleAnim == 'OpenIdle')
			IdleAnim = 'Idle';
		ReloadAnim = 'Reload';
	}
}

simulated function AnimEnded (int Channel, name anim, float frame, float rate)
{	
	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		IdleAnim = 'OpenIdle';
		ReloadAnim = 'OpenReload';
	}
	else
	{
		if (anim == FireMode[0].FireAnim || (FireMode[1] != None && anim == FireMode[1].FireAnim))
		{
			bPreventReload=false;
			if (anim == FireMode[0].FireAnim)
				CycleDrum();
		}
		IdleAnim = 'Idle';
		ReloadAnim = 'Reload';
	}

	//Phase out Channel 1 if a sight fire animation has just ended.
	if (anim == BFireMode[0].AimedFireAnim || anim == BFireMode[1].AimedFireAnim)
	{
		AnimBlendParams(1, 0);
		//Cut the basic fire anim if it's too long.
		if (SightingState > FireAnimCutThreshold && SafePlayAnim(IdleAnim, 1.0))
			FreezeAnimAt(0.0);
		bPreventReload=False;
		if (anim == BFireMode[0].AimedFireAnim)
			CycleDrum();
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
		if (Channel == 0 && (bNeedReload || !FireMode[0].bIsFiring) && MeleeState < MS_Held)
			PlayIdle();
    }
	// End stuff from Engine.Weapon
	
	// End of reloading, either cock the gun or go to idle
	if (ReloadState == RS_PostClipIn)
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

simulated function Notify_DrumDown()
{
	local int i, j;
	
	j=DrumPos;
	
	for (i=0; i < default.MagAmmo; i++)
	{
		if (i < Ammo[0].AmmoAmount)
			SetBoneScale(j, 1, ShellBones[j]);
		else SetBoneScale(j+default.MagAmmo, 0, SpareShellBones[j]);
		
		if (j == 4)
			j = 0;
		else j++;
	}
}

simulated function Notify_ClipIn()
{
	local int i;
	
	Super.Notify_ClipIn();
	
	for (i=0; i < default.MagAmmo; i++)
		SetBoneScale(i+default.MagAmmo, 1, SpareShellBones[i]);
}

//===========================================================================
// Darts.
//===========================================================================
function AddControl(PD97DartControl DC)
{
	StruckTargets[StruckTargets.Length] = DC;
}

function LostControl(PD97DartControl DC)
{
	local int i;
	
	for (i=0; i < StruckTargets.Length; i++)
	{
		if (StruckTargets[i] == DC)
		{
			StruckTargets.Remove(i, 1);
			return;
		}
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

	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, 768, 2048); 
}

defaultproperties
{
     Drumbone="SpareDrum"
	 Ejectingshellbone="Ejectingshell"
     ShellBones(0)="Shell1"
     ShellBones(1)="Shell2"
     ShellBones(2)="Shell3"
     ShellBones(3)="Shell4"
     ShellBones(4)="Shell5"
     SpareShellBones(0)="SpareShell1"
     SpareShellBones(1)="SpareShell2"
     SpareShellBones(2)="SpareShell3"
     SpareShellBones(3)="SpareShell4"
     SpareShellBones(4)="SpareShell5"
     PlayerSpeedFactor=1.100000
     PlayerJumpFactor=1.100000				 
     AIReloadTime=1.500000
     BigIconMaterial=Texture'BallisticProUI.Icons.BigIcon_PD97'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo' 
	 InventorySize=6	 
     bWT_Bullet=False
	 bWT_Projectile=True
     bWT_Heal=True
     SpecialInfo(0)=(Info="120.0;15.0;0.8;50.0;0.0;0.5;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.M806.M806Pullout',Volume=0.325000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     PutDownSound=(Sound=Sound'BallisticSounds2.M806.M806Putaway',Volume=0.325000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     MagAmmo=5
     CockAnimRate=1.250000
     CockSound=(Sound=Sound'BallisticSounds2.AM67.AM67-Cock',Volume=1.200000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
	 ReloadAnimRate=0.800000
     ClipHitSound=(Sound=Sound'BallisticSounds2.AM67.AM67-ClipHit',Volume=1.200000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipOutSound=(Sound=Sound'BallisticSounds2.AM67.AM67-ClipOut',Volume=1.200000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipInSound=(Sound=Sound'BallisticSounds2.AM67.AM67-ClipIn',Volume=1.200000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipInFrame=25.000000
     WeaponModes(0)=(ModeName="Healing Darts",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
     bNoCrosshairInScope=True
	 SightZoomFactor=0	 
     SightOffset=(X=-10.000000,Y=-4.400000,Z=12.130000)
     SightDisplayFOV=45.000000
     SightingTime=0.200000
     GunLength=16.000000
     LongGunPivot=(Pitch=5000,Yaw=6000)
     LongGunOffset=(X=5.000000,Y=10.000000,Z=-11.000000)
     CrouchAimFactor=0.800000	 
     SightAimFactor=0.150000
     HipRecoilFactor=1.600000
     SprintChaos=0.100000	 
     SprintOffSet=(Pitch=-1000,Yaw=-2048)
     AimSpread=16
     ChaosDeclineTime=0.450000
     ChaosSpeedThreshold=6000.000000	 
     ChaosAimSpread=512
     RecoilXCurve=(Points=(,(InVal=1.000000)))
     RecoilYCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))	 
     RecoilPitchFactor=1.000000
     RecoilYawFactor=1.000000	 
     RecoilXFactor=0.10000
     RecoilYFactor=0.10000
     RecoilMax=8192.000000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.500000
     SelectAnimRate=1.000000
     PutDownAnimRate=1.000000	 
     PutDownTime=0.600000
     BringUpTime=0.900000	 
     DisplayFOV=57.500000
     Priority=24	 
     FireModeClass(0)=Class'BallisticProV55.PD97PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
	 AIRating=0.500000
	 CurrentRating=0.500000
     AmmoClass(0)=Class'BallisticProV55.Ammo_PD97_Pistol'
     AmmoClass(1)=Class'BallisticProV55.Ammo_PD97_Pistol'	 
     Description="PD-97"
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=2
     PlayerViewOffset=(X=10.000000,Y=9.750000,Z=-9.500000)
     AttachmentClass=Class'BallisticProV55.PD97Attachment'
     IconMaterial=Texture'BallisticProUI.Icons.SmallIcon-PD97'
     IconCoords=(X2=127,Y2=31)
     ItemName="PD-97"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=2.250000
     Mesh=SkeletalMesh'BallisticAnims1.Bloodhound_FP'
     DrawScale=0.200000
	 Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticWeapons1.Bloodhound.BloodhoundMain'
	 Skins(2)=Texture'BallisticWeapons1.Bloodhound.BloodhoundAmmo'
	 Skins(3)=Texture'BallisticWeapons1.Bloodhound.BloodhoundAcc'
	 Skins(4)=Shader'BallisticWeapons1.General.RedDotSightShader'
}
