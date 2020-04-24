class MutBWInteractions extends xMutator 
	transient;

simulated function ClientSideInitialization(PlayerController PC)
{
	AddAnInteraction(PC, string( class'BallisticProInteractions' ));
}

defaultproperties
{
     FriendlyName="Ballistic Binds Menu"
     Description="Adds bind support to Ballistic."
}
