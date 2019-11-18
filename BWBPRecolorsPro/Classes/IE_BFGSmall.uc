//=============================================================================
// IE_A73General.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_BFGSmall extends DGVEmitter
	placeable;

simulated event PreBeginPlay()
{
	if (Level.DetailMode < DM_SuperHigh)
		Emitters[2].Disabled=true;
	if (Level.DetailMode < DM_High)
		Emitters[0].Disabled=true;

//	if ( !FastTrace(Location + Vector(Rotation)*8 ,Level.GetLocalPlayerController().Location) )
	if ( !FastTrace(Location + Vector(Rotation)*8 ,Level.GetLocalPlayerController().ViewTarget.Location) )
	{
		SetLocation(Location + Vector(Rotation)*8);
		Emitters[1].ZTest = true;
		Emitters[2].ZTest = true;
	}
	Super.PreBeginPlay();
}

defaultproperties
{
     DisableDGV(1)=1
     Begin Object Class=SpriteEmitter Name=SpriteEmitter12
         UseCollision=True
         UseMaxCollisions=True
         UseColorScale=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-750.000000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=32,G=255,R=32))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.200000),Y=(Min=2.000000,Max=0.400000),Z=(Min=0.000000,Max=0.200000))
         MaxParticles=30
         StartSizeRange=(X=(Min=1.500000,Max=2.000000))
         InitialParticlesPerSecond=100.000000
         Texture=Texture'BallisticRecolors3TexPro.A73b.A73BMuzzleFlash'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SubdivisionStart=1
         SubdivisionEnd=1
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Max=200.000000),Y=(Min=-90.000000,Max=90.000000),Z=(Min=-150.000000,Max=350.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBPRecolorsPro.IE_BFGSmall.SpriteEmitter12'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter13
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         ZTest=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.342857,Color=(B=255,G=192,R=192,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=128))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.200000),Y=(Min=2.000000,Max=0.400000),Z=(Min=0.000000,Max=0.200000))
         FadeOutStartTime=0.090000
         FadeInEndTime=0.090000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SizeScale(0)=(RelativeSize=1.250000)
         SizeScale(1)=(RelativeTime=0.040000,RelativeSize=0.600000)
         SizeScale(2)=(RelativeTime=0.100000,RelativeSize=0.800000)
         StartSizeRange=(X=(Min=20.000000,Max=30.000000))
         InitialParticlesPerSecond=100000.000000
         Texture=Texture'BallisticRecolors3TexPro.A73b.A73BMuzzleFlash'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SubdivisionStart=1
         SubdivisionEnd=1
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.500000,Max=1.500000)
     End Object
     Emitters(1)=SpriteEmitter'BWBPRecolorsPro.IE_BFGSmall.SpriteEmitter13'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter14
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         Opacity=0.400000
         FadeOutStartTime=1.065000
         FadeInEndTime=0.150000
         MaxParticles=45
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=0.550000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=5.000000,Max=5.000000))
         InitialParticlesPerSecond=20.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.Smoke4'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=20.000000,Max=30.000000))
         VelocityLossRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
     End Object
     Emitters(2)=SpriteEmitter'BWBPRecolorsPro.IE_BFGSmall.SpriteEmitter14'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter15
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-600.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.467857,Color=(B=255,G=128,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.200000),Y=(Min=2.000000,Max=0.400000),Z=(Min=0.000000,Max=0.200000))
         FadeOutStartTime=0.028000
         MaxParticles=24
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.085000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=0.500000,RelativeSize=0.750000)
         StartSizeRange=(X=(Min=7.500000,Max=15.000000),Y=(Min=7.500000,Max=15.000000),Z=(Min=7.500000,Max=15.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BallisticWeapons2.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.350000,Max=0.350000)
         StartVelocityRange=(X=(Min=50.000000,Max=500.000000),Y=(Min=-300.000000,Max=300.000000),Z=(Min=-50.000000,Max=350.000000))
     End Object
     Emitters(3)=SpriteEmitter'BWBPRecolorsPro.IE_BFGSmall.SpriteEmitter15'

     AutoDestroy=True
}
