//=============================================================================
// Secondaryfire class for the FP7 Grenade
// 
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class FP7SecondaryFire extends FP7PrimaryFire;

defaultproperties
{
     NoClipPreFireAnim="RollNoClip"
     SpawnOffset=(Z=-14.000000)
     BrassClass=Class'BallisticProV55.Brass_FP7Clip'
     BrassBone="tip"
     BrassOffset=(X=-20.000000,Z=-2.000000)
     BallisticFireSound=(Sound=Sound'BallisticSounds2.NRP57.NRP57-Throw',Radius=32.000000,bAtten=True)	 
     PreFireAnim="PrepRoll"
     FireAnim="Roll"
     AmmoClass=Class'BallisticProV55.Ammo_FP7_Grenade'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000	 
     ProjectileClass=Class'BallisticProV55.FP7Rolled'
	 WarnTargetPct=0.9	 
}
