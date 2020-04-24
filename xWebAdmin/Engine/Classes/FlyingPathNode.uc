//=============================================================================
// FlyingPathNode
// Useful for flying or swimming
//=============================================================================

#exec Texture Import File=Textures\FlyingApple.tga Name=S_FlyingPath Mips=Off MASKED=1

class FlyingPathNode extends PathNode
	native;

cpptext
{
	INT ProscribedPathTo(ANavigationPoint *Nav);
	virtual UBOOL ReachedBy( APawn * P, FVector Loc );
	virtual UBOOL NoReachDistance();
	virtual UBOOL BigAnchor(APawn * P, FVector Loc);
	virtual void addReachSpecs(APawn * Scout, UBOOL bOnlyChanged);
	virtual UBOOL ShouldBeBased();
	virtual void InitForPathFinding();
	UBOOL ReviewPath(APawn* Scout);
}

defaultproperties
{
     bNoAutoConnect=True
     bFlyingPreferred=True
     bVehicleDestination=True
     Texture=Texture'Engine.S_FlyingPath'
     DrawScale=0.400000
}
