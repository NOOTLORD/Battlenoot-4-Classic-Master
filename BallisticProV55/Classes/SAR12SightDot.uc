//=============================================================================
// SARSightDot.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class SAR12SightDot extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseDirectionAs=PTDU_Normal
         ProjectionNormal=(X=1.000000,Z=0.000000)
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=-20.000000,Z=27.250000)
         StartSizeRange=(X=(Min=11.000000,Max=11.000000),Y=(Min=11.000000,Max=11.000000),Z=(Min=11.000000,Max=11.000000))
         Texture=Texture'BallisticProTex.SAR-12.SAR-12-SightRed'
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.SAR12SightDot.SpriteEmitter0'

     bHidden=True
}
