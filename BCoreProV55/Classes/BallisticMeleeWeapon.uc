//=============================================================================
// BallisticMeleeWeapon.
//
// Base class for melee weapons that can be used to block the attacks of enemy
// weapons.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticMeleeWeapon extends BallisticWeapon 
	abstract
	HideDropDown
	CacheExempt;

var   bool			bBlocked;		// Currently blocking
var() name			BlockUpAnim;	// Anim for going into blocking
var() name			BlockDownAnim;	// Anim when blocking stops
var() name			BlockIdleAnim;	// Anim when in block mode and idle

var float				MeleeSpreadAngle;

replication
{
	reliable if ( Role<ROLE_Authority )
		ServerSetBlocked;
}

simulated function TickDisplacement(float DT)
{
	if (AimDisplacementEndTime > Level.TimeSeconds)
	{
		AimDisplacementFactor = FMin (AimDisplacementFactor + DT/0.2, 0.75);
		if (!bServerReloading)
			bServerReloading = True;
	}
	else 
	{
		AimDisplacementFactor = FMax(AimDisplacementFactor-DT/0.35, 0);
		if (bServerReloading)
			bServerReloading=False;
	}
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	MeleeSpreadAngle = BallisticMeleeFire(BFireMode[0]).GetCrosshairInaccAngle();
}

function ServerSetBlocked(bool NewValue)
{
	bBlocked=NewValue;
}

simulated function float ChargeBar()
{
	return MeleeFatigue;
}

//simulated function DoWeaponSpecial(optional byte i)
exec simulated function WeaponSpecial(optional byte i)
{
	if (bBlocked)
		return;
	bBlocked=true;
	ServerSetBlocked(bBlocked);
	if (!IsFiring())
		PlayAnim(BlockUpAnim, 1.5);
	IdleAnim = BlockIdleAnim;
}
//simulated function DoWeaponSpecialRelease(optional byte i)
exec simulated function WeaponSpecialRelease(optional byte i)
{
	if (!bBlocked)
		return;
	bBlocked=false;
	ServerSetBlocked(bBlocked);
	if (!IsFiring())
		PlayAnim(BlockDownAnim, 1.5);
	IdleAnim = default.IdleAnim;
}

//Draws simple crosshairs to accurately describe hipfire at any FOV and resolution.
simulated function DrawCrosshairs(canvas C)
{
	local float 		ShortBound, LongBound;
	local float 		OffsetAdjustment;

	// Draw weapon specific Crosshairs
	if (bOldCrosshairs || (bScopeView && bNoCrosshairInScope))
		return;

	//C.SetDrawColor(150,150,255,255);
	C.DrawColor = class'HUD'.default.CrosshairColor;
	
	ShortBound = 2;
	LongBound= 10;
	
	OffsetAdjustment = C.ClipX / 2;
	OffsetAdjustment *= tan (MeleeSpreadAngle) / tan((Instigator.Controller.FovAngle/2) * 0.01745329252);
	
	//hor
	C.SetPos((C.ClipX / 2) - (LongBound + OffsetAdjustment), (C.ClipY/2) - (ShortBound/2));
	C.DrawTileStretched(Texture'Engine.WhiteTexture', LongBound, ShortBound);
	
	C.SetPos((C.ClipX / 2) + OffsetAdjustment, (C.ClipY/2) - (ShortBound/2));
	C.DrawTileStretched(Texture'Engine.WhiteTexture', LongBound, ShortBound);
	
	//ver
	C.SetPos((C.ClipX / 2) - (ShortBound/2), (C.ClipY/2) - (LongBound + OffsetAdjustment/3));
	C.DrawTileStretched(Texture'Engine.WhiteTexture', ShortBound, LongBound);
	
	C.SetPos((C.ClipX / 2) - (Shortbound/2), (C.ClipY/2) + OffsetAdjustment/3);
	C.DrawTileStretched(Texture'Engine.WhiteTexture', ShortBound, LongBound);
	
	
	//centre square
	if (bDrawCrosshairDot)
	{
		C.DrawColor.A = 255;
		C.SetPos((C.ClipX - ShortBound)/2, (C.ClipY - ShortBound)/2);
		C.DrawTileStretched(Texture'Engine.WhiteTexture', ShortBound, ShortBound);
	}
}

simulated event Tick (Float DT)
{
	Super.Tick (DT);
	
	if (LastFireTime < Level.TimeSeconds - RecoilDeclineDelay && MeleeFatigue > 0)
		MeleeFatigue = FMax(0, MeleeFatigue - DT/RecoilDeclineTime);
}

defaultproperties
{
     BlockUpAnim="PrepBlock"
     BlockDownAnim="EndBlock"
     BlockIdleAnim="BlockIdle"
     InventorySize=2
     bNonCocking=True
     WeaponModes(0)=(bUnavailable=True,ModeID="WM_None")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
     bUseSights=False
     SightingTime=0.000000
     CrouchAimFactor=1.000000
     AimSpread=0
     ChaosAimSpread=0
     RecoilDeclineTime=4.000000
     RecoilDeclineDelay=0.750000
     bShowChargingBar=True
}
