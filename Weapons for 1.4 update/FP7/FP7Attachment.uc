//=============================================================================
// 3rd person weapon class for the FP7 Grenade
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class FP7Attachment extends BallisticGrenadeAttachment;

defaultproperties
{
     ExplodeManager=Class'BallisticProV55.IM_Grenade'
     GrenadeSmokeClass=Class'BallisticProV55.NRP57Trail'
     Mesh=SkeletalMesh'BallisticAnims1.FP7_TP'
     DrawScale=0.250000
	 Skins(0)=Texture'BallisticWeapons1.FP7.FP7Grenade'
}
