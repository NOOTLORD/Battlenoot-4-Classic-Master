//=============================================================================
// AP_LAWTBEEBEB
//
// 1 LAW tube
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_LAWTube extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=1
     InventoryType=Class'BWBPRecolorsPro.Ammo_LAW'
     PickupMessage="You picked up 1 LAW T70B1 rocket"
     PickupSound=Sound'BallisticSounds2.Ammo.RocketPickup'
     StaticMesh=StaticMesh'BallisticRecolors4StaticProExp.LAW.LAWAmmo'
     DrawScale=0.750000
     CollisionRadius=8.000000
     CollisionHeight=5.000000
}
