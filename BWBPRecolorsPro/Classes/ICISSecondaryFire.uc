//=============================================================================
// ICISSecondaryFire.
//
// Preps and stabs the needle into people! Only heals teammates
//
// by Marc Sergeant Kelly Moylan
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class ICISSecondaryFire extends BallisticMeleeFire;

simulated function bool HasAmmo()
{
	return true;
}

defaultproperties
{
     SwipePoints(0)=(offset=(Pitch=4000,Yaw=2000))
     SwipePoints(1)=(offset=(Pitch=2000,Yaw=1000))
     SwipePoints(3)=(offset=(Pitch=-2000,Yaw=-1000))
     SwipePoints(4)=(offset=(Pitch=-4000,Yaw=-2000))
     SwipePoints(5)=(Weight=-1)
     SwipePoints(6)=(Weight=-1)
     TraceRange=(Min=96.000000,Max=96.000000)
     DamageHead=75.000000
     DamageLimb=75.000000
     DamageType=Class'BWBPRecolorsPro.DT_ICIS'
     DamageTypeHead=Class'BWBPRecolorsPro.DT_ICIS'
     DamageTypeArm=Class'BWBPRecolorsPro.DT_ICIS'
     KickForce=100
     HookStopFactor=1.700000
     HookPullForce=100.000000
     bReleaseFireOnDie=False
     BallisticFireSound=(Sound=SoundGroup'BallisticSounds_25.X4.X4_Melee',Radius=32.000000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
     PreFireAnim="PreFriendlyShank"
     FireAnim="FriendlyShank"
     FireRate=0.600000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_ICISStim'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=128.000000)
     ShakeRotRate=(X=2500.000000,Y=2500.000000,Z=2500.000000)
     ShakeRotTime=2.500000
     BotRefireRate=0.800000
     WarnTargetPct=0.050000
}
