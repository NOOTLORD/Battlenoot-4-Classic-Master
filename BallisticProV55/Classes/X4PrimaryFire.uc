//=============================================================================
// X4PrimaryFire.
//
// Rapid swinging of the knife. Effective in an insane melee.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
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

simulated function bool HasAmmo()
{
	return true;
}

defaultproperties
{
     SliceAnims(0)="Slash1"
     SliceAnims(1)="Slash2"
     SliceAnims(2)="Slash3"
     SliceAnims(3)="Slash4"
     FatiguePerStrike=0.060000
     bCanBackstab=False
     TraceRange=(Min=130.000000,Max=130.000000)
     Damage=55.000000
     DamageHead=55.000000
     DamageLimb=55.000000
     DamageType=Class'BallisticProV55.DTX4Knife'
     DamageTypeHead=Class'BallisticProV55.DTX4KnifeHead'
     DamageTypeArm=Class'BallisticProV55.DTX4KnifeLimb'
     KickForce=0
     BallisticFireSound=(Sound=SoundGroup'BallisticSounds_25.X4.X4_Melee',Radius=378.000000,bAtten=True)
     bAISilent=True
     FireAnim="Slash1"
     FireAnimRate=1.500000
     FireRate=0.350000
     AmmoClass=Class'BallisticProV55.Ammo_X4Knife'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=128.000000)
     ShakeRotRate=(X=2500.000000,Y=2500.000000,Z=2500.000000)
     ShakeRotTime=0.000000
     BotRefireRate=0.9900000
     WarnTargetPct=0.300000
}
