//=============================================================================
// BloodSetDefault.
//
// Info for red blooded brutes like humans and juggs.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class BloodSetDefault extends BallisticBloodSet;

defaultproperties
{
     MyBloodName="default-red"
     MyBloodColor=(R=255)
     WaterBloodClass=Class'BallisticProV55.IE_WaterBlood' 
     BulletEffect=Class'BallisticProV55.BG_BulletHit'
     BulletHeadEffect=Class'BallisticProV55.BG_BulletHitHead'
     ShotgunEffect=Class'BallisticProV55.BG_ShellHit'
     ExplodeEffect=Class'BallisticProV55.IE_BloodExplode'
     SlashEffect=Class'BallisticProV55.BG_SlashHit'
     SlashHeadEffect=Class'BallisticProV55.BG_SlashHitHead'
     BulletHitSound=SoundGroup'BallisticSounds2.BulletImpacts.BulletFlesh'
     BulletHitHeadSound=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'
     DefaultGibClass=Class'BallisticProV55.BWGib_Default'
}
