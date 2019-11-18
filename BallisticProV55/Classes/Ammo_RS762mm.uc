//=============================================================================
// Ammo_RS762mm.
//
// 7.62mm bullet ammo. Used by SRS900 Battle Rifle.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_RS762mm extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=120
     InitialAmount=60
     bTryHeadShot=True
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIcon_SRSFlash'
     PickupClass=Class'BallisticProV55.AP_SRS900Clip'
     IconMaterial=Texture'BWBP3-Tex.SRS900.AmmoIcon_SRSClips'
     IconCoords=(X1=128,X2=191,Y2=63)
     ItemName=".308 Rifle Rounds"
}
