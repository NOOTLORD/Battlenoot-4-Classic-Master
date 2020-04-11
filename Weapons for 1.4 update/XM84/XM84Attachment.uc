//=============================================================================
// XM84Attachment.
//
// 3rd person weapon attachment for XM84 Grenade.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class XM84Attachment extends BallisticGrenadeAttachment;

defaultproperties
{
     ExplodeManager=Class'BWBPRecolorsPro.IM_XM84Grenade'
     GrenadeSmokeClass=Class'BWBPRecolorsPro.XM84Trail'
     Mesh=SkeletalMesh'BallisticRecolorsAnims.XM84_3rd'
     DrawScale=0.500000
}
