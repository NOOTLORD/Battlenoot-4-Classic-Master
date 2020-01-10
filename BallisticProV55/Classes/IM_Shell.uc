//=============================================================================
// IM_Shell.
//
// ImpactManager subclass for shotgun impacts
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_Shell extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BallisticProV55.IE_ShellConcrete'
     HitEffects(1)=Class'BallisticProV55.IE_ShellConcrete'
     HitEffects(2)=Class'BallisticProV55.IE_ShellDirt'
     HitEffects(3)=Class'BallisticProV55.IE_ShellMetal'
     HitEffects(4)=Class'BallisticProV55.IE_ShellWood'
     HitEffects(5)=Class'BallisticProV55.IE_BulletGrass'
     HitEffects(6)=Class'XEffects.pclredsmoke'
     HitEffects(7)=Class'BallisticProV55.IE_ShellIce'
     HitEffects(8)=Class'BallisticProV55.IE_ShellSnow'
     HitEffects(9)=Class'BallisticProV55.IE_ShellWater'
     HitEffects(10)=Class'BallisticProV55.IE_BulletGlass'
     HitSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.BulletConcrete'
     HitSounds(1)=SoundGroup'BallisticSounds2.BulletImpacts.BulletConcrete'
     HitSounds(2)=SoundGroup'BallisticSounds2.BulletImpacts.BulletConcrete'
     HitSounds(3)=SoundGroup'BallisticSounds2.BulletImpacts.BulletMetal'
     HitSounds(4)=SoundGroup'BallisticSounds2.BulletImpacts.BulletWood'
     HitSounds(5)=SoundGroup'BallisticSounds2.BulletImpacts.BulletConcrete'
     HitSounds(6)=SoundGroup'BallisticSounds2.BulletImpacts.BulletConcrete'
     HitSounds(7)=SoundGroup'BallisticSounds2.BulletImpacts.BulletConcrete'
     HitSounds(8)=SoundGroup'BallisticSounds2.BulletImpacts.BulletConcrete'
     HitSounds(9)=SoundGroup'BallisticSounds2.BulletImpacts.BulletWater'
     HitSounds(10)=SoundGroup'BallisticSounds2.BulletImpacts.BulletConcrete'
     HitSoundVolume=0.300000
     HitDelay=0.080000
}
