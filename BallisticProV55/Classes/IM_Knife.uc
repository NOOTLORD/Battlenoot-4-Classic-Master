//=============================================================================
// IM_Knife.
//
// ImpactManager subclass for knives
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_Knife extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BallisticProV55.IE_KnifeConcrete'
     HitEffects(1)=Class'BallisticProV55.IE_KnifeConcrete'
     HitEffects(2)=Class'BallisticProV55.IE_BulletDirt'
     HitEffects(3)=Class'BallisticProV55.IE_KnifeMetal'
     HitEffects(4)=Class'BallisticProV55.IE_BulletWood'
     HitEffects(5)=Class'BallisticProV55.IE_BulletGrass'
     HitEffects(6)=Class'BallisticProV55.IE_BulletDirt'
     HitEffects(7)=Class'BallisticProV55.IE_BulletIce'
     HitEffects(8)=Class'BallisticProV55.IE_BulletIce'
     HitEffects(9)=Class'BallisticProV55.IE_ProjWater'
     HitEffects(10)=Class'BallisticProV55.IE_BulletGlass'
     HitDecals(0)=Class'BallisticProV55.AD_Knife'
     HitDecals(1)=Class'BallisticProV55.AD_Knife'
     HitDecals(2)=Class'BallisticProV55.AD_Knife'
     HitDecals(3)=Class'BallisticProV55.AD_Knife'
     HitDecals(4)=Class'BallisticProV55.AD_KnifeWood'
     HitDecals(5)=Class'BallisticProV55.AD_KnifeWood'
     HitDecals(6)=Class'BallisticProV55.AD_Knife'
     HitDecals(7)=Class'BallisticProV55.AD_Knife'
     HitDecals(8)=Class'BallisticProV55.AD_Knife'
     HitDecals(10)=Class'BallisticProV55.AD_Knife'
     HitSounds(0)=SoundGroup'BallisticProSounds.Effects.Knife-Concrete'
     HitSounds(1)=SoundGroup'BallisticProSounds.Effects.Knife-Concrete'
     HitSounds(2)=SoundGroup'BallisticProSounds.Effects.Knife-Concrete'
     HitSounds(3)=SoundGroup'BallisticProSounds.Effects.Knife-Metal'
     HitSounds(4)=SoundGroup'BallisticProSounds.Effects.Knife-Wood'
     HitSounds(5)=SoundGroup'BallisticProSounds.Effects.Knife-Wood'
     HitSounds(6)=SoundGroup'BallisticProSounds.Effects.Knife-Concrete'
     HitSounds(7)=SoundGroup'BallisticProSounds.Effects.Knife-Concrete'
     HitSounds(8)=SoundGroup'BallisticProSounds.Effects.Knife-Concrete'
     HitSounds(9)=SoundGroup'BallisticProSounds.Effects.Grenade-Water'
     HitSounds(10)=SoundGroup'BallisticProSounds.Effects.Knife-Concrete'
     HitSoundVolume=0.700000
     HitSoundRadius=32.000000
     HitDelay=0.250000
}
