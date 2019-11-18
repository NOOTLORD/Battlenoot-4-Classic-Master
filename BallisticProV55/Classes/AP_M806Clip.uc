//=============================================================================
// AP_M806Clip.
//
// Clips for the M806A2.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_M806Clip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=24
     InventoryType=Class'BallisticProV55.Ammo_45HV'
     PickupMessage="You picked up .45 high velocity M806 bullets."
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BallisticHardware2.Ammo.M806Clip'
     DrawScale=0.300000
     CollisionRadius=8.000000
     CollisionHeight=16.000000
}
