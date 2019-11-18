//=============================================================================
// TraceEmitter_Flechette.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class TraceEmitter_Flechette extends BCTraceEmitter;

simulated function Initialize(float Distance, optional float Power)
{
}

defaultproperties
{
     Begin Object Class=SparkEmitter Name=SparkEmitter6
         LineSegmentsRange=(Min=0.000000,Max=0.000000)
         UseCollision=True
         UseMaxCollisions=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-100.000000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=192,G=192,R=192,A=255))
         ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.800000),Z=(Min=0.800000))
         FadeOutStartTime=0.110000
         CoordinateSystem=PTCS_Relative
         MaxParticles=9
         StartSizeRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=100.000000,Max=5000.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-100.000000,Max=200.000000))
     End Object
     Emitters(0)=SparkEmitter'BWBPRecolorsPro.TraceEmitter_Flechette.SparkEmitter6'

     Emitters(1)=MeshEmitter'BallisticProV55.TraceEmitter_Shotgun.MeshEmitter15'

}
