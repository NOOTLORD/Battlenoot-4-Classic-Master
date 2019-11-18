//=============================================================================
// Ammo_16GuageleMat.
//
// 16 Guage shotgun ammo. Used by Wilson DB revolver.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_CYLOSG extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=24
     InitialAmount=6
     IconFlashMaterial=Shader'BWBP4-Tex.leMat.AmmoIcon_Wilson41DBFlash'
     PickupClass=Class'BWBPRecolorsPro.AP_CYLOSG'
     IconMaterial=Texture'BWBP4-Tex.leMat.AmmoIcon_Wilson41DB'
     IconCoords=(X2=63,Y2=63)
     ItemName="16 Gauge Magnum Shells"
}
