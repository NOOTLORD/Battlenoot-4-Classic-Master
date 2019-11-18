//=============================================================================
// FG50Heater
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class FG50Heater extends BallisticEmitter;

simulated function SetHeat(float NewHeat)
{
	if (NewHeat == 0)
	{
		Emitters[0].Disabled = true;
		Emitters[1].Disabled = true;
	}
	else if (Emitters[0].Disabled)
	{
		Emitters[0].Disabled = false;
		Emitters[1].Disabled = false;
	}
	Emitters[0].Opacity = NewHeat;
	Emitters[1].Opacity = 0.4 * NewHeat;
}

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter1
         StaticMesh=StaticMesh'BallisticRecolors4StaticPro.FG50.FG50Barrel'
         UseMeshBlendMode=False
         UseParticleColor=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.200000,Max=0.200000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=1.000000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSizeRange=(X=(Min=1.670000,Max=1.670000),Y=(Min=1.670000,Max=1.670000),Z=(Min=1.670000,Max=1.670000))
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(0)=MeshEmitter'BWBPRecolorsPro.FG50Heater.MeshEmitter1'

     Emitters(1)=SpriteEmitter'BallisticProV55.RX22AHeater.SpriteEmitter3'

     Emitters(2)=SpriteEmitter'BallisticProV55.RX22AHeater.SpriteEmitter6'

}
