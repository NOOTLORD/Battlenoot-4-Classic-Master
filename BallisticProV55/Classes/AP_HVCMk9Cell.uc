//=============================================================================
// AP_HVCMk9Cell
//
// Favorite ammo pickup of the HVC-Mk9 Lightning Gun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_HVCMk9Cell extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=125
     InventoryType=Class'BallisticProV55.Ammo_HVCCells'
     PickupMessage="You got an HVC Mk9 Lightning Cell"
     PickupSound=Sound'BWBP2-Sounds.LightningGun.LG-AmmoPickup'
     StaticMesh=StaticMesh'BWBP2Hardware.LightningGun.LighterAmmo'
     DrawScale=0.250000
     CollisionRadius=8.000000
     CollisionHeight=4.800000
}
