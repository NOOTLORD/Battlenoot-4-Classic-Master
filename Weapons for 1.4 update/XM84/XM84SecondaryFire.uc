//=============================================================================
// Secondaryfire class for XM84 Flashbang
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class XM84SecondaryFire extends XM84PrimaryFire;

defaultproperties
{
     NoClipPreFireAnim="PrepRoll"
     SpawnOffset=(Z=-14.000000)
     BrassClass=Class'BWBPRecolorsPro.Brass_XM84_Grenade'
     BrassBone="tip"
     BrassOffset=(X=10.000000)
     BallisticFireSound=(Sound=Sound'BallisticSounds2.NRP57.NRP57-Throw',Radius=32.000000,bAtten=True)	 
     PreFireAnim="PrepRoll"
     FireAnim="Roll"
     FireRate=2.000000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_XM84_Grenade'	 
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000	 
     ProjectileClass=Class'BWBPRecolorsPro.XM84Rolled'
}
