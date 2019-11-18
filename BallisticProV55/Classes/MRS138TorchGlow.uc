//===========================================================================
// MRS138's Torch glow.
//
// Modified SquirrelZero light
//===========================================================================
class MRS138TorchGlow extends Light
	notplaceable;

function PostBeginPlay()
{
	SetTimer(1.0,true);
}

function Timer()
{
	MakeNoise(0.3);
}

defaultproperties
{
     MaxCoronaSize=0.000000
     LightBrightness=0.000000
     LightRadius=1.000000
     LightPeriod=0
     LightCone=0
     bLightingVisibility=False
     bStatic=False
     bHidden=False
     bNoDelete=False
     RemoteRole=ROLE_None
     Texture=None
     DrawScale=0.000000
     DrawScale3D=(X=0.000000,Y=0.000000,Z=0.000000)
     bGameRelevant=True
     bMovable=True
     CollisionRadius=5.000000
     CollisionHeight=5.000000
     bDirectional=True
     bSelected=True
}
