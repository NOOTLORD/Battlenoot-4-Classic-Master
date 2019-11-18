//=============================================================================
// MRS138ViewMesser.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class MRS138ViewMesser extends Actor config(BallisticProV55);

var PlayerController 	PC;

replication
{
	unreliable if (Role == ROLE_Authority)
		AddImpulse;
}

simulated function PostNetBeginPlay()
{
	PC = level.GetLocalPlayerController();
	if (Owner != None && PlayerController(Owner) != None)
		PC = PlayerController(Owner);
	if (Role == ROLE_Authority && PC == None)
		Destroy();
}

simulated function AddImpulse()
{
	if (PC == None || xPawn(PC.Pawn) == None)
		return;

	class'BC_MotionBlurActor'.static.DoMotionBlur(PC, 3.0, 15);
}

defaultproperties
{
     bHidden=True
     bOnlyRelevantToOwner=True
     bReplicateMovement=False
     bSkipActorPropertyReplication=True
     RemoteRole=ROLE_SimulatedProxy
     bSelected=True
}
