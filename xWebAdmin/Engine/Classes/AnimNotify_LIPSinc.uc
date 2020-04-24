
// ifdef WITH_LIPSinc

class AnimNotify_LIPSinc extends AnimNotify
	native;

var() name  LIPSincAnimName;
var() float Volume;
var() int   Radius;
var() float Pitch;

cpptext
{
	// AnimNotify interface.
	virtual void Notify( UMeshInstance *Instance, AActor *Owner );
}

// endif

defaultproperties
{
     Volume=1.000000
     Radius=80
     Pitch=1.000000
}