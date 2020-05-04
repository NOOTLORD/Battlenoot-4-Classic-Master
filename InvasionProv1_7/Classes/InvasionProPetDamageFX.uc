class InvasionProPetDamageFX extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseDirectionAs=PTDU_Scale
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         ScaleSizeYByVelocity=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=200.000000)
         ColorScale(1)=(RelativeTime=0.100000,Color=(R=255))
         ColorScale(2)=(RelativeTime=0.800000,Color=(B=128,R=128))
         ColorScale(3)=(RelativeTime=1.000000)
         Opacity=0.850000
         FadeOutStartTime=0.500000
         MaxParticles=7
         StartLocationRange=(X=(Min=-25.000000,Max=25.000000),Y=(Min=-25.000000,Max=25.000000))
         StartLocationShape=PTLS_All
         SphereRadiusRange=(Min=10.000000,Max=20.000000)
         RevolutionScale(0)=(RelativeRevolution=(Z=1.000000))
         RevolutionScale(1)=(RelativeTime=1.000000)
         UseRotationFrom=PTRS_Actor
         SizeScale(0)=(RelativeSize=20.000000)
         SizeScale(1)=(RelativeTime=0.300000,RelativeSize=8.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=2.000000,Max=5.000000),Y=(Min=2.000000,Max=5.000000))
         ScaleSizeByVelocityMultiplier=(Y=0.008000)
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'EpicParticles.Flares.OutSpark01aw'
         LifetimeRange=(Min=1.000000,Max=2.000000)
         StartVelocityRange=(Z=(Min=8.000000,Max=10.000000))
         VelocityScale(0)=(RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
         VelocityScale(1)=(RelativeTime=0.200000,RelativeVelocity=(X=10.000000,Y=10.000000,Z=10.000000))
         VelocityScale(2)=(RelativeTime=0.400000,RelativeVelocity=(X=15.000000,Y=15.000000,Z=15.000000))
         VelocityScale(3)=(RelativeTime=1.000000,RelativeVelocity=(X=200.000000,Y=200.000000,Z=200.000000))
     End Object
     Emitters(0)=SpriteEmitter'InvasionProv1_7.InvasionProPetDamageFX.SpriteEmitter5'

     AutoDestroy=True
     bNoDelete=False
     RemoteRole=ROLE_SimulatedProxy
}
