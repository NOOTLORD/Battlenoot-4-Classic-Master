//=============================================================================
// TraceEmitter_Dart
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class TraceEmitter_Dart extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
         RespawnDeadParticles=False
         Disabled=True
         Backup_Disabled=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.900000),Y=(Min=0.800000,Max=0.900000),Z=(Min=0.500000,Max=0.700000))
         Opacity=0.350000
         FadeOutStartTime=1.000000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
         InitialParticlesPerSecond=20.000000
         Texture=Texture'BallisticEffects.Particles.AquaFlareA1'
         SecondsBeforeInactive=0.000000
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.TraceEmitter_Dart.SpriteEmitter8'

     Begin Object Class=TrailEmitter Name=TrailEmitter1
         TrailShadeType=PTTST_PointLife
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=50
         DistanceThreshold=40.000000
         PointLifeTime=1.000000
         FadeOut=True
         FadeIn=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.850000,Max=0.900000),Z=(Min=0.650000,Max=0.700000))
         Opacity=0.200000
         FadeOutStartTime=0.400000
         FadeInEndTime=0.200000
         MaxParticles=1
         StartSizeRange=(X=(Min=17.500000,Max=17.500000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=10.000000))
         InitialParticlesPerSecond=500000.000000
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
     End Object
     Emitters(1)=TrailEmitter'BallisticProV55.TraceEmitter_Dart.TrailEmitter1'
}
