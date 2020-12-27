//=============================================================================
// IE_GunConcrete.
// 
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_GunConcrete extends DGVEmitter
	placeable;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter14
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-30.000000)
         ColorScale(0)=(Color=(B=230,G=240,R=255,A=128))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=230,G=240,R=255,A=255))
         FadeOutStartTime=0.100000
         MaxParticles=5
         SpinsPerSecondRange=(X=(Max=0.300000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.300000,RelativeSize=0.600000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=15.000000,Max=20.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticProEffectsTex.Particles.Smoke1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=20.000000,Max=60.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=30.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_GunConcrete.SpriteEmitter14'

}
