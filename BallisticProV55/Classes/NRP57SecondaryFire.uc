//=============================================================================
// Secondaryfire class for NRP57 Grenade
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class NRP57SecondaryFire extends NRP57PrimaryFire;

defaultproperties
{
     NoClipPreFireAnim="RollNoClip"
     SpawnOffset=(Z=-14.000000)
     BrassClass=Class'BallisticProV55.Brass_Grenade'
     BrassBone="tip"
     BrassOffset=(X=10.000000)
     BallisticFireSound=(Sound=Sound'BallisticSounds2.NRP57.NRP57-Throw',Volume=0.500000,Radius=32.000000,bAtten=True)	 
     PreFireAnim="PrepRoll"
     FireAnim="Roll" 
     AmmoClass=Class'BallisticProV55.Ammo_NRP57_Grenade'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000	 
     ProjectileClass=Class'BallisticProV55.NRP57Rolled'
 	 BotRefireRate=0.4
     WarnTargetPct=0.75 	 
}
