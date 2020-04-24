//=============================================================================
// G5FlashEmitter.
// 
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class G5FlashEmitter extends BallisticEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	if (WeaponAttachment(Owner) != None)
		Emitters[1].ZTest = true;
}

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter2
         StaticMesh=StaticMesh'BallisticHardware2.G5.BazookaMuzzleFlash'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=64,R=128))
         FadeOutStartTime=0.100000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SizeScale(1)=(RelativeTime=0.100000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         DrawStyle=PTDS_Brighten
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.800000,Max=0.800000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
         StartVelocityRange=(X=(Min=30.000000,Max=30.000000))
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.G5FlashEmitter.MeshEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(G=128,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=64,R=128))
         FadeOutStartTime=0.100000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=20.000000)
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.800000,Max=0.800000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.G5FlashEmitter.SpriteEmitter3'
}
