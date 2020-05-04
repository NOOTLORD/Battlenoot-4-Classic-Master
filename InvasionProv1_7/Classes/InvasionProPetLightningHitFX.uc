class InvasionProPetLightningHitFX extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=140,G=255,R=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255))
         MaxParticles=1
         StartLocationShape=PTLS_All
         RevolutionsPerSecondRange=(Z=(Min=2.000000,Max=1.000000))
         RevolutionScale(0)=(RelativeRevolution=(Z=1.000000))
         RevolutionScale(1)=(RelativeTime=1.000000)
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=5.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000))
         ScaleSizeByVelocityMultiplier=(X=0.005000)
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'AW-2004Particles.Energy.ElecPanels'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.500000,Max=1.000000)
         StartVelocityRadialRange=(Min=20.000000,Max=20.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(0)=SpriteEmitter'InvasionProv1_7.InvasionProPetLightningHitFX.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=128,G=255,R=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255))
         Opacity=0.500000
         FadeOutStartTime=0.400000
         FadeInEndTime=0.200000
         MaxParticles=2
         SpinsPerSecondRange=(X=(Min=-0.200000,Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=5.000000,Max=25.000000))
         InitialParticlesPerSecond=75.000000
         Texture=Texture'EpicParticles.Flares.BurnFlare1'
         LifetimeRange=(Min=0.750000,Max=1.000000)
     End Object
     Emitters(1)=SpriteEmitter'InvasionProv1_7.InvasionProPetLightningHitFX.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         ColorScale(0)=(Color=(B=128,G=255,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255))
         Opacity=0.500000
         MaxParticles=1
         Texture=Texture'AW-2004Particles.Weapons.HardSpot'
         LifetimeRange=(Min=0.300000,Max=0.400000)
         WarmupTicksPerSecond=5.000000
         RelativeWarmupTime=1.000000
     End Object
     Emitters(2)=SpriteEmitter'InvasionProv1_7.InvasionProPetLightningHitFX.SpriteEmitter2'

     AutoDestroy=True
     bNoDelete=False
     RemoteRole=ROLE_SimulatedProxy
}
