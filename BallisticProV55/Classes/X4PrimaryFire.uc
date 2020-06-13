//=============================================================================
// X4PrimaryFire.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD 						   
//=============================================================================
class X4PrimaryFire extends BallisticMeleeFire;

var() Array<name> SliceAnims;
var int SliceAnim;

simulated event ModeDoFire()
{
	FireAnim = SliceAnims[SliceAnim];
	SliceAnim++;
	if (SliceAnim >= SliceAnims.Length)
		SliceAnim = 0;

	Super.ModeDoFire();
}

defaultproperties
{
     SliceAnims(0)="Slash1"
     SliceAnims(1)="Slash2"
     SliceAnims(2)="Slash3"
     SliceAnims(3)="Slash4"
     FatiguePerStrike=0.060000
     bCanBackstab=False
     TraceRange=(Min=110.000000,Max=110.000000)
     Damage=55.000000
     DamageHead=55.000000
     DamageLimb=55.000000
     DamageType=Class'BallisticProV55.DT_X4Knife'
     DamageTypeHead=Class'BallisticProV55.DT_X4KnifeHead'
     DamageTypeArm=Class'BallisticProV55.DT_X4Knife'
     KickForce=0
     PenetrateForce=0
     bPenetrate=False
     BallisticFireSound=(Sound=SoundGroup'BallisticSounds1.X4.X4_Melee',Volume=1.100000,Radius=8.000000,bAtten=True)
     bAISilent=True
     FireAnim="Slash1"
     FireAnimRate=1.500000
     FireRate=0.350000
     AmmoClass=Class'BallisticProV55.Ammo_X4_Knife'
     AmmoPerFire=0
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     BotRefireRate=0.9900000
}
