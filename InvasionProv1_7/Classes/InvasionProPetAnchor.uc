class InvasionProPetAnchor extends Actor;

event Landed ( vector HitNormal )
{
	SetPhysics(PHYS_None);
}

defaultproperties
{
     bHidden=True
     CollisionRadius=10.000000
     CollisionHeight=10.000000
     bCollideWorld=True
     Mass=2000.000000
}
