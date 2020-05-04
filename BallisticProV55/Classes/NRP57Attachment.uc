//=============================================================================
// 3rd person weapon class for NRP57 Grenade
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class NRP57Attachment extends BallisticGrenadeAttachment;

defaultproperties
{
     ExplodeManager=Class'BallisticProV55.IM_NRP57Grenade'
     GrenadeSmokeClass=Class'BallisticProV55.NRP57Trail'
     Mesh=SkeletalMesh'BallisticAnims2.NRP57_TP'
     DrawScale=0.100000
	 Skins(0)=Texture'BallisticWeapons2.NRP57.Grenade'
}
