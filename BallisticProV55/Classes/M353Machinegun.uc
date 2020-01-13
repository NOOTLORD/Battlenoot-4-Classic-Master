//=============================================================================
// M353Machinegun.
//
// The "Guardian" M353 Machinegun has an extremely high fire rate, high ammo
// capacity and decent damage, but is extremely inacurate and can quickly fight
// its way from its owner's control. Secondary allows the user to mount the
// weapon on the ground by crouching.
//
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M353Machinegun extends BallisticMachinegun;

function InitWeaponFromTurret(BallisticTurret Turret)
{
	bNeedCock = false;
	Ammo[0].AmmoAmount = Turret.AmmoAmount[0];
	if (!Instigator.IsLocallyControlled())
		ClientInitWeaponFromTurret(Turret);
}
simulated function ClientInitWeaponFromTurret(BallisticTurret Turret)
{
	bNeedCock=false;
}

simulated function TickAim(float DT)
{
	Super(BallisticWeapon).TickAim(DT);
}

function Notify_Deploy()
{
	local vector HitLoc, HitNorm, Start, End;
	local actor T;
	local Rotator CompressedEq;
    local BallisticTurret Turret;
    local int Forward;

	if (Instigator.HeadVolume.bWaterVolume)
		return;
	// Trace forward and then down. make sure turret is being deployed:
	//   on world geometry, at least 30 units away, on level ground, not on the other side of an obstacle
	// BallisticPro specific: Can be deployed upon sandbags providing that sandbag is not hosting
	// another weapon already. When deployed upon sandbags, the weapon is automatically deployed 
	// to the centre of the bags.
	
	Start = Instigator.Location + Instigator.EyePosition();
	for (Forward=75;Forward>=45;Forward-=15)
	{
		End = Start + vector(Instigator.Rotation) * Forward;
		T = Trace(HitLoc, HitNorm, End, Start, true, vect(6,6,6));
		if (T != None && VSize(HitLoc - Start) < 30)
			return;
		if (T == None)
			HitLoc = End;
		End = HitLoc - vect(0,0,100);
		T = Trace(HitLoc, HitNorm, End, HitLoc, true, vect(6,6,6));
		if (T != None && (T.bWorldGeometry && (Sandbag(T) == None || Sandbag(T).AttachedWeapon == None)) && HitNorm.Z >= 0.9 && FastTrace(HitLoc, Start))
			break;
		if (Forward <= 45)
			return;
	}

	FireMode[1].bIsFiring = false;
   	FireMode[1].StopFiring();

	if(Sandbag(T) != None)
	{
		HitLoc = T.Location;
		HitLoc.Z += class'M353Turret'.default.CollisionHeight + 30;
	}
	
	else
	{
		HitLoc.Z += class'M353Turret'.default.CollisionHeight - 9;
	}
	
	CompressedEq = Instigator.Rotation;
		
	//Rotator compression causes disparity between server and client rotations,
	//which then plays hob with the turret's aim.
	//Do the compression first then use that to spawn the turret.
	
	CompressedEq.Pitch = (CompressedEq.Pitch >> 8) & 255;
	CompressedEq.Yaw = (CompressedEq.Yaw >> 8) & 255;
	CompressedEq.Pitch = (CompressedEq.Pitch << 8);
	CompressedEq.Yaw = (CompressedEq.Yaw << 8);

	Turret = Spawn(class'M353Turret', None,, HitLoc, CompressedEq);
	
    if (Turret != None)
    {
    	if (Sandbag(T) != None)
			Sandbag(T).AttachedWeapon = Turret;
		Turret.InitDeployedTurretFor(self);
		Turret.TryToDrive(Instigator);
		Destroy();
    }
    else
		log("Notify_Deploy: Could not spawn turret for M353 Machinegun");
}

simulated function PlayReload()
{
	PlayAnim('ReloadHold', ReloadAnimRate, , 0.25);
}

simulated function Notify_M353FlapOpenedReload ()
{
	super.PlayReload();
}

// Animation notify to make gun cock after reload
simulated function Notify_CockAfterReload()
{
	if (bNeedCock && MagAmmo > 0)
		CommonCockGun(2);
	else
		PlayAnim('ReloadFinishHold', ReloadAnimRate, 0.2);
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2 && HasAnim('ReloadEndCock'))
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

simulated function PositionSights ()
{
	super.PositionSights();
	if (SightingPhase <= 0.0)
		SetBoneRotation('TopHandle', rot(0,0,0));
	else if (SightingPhase >= 1.0 )
		SetBoneRotation('TopHandle', rot(0,0,-8192));
	else
		SetBoneRotation('TopHandle', class'BUtil'.static.RSmerp(SightingPhase, rot(0,0,0), rot(0,0,-8192)));
}

simulated function bool HasAmmo()
{
	//First Check the magazine
	if (FireMode[0] != None && MagAmmo >= FireMode[0].AmmoPerFire)
		return true;
	//If it is a non-mag or the magazine is empty
	if (Ammo[0] != None && FireMode[0] != None && Ammo[0].AmmoAmount >= FireMode[0].AmmoPerFire)
			return true;
	return false;	//This weapon is empty
}

function GiveTo(Pawn Other, optional Pickup Pickup)
{
    local int m;
    local weapon w;
	local SandbagLayer Bags;
    local bool bPossiblySwitch, bJustSpawned;

    Instigator = Other;
    W = Weapon(Other.FindInventoryType(class));
    if ( W == None || class != W.Class)
    {
		bJustSpawned = true;
        Super(Inventory).GiveTo(Other);
        bPossiblySwitch = true;
        W = self;
		if (Pickup != None && BallisticWeaponPickup(Pickup) != None)
			MagAmmo = BallisticWeaponPickup(Pickup).MagAmmo;
    }
 	
   	else if ( !W.HasAmmo() )
	    bPossiblySwitch = true;
	    

    if ( Pickup == None )
        bPossiblySwitch = true;

    for (m = 0; m < NUM_FIRE_MODES; m++)
    {
        if ( FireMode[m] != None )
        {
            FireMode[m].Instigator = Instigator;
            W.GiveAmmo(m,WeaponPickup(Pickup),bJustSpawned);
        }
    }
	
	if (MeleeFireMode != None)
		MeleeFireMode.Instigator = Instigator;

	if ( (Instigator.Weapon != None) && Instigator.Weapon.IsFiring() )
		bPossiblySwitch = false;

	if ( Instigator.Weapon != W )
		W.ClientWeaponSet(bPossiblySwitch);
		
	if(BallisticTurret(Instigator) == None && Instigator.IsHumanControlled() && Instigator.FindInventoryType(class'SandbagLayer') == None)
    {
        Bags = Spawn(class'SandbagLayer',,,Instigator.Location);
		
		if (Instigator.Weapon == None)
			Instigator.Weapon = Self;
			
        if( Bags != None )
            Bags.GiveTo(Instigator);
    }
		
	//Disable aim for weapons picked up by AI-controlled pawns
	bAimDisabled = default.bAimDisabled || !Instigator.IsHumanControlled();

    if ( !bJustSpawned )
	{
        for (m = 0; m < NUM_FIRE_MODES; m++)
			Ammo[m] = None;
		Destroy();
	}
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
	
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.75, Dist, 1024, 2048); 
}

simulated function SetScopeBehavior()
{
	bUseNetAim = default.bUseNetAim || bScopeView;
		
	if (bScopeView)
	{
		ViewAimFactor = 1.0;
		ViewRecoilFactor = 1.0;
		AimAdjustTime *= 2;
		AimSpread = 0;
		ChaosAimSpread *= SightAimFactor;
		ChaosDeclineTime *= 2.0;
		ChaosSpeedThreshold *= 0.5;
	}
	else
	{
		//PositionSights will handle this for clients
		if(Level.NetMode == NM_DedicatedServer)
		{
			ViewAimFactor = default.ViewAimFactor;
			ViewRecoilFactor = default.ViewRecoilFactor;
		}

		AimAdjustTime = default.AimAdjustTime;
		AimSpread = default.AimSpread;
		AimSpread *= BCRepClass.default.AccuracyScale;
		ChaosAimSpread = default.ChaosAimSpread;
		ChaosAimSpread *= BCRepClass.default.AccuracyScale;
		ChaosDeclineTime = default.ChaosDeclineTime;
		ChaosSpeedThreshold = default.ChaosSpeedThreshold;
	}
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.5;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}

defaultproperties
{
     BoxOnSound=(Sound=Sound'BallisticSounds2.M353.M353-BoxOn')
     BoxOffSound=(Sound=Sound'BallisticSounds2.M353.M353-BoxOff')
     FlapUpSound=(Sound=Sound'BallisticSounds2.M353.M353-FlapUp')
     FlapDownSound=(Sound=Sound'BallisticSounds2.M353.M353-FlapDown')
     PlayerSpeedFactor=0.850000
     PlayerJumpFactor=0.900000
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=4.000000
     BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_M353'
     BigIconCoords=(Y1=50,Y2=240)
     SightFXClass=Class'BallisticProV55.M353SightLEDs'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     bWT_Machinegun=True
     ManualLines(0)="Automatic 5.56mm fire. Has a high rate of fire, moderate damage and good sustained damage output. As a machinegun, it has a very long effective range. Large magazine capacity allows the weapon to fire for a long time, but the reload time is long."
     ManualLines(1)="Deploys the machinegun upon the ground or a nearby wall. May also be deployed upon sandbags. Whilst deployed, becomes perfectly accurate, loses its iron sights and gains a reduction in recoil. Locational damage (damage which can target an area on the body) taken from the front is significantly reduced."
     ManualLines(2)="The M353 is a more cumbersome and heavy weapon, and accordingly has poor hipfire and takes some time to aim.||It is effective at medium to long range."
     SpecialInfo(0)=(Info="300.0;25.0;0.7;-1.0;0.4;0.4;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.M353.M353-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.M353.M353-Putaway')
     MagAmmo=100
     CockAnimRate=1.250000
     CockSound=(Sound=Sound'BallisticSounds2.M353.M353-Cock')
     ReloadAnim="ReloadStart"
     ReloadAnimRate=1.450000
     ClipOutSound=(Sound=Sound'BallisticSounds2.M353.M353-ShellOut')
     ClipInSound=(Sound=Sound'BallisticSounds2.M353.M353-ShellIn')
     ClipInFrame=0.650000
     bCockOnEmpty=True
     WeaponModes(0)=(bUnavailable=True)
     WeaponModes(1)=(ModeName="Burst of Three")
     WeaponModes(2)=(ModeName="Burst of Five",ModeID="WM_BigBurst",Value=5.000000)
     WeaponModes(3)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     CurrentWeaponMode=3
     bNoCrosshairInScope=False
     SightPivot=(Pitch=128)
     SightOffset=(X=-6.000000,Z=5.350000)
     SightingTime=0.550000
     SightAimFactor=0.700000
     SprintOffSet=(Pitch=-6000,Yaw=-8000)
     AimSpread=384
     ViewRecoilFactor=0.500000
     ChaosDeclineTime=1.600000
     ChaosAimSpread=3072
     RecoilXCurve=(Points=(,(InVal=0.070000,OutVal=-0.050000),(InVal=0.100000,OutVal=-0.085000),(InVal=0.180000,OutVal=0.060000),(InVal=0.300000,OutVal=-0.100000),(InVal=0.500000,OutVal=0.200000),(InVal=0.650000,OutVal=0.300000),(InVal=0.700000,OutVal=-0.100000),(InVal=0.850000,OutVal=0.400000),(InVal=1.000000)))
     RecoilYCurve=(Points=(,(InVal=0.050000,OutVal=0.070000),(InVal=0.100000,OutVal=0.120000),(InVal=0.200000,OutVal=0.250000),(InVal=0.400000,OutVal=0.400000),(InVal=0.550000,OutVal=0.650000),(InVal=0.650000,OutVal=0.450000),(InVal=0.800000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.250000
     RecoilYFactor=0.250000
     RecoilMax=12288.000000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.150000
     FireModeClass(0)=Class'BallisticProV55.M353PrimaryFire'
     FireModeClass(1)=Class'BallisticProV55.M353SecondaryFire'
     SelectAnimRate=1.350000
     PutDownTime=0.550000
     BringUpTime=0.700000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.7500000
     CurrentRating=0.7500000
     Description="The M353 'Guardian' Machinegun has seen some of the most brutal battles ever recorded in recent history, and has helped win many of them, the most famous being the bloody 'Wasteland Seige' where 12 million Krao were slaughtered along a 500 mile line of defences. Used primarily as a defensive weapon, the M353's incredible rate of fire can quickly and effectively destroy masses of oncoming foes, especially melee attackers. When the secondary mode is activated, the Guardian becomes much more accurate when the user mounts it on the ground, allowing it to be a very effective defensive weapon. With its high rate of fire and high damage, the M353 becomes very inaccurate after just a few rounds and with its high ammo capacity, comes the difficulty of longer reload times than smaller weapons."
     DisplayFOV=50.000000
     Priority=43
     HudColor=(G=150,R=100)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=6
     PickupClass=Class'BallisticProV55.M353Pickup'
     PlayerViewOffset=(X=2.000000,Y=3.500000,Z=-4.000000)
     AttachmentClass=Class'BallisticProV55.M353Attachment'
     IconMaterial=Texture'BallisticUI2.Icons.SmallIcon_M353'
     IconCoords=(X2=127,Y2=31)
     ItemName="M353 Light Machine Gun"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BallisticProAnims.M353Machinegun'
     DrawScale=0.350000
}
