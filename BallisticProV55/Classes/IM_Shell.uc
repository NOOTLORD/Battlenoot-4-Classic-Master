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
     HitDecals(0)=Class'BallisticProV55.AD_ShellConcrete'
     HitDecals(1)=Class'BallisticProV55.AD_ShellConcrete'
     HitDecals(3)=Class'BallisticProV55.AD_ShellMetal'
     HitDecals(4)=Class'BallisticProV55.AD_ShellWood'
     HitDecals(5)=Class'BallisticProV55.AD_ShellConcrete'
     HitDecals(6)=Class'BallisticProV55.AD_ShellConcrete'
     HitDecals(7)=Class'BallisticProV55.AD_ShellConcrete'
     HitDecals(10)=Class'BallisticProV55.AD_ShellConcrete'
     HitSounds(0)=SoundGroup'BallisticProSounds.Effects.Bullet-Concrete'
     HitSounds(1)=SoundGroup'BallisticProSounds.Effects.Bullet-Concrete'
     HitSounds(2)=SoundGroup'BallisticProSounds.Effects.Bullet-Concrete'
     HitSounds(3)=SoundGroup'BallisticProSounds.Effects.Bullet-Metal'
     HitSounds(4)=SoundGroup'BallisticProSounds.Effects.Bullet-Wood'
     HitSounds(5)=SoundGroup'BallisticProSounds.Effects.Bullet-Concrete'
     HitSounds(6)=SoundGroup'BallisticProSounds.Effects.Bullet-Concrete'
     HitSounds(7)=SoundGroup'BallisticProSounds.Effects.Bullet-Concrete'
     HitSounds(8)=SoundGroup'BallisticProSounds.Effects.Bullet-Concrete'
     HitSounds(9)=SoundGroup'BallisticProSounds.Effects.Bullet-Water'
     HitSounds(10)=SoundGroup'BallisticProSounds.Effects.Bullet-Concrete'
     HitSoundVolume=0.300000
     HitDelay=0.080000
}
