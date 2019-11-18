//=============================================================================
// IE_BulletExpConcrete.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_BulletExpConcrete extends DGVEmitter
	placeable;

simulated event PostBeginPlay()
{
	if ( PhysicsVolume.bWaterVolume )
	{
		Emitters[0].Disabled=true;
		Emitters[1].Disabled=true;
		Emitters[2].Acceleration.Z = 50.0;
		Emitters[2].VelocityLossRange.X.Min=1.000000;
		Emitters[2].VelocityLossRange.X.Max=1.000000;
		Emitters[2].VelocityLossRange.Y.Min=1.000000;
		Emitters[2].VelocityLossRange.Y.Max=1.000000;
	}
	if (vector(Rotation).Z > 0.5)
	{
		Emitters[1].Disabled = true;
		Emitters[3].Disabled = true;
	}
	super.PostBeginPlay();
}

defaultproperties
{
     DisableDGV(4)=1
     bModifyLossRange=False
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_BulletConcrete.SpriteEmitter27'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter28
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-100.000000)
         ColorScale(0)=(Color=(B=64,G=64,R=64))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=64,R=64))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.800000,Max=0.800000),Z=(Min=0.800000,Max=0.800000))
         Opacity=0.540000
         FadeOutStartTime=0.520000
         MaxParticles=25
         DetailMode=DM_SuperHigh
         SpinsPerSecondRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=8.000000,Max=9.000000))
         InitialParticlesPerSecond=30.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.200000)
         StartVelocityRange=(X=(Min=2.000000,Max=5.000000),Y=(Min=-2.000000,Max=2.000000))
     End Object
     Emitters(1)=SpriteEmitter'BWBPRecolorsPro.IE_BulletExpConcrete.SpriteEmitter28'

     Begin Object Class=MeshEmitter Name=MeshEmitter12
         StaticMesh=StaticMesh'BallisticHardware2.Impact.ConcreteChip2'
         UseMeshBlendMode=False
         UseParticleColor=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-300.000000)
         ColorScale(0)=(Color=(B=255,G=192,R=192,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=192,R=192,A=255))
         FadeOutStartTime=0.312000
         MaxParticles=5
         DetailMode=DM_High
         SpinsPerSecondRange=(X=(Min=0.500000,Max=3.000000),Y=(Min=0.500000,Max=3.000000),Z=(Min=0.500000,Max=3.000000))
         StartSizeRange=(X=(Min=0.100000,Max=0.200000),Y=(Min=0.100000,Max=0.200000),Z=(Min=0.100000,Max=0.200000))
         InitialParticlesPerSecond=10000.000000
         DrawStyle=PTDS_AlphaBlend
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=50.000000,Max=250.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-70.000000,Max=150.000000))
     End Object
     Emitters(2)=MeshEmitter'BWBPRecolorsPro.IE_BulletExpConcrete.MeshEmitter12'

     Begin Object Class=MeshEmitter Name=MeshEmitter13
         StaticMesh=StaticMesh'BallisticHardware2.Impact.ConcreteChip3'
         UseMeshBlendMode=False
         UseParticleColor=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-200.000000)
         ColorScale(0)=(Color=(B=255,G=192,R=192,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=192,R=192,A=255))
         ColorMultiplierRange=(X=(Min=0.700000,Max=0.700000),Y=(Min=0.700000,Max=0.700000),Z=(Min=0.700000,Max=0.700000))
         FadeOutStartTime=0.710000
         FadeInEndTime=0.180000
         MaxParticles=2
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=-1.000000)
         StartLocationRange=(Y=(Min=-6.000000,Max=6.000000),Z=(Min=-6.000000,Max=6.000000))
         SpinsPerSecondRange=(X=(Max=0.300000),Y=(Max=0.300000),Z=(Max=0.500000))
         StartSpinRange=(Z=(Max=1.000000))
         StartSizeRange=(X=(Min=0.000000,Max=0.100000),Y=(Min=0.400000,Max=0.800000),Z=(Min=0.400000,Max=0.800000))
         InitialParticlesPerSecond=10000.000000
         DrawStyle=PTDS_AlphaBlend
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=2.000000,Max=20.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Max=50.000000))
     End Object
     Emitters(3)=MeshEmitter'BWBPRecolorsPro.IE_BulletExpConcrete.MeshEmitter13'

     Emitters(4)=MeshEmitter'BallisticProV55.IE_BulletConcrete.MeshEmitter14'

     Emitters(5)=SpriteEmitter'BallisticProV55.IE_BulletConcrete.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter12
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.200000
         FadeOutStartTime=0.161000
         FadeInEndTime=0.031500
         MaxParticles=1
         DetailMode=DM_High
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=35.000000,Max=35.000000),Y=(Min=35.000000,Max=35.000000),Z=(Min=35.000000,Max=35.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticEffects.Particles.Shockwave'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.350000,Max=0.350000)
     End Object
     Emitters(6)=SpriteEmitter'BWBPRecolorsPro.IE_BulletExpConcrete.SpriteEmitter12'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter14
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.800000,Max=0.800000))
         FadeOutStartTime=0.100000
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=15.000000,Max=15.000000),Z=(Min=15.000000,Max=15.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticEffects.Particles.Explode2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
     End Object
     Emitters(7)=SpriteEmitter'BWBPRecolorsPro.IE_BulletExpConcrete.SpriteEmitter14'

     AutoDestroy=True
}
