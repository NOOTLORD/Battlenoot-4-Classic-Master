class InvasionProPetDeflectFX extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseDirectionAs=PTDU_Forward
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         ScaleSizeXByVelocity=True
         ScaleSizeYByVelocity=True
         AutomaticInitialSpawning=False
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000))
         FadeInEndTime=0.250000
         CoordinateSystem=PTCS_Relative
         MaxParticles=12
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=65.000000,Max=65.000000),Y=(Min=65.000000,Max=65.000000))
         ScaleSizeByVelocityMultiplier=(X=0.200000,Y=0.200000)
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'InvasionProTexturesv1_4.HUD.PulseRing02'
         LifetimeRange=(Min=0.500000,Max=1.000000)
         StartVelocityRange=(X=(Min=5.000000,Max=10.000000))
     End Object
     Emitters(0)=SpriteEmitter'InvasionProv1_7.InvasionProPetDeflectFX.SpriteEmitter3'

     AutoDestroy=True
     bNoDelete=False
     RemoteRole=ROLE_SimulatedProxy
}
