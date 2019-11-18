//=============================================================================
// XM84SecondaryFire.
//
// XM84 Grenade rolled underhand
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class XM84SecondaryFire extends XM84PrimaryFire;

defaultproperties
{
     NoClipPreFireAnim="PrepRoll"
     SpawnOffset=(Z=-14.000000)
     PreFireAnim="PrepRoll"
     FireAnim="Roll"
     ShakeRotTime=0.000000
     ShakeOffsetTime=0.000000
     ProjectileClass=Class'BWBPRecolorsPro.XM84Rolled'
     aimerror=600.000000
}
