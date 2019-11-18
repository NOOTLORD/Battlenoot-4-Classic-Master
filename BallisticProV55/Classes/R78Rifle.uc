//=============================================================================
// R78Rifle.
//
// Powerful, accurate semi automatic rifle with good power and reasonable
// reload time, but low clip capacity. Secondary fire makes it the weapon it is
// by providing a powerful scope. Holding secondary zooms in further initially,
// but the player can still use Prev and Next weapon to adjust.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class R78Rifle extends BallisticWeapon;

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2 && HasAnim(CockAnimPostReload))
		SafePlayAnim(CockAnimPostReload, CockAnimRate, 0.2, , "RELOAD");
	else
		SafePlayAnim(CockAnim, CockAnimRate, 0.2, , "RELOAD");

	if (SightingState != SS_None && Type != 1)
		TemporaryScopeDown(0.5);
}

// Animation notify for when cocking action starts. Used to time sounds
simulated function Notify_CockAimed()
{
	bNeedCock = False;
	ReloadState = RS_Cocking;
	PlayOwnedSound(CockSound.Sound,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
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
function byte BestMode()	{	return 0;	}

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
	Result += (Dist-1000) / 2000;

	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.9;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.9;	}
// End AI Stuff =====

defaultproperties
{
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_R78'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     ManualLines(0)="Bolt-action sniper rifle fire. High damage, long range, slow fire rate and unusually quiet compared to other weapons in its class."
     ManualLines(1)="Engages the scope."
     ManualLines(2)="Does not use tracer rounds. Effective at long range and as a stealth weapon."
     SpecialInfo(0)=(Info="240.0;25.0;0.5;60.0;10.0;0.0;0.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.R78.R78Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.R78.R78Putaway')
	 PutDownTime=0.5			 
     MagAmmo=7
     CockAnim="CockQuick"
     CockSound=(Sound=Sound'BWAddPack-RS-Sounds.TEC.RSMP-Cock',Volume=0.700000)
     ReloadAnimRate=1.250000
     ClipHitSound=(Sound=Sound'BallisticSounds2.R78.R78-ClipHit',Volume=0.700000)
     ClipOutSound=(Sound=Sound'BallisticSounds2.R78.R78-ClipOut',Volume=0.700000)
     ClipInSound=(Sound=Sound'BallisticSounds2.R78.R78-ClipIn',Volume=0.700000)
     ClipInFrame=0.650000
     bCockOnEmpty=True
     WeaponModes(0)=(ModeName="Semi-Automatic")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
     ZoomType=ZT_Logarithmic
     ScopeXScale=1.333000
     ZoomInAnim="ZoomIn"
     ScopeViewTex=Texture'BallisticUI2.R78.RifleScopeView'
     ZoomInSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
     ZoomOutSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
     FullZoomFOV=20.000000
     bNoMeshInScope=True
     bNoCrosshairInScope=True
     SightPivot=(Roll=-1024)
     SightOffset=(X=10.000000,Y=-1.600000,Z=17.000000)
     SightingTime=0.450000
     MinZoom=2.000000
     MaxZoom=16.000000
     ZoomStages=8
     GunLength=80.000000
     CrouchAimFactor=0.600000
     SightAimFactor=0.150000
     SprintOffSet=(Pitch=-1000,Yaw=-2048)
     AimAdjustTime=100.000000
     AimSpread=192
     AimDamageThreshold=0.000000
     ChaosSpeedThreshold=2400.000000
     ChaosAimSpread=2048
     RecoilYawFactor=0.100000
     RecoilXFactor=0.750000
     RecoilYFactor=0.400000
     RecoilDeclineTime=1.000000
     FireModeClass(0)=Class'BallisticProV55.R78PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     BringUpTime=0.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000
     bSniping=True
     bCanThrow=False
     AmmoClass(0)=Class'BCoreProV55.BallisticAmmo'
     AmmoClass(1)=Class'BCoreProV55.BallisticAmmo'
     Description="Originally taken from the design of a bird hunting rifle, the R78 'Raven', is a favourite among military snipers and commando corps. Used to a great extent by the expert marksmen of the New European Army, the Raven, is extremely reliable and capable of incredible damage in a single shot. The added long distance sniping scope makes the R78 one of the most deadly weapons. Of course, the gun is only as good as the soldier using it, with a low clip capacity, long reload times and it's terrible ineffectiveness in close quarters combat."
     DisplayFOV=55.000000
     Priority=33
     HudColor=(B=50,G=50,R=200)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=9
     GroupOffset=2
     PickupClass=Class'BallisticProV55.R78Pickup'
     PlayerViewOffset=(X=6.000000,Y=8.000000,Z=-11.500000)
     AttachmentClass=Class'BallisticProV55.R78Attachment'
     IconMaterial=Texture'BallisticUI2.Icons.SmallIcon_R78'
     IconCoords=(X2=127,Y2=31)
     ItemName="R78A1 Sniper Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=5.000000
     Mesh=SkeletalMesh'BallisticProAnims.R78A1Rifle'
     DrawScale=0.450000
     AmbientGlow=0
     bSelected=True
}