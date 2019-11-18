//=============================================================================
// PS9mPistol.
//
// Soviet assassin pistol. Fires darts that blur screen. Alt is medical dart.
// This gun is for cool people.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class PS9mPistol extends BallisticHandGun;

var() name			GrenBone;			
var() name			GrenBoneBase;
var() name			GrenadeLoadAnim;	//Anim for grenade reload
var   bool			bLoaded;


var() Sound		GrenSlideSound;		//Sounds for grenade reloading
var() Sound		GrenLoadSound;		//	

var() sound		PartialReloadSound;	// Silencer stuck on sound
var() name			HealAnim;		// Anim for murdering Simon
var() sound		HealSound;		// The sound of a thousand dying orphans

simulated function bool SlaveCanUseMode(int Mode) {return Mode == 0;}
simulated function bool MasterCanSendMode(int Mode) {return Mode == 0;}

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (!bLoaded)
	{
		SetBoneScale (0, 0.0, GrenBone);
		SetBoneScale (1, 0.0, GrenBoneBase);
	}

	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		ReloadAnim = 'ReloadOpen';
		IdleAnim = 'IdleOpen';
	}
	else
	{
		ReloadAnim = 'Reload';
		IdleAnim = 'Idle';
	}

	super.BringUp(PrevWeapon);
}

function ServerWeaponSpecial(optional byte i)
{
	if (bLoaded)
	{
		PlayAnim(HealAnim, 1.1, , 0);
		ReloadState = RS_Cocking;
	}
}

exec simulated function WeaponSpecial(optional byte i)
{
	if (ReloadState != RS_None)
		return;
	if (Clientstate != WS_ReadyToFire)
		return;
	TemporaryScopeDown(0.5);
	ServerWeaponSpecial();
	if (bLoaded)
	{
		PlayAnim(HealAnim, 1.1, , 0);
		ReloadState = RS_Cocking;
	}
}


simulated function Notify_DartHeal()
{
	PlaySound(HealSound, SLOT_Misc, 1.5, ,64);
	//Ammo[1].UseAmmo (1, True);
	DoDartEffect(Instigator, Instigator);
	bLoaded = false;
}

static function DoDartEffect(Actor Victim, Pawn Instigator)
{
	local PS9mDartHeal HP;

	if(Pawn(Victim) == None || Vehicle(Victim) != None || Pawn(Victim).Health <= 0)
		Return;

	HP = Victim.Level.Spawn(class'PS9mDartHeal', Pawn(Victim).Owner);

	HP.Instigator = Instigator;

    if(Victim.Role == ROLE_Authority && Instigator != None && Instigator.Controller != None)
		HP.InstigatorController = Instigator.Controller;

	HP.Initialize(Victim);
}

// Load in a grenade
simulated function LoadGrenade()
{
	if (Ammo[1].AmmoAmount < 1 || bLoaded)
		return;
	if (ReloadState == RS_None)
		PlayAnim(GrenadeLoadAnim, 1.1, , 0);
}

// Notifys for greande loading sounds
simulated function Notify_GrenVisible()	{	SetBoneScale (0, 1.0, GrenBone); SetBoneScale (1, 1.0, GrenBoneBase);	ReloadState = RS_PreClipOut;}
simulated function Notify_GrenLoaded()	
{
	PS9mAttachment(ThirdPersonActor).bGrenadier=true;
	PS9mAttachment(ThirdPersonActor).IAOverride(True);	
	PlaySound(GrenLoadSound, SLOT_Misc, 0.5, ,64);	
	Ammo[1].UseAmmo (1, True);
}

simulated function Notify_GrenReady()	{	ReloadState = RS_None; bLoaded = true;	}
simulated function Notify_GrenLaunch()	
{
	SetBoneScale (0, 0.0, GrenBone); 
	PS9mAttachment(ThirdPersonActor).IAOverride(False);
	PS9mAttachment(ThirdPersonActor).bGrenadier=false;	
}

simulated function Notify_GrenInvisible()	{ SetBoneScale (1, 0.0, GrenBoneBase);	}

simulated function PlayReload()
{
    if (MagAmmo < 1)
    {
       ReloadAnim='ReloadOpen';
       ClipInSound.Sound=default.ClipInSound.Sound;
    }
    else
    {
       ReloadAnim='Reload';
       ClipInSound.Sound=PartialReloadSound;
    }
	SafePlayAnim(ReloadAnim, ReloadAnimRate, , 0, "RELOAD");
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);
	if (Anim == HealAnim)
		ReloadState = RS_None;
	if (Anim == 'FireOpen' || Anim == 'Pullout' || Anim == 'Fire' || Anim == 'Dart_Fire' || Anim == 'Dart_FireOpen' ||Anim == CockAnim || Anim == ReloadAnim)
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			IdleAnim = 'IdleOpen';
			ReloadAnim = 'ReloadOpen';
		}
		else
		{
			IdleAnim = 'Idle';
			ReloadAnim = 'Reload';
		}
	}
	Super.AnimEnd(Channel);
}


simulated function bool CanAlternate(int Mode)
{
	if (Mode != 0)
		return false;
	return super.CanAlternate(Mode);
}

simulated state Lowering// extends DualAction
{
Begin:
	SafePlayAnim(PutDownAnim, 1.75, 0.1);
	FinishAnim();
	GotoState('Lowered');
}


simulated function SetDualMode (bool bDualMode)
{
	AdjustUziProperties(bDualMode);
}
simulated function AdjustUziProperties (bool bDualMode)
{
//	AimAdjustTime		= default.AimAdjustTime;
	AimSpread 			= default.AimSpread;
	ViewAimFactor		= default.ViewAimFactor;
	ViewRecoilFactor	= default.ViewRecoilFactor;
	ChaosDeclineTime	= default.ChaosDeclineTime;
	ChaosSpeedThreshold	= default.ChaosSpeedThreshold;
	ChaosAimSpread		= default.ChaosAimSpread;
	ChaosAimSpread 		*= BCRepClass.default.AccuracyScale;

	RecoilPitchFactor	= default.RecoilPitchFactor;
	RecoilYawFactor		= default.RecoilYawFactor;
	RecoilXFactor		= default.RecoilXFactor;
	RecoilYFactor		= default.RecoilYFactor;
	RecoilDeclineTime	= default.RecoilDeclineTime;

	if (bDualMode)
	{
		if (Instigator.IsLocallyControlled() && SightingState == SS_Active)
			StopScopeView();
		SetBoneScale(8, 0.0, SupportHandBone);
		if (AIController(Instigator.Controller) == None)
			bUseSpecialAim = true;
//		AimAdjustTime		*= 1.0;
		AimSpread			*= 1.4;
		ViewAimFactor		*= 0.6;
		ViewRecoilFactor	*= 1.75;
		ChaosDeclineTime	*= 1.2;
		ChaosSpeedThreshold	*= 0.8;
		ChaosAimSpread		*= 1.2;
		RecoilPitchFactor	*= 1.2;
		RecoilYawFactor		*= 1.2;
		RecoilXFactor		*= 1.2;
		RecoilYFactor		*= 1.2;
//		RecoilMax			*= 1.0;
		RecoilDeclineTime	*= 1.2;
	}
	else
	{
		SetBoneScale(8, 1.0, SupportHandBone);
		bUseSpecialAim = false;
	}
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Dist;
	local Vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (!HasAmmoLoaded(0))
		return 1;

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);

	if (Dist > 200)
		return 0;
	if (Dist < FireMode[1].MaxRange())
		return 1;
	return Rand(2);
}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;
	local vector Dir;

	if (IsSlave())
		return 0;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return Super.GetAIRating();

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	Result = Super.GetAIRating();
	if (!HasMagAmmo(0) && !HasNonMagAmmo(0))
	{
		if (Dist > 400)
			return 0;
		return Result / (1+(Dist/400));
	}

	if (Dist < 500)
		Result += 0.3;
	if (Dist > 1000)
		Result -= (Dist-1000) / 4000;

	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.8;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.8;	}
// End AI Stuff =================================


simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

// =============================================

defaultproperties
{
	ManualLines(0)="Rapid automatic dart fire. High DPS and low recoil, but no penetration and very low magazine capacity."
	ManualLines(1)="Readies a medical dart. When a medical dart has been readied, firing again will launch the dart. Allies will receive a significant health boost."
	ManualLines(2)="Effective at close range and support."																																								  													   
     GrenBone="Dart"
     GrenBoneBase="MuzzleAttachment"
     GrenadeLoadAnim="DartOn"
     GrenSlideSound=Sound'BallisticSounds2.M50.M50GrenOpen'
     GrenLoadSound=Sound'BallisticSounds2.M50.M50GrenLoad'
     PartialReloadSound=Sound'PackageSounds4ProExp.Stealth.Stealth-MagInS2'
     HealAnim="Heal"
     HealSound=Sound'PackageSounds4ProExp.Stealth.Stealth-Heal'
     bShouldDualInLoadout=False
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticRecolors4TexPro.Stealth.BigIcon_PS9M'
     BigIconCoords=(X1=96,Y1=16,X2=418,Y2=255)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     bWT_Heal=True
     SpecialInfo(0)=(Info="320.0;25.0;1.0;110.0;2.0;0.1;0.1")
     BringUpSound=(Sound=Sound'PackageSounds4ProExp.Stealth.Stealth-Pickup')
     PutDownSound=(Sound=Sound'BallisticSounds2.M806.M806Putaway')
     MagAmmo=20
     CockSound=(Sound=Sound'BallisticSounds2.M806.M806-Cock',Volume=0.750000,Radius=32.000000)
     ClipHitSound=(Sound=Sound'PackageSounds4ProExp.Stealth.Stealth-MagInS1',Volume=0.750000,Radius=32.000000)
     ClipOutSound=(Sound=Sound'PackageSounds4ProExp.Stealth.Stealth-MagOut',Volume=0.750000,Radius=32.000000)
     ClipInSound=(Sound=Sound'PackageSounds4ProExp.Stealth.Stealth-MagIn',Volume=0.750000,Radius=32.000000)
     ClipInFrame=0.650000
     bCockOnEmpty=True
     WeaponModes(0)=(ModeName="Semi-Automatic",bUnavailable=True)
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(ModeName="Full auto")
     bNoCrosshairInScope=True
     SightPivot=(Pitch=1024)
     SightOffset=(X=-10.000000,Y=11.400000,Z=11.250000)
     SightDisplayFOV=40.000000
     SightingTime=0.200000
     SprintOffSet=(Pitch=-1000,Yaw=-2048)
     AimAdjustTime=100.000000
     AimSpread=16
     AimDamageThreshold=0.000000
     ChaosDeclineTime=0.450000
     ChaosAimSpread=768
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.400000),(InVal=1.000000,OutVal=-0.200000)))
     RecoilYCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.650000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
     RecoilYawFactor=0.400000
     RecoilXFactor=0.300000
     RecoilYFactor=0.200000
     FireModeClass(0)=Class'BWBPRecolorsPro.PS9mPrimaryFire'
     FireModeClass(1)=Class'BWBPRecolorsPro.PS9mPrimaryFire'
     PutDownTime=0.700000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000
     bCanThrow=False
     Description="PS-9m Stealth Pistol||Manufacturer: Zavod Tochnogo Voorujeniya (ZTV Export)|Primary: Tranquilizer Dart Fire|Secondary: FMD Medical Dart"
     Priority=65
     HudColor=(B=130,G=100,R=100)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=2
     PickupClass=Class'BWBPRecolorsPro.PS9mPickup'
     PlayerViewOffset=(X=3.000000,Y=-2.000000,Z=-8.500000)
     BobDamping=2.000000
     AttachmentClass=Class'BWBPRecolorsPro.PS9mAttachment'
     IconMaterial=Texture'BallisticRecolors4TexPro.Stealth.SmallIcon_PS9M'
     IconCoords=(X2=127,Y2=31)
     ItemName="PS-9m Stealth Pistol"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BallisticRecolors4AnimProExp.Stealth_FP'
     DrawScale=0.300000
     Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
     Skins(1)=Texture'BallisticRecolors4TexPro.Stealth.Stealth-Main'
     AmbientGlow=0
     bSelected=True
}
