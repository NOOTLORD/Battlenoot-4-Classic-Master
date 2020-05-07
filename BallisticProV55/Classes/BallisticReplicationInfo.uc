//=============================================================================
// BallisticReplicationInfo.
//
// Special global replication actor for transmitting server-side globals to all
// clients.
// This is spawned at the beginning of the match by mutator, then it is
// replicated to all clients. Client then copies the values of all the varibles
// to its defaults. After that, all actors client side can see what the server
// has set by reading the defaults of this class.
//
// Extension for Ballistic package variables. Ballistic uses this class instead
// of the BCore base class for its server-side vars.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticReplicationInfo extends BCReplicationInfo config(BallisticProV55);

// Server Variables -----------------------------------------------------------
// Pawn
var() Config bool		bBrightPlayers;		// Players have ambient glow to glow in the dark like the standard pawns.
var() Config bool		bNoDodging;			// Disables dodging.
var() Config bool		bLimitDoubleJumps;	// Limits double jumps so you can only do a few before having to wait for them to recharge.
var() Config float		WalkingPercentage;   // Let players configure the walking movespeed percentage.
var() Config float		CrouchingPercentage; // Let players configure the crouching movespeed percentage.
var() Config bool 		bUseRunningAnims; // Pawns will use running anims for walking.
var() Config bool		bUniversalMineLights; // All BX-5 mines are lit.
// ----------------------------------------------------------------------------
var struct RepInfo_BW
{
	var bool		bBrightPlayers;
	var bool		bNoDodging;
	var bool		bLimitDoubleJumps;
	var float	WalkingPercentage;
	var float	CrouchingPercentage;
	var bool		bUseRunningAnims;
}BWRep;

replication
{
	reliable if (Role == ROLE_Authority && bNetInitial)
		BWRep;
}

//Set all defaults to match server vars here
simulated function InitClientVars()
{
	local BallisticPawn P;

	bBrightPlayers		= BWRep.bBrightPlayers;
	bNoDodging			= BWRep.bNoDodging;
	bLimitDoubleJumps	= BWRep.bLimitDoubleJumps;
	WalkingPercentage	= BWRep.WalkingPercentage;
	CrouchingPercentage = BWRep.CrouchingPercentage;
	bUseRunningAnims = BWRep.bUseRunningAnims;

	class.default.bBrightPlayers	= bBrightPlayers;
	class.default.bNoDodging		= bNoDodging;
	class.default.bLimitDoubleJumps	= bLimitDoubleJumps;
	class.default.WalkingPercentage	= WalkingPercentage;
	class.default.CrouchingPercentage = CrouchingPercentage;
	class.default.bUseRunningAnims = bUseRunningAnims;
	super.InitClientVars();

	Log("bBrightPlayers: "$bBrightPlayers);
	Log("bNoDodging: "$bNoDodging);
	Log("bLimitDoubleJumps: "$bLimitDoubleJumps);
	log("Walking percentage: "$WalkingPercentage * 100$"%");
	log("Crouching percentage:"$CrouchingPercentage*100$"%");

	if (Role < ROLE_Authority && bBrightPlayers)
	{
		foreach DynamicActors ( class'BallisticPawn', P )
		{
			P.bDramaticLighting = class'BallisticPawn'.default.bDramaticLighting;
			P.AmbientGlow = class'BallisticPawn'.default.AmbientGlow;
		}
	}
}

function ServerInitialize()
{
	BWRep.bBrightPlayers	= bBrightPlayers;
	BWRep.bNoDodging		= bNoDodging;
	BWRep.bLimitDoubleJumps	= bLimitDoubleJumps;
    BWRep.WalkingPercentage = WalkingPercentage;
    BWRep.CrouchingPercentage = CrouchingPercentage;
	BWRep.bUseRunningAnims = bUseRunningAnims;

	super.ServerInitialize();
}

static function BCReplicationInfo GetBRep(actor A)
{
	local BallisticReplicationInfo BRI;

	foreach A.DynamicActors(class'BallisticReplicationInfo', BRI)
	{
		if (A != None)
			return BRI;
	}
	return None;
}

defaultproperties
{
     bBrightPlayers=False
     bNoDodging=True
     bLimitDoubleJumps=False
     WalkingPercentage=1.000000
     CrouchingPercentage=0.500000
     bUseRunningAnims=False
     ModString="Ballistic Weapons v2.5"
}
