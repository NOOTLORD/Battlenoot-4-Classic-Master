//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ONSShockTank extends ONSWheeledCraft;


function bool ImportantVehicle()
{
	return true;
}

function ShouldTargetMissile(Projectile P)
{
	local AIController C;

	C = AIController(Controller);
	if ( (C != None) && (C.Skill >= 2.0) )
		ONSShockTankCannon(Weapons[0]).ShieldAgainstIncoming(P);
}

function bool Dodge(eDoubleClickDir DoubleClickMove)
{
	ONSShockTankCannon(Weapons[0]).ShieldAgainstIncoming();
	return false;
}

function VehicleCeaseFire(bool bWasAltFire)
{
    Super.VehicleCeaseFire(bWasAltFire);

    if (bWasAltFire && ONSShockTankCannon(Weapons[ActiveWeapon]) != None)
        ONSShockTankCannon(Weapons[ActiveWeapon]).CeaseAltFire();
}

event TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
	local vector ShieldHitLocation, ShieldHitNormal;

	// don't take damage if should have been blocked by shield
	if ( (Weapons.Length > 0) && ONSShockTankCannon(Weapons[0]).bShieldActive && (ONSShockTankCannon(Weapons[0]).ShockShield != None) && (Momentum != vect(0,0,0))
		&& (HitLocation != Location) && (DamageType != None) && (ClassIsChildOf(DamageType,class'WeaponDamageType') || ClassIsChildOf(DamageType,class'VehicleDamageType')) 
		&& !ONSShockTankCannon(Weapons[0]).ShockShield.TraceThisActor(ShieldHitLocation,ShieldHitNormal,HitLocation,HitLocation - 2000*Normal(Momentum)) )
		return;

    // Don't take self inflicated damage from proximity explosion
    if (DamageType == class'DamTypeShockTankProximityExplosion' && EventInstigator != None && EventInstigator == self)
        return;

    Super.TakeDamage(Damage, EventInstigator, HitLocation, Momentum, DamageType);
}


simulated function vector GetTargetLocation()
{
	return Location + vect(0,0,1)*CollisionHeight;
}

static function StaticPrecache(LevelInfo L)
{
    Super.StaticPrecache(L);

    L.AddPrecacheMaterial(Material'ONSBPTextures.Skins.PaladinGreen');
    L.AddPrecacheMaterial(Material'ONSBPTextures.Skins.PaladinTan');
    L.AddPrecacheMaterial(Material'AW-2004Particles.Fire.SmokeFragment');
    L.AddPrecacheMaterial(Material'AW-2004Particles.Fire.NapalmSpot');
    L.AddPrecacheMaterial(Material'AW-2004Particles.Energy.ElecPanelsP');
    L.AddPrecacheMaterial(Material'AW-2004Particles.Energy.ElecPanels');
    L.AddPrecacheMaterial(Material'ExplosionTex.Framed.exp2_framesP');
    L.AddPrecacheMaterial(Material'ONSInterface-TX.tankBarrelAligned');
    L.AddPrecacheMaterial(Material'AW-2k4XP.Weapons.ShockTankEffectCore2');
    L.AddPrecacheMaterial(Material'AW-2k4XP.Weapons.ShockTankEffectSwirl');
    L.AddPrecacheMaterial(Material'AW-2k4XP.Weapons.ShockBallTrail');
    L.AddPrecacheMaterial(Material'AW-2k4XP.Weapons.ShockTankEffectCore2a');
    L.AddPrecacheMaterial(Material'AW-2k4XP.Weapons.ShockRingTex');
    L.AddPrecacheMaterial(Material'AW-2k4XP.Weapons.ShockTankEffectCore');
    L.AddPrecacheMaterial(Material'AW-2004Particles.Energy.SmoothRing');
    L.AddPrecacheMaterial(Material'AW-2004Particles.Fire.Ripples1P');
    L.AddPrecacheMaterial(Material'AW-2004Particles.Fire.Ripples2P');
    L.AddPrecacheMaterial(Material'AW-2004Particles.Weapons.BoloBlob');
    L.AddPrecacheMaterial(Material'AW-2k4XP.Weapons.ElectricShockTexG');
    L.AddPrecacheMaterial(Material'AW-2k4XP.Weapons.ElectricShockTexG2');
    L.AddPrecacheMaterial(Material'VehicleFX.Particles.DustyCloud2');
    L.AddPrecacheMaterial(Material'VMParticleTextures.DirtKICKGROUP.dirtKICKTEX');
    L.AddPrecacheMaterial(Material'AW-2004Particles.Weapons.SoftFade');
    L.AddPrecacheMaterial(Material'AbaddonArchitecture.Base.bas27go');
}

simulated function UpdatePrecacheStaticMeshes()
{
    Super.UpdatePrecacheStaticMeshes();
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'ONSBPTextures.Skins.PaladinGreen');
    Level.AddPrecacheMaterial(Material'ONSBPTextures.Skins.PaladinTan');
    Level.AddPrecacheMaterial(Material'AW-2004Particles.Fire.SmokeFragment');
    Level.AddPrecacheMaterial(Material'AW-2004Particles.Fire.NapalmSpot');
    Level.AddPrecacheMaterial(Material'AW-2004Particles.Energy.ElecPanelsP');
    Level.AddPrecacheMaterial(Material'AW-2004Particles.Energy.ElecPanels');
    Level.AddPrecacheMaterial(Material'ExplosionTex.Framed.exp2_framesP');
    Level.AddPrecacheMaterial(Material'ONSInterface-TX.tankBarrelAligned');
    Level.AddPrecacheMaterial(Material'AW-2k4XP.Weapons.ShockTankEffectCore2');
    Level.AddPrecacheMaterial(Material'AW-2k4XP.Weapons.ShockTankEffectSwirl');
    Level.AddPrecacheMaterial(Material'AW-2k4XP.Weapons.ShockBallTrail');
    Level.AddPrecacheMaterial(Material'AW-2k4XP.Weapons.ShockTankEffectCore2a');
    Level.AddPrecacheMaterial(Material'AW-2k4XP.Weapons.ShockRingTex');
    Level.AddPrecacheMaterial(Material'AW-2k4XP.Weapons.ShockTankEffectCore');
    Level.AddPrecacheMaterial(Material'AW-2004Particles.Energy.SmoothRing');
    Level.AddPrecacheMaterial(Material'AW-2004Particles.Fire.Ripples1P');
    Level.AddPrecacheMaterial(Material'AW-2004Particles.Fire.Ripples2P');
    Level.AddPrecacheMaterial(Material'AW-2004Particles.Weapons.BoloBlob');
    Level.AddPrecacheMaterial(Material'AW-2k4XP.Weapons.ElectricShockTexG');
    Level.AddPrecacheMaterial(Material'AW-2k4XP.Weapons.ElectricShockTexG2');
    Level.AddPrecacheMaterial(Material'VehicleFX.Particles.DustyCloud2');
    Level.AddPrecacheMaterial(Material'VMParticleTextures.DirtKICKGROUP.dirtKICKTEX');
    Level.AddPrecacheMaterial(Material'AW-2004Particles.Weapons.SoftFade');
    Level.AddPrecacheMaterial(Material'AbaddonArchitecture.Base.bas27go');

	Super.UpdatePrecacheMaterials();
}

defaultproperties
{
     WheelSoftness=0.100000
     WheelPenScale=1.200000
     WheelPenOffset=0.010000
     WheelRestitution=0.100000
     WheelInertia=0.100000
     WheelLongFrictionFunc=(Points=(,(InVal=100.000000,OutVal=1.000000),(InVal=200.000000,OutVal=0.900000),(InVal=10000000000.000000,OutVal=0.900000)))
     WheelLongSlip=0.001000
     WheelLatSlipFunc=(Points=(,(InVal=30.000000,OutVal=0.010000),(InVal=45.000000),(InVal=10000000000.000000)))
     WheelLongFrictionScale=2.000000
     WheelLatFrictionScale=1.500000
     WheelHandbrakeSlip=0.010000
     WheelHandbrakeFriction=0.100000
     WheelSuspensionTravel=45.000000
     WheelSuspensionOffset=-12.000000
     WheelSuspensionMaxRenderTravel=45.000000
     FTScale=0.020000
     ChassisTorqueScale=0.200000
     MinBrakeFriction=4.000000
     MaxSteerAngleCurve=(Points=((OutVal=35.000000),(InVal=450.000000,OutVal=35.000000),(InVal=550.000000,OutVal=11.000000),(InVal=1000000000.000000,OutVal=11.000000)))
     TorqueCurve=(Points=((OutVal=27.000000),(InVal=200.000000,OutVal=30.000000),(InVal=1500.000000,OutVal=33.000000),(InVal=2800.000000)))
     GearRatios(0)=-0.500000
     GearRatios(1)=0.400000
     GearRatios(2)=0.650000
     GearRatios(3)=0.850000
     GearRatios(4)=1.100000
     TransRatio=0.030000
     ChangeUpPoint=2000.000000
     ChangeDownPoint=1000.000000
     LSDFactor=1.000000
     EngineBrakeFactor=0.000100
     EngineBrakeRPMScale=0.100000
     MaxBrakeTorque=20.000000
     SteerSpeed=80.000000
     TurnDamping=35.000000
     StopThreshold=100.000000
     HandbrakeThresh=200.000000
     EngineInertia=0.100000
     IdleRPM=500.000000
     EngineRPMSoundRange=9000.000000
     SteerBoneName="SteeringWheel"
     SteerBoneAxis=AXIS_Z
     SteerBoneMaxAngle=90.000000
     RevMeterScale=4000.000000
     bAllowBigWheels=True
     AirPitchDamping=25.000000
     DriverWeapons(0)=(WeaponClass=Class'OnslaughtBP.ONSShockTankCannon',WeaponBone="CannonAttach")
     RedSkin=Texture'ONSBPTextures.Skins.PaladinTan'
     BlueSkin=Texture'ONSBPTextures.Skins.PaladinGreen'
     IdleSound=Sound'ONSBPSounds.ShockTank.EngineCruise'
     StartUpSound=Sound'ONSBPSounds.ShockTank.EngineRampUp'
     ShutDownSound=Sound'ONSBPSounds.ShockTank.EngineRampDown'
     StartUpForce="RVStartUp"
     DestroyedVehicleMesh=StaticMesh'ONSBP_DestroyedVehicles.Paladin.DestroyedPaladin'
     DestructionEffectClass=Class'Onslaught.ONSSmallVehicleExplosionEffect'
     DisintegrationEffectClass=Class'OnslaughtBP.ONSShockTankDeathExp'
     DisintegrationHealth=-25.000000
     DestructionLinearMomentum=(Min=200000.000000,Max=300000.000000)
     DestructionAngularMomentum=(Min=100.000000,Max=150.000000)
     DamagedEffectOffset=(X=60.000000,Y=10.000000,Z=10.000000)
     ImpactDamageMult=0.001000
     Begin Object Class=SVehicleWheel Name=RWheel1
         bPoweredWheel=True
         SteerType=VST_Steered
         BoneName="8WheelerWheel01"
         BoneRollAxis=AXIS_Y
         BoneOffset=(Y=7.000000)
         WheelRadius=44.000000
         SupportBoneName="Suspension_Right1"
         SupportBoneAxis=AXIS_X
     End Object
     Wheels(0)=SVehicleWheel'OnslaughtBP.ONSShockTank.RWheel1'

     Begin Object Class=SVehicleWheel Name=RWheel2
         bPoweredWheel=True
         BoneName="8WheelerWheel03"
         BoneRollAxis=AXIS_Y
         BoneOffset=(Y=7.000000)
         WheelRadius=44.000000
         SupportBoneName="Suspension_Right2"
         SupportBoneAxis=AXIS_X
     End Object
     Wheels(1)=SVehicleWheel'OnslaughtBP.ONSShockTank.RWheel2'

     Begin Object Class=SVehicleWheel Name=RWheel3
         bPoweredWheel=True
         BoneName="8WheelerWheel05"
         BoneRollAxis=AXIS_Y
         BoneOffset=(Y=7.000000)
         WheelRadius=44.000000
         SupportBoneName="Suspension_Right3"
         SupportBoneAxis=AXIS_X
     End Object
     Wheels(2)=SVehicleWheel'OnslaughtBP.ONSShockTank.RWheel3'

     Begin Object Class=SVehicleWheel Name=RWheel4
         bPoweredWheel=True
         SteerType=VST_Inverted
         BoneName="8WheelerWheel07"
         BoneRollAxis=AXIS_Y
         BoneOffset=(Y=7.000000)
         WheelRadius=44.000000
         SupportBoneName="Suspension_Right4"
         SupportBoneAxis=AXIS_X
     End Object
     Wheels(3)=SVehicleWheel'OnslaughtBP.ONSShockTank.RWheel4'

     Begin Object Class=SVehicleWheel Name=LWheel1
         bPoweredWheel=True
         SteerType=VST_Steered
         BoneName="8WheelerWheel02"
         BoneRollAxis=AXIS_Y
         BoneOffset=(Y=7.000000)
         WheelRadius=44.000000
         SupportBoneName="Suspension_Left1"
         SupportBoneAxis=AXIS_X
     End Object
     Wheels(4)=SVehicleWheel'OnslaughtBP.ONSShockTank.LWheel1'

     Begin Object Class=SVehicleWheel Name=LWheel2
         bPoweredWheel=True
         BoneName="8WheelerWheel04"
         BoneRollAxis=AXIS_Y
         BoneOffset=(Y=7.000000)
         WheelRadius=44.000000
         SupportBoneName="Suspension_Left2"
         SupportBoneAxis=AXIS_X
     End Object
     Wheels(5)=SVehicleWheel'OnslaughtBP.ONSShockTank.LWheel2'

     Begin Object Class=SVehicleWheel Name=LWheel3
         bPoweredWheel=True
         BoneName="8WheelerWheel06"
         BoneRollAxis=AXIS_Y
         BoneOffset=(Y=7.000000)
         WheelRadius=44.000000
         SupportBoneName="Suspension_Left3"
         SupportBoneAxis=AXIS_X
     End Object
     Wheels(6)=SVehicleWheel'OnslaughtBP.ONSShockTank.LWheel3'

     Begin Object Class=SVehicleWheel Name=LWheel4
         bPoweredWheel=True
         SteerType=VST_Inverted
         BoneName="8WheelerWheel08"
         BoneRollAxis=AXIS_Y
         BoneOffset=(Y=7.000000)
         WheelRadius=44.000000
         SupportBoneName="Suspension_Left4"
         SupportBoneAxis=AXIS_X
     End Object
     Wheels(7)=SVehicleWheel'OnslaughtBP.ONSShockTank.LWheel4'

     VehicleMass=6.000000
     FlipTorque=400.000000
     bDrawMeshInFP=True
     bSeparateTurretFocus=True
     bDriverHoldsFlag=False
     ExitPositions(0)=(Y=-265.000000,Z=100.000000)
     ExitPositions(1)=(Y=265.000000,Z=100.000000)
     ExitPositions(2)=(Y=-265.000000,Z=-100.000000)
     ExitPositions(3)=(Y=265.000000,Z=-100.000000)
     EntryRadius=300.000000
     FPCamPos=(X=-45.000000,Z=250.000000)
     FPCamViewOffset=(X=-30.000000)
     TPCamDistance=375.000000
     CenterSpringForce="SpringONSSRV"
     TPCamLookat=(X=0.000000,Z=0.000000)
     TPCamWorldOffset=(Z=375.000000)
     MomentumMult=0.800000
     DriverDamageMult=0.010000
     VehiclePositionString="in a Paladin"
     VehicleNameString="Paladin"
     RanOverDamageType=Class'Onslaught.DamTypeRVRoadkill'
     CrushedDamageType=Class'Onslaught.DamTypeRVPancake'
     MaxDesireability=0.600000
     ObjectiveGetOutDist=1500.000000
     FlagBone="CannonAttach"
     FlagOffset=(Z=50.000000)
     FlagRotation=(Yaw=32768)
     HornSounds(0)=Sound'ONSBPSounds.ShockTank.PaladinHorn'
     HornSounds(1)=Sound'ONSVehicleSounds-S.Horns.Dixie_Horn'
     GroundSpeed=940.000000
     HealthMax=800.000000
     Health=800
     AmbientSoundScaling=2.000000
     bReplicateAnimations=True
     Mesh=SkeletalMesh'ONSBPAnimations.ShockTankMesh'
     CollisionRadius=260.000000
     CollisionHeight=40.000000
     Begin Object Class=KarmaParamsRBFull Name=KParams0
         KInertiaTensor(0)=1.000000
         KInertiaTensor(3)=3.000000
         KInertiaTensor(5)=3.000000
         KCOMOffset=(X=-0.250000,Z=-1.350000)
         KLinearDamping=0.050000
         KAngularDamping=0.050000
         KStartEnabled=True
         bKNonSphericalInertia=True
         bHighDetailOnly=False
         bClientOnly=False
         bKDoubleTickRate=True
         bDestroyOnWorldPenetrate=True
         bDoSafetime=True
         KFriction=0.500000
         KImpactThreshold=700.000000
     End Object
     KParams=KarmaParamsRBFull'OnslaughtBP.ONSShockTank.KParams0'

}