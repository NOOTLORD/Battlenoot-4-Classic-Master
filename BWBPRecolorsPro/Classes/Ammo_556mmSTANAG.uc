//=============================================================================
// Ammo_556mmSTANAG.
//
// 5.56mm bullet ammo. Shorter length round used in STANAG mags.
// Used by the MJ51, MARS-2, JSOC, MG33, and HKAR
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_556mmSTANAG extends BallisticAmmo;

defaultproperties
{
     InitialAmount=90
     IconFlashMaterial=Shader'BallisticRecolors4TexPro.M4A1.AmmoIcon_556Flash'
     PickupClass=Class'BWBPRecolorsPro.AP_STANAG'
     IconMaterial=Texture'BallisticRecolors4TexPro.M4A1.AmmoIcon_556'
     IconCoords=(X2=64,Y2=64)
     ItemName="5.56mm CAP Ammo"
}
