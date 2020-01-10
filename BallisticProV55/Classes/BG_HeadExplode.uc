//=============================================================================
// BG_HeadExplode.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BG_HeadExplode extends BW_HitGoreEmitter
	placeable;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-10.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.400000,Max=0.800000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.500000
         FadeOutStartTime=1.160000
         FadeInEndTime=0.280000
         SpinsPerSecondRange=(X=(Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=0.700000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=10.000000,Max=15.000000),Y=(Min=10.000000,Max=15.000000),Z=(Min=10.000000,Max=15.000000))
         InitialParticlesPerSecond=400.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         StartVelocityRange=(X=(Max=50.000000),Y=(Min=-30.000000,Max=30.000000),Z=(Max=100.000000))
         VelocityLossRange=(X=(Min=1.500000,Max=1.500000),Y=(Min=1.500000,Max=1.500000),Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.BG_HeadExplode.SpriteEmitter2'

     Begin Object Class=TrailEmitter Name=TrailEmitter0
         TrailShadeType=PTTST_PointLife
         MaxPointsPerTrail=15
         DistanceThreshold=8.000000
         PointLifeTime=2.000000
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-200.000000)
         ColorMultiplierRange=(X=(Min=0.500000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         MaxParticles=5
         StartLocationOffset=(Z=5.000000)
         StartSizeRange=(X=(Min=2.000000,Max=5.000000))
         InitialParticlesPerSecond=400.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Max=400.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Max=200.000000))
     End Object
     Emitters(1)=TrailEmitter'BallisticProV55.BG_HeadExplode.TrailEmitter0'

     AutoDestroy=True
}
