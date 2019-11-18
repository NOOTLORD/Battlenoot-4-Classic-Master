//=============================================================================
// LonghornLauncher.
//
// Lever Action Grenade Launcher - Fires cluster grenades. Alt fire simply shoots
// cluster. Shooting in the air will make it rain down with increased damage.
// Primary fire can be held to remotely detonate
//
// by Marc "Sergeant_Kelly"
//=============================================================================
class LonghornLauncher extends BallisticWeapon;

var	  bool		bGunCocked;
var	  bool		bQuickFire;

var   bool      bWasQuick;
var   float     LonghornHeldTime;
var   float     LonghornTimer;

var() Name	Shells[4];


simulated function AltFire(float F)	{	FirePressed(F);	}

simulated function SetScopeBehavior()
{
	super.SetScopeBehavior();

	if (!bScopeView)
	    CockAnim='Cock1';
}

// Prepare to reload, set reload state, start anims. Called on client and server
simulated function CommonStartReload (optional byte i)
{
	local int m;
	if (ClientState == WS_BringUp)
		ClientState = WS_ReadyToFire;
	ReloadState = RS_StartShovel;
	PlayReload();

	if (bScopeView && Instigator.IsLocallyControlled())
		TemporaryScopeDown(Default.SightingTime*Default.SightingTimeScale);
	for (m=0; m < NUM_FIRE_MODES; m++)
		if (BFireMode[m] != None)
			BFireMode[m].ReloadingGun(i);

	if (bCockAfterReload)
		bNeedCock=true;
	if (bCockOnEmpty && MagAmmo < 1)
		bNeedCock=true;
	bNeedReload=false;
}

simulated function PlayReload()
{
	if (SightingState != SS_None)
		TemporaryScopeDown(0.5);
		
    if (MagAmmo < 1 && Ammo[0].AmmoAmount >= default.MagAmmo)
    {
       ShovelIncrement=default.MagAmmo;
       ReloadAnim='ReloadFull';
       bCanSkipReload=False;
    }
	
    else
    {
       ShovelIncrement=1;
       ReloadAnim='ReloadSingle';
       bCanSkipReload=True;
    }
	
	SafePlayAnim(StartShovelAnim, ReloadAnimRate, , 0, "RELOAD");
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2 && HasAnim(CockAnimPostReload))
		SafePlayAnim(CockAnimPostReload, CockAnimRate, 0.2, , "RELOAD");
	else
		SafePlayAnim(CockAnim, CockAnimRate, 0.2, , "RELOAD");

	if (SightingState != SS_None && SightingState != SS_Active)
		TemporaryScopeDown(0.5);
}

simulated function bool CheckScope()
{
	if (level.TimeSeconds < NextCheckScopeTime)
		return true;

	NextCheckScopeTime = level.TimeSeconds + 0.25;
	
	//LH should hold scope while cocking
	if ((ReloadState != RS_None && ReloadState != RS_Cocking) || (Instigator.Controller.bRun == 0 && Instigator.Physics == PHYS_Walking) || (Instigator.Physics == PHYS_Falling && VSize(Instigator.Velocity) > Instigator.GroundSpeed * 1.5) || (SprintControl != None && SprintControl.bSprinting))
	{
		StopScopeView();
		return false;
	}
		
	return true;
}

simulated function LonghornFired()
{
    local float r;
    
	bGunCocked = false;
    r=FRand();
    
	if (SightingState != SS_None)
    {
 		if (r < 0.50)
            CockAnim='SlowCocking1';
        else
            CockAnim='SlowCocking2';
	}
	
    else
    {
        if (r < 0.50)
			CockAnim='Cock1';
        else
			CockAnim='Cock2';
	}
	 
	SetBoneRotation('Hammer', rot(0,0,0));
}

simulated function Notify_CockStart()
{
	if (ReloadState == RS_None)
		return;
	if (ReloadState == RS_EndShovel)
		PlayOwnedSound(ClipHitSound.Sound,ClipHitSound.Slot,ClipHitSound.Volume,ClipHitSound.bNoOverride,ClipHitSound.Radius,ClipHitSound.Pitch,ClipHitSound.bAtten);
	else
		PlayOwnedSound(CockSound.Sound,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
	bGunCocked=true;
	bNeedCock=false;
}

simulated function bool PutDown()
{
	if (super.PutDown())
	{
		if (Instigator.IsLocallyControlled())
		{
			bGunCocked=false;
			SetBoneRotation('Hammer', rot(0,0,0));
		}
		return true;
	}
	return false;
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		SetBoneScale(0,0.0,Shells[0]);
		SetBoneScale(1,0.0,Shells[1]);
		SetBoneScale(2,0.0,Shells[2]);
		SetBoneScale(3,0.0,Shells[3]);
	}

	Super.BringUp(PrevWeapon);
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);

	if (bGunCocked && Anim == CockAnim || Anim == EndShovelAnim)
	{
		SetBoneRotation('Hammer', rot(0,7282,0));
		IdleTweenTime=0.00;
	}
	Super.AnimEnd(Channel);
	IdleTweenTime = default.IdleTweenTime;
}

simulated function AnimEnded (int Channel, name anim, float frame, float rate)
{
	if (Channel == 1)
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
		return;
	}
		
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
	if (ReloadState == RS_None && anim == BFireMode[0].AimedFireAnim || anim == BFireMode[1].AimedFireAnim)
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
        else if ((FireMode[0] == None || !FireMode[0].bIsFiring) && (FireMode[1] == None || !FireMode[1].bIsFiring))
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
		if (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1)
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

}

// Animation notify for when the clip is pulled out - grens are all visible
simulated function Notify_GrenVisible() //We can see these now
{
	SetBoneScale(0,1.0,Shells[0]);
	SetBoneScale(1,1.0,Shells[1]);
	SetBoneScale(2,1.0,Shells[2]);
	SetBoneScale(3,1.0,Shells[3]);
}
simulated function Notify_GrenVisiblePart() //Show gren 4
{
	SetBoneScale(3,1.0,Shells[3]);
}
simulated function Notify_GrenHide()
{
	if (MagAmmo <= 1)
	{
		SetBoneScale(0,0.0,Shells[0]);
		SetBoneScale(1,0.0,Shells[1]);
		SetBoneScale(2,0.0,Shells[2]);
		SetBoneScale(3,0.0,Shells[3]);
	}
}
simulated function UpdateBones()
{
	local int i;
	
	for(i=3; i>=MagAmmo; i--)
		SetBoneScale(i, 0.0, Shells[i]);
	for(i=0; i<MagAmmo && i<4; i++)
		SetBoneScale(i, 1.0, Shells[i]);
}

// AI Interface =====
function byte BestMode()
{
	local Bot B;
	local float Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	if (Dist < FireMode[1].MaxRange())
		return 1;
	if (Dist < FireMode[1].MaxRange() * 2 && FRand() > 0.5)
		return 1;

	return 0;
}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;
	local vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return Super.GetAIRating();

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	Result = Super.GetAIRating();
	if (Dist > 4000)
		Result -= 0.35;
	if (Dist > 1500)
		Result += 0.15;

	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.4;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.4;	}
// End AI Stuff =====

simulated function float ChargeBar()
{
	if (CurrentWeaponMode == 0)
		return LonghornPrimaryFire(FireMode[0]).HoldTime / 0.4;
	return LonghornPrimaryFire(FireMode[0]).HoldTime / 0.8;
}

defaultproperties
{
     ManualLines(0)="Fires a grenade which inflicts massive damage on direct impact.||If the Fire key is held down, the grenade will enter manual detonation mode. Fire can then be released to cause the grenade to explode with moderate damage and split into clusters. These clusters inflict moderate damage.||If detonated high above the ground, the clusters will project downwards instead of randomly, and will inflict heavier damage with a wider radius."
     ManualLines(1)="Fires the grenade as its component clusters. Essentially an explosive projectile shotgun attack."
     ManualLines(2)="Effective at close and medium range and as a bombardment and indirect fire weapon."																																																																																																																	  																													  
     Shells(0)="GrenadeA"
     Shells(1)="GrenadeB"
     Shells(2)="GrenadeC"
     Shells(3)="GrenadeD"
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BallisticRecolors4TexPro.Longhorn.BigIcon_LHorn'
     BigIconCoords=(Y1=30)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Hazardous=True
     bWT_Splash=True
     bWT_Grenade=True
     bWT_Spam=True
     SpecialInfo(0)=(Info="240.0;25.0;0.6;50.0;1.0;0.5;-999.0")
     BringUpSound=(Sound=Sound'PackageSounds4Pro.Bulldog.Bulldog-PullOut')
     PutDownSound=(Sound=Sound'PackageSounds4Pro.Bulldog.Bulldog-PutAway')
     MagAmmo=4
     CockAnim="Cock1"
     CockAnimRate=1.250000
     CockSound=(Sound=Sound'PackageSounds4ProExp.Longhorn.Longhorn-CockAlt',Volume=0.950000)
     ReloadAnim="ReloadSingle"
     ClipHitSound=(Sound=Sound'PackageSounds4ProExp.Longhorn.Longhorn-CockShut',Volume=1.000000)
     ClipOutSound=(Sound=Sound'PackageSounds4ProExp.Longhorn.Longhorn-CockOpen')
     ClipInSound=(Sound=SoundGroup'BWBP4-Sounds.Marlin.Mar-ShellIn')
     ClipInFrame=0.650000
     bCanSkipReload=True
     bShovelLoad=True
     StartShovelAnim="ReloadStart"
     EndShovelAnim="ReloadEnd"
     WeaponModes(0)=(ModeName="Single Fire")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
     bNotifyModeSwitch=True
     FullZoomFOV=70.000000
     bNoCrosshairInScope=True
     SightPivot=(Pitch=150)
     SightOffset=(Y=19.600000,Z=26.400000)
     SprintOffSet=(Pitch=-3072,Yaw=-4096)
     JumpChaos=0.200000
     FallingChaos=0.200000
     SprintChaos=0.200000
     AimAdjustTime=0.900000
     AimSpread=256
     ChaosDeclineTime=2.000000
     ChaosSpeedThreshold=2000.000000
     RecoilXFactor=1.500000
     RecoilYFactor=0.700000
     RecoilDeclineDelay=0.500000
     FireModeClass(0)=Class'BWBPRecolorsPro.LonghornPrimaryFire'
     FireModeClass(1)=Class'BWBPRecolorsPro.LonghornSecondaryFire'
     SelectAnimRate=1.100000
     PutDownAnimRate=1.500000
     PutDownTime=0.500000
     BringUpTime=0.450000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000
     bShowChargingBar=True
     Description="Longhorn Lever-Action Repeater|Manufacturer: Redwood Firearms|Primary: Cluster Round|Secondary: Split Cluster Round|| The longhorn is a large caliber lever-action rifle capable of firing everything from solid slugs to fragmentation grenades. This heavy duty hunting rifle first entered combat with the UTC Silver Ranger Division based in New Arizona. Outnumbered and outgunned, they had lost the battle of Phoenix Dam to the rebelling separatist groups. As the hostiles marched towards the colony's atmospheric stabilizer, they were continually dogged by the Rangers who had armed themselves with Longhorns filled with explosives and shrapnel. The lever-action launcher was easy to use and reliable and the rangers inflicted heavy casualties on the separatists before the stabilizer was lost and the colony compromised. Today, it is still in use with the Silver Rangers and is often loaded with powerful X2 SMRT Tandem-Cluster Grenades."
     Priority=4
     HudColor=(G=200,R=225)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=8
     PickupClass=Class'BWBPRecolorsPro.LonghornPickup'
     PlayerViewOffset=(X=-30.000000,Y=5.000000,Z=-20.000000)
     BobDamping=1.800000
     AttachmentClass=Class'BWBPRecolorsPro.LonghornAttachment'
     IconMaterial=Texture'BallisticRecolors4TexPro.Longhorn.SmallIcon_LHorn'
     IconCoords=(X2=127,Y2=31)
     ItemName="Longhorn Repeater"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=5.000000
     Mesh=SkeletalMesh'BallisticRecolors4AnimProExp.Longhorn_FP'
     DrawScale=0.900000
}
