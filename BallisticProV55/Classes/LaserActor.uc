//=============================================================================
// LaserActor.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class LaserActor extends Actor;

defaultproperties
{
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'BallisticProStatic.Effects.LaserHex'
     bHidden=True
     bAcceptsProjectors=False
     RemoteRole=ROLE_None
     bUnlit=True
     bHardAttach=True
}
