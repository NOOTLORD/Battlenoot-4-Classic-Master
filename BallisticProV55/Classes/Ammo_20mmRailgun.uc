//=============================================================================
// Ammo_20mmRailgun.
//
// 20mm Railgun rounds.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_20mmRailgun extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=30
     InitialAmount=15
     bTryHeadShot=True
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIconsFlashing'
     PickupClass=Class'BallisticProV55.AP_M75Clip'
     IconMaterial=Texture'BallisticUI2.Icons.AmmoIconPage'
     IconCoords=(X1=192,X2=255,Y2=63)
     ItemName="20mm Railgun Rounds"
}
