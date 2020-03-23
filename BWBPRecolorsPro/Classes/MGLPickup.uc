//=============================================================================
// Pickup class for MGL Grenade Launcher
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Edited by (NL)NOOTLORD
//=============================================================================
class MGLPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticRecolorsTex.utx
#exec OBJ LOAD FILE=BallisticRecolorsStatic.usx

//Fixed by (NL)NOOTLORD
//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticRecolorsTex.MGL.MGL-Main');
	L.AddPrecacheMaterial(Texture'BallisticRecolorsTex.MGL.MGL-Holosight');
	L.AddPrecacheMaterial(Texture'BallisticRecolorsTex.MGL.MGL-Screen');
	L.AddPrecacheMaterial(Texture'BallisticRecolorsTex.MGL.MGL-ScreenBase');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolorsTex.MGL.MGL-Main');
	Level.AddPrecacheMaterial(Texture'BallisticRecolorsTex.MGL.MGL-Holosight');
	Level.AddPrecacheMaterial(Texture'BallisticRecolorsTex.MGL.MGL-Screen');
	Level.AddPrecacheMaterial(Texture'BallisticRecolorsTex.MGL.MGL-ScreenBase');
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolorsStatic.MGL.MGLPickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolorsStatic.MGL.MGLPickupLow');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolorsStatic.MGL.MGLPickupLow'
     InventoryType=Class'BWBPRecolorsPro.MGLauncher'
     RespawnTime=5.000000
     PickupMessage="You picked up the Conqueror multiple grenade launcher."
     PickupSound=Sound'BallisticSounds2.M763.M763Putaway'
     StaticMesh=StaticMesh'BallisticRecolorsStatic.MGL.MGLPickup'
     Physics=PHYS_None
     DrawScale=0.900000
     CollisionHeight=3.000000
}
