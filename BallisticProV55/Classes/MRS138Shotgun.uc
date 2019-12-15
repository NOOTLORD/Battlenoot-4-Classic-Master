//=============================================================================
// MRS138Shotgun.
//
// A combat shotgun with a Flashlight and Tazer.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class MRS138Shotgun extends BallisticProShotgun;

var Projector	FlashLightProj;
var Emitter		FlashLightEmitter;
var bool		bLightsOn;
var vector		TorchOffset;
var() Sound		TorchOnSound;
var() Sound		TorchOffSound;

var Emitter		TazerEffect;
var MRS138TazerLineEffect TazerLineEffect;
var float		TazerTime;

replication
{
	reliable if (Role < ROLE_Authority)
		ServerFlashLight;
}

function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	if (MeleeState >= MS_Held)
		Momentum *= 0.5;
	
	super.AdjustPlayerDamage( Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}

// Animation notify for when cocking action starts. Used to time sounds
simulated function Notify_CockAimed()
{
	bNeedCock = False;
	PlayOwnedSound(CockSound.Sound,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
}

simulated function StartTazer()
{
   	TazerTime = 0;
	if (Role==ROLE_Authority)
		MRS138Attachment(ThirdPersonActor).bTazerOn = true;
	if (Instigator.IsLocallyControlled() && TazerEffect == None)
	{
		TazerEffect = Spawn(class'MRS138TazerEffect',self,,location);
		class'BallisticEmitter'.static.ScaleEmitter(TazerEffect, DrawScale);
		AttachToBone(TazerEffect, 'tip2');
	}
}

simulated function KillTazer()
{
	if (TazerEffect != None)
		TazerEffect.Kill();
	if (Role==ROLE_Authority && ThirdPersonActor != None)
		MRS138Attachment(ThirdPersonActor).bTazerOn = false;
}

function ServerFlashLight (bool bNew)
{
	bLightsOn = bNew;
	MRS138Attachment(ThirdPersonActor).bLightsOn = bLightsOn;
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);
	GunLength = default.GunLength;
	if (Instigator != None && AIController(Instigator.Controller) != None && FRand() > 0.5)
		WeaponSpecial();
	else if (bLightsOn && Instigator.IsLocallyControlled())
	{
		bLightsOn=false;
		WeaponSpecial();
	}
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillTazer();
		KillProjector();
		if (FlashLightEmitter != None)
			FlashLightEmitter.Destroy();
		return true;
	}
	return false;
}

simulated function Destroyed()
{
	if (FlashLightEmitter != None)
		FlashLightEmitter.Destroy();
	KillProjector();
	KillTazer();
	super.Destroyed();
}

simulated function StartProjector()
{
	if (FlashLightProj == None)
		FlashLightProj = Spawn(class'MRS138TorchProjector',self,,location);
	AttachToBone(FlashLightProj, 'tip2');
	FlashLightProj.SetRelativeLocation(TorchOffset);
}
simulated function KillProjector()
{
	if (FlashLightProj != None)
		FlashLightProj.Destroy();
}

simulated event Tick(float DT)
{
	super.Tick(DT);

	if (TazerTime != 0 && level.TimeSeconds > TazerTime + 5)
	{
		KillTazer();
		TazerTime = 0;
	}

	if (!bLightsOn || ClientState != WS_ReadyToFire)
		return;
	if (!Instigator.IsFirstPerson())
		KillProjector();
	else if (FlashLightProj == None)
		StartProjector();
}

simulated event RenderOverlays( Canvas Canvas )
{
	local Vector TazLoc;
	local Rotator TazRot;
	
	if (TazerLineEffect != None)
	{
		TazerLineEffect.bHidden = true;
		TazerLineEffect.SetLocation(ConvertFOVs(GetBoneCoords('tip2').Origin, DisplayFOV, Instigator.Controller.FovAngle, 96));
		Canvas.DrawActor(TazerLineEffect, false, false, Instigator.Controller.FovAngle);
	}
	
	super.RenderOverlays(Canvas);
	
	if (bLightsOn || TazerEffect!= None)
	{
		TazLoc = GetBoneCoords('tip2').Origin;
		TazRot = GetBoneRotation('tip2');
		if (TazerEffect != None)
		{
			TazerEffect.SetLocation(TazLoc);
			TazerEffect.SetRotation(TazRot);
			Canvas.DrawActor(TazerEffect, false, false, DisplayFOV);
		}
		if (FlashLightEmitter != None)
		{
			FlashLightEmitter.SetLocation(TazLoc);
			FlashLightEmitter.SetRotation(TazRot);
			Canvas.DrawActor(FlashLightEmitter, false, false, DisplayFOV);
		}
	}
	

}

simulated function WeaponTick (float DT)
{
	super.WeaponTick(DT);

	if (TazerLineEffect != None && !Instigator.IsFirstPerson() && AIController(Instigator.Controller) == None)
	{
		TazerLineEffect.bHidden = False;
		TazerLineEffect.SetLocation(BallisticAttachment(ThirdPersonActor).GetTipLocation());
	}
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

simulated function float RateSelf()
{
	if (PlayerController(Instigator.Controller) != None && Ammo[0].AmmoAmount <=0 && MagAmmo <= 0)
		CurrentRating = Super.RateSelf() * 0.2;
	else
		return Super.RateSelf();
	return CurrentRating;
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

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);

	if (Dist > 250)
		return 0;
	if (Dist < FireMode[1].MaxRange() && FRand() > 0.3)
		return 1;
	if (vector(B.Enemy.Rotation) dot Normal(Dir) < 0.0 && (VSize(B.Enemy.Velocity) < 100 || Normal(B.Enemy.Velocity) dot Normal(Instigator.Velocity) < 0.5))
		return 1;
	return Rand(2);
}

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
     TorchOffset=(X=-330.000000,Y=-35.000000,Z=50.000000)
     TorchOnSound=Sound'BWAddPack-RS-Sounds.MRS38.RSS-FlashClick'
     TorchOffSound=Sound'BWAddPack-RS-Sounds.MRS38.RSS-FlashClick'
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_MRS138'
     BigIconCoords=(Y1=36,Y2=230)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Shotgun=True
     ManualLines(0)="Automatic 10-gauge shotgun fire. Moderate spread, high damage and fast fire rate. Damage output is excellent. Strong from the hip."
     ManualLines(1)="Melee attack using the tazer. Like other melee attacks, gains damage the longer the altfire key is held (up to 1.5 seconds). Deals more damage from behind. Inflicts a medium-duration blind upon enemies when impacting and knocks them away from the user."
     ManualLines(2)="Weapon Function engages a flashlight which illuminates dark areas.||This weapon is extremely effective at close range."
     SpecialInfo(0)=(Info="240.0;25.0;0.5;40.0;0.0;1.0;-999.0")
     MeleeFireClass=Class'BallisticProV55.MRS138MeleeFire'
     BringUpSound=(Sound=Sound'BallisticSounds2.M763.M763Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.M763.M763Putaway')
	 PutDownAnimRate=1.5
	 PutDownTime=0.35					 				  
     MagAmmo=5
     CockAnimRate=1.200000
     CockSound=(Sound=Sound'BWAddPack-RS-Sounds.MRS38.RSS-Cock',Volume=0.550000)
     ReloadAnim="ReloadLoop"
     ReloadAnimRate=1.500000
     ClipInSound=(Sound=Sound'BWAddPack-RS-Sounds.MRS38.RSS-ShellIn',Volume=0.750000)
     ClipInFrame=0.375000
     bCockOnEmpty=True
     bCanSkipReload=True
     bShovelLoad=True
     StartShovelAnim="PrepReload"
     StartShovelAnimRate=1.400000
     EndShovelAnim="EndReload"
     EndShovelAnimRate=1.600000
     WeaponModes(0)=(ModeName="Semi-Automatic")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
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
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
     RecoilYCurve=(Points=(,(InVal=0.300000,OutVal=0.200000),(InVal=1.000000)))
     RecoilYFactor=1.000000
     RecoilDeclineDelay=0.650000
     FireModeClass(0)=Class'BallisticProV55.MRS138PrimaryFire'
     FireModeClass(1)=Class'BallisticProV55.MRS138PrimaryFire'
     AIRating=0.800000
     CurrentRating=0.800000
     bMeleeWeapon=True
     bCanThrow=False
     AmmoClass(0)=Class'BCoreProV55.BallisticAmmo'
     AmmoClass(1)=Class'BCoreProV55.BallisticAmmo'
     Description="Also from the first line of Drake & Co weaponry, the MRS138 Combat Shotgun is an excellent close-range weapon. It is outfitted with a tactical light and tazer attachment to increase its effectiveness as a crowd control and civilian weapon. The tazer is an effective tool for stunning enemies and inflicting slight damage, leaving them blinded and disoriented for a few seconds, while the flash light can be used for locating those which hide in the dark."
     DisplayFOV=50.000000
     Priority=36
     HudColor=(B=255,G=150,R=100)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=7
     GroupOffset=3
     PickupClass=Class'BallisticProV55.MRS138Pickup'
     PlayerViewOffset=(Y=10.000000,Z=-14.000000)
     AttachmentClass=Class'BallisticProV55.MRS138Attachment'
     IconMaterial=Texture'BWAddPack-RS-Skins.MRS138.SmallIcon_MRS138'
     IconCoords=(X2=127,Y2=31)
     ItemName="MRS-138 Tactical Shotgun"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=25
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=5.000000
     Mesh=SkeletalMesh'BallisticProAnims.MRS138Shotgun'
     DrawScale=0.400000
     Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
     Skins(1)=Shader'BWAddPack-RS-Skins.MRS138.MRS138Shiney'
     Skins(2)=Shader'BWAddPack-RS-Skins.MRS138.MRS138HeatShiney'
     Skins(3)=Texture'BWAddPack-RS-Skins.MRS138.MRS138Shell'
     AmbientGlow=0
     bSelected=True
}
