//=============================================================================
// BallisticMod.
//
// FIXME.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class BallisticMod extends Info
	exportstructs
	config(BallisticProV55);

enum ELLHDetailMode
{
	DM_SuperLow,
	DM_Low,
	DM_High
};

var() ELLHDetailMode	EffectsDetailMode;
var() bool				bEjectBrass;
var() bool				bMuzzleSmoke;
var() bool				bBulletFlybys;
var() bool	            bUseMotionBlur;

var   BallisticMod					BallisticMod;

static function InitializeMod()
{
	log("Ballistic Core: Initialized Mod: FIXME");
}

static function BallisticMod Get(actor a)
{
	local BallisticMod BM;

	if (default.BallisticMod != None)
		return default.BallisticMod;
	foreach A.AllActors(class'BallisticMod', BM)
		if (BM != None)
		{
			default.BallisticMod = BM;
			return default.BallisticMod;
		}
	return None;
}

defaultproperties
{
     EffectsDetailMode=DM_High
     bEjectBrass=True
     bMuzzleSmoke=False
     bBulletFlybys=True
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
}
