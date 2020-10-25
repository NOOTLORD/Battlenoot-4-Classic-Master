//=============================================================================
// Weapon class for the MRS138 Shotgun
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
	return 0.5;
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
	return -0.5;
}

// End AI Stuff =====

defaultproperties
{
     ShellBone="shell"
     PlayerSpeedFactor=1.000000
     PlayerJumpFactor=1.000000
     AIReloadTime=1.000000	 
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_MRS138'
     BigIconCoords=(Y1=36,Y2=230)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     InventorySize=12	 
     SpecialInfo(0)=(Info="240.0;25.0;0.5;40.0;0.0;1.0;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.M763.M763Pullout',Volume=0.425000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     PutDownSound=(Sound=Sound'BallisticSounds2.M763.M763Putaway',Volume=0.425000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     MagAmmo=5
     CockAnimRate=1.200000
     CockSound=(Sound=Sound'BallisticSounds1.MRS38.RSS-Cock',Volume=0.850000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ReloadAnim="ReloadLoop"
     ReloadAnimRate=1.500000
     ClipInSound=(Sound=Sound'BallisticSounds1.MRS38.RSS-ShellIn',Volume=1.000000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     ClipInFrame=28.000000
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
     SightZoomFactor=0	 
     SightOffset=(Z=18.00000)
     SightDisplayFOV=30.000000	 
     SightingTime=0.300000
     GunLength=32.000000
     LongGunPivot=(Pitch=4500,Yaw=-8000)
     LongGunOffset=(X=5.000000,Y=10.000000,Z=-11.000000)	
     CrouchAimFactor=0.800000	 
     SightAimFactor=1.000000
	 HipRecoilFactor=1.000000 
     SprintChaos=0.100000	 
     SprintOffSet=(Pitch=-1000,Yaw=-2048)
     AimSpread=0
	 ChaosDeclineTime=0.750000
	 ChaosSpeedThreshold=1200.000000	 
     ChaosAimSpread=0
	 RecoilXCurve=(Points=(,(InVal=0.3,OutVal=0.2),(InVal=0.55,OutVal=0.1),(InVal=0.8,OutVal=0.25),(InVal=1.000000,OutVal=0.4)))
	 RecoilYCurve=(Points=(,(InVal=0.2,OutVal=0.2),(InVal=0.4,OutVal=0.45),(InVal=0.75,OutVal=0.7),(InVal=1.000000,OutVal=1)))
     RecoilPitchFactor=1.000000
     RecoilYawFactor=1.000000
	 RecoilXFactor=0.100000
	 RecoilYFactor=0.100000
	 RecoilDeclineTime=0.500000	 
	 RecoilDeclineDelay=0.650000
     SelectAnimRate=1.000000 
	 PutDownAnimRate=1.500000
	 PutDownTime=0.350000	
     BringUpTime=0.300000	
     DisplayFOV=50.000000	 
     Priority=36	 
     FireModeClass(0)=Class'BallisticProV55.MRS138PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     AIRating=0.800000
     CurrentRating=0.800000
     AmmoClass(0)=Class'BallisticProV55.Ammo_MRS138_Shotgun'
     AmmoClass(1)=Class'BallisticProV55.Ammo_MRS138_Shotgun'	 
     Description="MRS-138"
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=1
     PlayerViewOffset=(X=7.500000,Y=10.000000,Z=-14.000000)
     AttachmentClass=Class'BallisticProV55.MRS138Attachment'
     IconMaterial=Texture'BallisticUI.Icons.SmallIcon_MRS138'
     IconCoords=(X2=127,Y2=31)
     ItemName="MRS-138"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticAnims1.MRS138_FP'
     DrawScale=0.400000	 	 
	 Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticWeapons1.MRS138.MRS138Skin'
	 Skins(2)=Texture'BallisticWeapons1.MRS138.MRS138HeatShield'
	 Skins(3)=Texture'BallisticEffects.Brass.MRS138Shell'
}