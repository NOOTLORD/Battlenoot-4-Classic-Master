class InvasionProPetShieldFX extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         ScaleSizeXByVelocity=True
         AutomaticInitialSpawning=False
         UseVelocityScale=True
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=179,G=104,R=77))
         ColorScale(2)=(RelativeTime=0.750000,Color=(B=192,G=128,R=128))
         ColorScale(3)=(RelativeTime=1.000000)
         MaxParticles=15
         StartLocationRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000))
         StartLocationShape=PTLS_All
         SphereRadiusRange=(Max=60.000000)
         RevolutionsPerSecondRange=(Z=(Min=2.000000,Max=1.000000))
         RevolutionScale(0)=(RelativeRevolution=(Z=1.000000))
         RevolutionScale(1)=(RelativeTime=1.000000)
         UseRotationFrom=PTRS_Actor
         SizeScale(0)=(RelativeSize=20.000000)
         SizeScale(1)=(RelativeTime=0.300000,RelativeSize=8.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000))
         ScaleSizeByVelocityMultiplier=(X=0.005000)
         InitialParticlesPerSecond=200.000000
         Texture=Texture'AW-2004Particles.Weapons.PlasmaStar2'
         LifetimeRange=(Min=0.500000,Max=2.000000)
         StartVelocityRange=(Z=(Min=0.500000,Max=1.000000))
         VelocityScale(0)=(RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
         VelocityScale(1)=(RelativeTime=0.200000,RelativeVelocity=(X=5.000000,Y=5.000000,Z=5.000000))
         VelocityScale(2)=(RelativeTime=0.400000,RelativeVelocity=(X=20.000000,Y=20.000000,Z=20.000000))
         VelocityScale(3)=(RelativeTime=1.000000)
     End Object
     Emitters(0)=SpriteEmitter'InvasionProv1_7.InvasionProPetShieldFX.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=167,G=118,R=88))
         ColorScale(2)=(RelativeTime=0.700000,Color=(B=192,G=128,R=128))
         ColorScale(3)=(RelativeTime=1.000000)
         Opacity=0.300000
         MaxParticles=5
         SpinsPerSecondRange=(X=(Min=-0.200000,Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=4.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=8.000000)
         StartSizeRange=(X=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=400.000000
         Texture=Texture'AW-2004Particles.Fire.SmokeFragment'
         LifetimeRange=(Min=1.000000,Max=1.250000)
     End Object
     Emitters(1)=SpriteEmitter'InvasionProv1_7.InvasionProPetShieldFX.SpriteEmitter2'

     AutoDestroy=True
     bNoDelete=False
     RemoteRole=ROLE_SimulatedProxy
}
