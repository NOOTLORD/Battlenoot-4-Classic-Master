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

var float				MeleeSpreadAngle;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	MeleeSpreadAngle = BallisticMeleeFire(BFireMode[0]).GetCrosshairInaccAngle();
}


function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	local class<BallisticDamageType> BDT;
	
	if (InstigatedBy != None && InstigatedBy.Controller != None && InstigatedBy.Controller.SameTeamAs(InstigatorController))
		return;
		
	BDT = class<BallisticDamageType>(DamageType);
	
	if (VSize(Instigator.Location - InstigatedBy.Location) < 512 && VSize(Momentum) < 60)
		Momentum = vect(0,0,0);
	else Momentum *= 0.5;
		
	if (bBerserk)
		Damage *= 0.75;
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

// AI Interface =====
function bool CanAttack(Actor Other)
{
	return VSize(Other.Location - Instigator.Location) < FireMode[0].MaxRange() * 2;
}

function float GetAIRating()
{
	local Bot B;
	local BallisticWeapon BW;
	local vector Dir;
	local float Dist;
	local float Rating;

	B = Bot(Instigator.Controller);

	if ( B == None)
		return AIRating;

	if (B.Enemy == None)
		return 0; // almost certainly useless against non-humans

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	// favour melee when attacking the enemy's back
	if (vector(B.Enemy.Rotation) dot Normal(Dir) < 0.0)
		Rating += 0.08 * B.Skill;
	
	BW = BallisticWeapon(B.Enemy.Weapon);
	
	if (BW != None)
	{ 
		// discourage melee-on-melee
		if (BW.bMeleeWeapon)
			Rating *= 0.75;
			
		// trying this against a shotgun or a PDW is a very bad idea
		if (BW.bWT_Shotgun || BW.InventoryGroup == 3)
			Rating = 0;	
	}

	Rating = class'BUtil'.static.DistanceAtten(Rating, 0.4, Dist, 128, 128);

	return Rating * (1 - MeleeFatigue);
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	return 1;
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
	return -1;
}

defaultproperties
{
     InventorySize=2
	 bNoMag=True
     bNonCocking=True
	 AIRating=0.700000
	 CurrentRating=0.700000
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
     bShowChargingBar=False
}
