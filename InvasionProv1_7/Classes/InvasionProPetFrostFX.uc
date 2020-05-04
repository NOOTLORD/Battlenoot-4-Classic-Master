class InvasionProPetFrostFX extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         UseVelocityScale=True
         Acceleration=(Z=10.000000)
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=192,G=128))
         ColorScale(2)=(RelativeTime=0.800000,Color=(B=255,G=255,R=128))
         ColorScale(3)=(RelativeTime=1.000000)
         Opacity=0.750000
         MaxParticles=7
         StartLocationRange=(X=(Min=-30.000000,Max=30.000000),Y=(Min=-30.000000,Max=30.000000))
         StartLocationShape=PTLS_All
         SphereRadiusRange=(Min=10.000000,Max=40.000000)
         RevolutionScale(0)=(RelativeRevolution=(Z=1.000000))
         RevolutionScale(1)=(RelativeTime=1.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=3.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
         StartSizeRange=(X=(Min=2.000000,Max=4.000000),Y=(Min=5.000000,Max=5.000000))
         Texture=Texture'InvasionProv1_7.aura_fx_snowflake'
         TextureUSubdivisions=4
         TextureVSubdivisions=1
         LifetimeRange=(Min=1.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=8.000000,Max=10.000000))
         VelocityScale(0)=(RelativeVelocity=(X=2.000000,Y=2.000000,Z=1.000000))
         VelocityScale(1)=(RelativeTime=0.200000,RelativeVelocity=(X=10.000000,Y=10.000000,Z=1.000000))
     End Object
     Emitters(0)=SpriteEmitter'InvasionProv1_7.InvasionProPetFrostFX.SpriteEmitter0'

     AutoDestroy=True
     bNoDelete=False
     RemoteRole=ROLE_SimulatedProxy
}
