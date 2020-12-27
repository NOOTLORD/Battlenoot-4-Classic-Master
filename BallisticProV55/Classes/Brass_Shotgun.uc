//=============================================================================
// Brass class for the Shotgun type weapons
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class Brass_Shotgun extends BWBrass_Default;

var Emitter Trail;

// Initialize velocity and spin
simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

    if (level.DetailMode == DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2)
		Trail = Spawn(class'ShotgunBrassTrail',,, Location + vector(Rotation) * 19 * DrawScale);
	if (Trail != None)
	{
		class'BallisticEmitter'.static.ScaleEmitter(Trail, DrawScale);
		Trail.SetBase(self);
	}
}

simulated function Destroyed()
{
	if (Trail != None)
		Trail.Destroy();

	super.Destroyed();
}

defaultproperties
{
     StartVelocity=(Z=60.000000)
     HitSounds(0)=SoundGroup'BallisticProSounds.Effects.Shell-Concrete'
     HitSounds(1)=SoundGroup'BallisticProSounds.Effects.Shell-Concrete'
     HitSounds(2)=SoundGroup'BallisticProSounds.Effects.Shell-Concrete'
     HitSounds(3)=SoundGroup'BallisticProSounds.Effects.Shell-Metal'
     HitSounds(4)=SoundGroup'BallisticProSounds.Effects.Shell-Wood'
     HitSounds(5)=SoundGroup'BallisticProSounds.Effects.Shell-Wood'
     HitSounds(6)=SoundGroup'BallisticProSounds.Effects.Shell-Concrete'
     HitSounds(7)=SoundGroup'BallisticProSounds.Effects.Shell-Concrete'
     HitSounds(8)=SoundGroup'BallisticProSounds.Effects.Shell-Concrete'
     HitSounds(9)=SoundGroup'BallisticProSounds.Effects.Shell-Concrete'
     HitSounds(10)=SoundGroup'BallisticProSounds.Effects.Shell-Concrete'
     HitSoundVolume=0.140000
     StaticMesh=StaticMesh'BallisticProStatic.Effects.EmptyShell'
     DrawScale=0.110000
     DrawScale3D=(X=0.500000,Y=0.800000,Z=0.800000)
}
