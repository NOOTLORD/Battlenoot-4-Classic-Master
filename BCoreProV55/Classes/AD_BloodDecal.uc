//=============================================================================
// AD_BloodDecal.
//
// Gore Decal used by Ballistic and related stuff
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AD_BloodDecal extends BallisticDecal
	config(BallisticProV55);

var() Globalconfig float	StayScale;		// Scales the life time of blood decals. 0 = Forever...

event PostBeginPlay()
{
	if (StayScale >= 0)
		StayTime *= StayScale;
    Super.PostBeginPlay();
}

function StopExpanding ()
{
	bExpandingDecal = False;
    AbandonProjector(StayTime*Level.DecalStayScale);
	Destroy();
}

defaultproperties
{
     StayScale=0.100000
     bProjectBSP=False
     bProjectTerrain=False
     bProjectStaticMesh=False
     bProjectParticles=False
     bProjectActor=False
     bProjectOnAlpha=False
     bSelected=True
}
