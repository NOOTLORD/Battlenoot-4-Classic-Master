//=============================================================================
// BallisticStump.
//
// An stump actor attached to corpses where limbs have been severed
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticStump extends Effects;

defaultproperties
{
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'BallisticProStatic.Stumps.Limb-Stump1'
     AmbientGlow=5
     bUnlit=False
     bHardAttach=True
}
