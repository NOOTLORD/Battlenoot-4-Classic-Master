//=============================================================================
// Brass_SAR.
//
// A rifle shell casing that flies out left
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class Brass_SAR extends BWBrass_Default;

defaultproperties
{
     RandomDir=(Pitch=1024,Yaw=1024,Roll=1024)
     StartVelocity=(X=10.000000,Y=-60.000000,Z=0.000000)
     bAddOwnerVelocity=False
     HitSoundVolume=0.140000
     StaticMesh=StaticMesh'BallisticHardware2.Brass.EmptyRifleRound'
     DrawScale=0.090000
     DrawScale3D=(X=0.600000)
     RotationRate=(Pitch=16384,Yaw=32768)
}
