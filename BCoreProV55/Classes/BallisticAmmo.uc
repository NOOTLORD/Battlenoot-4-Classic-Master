//=============================================================================
// BallisticAmmo.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticAmmo extends Ammunition;

var bool bNoPackResupply;

static function int GetKillResupplyAmmo()
{
	return default.InitialAmount/3;
}

function bool AddAmmo(int AmmoToAdd)
{
	return super.AddAmmo(AmmoToAdd);
}

defaultproperties
{
     MaxAmmo=180
     InitialAmount=30
     PickupClass=Class'BCoreProV55.BallisticAmmoPickup'
     ItemName="Ballistic Ammo"
}
