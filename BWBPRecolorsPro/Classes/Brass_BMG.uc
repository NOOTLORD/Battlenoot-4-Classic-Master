//=============================================================================
// Brass_BMG.
//
// A .50 BMG casing that flies left.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class Brass_BMG extends BWBrass_Default;

defaultproperties
{
     StartVelocity=(X=10.000000,Y=-100.000000,Z=10.000000)
     bAddOwnerVelocity=False
     HitSoundVolume=0.125000
     StaticMesh=StaticMesh'VMmeshEmitted.EJECTA.EjectedBRASSsm'
     DrawScale=0.070000
     DrawScale3D=(X=0.750000,Y=0.800000,Z=0.800000)
     RotationRate=(Pitch=16384,Yaw=32768)
}
