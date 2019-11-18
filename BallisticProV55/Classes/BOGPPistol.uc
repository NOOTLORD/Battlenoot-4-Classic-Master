//=============================================================================
// BOGPPistol.
//
// Actually a break-open grenade pistol. Now with 100% more sidearm balance!
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class BOGPPistol extends BallisticHandgun;

var() name	GrenadeBone;
var	bool	bUseFlare, bOldUseFlare;
var bool	bHideHead, bCockOtherGun;
var float	LastFlareTime, FlareSwitchTime;

replication
{
	reliable if (Role == ROLE_Authority)
		bUseFlare;
}

// Fire pressed. Change weapon if out of ammo, reload if empty mag or skip reloading if possible
simulated function FirePressed(float F)
{
	if (IsInState('DualAction') || IsInState('PendingDualAction'))
		return;
	if (!HasAmmo() && !IsSlave() && (Othergun == None || !Othergun.HasAmmo()))
	{
		OutOfAmmo();
	}
	else if (bCanSkipReload && ((ReloadState == RS_Shovel) || (ReloadState == RS_PostShellIn) || (ReloadState == RS_PreClipOut)))
	{
		ServerSkipReload();
		if (Level.NetMode == NM_Client)
			SkipReload();
	}
	else if (reloadState == RS_None && bNeedCock && MagAmmo > 0 && !IsFiring() && level.TimeSeconds > FireMode[0].NextfireTime &&
		(Othergun == None || Othergun.bNeedCock || !Othergun.HasAmmo()))
	{
		CommonCockGun();
		if (Level.NetMode == NM_Client)
			ServerCockGun();
	}
	else if (IsMaster())
	{
		Othergun.FirePressed(F);
	}
}

simulated function bool CheckGrenade()
{
	if(bNeedCock)
	{
		Reload(0);
		return false;
	}
	return true;
}

simulated function bool SlaveCanUseMode(int Mode) {return Mode == 0;}
simulated function bool MasterCanSendMode(int Mode) {return Mode == 0;}

// Notifies for grenade loading sounds
simulated function Notify_BOGPOpen()
{
	PlaySound(ClipOutSound.Sound, SLOT_Misc, 0.5, ,64);

	if(bHideHead)
	{
		SetBoneScale(0,0.0,GrenadeBone);
		bHideHead=false;
	}
}
simulated function Notify_BOGPIn()		{	PlaySound(ClipInSound.Sound, SLOT_Misc, 0.5, ,64);		}

simulated function Notify_BOGPClose()	
{	
	PlaySound(ClipHitSound.Sound, SLOT_Misc, 0.5, ,64);		
}

simulated function Notify_BOGPUnhide()	{	SetBoneScale(0,1.0,GrenadeBone);		}

simulated function bool CanReload ()
{
	if (bPreventReload || ReloadState != RS_None || IsInState('DualAction') || (OtherGun!=None && OtherGun.ReloadState != RS_None) || Ammo[0].AmmoAmount < 1)
		return false;
	return true;
}

exec simulated function Reload (optional byte i)
{
	if (bIsPendingHandGun || PendingHandGun != None || ClientState != WS_ReadyToFire)
		return;

	if (OtherGun != None && Othergun.ClientState != WS_ReadyToFire)
		return;
		
	if(bNeedCock)
		CockGun(0);

	else if(IsMaster())
		OtherGun.Reload(i);
}

// Can we do alternating style Semi-Auto firing?
simulated function bool CanAlternate(int Mode)
{
	if (Mode != 0)
		return false;

	return super.CanAlternate(Mode);
}

simulated event PostNetReceive()
{
	if (bUseFlare != bOldUseFlare)
	{
		bOldUseFlare = bUseFlare;
		ClientSwitchFlare();
	}
	Super.PostNetReceive();
}

function ServerSwitchFlare(bool bNewUseFlare)
{
	if(FlareSwitchTime > Level.TimeSeconds || bIsPendingHandGun || PendingHandgun != None)
		return;

	bUseFlare = bNewUseFlare;
	
	CurrentWeaponMode = byte(bNewUseFlare);
	
	if(ReloadState > RS_None || !HasAmmo())
		return;

	CommonCockGun(1);
}

simulated function ClientSwitchFlare()
{
	if(ReloadState > RS_None || !HasAmmo())
		return;

	CommonCockGun(1);
}

function ServerSwitchWeaponMode(byte NewMode)
{
	ServerSwitchFlare(!bUseFlare);
}

// Implement restrictions on when we can fire the weapon depending on when our partner fired.
simulated function Notify_CockAfterFire()
{
	bPreventReload=false;
	
	if((OtherGun != None && BOGPPistol(OtherGun) == None) || (BOGPPistol(OtherGun) != None && (IsSlave() || OtherGun.bNeedCock)))
		return;

	if(bNeedCock)
		CommonCockGun(1);
}

simulated function HandgunRaised (BallisticHandgun Other)
{
	if(Other == self && IsMaster())
	{
		if (bNeedCock)
			CommonCockGun();
	}
	else if(OtherGun != None && Other != self && IsSlave())
	{
		if (OtherGun.bNeedCock)
			OtherGun.CommonCockGun();
	}
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	super.BringUp(PrevWeapon);

	FlareSwitchTime=Level.TimeSeconds+0.6;
	
	if(OtherGun != None) //Azarael
		if(OtherGun.ClientState == WS_BringUp && OtherGun.bNeedCock)
			bCockOtherGun=true;
}

simulated function bool PutDown()
{
	local bool bSuccess;

	bSuccess = Super.PutDown();

	if(bSuccess)
		FlareSwitchTime=Level.TimeSeconds+2.0;
	return bSuccess;
}

simulated function vector ConvertFOVs (vector InVec, float InFOV, float OutFOV, float Distance)
{
	local vector ViewLoc, Outvec, Dir, X, Y, Z;
	local rotator ViewRot;

	ViewLoc = Instigator.Location + Instigator.EyePosition();
	ViewRot = Instigator.GetViewRotation();
	Dir = InVec - ViewLoc;
	GetAxes(ViewRot, X, Y, Z);

    OutVec.X = Distance / tan(OutFOV * PI / 360);
    OutVec.Y = (Dir dot Y) * (Distance / tan(InFOV * PI / 360)) / (Dir dot X);
    OutVec.Z = (Dir dot Z) * (Distance / tan(InFOV * PI / 360)) / (Dir dot X);
    OutVec = OutVec >> ViewRot;

	return OutVec + ViewLoc;
}

// Secondary fire doesn't count for this weapon
simulated function bool HasAmmo()
{
	//First Check the magazine
	if (!bNoMag && FireMode[0] != None && MagAmmo >= FireMode[0].AmmoPerFire)
		return true;
	//If it is a non-mag or the magazine is empty
	if (Ammo[0] != None && FireMode[0] != None && Ammo[0].AmmoAmount >= FireMode[0].AmmoPerFire)
			return true;
	return false;	//This weapon is empty
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	if(Level.TimeSeconds - LastFlareTime > 15.0 && FRand() <= 0.15)
	{
		LastFlareTime = Level.TimeSeconds;
		return 1;
	}

	return 0;
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
		return AIRating;

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	Result = AIRating;
	if (Dist > 800)
		Result -= (Dist-800) / 2000;
	else if (Dist < 500 && B.Enemy.Weapon != None && B.Enemy.Weapon.bMeleeWeapon)
		Result -= 0.2;
	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.3;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

defaultproperties
{
     GrenadeBone="GrenadePistolGrenade"
     bShouldDualInLoadout=False
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny',SkinNum=1)
     AIReloadTime=1.500000
     BigIconMaterial=Texture'BallisticTextures_25.BOGP.BigIcon_BOGP'
     BigIconCoords=(Y1=32,Y2=230)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Splash=True
     bWT_Projectile=True
     ManualLines(0)="Grenade mode launches a grenade with good damage and moderate blast radius. This grenade has an arming delay and upon striking a surface or player when unarmed. will ricochet, dealing only minor damage.|Flare mode will emit a flare which deals upfront damage, burns struck targets over time and obscures their view. If fired into the air, it will eventually explode with a distinctive effect."
     ManualLines(1)="Used to toggle between grenade and flare modes."
     ManualLines(2)="The BORT grenade is effective at medium range and when the player has height advantage. The BORT flare is most effective at close range. Recoil and hip spread are low, except when jumping. When dual wielded, the BORT pistols will fire simultaneously."
     SpecialInfo(0)=(Info="120.0;20.0;0.8;40.0;0.0;0.0;0.6")
     BringUpSound=(Sound=Sound'BallisticSounds2.M806.M806Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.M806.M806Putaway')
     MagAmmo=1
     bNoMag=True
     CockAnim="Reload"
     CockAnimRate=1.500000
     CockSound=(Sound=Sound'BallisticSounds2.M806.M806-Cock')
     ReloadAnimRate=1.250000
     ClipHitSound=(Sound=Sound'BallisticSounds_25.BOGP.BOGP_Close',Volume=1.000000)
     ClipOutSound=(Sound=Sound'BallisticSounds_25.BOGP.BOGP_Open',Volume=1.000000)
     ClipInSound=(Sound=Sound'BallisticSounds_25.BOGP.BOGP_GrenLoad',Volume=1.000000)
     ClipInFrame=0.650000
     WeaponModes(0)=(ModeName="Grenade")
     WeaponModes(1)=(ModeName="Flare",ModeID="WM_SemiAuto",Value=1.000000)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
     bNoCrosshairInScope=True
     SightPivot=(Pitch=300)
     SightOffset=(X=-24.000000,Y=0.080000,Z=8.550000)
     JumpChaos=0.750000
     AimAdjustTime=0.450000
     AimSpread=16
     ChaosDeclineTime=1.000000
     ChaosSpeedThreshold=1250.000000
     ChaosAimSpread=768
     RecoilYawFactor=0.000000
     RecoilXFactor=0.250000
     RecoilYFactor=0.250000
     RecoilDeclineTime=1.000000
     RecoilDeclineDelay=0.800000
     FireModeClass(0)=Class'BallisticProV55.BOGPPrimaryFire'
     FireModeClass(1)=Class'BallisticProV55.BOGPSecondaryFire'
     PutDownTime=0.450000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.400000
     CurrentRating=0.400000
     Description="The BORT-85 Break-Open Grenade Pistol is a compact grenade launcher manufactured by NDTR Industries. The need for a simple and easy to use grenade launcher arose towards the end of the first war, especially in the large industrial zones of various Outworld colonies. Skrith favoured these areas, as they were perfect for the aliens which prefered to be hidden and strike with surprise. The simple design had several benefits, as it was relatively compact, and could fire many different types of ammunition."
     Priority=19
     HudColor=(G=50)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=2
     GroupOffset=1
     PickupClass=Class'BallisticProV55.BOGPPickup'
     PlayerViewOffset=(X=5.000000,Y=6.000000,Z=-7.000000)
     AttachmentClass=Class'BallisticProV55.BOGPAttachment'
     IconMaterial=Texture'BallisticTextures_25.BOGP.SmallIcon_BOGP'
     IconCoords=(X2=127,Y2=31)
     ItemName="BORT-85 Grenade Pistol"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BallisticAnims_25.BOGP'
     DrawScale=0.300000
     Skins(0)=Texture'BallisticTextures_25.BOGP.BOGP_Main'
     Skins(1)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
}
