//=============================================================================
// Pickup class for the MGL Launcher
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Edited by (NL)NOOTLORD
//=============================================================================
class MGLPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticProEffectsTex.utx
#exec OBJ LOAD FILE=BallisticProRecolorsTex.utx
#exec OBJ LOAD FILE=BallisticProRecolorsStatic.usx

//Fixed by (NL)NOOTLORD
//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticProRecolorsTex.MGL.MGL-Main');
	L.AddPrecacheMaterial(Texture'BallisticProRecolorsTex.MGL.MGL-ScreenBase');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticProRecolorsTex.MGL.MGL-Main');
	Level.AddPrecacheMaterial(Texture'BallisticProRecolorsTex.MGL.MGL-ScreenBase');
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticProRecolorsStatic.MGL.MGLPickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticProRecolorsStatic.MGL.MGLPickupLow');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticProRecolorsStatic.MGL.MGLPickupLow'
     InventoryType=Class'BallisticProV55Recolors.MGLLauncher'
     RespawnTime=5.000000
     PickupMessage="You picked up the Conqueror multiple grenade launcher."
     PickupSound=Sound'BallisticProSounds.M763.M763-Putaway'
     StaticMesh=StaticMesh'BallisticProRecolorsStatic.MGL.MGLPickup'
     Physics=PHYS_None
     DrawScale=0.900000
     CollisionHeight=3.000000
}
