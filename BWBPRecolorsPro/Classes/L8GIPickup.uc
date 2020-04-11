//=============================================================================
// FP7Pickup.
//=============================================================================
class L8GIPickup extends BallisticWeaponPickup
	placeable;
/*
#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx
*/

simulated function UpdatePrecacheMaterials()
{

}

simulated function UpdatePrecacheStaticMeshes()
{

}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BallisticHardware1.Ammo.AmmoPackLo'
     PickupDrawScale=0.350000
     bWeaponStay=False
     InventoryType=Class'BWBPRecolorsPro.L8GIAmmoPack'
     RespawnTime=20.000000
     PickupMessage="You picked up the L8 GI Ammunition Pack"
     PickupSound=Sound'BallisticSounds2.Ammo.AmmoPackPickup'
     StaticMesh=StaticMesh'BallisticHardware1.Ammo.AmmoPackHi'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.350000
     Skins(0)=Texture'BallisticRecolorsTex.AmmoPack.L8GISkin'
     CollisionRadius=16.000000
     CollisionHeight=15.000000
}
