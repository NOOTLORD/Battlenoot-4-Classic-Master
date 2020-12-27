//=============================================================================
// 3rd person weapon class for the NRP57 Grenade
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
     Mesh=SkeletalMesh'BallisticProAnims.NRP57_TP'
     DrawScale=0.100000
	 Skins(0)=Texture'BallisticProTex.NRP57.NRP57-Main'
}
