//=============================================================================
// IE_KnifeConcrete.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class IE_KnifeConcrete extends DGVEmitter
	placeable;

simulated event PreBeginPlay()
{
	if (Level.DetailMode < DM_SuperHigh)
		Emitters[0].Disabled=true;
	Super.PreBeginPlay();
}

simulated event PostBeginPlay()
{
	local Rotator R;
	local int SliceAnim;

//	SetRotation(Rotation + Rot(0,0,1) * Owner.Rotation.Yaw * Abs(Vector(Rotation).Z));

	R = Rotation;
	R.Roll = -R.Yaw + Rotator(Owner.Location - Location).Yaw;
	if (Owner != None && Pawn(Owner) != None && Pawn(Owner).Weapon != None && Pawn(Owner).Weapon.GetFireMode(0) != None && X4PrimaryFire(Pawn(Owner).Weapon.GetFireMode(0)) != None)
	{
		SliceAnim = X4PrimaryFire(Pawn(Owner).Weapon.GetFireMode(0)).SliceAnim;
		if (SliceAnim == 0)
			R.Roll -= 24768;
//		else if (SliceAnim == 1)
//			R.Roll += 0;
		else if (SliceAnim == 2)
			R.Roll += 32768;
		else if (SliceAnim == 3)
			R.Roll -= 8192;
	}
	else
		R.Roll = Rand(65536);

	SetRotation (R);
	Super.PostBeginPlay();
}

defaultproperties
{	 

     DisableDGV(4)=1
     bModifyLossRange=False
     Begin Object Class=SpriteEmitter Name=SpriteEmitter27
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-20.000000)
         ColorScale(0)=(Color=(B=64,G=64,R=64,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=64,R=64,A=255))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.800000,Max=0.800000),Z=(Min=0.800000,Max=0.800000))
         Opacity=0.760000
         FadeOutStartTime=0.460000
         MaxParticles=1
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=0.340000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=20.000000,Max=40.000000),Y=(Min=20.000000,Max=40.000000),Z=(Min=20.000000,Max=40.000000))
         InitialParticlesPerSecond=10000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=60.000000,Max=100.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-5.000000,Max=20.000000))
         VelocityLossRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_BulletConcrete.SpriteEmitter27'
	 
	  Begin Object Class=MeshEmitter Name=MeshEmitter14
         StaticMesh=StaticMesh'BallisticProStatic2.Effects.VolumetricA3'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.085000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSpinRange=(Z=(Max=1.000000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=0.600000,Max=0.800000),Y=(Min=1.500000,Max=1.500000),Z=(Min=1.500000,Max=1.500000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         LifetimeRange=(Min=0.300000,Max=0.300000)
     End Object
     Emitters(1)=MeshEmitter'BallisticProV55.IE_BulletConcrete.MeshEmitter14'

     AutoDestroy=True
}
