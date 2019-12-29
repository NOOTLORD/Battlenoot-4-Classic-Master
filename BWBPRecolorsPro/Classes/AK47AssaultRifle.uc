//=============================================================================
// AK47BattleRifle.
//
// A powerful 7.62mm powerhouse. Fills a similar role to the CYLO UAW, albiet is
// far more reliable and has a launchable bayonet in place of the shotgun.
//
// Edited by (NL)NOOTLORD
//=============================================================================
class AK47AssaultRifle extends BallisticWeapon;

var   bool			bLoaded;

var() name			GrenBone;	
var() name			GrenBoneBase;
var() Sound		GrenLoadSound;				
var() Sound		GrenDropSound;		

var   float			NextThrowTime;

var name			BulletBone, BulletBone2;


// Animation notify for when cocking action starts. Used to time sounds
simulated function Notify_CockSim()
{
	PlayOwnedSound(CockSound.Sound,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

// Animation notify for when the clip is stuck in
simulated function Notify_ClipUp()
{
	SetBoneScale(2,1.0,BulletBone);
	SetBoneScale(3,1.0,BulletBone2);
}

simulated function Notify_ClipOut()
{
	Super.Notify_ClipOut();

	if(MagAmmo < 1)
	{
		SetBoneScale(2,0.0,BulletBone);
		SetBoneScale(3,0.0,BulletBone2);
	}
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

simulated function float RateSelf()
{
	if (!HasAmmo())
		CurrentRating = 0;
	else if (Ammo[0].AmmoAmount < 1 && MagAmmo < 1)
		CurrentRating = Instigator.Controller.RateWeapon(self)*0.3;
	else
		return Super.RateSelf();
	return CurrentRating;
}

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
	if (B.Enemy == None)
		return Rating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	return class'BUtil'.static.DistanceAtten(Rating, 0.6, Dist, BallisticRangeAttenFire(BFireMode[0]).CutOffStartRange, BallisticRangeAttenFire(BFireMode[0]).CutOffDistance); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.0;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.0;	}
// End AI Stuff =====

defaultproperties
{
     BulletBone="Bullet1"
     BulletBone2="Bullet2"
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticRecolors3TexPro.AK490.BigIcon_AK490'
     BigIconCoords=(Y1=32,Y2=220)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     ManualLines(0)="Automatic 7.62mm fire. Higher sustained damage than other weapons in its class, but greater recoil and inferior hipfire ability."
     ManualLines(1)="Prepares a melee attack, which will be executed upon release. The damage of the attack increases the longer altfire is held, up to 1.5 seconds for maximum damage output. If lacking a knife, becomes a blunt attack, dealing lower base damage but inflicting a short-duration blinding effect when striking. This attack inflicts more damage from behind."
     ManualLines(2)="The Weapon Function key manages the ballistic knife. If a knife is attached, it will be launched, dealing high damage. This attack is hip-accurate and has no recoil. If no knife is attached, one will be attached if available.||This weapon is effective at medium range."
     SpecialInfo(0)=(Info="320.0;25.0;1.0;110.0;0.5;0.8;0.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.M50.M50Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.M50.M50Putaway')
     MagAmmo=25
     CockAnimPostReload="ReloadEndCock"
     CockingBringUpTime=1.300000
     CockSound=(Sound=Sound'PackageSounds4Pro.AK47.AK47-Cock',Volume=0.650000)
     ReloadAnimRate=1.250000
     ClipHitSound=(Sound=Sound'PackageSounds4Pro.AK47.AK47-ClipHit',Volume=0.650000)
     ClipOutSound=(Sound=Sound'PackageSounds4Pro.AK47.AK47-ClipOut',Volume=0.650000)
     ClipInSound=(Sound=Sound'PackageSounds4Pro.AK47.AK47-ClipIn',Volume=0.650000,Pitch=0.750000)
     ClipInFrame=0.650000
     bCockOnEmpty=True
     WeaponModes(0)=(bUnavailable=True,ModeID="WM_None")
     WeaponModes(1)=(bUnavailable=True)
     bNoCrosshairInScope=True
     SightPivot=(Pitch=64)
     SightOffset=(X=10.000000,Y=-10.020000,Z=20.600000)
     SightDisplayFOV=40.000000
     HipRecoilFactor=0.500000
     SprintOffSet=(Pitch=-1000,Yaw=-2048)
     AimAdjustTime=100.000000
     AimSpread=16
     AimDamageThreshold=0.000000
     ChaosDeclineTime=1.250000
     ChaosSpeedThreshold=15000.000000
     ChaosAimSpread=3072
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=0.050000),(InVal=0.400000,OutVal=0.130000),(InVal=0.800000,OutVal=-0.160000),(InVal=1.000000,OutVal=-0.080000)))
     RecoilYCurve=(Points=(,(InVal=0.200000,OutVal=0.170000),(InVal=0.300000,OutVal=0.450000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.220000
     RecoilYFactor=0.300000
     RecoilMinRandFactor=0.15000
     RecoilDeclineTime=1.500000
     FireModeClass(0)=Class'BWBPRecolorsPro.AK47PrimaryFire'
	 FireModeClass(1)=Class'BWBPRecolorsPro.AK47PrimaryFire'
     IdleAnimRate=0.400000
     SelectAnimRate=1.700000
     PutDownAnimRate=1.750000
     BringUpTime=0.400000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.700000
     CurrentRating=0.700000
     bCanThrow=False
     AmmoClass(0)=Class'BWBPRecolorsPro.Ammo_AK47rifle'
     Description="Chambering 7.62mm armor piercing rounds, this rifle is a homage to its distant predecessor, the AK-47. Though the weapons' looks have hardly changed at all, this model features a vastly improved firing mechanism, allowing it to operate in the most punishing of conditions. Equipped with a heavy reinforced stock, launchable ballistic bayonet, and 20 round box mag, this automatic powerhouse is guaranteed to cut through anything in its way. ZVT Exports designed this weapon to be practical and very easy to maintain. With its rugged and reliable design, the AK490 has spread throughout the cosmos and can be found just about anywhere."
     Priority=65
     HudColor=(G=100)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=4
     GroupOffset=5
     PlayerViewOffset=(X=-4.000000,Y=13.000000,Z=-16.000000)
     BobDamping=2.000000
     AttachmentClass=Class'BWBPRecolorsPro.AK47Attachment'
     IconMaterial=Texture'BallisticRecolors3TexPro.AK490.SmallIcon_AK490'
     IconCoords=(X2=127,Y2=31)
     ItemName="AK-490 Battle Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BallisticRecolors4AnimPro.AK490_FPNew'
     DrawScale=0.350000
     Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
     Skins(1)=Texture'BallisticRecolors3TexPro.AK490.AK490-Main'
     Skins(2)=Texture'BallisticRecolors3TexPro.AK490.AK490-Misc'
     AmbientGlow=0
}
