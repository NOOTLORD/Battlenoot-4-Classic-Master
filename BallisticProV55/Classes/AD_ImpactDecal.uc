//=============================================================================
// AD_ImpactDecal
//=============================================================================
class AD_ImpactDecal extends BallisticDecal
	placeable
	config(BallisticProV55);

var() Globalconfig bool		bPermanentImpacts;	// This decal will stay forever...

event PostBeginPlay()
{
	if (bWaitForInit)
		return;
	if (bPermanentImpacts)
		StayTime = 0.0;	// Forever...
    Super.PostBeginPlay();
}

defaultproperties
{
     bRandomRotate=True
     StayTime=1.500000
     FOV=1
     MaxTraceDistance=60
     bProjectParticles=False
     bProjectActor=False
     bClipBSP=True
     bClipStaticMesh=True
     bProjectOnUnlit=True
     bStatic=False
     LifeSpan=1.500000
     DrawScale=0.250000
     bGameRelevant=True
}
