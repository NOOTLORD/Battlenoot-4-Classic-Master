//=============================================================================
// Mut_SpatialLoadoutDM.
//
// The internal ballistic deathmatch subclass of the Ballistic Conflict Loadout mutator.
// This is added to the game by the GameInfo and is not available in mutator lists.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Mut_SpatialLoadoutDM extends Mut_SpatialLoadout
	HideDropDown
	CacheExempt;

function bool MutatorIsAllowed()
{
	return true;
}

defaultproperties
{
     DMMode=True
     FriendlyName="BallisticPro: Conflict Loadout - Internal"
}
