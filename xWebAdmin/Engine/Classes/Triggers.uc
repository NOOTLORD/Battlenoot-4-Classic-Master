//=============================================================================
// Event.
//=============================================================================
class Triggers extends Actor
	abstract
	placeable
	native;

cpptext
{
	virtual UBOOL ReachedBy(APawn * P, FVector Loc);
}

defaultproperties
{
     bHidden=True
     RemoteRole=ROLE_None
     CollisionRadius=40.000000
     CollisionHeight=40.000000
     bCollideActors=True
}
