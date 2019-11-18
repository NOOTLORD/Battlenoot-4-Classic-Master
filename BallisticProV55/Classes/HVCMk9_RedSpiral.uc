//=============================================================================
// HVCMk9_RedSpiral.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class HVCMk9_RedSpiral extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter15
         UseDirectionAs=PTDU_Forward
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.360000
         FadeInEndTime=0.130000
         CoordinateSystem=PTCS_Relative
         MaxParticles=8
         StartLocationOffset=(X=-10.000000)
         SpinCCWorCW=(X=1.000000)
         SpinsPerSecondRange=(X=(Min=-0.250000,Max=-0.250000))
         StartSpinRange=(X=(Min=-0.450000,Max=-0.450000))
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         Texture=Texture'BWBP2-FX.Particles.FlareC2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-50.000000,Max=-50.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.HVCMk9_RedSpiral.SpriteEmitter15'

     Begin Object Class=BeamEmitter Name=BeamEmitter10
         BeamDistanceRange=(Min=20.000000,Max=30.000000)
         DetermineEndPointBy=PTEP_Distance
         BeamTextureUScale=2.000000
         LowFrequencyPoints=2
         HighFrequencyPoints=2
         FadeOut=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.040000
         CoordinateSystem=PTCS_Relative
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=-12.000000)
         StartLocationRange=(X=(Min=-35.000000))
         StartSizeRange=(X=(Min=3.000000,Max=4.000000),Y=(Min=3.000000,Max=4.000000),Z=(Min=3.000000,Max=4.000000))
         Texture=Texture'BWBP2-FX.Particles.LightningBoltCut2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
         StartVelocityRange=(X=(Min=-0.200000,Max=0.200000),Y=(Min=-3.000000,Max=1.000000),Z=(Max=3.000000))
     End Object
     Emitters(1)=BeamEmitter'BallisticProV55.HVCMk9_RedSpiral.BeamEmitter10'

}
