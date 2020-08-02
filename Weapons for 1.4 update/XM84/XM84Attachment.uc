//=============================================================================
// 3rd person weapon class for the XM84 Grenade.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class XM84Attachment extends BallisticGrenadeAttachment;

defaultproperties
{
     ExplodeManager=Class'BWBPRecolorsPro.IM_XM84Grenade'
     GrenadeSmokeClass=Class'BWBPRecolorsPro.XM84Trail'
     Mesh=SkeletalMesh'BallisticRecolorsAnims.XM84_TP'
     DrawScale=0.500000
	 Skins(0)=Shader'BallisticRecolorsTex.XM84.XM84-Glow2'
	 Skins(1)=Shader'BallisticRecolorsTex.XM84.XM84-Glow2'
}
