class InvasionProPetResurrectDeathFX extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=64,G=255))
         ColorScale(1)=(RelativeTime=0.700000,Color=(B=255,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,R=64,A=255))
         FadeOutFactor=(X=0.600000)
         MaxParticles=25
         StartLocationShape=PTLS_All
         SphereRadiusRange=(Min=10.000000,Max=10.000000)
         UseRotationFrom=PTRS_Actor
         RotationOffset=(Yaw=-16384)
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.500000)
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'AW-2004Particles.Fire.SmokeFragment'
         LifetimeRange=(Min=0.500000,Max=1.000000)
         StartVelocityRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         StartVelocityRadialRange=(Min=-100.000000,Max=-200.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(0)=SpriteEmitter'InvasionProv1_7.InvasionProPetResurrectDeathFX.SpriteEmitter4'

     AutoDestroy=True
     bNoDelete=False
     RemoteRole=ROLE_SimulatedProxy
}
