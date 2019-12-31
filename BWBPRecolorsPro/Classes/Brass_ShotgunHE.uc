//=============================================================================
// Brass_ShotgunHE.
//
// A HE Shotgun shell casing
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Brass_ShotgunHE extends BWBrass_Default;

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
     StartVelocity=(Y=50.000000,Z=40.000000)
     bAddOwnerVelocity=False
     HitSounds(0)=SoundGroup'BallisticSounds2.Brass.ShellConcrete'
     HitSounds(1)=SoundGroup'BallisticSounds2.Brass.ShellConcrete'
     HitSounds(2)=SoundGroup'BallisticSounds2.Brass.ShellConcrete'
     HitSounds(3)=SoundGroup'BallisticSounds2.Brass.ShellMetal'
     HitSounds(4)=SoundGroup'BallisticSounds2.Brass.ShellWood'
     HitSounds(5)=SoundGroup'BallisticSounds2.Brass.ShellWood'
     HitSounds(6)=SoundGroup'BallisticSounds2.Brass.ShellConcrete'
     HitSounds(7)=SoundGroup'BallisticSounds2.Brass.ShellConcrete'
     HitSounds(8)=SoundGroup'BallisticSounds2.Brass.ShellConcrete'
     HitSounds(9)=SoundGroup'BallisticSounds2.Brass.ShellConcrete'
     HitSounds(10)=SoundGroup'BallisticSounds2.Brass.ShellConcrete'
     HitSoundVolume=0.125000
     StaticMesh=StaticMesh'BallisticHardware2.Brass.EmptyShell'
     DrawScale=0.110000
	 DrawScale3D=(X=0.700000,Y=0.700000,Z=0.700000)
     Skins(0)=Texture'BallisticRecolors3TexPro.SK410.Cart_ShotgunHE'
     bSelected=True
}
