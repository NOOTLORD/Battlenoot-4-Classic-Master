//=============================================================================
// Secondaryfire class for the X4 Knife
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyrightę 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD 						   
//=============================================================================
class X4SecondaryFire extends BallisticMeleeFire;

defaultproperties
{
     SwipePoints(0)=(offset=(Yaw=-1536))
     SwipePoints(1)=(offset=(Yaw=0))
     SwipePoints(2)=(offset=(Yaw=1536))
     WallHitPoint=1
     NumSwipePoints=3
     FatiguePerStrike=0.200000
     TraceRange=(Min=110.000000,Max=110.000000)
     Damage=90.000000
     DamageType=Class'BallisticProV55.DT_X4Body'
     DamageTypeHead=Class'BallisticProV55.DT_X4Head'
     DamageTypeArm=Class'BallisticProV55.DT_X4Body'
     KickForce=0
     PenetrateForce=0
     bPenetrate=False
     HookStopFactor=1.700000
     HookPullForce=100.000000
     bReleaseFireOnDie=False
     BallisticFireSound=(Sound=SoundGroup'BallisticProSounds.X4.X4-Melee',Volume=1.100000,Radius=8.000000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
     PreFireAnim="PrepMelee"
     FireAnim="Melee"
     AmmoClass=Class'BallisticProV55.Ammo_X4Knife'
     AmmoPerFire=0
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     BotRefireRate=0.500000
     WarnTargetPct=0.50000	 
}
