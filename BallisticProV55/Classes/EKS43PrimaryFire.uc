//=============================================================================
// EKS43PrimaryFire.
//
// Horizontalish swipe attack for the EKS43. Uses melee swpie system to do
// horizontal swipes. When the swipe traces find a player, the trace closest to
// the aim will be used to do the damage.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class EKS43PrimaryFire extends BallisticMeleeFire;

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
     FatiguePerStrike=0.080000
     bCanBackstab=False
     TraceRange=(Min=160.000000,Max=160.000000)
     DamageHead=75.000000
     DamageLimb=75.000000
     DamageType=Class'BallisticProV55.DTEKS43Katana'
     DamageTypeHead=Class'BallisticProV55.DTEKS43KatanaHead'
     DamageTypeArm=Class'BallisticProV55.DTEKS43KatanaLimb'
     KickForce=100
     BallisticFireSound=(Sound=SoundGroup'BallisticSounds3.EKS43.EKS-Slash',Radius=378.000000,bAtten=True)
     bAISilent=True
     FireAnim="Slash1"
     FireRate=0.550000
     AmmoClass=Class'BallisticProV55.Ammo_Knife'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=512.000000)
     ShakeRotRate=(X=3000.000000,Y=3000.000000,Z=3000.000000)
     ShakeRotTime=2.500000
     BotRefireRate=0.800000
     WarnTargetPct=0.100000
}
