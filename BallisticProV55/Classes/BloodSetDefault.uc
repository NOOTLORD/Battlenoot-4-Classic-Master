//=============================================================================
// BloodSetDefault.
//
// Info for red blooded brutes like humans and juggs.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BloodSetDefault extends BallisticBloodSet;

defaultproperties
{
     MyBloodName="default-red"
     MyBloodColor=(R=255)
     BulletEffect=Class'BallisticProV55.BG_BulletHit'
     HeadExplode=Class'BallisticProV55.BG_HeadExplode'
     BulletHitSound=SoundGroup'BallisticSounds2.BulletImpacts.BulletFlesh'
     BulletHitHeadSound=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'
     DefaultGibClass=Class'BallisticProV55.BWGib_Default'
}
