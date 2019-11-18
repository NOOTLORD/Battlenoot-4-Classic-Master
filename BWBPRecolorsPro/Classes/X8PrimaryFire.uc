//=============================================================================
// X8 knife primary.
//
// Slicing.
//=============================================================================
class X8PrimaryFire extends BallisticMeleeFire;

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
     SwipePoints(0)=(offset=(Pitch=2000,Yaw=4000))
     SwipePoints(1)=(offset=(Pitch=1000))
     SwipePoints(3)=(offset=(Pitch=1000,Yaw=-2000,Roll=32768))
     SwipePoints(4)=(offset=(Pitch=2000,Yaw=-4000))
     SwipePoints(5)=(Weight=-1)
     SwipePoints(6)=(Weight=-1)
     FatiguePerStrike=0.035000
     TraceRange=(Min=140.000000,Max=140.000000)
     Damage=30.000000
     DamageHead=30.000000
     DamageLimb=30.000000
     DamageType=Class'BWBPRecolorsPro.DTX8Knife'
     DamageTypeHead=Class'BWBPRecolorsPro.DTX8Knife'
     DamageTypeArm=Class'BWBPRecolorsPro.DTX8Knife'
     KickForce=100
     BallisticFireSound=(Sound=SoundGroup'BallisticSounds_25.X4.X4_Melee',Radius=32.000000,bAtten=True)
     bAISilent=True
     FireAnim="Slash1"
     FireRate=0.300000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_X8Knife'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=128.000000)
     ShakeRotRate=(X=2500.000000,Y=2500.000000,Z=2500.000000)
     ShakeRotTime=2.500000
     BotRefireRate=0.800000
     WarnTargetPct=0.100000
}
