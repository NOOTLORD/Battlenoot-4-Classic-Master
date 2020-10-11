//=============================================================================
// Weapon class for the AH-208 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class AH208Pistol extends BallisticWeapon;

var(AH208Pistol) name		BulletBone;			// Bone to use for hiding bullet

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		IdleAnim = 'OpenIdle';
		ReloadAnim = 'OpenReload';
		SelectAnim = 'OpenPullout';
		BringUpTime=default.BringUpTime;
		SetBoneScale(4,0.0,BulletBone);
	}
	else
	{
		IdleAnim = 'Idle';
		ReloadAnim = 'Reload';
		SelectAnim = 'Pullout';
		BringUpTime=default.BringUpTime;
	}

	Super.BringUp(PrevWeapon);
}

simulated function Notify_HideBullet()
{
	if (MagAmmo < 1)
		SetBoneScale(4,0.0,BulletBone);
}


simulated function Notify_ShowBullet()
{
	SetBoneScale(4,1.0,BulletBone);
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);

	if (Anim == 'OpenFire' || Anim == 'Fire' || Anim == 'OpenFire' || Anim == 'OpenSightFire' || Anim == CockAnim || Anim == ReloadAnim)
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			IdleAnim = 'OpenIdle';
			ReloadAnim = 'OpenReload';
			PutDownAnim = 'OpenPutaway';
			SelectAnim = 'OpenPullout';
		}
		else
		{
			IdleAnim = 'Idle';
			ReloadAnim = 'Reload';
			PutDownAnim = 'Putaway';
			SelectAnim = 'Pullout';
		}
	}
	Super.AnimEnd(Channel);
}		   							

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()	{	return 0;	}


function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	Result = Super.GetAIRating();
	if (Dist < 500)
		Result -= 1-Dist/500;
	else if (Dist < 3000)
		Result += (Dist-1000) / 2000;
	else
		Result = (Result + 0.66) - (Dist-3000) / 2500;
	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.3;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}

// End AI Stuff =====

defaultproperties
{
     BulletBone="Bullet"
     AIReloadTime=1.500000
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_AH208-Pistol'
     BigIconCoords=(X1=47,Y1=16,X2=455,Y2=245)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     InventorySize=8
     bWT_Bullet=True
     BringUpSound=(Sound=Sound'BallisticSounds2.M806.M806Pullout',Volume=0.400000)
     PutDownSound=(Sound=Sound'BallisticSounds2.M806.M806Putaway',Volume=0.400000)
     MagAmmo=7
     CockSound=(Sound=Sound'BallisticRecolorsSounds.Eagle.Eagle-Cock',Volume=1.500000)
     ClipHitSound=(Sound=Sound'BallisticRecolorsSounds.Eagle.Eagle-ClipHit',Volume=1.500000)
     ClipOutSound=(Sound=Sound'BallisticRecolorsSounds.Eagle.Eagle-ClipOut',Volume=1.500000)
     ClipInSound=(Sound=Sound'BallisticRecolorsSounds.Eagle.Eagle-ClipIn',Volume=1.500000)
     ClipInFrame=56.000000
     bCockOnEmpty=True	 
     WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",)
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
     bNoCrosshairInScope=True
     SightOffset=(X=-20.000000,Y=-7.400000,Z=41.000000)
     SightDisplayFOV=55.000000
     SightingTime=0.200000
	 SightAimFactor=2.000000
     GunLength=4.000000
     SprintOffSet=(Pitch=-1000,Yaw=-2048)	 
     AimSpread=16	 
     ChaosDeclineTime=0.60000
	 ChaosAimSpread=128	 
	 RecoilXCurve=(Points=((InVal=0.0,OutVal=0.0),(InVal=0.15,OutVal=0.03),(InVal=0.35,OutVal=-0.05),(InVal=0.5,OutVal=0.00),(InVal=0.7,OutVal=0.03),(InVal=1.0,OutVal=0.00))) 
     RecoilXFactor=0.100000
     RecoilYFactor=0.100000
     RecoilMax=6144.000000	 
     RecoilDeclineDelay=0.650000
	 RecoilDeclineTime=1.000000 
     FireModeClass(0)=Class'BWBPRecolorsPro.AH208PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     PutDownAnimRate=1.600000
     PutDownTime=0.500000
     BringUpTime=1.200000
     SelectForce="SwitchToAssaultRifle"
     AmmoClass(0)=Class'BWBPRecolorsPro.Ammo_AH208_Pistol'
     AmmoClass(1)=Class'BWBPRecolorsPro.Ammo_AH208_Pistol'	 
     Description="AH-208"
     Priority=96
     HudColor=(B=255,G=200,R=200)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=2
     GroupOffset=14
     PlayerViewOffset=(X=15.000000,Y=25.500000,Z=-31.500000)
     AttachmentClass=Class'BWBPRecolorsPro.AH208Attachment'
     IconMaterial=Texture'BallisticUI.Icons.SmallIcon_AH208-Pistol'
     IconCoords=(X2=127,Y2=31)
     BobDamping=1.250000	 
     ItemName="AH-208"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=2.250000
     Mesh=SkeletalMesh'BallisticRecolorsAnims.Eagle_FP'
     DrawScale=0.800000
	 Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticRecolorsTex.Eagle.Eagle-MainSilverEngraved'
	 Skins(2)=Texture'BallisticRecolorsTex.Eagle.Eagle-Misc' 
}
