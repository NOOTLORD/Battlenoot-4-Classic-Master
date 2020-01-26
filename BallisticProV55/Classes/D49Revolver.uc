//=============================================================================
// D49Revolver.
//
// A powerful handgun that behaves like a revolver. Primary fire is a single
// powerful round, secondary fire both barrels at once, if possible.
// Info is stored for the state of each of the six chambers in order to ensure
// proper behaviour. This way the dry firing of empty chambers and altering the
// appearance of fired and missing shells is possible.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class D49Revolver extends BallisticHandgun;

// Sounds played at various stages of revolver reload
var() BUtil.FullSound	RevReloadSound;		// Catch release
var() BUtil.FullSound	RevOpenSound;		// Drum swing open
var() BUtil.FullSound	RevCloseSound;		// Drum shut
var() BUtil.FullSound	RevSpinSound;		// Spin drum
var() BUtil.FullSound	DryFireSound;		// Sound for trying to fire empty chamber

var() rotator			CylinderRotation;	// Rotation aplied to drum
var	  bool				bRevCocked;			// Is it cocked? (for effect only)

// Type of fire
enum EBarrelMode
{
	BM_Neither,
	BM_Primary,
	BM_Both
};
// State of a shell (slot in drum)
enum EShellState
{
	SS_Loaded,
	SS_Fired,
	SS_Empty
};
// Info for a single shell in the drum
struct RevShell
{
	var() EShellState	ShellState;
	var() name			BulletName;
	var() name			ShellName;
	var() byte			NextShell;
};
var() RevShell			Shells[6];			// The six shells (ammo slots) and their info
var() byte				PrimaryShell;		// Shell under primary hammer
var() byte				SecondaryShell;		// Shell under secondary hammer

var   EBarrelMode		NetBarrelMode;
var   EBarrelMode		RealBarrelMode;
var   bool				bBarrelModeUsed;
var   byte				BMByte, OldBMByte;

simulated function RevolverFired(EBarrelMode BarrelsFired)
{
	if (BarrelsFired == BM_Neither)
	{
	    class'BUtil'.static.PlayFullSound(self, DryFireSound);
		if (ClientState != WS_Hidden)
			SafePlayAnim('Cock', 1.0, 0.2);
	}
	if ((BarrelsFired == BM_Primary || BarrelsFired == BM_Both) && Shells[PrimaryShell].ShellState == SS_Loaded)
	{
		Shells[PrimaryShell].ShellState = SS_Fired;
		SetBoneScale(PrimaryShell, 0.0, Shells[PrimaryShell].BulletName);
	}
	
	CylinderRotation.Roll-=10922;
	SetBoneRotation('Revolver', CylinderRotation,0,1.0);

	PrimaryShell = Shells[PrimaryShell].NextShell;
	SecondaryShell = Shells[SecondaryShell].NextShell;

	bRevCocked = false;
	SetBoneRotation('Hammer', rot(0,0,0));

	if (class'BallisticReplicationInfo'.default.bNoReloading)
		NoReloadingCheckUo();
}

simulated function NoReloadingCheckUo()
{
	local int i;

	if (AmmoAmount(0) > 0)
	{
		for (i=0;i<6;i++)
			if (Shells[i].ShellState == SS_Loaded)
				return;

		for(i=0;i<6;i++)
			if (AmmoAmount(0)<=i)
			{
				Shells[i].ShellState = SS_Empty;
				SetBoneScale(i, 0.0, Shells[i].ShellName);
			}
			else
			{
				Shells[i].ShellState = SS_Loaded;
				SetBoneScale(i, 1.0, Shells[i].ShellName);
			}
		PrimaryShell = 0;
		SecondaryShell = 1;
	}
}

simulated function EBarrelMode GetBarrelMode()
{
	local byte b;

	if (Shells[SecondaryShell].ShellState == SS_Loaded)
		b = 2;
	if (Shells[PrimaryShell].ShellState == SS_Loaded)
		b ++;
	return EBarrelMode(b);
}

simulated function Notify_ClipOutOfSight()
{
	local int i, Empties;
	local vector Start;

	for (i=0;i<6;i++)
		if (Shells[i].ShellState == SS_Fired)
			Empties++;
	for(i=0;i<6;i++)
		if (AmmoAmount(0)+MagAmmo<=i)
		{
			Shells[i].ShellState = SS_Empty;
			SetBoneScale(i, 0.0, Shells[i].ShellName);
		}
		else
		{
			Shells[i].ShellState = SS_Loaded;
			SetBoneScale(i, 1.0, Shells[i].ShellName);
		}
	PrimaryShell = 0;
	SecondaryShell = 1;

	if (Instigator.IsLocallyControlled() && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
	{
		if (class'BallisticMod'.default.bEjectBrass && Level.DetailMode > DM_Low)
		{
			Start = Instigator.Location + Instigator.EyePosition() + class'BUtil'.static.AlignedOffset(Instigator.GetViewRotation(), vect(5,1,-5));
			for(i=0;i<Empties;i++)
				Spawn(class'Brass_Magnum', self,, Start+VRand()*2, Instigator.GetViewRotation() + rot(8192,0,0));
		}
	}
	if (Role == ROLE_Authority && ThirdPersonActor!= None)
		D49Attachment(ThirdPersonActor).RevolverEjectBrass(Empties);
}

simulated function Notify_D49Uncock()
{	bRevCocked=false;	}
simulated function Notify_D49Cock()
{	bRevCocked=true;
	class'BUtil'.static.PlayFullSound(self, CockSound);	}
simulated function Notify_D49CockAfterPullout()
{	Notify_D49Cock();	}
simulated function Notify_D49CockAfterFire()
{	Notify_D49Cock();	}
simulated function Notify_D49StartReload()
{    class'BUtil'.static.PlayFullSound(self, RevReloadSound);	}
simulated function Notify_D49SwingOpen()
{
    class'BUtil'.static.PlayFullSound(self, RevOpenSound);
	CylinderRotation.Roll = 0;
	SetBoneRotation('Revolver', CylinderRotation);
	if (ReloadState != RS_None && Shells[0].ShellState==SS_Empty)
	{
		ReloadState = RS_PreClipIn;
		SetAnimFrame(0.38, 0);
	}
}
simulated function Notify_D49SwingClosed()
{	class'BUtil'.static.PlayFullSound(self, RevCloseSound);	}
simulated function Notify_D49Spin()
{	class'BUtil'.static.PlayFullSound(self, RevSpinSound);	}

// Animation notify for when the clip is pulled out
simulated function Notify_ClipOut()
{
	if (ReloadState == RS_None)
		return;
	ReloadState = RS_PreClipIn;
	PlayOwnedSound(ClipOutSound.Sound,ClipOutSound.Slot,ClipOutSound.Volume,ClipOutSound.bNoOverride,ClipOutSound.Radius,ClipOutSound.Pitch,ClipOutSound.bAtten);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	local int i;

	if (PrimaryShell == SecondaryShell)
	{
		for(i=0;i<6;i++)
			if (MagAmmo<=i)
			{
				Shells[i].ShellState = SS_Empty;
				SetBoneScale(i, 0.0, Shells[i].ShellName);
			}
			else
			{
				Shells[i].ShellState = SS_Loaded;
				SetBoneScale(i, 1.0, Shells[i].ShellName);
			}
		PrimaryShell = 0;
		SecondaryShell = 1;
	}

	SetBoneRotation('Hammer', rot(0,0,0));
	Super.BringUp(PrevWeapon);

	if (IsSlave())
		HandgunGroup = Othergun.HandgunGroup;
	else
		HandgunGroup = default.HandgunGroup;
}

simulated state Raising
{
Begin:
	OtherGun.SetBoneScale(8, 0.0, OtherGun.SupportHandBone);
	SafePlayAnim(SelectAnim, 1.5, 0.1);
	SetBoneRotation('Hammer', rot(0,0,0));
	FinishAnim();
	OtherGun.HandgunRaised(self);
	HandgunRaised(self);
	if (ClientState == WS_ReadyToFire)
		PlayIdle();
	GotoState('');
}
simulated state Lowering
{
Begin:
	SetBoneRotation('Hammer', rot(0,0,0));
	SafePlayAnim(PutDownAnim, 1.5, 0.1);
	FinishAnim();
	GotoState('Lowered');
}

simulated function PlayIdle()
{
	if (!bRevCocked && ClientState != WS_Hidden && SightingState != SS_Active && MagAmmo > 0)
		SafePlayAnim('Cock', 1.0, 0.2);
	else
		super.PlayIdle();
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);
	if (bRevCocked && Anim == CockAnim)
	{
		SetBoneRotation('Hammer', rot(-5734,0,0));
		IdleTweenTime=0.0;
	}
	Super.AnimEnd(Channel);
	IdleTweenTime = default.IdleTweenTime;
}

simulated function CommonCockGun(optional byte Type)
{
	if (Role == ROLE_Authority)
		bServerReloading=false;
	ReloadState = RS_None;
	bNeedCock=false;
	if (!bRevCocked)
		SafePlayAnim('Cock', 1.0, 0.2);
}

// Change some properties when using sights...
simulated function SetScopeBehavior()
{
	super.SetScopeBehavior();
	bUseNetAim = default.bUseNetAim || bScopeView;
}													   
simulated function ApplyAimRotation()
{
	ApplyAimToView();
	PlayerViewPivot = default.PlayerViewPivot + (GetAimPivot() + GetRecoilPivot()*0.1) * (DisplayFOV / Instigator.Controller.FovAngle);
}

// See if firing modes will let us fire another round or not
simulated function bool CheckWeaponMode (int Mode)
{
	if (IsInState('DualAction') || IsInState('PendingDualAction'))
		return false;
	if (WeaponModes[CurrentWeaponMode].ModeID ~= "WM_FullAuto" || WeaponModes[CurrentWeaponMode].ModeID ~= "WM_None")
		return true;
	if (Mode > 0 && OtherGun != None && D49Revolver(OtherGun) != None && FireCount < 1)
		return true;
	if (FireCount >= WeaponModes[CurrentWeaponMode].Value && (!IsSlave() || WeaponModes[CurrentWeaponMode].ModeID != "WM_SemiAuto" || Othergun.WeaponModes[Othergun.CurrentWeaponMode].ModeID != "WM_SemiAuto" || Othergun.HandgunGroup == HandgunGroup || LastFireTime > level.TimeSeconds-SingleHeldRate))
		return false;
	if (Othergun != None && CanAlternate(Mode) && Mode == 0)
	{
		if ( (!Othergun.HasAmmoLoaded(Mode) || LastFireTime <= OtherGun.LastFireTime) && FireCount < 1 && Othergun.FireCount < 1 )
			return true;
		return false;
	}
	return true;
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

	return class'BUtil'.static.DistanceAtten(Rating, 0.5, Dist, 768, 3072); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.5;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.5;	}

// End AI Stuff =====

defaultproperties
{
     RevReloadSound=(Sound=Sound'BallisticSounds2.D49.D49-Click',Volume=1.000000)
     RevOpenSound=(Sound=Sound'BallisticSounds2.D49.D49-Open',Volume=1.000000)
     RevCloseSound=(Sound=Sound'BallisticSounds2.D49.D49-Close',Volume=1.000000)
     RevSpinSound=(Sound=Sound'BallisticSounds2.D49.D49-Spin',Volume=1.000000)
     Shells(0)=(BulletName="Bullet1",ShellName="Shell1",NextShell=2)
     Shells(1)=(BulletName="Bullet4",ShellName="Shell4",NextShell=3)
     Shells(2)=(BulletName="Bullet2",ShellName="Shell2",NextShell=4)
     Shells(3)=(BulletName="Bullet5",ShellName="Shell5",NextShell=5)
     Shells(4)=(BulletName="Bullet3",ShellName="Shell3",NextShell=1)
     Shells(5)=(BulletName="Bullet6",ShellName="Shell6")
     bShouldDualInLoadout=False
     HandgunGroup=1
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.500000
     BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_D49'
     SightFXClass=Class'BallisticProV55.D49SightLEDs'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     ManualLines(0)="Fires from a single barrel. Powerful, but short-ranged and has high recoil."
     ManualLines(1)="Fires both barrels at once. Twice as much recoil as the single fire with lower sustained damage output."
     ManualLines(2)="The D49 is very effective at close range. However, it suffers from a cripplingly long reload time. When dual wielded, both pistols will fire simultaneously, allowing the altfire to be used for an extremely powerful attack."
     SpecialInfo(0)=(Info="120.0;10.0;0.6;50.0;1.0;0.0;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.M806.M806Pullout',Volume=0.325000)
     PutDownSound=(Sound=Sound'BallisticSounds2.M806.M806Putaway',Volume=0.325000)
     MagAmmo=6
     CockAnimRate=1.250000
     CockSound=(Sound=Sound'BallisticSounds2.D49.D49-Cock',Volume=1.000000)
     ReloadAnimRate=1.250000
     ClipHitSound=(Volume=0.750000)
     ClipOutSound=(Sound=Sound'BallisticSounds2.D49.D49-ShellOut',Volume=1.000000)
     ClipInSound=(Sound=Sound'BallisticSounds2.D49.D49-ShellIn',Volume=1.000000)
     ClipInFrame=0.650000
     bCockOnEmpty=True
     WeaponModes(0)=(ModeName="Semi-Automatic",ModeID="WM_SemiAuto",)
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
     bNoCrosshairInScope=True
     SightOffset=(X=-30.000000,Y=-0.400000,Z=14.500000)
     SightingTime=0.200000
     SightAimFactor=0.150000
     AimAdjustTime=100.000000
	 SightZoomFactor=0
     AimSpread=16
     AimDamageThreshold=0.000000
     ChaosDeclineTime=0.450000
     ChaosAimSpread=768
     RecoilYawFactor=0.000000
     RecoilXFactor=0.250000
     RecoilYFactor=0.250000
     RecoilDeclineTime=0.800000
     RecoilDeclineDelay=0.350000
     FireModeClass(0)=Class'BallisticProV55.D49PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     PutDownAnimRate=1.250000
     PutDownTime=0.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000
     bSniping=True
     bCanThrow=False
     AmmoClass(0)=Class'BallisticProV55.Ammo_D49Bullets'	 
     Description="Another fine weapon designed by the acclaimed 'Black & Wood' company, the D49 revolver is a true hand cannon. Based on weapons of old, the D49 was intended for non-military use, but rather for self defense and civilian purposes. The dual-barrel design has made it a favourite among it's users, capable of causing massive damage if used correctly, able to easily kill an armored Terran."
     DisplayFOV=50.000000
     Priority=22
     HudColor=(B=255,G=200,R=200)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=2
     GroupOffset=2
     PlayerViewOffset=(X=-2.000000,Y=13.000000,Z=-12.000000)
     PlayerViewPivot=(Pitch=512)
     AttachmentClass=Class'BallisticProV55.D49Attachment'
     IconMaterial=Texture'BallisticUI2.Icons.SmallIcon_D49'
     IconCoords=(X2=127,Y2=31)
     ItemName="D49 Revolver"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BallisticProAnims.D49Revolver'
     DrawScale=0.220000
     Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
     Skins(1)=Texture'BallisticWeapons2.D49.D49RevolverSkin'
     Skins(2)=Texture'BallisticWeapons2.D49.D49ShellsSkin'
     AmbientGlow=10
}
