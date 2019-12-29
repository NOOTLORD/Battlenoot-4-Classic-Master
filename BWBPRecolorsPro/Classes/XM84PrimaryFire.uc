//=============================================================================
// XM84PrimaryFire.
//
// XM84 Grenade thrown overhand
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Edited by (NL)NOOTLORD
//=============================================================================
class XM84PrimaryFire extends BallisticGrenadeFire;

defaultproperties
{
     NoClipPreFireAnim="PrepThrow"
     SpawnOffset=(X=25.000000,Y=10.000000,Z=2.000000)
     BrassClass=Class'BWBPRecolorsPro.Brass_XClip'
     BrassBone="tip"
     BrassOffset=(X=10.000000)
     BallisticFireSound=(Sound=Sound'BallisticSounds2.NRP57.NRP57-Throw',Radius=32.000000,bAtten=True)
     PreFireAnim="PrepThrow"
     FireAnim="Throw"
     FireRate=2.000000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_XM84flash'
     ShakeRotMag=(X=0.000000,Y=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000						  
     ShakeOffsetMag=(X=0.000000)
     ShakeOffsetRate=(X=0.000000)
     ShakeOffsetTime=0.000000							 
     ProjectileClass=Class'BWBPRecolorsPro.XM84Thrown'
     aimerror=600.000000
}
