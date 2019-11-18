//=============================================================================
// AP_6Magnum.
//
// 12 .44 magnum rounds.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_6Magnum extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=12
     InventoryType=Class'BallisticProV55.Ammo_44Magnum'
     PickupMessage="You picked up 12 .44 rounds."
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BallisticHardware2.D49.D49AmmoBox'
     DrawScale=0.250000
     PrePivot=(Z=70.000000)
     CollisionRadius=8.000000
     CollisionHeight=16.000000
}
