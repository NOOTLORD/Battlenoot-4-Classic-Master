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
var() Config bool		bNoDodging;			// Disables dodging.
var() Config bool		bLimitDoubleJumps;	// Limits double jumps so you can only do a few before having to wait for them to recharge.
var() Config float		WalkingPercentage;   // Let players configure the walking movespeed percentage.
var() Config float		CrouchingPercentage; // Let players configure the crouching movespeed percentage.
// ----------------------------------------------------------------------------
var struct RepInfo_BW
{
	var bool		bNoDodging;
	var bool		bLimitDoubleJumps;
	var float	WalkingPercentage;
	var float	CrouchingPercentage;
}BWRep;

replication
{
	reliable if (Role == ROLE_Authority && bNetInitial)
		BWRep;
}

//Set all defaults to match server vars here
simulated function InitClientVars()
{
	bNoDodging			= BWRep.bNoDodging;
	bLimitDoubleJumps	= BWRep.bLimitDoubleJumps;
	WalkingPercentage	= BWRep.WalkingPercentage;
	CrouchingPercentage = BWRep.CrouchingPercentage;

	class.default.bNoDodging		= bNoDodging;
	class.default.bLimitDoubleJumps	= bLimitDoubleJumps;
	class.default.WalkingPercentage	= WalkingPercentage;
	class.default.CrouchingPercentage = CrouchingPercentage;
	super.InitClientVars();
	
	Log("bNoDodging: "$bNoDodging);
	Log("bLimitDoubleJumps: "$bLimitDoubleJumps);
	log("Walking percentage: "$WalkingPercentage * 100$"%");
	log("Crouching percentage:"$CrouchingPercentage*100$"%");
}

function ServerInitialize()
{
	BWRep.bNoDodging		= bNoDodging;
	BWRep.bLimitDoubleJumps	= bLimitDoubleJumps;
    BWRep.WalkingPercentage = WalkingPercentage;
    BWRep.CrouchingPercentage = CrouchingPercentage;

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
     bNoDodging=True
     bLimitDoubleJumps=False
     WalkingPercentage=1.000000
     CrouchingPercentage=0.500000
     ModString="Ballistic Weapons Pro v2.5"
}
