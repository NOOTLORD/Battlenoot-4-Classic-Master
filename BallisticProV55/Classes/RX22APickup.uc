//=============================================================================
// RX22APickup.
//=============================================================================
class RX22APickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx

function SetWeaponStay()
{
	bWeaponStay = false;
}

function float GetRespawnTime()
{
	return RespawnTime;
}

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.RX22A.RX22AShield');
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.RX22A.RX22ASign');
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.RX22A.RX22ATank');
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.RX22A.RX22ASkin');
	
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.RX22A.FlamerCanHeater');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.RX22A.FlamerTank');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.RX22A.RX22AShield');
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.RX22A.RX22ASign');
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.RX22A.RX22ATank');
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.RX22A.RX22ASkin');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.RX22A.FlamerPickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.RX22A.FlamerPickupLD');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.RX22A.FlamerCanHeater');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.RX22A.FlamerTank');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BallisticHardware2.RX22A.FlamerPickupLD'
     PickupDrawScale=0.350000
     InventoryType=Class'BallisticProV55.RX22AFlamer'
     RespawnTime=60.000000
     PickupMessage="You picked up the RX-22A flamethrower."
     PickupSound=Sound'BallisticSounds2.RX22A.RX22A-Putaway'
     StaticMesh=StaticMesh'BallisticHardware2.RX22A.FlamerPickup'
     Physics=PHYS_None
     DrawScale=0.350000
     CollisionHeight=5.000000
}
