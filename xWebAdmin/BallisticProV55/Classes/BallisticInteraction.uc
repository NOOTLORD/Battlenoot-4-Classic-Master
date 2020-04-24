//=============================================================================
// BallisticInteraction.
//
// Interaction used by BW to draw splash screen
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class BallisticInteraction extends Interaction;

var PlayerController PC;

var BallisticPlayerReplicationInfo BPRI;

static function BallisticInteraction Launch (PlayerController ThePC)
{
	local int i;
	local BallisticInteraction NI;

	log ("Launching BallisticInteraction...");

	for(i=0;i<ThePC.Player.LocalInteractions.length;i++)
		if (ThePC.Player.LocalInteractions[i].Class == class'BallisticInteraction')
			return BallisticInteraction(ThePC.Player.LocalInteractions[i]);
	NI = BallisticInteraction(ThePC.Player.InteractionMaster.AddInteraction("BallisticProV55.BallisticInteraction", ThePC.Player));
	return NI;
}

event NotifyLevelChange()
{
	PC = None;
	Master.RemoveInteraction(self);
}

defaultproperties
{
}
