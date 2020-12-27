//=============================================================================
// Brass class for NRP57 grenade
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class Brass_Grenade extends BWBrass_Default;

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();
	RotationRate.Pitch = 32768 + 32768*FRand();
}

defaultproperties
{
     StartVelocity=(X=20.000000,Y=0.000000)
     bHitSounds=False
     StaticMesh=StaticMesh'BallisticProStatic.Effects.GrenadeClip'
     DrawScale=0.200000
}
