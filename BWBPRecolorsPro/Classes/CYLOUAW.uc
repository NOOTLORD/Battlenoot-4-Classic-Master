//=============================================================================
// CYLOUAW.
//
// CYLO Versitile Urban Assault Weapon.
//
// This nasty little gun has all sorts of tricks up its sleeve. Primary fire is
// a somewhat unreliable assault rifle with random fire rate and a chance to jam.
// Secondary fire is a semi-auto shotgun with its own magazine system. Special
// fire utilizes the bayonet in an attack by modifying properties of primary fire
// when activated.
//
// The gun is small enough to allow dual wielding, but because the left hand is
// occupied with the other gun, the shotgun can not be used, so that attack is
// swapped with a melee attack.
//
// by Casey 'Xavious' Johnson, Marc 'Sergeant Kelly' and Azarael
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class CYLOUAW extends BallisticWeapon;

var() sound		MeleeFireSound;

var	bool			bAltNeedCock;			//Should SG cock after reloading
var	bool			bReloadingShotgun;	//Used to disable primary fire if reloading the shotgun
var() name			ShotgunLoadAnim, ShotgunEmptyLoadAnim;
var() name			ShotgunSGAnim;
var() name			CockSGAnim;
var() Sound		TubeOpenSound;
var() Sound		TubeInSound;
var() Sound		TubeCloseSound;
var() int	     	SGShells;
var byte			OldWeaponMode;
var() float			GunCockTime;		// Used so players cant interrupt the shotgun.

replication
{
	reliable if (Role == ROLE_Authority)
	    SGShells;
}

function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	if (MeleeState >= MS_Held)
		Momentum *= 0.5;
	
	super.AdjustPlayerDamage( Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	SetBoneScale(5, 0, 'ElecSight');
}

simulated function DrawWeaponInfo(Canvas C)
{
	NewDrawWeaponInfo(C, 0.705*C.ClipY);
}

simulated function NewDrawWeaponInfo(Canvas C, float YPos)
{
	local int i,Count;
	local float ScaleFactor2;

	local float		ScaleFactor, XL, YL, YL2, SprintFactor;
	local string	Temp;
	local int	TempNum;

	DrawCrosshairs(C);

	ScaleFactor = C.ClipX / 1600;
	ScaleFactor2 = 45 * ScaleFactor;
	
	C.Style = ERenderStyle.STY_Alpha;
	C.DrawColor = class'HUD'.Default.WhiteColor;
	Count = Min(6,SGShells);
	
    for( i=0; i<Count; i++ )
    {
		C.SetPos(C.ClipX - (0.5*i+1) * ScaleFactor2, C.ClipY - 100 * ScaleFactor * class'HUD'.default.HudScale);
		C.DrawTile( Texture'BallisticRecolors3TexPro.CYLO.CYLO-SGIcon',ScaleFactor2, ScaleFactor2, 0, 0, 128, 128);
	}
	
	if (bSkipDrawWeaponInfo)
		return;

	// Draw the spare ammo amount
	C.Font = GetFontSizeIndex(C, -2 + int(2 * class'HUD'.default.HudScale));
	C.DrawColor = class'hud'.default.WhiteColor;
	if (!bNoMag)
	{
		Temp = GetHUDAmmoText(0);
		C.TextSize(Temp, XL, YL);
		C.CurX = C.ClipX - 20 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 120 * ScaleFactor * class'HUD'.default.HudScale - YL;
		C.DrawText(Temp, false);
	}
	if (Ammo[1] != None && Ammo[1] != Ammo[0])
	{
		TempNum = Ammo[1].AmmoAmount;
		C.TextSize(Temp, XL, YL);
		C.CurX = C.ClipX - 160 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 120 * ScaleFactor * class'HUD'.default.HudScale - YL;
		C.DrawText(TempNum, false);
	}

	if (CurrentWeaponMode < WeaponModes.length && !WeaponModes[CurrentWeaponMode].bUnavailable && WeaponModes[CurrentWeaponMode].ModeName != "")
	{
		C.Font = GetFontSizeIndex(C, -3 + int(2 * class'HUD'.default.HudScale));
		C.TextSize(WeaponModes[CurrentWeaponMode].ModeName, XL, YL2);
		C.CurX = C.ClipX - 15 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 130 * ScaleFactor * class'HUD'.default.HudScale - YL2 - YL;
		C.DrawText(WeaponModes[CurrentWeaponMode].ModeName, false);
	}

	// This is pretty damn disgusting, but the weapon seems to be the only way we can draw extra info on the HUD
	// Would be nice if someone could have a HUD function called along the inventory chain
	if (SprintControl != None && SprintControl.Stamina < SprintControl.MaxStamina)
	{
		SprintFactor = SprintControl.Stamina / SprintControl.MaxStamina;
		C.CurX = C.OrgX  + 5    * ScaleFactor * class'HUD'.default.HudScale;
		C.CurY = C.ClipY - 330  * ScaleFactor * class'HUD'.default.HudScale;
		if (SprintFactor < 0.2)
			C.SetDrawColor(255, 0, 0);
		else if (SprintFactor < 0.5)
			C.SetDrawColor(64, 128, 255);
		else
			C.SetDrawColor(0, 0, 255);
		C.DrawTile(Texture'Engine.MenuWhite', 200 * ScaleFactor * class'HUD'.default.HudScale * SprintFactor, 30 * ScaleFactor * class'HUD'.default.HudScale, 0, 0, 1, 1);
	}
}

//===========================================================================
// Shotgun handling.
//===========================================================================

//===========================================================================
// EmptyFire
//
// Cock shotgun if alt and needs cocking
//===========================================================================
simulated function FirePressed(float F)
{
	if (!HasAmmo())
		OutOfAmmo();
	else if (bNeedReload && ClientState == WS_ReadyToFire)
	{
		//Do nothing!
	}
	else if (bCanSkipReload && ((ReloadState == RS_Shovel) || (ReloadState == RS_PostShellIn) || (ReloadState == RS_PreClipOut)))
	{
		ServerSkipReload();
		if (Level.NetMode == NM_Client)
			SkipReload();
	}
	//mod
	else 
	{
		if (F == 0)
		{
			if (ReloadState == RS_None && bNeedCock && !bPreventReload && MagAmmo > 0 && !IsFiring() && level.TimeSeconds > FireMode[0].NextfireTime)
			{
				CommonCockGun(0);
				if (Level.NetMode == NM_Client)
					ServerCockGun(0);
			}
		}
		else if (ReloadState == RS_None && bAltNeedCock && !bPreventReload && SGShells > 0 && !IsFiring() && Level.TimeSeconds > FireMode[1].NextFireTime)
		{
			CommonCockGun(5);
			if (Level.NetMode == NM_Client)
				ServerCockGun(5);
		}
	}
}

//===========================================================================
// PlayCocking
//
// Cocks shotgun on 5
//===========================================================================
simulated function PlayCocking(optional byte Type)
{
	if (Type == 2 && HasAnim(CockAnimPostReload))
		SafePlayAnim(CockAnimPostReload, CockAnimRate, 0.2, , "RELOAD");
	else if (Type == 5)
		SafePlayAnim(CockSGAnim, CockAnimRate, 0.2, , "RELOAD");
	else
		SafePlayAnim(CockAnim, CockAnimRate, 0.2, , "RELOAD");

	if (SightingState != SS_None)
		TemporaryScopeDown(Default.SightingTime*Default.SightingTimeScale);
}

//===========================================================================
// Reload notifies
//===========================================================================
simulated function Notify_TubeSlideOut()	
{	
	PlaySound(TubeOpenSound, SLOT_Misc, 0.5, ,64);	
	ReloadState = RS_PreClipIn;
}
simulated function Notify_TubeIn()          
{   
	local int AmmoNeeded;
	
	PlaySound(TubeInSound, SLOT_Misc, 0.5, ,64);    
	ReloadState = RS_PostClipIn; 
	if (level.NetMode != NM_Client)
	{
		AmmoNeeded = default.SGShells-SGShells;
		if (AmmoNeeded > Ammo[1].AmmoAmount)
			SGShells+=Ammo[1].AmmoAmount;
		else
			SGShells = default.SGShells;   
		Ammo[1].UseAmmo (AmmoNeeded, True);
	}
}
simulated function Notify_TubeSlideIn()	    
{	
	PlaySound(TubeCloseSound, SLOT_Misc, 0.5, ,64);	
}
simulated function Notify_SGCockEnd()	
{
	bAltNeedCock=false;
	ReloadState = RS_GearSwitch;					
}

simulated function bool IsReloadingShotgun()
{
    local name anim;
    local float frame, rate;
    GetAnimParams(0, anim, frame, rate);
	if (Anim == ShotgunLoadAnim)
 		return true;
	return false;
}

function bool BotShouldReloadShotgun ()
{
	if ( (Level.TimeSeconds - Instigator.LastPainTime > 1.0) )
		return true;
	return false;
}

simulated event WeaponTick(float DT)
{
	super.WeaponTick(DT);
	
	if (AIController(Instigator.Controller) != None && bAltNeedCock && AmmoAmount(1) > 0 && BotShouldReloadShotgun() && !IsReloadingShotgun())
		ServerStartReload(1);
}

simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);
	
	if (anim == CockSGAnim || anim == ShotgunEmptyLoadAnim)
	{
		bAltNeedCock=False;
		ReloadState = RS_None;
		ReloadFinished();
		PlayIdle();
	}
	else
		Super.AnimEnd(Channel);
}

//===========================================================================
// ServerStartReload
//
// byte 1 reloads the shotgun.
//===========================================================================
function ServerStartReload (optional byte i)
{
	local int m;
	local array<byte> Loadings[2];
	
	if (bPreventReload)
		return;
	if (ReloadState != RS_None)
		return;
	if (i == 0 && MagAmmo >= default.MagAmmo)
	{
		if (bNeedCock)
		{
			ServerCockGun(0);
			return;
		}
	}
	// Escape on full shells
	if (i == 1 && SGShells >= default.SGShells)
	{
		if (bAltNeedCock)
		{
			ServerCockGun(5);
			return;
		}
	}
	
	if (MagAmmo < default.MagAmmo && Ammo[0].AmmoAmount > 0)
		Loadings[0] = 1;
	if (SGShells < default.SGShells && Ammo[1].AmmoAmount > 0)
		Loadings[1] = 1;
	if (Loadings[0] == 0 && Loadings[1] == 0)
		return;

	for (m=0; m < NUM_FIRE_MODES; m++)
		if (FireMode[m] != None && FireMode[m].bIsFiring)
			StopFire(m);

	bServerReloading = true;
	
	if (i == 1)
		m = 0;
	else m = 1;
	
	if (BallisticAttachment(ThirdPersonActor) != None && BallisticAttachment(ThirdPersonActor).ReloadAnim != '')
		Instigator.SetAnimAction('ReloadGun');
		
	if (Loadings[i] == 1)
	{
		ClientStartReload(i);
		CommonStartReload(i);
	}
	
	else if (Loadings[m] == 1)
	{
		ClientStartReload(m);
		CommonStartReload(m);
	}
}

simulated function ClientStartReload(optional byte i)
{
	if (Level.NetMode == NM_Client)
	{
		if (i == 1)
			CommonStartReload(1);
		else
			CommonStartReload(0);
	}
}

// Prepare to reload, set reload state, start anims. Called on client and server
simulated function CommonStartReload (optional byte i)
{
	local int m;
	if (ClientState == WS_BringUp)
		ClientState = WS_ReadyToFire;
	if (i == 1)
	{
		ReloadState = RS_PreClipOut;
		PlayReloadAlt();
	}
	else
	{
		ReloadState = RS_PreClipOut;
		PlayReload();
	}

	if (bScopeView && Instigator.IsLocallyControlled())
		TemporaryScopeDown(Default.SightingTime*Default.SightingTimeScale);
	for (m=0; m < NUM_FIRE_MODES; m++)
		if (BFireMode[m] != None)
			BFireMode[m].ReloadingGun(i);

	if (i == 0)
	{
		if (bCockAfterReload)
			bNeedCock=true;
		if (bCockOnEmpty && MagAmmo < 1)
			bNeedCock=true;
	}
	bNeedReload=false;
}

simulated function PlayReloadAlt()
{
	if (SGShells == 0)
		SafePlayAnim(ShotgunEmptyLoadAnim, 1, , 0, "RELOAD");
	else
		SafePlayAnim(ShotgunLoadAnim, 1, , 0, "RELOAD");
}

// AI Interface =====
simulated function float RateSelf()
{
	if (!HasAmmo())
		CurrentRating = 0;
	else if (Ammo[0].AmmoAmount < 1 && MagAmmo < 1)
		CurrentRating = Instigator.Controller.RateWeapon(self)*0.3;
	else
		return Super.RateSelf();
	return CurrentRating;
}

// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Result, Height, Dist, VDot;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (AmmoAmount(1) < 1 || bAltNeedCock)
		return 0;
	else if (MagAmmo < 1)
		return 1;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	Height = B.Enemy.Location.Z - Instigator.Location.Z;
	VDot = Normal(B.Enemy.Velocity) Dot Normal(Instigator.Location - B.Enemy.Location);

	Result = FRand()-0.3;
	// Too far for grenade
	if (Dist > 800)
		Result -= (Dist-800) / 2000;
	if (VSize(B.Enemy.Velocity) > 50)
	{
		// Straight lines
		if (Abs(VDot) > 0.8)
			Result += 0.1;
		// Enemy running away
		if (VDot < 0)
			Result -= 0.2;
		else
			Result += 0.2;
	}
	// Higher than enemy
//	if (Height < 0)
//		Result += 0.1;
	// Improve grenade acording to height, but temper using horizontal distance (bots really like grenades when right above you)
	Dist = VSize(B.Enemy.Location*vect(1,1,0) - Instigator.Location*vect(1,1,0));
	if (Height < -100)
		Result += Abs((Height/2) / Dist);

	if (Result > 0.5)
		return 1;
	return 0;
}

function bool CanAttack(Actor Other)
{
	if (bAltNeedCock)
	{
		if (IsReloadingShotgun())
		{
			if ((Level.TimeSeconds - Instigator.LastPainTime > 1.0))
				return false;
		}
		else if (AmmoAmount(1) > 0 && BotShouldReloadShotgun())
		{
			ServerStartReload(1);
			return false;
		}
	}
	return super.CanAttack(Other);
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
	if (Dist > 700)
		Result += 0.3;
	else if (B.Enemy.Weapon != None && B.Enemy.Weapon.bMeleeWeapon)
		Result -= 0.05 * B.Skill;
	if (Dist > 3000)
		Result -= (Dist-3000) / 4000;

	return Result;
}
// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.1;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

simulated function bool HasAmmo()
{
	return true;
}

defaultproperties
{
     ShotgunLoadAnim="ReloadSG"
     ShotgunEmptyLoadAnim="ReloadSGEmpty"
     CockSGAnim="CockSG"
     TubeOpenSound=Sound'BallisticSounds2.M50.M50GrenOpen'
     TubeInSound=Sound'BallisticSounds2.M50.M50GrenLoad'
     TubeCloseSound=Sound'BallisticSounds2.M50.M50GrenClose'
     SGShells=6
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticRecolors3TexPro.CYLO.BigIcon_CYLO'
     BigIconCoords=(X1=16,Y1=30)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     bWT_Shotgun=True
     bWT_Machinegun=True
     ManualLines(0)="Automatic fire. Moderate power, fire rate and recoil."
     ManualLines(1)="Engages the secondary shotgun. Has a shorter range than other shotguns and moderate spread."
     ManualLines(2)="Effective at close to medium range."
     SpecialInfo(0)=(Info="240.0;25.0;0.9;85.0;0.1;0.9;0.4")
     MeleeFireClass=Class'BWBPRecolorsPro.CYLOMeleeFire'
     BringUpSound=(Sound=Sound'BallisticSounds2.M50.M50Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.M50.M50Putaway')
     MagAmmo=28
     CockAnimPostReload="Cock"
     CockAnimRate=1.400000
     CockSound=(Sound=Sound'BallisticSounds2.M50.M50Cock')
     ClipHitSound=(Sound=Sound'BallisticSounds2.M50.M50ClipHit')
     ClipOutSound=(Sound=Sound'BallisticSounds2.M50.M50ClipOut')
     ClipInSound=(Sound=Sound'BallisticSounds2.M50.M50ClipIn')
     ClipInFrame=0.700000
     bCockOnEmpty=True
     bAltTriggerReload=True
     WeaponModes(0)=(bUnavailable=True)
     WeaponModes(1)=(bUnavailable=True)
     bNoCrosshairInScope=True
     SightPivot=(Pitch=64)
     SightOffset=(X=-5.000000,Y=13.600000,Z=19.500000)
     SightDisplayFOV=40.000000
     GunLength=16.000000
     CrouchAimFactor=0.850000
     SightAimFactor=0.200000
     SprintOffSet=(Pitch=-3000,Yaw=-8000)
     AimAdjustTime=100.000000
     AimSpread=16
     AimDamageThreshold=0.000000
     ChaosDeclineTime=1.250000
     ChaosSpeedThreshold=15000.000000
     ChaosAimSpread=3072
     RecoilXCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.150000,OutVal=0.060000),(InVal=0.200000,OutVal=-0.060000),(InVal=0.300000),(InVal=0.400000,OutVal=-0.200000),(InVal=0.600000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.300000),(InVal=1.000000,OutVal=1.000000)))
     RecoilYCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.150000),(InVal=0.300000,OutVal=0.300000),(InVal=0.400000,OutVal=0.550000),(InVal=0.500000,OutVal=0.600000),(InVal=0.600000,OutVal=0.500000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.200000
     RecoilYFactor=0.200000
     RecoilDeclineTime=1.000000
     RecoilDeclineDelay=0.170000
     FireModeClass(0)=Class'BWBPRecolorsPro.CYLOPriFire'
     FireModeClass(1)=Class'BWBPRecolorsPro.CYLOSecondaryFire'
     SelectAnimRate=2.000000
     PutDownAnimRate=1.600000
     PutDownTime=0.330000
     BringUpTime=0.450000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000
     bCanThrow=False
     AmmoClass(0)=Class'BCoreProV55.BallisticAmmo'
     AmmoClass(1)=Class'BCoreProV55.BallisticAmmo'
     Description="Dipheox's most popular weapon, the CYLO Versatile Urban Assault Weapon is designed with one goal in mind: Brutal close quarters combat. The CYLO accomplishes this goal quite well, earning itself the nickname of Badger with its small frame, brutal effectiveness, and unpredictability. UTC refuses to let this weapon in the hands of its soldiers because of its erratic firing and tendency to jam.||The CYLO Versatile UAW is fully capable for urban combat. The rifle's caseless 7.62mm rounds can easily shoot through doors and thin walls, while the shotgun can clear a room quickly with its semi-automatic firing. Proper training with the bayonet can turn the gun itself into a deadly melee weapon."
     DisplayFOV=55.000000
     Priority=54
     HudColor=(G=135)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=4
     GroupOffset=10
     PickupClass=Class'BWBPRecolorsPro.CYLOMk1Pickup'
     PlayerViewOffset=(X=8.000000,Z=-14.000000)
     BobDamping=2.000000
     AttachmentClass=Class'BWBPRecolorsPro.CYLOAttachment'
     IconMaterial=Texture'BallisticRecolors3TexPro.CYLO.SmallIcon_CYLO'
     IconCoords=(X2=127,Y2=31)
     ItemName="CYLO Assault Weapon"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BallisticRecolors4AnimPro.CYLO'
     DrawScale=0.400000
     AmbientGlow=0
     bSelected=True
}
