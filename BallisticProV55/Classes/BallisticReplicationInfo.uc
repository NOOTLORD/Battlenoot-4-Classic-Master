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
//
// Modified by (NL)NOOTLORD
//=============================================================================
class BallisticReplicationInfo extends BCReplicationInfo config(BallisticProV55);

// Server Variables -----------------------------------------------------------
// Pawn
var() Config bool		bNoDodging;			// Disables dodging.
var() Config bool		bLimitDoubleJumps;	// Limits double jumps so you can only do a few before having to wait for them to recharge.
var() Config float		ScopedWalkingPercentage;   // Let players configure the walking movespeed when scoped.
var() Config float		CrouchingPercentage; // Let players configure the crouching movespeed when scoped.
// ----------------------------------------------------------------------------
var struct RepInfo_BW
{
	var bool		bNoDodging;
	var bool		bLimitDoubleJumps;
	var float	    ScopedWalkingPercentage;
	var float	    CrouchingPercentage;
}BWRep;

replication
{
	reliable if (Role == ROLE_Authority && bNetInitial)
		BWRep;
}

//Set all defaults to match server vars here
simulated function InitClientVars()
{
	bNoDodging			    = BWRep.bNoDodging;
	bLimitDoubleJumps	    = BWRep.bLimitDoubleJumps;
	ScopedWalkingPercentage	= BWRep.ScopedWalkingPercentage;
	CrouchingPercentage     = BWRep.CrouchingPercentage;
 
	class.default.bNoDodging		      = bNoDodging;
	class.default.bLimitDoubleJumps       = bLimitDoubleJumps;
	class.default.ScopedWalkingPercentage = ScopedWalkingPercentage;
	class.default.CrouchingPercentage     = CrouchingPercentage;
	super.InitClientVars();
	
	Log("bNoDodging: "$bNoDodging);
	Log("bLimitDoubleJumps: "$bLimitDoubleJumps);
	log("Scoped Walking percentage: "$ScopedWalkingPercentage * 100$"%");
	log("Crouching percentage:"$CrouchingPercentage*100$"%");
}

function ServerInitialize()
{
	BWRep.bNoDodging		= bNoDodging;
	BWRep.bLimitDoubleJumps	= bLimitDoubleJumps;
    BWRep.ScopedWalkingPercentage = ScopedWalkingPercentage;
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
     ScopedWalkingPercentage=0.800000
     CrouchingPercentage=0.500000
     ModString="Ballistic Weapons Pro v2.5"
}
