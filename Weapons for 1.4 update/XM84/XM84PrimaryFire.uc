//=============================================================================
// XM84PrimaryFire.
//
// XM84 Grenade thrown overhand
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class XM84PrimaryFire extends BallisticGrenadeFire;

defaultproperties
{
     NoClipPreFireAnim="PrepThrow"
     SpawnOffset=(X=25.000000,Y=10.000000,Z=2.000000)
     BrassClass=Class'BWBPRecolorsPro.Brass_XM84_Grenade'
     BrassBone="tip"
     BrassOffset=(X=10.000000)
     BallisticFireSound=(Sound=Sound'BallisticSounds2.NRP57.NRP57-Throw',Radius=32.000000,bAtten=True)
     PreFireAnim="PrepThrow"
     FireAnim="Throw"
     FireRate=2.000000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_XM84_Grenade'
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BWBPRecolorsPro.XM84Thrown'
}
