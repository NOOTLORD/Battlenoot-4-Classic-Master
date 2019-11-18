//=============================================================================
// M58Pickup.
//=============================================================================
class M58Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticProTextures.utx
#exec OBJ LOAD FILE=BallisticProStatic.usx
#exec OBJ LOAD FILE=BallisticHardware2.usx

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticProTextures.M58.M58GrenadeSkin');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.T10.T10Clip');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticProStatic.M58.M58Projectile');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.T10.T10Pickup');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BallisticHardware2.T10.T10Pickup'
     PickupDrawScale=0.350000
     bWeaponStay=False
     InventoryType=Class'BallisticProV55.M58Grenade'
     RespawnTime=20.000000
     PickupMessage="You picked up the M58 smoke grenade."
     PickupSound=Sound'BallisticSounds2.Ammo.GrenadePickup'
     StaticMesh=StaticMesh'BallisticHardware2.T10.T10Pickup'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.700000
     CollisionHeight=5.600000
}
