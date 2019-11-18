//=============================================================================
// E23FlashEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class E23FlashEmitter extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter2
         StaticMesh=StaticMesh'BWBP4-Hardware.VPR.VPRMuzzleFlash'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.235714,Color=(B=96,G=96,R=96,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.900000),Z=(Min=0.600000,Max=0.600000))
         FadeOutStartTime=0.056000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=-2.000000)
         SpinCCWorCW=(Z=0.000000)
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=0.250000,RelativeSize=0.700000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=0.850000,Max=0.850000),Y=(Min=0.850000,Max=0.850000),Z=(Min=0.850000,Max=0.850000))
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.E23FlashEmitter.MeshEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.221429,Color=(B=96,G=96,R=96,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(G=128,R=128,A=255))
         ColorMultiplierRange=(Z=(Min=0.000000,Max=0.000000))
         Opacity=0.570000
         FadeOutStartTime=0.025000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=20.000000)
         StartSizeRange=(X=(Min=35.000000,Max=35.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         Texture=Texture'BallisticEffects.Particles.FlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.E23FlashEmitter.SpriteEmitter10'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseDirectionAs=PTDU_Normal
         ProjectionNormal=(X=1.000000,Z=0.000000)
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=96,G=255,R=200,A=255))
         ColorMultiplierRange=(Z=(Min=0.750000,Max=0.750000))
         FadeOutStartTime=0.260000
         FadeInEndTime=0.012000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.100000)
         StartSizeRange=(X=(Min=7.000000,Max=8.500000),Y=(Min=7.000000,Max=8.500000),Z=(Min=7.000000,Max=8.500000))
         Texture=Texture'BWBP4-Tex.VPR.VPR-MuzzleEffect'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         SpawnOnTriggerRange=(Min=1.000000,Max=2.000000)
         SpawnOnTriggerPPS=20.000000
         StartVelocityRange=(X=(Min=150.000000,Max=300.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.E23FlashEmitter.SpriteEmitter1'

     bSelected=True
}
