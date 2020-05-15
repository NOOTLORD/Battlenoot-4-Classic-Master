//=============================================================================
// Weapon class for MRS138 Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class MRS138Shotgun extends BallisticProShotgun;

var name			ShellBone;

// Animation notify for when cocking action starts. Used to time sounds
simulated function Notify_CockAimed()
{
	bNeedCock = False;
	PlayOwnedSound(CockSound.Sound,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
}

simulated function Notify_Hideshell()
{
	SetBoneScale(0,0.0,ShellBone);
}

simulated function Notify_Showshell()
{
	SetBoneScale(0,1.0,ShellBone);
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

    return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, BallisticProShotgunFire(BFireMode[0]).CutOffStartRange, BallisticProShotgunFire(BFireMode[0]).CutOffDistance);}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	if (AIController(Instigator.Controller) == None)
		return 0.5;
	return AIController(Instigator.Controller).Skill / 7;
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
	local Bot B;
	local float Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return -0.5;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

    return 0.3 - (B.Skill / 6) * (1-(Dist/3000));
}

// End AI Stuff =====

defaultproperties
{
     ShellBone="shell"
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_MRS138'
     BigIconCoords=(Y1=36,Y2=230)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Shotgun=True
     SpecialInfo(0)=(Info="240.0;25.0;0.5;40.0;0.0;1.0;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.M763.M763Pullout',Volume=0.425000)
     PutDownSound=(Sound=Sound'BallisticSounds2.M763.M763Putaway',Volume=0.425000)
	 PutDownAnimRate=1.5
	 PutDownTime=0.35
     MagAmmo=5
     CockAnimRate=1.200000
     CockSound=(Sound=Sound'BallisticSounds1.MRS38.RSS-Cock',Volume=0.850000)
     ReloadAnim="ReloadLoop"
     ReloadAnimRate=1.500000
     ClipInSound=(Sound=Sound'BallisticSounds1.MRS38.RSS-ShellIn',Volume=1.000000)
     ClipInFrame=0.375000
     bCockOnEmpty=True
     WeaponModes(0)=(ModeName="Pump-Action",ModeID="WM_SemiAuto",)
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0	 
     bCanSkipReload=True
     bShovelLoad=True
     StartShovelAnim="PrepReload"
     StartShovelAnimRate=1.400000
     EndShovelAnim="EndReload"
     EndShovelAnimRate=1.600000
     bNoCrosshairInScope=True
     SightOffset=(Z=18.00000)
     SightingTime=0.300000
	 SightZoomFactor=0
     GunLength=32.000000
     LongGunPivot=(Pitch=4500,Yaw=-8000)
     SightAimFactor=0.100000
     SprintOffSet=(Pitch=-1000,Yaw=-2048)
     AimAdjustTime=100.000000
     AimSpread=0
     AimDamageThreshold=0.000000
     ChaosDeclineTime=0.750000
     ChaosSpeedThreshold=1200.000000
     ChaosAimSpread=0
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=0.000000),(InVal=0.300000,OutVal=0.100000),(InVal=1.000000,OutVal=0.000000)))
     RecoilYCurve=(Points=(,(InVal=0.300000,OutVal=0.200000),(InVal=1.000000)))
     RecoilXFactor=0.15
	 RecoilYFactor=0.2
     RecoilDeclineDelay=0.650000
     FireModeClass(0)=Class'BallisticProV55.MRS138PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     AIRating=0.800000
     CurrentRating=0.800000
     AmmoClass(0)=Class'BallisticProV55.Ammo_MRS138_Shotgun'
     AmmoClass(1)=Class'BallisticProV55.Ammo_MRS138_Shotgun'	 
     Description="MRS-138"
     DisplayFOV=50.000000
     Priority=36
     HudColor=(B=255,G=200,R=200)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=1
     GroupOffset=3
     PlayerViewOffset=(X=7.500000,Y=10.000000,Z=-14.000000)
     AttachmentClass=Class'BallisticProV55.MRS138Attachment'
     IconMaterial=Texture'BallisticUI.Icons.SmallIcon_MRS138'
     IconCoords=(X2=127,Y2=31)
     ItemName="MRS-138 Shotgun"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticAnims1.MRS138_FP'
     DrawScale=0.400000	 	 
     AmbientGlow=5
	 Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticWeapons1.MRS138.MRS138Skin'
	 Skins(2)=Texture'BallisticWeapons1.MRS138.MRS138HeatShield'
	 Skins(3)=Texture'BallisticEffects.Brass.MRS138Shell'
}