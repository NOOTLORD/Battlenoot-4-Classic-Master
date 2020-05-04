class InvasionProPetLevelUpFX extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseDirectionAs=PTDU_UpAndNormal
         UseColorScale=True
         RespawnDeadParticles=False
         UseRevolution=True
         UseRevolutionScale=True
         UseSizeScale=True
         UseRegularSizeScale=False
         ScaleSizeXByVelocity=True
         AutomaticInitialSpawning=False
         UseVelocityScale=True
         Acceleration=(Z=-5.000000)
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=128,G=255,R=255))
         ColorScale(2)=(RelativeTime=0.750000,Color=(B=245,G=10,R=98))
         ColorScale(3)=(RelativeTime=1.000000)
         MaxParticles=100
         StartLocationRange=(Z=(Min=-64.000000,Max=64.000000))
         StartLocationShape=PTLS_All
         SphereRadiusRange=(Min=32.000000,Max=50.000000)
         RevolutionsPerSecondRange=(Z=(Min=2.000000,Max=1.000000))
         RevolutionScale(0)=(RelativeRevolution=(Z=1.000000))
         RevolutionScale(1)=(RelativeTime=1.000000)
         UseRotationFrom=PTRS_Actor
         SizeScale(0)=(RelativeSize=20.000000)
         SizeScale(1)=(RelativeTime=0.300000,RelativeSize=8.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=8.000000,Max=12.000000),Y=(Min=2.000000,Max=10.000000))
         ScaleSizeByVelocityMultiplier=(X=0.005000)
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'AW-2004Particles.Weapons.PlasmaStar2'
         LifetimeRange=(Min=0.500000,Max=2.000000)
         StartVelocityRange=(Z=(Min=8.000000,Max=10.000000))
         VelocityScale(0)=(RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
         VelocityScale(1)=(RelativeTime=0.200000,RelativeVelocity=(X=5.000000,Y=5.000000,Z=5.000000))
         VelocityScale(2)=(RelativeTime=0.400000,RelativeVelocity=(X=20.000000,Y=20.000000,Z=20.000000))
         VelocityScale(3)=(RelativeTime=1.000000,RelativeVelocity=(X=200.000000,Y=200.000000,Z=200.000000))
     End Object
     Emitters(0)=SpriteEmitter'InvasionProv1_7.InvasionProPetLevelUpFX.SpriteEmitter0'

     AutoDestroy=True
     bNoDelete=False
     bNetTemporary=True
     RemoteRole=ROLE_SimulatedProxy
}
