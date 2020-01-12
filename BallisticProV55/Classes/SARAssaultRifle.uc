//=============================================================================
// SARAssaultRifle.
//
// Highly compact, but innacurate assault rifle with switchable stock,
// flash, large mag, quick reloading and red-dot sights.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class SARAssaultRifle extends BallisticWeapon;

var   name		StockOpenAnim;
var   name		StockCloseAnim;
var   bool		bStockOpen, bStockOpenRotated;

// This uhhh... thing is added to allow manual drawing of brass OVER the muzzle flash
struct UziBrass
{
	var() actor Actor;
	var() float KillTime;
};
var   array<UziBrass>	UziBrassList;

replication
{
	reliable if (Role == ROLE_Authority)
		ServerSwitchStock;
}

simulated function AdjustStockProperties ()
{
	if (bStockOpen)
	{
		// Long Gun related
	    LongGunPivot 	= rot(4000, -12000, 0);
    	LongGunOffset	= vect(15, 20, -7);
		GunLength 		= 64;
		
		// Weapon bonuses
		CrouchAimFactor		= 0.7;
		BFireMode[0].RecoilPerShot = 128;
		BFireMode[0].FireChaos=0.030000;
		SightingTime	=	0.35;
		RecoilMinRandFactor=0;
	}
	else
	{
		// Long Gun related
		GunLength	 		= default.GunLength;
    	LongGunPivot		= default.LongGunPivot;
    	LongGunOffset		= default.LongGunOffset;
		
		// Weapon Bonuses
		CrouchAimFactor		= default.CrouchAimFactor;
		BFireMode[0].RecoilPerShot = BFireMode[0].default.RecoilPerShot;
		BFireMode[0].FireChaos = BFireMode[0].default.FireChaos;
		SightingTime = default.SightingTime;
		RecoilMinRandFactor= default.RecoilMinRandFactor;
	}
}

function ServerSwitchStock(bool bNewValue)
{
	bStockOpen = bNewValue;
	SwitchStock(bNewValue);
	AdjustStockProperties();
}
//simulated function DoWeaponSpecial(optional byte i)
exec simulated function WeaponSpecial(optional byte i)
{
	if (ReloadState != RS_None)
		return;
	if (Clientstate != WS_ReadyToFire)
		return;

	if (!bStockOpen)
		SetStockRotation();

	bStockOpen = !bStockOpen;

	if (!bStockOpen)
		SetStockRotation();

	TemporaryScopeDown(0.4);
	ServerSwitchStock(bStockOpen);
	SwitchStock(bStockOpen);
	AdjustStockProperties();
}

simulated function SwitchStock(bool bNewValue)
{
	if (Role == ROLE_Authority)
		bServerReloading = True;
	ReloadState = RS_GearSwitch;
	
	if (bNewValue)
		PlayAnim(StockOpenAnim);
	else
		PlayAnim(StockCloseAnim);
}

simulated function SetStockRotation()
{
	if (bStockOpen)
	{
		SetBoneLocation('Stock',vect(-38.472,0,0),1.0);
		bStockOpenRotated = true;
	}
	else
	{
		SetBoneLocation('Stock',vect(0,0,0),1.0);
		bStockOpenRotated = false;
	}
}

simulated function PlayIdle()
{
	if (bStockOpen && !bStockOpenRotated)
	{
		SetStockRotation();
		IdleTweenTime=0.0;
		super.PlayIdle();
		IdleTweenTime=default.IdleTweenTime;
	}
	else
	{	if (!bStockOpen && bStockOpenRotated)
			SetStockRotation();
		super.PlayIdle();
	}

	if (!bPendingSightUp || SightingState != SS_None || bScopeView || !CanPlayAnim(IdleAnim, ,"IDLE"))
		return;
	FreezeAnimAt(0.0);
}

simulated function SetScopeBehavior()
{
	bUseNetAim = default.bUseNetAim || bScopeView;
	if (bScopeView)
	{
		ViewAimFactor = 1.0;
		ViewRecoilFactor = 1.0;
		AimAdjustTime *= 1.5;
		AimSpread *= SightAimFactor;
		ChaosAimSpread *= SightAimFactor;
	}
	else

	{
		//caused flicker coming out of scope - regulated differently for server & client!
		if(Level.NetMode == NM_DedicatedServer)
			ViewAimFactor = default.ViewAimFactor;

		ViewRecoilFactor = default.ViewRecoilFactor;
		AimAdjustTime = default.AimAdjustTime;
		AimSpread = default.AimSpread;
		AimSpread *= BCRepClass.default.AccuracyScale;
		ChaosAimSpread = default.ChaosAimSpread;
		ChaosAimSpread *= BCRepClass.default.AccuracyScale;
	}
}

simulated function PlayReload()
{
	if (MagAmmo < 1)
		SetBoneScale (1, 0.0, 'Bullet');

	super.PlayReload();
}

simulated function Notify_ClipOutOfSight()
{
	SetBoneScale (1, 1.0, 'Bullet');
}

simulated function bool ReadyToFire(int Mode)
{
    local int alt;

    if ( Mode == 0 )
        alt = 1;
    else
        alt = 0;

	if (FireMode[Mode] == None)
		return false;

    if ( ((FireMode[alt] != None && FireMode[alt] != FireMode[Mode]) && FireMode[alt].bIsFiring)
		|| !FireMode[Mode].AllowFire()
		|| (FireMode[Mode].NextFireTime > Level.TimeSeconds + FireMode[Mode].PreFireTime) )
    {
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.6, Dist, BallisticRangeAttenFire(BFireMode[0]).CutOffStartRange, BallisticRangeAttenFire(BFireMode[0]).CutOffDistance); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.4;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.4;	}

// End AI Stuff =====

defaultproperties
{
	 AIRating=0.72
	 CurrentRating=0.72
     StockOpenAnim="StockOn"
     StockCloseAnim="StockOff"
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticTextures3.ui.BigIcon_SAR12'
     BigIconCoords=(Y1=24,Y2=250)
     SightFXClass=Class'BallisticProV55.SARSightDot'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     bWT_Machinegun=True
     ManualLines(0)="Automatic 5.56mm fire. Slightly shorter range than full-size assault rifles. Low damage and moderate recoil by default."
     ManualLines(1)="Engages the frontal flash device. Inflicts a medium-duration blind upon enemies. The effect is more potent the closer the foe is both to the point of aim and to the user."
     ManualLines(2)="The Weapon Function key engages or disengages the stock. By default, the stock is disengaged, granting the SAR-12 superior hipfire but more recoil than similar weapons. Extending the stock reduces the recoil and widens the hipfire.||Effective at close to medium range, depending upon specialisation."
     BringUpSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Putaway')
     MagAmmo=40
     CockAnimPostReload="ReloadEndCock"
     CockAnimRate=1.250000
     CockSound=(Sound=Sound'BallisticSounds3.SAR.SAR-Cock')
     ReloadAnimRate=1.100000
     ClipOutSound=(Sound=Sound'BallisticSounds3.SAR.SAR-ClipOut')
     ClipInSound=(Sound=Sound'BallisticSounds3.SAR.SAR-ClipIn')
     ClipInFrame=0.650000
     WeaponModes(0)=(bUnavailable=True)
     WeaponModes(1)=(Value=5.000000)
     bNoCrosshairInScope=True
     SightPivot=(Pitch=350)
     SightOffset=(X=20.000000,Y=-0.010000,Z=12.400000)
     SightDisplayFOV=25.000000
     SightingTime=0.250000
     GunLength=16.000000
     CrouchAimFactor=1.000000
     SightAimFactor=0.200000
     SprintOffSet=(Pitch=-3000,Yaw=-4000)
     AimAdjustTime=0.300000
     AimSpread=12
     ChaosDeclineTime=1.250000
     ChaosSpeedThreshold=15000.000000
     ChaosAimSpread=2560
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=-0.060000),(InVal=0.400000,OutVal=0.110000),(InVal=0.500000,OutVal=-0.120000),(InVal=0.600000,OutVal=0.130000),(InVal=0.800000,OutVal=0.160000),(InVal=1.000000)))
     RecoilYCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.230000),(InVal=0.400000,OutVal=0.360000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.250000
     RecoilYFactor=0.250000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.150000
     FireModeClass(0)=Class'BallisticProV55.SARPrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     SelectForce="SwitchToAssaultRifle"
     bShowChargingBar=True
     Description="With a growing number of operations and battles taking place in urban and industial enviroments, the UTC realized that their ground infantry units were in dire need of a more effective, balanced weapon system for indoor combat. UTC soldiers fighting in the close confines of urban structures and industrial installatons needed a highly compact, reliable and manouverable weapon, but it needed the power to blast through light walls and take down the agile alien forces they were faced with.||The result was the development of the Sub-Assault Rifle, the most well known of which is the S-AR 12. These weapons have the power of an assault rifle, usually using rifle ammunition such as 5.56mm rounds, and the manouverability of a compact sub-machinegun. Accuracy was not an issue due to the extremely short range of most of the encounters in urban combat."
     DisplayFOV=55.000000
     Priority=32
     HudColor=(G=200,R=100)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=4
     GroupOffset=4
     PickupClass=Class'BallisticProV55.SARPickup'
     PlayerViewOffset=(X=5.000000,Y=9.000000,Z=-11.000000)
     AttachmentClass=Class'BallisticProV55.SARAttachment'
     IconMaterial=Texture'BallisticTextures3.ui.SmallIcon_SAR12'
     IconCoords=(X2=127,Y2=31)
     ItemName="Sub-Assault Rifle 12"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticProAnims.SAR'
     DrawScale=0.300000
     SoundPitch=56
     SoundRadius=32.000000
}
